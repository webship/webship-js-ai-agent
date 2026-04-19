#!/bin/bash
# Install webship-js AI agent for Gemini CLI.
#
# Writes:
#   <target>/GEMINI.md
#   <target>/commands/webship-js/agent.toml       (invoke: /webship-js:agent)
#
# Usage:
#   bash install-gemini.sh                    # global:  ~/.gemini/
#   bash install-gemini.sh --project /path    # project: <path>/.gemini/

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
      sed -n '2,10p' "$0" | sed 's/^# //;s/^#//'
      exit 0 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
  shift
done

if [ -n "$PROJECT" ]; then
  target="$PROJECT/.gemini"
else
  target="$HOME/.gemini"
fi
mkdir -p "$target/commands/webship-js"

strip_frontmatter() {
  awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' "$1"
}

cat > "$target/GEMINI.md" <<'EOF'
# Gemini context — webship-js agent

This project uses webship-js 2.0.x (Playwright + Cucumber-js). The
`/webship-js:agent` command activates a specialized automated-testing agent.

Authoritative step source: `node_modules/webship-js/tests/step-definitions/*.js`
or the 2.0.x branch at https://github.com/webship/webship-js.

Always wait after submits (`And I wait for AJAX to finish`). Use the
link-by-attribute form for href/src assertions.
EOF

{
  printf 'description = "webship-js automated testing agent"\n'
  printf 'prompt = """\n'
  strip_frontmatter "$AGENT_FILE"
  printf '\n"""\n'
} > "$target/commands/webship-js/agent.toml"

echo "[gemini] context -> $target/GEMINI.md"
echo "[gemini] command -> $target/commands/webship-js/agent.toml"
