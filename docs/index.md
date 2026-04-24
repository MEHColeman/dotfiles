# Dotfiles Wiki

Companion docs for [`~/.dotfiles`](../README.md). Each page explains a tool
that has config in the repo: what it does, how I use it, and a shortcut
cheatsheet. Links use Obsidian `[[wiki-link]]` syntax.

For repo layout and deploy mechanics, see the top-level [`README`](../README.md).

## Editor

- [[Neovim]] — `vimrc`, `vimrc.plugins` (vim-plug), `vimrc.key_mappings`, Colemak remaps, plugin cheatsheet

## Shells & Terminal

- [[Shell]] — zsh + oh-my-zsh + powerlevel10k; init chain across bash/zsh; `aliases`; local/private override pattern
- [[Tmux]] — prefix (`C-t`), pane/window bindings, `tmux-resurrect`, `tmuxifier` layouts, vim-tmux-navigator integration
- [[Alacritty]] — GPU terminal config (fonts, colors, keybindings)

## Version Control

- [[Git]] — aliases, commit template, signing, `diff-highlight` pager, `gh` credential helper, `[include]` layering

## AI Assistant

- [[Claude Code]] — `settings.json` (voice hold mode), layout of `~/.claude/`, commands/agents/skills, memory, hooks

## Desktop / WM

- [[Hyprland]] — Wayland tiling WM (dormant, planned) — keybinds, workspaces, volume scripts

## Scripts & Misc

- [[Bin Scripts]] — `ssh-manager`, `start_ssh_agent.sh`, `start_postgres.sh`, `tmux.number.sh`, `diff-highlight`, `tree`
- [[Other Tools]] — small configs: `ack`, `pry`, `rubocop`, `rspec`, `gemrc`, `screenrc`, `lesskey`, `ctags`, `pcmanfm`, `mc`, `libfm`, `volumeicon`, `parcellite`, `youtube-dl`, `terminalizer`, `tmuxinator`, `sidebar_aliases`, `fonts/`

## Conventions used in these pages

- **File paths** are absolute (`/home/mark/.dotfiles/…`) so they're clickable in Obsidian and `grep`-pastable in a terminal.
- **Cheatsheets** prefer a table: `Key` / `Mode` / `Action`. Stripped to what I actually use.
- **Plugin descriptions** cover the *paradigm* (what it's for, when to reach for it) rather than exhaustively listing commands — upstream docs remain the source of truth for full syntax.
- **Stale-risk items** (plugin lists, keybinds) are sourced from the tracked config files — if a page disagrees with a config, the config wins.
