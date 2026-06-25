# Phase Implementation Loop

A Codex plugin that adds the `$phase-implementation-loop` skill: a phase-gated
implementation workflow with configurable Codex, Cursor, and Claude roles for
planning, implementation, and verification.

## Install

Add this repository as a Codex plugin marketplace:

```bash
codex plugin marketplace add crawlon/phase-implementation-loop --sparse .agents/plugins
```

Then restart Codex and install **Phase Implementation Loop** from the plugin
directory.

## What It Does

- Reconciles markdown plans and Linear issues into a canonical markdown phase
  plan before implementation starts.
- Lets the main Codex agent recommend or confirm an execution profile for Codex,
  Cursor, and Claude roles.
- Runs phase by phase with planning, implementation, verification, phase reports,
  approval gates, commits, and durable handoffs.
- Keeps wrappers thin: agent policies, prompts, defaults, and fallbacks live in
  the skill references.

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
```
