# Phase Implementation Loop

A Codex plugin that adds the `$phase-implementation-loop` skill: a phase-gated
implementation workflow with configurable Codex, Cursor, and Claude roles for
planning, implementation, and verification.

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
scripts/
  cursor-bridge/
    bin/
    tests/
```
