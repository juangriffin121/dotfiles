# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/dotfiles/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "dotfiles"; then

  run_cmd "poetry shell"
  new_window "code"
  split_h 50

  select_pane 1
  run_cmd "nvim"

  new_window "git"
  run_cmd "lazygit"

  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
