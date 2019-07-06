#!/bin/bash

# This script implements screen-like window renumbering.
# It is referenced in tmux.conf
# source: https://superuser.com/questions/343572/how-do-i-reorder-tmux-windows

if [ $# -ne 1 -o -z "$1" ]; then
    exit 1
fi
if tmux list-windows | grep -q "^$1:"; then
    tmux swap-window -t $1
else
    tmux move-window -t $1
fi
