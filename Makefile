.PHONY: all
all: dotfiles bin

.PHONY: docker
docker:
	docker build -t docker_dotfile_test .

.PHONY: dotfiles
dotfiles: set_local_dotfiles link_dotfiles_to_home

.PHONY: link_dotfiles_to_home
link_dotfiles_to_home:
	for file in $(shell find $(CURDIR) -maxdepth 1 -mindepth 1 -name "*" -not -name ".gitignore" -not -name ".git*" -not -name "*README*" -not -name "*NO_DOT*" -not -name "bin" -not -name "util" -not -name "lib" -not -name "local" -not -name "Makefile" -not -name "Dockerfile"); do \
		f=$$(basename $$file); \
		rm -f $(HOME)/$$f; \
		ln -sfn $$file $(HOME)/.$$f; \
	done;
	cp -R local/$(target_env) .

.PHONY: list_dotfiles
list_dotfiles:
	for file in $(shell find $(CURDIR) -maxdepth 1 -mindepth 1 -name "*" -not -name ".gitignore" -not -name ".git*" -not -name "*README*" -not -name "*NO_DOT*" -not -name "bin" -not -name "util" -not -name "lib" -not -name "local" -not -name "Makefile" -not -name "Dockerfile"); do \
		f=$$(basename $$file); \
		echo $$file;\
	done;

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
	cp -R bin $(HOME)/bin
	for file in $(shell find $(CURDIR)/bin -maxdepth 1 -mindepth 1 -name "*"); do \
		f=$$(basename $$file); \
		rm -f $(HOME)/bin/$$f; \
		ln -sfn $$file $(HOME)/bin/$$f; \
	done
