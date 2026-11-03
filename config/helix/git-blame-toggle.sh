#!/bin/bash
FILE="$1"
LOCKFILE="/tmp/helix-git-blame.pid"

if [ -f "$LOCKFILE" ]; then
    PID=$(cat "$LOCKFILE")
    if kill -0 "$PID" 2>/dev/null; then
        kill "$PID" 2>/dev/null
        rm -f "$LOCKFILE"
        exit 0
    fi
    rm -f "$LOCKFILE"
fi

zellij run -f -x 5% -y 5% --width 90% --height 90% -- \
    bash -c "echo \$\$ > '$LOCKFILE'; git blame '$FILE' | less -R; rm -f '$LOCKFILE'"
