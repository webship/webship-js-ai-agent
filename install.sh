#!/bin/bash
# Install the webship-js AI agent for one or all AI coding assistants.
#
# Delegates to per-assistant installers:
#   install-claude.sh   — Claude Code
#   install-copilot.sh  — GitHub Copilot
#   install-gemini.sh   — Gemini CLI
#   install-codex.sh    — Codex CLI
#
# Usage:
#   bash install.sh                          # Claude Code, globally (default)
#   bash install.sh --project /path          # Claude Code, project-scoped
#   bash install.sh --copilot [--project P]  # GitHub Copilot
#   bash install.sh --gemini  [--project P]  # Gemini CLI
#   bash install.sh --codex   [--project P]  # Codex CLI
#   bash install.sh --all     [--project P]  # all four

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

MODE=claude
PROJECT_ARGS=()
while [ $# -gt 0 ]; do
  case "$1" in
    --claude)  MODE=claude ;;
    --copilot) MODE=copilot ;;
    --gemini)  MODE=gemini ;;
    --codex)   MODE=codex ;;
    --all)     MODE=all ;;
    --global)  PROJECT_ARGS=() ;;
    --project) PROJECT_ARGS=(--project "$2"); shift ;;
    -h|--help)
      sed -n '2,18p' "$0" | sed 's/^# //;s/^#//'
      exit 0 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
  shift
done

run() {
  bash "$SCRIPT_DIR/install-$1.sh" "${PROJECT_ARGS[@]}"
}

case "$MODE" in
  claude)  run claude ;;
  copilot) run copilot ;;
  gemini)  run gemini ;;
  codex)   run codex ;;
  all)
    run claude
    run copilot
    run gemini
    run codex
    ;;
esac

echo ""
echo "Done. The webship-js AI agent is installed."
