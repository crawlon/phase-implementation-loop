# Codex Agent Reference

Use this reference when Codex is selected for research, planning, implementation,
UI/UX review or verification. The phase-loop orchestrator may be
any agent.

## Roles

- Bounded research: use a fresh read-only researcher under the shared protocol;
  return source-linked findings, drafts and uncertainty to the commissioning role.
- Substantive planning and replanning: use a fresh, read-only Codex planning
  subagent by default under `shared-protocol.md`. Routine reconciliation,
  factual bookkeeping, and drift checks remain direct orchestrator work.
- Implementation: always use a separate edit-capable Codex worker subagent. The
  orchestrator never implements or applies a returned patch.
- UI/UX review: use a fresh, non-editing Codex reviewer subagent to run
  `$ui-ux-browser-review` for UI-affecting phases. Return findings to the
  implementation worker; the reviewer never edits the workspace.
- Verification: use a fresh read-only verifier that did not implement the phase, following the selected
  chain in `delegated-jobs.md`.

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

Use the shared [role profiles](shared-protocol.md#role-profiles) with the approved
brief. Read only the relevant shared protocol section for research, implementation,
standalone planning or UI review; verification uses `delegated-jobs.md`. Managed
plan adoption uses the owner route; supporting delegation follows each role's
responsibility in the trial agreement. Do not call another model to choose.

Check the selected model and reasoning against the active worker surface. If
they are unavailable or not configurable, follow the role's fallback rules and
disclose the limitation rather than claiming the requested model ran.
Keep the choice stable unless scope, risk, or provider availability changes.
Record model, reasoning, and one-line rationale in durable state.

## Prompts

Use `agent-prompts.md` and add the role-specific first line:

- Research: `Act as the bounded read-only researcher; return evidence and uncertainty, not plan decisions or acceptance.`
- Planning: `Act as a bounded read-only planning-support subagent; return proposals to the commissioning role and preserve the designated canonical writer.`
- Implementation: `Act as the separate Codex worker subagent; you are not the orchestrator.`
- UI/UX review: `Act as the dedicated non-editing Codex UI/UX review subagent.`
- Verification: `Act as the fresh read-only Codex verifier; you did not implement this phase.`

For implementation, include selected model/reasoning and require workspace edits,
not a patch for the orchestrator to apply. For verification, carry the selected
model/effort into a fresh context; omit implementer reasoning and
any desired verdict. Disable unrelated connectors/configuration when supported
and record the isolation used.

A Codex verifier `PASS` has degraded cross-provider independence. Apply the
critical-work limits in `delegated-jobs.md`; orchestrator self-review is never an
independent tier.
