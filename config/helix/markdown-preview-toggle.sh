#!/usr/bin/env bash
set -euo pipefail

file=${1:?Markdown file path is required}

workspace_id=${HERDR_WORKSPACE_ID:-}
caller_pane_id=${HERDR_PANE_ID:-}
if [[ ! "$workspace_id" =~ ^w[[:alnum:]_-]+$ ||
  ! "$caller_pane_id" =~ ^w[[:alnum:]_-]+:p[[:alnum:]_-]+$ ]]; then
  current_pane=$(herdr pane current)
  current_context=$(python3 -c '
import json
import sys

pane = json.load(sys.stdin).get("result", {}).get("pane", {})
print(pane.get("workspace_id", ""), pane.get("pane_id", ""))
' <<<"$current_pane")
  workspace_id=''
  caller_pane_id=''
  read -r workspace_id caller_pane_id <<<"$current_context" || true
fi

if [[ ! "$workspace_id" =~ ^w[[:alnum:]_-]+$ ||
  ! "$caller_pane_id" =~ ^w[[:alnum:]_-]+:p[[:alnum:]_-]+$ ]]; then
  printf 'Could not resolve the current Herdr pane for Markdown preview.\n' >&2
  exit 1
fi

file_path=$(realpath -- "$file")
runtime_dir=${XDG_RUNTIME_DIR:-/tmp}
state_file="${runtime_dir}/helix-markdown-preview-${UID}-${caller_pane_id//:/_}.pane"

if [[ -f "$state_file" ]]; then
  pane_id=''
  read -r pane_id < "$state_file" || true
  if [[ "$pane_id" =~ ^w[[:alnum:]_-]+:p[[:alnum:]_-]+$ ]]; then
    pane_ids=$(herdr pane list --workspace "$workspace_id" |
      python3 -c 'import json, sys; print("\n".join(p["pane_id"] for p in json.load(sys.stdin)["result"]["panes"]))')
    if grep -Fxq -- "$pane_id" <<<"$pane_ids"; then
      herdr pane close "$pane_id"
      rm -f -- "$state_file"
      exit 0
    fi
  fi
  rm -f -- "$state_file"
fi

split_result=$(herdr pane split "$caller_pane_id" --direction right --ratio 0.5 \
  --cwd "$(dirname -- "$file_path")" --no-focus)
pane_id=$(python3 -c 'import json, sys; print(json.load(sys.stdin).get("result", {}).get("pane", {}).get("pane_id", ""))' \
  <<<"$split_result")
if [[ ! "$pane_id" =~ ^w[[:alnum:]_-]+:p[[:alnum:]_-]+$ ]]; then
  printf 'Could not identify the Herdr pane created for Markdown preview.\n' >&2
  exit 1
fi

printf -v quoted_file '%q' "$file_path"
if ! herdr pane run "$pane_id" "markdown-reader $quoted_file"; then
  herdr pane close "$pane_id" || printf 'Could not close the failed Markdown preview pane %s.\n' "$pane_id" >&2
  exit 1
fi

umask 077
printf '%s\n' "$pane_id" > "$state_file"
