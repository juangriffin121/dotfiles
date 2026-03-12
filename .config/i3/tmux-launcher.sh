#!/bin/bash

selected=$(echo -e "$(tmuxifier list-sessions)" | custom_menu1 -i -p "Open tmux session:") # custom_menu1 is a rofi script

if [ -n "$selected" ]; then
    option=$(echo -e "Load\nEdit"| custom_menu1 -i -p "Open tmux session:") # custom_menu1 is a rofi script
    case "$option" in
      "Edit") alacritty -e bash -ic "tmuxifier edit-session $selected"
      ;;
      "Load") alacritty -e bash -ic "tmuxifier load-session $selected"
      ;;
      *) echo "Something wong"
      ;;
    esac
fi
