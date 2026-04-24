.PHONY: all
all: dotfiles bin

.PHONY: docker
docker:
	docker build -t docker_dotfile_test .

.PHONY: dotfiles
dotfiles: set_local_dotfiles link_dotfiles_to_home link_config_to_home link_claude_to_home

# Items excluded from the top-level dotfile sweep:
#   .git*, *README*, NO_DOT*, Makefile, Dockerfile  : repo support, not dotfiles
#   bin, util, lib, local                           : handled separately or
#                                                     not user-facing
#   install                                         : install scripts (being
#                                                     replaced by Ansible)
#   config                                          : symlinked per-subdir
#                                                     into an existing
#                                                     ~/.config/ rather than
#                                                     clobbering the dir
#   claude                                          : ~/.claude/ is
#                                                     app-managed state;
#                                                     individual files are
#                                                     linked explicitly
#   git_commit_template.txt                         : no leading-dot rename;
#                                                     linked explicitly
FIND_DOTFILES = find $(CURDIR) -maxdepth 1 -mindepth 1 \
	-not -name ".git*" -not -name ".dockerignore" \
	-not -name "*README*" -not -name "*NO_DOT*" \
	-not -name "bin" -not -name "util" -not -name "lib" -not -name "local" \
	-not -name "install" -not -name "config" -not -name "claude" \
	-not -name "Makefile" -not -name "Dockerfile" \
	-not -name "git_commit_template.txt"

# Safe symlink: remove destination if it is a file or an existing symlink;
# refuse to proceed if it is a real directory (prevents clobbering ~/.config
# and similar). Use with shell.
define safe_link
	if [ -L "$(2)" ] || [ -f "$(2)" ]; then rm -f "$(2)"; fi; \
	if [ -d "$(2)" ] && [ ! -L "$(2)" ]; then \
		echo "SKIP: $(2) is a real directory; remove or merge manually, then re-run"; \
	else \
		ln -sfn "$(1)" "$(2)"; \
	fi
endef

.PHONY: link_dotfiles_to_home
link_dotfiles_to_home:
	for file in $(shell $(FIND_DOTFILES)); do \
		f=$$(basename $$file); \
		$(call safe_link,$$file,$(HOME)/.$$f); \
	done
	$(call safe_link,$(CURDIR)/git_commit_template.txt,$(HOME)/.git_commit_template.txt)

.PHONY: link_config_to_home
link_config_to_home:
	mkdir -p $(HOME)/.config
	for dir in $(shell find $(CURDIR)/config -maxdepth 1 -mindepth 1 -type d); do \
		d=$$(basename $$dir); \
		$(call safe_link,$$dir,$(HOME)/.config/$$d); \
	done

.PHONY: link_claude_to_home
link_claude_to_home:
	mkdir -p $(HOME)/.claude
	$(call safe_link,$(CURDIR)/claude/settings.json,$(HOME)/.claude/settings.json)

.PHONY: list_dotfiles
list_dotfiles:
	@for file in $(shell $(FIND_DOTFILES)); do \
		f=$$(basename $$file); \
		echo "$$file -> $(HOME)/.$$f"; \
	done
	@echo "$(CURDIR)/git_commit_template.txt -> $(HOME)/.git_commit_template.txt"
	@for dir in $(shell find $(CURDIR)/config -maxdepth 1 -mindepth 1 -type d); do \
		d=$$(basename $$dir); \
		echo "$$dir -> $(HOME)/.config/$$d"; \
	done
	@echo "$(CURDIR)/claude/settings.json -> $(HOME)/.claude/settings.json"

.PHONY: set_local_dotfiles
set_local_dotfiles:
ifndef target_env
	$(error target_env not specified: "make target_env=home_macos set_local_dotfiles")
else
	for file in $(shell find $(CURDIR)/local/$(target_env) -maxdepth 1 -mindepth 1 -name "*" -not -name "*README*" -not -name "*NO_DOT*"); do \
		f=$$(basename $$file); \
		rm -f $(CURDIR)/$$f; \
		ln -sfn $$file $(CURDIR)/$$f; \
	done
endif

.PHONY: bin
bin:
	mkdir -p $(HOME)/bin
	for file in $(shell find $(CURDIR)/bin -maxdepth 1 -mindepth 1); do \
		f=$$(basename $$file); \
		$(call safe_link,$$file,$(HOME)/bin/$$f); \
	done
