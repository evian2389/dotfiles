#!/bin/bash
# Usage: ./niri-run-or-raise.sh <app_id> <command>

APP_ID="$1"
LAUNCH_CMD="$2"

# Get the window ID of the first existing instance matching the app_id
WINDOW_ID=$(niri msg --json windows | jq -r --arg app_id "$APP_ID" '.[] | select(.app_id == $app_id) | .id' | head -n1)

if [ -n "$WINDOW_ID" ]; then
    # If it exists, pull focus to that window
    niri msg action focus-window --id "$WINDOW_ID"
else
    # If it doesn't exist, spawn a new process completely detached
    setsid $LAUNCH_CMD &
fi
