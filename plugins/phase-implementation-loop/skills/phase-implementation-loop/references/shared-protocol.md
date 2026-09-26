# Shared Phase Protocol

Both phase skills use this protocol. The invoking agent is the orchestrator,
regardless of provider or model. The mode skill decides whether a green phase
waits for approval or commits and continues automatically.

## Role Contract

The orchestrator owns plan reconciliation, routing, supervision, diff inspection,
tests, verification gates, commits, and reporting. It does not implement code.
Delegate every workspace edit to a selected edit-capable implementation agent.

The invoking surface qualifies as orchestrator only when it can inspect the
workspace/diff, run required checks, supervise delegated jobs, and enforce the
active mode's git gates. Otherwise stop before Phase 1 and hand off to a capable
orchestrator.

The orchestrator owns the canonical plan and decisions but preferably does not
perform planning or replanning analysis itself. Delegate that analysis under the
Planning And Replanning section below.

Codex implementation always runs as a separate worker subagent. It must never be
the orchestrator's current context or a user-owned task/thread created as a
substitute for a worker. Agent output is advisory until the orchestrator inspects
the actual workspace and evidence.

Implementation and verification are separate roles. A verifier must not have
implemented the phase. Do not ask delegated agents to commit, push, deploy,
handle secrets or credentials, approve prompts, or perform destructive or live
actions.

For a UI-affecting phase, UI/UX review is a separate non-editing role. Its
findings return to an edit-capable implementation worker; the orchestrator
inspects the follow-up diff and evidence before deciding GREEN.

## Canonical Plan And Linear

Accept a markdown plan, chat plan, Linear issue list, one Linear parent with
sub-issues, or mixed sources. Before Phase 1, reconcile them into one canonical
markdown plan containing:

- ordered phase number and title
- source file heading and linked issue/sub-issue ids
- objective and checkable acceptance criteria
- dependencies and ordering constraints
- likely verification
- blockers, deferrals, and out-of-scope items

If only Linear exists, create the local markdown plan from the issues. If a
canonical plan has no linked Linear coverage, prepare an exact create/update
mapping that gives every planned phase its intended issue or sub-issue, ordered
dependencies, objective, acceptance criteria, and known blockers or deferrals.
Treat that mapping as a required startup artifact, not an optional follow-up.
Creating or materially updating tracker state still requires explicit user
authority: ask in gated mode or include it in the autopilot startup envelope.
Once that authority exists, apply the mapping, record the created issue ids in
the canonical plan, and re-read both sources after mutation.

100% synchronization is complete only when every planned phase maps to the intended
issue, every relevant issue appears in markdown, order and dependencies agree,
objectives and acceptance criteria do not conflict, and blockers/deferrals exist
in both places. Do not start Phase 1 with a known synchronization gap.

Use explicit user instructions first, then the most specific phase source, then
the broader plan. Ask when a conflict changes scope, behavior, risk, or order.
Otherwise preserve source ids and state the ordering rule used. Do not close
issues or change status, ownership, or priority without explicit authority or a
separately established tracker policy.

## Execution Profile

Before Phase 1, read `phase-capability.md` and run its phase capability
assessment across the canonical plan. Use the user's stated roles, models, and
effort only where they are compatible with that assessment. Otherwise make a
compact recommendation and obtain the approval required by the active mode. The
profile records:

- orchestrator
- planning/replanning route and fallback
- per-phase complexity, plan detail, implementation route, and required action
- implementation fallback
- UI/UX review route when any phase is UI-affecting
- verifier chain
- selected models and reasoning/effort when configurable
- one-line routing rationale

Check only capabilities needed by the proposed profile. Use `command -v` on
macOS/Linux, `Get-Command` in PowerShell, or `where` in Windows cmd. Wrappers are
transport only; role and safety policy belongs in prompts and these references.

After the assessment identifies the required capability tier, map it to the
available implementation routes using phase facts already gathered:

1. **Simple:** use a fast capable Codex worker subagent or the user's basic
   implementer for a TINY or sufficiently detailed low-risk phase.
2. **Routine:** use Cursor Composer 2.5 (`composer-2.5-fast`) for
   bounded implementation with clear requirements and local patterns.
3. **Strong:** use Cursor Grok 4.6 High Fast
   (`cursor-grok-4.6-high-fast`) for ambiguous root cause, cross-package
   behavior, migration/schema/public contract, concurrency, auth/security,
   production-data risk, or likely multi-iteration exploration.

Do not call a model to choose the route or compare multiple implementers. Do not
silently run a basic implementer where `phase-capability.md` requires a routine
or strong route. If the selected route is unavailable, use another edit-capable
implementation agent at the same required capability tier and retain the same
phase brief. For a Codex fallback, select model and reasoning from complexity
using `agent-codex.md`. If no separate edit-capable implementer is available,
stop for operator guidance; the orchestrator does not take over.

Read only the selected agent references:

- `agent-codex.md`
- `agent-cursor.md`
- `agent-claude.md`
- `agent-prompts.md` when constructing a delegated prompt

