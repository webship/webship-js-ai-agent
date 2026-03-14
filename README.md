# webship-js AI Agent for Claude Code

A Claude Code custom agent specialized in automated website testing using
[webship-js](https://webship.co/docs/webship-js/2.0.x) (Playwright + Cucumber-js).

## What It Does

The `agent-webship-js` agent can:

- **Set up** webship-js test projects from scratch
- **Create** BDD feature files (Gherkin) for any website
- **Write** custom Cucumber step definitions
- **Run** test suites and interpret results
- **Debug** failing tests (AJAX timing, selectors, rate limiting)
- **Generate** HTML test reports

## Installation

### Quick Install

```bash
# Clone the repo
git clone https://github.com/webship/webship-js-ai-agent.git

# Copy agent to your Claude Code agents directory
cp webship-js-ai-agent/.claude/agents/agent-webship-js.md ~/.claude/agents/

# Or copy to a specific project
cp webship-js-ai-agent/.claude/agents/agent-webship-js.md /path/to/project/.claude/agents/
```

### Manual Install

Copy `.claude/agents/agent-webship-js.md` to either:
- `~/.claude/agents/` (available globally)
- `<project>/.claude/agents/` (available in specific project)

## Usage

In Claude Code, use the agent via the Agent tool:

```
Use the agent-webship-js agent to test https://example.com/contact
```

Or reference it in conversations:

```
@agent-webship-js Set up a test project for https://example.com and create
test cases for the login page.
```

## Example Workflow

1. **Setup**: Agent creates project, installs webship-js, configures cucumber.js
2. **Exploration**: Agent visits the target page, identifies testable elements
3. **Test Creation**: Agent writes `.feature` files for desktop + mobile
4. **Execution**: Agent runs tests, handles failures
5. **Reporting**: Agent generates HTML report

## Requirements

- [Claude Code](https://claude.com/claude-code) CLI
- Node.js >= 20.0
- npm

## webship-js Version

This agent is built for **webship-js 2.0**. See the
[webship-js documentation](https://webship.co/docs/webship-js/2.0.x) for details.

## License

MIT
