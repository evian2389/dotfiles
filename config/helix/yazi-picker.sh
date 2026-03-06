#!/bin/bash
# Yazi file picker for Helix in Zellij

tmp=$(mktemp)

yazi --chooser-file="$tmp"

if [ -s "$tmp" ]; then
    selected=$(head -1 "$tmp")
    
    if [ -f "$selected" ]; then
        zellij action toggle-floating-panes
        zellij action write-chars ":open $selected"
        zellij action write 13
    fi
fi

rm -f "$tmp"
