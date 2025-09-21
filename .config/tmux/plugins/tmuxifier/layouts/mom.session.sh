# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/mom"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "mom"; then

  new_window "main"
  run_cmd "y"

  new_window "text"
  split_h 50
  select_pane 1
  run_cmd "nvim"
  select_pane 2
  run_cmd "neofetch"
  select_pane 1
  

  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
