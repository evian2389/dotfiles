#!/usr/bin/env bash
# Usage: ./niri_run_or_raise.sh <app_id> <command>

APP_ID="$1"
LAUNCH_CMD="$2"

# Get the window ID of the first existing instance matching the app_id
WINDOW_ID=$(niri msg --json windows | jq -r --arg app_id "$APP_ID" '.[] | select(.app_id == $app_id) | .id' | head -n1)

if [ -n "$WINDOW_ID" ]; then
    # If it exists, pull focus to that window
    niri msg action focus-window --id "$WINDOW_ID"
else
    # Fallback for Google Chrome if binary name differs (e.g. Flatpak installation on Guix)
    if [ "$LAUNCH_CMD" = "google-chrome-stable" ] && ! command -v google-chrome-stable &>/dev/null; then
        if command -v google-chrome &>/dev/null; then
            LAUNCH_CMD="google-chrome"
        elif command -v flatpak &>/dev/null && flatpak info com.google.Chrome &>/dev/null; then
            LAUNCH_CMD="flatpak run com.google.Chrome"
        fi
    fi
    # If it doesn't exist, spawn a new process completely detached
    setsid $LAUNCH_CMD &
fi
