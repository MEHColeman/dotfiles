# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "$HOME/dev/bw/projects/proxmox"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "proxmox"

# Split window into panes.
split_h 40 1

split_v 33 2
split_v 50 2

# Run commands.
run_cmd " pwd"  1    # runs in active pane
run_cmd " ls" 2  # runs in pane 1

run_cmd "tmux set pane-border-status top" 1
run_cmd "printf '\033]2;%s\033\\' 'pve'" 1
run_cmd "ssh root@192.168.1.33" 1


run_cmd "printf '\033]2;%s\033\\' 'macos'" 2
run_cmd "ssh mark@192.168.1.240" 2

run_cmd "printf '\033]2;%s\033\\' 'windows'" 3
run_cmd "ssh mark@192.168.1.55" 3

run_cmd "printf '\033]2;%s\033\\' 'popos'" 4
run_cmd "ssh mark@192.168.1.204" 4

# Paste text
#send_keys "cat     # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
select_pane 1
