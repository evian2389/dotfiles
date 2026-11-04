#!/usr/bin/env bash
set -euo pipefail

exec systemctl --user start taskwarrior-jira-sync.service
