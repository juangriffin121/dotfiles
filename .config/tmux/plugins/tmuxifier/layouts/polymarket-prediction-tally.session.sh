# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "/mnt/win_share/Users/Usuario/my_scripts/polymarket-predictions-tally/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "polymarket-prediction-tally"; then

  new_window "code"
  split_h 50
  select_pane 1
  run_cmd "nvim"
  select_pane 2
  run_cmd "neofetch"
  select_pane 1
  
  new_window "files"
  run_cmd "y"
  # y is a shorthand function for yasi that allows me to cwd when i press q, it has to have the function written in .bashrc

  new_window "git"
  run_cmd "lazygit"

  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
