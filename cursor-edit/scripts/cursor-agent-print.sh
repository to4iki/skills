#!/usr/bin/env bash
# cursor-agent-print.sh — cursor-edit skill wrapper.
# Runs cursor-agent in print mode and delegates file edits in the current directory.
#
# Usage:
#   cursor-agent-print.sh "<edit instruction>"
#
# Environment:
#   CURSOR_MODEL  Passed to cursor-agent --model (default: composer-2.5-fast)
set -euo pipefail

if [ "$#" -lt 1 ] || [ -z "${1:-}" ]; then
  echo 'usage: cursor-agent-print.sh "<edit instruction>"' >&2
  exit 2
fi

MODEL="${CURSOR_MODEL:-composer-2.5-fast}"

# -p              : non-interactive print mode
# --force         : apply file changes without confirmation
# --trust         : trust the workspace without prompting
# --output-format : return plain text
# cursor-agent reads and writes files relative to the current directory.
exec cursor-agent -p --force --trust --output-format text \
  --model "$MODEL" "$1"
