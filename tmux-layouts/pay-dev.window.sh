# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/dev/mgage/pay-nl"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "pay-dev"

# Split window into panes.
split_h 42
split_v 30
split_v 14

# Run commands.
run_cmd " vi"  1    # runs in active pane
run_cmd " bundle exec guard" 2  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
select_pane 1
