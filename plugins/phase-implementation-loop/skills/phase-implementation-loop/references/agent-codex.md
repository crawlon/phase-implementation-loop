# Codex Agent Reference

Use this reference when Codex is selected for planning, implementation, or the
last verification fallback. The phase-loop orchestrator may be any agent.

## Roles

- Planning: the orchestrator may plan directly. Use a separate Codex planning
  subagent only when bounded exploration saves context.
- Implementation: always use a separate edit-capable Codex worker subagent. The
  orchestrator never implements or applies a returned patch.
- Verification: after Claude and GLM are unavailable or inconclusive, use a fresh
  read-only Codex verifier subagent that did not implement the phase.

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

- Tiny: use the surfaced default or fastest capable Codex coding model at medium
  reasoning.
- Routine/moderate fallback: use a strong available Codex coding model at high
  reasoning.
- Complex/high-risk fallback: use the strongest suitable available Codex coding
  model at high or maximum supported reasoning.

Prefer explicit capability labels exposed by the subagent surface. If models are
not ranked or configurable, use the surfaced default and disclose the limitation.
Keep the choice stable unless scope, risk, or provider availability changes.
Record model, reasoning, and one-line rationale in durable state.

## Prompts

Use `agent-prompts.md` and add the role-specific first line:

- Planning: `Act as a bounded Codex planning subagent.`
- Implementation: `Act as the separate Codex worker subagent; you are not the orchestrator.`
- Verification: `Act as the fresh last-resort Codex verifier; you did not implement this phase.`

For implementation, include selected model/reasoning and require workspace edits,
not a patch for the orchestrator to apply. For verification, prefer
`gpt-5.6-terra` with high reasoning when exposed, or a comparable strong Codex
model. Start from fresh context; omit implementer reasoning and any desired
verdict. Disable unrelated connectors/configuration when supported and record
the isolation used.

A Codex verifier `PASS` has degraded cross-provider independence. Apply the
critical-work limits in `delegated-jobs.md`; orchestrator self-review is never an
independent tier.
