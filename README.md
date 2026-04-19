# webship-js AI Agent

AI coding-assistant agent specialized in automated website testing with
[webship-js](https://webship.co/docs/webship-js/2.0.x) (Playwright +
Cucumber-js).

Works with **Claude Code**, **GitHub Copilot**, **Gemini CLI**, and
**Codex CLI**.

## What it does

- **Scaffolds** webship-js projects from scratch (Node.js) or into a DDEV
  project via the [`ddev-webship-js`](https://github.com/webship/ddev-webship-js)
  add-on.
- **Writes** BDD `.feature` files (Gherkin) for any page, with desktop +
  mobile scenarios and tag filters.
- **Registers** named CSS / XPath selectors and uses the viewport
  breakpoint registry (`xs` … `xxxl`).
- **Authors** custom Cucumber step definitions when built-in steps aren't
  enough.
- **Runs** the suite (`npm test`, per-browser, tag-filtered) and interprets
  failures — AJAX timing, rate limiting, selector issues, auto-dismiss.
- **Generates** the HTML test report and summarizes pass/fail with root
  cause + suggested fixes.

## Install

Clone once, then run the installer for whichever assistant(s) you use.
Each installer takes an optional `--project /path` (default: install
globally to your home directory).

```bash
git clone https://github.com/webship/webship-js-ai-agent.git
cd webship-js-ai-agent
```

| Assistant         | Per-assistant installer                                    | Global target                          | Project target                     |
|-------------------|------------------------------------------------------------|----------------------------------------|------------------------------------|
| Claude Code       | `bash install-claude.sh [--project P]`                     | `~/.claude/agents/`                    | `<P>/.claude/agents/`              |
| GitHub Copilot    | `bash install-copilot.sh [--project P]`                    | `~/.config/github-copilot/`            | `<P>/.github/`                     |
| Gemini CLI        | `bash install-gemini.sh [--project P]`                     | `~/.gemini/`                           | `<P>/.gemini/`                     |
| Codex CLI         | `bash install-codex.sh [--project P]`                      | `$HOME/AGENTS.md` + `~/.codex/prompts/`| `<P>/AGENTS.md` + `<P>/.codex/prompts/` |

### Examples

```bash
# Claude Code, globally
bash install-claude.sh

# Copilot, into a specific project
bash install-copilot.sh --project /path/to/proj

# Gemini CLI, globally
bash install-gemini.sh

# Codex CLI, into a specific project
bash install-codex.sh --project /path/to/proj
```

### Install all at once

`install.sh` is a dispatcher — routes to any per-assistant installer or
runs them all:

```bash
bash install.sh                          # Claude Code (default), globally
bash install.sh --project /path          # Claude Code, project
bash install.sh --copilot --project /p   # Copilot only, project
bash install.sh --all                    # all four, globally
bash install.sh --all --project /path    # all four, project
```

### What gets written

Claude Code:
- `.claude/agents/agent-webship-js.md`

GitHub Copilot:
- `.github/copilot-instructions.md`
- `.github/chatmodes/webship-js.chatmode.md`

Gemini CLI:
- `.gemini/GEMINI.md`
- `.gemini/commands/webship-js/agent.toml` (invoke `/webship-js:agent`)

Codex CLI:
- `AGENTS.md` at the target root
- `.codex/prompts/webship-js-agent.md`

## Usage

### Claude Code

```
Use the agent-webship-js agent to set up webship-js for https://example.com
and create tests for the /contact page.
```

Or from a prompt:

```
@agent-webship-js test the login page end to end, desktop + mobile.
```

### Copilot

In Copilot Chat, pick the **webship-js** chat mode:

```
@webship-js scaffold a project for https://example.com
@webship-js write tests for /contact
@webship-js run the suite and report failures
```

### Gemini

```
/webship-js:agent scaffold a project for https://example.com
/webship-js:agent write tests for /contact
```

### Codex

```bash
codex "use webship-js agent to scaffold and test https://example.com"
```

## Example workflow

1. **Scaffold.** Agent runs `npm install --no-save webship-js` +
   `npx init-webship-js` (or `ddev add-on get webship/ddev-webship-js`).
2. **Explore.** Agent fetches the target page, identifies forms, links,
   landmarks.
3. **Author.** Agent writes `tests/features/<page>--<category>.feature`
   with desktop + mobile scenarios.
4. **Run.** Agent runs `npm run test:chromium` or
   `ddev npm run test:chromium`.
5. **Report.** Agent produces `tests/reports/cucumber_report.html` and
   summarizes failures with root cause + fix.

## Requirements

- Node.js >= 20.0 (webship-js `engines`).
- One of: Claude Code, GitHub Copilot, Gemini CLI, or Codex CLI.
- Optional: DDEV for containerized projects (add-on handles Playwright
  browsers).

## webship-js version

Targets **webship-js 2.0.x**. See
[webship-js docs](https://webship.co/docs/webship-js/2.0.x) for the full
step reference. The agent loads
`node_modules/webship-js/tests/step-definitions/*.js` as source of truth
when available.

## Related

- [webship-js](https://github.com/webship/webship-js) — core library.
- [ddev-webship-js](https://github.com/webship/ddev-webship-js) — DDEV add-on.
- [webship-js-skills](https://github.com/webship/webship-js-skills) — slash-command
  skills (init / create / run / steps) for the same set of assistants.

## License

MIT
