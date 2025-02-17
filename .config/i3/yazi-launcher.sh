#!/bin/bash

# Save this as ~/.local/bin/yazi-launcher.sh and make it executable with chmod +x

# Associate display names with paths
declare -A dir_map
dir_map["🏠 Home"]="$HOME"
dir_map["📥 Downloads"]="$HOME/Downloads"
dir_map["📄 Documents"]="$HOME/Documents"
dir_map["🖼️ Pictures"]="$HOME/Pictures"
dir_map["</> Scripts"]="/mnt/win_share/Users/Usuario/my_scripts"
dir_map["󰉋  Mom"]="$HOME/mom/"
dir_map["  Config"]="$HOME/.config"
# dir_map["🎬 Videos"]="$HOME/Videos"
# dir_map["💻 Projects"]="$HOME/Projects"
# dir_map["📍 Current: $(pwd)"]="$(pwd)"

# Get the display names for rofi
options=$(printf "%s\n" "${!dir_map[@]}")

# Show rofi menu with display names
selected=$(echo -e "$options" | custom_menu1 -i -p "Open Yazi in:")

# Get the actual path from the selected display name and launch yazi
if [ -n "$selected" ]; then
    target_dir="${dir_map[$selected]}"
    kitty -e bash -ic 'cd "'"$target_dir"'" && yazi'
    # kitty -e bash -ic 'source "$HOME/.bashrc"; export EDITOR=nvim; cd "'"$target_dir"'" && yazi'
    # kitty -e sh -c 'cd "'"$target_dir"'" && yazi'
fi
