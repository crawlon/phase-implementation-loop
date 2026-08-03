# Cursor Agent Reference

Use this reference when Cursor is selected for planning, implementation, review,
verification, exploration, or orchestration.

## Transport And Models

Preferred thin wrappers:

- Planning: `codex-cursor-plan`
- Ask/review/verification: `codex-cursor-ask`
- Implementation: `codex-cursor-impl`

Pass the selected model per call with `--model`. Wrappers may also honor
`CODEX_CURSOR_MODEL`, but per-call selection wins. Current configured routes are:

- `composer-2.5-fast`: routine implementation
- `cursor-grok-4.5-high`: complex implementation
- `glm-5.2-high`: verification fallback after Claude

Treat model ids as configured defaults, not permanent inventory. Check
`cursor-agent models` when a configured id fails or the user changes available
models. The orchestrator chooses from the phase brief under `shared-protocol.md`;
do not ask Cursor to choose or run comparison prompts.

Examples:

```text
codex-cursor-plan --model composer-2.5-fast "..."
codex-cursor-impl --model composer-2.5-fast "..."
codex-cursor-impl --model cursor-grok-4.5-high "..."
codex-cursor-ask --model glm-5.2-high "..."
```

If wrappers are unavailable but `cursor-agent` exists, use non-interactive
`--print --output-format json` with the selected `--mode`, `--model`, and target
`--workspace`. Adapt quoting/current-directory syntax to the active shell.

Wrappers are transport only. Apply terminal and retry classification from
`delegated-jobs.md`. On ambiguous implementation failure, inspect the workspace
before retry or fallback because files may already have changed.

## Capabilities And Prompts

Use `agent-prompts.md` for the selected role. Cursor implementation must use an
edit-capable surface such as `codex-cursor-impl`; ask/plan output is guidance for
the selected implementation agent, not code for the orchestrator to apply.

Use GLM verification only after documented Claude terminal failure,
unavailability, or `INCONCLUSIVE`, or when the user explicitly selects it. Never
use GLM to overrule a Claude `BLOCKED` finding.

## Cursor Goal State

When Cursor orchestrates and its surface supports persistent goals, use `/mål`
or `/goal` as reinforcement:

```text
/goal Execute the canonical phase plan using the active gated or autopilot mode.
Keep orchestration separate from implementation and stop at that mode's gates.
```

Refresh the goal at phase boundaries with objective, acceptance criteria,
out-of-scope items, and stop conditions. Always include the same information in
ordinary prompts because non-interactive Cursor calls may not retain slash-command
state.
