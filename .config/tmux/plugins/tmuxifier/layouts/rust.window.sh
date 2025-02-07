# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "/mnt/win_share/Users/Usuario/my_scripts/rust_dir/unlp_rust/"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "rust"

run_cmd "nvim"     # runs in active pane

# Split window into panes.
#split_v 20
split_h 50

# Run commands.
#run_cmd "date" 1  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
#select_pane 0
