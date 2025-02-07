# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "/mnt/win_share/Users/Usuario/my_scripts/rust_dir/entropy_playground/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "entropy_playground"; then

  # Create a new window inline within session layout definition.

  new_window "code"
  split_h 50
  select_pane 1
  run_cmd "nvim"
  select_pane 2
  run_cmd "neofetch"
  select_pane 1
  # Load a defined window layout.
  new_window "files"


  # y is a shorthand function for yasi that allows me to cwd when i press q, it has to have the function written in .bashrc
  run_cmd "y"
  #load_window "example"
  select_window 1


fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
