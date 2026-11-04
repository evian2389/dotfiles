#!/usr/bin/env bash
set -euo pipefail

exec systemctl --user --no-block start taskwarrior-jira-sync.service
