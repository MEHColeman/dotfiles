# Other Tools

Smaller tool configs with small footprints. One paragraph each —
promote to its own page if the setup grows.

## ack

[`ackrc`](../ackrc) → `~/.ackrc`. Adds `.sass` / `.feature` as Ruby
files and ignores the usual noise dirs (`log`, `vendor`, `tmp`,
`images`, `.kerl`, `deps`, `ebin`, `.eunit`, `release`).

`ack-grep` is aliased to `ack` in [`aliases:4`](../aliases) so the
Debian binary name just works. Reach for `ack` when you want
fast, language-aware grep across a tree. (Modern alternatives like
`ripgrep`/`rg` are faster; ack is kept for muscle memory.)

## pry (`~/.pryrc`)

[`pryrc`](../pryrc) adds:

- `Object#interesting_methods` — `obj.interesting_methods` returns just
  the methods defined on that class, not inherited. Handy for quick
  introspection at a pry prompt.
- Pry-debugger shortcuts: `c`/`s`/`n`/`f` for continue/step/next/finish
  (only defined if `PryDebugger` or `PryByebug` is loaded).

## rubocop

[`rubocop.yml`](../rubocop.yml) → project-agnostic defaults. Ruby target
`2.7`, excludes `node_modules`, `db`, `bin`, `vendor`; relaxes
`Metrics/BlockLength` for `config/*`. Requires plugins: `rubocop-rspec`,
`rubocop-performance`, `rubocop-rails`, `rubocop-require_tools`,
`rubocop-rake`.

Note: placed at `~/.rubocop.yml`, so **every** Ruby project on the
machine gets these defaults unless a project-local `.rubocop.yml`
overrides. Most projects do override.

## rspec

[`rspec`](../rspec) → `~/.rspec`. Just:

```
--backtrace
--colour
```

## gemrc

[`gemrc`](../gemrc) → `~/.gemrc`. Turns off RDoc/RI generation on
`gem install`:

```
gem: --no-rdoc --no-ri
```

Saves time; generate docs on demand if actually needed.

## screenrc

[`screenrc`](../screenrc) → `~/.screenrc`. Three lines — `autodetach
on`, no startup message, 30k-line scrollback. `screen` is used as the
fallback multiplexer (auto-invoked in remote SSH sessions by the block
in [`shell_profile:26`](../shell_profile)) — [[Tmux]] is the primary.

## lesskey

[`lesskey`](../lesskey) sets the `LESS` env var to `-i -R -X`:

- `-i` — smart-case search
- `-R` — render ANSI colours
- `-X` — don't clear the screen on exit (results stay visible)

## ctags

[`ctags`](../ctags) → `~/.ctags`:

```
--recurse
--tag-relative
--exclude=".git"
```

Every `ctags` invocation gets these defaults. Paired with
[[Neovim#Navigation-search]] `vim-autotag` (uses `uctags` — universal
ctags) and `tagbar`.

## pcmanfm

[`config/pcmanfm/default/`](../config/pcmanfm) and
[`config/pcmanfm/lxde.conf`](../config/pcmanfm/lxde.conf). Lightweight
file manager used on slim desktop setups. No unusual settings.

## libfm

[`config/libfm/libfm.conf`](../config/libfm/libfm.conf). Settings for
libfm-backed file managers (pcmanfm, others): single-click off, trash
enabled, terminal set to `urxvt -e %s`, thumbnails up to 2048 KB.
Swap the terminal line if you don't have urxvt installed.

## mc (Midnight Commander)

[`config/mc/ini`](../config/mc/ini). Editor: internal editor with
syntax highlighting, tab=8, line-state off. Mostly defaults with a few
confirm-before-destructive tweaks.

Launch with `mc`. The two-pane file manager is great for move/copy
between directories via keyboard. F-keys at the bottom of the screen
show the main actions.

## volumeicon, parcellite, youtube-dl

Directories present under [`config/`](../config) for these tray apps
(`volumeicon`, `parcellite` clipboard manager) and downloader
(`youtube-dl`). Kept symlinked into `~/.config/` in case any of them
are running; no non-default customisation.

## terminalizer

[`terminalizer/config.yml`](../terminalizer/config.yml). Default record
settings for [terminalizer](https://github.com/faressoft/terminalizer):
shell `zsh`, Inconsolata font, solid frame, a dark-ish theme. Use for
turning a terminal session into a GIF:

```sh
terminalizer record demo
terminalizer render demo
```

## tmuxinator

[`tmuxinator/test.yml`](../tmuxinator/test.yml). A stub YAML session
layout. Tmuxinator has been superseded by tmuxifier in the current
workflow — see [[Tmux#tmuxinator-legacy]]. Kept as reference.

## sidebar_aliases

[`sidebar_aliases/`](../sidebar_aliases) — empty directories
(`Downloads`, `Formula 1`, `Movies`, `TV Shows`) used as custom Finder
sidebar aliases on macOS. Not relevant on Linux; kept for future Mac
sync.

## fonts

[`fonts/`](../fonts) symlinks to `~/.fonts/` (Linux) or needs installing
via Font Book / brew cask on macOS:

- `Inconsolata+for+Powerline.otf` — older powerline glyphs
- `mensch.ttf` — alternate coding font
- `MesloLGS NF Regular/Bold/Italic/Bold-Italic.ttf` — **required by
  powerlevel10k** and vim-airline. See [[Shell#powerlevel10k]].

After updating `~/.fonts/`, run `fc-cache -f` to refresh the font cache.

## Related pages

- [[Tmux]] — tmuxinator/terminalizer sit alongside primary tmux workflow
- [[Shell]] — fonts feed the prompt
- [[Neovim]] — ctags + ack used by plugins
