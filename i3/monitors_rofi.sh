#!/bin/bash

HDMI_STATUS=$(xrandr | grep -m 1 HDMI | awk '{ print $2 }')

commands=(
  ""
  "/home/griffin/.screenlayout/mirrored.sh"
  "/home/griffin/.screenlayout/pc_only.sh"
  "/home/griffin/.screenlayout/hdmi_only.sh"
  "/home/griffin/.screenlayout/hdmi_only_HD.sh"
  "/home/griffin/.screenlayout/separated.sh"
)

if [[ $HDMI_STATUS == "connected" ]]; then
    eval "/home/griffin/.config/i3/set_hdmi_audio.sh"

    options=("Mirror screens" "Show screen only on PC" "Show screen only on HDMI" "Show screen only on HDMI HD" "Separate screens" "Do nothing")

    chosen=$(printf "%s\n" "${options[@]}" | rofi -dmenu -p "Please select an option:")

    case "$chosen" in
        "Mirror screens")
            eval "${commands[1]}"
            ;;
        "Show screen only on PC")
            eval "${commands[2]}"
            ;;
        "Show screen only on HDMI")
            eval "${commands[3]}"
            ;;
        "Show screen only on HDMI HD")
            eval "${commands[4]}"
            ;;
        "Separate screens")
            eval "${commands[5]}"
            ;;
        "Do nothing")
            # No command to execute
            ;;
        *)
            echo "Invalid option. Please select a valid option."
            ;;
    esac
else
    eval "/home/griffin/.config/i3/set_pc_audio.sh"
    eval "/home/griffin/.screenlayout/pc_only.sh"
fi

eval "/home/griffin/.config/i3/set_wallpaper.sh"
