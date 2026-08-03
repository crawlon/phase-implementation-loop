# Phase Implementation Loop

A Codex plugin with two execution modes:

- `$phase-implementation-loop`: phase-gated execution with approval before each
  commit.
- `$phase-implementation-autopilot`: bounded continuous execution with automatic
  commits for green phases and strict operator stop gates.

Both support configurable Codex, Cursor, and Claude roles for planning,
implementation, and verification.

## Install

Prerequisites:

- Codex installed and available as `codex` on `PATH`.
- Git available in repositories where the phase loop should create branches or
  commits.
- Optional peer agents installed and authenticated only where you want to use
  them: Cursor Agent as `cursor-agent` and Claude Code as `claude`.

Add this repository as a Codex plugin marketplace. The command is the same from
macOS/Linux shells, Windows PowerShell, and Windows `cmd.exe` when `codex` is on
`PATH`:

```text
codex plugin marketplace add crawlon/phase-implementation-loop --sparse .agents/plugins
```

Then restart Codex and install **Phase Implementation Loop** from the plugin
directory.

## Cross-Platform Notes

The plugin is platform-neutral: it is a Codex plugin manifest plus Markdown
skill instructions. No Bash-only setup script is required. The skill references
include shell-specific examples for environment variables, current working
directory syntax, and command discovery on macOS, Linux, PowerShell, and
`cmd.exe`.

## What It Does

- Reconciles markdown plans and Linear issues into a canonical markdown phase
  plan before implementation starts.
- Lets the main Codex agent recommend or confirm an execution profile for Codex,
  Cursor, and Claude roles.
- Runs phase by phase with planning, implementation, verification, phase reports,
  approval gates, commits, and durable handoffs.
- Offers an explicit autopilot variant that freezes the approved scope, commits
  each green phase, continues without routine approval pauses, and stops on
  ambiguity, insufficient verification, or high-risk actions.
- Uses Claude Opus as the preferred external verifier, GLM 5.2 as fallback, and
  a fresh high-reasoning Codex sub-agent as the final verification fallback.
- Keeps wrappers transport-focused: agent policies, prompts, defaults, and
  fallbacks live in the skill references. Optional hardened macOS/zsh Cursor
  wrappers live under `scripts/cursor-bridge/`.

## Structure

```text
.agents/plugins/marketplace.json
plugins/phase-implementation-loop/
  .codex-plugin/plugin.json
  skills/phase-implementation-loop/
    SKILL.md
    references/
      agent-codex.md
      agent-cursor.md
      agent-claude.md
  skills/phase-implementation-autopilot/
    SKILL.md
    agents/openai.yaml
    references/
      agent-routing.md
scripts/
  cursor-bridge/
    bin/
    tests/
```
