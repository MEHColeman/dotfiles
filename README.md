# Mark's Dotfiles

Configuration files only. Package installation and first-time machine
bootstrap are handled by a separate **Ansible** project, which also drives
the deployment of this repo. The `Makefile` here is a manual fallback when
Ansible isn't available (e.g. bootstrapping a fresh box before Ansible is
installed).

## Layout

```
.dotfiles/
├── <dotfile>               # top-level files → ~/.<dotfile>
│                             (zshrc, bashrc, vimrc, gitconfig, tmux.conf, …)
├── config/                 # XDG configs → ~/.config/<name>/
│   ├── alacritty/
│   ├── hypr/
│   ├── nvim/
│   └── …
├── claude/                 # Claude Code — only specific files are
│   ├── settings.json       #   symlinked into ~/.claude/ (the rest of that
│   └── .gitignore          #   directory is app-managed state)
├── oh-my-zsh_custom/       # → ~/.oh-my-zsh_custom/  (custom plugins + themes)
├── vim/                    # → ~/.vim/
├── fonts/                  # → ~/.fonts/
├── bin/                    # → ~/bin/<script> (one symlink per script)
├── local/<target_env>/     # per-machine overrides, copied in as
│   ├── generic_ubuntu/     #   sibling .local files via `set_local_dotfiles`
│   └── home_macos/
├── install/                # DEPRECATED — superseded by Ansible, kept as reference
├── docs/                   # Obsidian-compatible wiki — per-tool guides + cheatsheets
├── Makefile                # manual deploy fallback
└── README.md
```

See [`docs/index.md`](docs/index.md) for per-tool explanations and
shortcut cheatsheets (neovim plugins, tmux bindings, git aliases,
Claude Code, etc.).

## Deploying (manual fallback)

Normally Ansible does this. To deploy manually:

```sh
make target_env=generic_ubuntu all     # or target_env=home_macos
```

This runs three things:

1. `set_local_dotfiles` — symlinks files from `local/<target_env>/` into the
   repo root so that, e.g., `local/generic_ubuntu/shell_profile.local` appears
   as `./shell_profile.local`.
2. `link_dotfiles_to_home` — creates `~/.<name>` symlinks for every top-level
   file (minus support/excluded names). Refuses to clobber an existing real
   directory (prints a SKIP message instead).
3. `link_config_to_home` + `link_claude_to_home` — per-subdir symlinks into
   existing `~/.config/` and `~/.claude/` without replacing those directories.
4. `bin` — per-file symlinks of `bin/*` into `~/bin/`.

Dry-run: `make list_dotfiles target_env=generic_ubuntu` — prints what would
be linked and where, without making changes.

### The `~/.config` and `~/.claude` caveats

`~/.config/` on Linux is almost always a real directory full of app state
(Brave, GTK, GNOME/Cosmic, etc.). The Makefile therefore symlinks only the
specific subdirs in `./config/` (alacritty, nvim, hypr, …) into it, rather
than replacing the whole directory.

`~/.claude/` is managed by Claude Code (sessions, history, auth tokens — not
suitable for tracking). The Makefile symlinks only the individual files from
`./claude/` that are intentionally tracked (currently just `settings.json`).

## Local overrides

The pattern: tracked files source a `.local` counterpart if it exists, e.g.
`aliases` sources `~/.aliases.local`. The `.local` files live under
`local/<target_env>/` and are selected at deploy time.

Files that follow the pattern: `aliases`, `bash_profile`, `gitconfig`,
`shell_profile`, `tmux.conf`, `vimrc`. Add a file to both the tracked
`<name>` (to source it) and to each `local/<env>/<name>.local` (with the
per-env content).

`gitconfig` specifically uses an `[include] path = ~/.gitconfig.local` at
the bottom of the file, so the local include wins over the tracked defaults
(useful for per-machine email and credential helpers).

## Private secrets

Anything that must never hit git goes into a `*.private` file, which is
sourced by `shell_profile` / `bash_profile` if present but not tracked:

```sh
touch ~/.shell_profile.private    # sourced by shell_profile
touch ~/.bash_profile.private     # sourced by bash_profile (if wired up)
```

`.gitignore` already excludes `*.private` and the `*.local` filenames.

## Shell-init reference

- `bashrc` runs for each new non-login shell (normal terminal windows on
  Linux). On macOS, Terminal.app runs a **login** shell per window and
  therefore sources `bash_profile`, not `bashrc` — so everything
  interactive needs to be reachable from `bash_profile`.
- In this repo, `bashrc` sources `bash_profile`, and `bash_profile` sources
  `shell_profile`, which is shared with `zshrc`. All interactive
  configuration ends up in `shell_profile` and `aliases`.
- `zsh` via oh-my-zsh is the intended primary shell; `bash` is supported
  for rescue/compat.

## Bootstrapping a brand-new machine

The full flow is in the Ansible project. The short version for a manual
bootstrap:

1. Install git + curl + sudo.
2. Generate / install SSH keys, add to GitHub.
3. `gh repo clone MEHColeman/dotfiles $HOME/.dotfiles`
4. Install oh-my-zsh (prereq for `zshrc`): see
   <https://github.com/ohmyzsh/ohmyzsh>.
5. `cd ~/.dotfiles && git submodule update --init --recursive`
6. `make target_env=generic_ubuntu all`
7. `touch ~/.shell_profile.private`
8. Switch default shell to zsh.

## Testing

A `Dockerfile` exists for smoke-testing the Makefile in an isolated Ubuntu
container: `make docker` builds an image named `docker_dotfile_test`. Run
`make all target_env=generic_ubuntu` inside the container to verify the
symlink layout.
