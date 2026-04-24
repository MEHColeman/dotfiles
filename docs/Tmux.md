# Tmux

Terminal multiplexer. Config at [`tmux.conf`](../tmux.conf), sourced as
`~/.tmux.conf` after `make dotfiles`. A per-env file
[`tmux.conf.local`](../local/generic_ubuntu/tmux.conf.local) is included
at the end.

## Prefix

```
C-t   (not the default C-b)
```

All bindings below assume you've pressed prefix first, unless marked as
`root` (sent without prefix).

## Layout philosophy

- Windows are numbered from **1**, not 0 (`base-index 1`).
- Panes are also 1-indexed (`pane-base-index 1`).
- Windows auto-renumber when one closes (`renumber-windows on`).
- Panes auto-rename based on the running command but names stick
  (`allow-rename off`), so your manual rename isn't stomped.
- Mouse is **on** — scroll with wheel, resize with drag, click to select.

## Window / pane management

| Key | Action |
|---|---|
| `v` | Split vertically (new pane to the right) |
| `s` | Split horizontally (new pane below) |
| `-` | Re-lay panes to even-vertical layout |
| `\|` | Re-lay panes to even-horizontal layout |
| `h` | "Hide" — break pane into its own window (`-dP` keeps it attached but hidden, prints info) |
| `S` | Choose window, join its pane as a horizontal split |
| `V` | Choose window, join its pane as a vertical split |
| `<` | Renumber current window (prompts for new index; uses [`bin/tmux.number.sh`](../bin/tmux.number.sh)) |
| `r` | Reload `~/.tmux.conf` |
| `p` | Paste latest buffer |

## Movement (without prefix)

Uses **[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)**
so the same bindings move between tmux panes *and* vim splits
seamlessly:

| Key | Action |
|---|---|
| `C-←` | Focus pane left (or, if in vim, split left) |
| `C-↓` | Focus pane down |
| `C-↑` | Focus pane up |
| `C-→` | Focus pane right |
| `C-\` | Focus last pane |
| `C-a` | (root) Last window |

The logic detects vim/nvim by inspecting the pane's running process
(`is_vim` shell test in [`tmux.conf:95`](../tmux.conf)).

## Resize (without prefix)

| Key | Action |
|---|---|
| `M-←/↓/↑/→` | Resize pane by 1 in that direction |
| `C-M-←/↓/↑/→` | Resize pane by 5 in that direction |

## Copy-mode (vi-style)

`mode-keys` is `vi`. Enter copy mode the usual way (`[` after prefix).

| Key | Mode | Action |
|---|---|---|
| `v` | copy-mode | Begin visual selection |
| `V` | copy-mode | Toggle line / rectangle select |
| `y` | copy-mode | Yank selection to buffer |
| `p` | normal | Paste latest buffer |

Mouse wheel in copy-mode scrolls back; mouse select auto-enters copy
mode.

## Status bar

Left: red session name + green hostname. Per-window format shows the
index, name, and an activity marker. Active window is highlighted in
colour 75 on 88.

## Plugins

### tmux-resurrect

[tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) saves
and restores sessions across reboots. Not bootstrapped automatically —
install once:

```sh
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux-resurrect
```

`tmux.conf` already runs `~/.tmux-resurrect/resurrect.tmux` at the end.
Configured to also restore: `ssh psql mysql sqlite3 bundle guard`, and
vim sessions (`@resurrect-strategy-vim 'session'`).

Save: `prefix + C-s`. Restore: `prefix + C-r`.

### tmuxifier (session layouts)

[tmuxifier](https://github.com/jimeh/tmuxifier) — scripted session
layouts. Initialized from [`zshrc:50`](../zshrc) and
[`bash_profile:68`](../bash_profile) via `eval "$(tmuxifier init -)"`.

Layouts live in [`tmux-layouts/`](../tmux-layouts), pointed to via
`TMUXIFIER_LAYOUT_PATH` in [`shell_profile:9`](../shell_profile). Current
layouts:

- `notes.window.sh` — splits into panes, opens notes files in each
- `phoenix-dev.window.sh`, `pay-dev.window.sh`, `migpay-dev.window.sh`,
  `shoreditch.window.sh`, `batch-dl.window.sh`, `proxmoxing.window.sh`
  — project-specific dev layouts

Aliases ([`aliases:31-34`](../aliases)):

| Alias | Runs |
|---|---|
| `mnotes` | `tmuxifier load-window notes` |
| `mphoenix` | `tmuxifier load-window phoenix-dev` |
| `mpay` | `tmuxifier load-window pay-dev` |
| `mmigpay` | `tmuxifier load-window migpay-dev` |

Author new layouts with `tmuxifier new-window <name>` — creates a
template in `$TMUXIFIER_LAYOUT_PATH`. See layout source files for the
DSL: `window_root`, `new_window`, `split_h`, `run_cmd`, `select_pane`.

### tmuxinator (legacy)

[`tmuxinator/test.yml`](../tmuxinator/test.yml) is a leftover YAML-based
session definition. Tmuxinator is not auto-wired by the Makefile and
isn't in the current workflow — tmuxifier replaced it. Kept for
reference.

## Terminal settings

- `default-terminal "screen-256color"` — correct TERM value inside tmux.
- `terminal-overrides ',xterm-256color:RGB'` — enables 24-bit truecolor
  for vim themes, airline, etc.
- `history-limit 10000` — scrollback buffer.
- `escape-time 0` — avoids vim `<Esc>` lag.
- `focus-events on` — lets vim's `FocusLost`/`FocusGained` autocmds fire.

## Related pages

- [[Neovim]] — vim-tmux-navigator, vim-slime (sends to tmux pane),
  tmux-resurrect restores vim sessions
- [[Shell]] — tmuxifier init lives in shell rc; layout aliases
- [[Bin Scripts]] — `tmux.number.sh` implements screen-style renumbering
