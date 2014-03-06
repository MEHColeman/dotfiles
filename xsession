#!/usr/bin/env bash
xrandr --output VGA1 --mode 1920x1200 --left-of HDMI1
# setxkbmap us -variant colemak
xrdb -merge ~/.Xdefaults
chromium &
gnome-do 2>/dev/null >/dev/null &
btsync # --config ~/.btsync/btsync.config
gnome-terminal --hide-menubar &
gnome-terminal --hide-menubar &
gnome-terminal --hide-menubar &
gnome-terminal --hide-menubar &
gnome-terminal --hide-menubar -x mcabber &
trayer --edge top --align right --SetDockType true  --expand true --width 10 --height 18  --transparent true --tint 0x073642 --alpha 0 &
xsetroot -solid '#200b06'

exec xmonad
