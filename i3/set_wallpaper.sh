#!/bin/bash

xrandr --listmonitors | grep HDMI | grep 1920
HD_ON=$? # 0 if command worked
if [ $HD_ON -eq 0 ]; then
  feh --bg-scale /home/griffin/Pictures/wallpaper/wallpaperHD.png
else
  feh --bg-scale /home/griffin/Pictures/wallpaper/wallpaper.png
fi

