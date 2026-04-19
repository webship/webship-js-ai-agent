#!/bin/bash
# Install webship-js AI agent for GitHub Copilot.
#
# Writes:
#   <target>/copilot-instructions.md
#   <target>/chatmodes/webship-js.chatmode.md
#
# Usage:
#   bash install-copilot.sh                    # global:  ~/.config/github-copilot/
#   bash install-copilot.sh --project /path    # project: <path>/.github/

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
  target="$PROJECT/.github"
else
  target="$HOME/.config/github-copilot"
fi
mkdir -p "$target/chatmodes"

strip_frontmatter() {
  awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' "$1"
}

cat > "$target/copilot-instructions.md" <<'EOF'
# Copilot instructions — webship-js agent

This project uses [webship-js 2.0.x](https://webship.co/docs/webship-js/2.0.x)
(Playwright + Cucumber-js).

When testing tasks come up, use the `webship-js` chat mode defined in
`.github/chatmodes/webship-js.chatmode.md`.

Source of truth for step definitions:
`node_modules/webship-js/tests/step-definitions/*.js` or
https://github.com/webship/webship-js/tree/2.0.x.

Critical rules:
1. After `When I press "Submit"` chain `And I wait for AJAX to finish`.
2. For `href`/`src` use the link-by-attribute form, not `response should contain`.
3. DDEV projects run tests via `ddev npm run test:*`, not host `npm`.
4. `npx init-webship-js` is idempotent — preserve user files.
EOF

{
  printf -- '---\n'
  printf 'description: "webship-js testing agent — scaffold, author, run, analyze"\n'
  printf 'tools: ["codebase","terminal","edit","search","fetch"]\n'
  printf -- '---\n\n'
  strip_frontmatter "$AGENT_FILE"
} > "$target/chatmodes/webship-js.chatmode.md"

echo "[copilot] instructions -> $target/copilot-instructions.md"
echo "[copilot] chat mode    -> $target/chatmodes/webship-js.chatmode.md"