## Planning And Replanning

When startup, a capability assessment, new repository evidence, verifier
findings, or a repair cycle requires planning or replanning, delegate one bounded
read-only planning job. The default route is a fresh Codex subagent using
`gpt-6-astra` at high reasoning. If that route terminates unsuccessfully or is
unavailable, use Claude Opus 5.5 through `codex-claude-ask --model
claude-opus-5-5`. Use the Planning prompt in `agent-prompts.md` for either route.

The planner may inspect the plan and repository evidence but must not edit the
workspace, mutate Linear, commit, push, deploy, or decide unresolved product
questions. The orchestrator reviews the advice, presents decisions to the user
when needed, and alone reconciles the approved result into the canonical plan,
Linear mapping, capability assessment, and durable state.

Do not call both planners for routine comparison. Use Opus 5.5 only after a
terminal Astra failure/unavailability or explicit user selection. If both routes
are unavailable, the orchestrator may plan directly only as a disclosed degraded
fallback; record the reason, keep the task bounded, and do not bypass user or
tracker authority.

## UI/UX Review Gate

Classify each phase as UI-affecting when it changes a user-visible screen,
interaction, responsive layout, navigation, or user-facing information flow or
copy. For every UI-affecting phase, after functional checks and before the
independent verifier, delegate a fresh non-editing Codex UI/UX review subagent.
Unless the user selects another route, use `gpt-5.6-luna` at maximum reasoning.
Read `agent-codex.md` and the UI/UX Review prompt in `agent-prompts.md`, then
give the reviewer the phase brief and current-worktree target. The reviewer
starts the relevant app, opens the target route in the in-app Browser, proves it
serves the phase diff, and follows `$ui-ux-browser-review`. Record its model,
effort, target, proof, coverage, findings, limitations, and outcome in durable
state. Return actionable findings to an edit-capable implementation worker, then
rerun affected checks and the UI/UX review before the independent verifier.

For a non-UI phase, record `UI/UX review: N/A` with the reason. A UI-affecting
phase cannot be GREEN without that review, or an explicit user waiver when the
required browser evidence cannot be obtained. A waiver must state the untested
scope and resulting risk; it is not implied by passing functional tests.

## Common Phase State Machine

For each phase:

1. Reconfirm the approved capability assessment, then write a phase brief with
   objective, scope, likely files, constraints, acceptance checks, risks, and
   stop conditions. Resolve any required `add plan detail` or `use stronger
   implementer` action before delegation.
2. When bounded planning or replanning would reduce implementation risk,
   delegate it under Planning And Replanning above and reconcile the approved
   result before implementation.
3. Select and record the implementation route, model, and reasoning/effort.
4. Delegate the bounded edit task with Ponytail/minimal-diff and drive it to a
   terminal result under `delegated-jobs.md`.
5. Inspect `git status --short` and the actual diff. Confirm every changed path
   belongs to the phase and no unrelated work was overwritten.
6. Run the smallest relevant verification, then broaden according to risk and
   repository norms.
7. For a UI-affecting phase, complete the UI/UX Review Gate above. For a non-UI
   phase, record its N/A decision.
8. Run the verifier chain in `delegated-jobs.md`. Return concrete findings to the
   selected implementer or another edit-capable worker, then repeat affected
   tests and verification.
9. If a repair exposes interpretation drift or capability mismatch, reassess
   plan detail and implementation strength before another attempt. After two
   materially similar red repair cycles without new evidence or a distinct fix,
   stop with the exact blocker or decision needed.
10. Update durable state before the mode-specific commit/continuation gate.

A phase is GREEN only when its acceptance criteria are met, the orchestrator has
inspected the diff, relevant tests pass or have an explicit approved waiver, the
verifier reports no unresolved blocker at confidence appropriate to the risk, no
unrelated change is staged, no delegated job remains in flight, and durable state
can reconstruct the result. The chosen implementation route must remain
compatible with the approved capability assessment. A UI-affecting phase
additionally requires a completed UI/UX review or explicit user waiver.

## Shared Fallback And Stop Rules

- Planning unavailable: try Astra High, then Opus 5.5. The orchestrator may plan
  directly only after both are unavailable, with the degradation recorded.
- Implementation unavailable: choose another edit-capable agent; never collapse
  implementation into orchestration.
- Verification unavailable: follow `delegated-jobs.md` and disclose degradation.
- Do not repeat the same failed command, prompt, provider call, or repair without
  new information.
- Stop for material scope/architecture decisions, unavailable important tests,
  conflicting high-risk findings, uncertain workspace ownership, destructive or
  live actions, secrets/credentials, deploy/release/push authority, or exhausted
  fallbacks.

Durable state records phase status, branch, changed files, planning/replanning
route and result, capability assessment, approved plan-detail/implementer
decision, implementation route and model, verification commands/results, UI/UX
review result or N/A decision, verifier tier/model/verdict, commit when
available, blockers, deferrals, next phase, and exact user decisions.
