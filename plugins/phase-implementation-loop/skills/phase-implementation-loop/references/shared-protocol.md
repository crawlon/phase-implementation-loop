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

Codex implementation always runs as a separate worker subagent. It must never be
the orchestrator's current context or a user-owned task/thread created as a
substitute for a worker. Agent output is advisory until the orchestrator inspects
the actual workspace and evidence.

Implementation and verification are separate roles. A verifier must not have
implemented the phase. Do not ask delegated agents to commit, push, deploy,
handle secrets or credentials, approve prompts, or perform destructive or live
actions.

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

If only Linear exists, create the local markdown plan from the issues. If Linear
tracking is part of the workflow and issues are missing or stale, prepare the
exact create/update mapping first. Creating or materially updating tracker state
requires explicit user authority: ask in gated mode or include it in the
autopilot startup envelope. Re-read both sources after mutation.

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

Before Phase 1, use the user's stated roles, models, and effort. Otherwise make a
compact recommendation and obtain the approval required by the active mode. The
profile records:

- orchestrator
- implementation route and fallback
- verifier chain
- selected models and reasoning/effort when configurable
- one-line routing rationale

Check only capabilities needed by the proposed profile. Use `command -v` on
macOS/Linux, `Get-Command` in PowerShell, or `where` in Windows cmd. Wrappers are
transport only; role and safety policy belongs in prompts and these references.

When the user has not explicitly selected an implementation agent, apply routing
in this order using phase facts already gathered:

1. **Complex:** if any trigger applies, use Cursor Grok 4.6
   (`cursor-grok-4.6-high`): ambiguous root cause, cross-package behavior,
   migration/schema/public contract, concurrency, auth/security, production-data
   risk, or likely multi-iteration exploration.
2. **Tiny:** if every condition holds, use a Codex worker subagent: at most two
   files in one familiar module, clear acceptance check, established pattern,
   and none of the complex triggers.
3. **Routine:** otherwise use Cursor Composer 2.5 (`composer-2.5-fast`) for
   bounded implementation with clear requirements and local patterns.

Do not call a model to choose the route or compare multiple implementers. If the
selected route is unavailable, use another edit-capable implementation agent and
retain the same phase brief. For a Codex fallback, select model and reasoning
from complexity using `agent-codex.md`. If no separate edit-capable implementer
is available, stop for operator guidance; the orchestrator does not take over.

Read only the selected agent references:

- `agent-codex.md`
- `agent-cursor.md`
- `agent-claude.md`
- `agent-prompts.md` when constructing a delegated prompt

## Common Phase State Machine

For each phase:

1. Write a phase brief with objective, scope, likely files, constraints,
   acceptance checks, risks, and stop conditions.
2. Run bounded planning/exploration only when it reduces implementation risk.
3. Select and record the implementation route, model, and reasoning/effort.
4. Delegate the bounded edit task with Ponytail/minimal-diff and drive it to a
   terminal result under `delegated-jobs.md`.
5. Inspect `git status --short` and the actual diff. Confirm every changed path
   belongs to the phase and no unrelated work was overwritten.
6. Run the smallest relevant verification, then broaden according to risk and
   repository norms.
7. If the phase changes user-visible UI, start an app instance from the exact
   phase worktree, or reuse one only after proving that its process and displayed
   UI contain the current phase diff. Do not review a stale dev server, another
   worktree, an older build, or a deployed environment as evidence for the phase.
   Then run `$ui-ux-browser-review` after the implementation checks and before
   sending work to the verifier chain. The orchestrator records the app target,
   proof it contains the phase changes, tested routes, viewports, states,
   findings, and limitations, and returns any actionable finding to an
   edit-capable worker. Re-run affected checks and the UI review after the fix.
   A UI phase cannot be GREEN without this completed review or an explicit user
   waiver. For a non-UI phase, record `N/A` with the reason.
8. Run the verifier chain in `delegated-jobs.md` only after the UI review gate.
   Return concrete findings to the selected implementer or another edit-capable
   worker, then repeat affected tests, UI review where applicable, and
   verification.
9. After two materially similar red repair cycles without new evidence or a
   distinct fix, stop with the exact blocker or decision needed.
10. Update durable state before the mode-specific commit/continuation gate.

A phase is GREEN only when its acceptance criteria are met, the orchestrator has
inspected the diff, relevant tests pass or have an explicit approved waiver, UI
phases have a completed UI/UX browser review against a proven current app target
or explicit user waiver, the verifier reports no unresolved blocker at confidence
appropriate to the risk, no unrelated change is staged, no delegated job remains
in flight, and durable state can reconstruct the result.

## Shared Fallback And Stop Rules

- Planning unavailable: the orchestrator may plan directly.
- Implementation unavailable: choose another edit-capable agent; never collapse
  implementation into orchestration.
- Verification unavailable: follow `delegated-jobs.md` and disclose degradation.
- Do not repeat the same failed command, prompt, provider call, or repair without
  new information.
- Stop for material scope/architecture decisions, unavailable important tests,
  conflicting high-risk findings, uncertain workspace ownership, destructive or
  live actions, secrets/credentials, deploy/release/push authority, or exhausted
  fallbacks.

Durable state records phase status, branch, changed files, implementation route
and model, verification commands/results, UI/UX browser review result, app target
and proof of the current phase changes (or `N/A` reason), verifier tier/model/
verdict, commit when available, blockers, deferrals, next phase, and exact user
decisions.
