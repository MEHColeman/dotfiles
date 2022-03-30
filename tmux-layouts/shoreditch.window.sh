# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/notes/blog/shoreditch"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "shoreditch"

# Split window into panes.
split_h 30
split_v 90

# Run commands.
run_cmd " vi"  1    # runs in active pane
run_cmd " bundle exec jekyll serve --future --watch -V -t --lsi" 2  # runs in pane 2

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
select_pane 1
