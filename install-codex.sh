#!/bin/bash
# Install webship-js AI agent for Codex CLI.
#
# Writes:
#   <root>/AGENTS.md
#   <root>/.codex/prompts/webship-js-agent.md
#
# Usage:
#   bash install-codex.sh                    # global:  $HOME/AGENTS.md + ~/.codex/prompts/
#   bash install-codex.sh --project /path    # project: <path>/AGENTS.md + <path>/.codex/prompts/

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
  root="$PROJECT"
  target_prompts="$PROJECT/.codex/prompts"
else
  root="$HOME"
  target_prompts="$HOME/.codex/prompts"
fi
mkdir -p "$target_prompts"

cat > "$root/AGENTS.md" <<'EOF'
# AGENTS.md — webship-js testing

This repository uses [webship-js 2.0.x](https://webship.co/docs/webship-js/2.0.x)
(Playwright + Cucumber-js).

## Primary agent

`.codex/prompts/webship-js-agent.md` — scaffolds projects, authors
`.feature` tests, runs the suite, and analyzes failures.

## Conventions

- Step-definition source of truth:
  `node_modules/webship-js/tests/step-definitions/*.js`. If missing, fetch
  from https://github.com/webship/webship-js/tree/2.0.x.
- Always chain `And I wait for AJAX to finish` after `When I press "Submit"`.
- For `href`/`src` assertions, use the link-by-attribute form, never
  `response should contain`.
- DDEV projects: run tests via `ddev npm run test:*` or `ddev exec`.
- `npx init-webship-js` is idempotent; preserve user files unless
  `--force` was explicitly requested.

## Commands

```bash
npm install --no-save webship-js
npx init-webship-js
npm test
BROWSER=firefox npm test
LAUNCH_URL=https://example.com npm test
npx cucumber-js --config cucumber.js tests/features/<file>.feature
npm run generate-reports
```

DDEV:

```bash
ddev add-on get webship/ddev-webship-js
ddev restart
ddev npm run test:chromium
```
EOF

cp "$AGENT_FILE" "$target_prompts/webship-js-agent.md"

echo "[codex] AGENTS.md -> $root/AGENTS.md"
echo "[codex] prompt   -> $target_prompts/webship-js-agent.md"
