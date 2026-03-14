#!/bin/bash
# Install webship-js AI Agent for Claude Code
# Usage: bash install.sh [--global|--project /path/to/project]

set -e

AGENT_FILE="$(dirname "$0")/.claude/agents/agent-webship-js.md"

if [ ! -f "$AGENT_FILE" ]; then
  echo "Error: Agent file not found at $AGENT_FILE"
  exit 1
fi

if [ "$1" = "--global" ] || [ -z "$1" ]; then
  TARGET_DIR="$HOME/.claude/agents"
  mkdir -p "$TARGET_DIR"
  cp "$AGENT_FILE" "$TARGET_DIR/"
  echo "Installed agent-webship-js globally to $TARGET_DIR/"
elif [ "$1" = "--project" ] && [ -n "$2" ]; then
  TARGET_DIR="$2/.claude/agents"
  mkdir -p "$TARGET_DIR"
  cp "$AGENT_FILE" "$TARGET_DIR/"
  echo "Installed agent-webship-js to project $TARGET_DIR/"
else
  echo "Usage: bash install.sh [--global|--project /path/to/project]"
  exit 1
fi

echo "Done. The agent is now available in Claude Code."
