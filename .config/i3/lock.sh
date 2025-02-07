#!/bin/bash

# Path to your image
IMAGE_PATH="/path/to/your/image.jpg"

# Get screen resolution
SCREEN_RES=$(xrandr | grep ' connected' | sed -e 's/^[[:space:]]*//' | cut -d' ' -f3)

# Resize the image to fit the screen resolution
convert "$IMAGE_PATH" -resize "$SCREEN_RES" -background black -gravity center -extent "$SCREEN_RES" /tmp/lock.png

# Run i3lock with the resized image
i3lock -i /tmp/lock.png

# Remove the temporary image after i3lock exits
rm /tmp/lock.png

