#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 || ! "$1" =~ ^[[:xdigit:]]{8}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{12}$ ]]; then
    echo "Select exactly one task to open its Jira issue." >&2
    exit 2
fi

jira_url="$(
    task "$1" export | python3 -c '
import json
import sys
from urllib.parse import urlsplit

records = json.load(sys.stdin)
if len(records) != 1:
    sys.exit("Selected Taskwarrior task was not found.")

url = records[0].get("jiraurl", "")
parsed = urlsplit(url)
if (
    parsed.scheme != "https"
    or parsed.netloc.lower() != "jira.lge.com"
    or not parsed.path.startswith("/issue/browse/")
):
    sys.exit("Selected task does not contain a valid Jira issue URL.")

print(url)
'
)"

browser="$(command -v zen-browser)" || {
    echo "Zen Browser executable 'zen-browser' was not found." >&2
    exit 127
}
nohup "$browser" --new-tab "$jira_url" >/dev/null 2>&1 </dev/null &
