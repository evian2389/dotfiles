#!/usr/bin/env bash

TAG_FILE_G="/tmp/niri_pinned_win_g"

case "$1" in
    "set_g")
        # Get the unique ID of the currently active window
        WIN_ID=$(niri msg --json focused-window | jq '.id')
        if [ "$WIN_ID" != "null" ]; then
            echo "$WIN_ID" > "$TAG_FILE_G"
            notify-send "Niri" "Window successfully pinned to G"
        fi
        ;;
    "go_g")
        # Read the stored ID and tell Niri to focus it
        if [ -f "$TAG_FILE_G" ]; then
            WIN_ID=$(cat "$TAG_FILE_G")
            niri msg action focus-window --id "$WIN_ID" || notify-send "Niri" "Pinned window no longer exists"
        else
            notify-send "Niri" "Slot G is empty. Use Mod+Alt+G to bind a window first."
        fi
        ;;
esac
