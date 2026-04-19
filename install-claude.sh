#!/bin/bash
# Install webship-js AI agent for Claude Code.
#
# Usage:
#   bash install-claude.sh                    # global:  ~/.claude/agents/
#   bash install-claude.sh --project /path    # project: <path>/.claude/agents/

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AGENT_FILE="$SCRIPT_DIR/.claude/agents/agent-webship-js.md"

if [ ! -f "$AGENT_FILE" ]; then
  echo "Error: agent file not found at $AGENT_FILE" >&2
  exit 1
fi

PROJECT=""
while [ $# -gt 0 ]; do
  case "$1" in
    --global)  PROJECT="" ;;
    --project) PROJECT="$2"; shift ;;
    -h|--help)
      sed -n '2,6p' "$0" | sed 's/^# //;s/^#//'
      exit 0 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
  shift
done

if [ -n "$PROJECT" ]; then
  target="$PROJECT/.claude/agents"
else
  target="$HOME/.claude/agents"
fi

mkdir -p "$target"
cp "$AGENT_FILE" "$target/agent-webship-js.md"
echo "[claude] installed to $target/agent-webship-js.md"
