# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/dev/bw/projects/download_management"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "batch-dls"

# Split window into panes.
split_h 33 1
split_h 50 1

split_v 33 1
split_v 50 1

split_v 33 4
split_v 50 4

# Run commands.
run_cmd " pwd"  1    # runs in active pane
run_cmd " ls" 2  # runs in pane 1
run_cmd " cd Bulk-Bing-Image-downloader" 3

# Paste text
#send_keys "cat     # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
select_pane 1
