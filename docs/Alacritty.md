# Alacritty

GPU-accelerated terminal emulator. Config:
[`config/alacritty/alacritty.yml`](../config/alacritty/alacritty.yml),
symlinked to `~/.config/alacritty/alacritty.yml`.

Alacritty has no tabs/splits of its own — pair it with [[Tmux]] for
multiplexing.

## Notable settings

| Setting | Value | Notes |
|---|---|---|
| `font.normal.family` | `Inconsolata Nerd Font` | Nerd Font required for airline + powerlevel10k glyphs. See [[Other Tools#fonts]] |
| `font.size` | `14.0` | |
| `window.option_as_alt` | `OnlyLeft` | macOS only — left Option becomes Alt for tmux/vim keybinds |
| `window.dynamic_title` | `true` | Let shell/tmux set the window title |
| `window.opacity` | `1.0` | No transparency |
| `window.startup_mode` | `Windowed` | |
| `scrolling.history` | `10000` | |
| `draw_bold_text_with_bright_colors` | `true` | |
| `mouse_bindings` | Middle-click pastes selection | Linux convention |
| `live_config_reload` | `true` | Edit the yaml and changes apply immediately |
| `cursor.style` | `Block` | |

Colour scheme is a dark "Tomorrow Night Bright"-style palette with
explicit 16-colour `normal` and `bright` tables.

## Key bindings worth noting

Most are the Alacritty defaults passed through explicitly (arrow keys,
page up/down with modifiers producing the right escape sequences for
xterm-compatible apps). The notable ones I actually touch:

| Key | Action |
|---|---|
| `C-l` | Clear log notice + send form-feed (clears the screen inside the shell too) |
| `Shift+PageUp/PageDown` | Scroll the terminal's own scrollback (not the app's) |
| `Alt+PageUp/PageDown` etc. | Pass-through of xterm escape sequences for apps to interpret |

The big block of `F1`–`F12` × `Shift` / `Control` / `Alt` / `Super`
mappings (lines 523–582) emit the standard xterm F-key sequences so
vim/tmux keybinds work predictably across platforms.

## Alternatives and Wayland notes

On a Wayland session (COSMIC / Hyprland), Alacritty runs natively on
Wayland. The config above works unchanged.

Config lives in `~/.config/alacritty/alacritty.yml` — newer Alacritty
releases prefer TOML (`alacritty.toml`). When upgrading: run
`alacritty migrate` to convert.

## Related pages

- [[Tmux]] — mux your alacritty window
- [[Shell]] — shell/prompt that renders inside
- [[Other Tools#fonts]] — Nerd Fonts required for the chosen family
