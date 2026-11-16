#!/bin/bash
# Install the book "Automated Functional Testing Recipes" next to the agent.
#
# The agent reads the book as its knowledge base (one file per
# chapter, named by its subject; it reads the chapter that matches the task). The per-assistant
# installers call this script; it copies automated-functional-testing-recipes/ to:
#
#   <root>/.claude/automated-functional-testing-recipes/
#
# where <root> is $HOME for a global install and the project path for a
# project install, so the same path works for every assistant.
#
# Usage:
#   bash install-book.sh                    # global:  ~/.claude/automated-functional-testing-recipes/
#   bash install-book.sh --project /path    # project: <path>/.claude/automated-functional-testing-recipes/

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BOOK_DIR="$SCRIPT_DIR/automated-functional-testing-recipes"

if [ ! -f "$BOOK_DIR/README.md" ]; then
  echo "Error: book not found at $BOOK_DIR" >&2
  exit 1
fi

PROJECT=""
while [ $# -gt 0 ]; do
  case "$1" in
    --global)  PROJECT="" ;;
    --project) PROJECT="$2"; shift ;;
    -h|--help)
      sed -n '2,14p' "$0" | sed 's/^# //;s/^#//'
      exit 0 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
  shift
done

if [ -n "$PROJECT" ]; then
  target="$PROJECT/.claude/automated-functional-testing-recipes"
else
  target="$HOME/.claude/automated-functional-testing-recipes"
fi

mkdir -p "$target"
cp "$BOOK_DIR"/*.md "$target/"
echo "[book]   installed to $target/ ($(ls "$target"/*.md | wc -l) files)"
