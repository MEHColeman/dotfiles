# Hyprland

Tiling Wayland compositor. Currently **dormant** — config is staged in
the repo but the active desktop is COSMIC. Leaving this configured
means I can switch sessions without a fresh bootstrap.

Config:
[`config/hypr/hyprland.conf`](../config/hypr/hyprland.conf), symlinked
to `~/.config/hypr/hyprland.conf`.

Helper scripts:
[`config/hypr/scripts/volumecontrol.sh`](../config/hypr/scripts/volumecontrol.sh)
(referenced as `$volume` for the `xf86audioraisevolume`/
`xf86audiolowervolume` binds).

## Modifier

```
$mainMod = SUPER     (Windows / Command key)
```

## Startup apps (`exec-once`)

- `waybar` — top bar
- `blueman-applet` — Bluetooth systray
- `nm-applet --indicator` — Network systray

## Keybinds

### Apps

| Key | Action |
|---|---|
| `SUPER + Q` | Launch `kitty` (terminal) |
| `SUPER + F` | Launch `firefox -P` (with profile chooser) |
| `SUPER + E` | Launch `nautilus` (file manager) |
| `SUPER + Space` | Run `rofi -show drun` (app launcher) |

### Window management

| Key | Action |
|---|---|
| `SUPER + K` | Kill active window |
| `SUPER + M` | Exit Hyprland |
| `SUPER + V` | Toggle floating |
| `SUPER + P` | Pseudotile (dwindle layout) |
| `SUPER + J` | Toggle split direction (dwindle) |
| `SUPER + ←/↓/↑/→` | Move focus |

### Workspaces

| Key | Action |
|---|---|
| `SUPER + 0..9` | Switch to workspace N (1-10) |
| `SUPER + Shift + 0..9` | Move active window to workspace N |
| `SUPER + Shift + ↑/↓` | Move active window to workspace 1 / 2 |
| `SUPER + mouse_up/down` | Cycle through existing workspaces |
| `SUPER + LMB drag` | Move window |
| `SUPER + RMB drag` | Resize window |

### Media

| Key | Action |
|---|---|
| `XF86AudioRaiseVolume` | Volume up (runs `volumecontrol.sh --inc`) |
| `XF86AudioLowerVolume` | Volume down (runs `volumecontrol.sh --dec`) |

## Input

| Setting | Value |
|---|---|
| `kb_layout` | `gb` |
| `kb_variant` | `colemak` (matches my physical typing layout) |
| `follow_mouse` | `1` (focus follows) |
| `touchpad.natural_scroll` | off |

## Visual

- `gaps_in = 1`, `gaps_out = 0` — minimal gaps
- `border_size = 3`; active border: gold/orange gradient (45°), inactive: deep navy
- `rounding = 5`
- Blur + drop shadows enabled
- Animations with a custom bezier curve
- `dwindle` layout (BSP-style recursive split)

## When activating Hyprland

Before switching sessions:

1. Install Hyprland + waybar + rofi + nautilus + kitty (Ansible will
   drive this; manual: `sudo apt install hyprland waybar rofi` etc.)
2. Verify `~/.config/hypr/hyprland.conf` resolves (should be a symlink
   after `make`).
3. Log out and pick the Hyprland session from the greeter.
4. First launch will spawn waybar/network applets via `exec-once`.

## Related pages

- [[Alacritty]] — drop-in terminal (replace `kitty` in the `SUPER+Q` bind
  if preferred)
- [[Shell]] — terminal-side setup that'll run inside kitty/alacritty
