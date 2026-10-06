# Phase Implementation Loop

A Codex plugin with two execution modes:

- `$phase-implementation-loop`: phase-gated execution with approval before each
  commit.
- `$phase-implementation-autopilot`: bounded continuous execution with automatic
  commits for green phases and strict operator stop gates.

Both use one shared protocol and support configurable Codex, Cursor, and Claude
roles. The invoking agent orchestrates; a separate edit-capable agent implements.

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
skill instructions. No Bash-only setup script is required. The shared protocol
covers command discovery and shell adaptation on macOS, Linux, PowerShell, and
`cmd.exe`.

## What It Does

- Reconciles markdown plans and Linear issues into a canonical markdown phase
  plan before implementation starts.
- Assesses every phase as TINY, ROUTINE, or COMPLEX against THIN, ADEQUATE, or
  DETAILED plan detail, then recommends either more detail or the least expensive
  capable implementer.
- Delegates planning and replanning to Codex GPT-6 Astra at high reasoning, with
  Claude Opus 5.5 as the fallback, while the orchestrator retains plan ownership.
- Lets the invoking orchestrator recommend or confirm an execution profile for
  Codex, Cursor, and Claude roles.
- Keeps Codex implementation separate from orchestration: a selected Codex
  implementer always runs as an edit-capable worker sub-agent.
- Runs phase by phase with planning, implementation, verification, phase reports,
  approval gates, commits, and durable handoffs.
- Keeps prerequisites tied to delivery criteria, reuses still-valid evidence,
  permits direct factual bookkeeping, and checks drift without routine extra
  planner calls, artifacts, or approval cycles.
- Monitors context at existing checkpoints and, with approved rollover authority,
  transfers to a fresh primary orchestrator using a compact handoff while
  preserving workspace identity, evidence, and pending gates.
- Offers an explicit autopilot variant that freezes the approved scope, commits
  each green phase, continues without routine approval pauses, and stops on
  ambiguity, insufficient verification, or high-risk actions.
- Defaults implementation to a separate Codex Luna 6 Max worker, with Cursor
  Grok 4.7 as the first fallback and task-appropriate model/effort selection if
  both are unavailable. Capability assessment still preserves phase requirements.
- Delegates UI/UX browser review to a fresh non-editing Codex Luna 6 Max reviewer.
- Uses Claude Opus 5.5 as the preferred external verifier, fresh Codex Astra High
  as the first fallback, and Cursor GLM 5.3 High as the second fallback.
- Keeps wrappers transport-focused: agent policies, prompts, defaults, and
  fallbacks live in the skill references. Optional hardened macOS/zsh Cursor
  wrappers live under `scripts/cursor-bridge/`.
- Packages both execution modes together; autopilot intentionally reuses the
  gated skill's shared protocol and agent references.

## Structure

```text
.agents/plugins/marketplace.json
plugins/phase-implementation-loop/
  .codex-plugin/plugin.json
  skills/phase-implementation-loop/
    SKILL.md
    references/
      shared-protocol.md
      phase-capability.md
      delivery-policy-scenarios.md
      context-rollover.md
      delegated-jobs.md
      agent-prompts.md
      agent-codex.md
      agent-cursor.md
      agent-claude.md
  skills/phase-implementation-autopilot/
    SKILL.md
    agents/openai.yaml
scripts/
  cursor-bridge/
    bin/
    tests/
```
