# Codex Agent Reference

Use this reference when Codex is selected for planning, implementation, UI/UX
review, or the first verification fallback. The phase-loop orchestrator may be
any agent.

## Roles

- Substantive planning and replanning: use a fresh, read-only Codex planning
  subagent by default under `shared-protocol.md`. Routine reconciliation,
  factual bookkeeping, and drift checks remain direct orchestrator work.
- Implementation: always use a separate edit-capable Codex worker subagent. The
  orchestrator never implements or applies a returned patch.
- UI/UX review: use a fresh, non-editing Codex reviewer subagent to run
  `$ui-ux-browser-review` for UI-affecting phases. Return findings to the
  implementation worker; the reviewer never edits the workspace.
- Verification: after Claude is unavailable or inconclusive, use a fresh
  read-only `gpt-6-astra` verifier at high reasoning that did not implement the
  phase. Cursor GLM 5.3 High is the next fallback under `delegated-jobs.md`.

## Worker Launch Contract

A Codex implementation worker qualifies only when all are true:

- it is launched through the active surface's native worker/subagent mechanism
- it has a fresh execution context distinct from the orchestrator
- it is not a user-owned task, thread, or chat created as a worker substitute
- it has explicit edit capability in the intended repository/worktree
- it receives a bounded phase brief and the implementation prompt contract
- its handle/session, model, reasoning level, and terminal result are recorded

If the surface cannot satisfy every condition, select another edit-capable
implementation agent or stop. Never collapse the worker role into orchestration.

## Model And Reasoning

Choose locally from the phase brief; do not call another model to choose:

- Planning and replanning: use `gpt-6-astra` at high reasoning. If that route is
  unavailable, use the Claude Opus 5.5 fallback in `agent-claude.md`, then follow
  the shared degraded-planning and mode-specific stop rules if both fail.
- Implementation: default to a separate `gpt-6-luna` worker at `max` reasoning.
  Cursor Grok 4.7 is the first fallback under `shared-protocol.md`.
- Further implementation fallback: the orchestrator chooses an available model
  and reasoning level appropriate to the task, required capabilities, and risk.
  Do not automatically select the largest model or maximum reasoning.
- UI/UX review: default to a fresh `gpt-6-luna` reviewer at `max` reasoning.
  If unavailable, select an appropriate non-editing browser-capable reviewer
  and record the fallback.
- Verification: use a fresh `gpt-6-astra` verifier at high reasoning after the
  primary Claude route is unavailable or inconclusive.

Check the selected model and reasoning against the active worker surface. If
they are unavailable or not configurable, follow the role's fallback rules and
disclose the limitation rather than claiming the requested model ran.
Keep the choice stable unless scope, risk, or provider availability changes.
Record model, reasoning, and one-line rationale in durable state.

## Prompts

Use `agent-prompts.md` and add the role-specific first line:

- Planning: `Act as the dedicated read-only Codex planning subagent; the orchestrator owns the canonical plan.`
- Implementation: `Act as the separate Codex worker subagent; you are not the orchestrator.`
- UI/UX review: `Act as the dedicated non-editing Codex UI/UX review subagent.`
- Verification: `Act as the fresh read-only Codex verifier; you did not implement this phase.`

For implementation, include selected model/reasoning and require workspace edits,
not a patch for the orchestrator to apply. For verification, use `gpt-6-astra`
with high reasoning. Start from fresh context; omit implementer reasoning and
any desired verdict. Disable unrelated connectors/configuration when supported
and record the isolation used.

A Codex verifier `PASS` has degraded cross-provider independence. Apply the
critical-work limits in `delegated-jobs.md`; orchestrator self-review is never an
independent tier.
