# Shared Phase Protocol

Both phase skills use this protocol. The invoking agent is the orchestrator,
regardless of provider or model. The mode skill decides whether a green phase
waits for approval or commits and continues automatically.

## Role Contract

The orchestrator owns plan reconciliation, routing, supervision, diff inspection,
tests, verification gates, commits, and reporting. It may directly maintain
factual phase status, receipt links, commit ids, and handoff summaries. Delegate
implementation, operational scripts, and substantive plan changes to an
edit-capable worker; substantive verification remains independent. A correction
to permissions, acceptance, dependencies, or evidence meaning is substantive
even in Markdown. Factual bookkeeping must not upgrade an evidence claim.

The invoking surface qualifies as orchestrator only when it can inspect the
workspace/diff, run required checks, supervise delegated jobs, and enforce the
active mode's git gates. Otherwise stop before Phase 1 and hand off to a capable
orchestrator.

Keep the invoking agent as orchestrator; no fixed model or maximum reasoning is
required for this role.

The orchestrator owns the canonical plan and decisions. Delegate substantive
planning analysis under Planning And Replanning below; routine status updates,
evidence reconciliation, and critical-path checks need no planning agent.

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

## Delivery And Evidence Discipline

Optimize for verified delivery of the approved outcome, not completion of an
expanding verification process. Add two short fields to the existing phase brief:
`capability delivered/blocker removed` and `criterion/invariant served`.
A new prerequisite must show why that criterion or safety invariant cannot be
met without it, with evidence. Otherwise schedule it as a nonblocking follow-up;
preserve the full end goal and all explicitly required dependencies.

Distinguish usable capability/current environment, repeatable setup/recovery,
and production hardening. Do not assume earlier milestones require every later
assurance. At each accepted milestone, state what is unblocked and advance the
next authorized critical-path step. Changing frozen order, dependencies, scope,
or acceptance materially still requires the active mode's approval.

Record accepted evidence's scope, target, relevant code/configuration and
conditions, and invalidation triggers in the existing state summary. Reuse it
until a relevant change or contradictory evidence invalidates it; recheck the
affected boundary only. A new agent re-establishes workspace, ownership, target,
and evidence conditions, without automatically replaying whole audits. Status
prose, receipt pointers, or unrelated commits do not invalidate runtime evidence;
preserve any material safety binding and immutable historical receipts.

After two consecutive preparation-only phases, or growing tooling/review effort
without closing capability criteria, the orchestrator briefly reassesses the
critical path: what remains blocked, what evidence makes preparation necessary,
and which authorized step delivers progress. Continue evidenced preparation;
otherwise schedule it as follow-up and advance authorized work. This checkpoint
requires no additional planner, artifact, tracker hierarchy, or approval cycle.
It does not authorize changes to frozen order or dependencies.

## Context Health And Rollover

Check context health at existing phase/job checkpoints and before the next
substantial step. Use reliable usage indicators when exposed; otherwise watch
for accumulating logs/diffs, repeated reconstruction, or difficulty retaining
exact decisions and authority. Do not invent a token percentage. Save state early
and roll over at a safe checkpoint before reliable orchestration degrades.

Include automatic fresh-orchestrator rollover in the execution profile or
approved envelope. An explicit user request for automatic handoffs supplies
that authority within its stated scope; a skill alone does not authorize new
chats. When rollover is due and authorized, read `context-rollover.md`, update
the existing status summary, prepare a concise handoff, and launch one fresh
primary orchestrator. Preserve pending gates and prevent concurrent owners; do
not substitute an implementation subagent or a fork retaining the heavy history.
No routine user prompt, planner, or extra review is needed for an authorized
rollover. If tooling, authority, or exact-workspace access prevents safe launch,
preserve the handoff and report the limitation rather than claiming a transfer.

## Bounded Authorization

Use the existing phase approval or autopilot envelope to name targets, allowed
actions, risks, incidental effects, repair/retry bounds, and exclusions. Reuse
explicit authority from the session: ordinary steps, approved verifier use, and
repairs within that boundary need no repeated approval. The gated commit approval
and autopilot startup gate remain distinct. New authority, material scope/risk
changes, or unexpected partial writes require preservation and the appropriate
stop/decision. Platform permissions and sensitive-action gates still apply.

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

After the assessment identifies the required capabilities, use these defaults
unless the user selects another implementation profile:

1. A separate Codex worker using `gpt-6-luna` at `max` reasoning.
2. If unavailable, an edit-capable Cursor Grok 4.7 worker. Choose its effort for
   the phase and use the corresponding surfaced model id, such as
   `grok-4.7-high` for high effort.
3. If both routes are unavailable, the orchestrator selects an available
   edit-capable implementation model and reasoning level appropriate to the
   task, required capabilities, and risk. Record the choice and reason; do not
   automatically choose the largest model or maximum reasoning.

Do not call a model to choose the route or compare multiple implementers. Do not
silently use an implementer that lacks the capabilities required by
`phase-capability.md`. Retain the same phase brief and acceptance criteria on
fallback; model choice does not reduce the goal or risk requirements. For a
Codex worker, use `agent-codex.md`. If no separate edit-capable implementer is
available, stop for operator guidance; the orchestrator does not take over.

Read only the selected agent references:

- `agent-codex.md`
- `agent-cursor.md`
- `agent-claude.md`
- `agent-prompts.md` when constructing a delegated prompt

## Planning And Replanning

Delegate one bounded read-only planning job when unresolved implementation
decisions or risks require substantive exploration or replanning. Do not launch
a planner merely for a new phase, factual bookkeeping, or the drift checkpoint.
The default route is a fresh Codex subagent using
`gpt-6-astra` at high reasoning. If that route terminates unsuccessfully or is
unavailable, use Claude Opus 5.5 through `codex-claude-ask --model
claude-opus-5-5`. Use the Planning prompt in `agent-prompts.md` for either route.

The planner may inspect the plan and repository evidence but must not edit the
workspace, mutate Linear, commit, push, deploy, or decide unresolved product
questions. The orchestrator reviews the advice, presents decisions to the user
when needed, and owns reconciliation into the canonical plan, Linear mapping,
capability assessment, and durable state. Delegate substantive plan edits to a
worker; factual status and pointer updates remain direct orchestrator work.

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
Unless the user selects another route, use `gpt-6-luna` at `max` reasoning.
If unavailable, select an appropriate non-editing browser-capable reviewer and
record its model, effort, and fallback reason.
Read `agent-codex.md` and the UI/UX Review prompt in `agent-prompts.md`, then
give the reviewer the phase brief and current-worktree target. The reviewer
starts or reuses the relevant app, opens the target in the in-app Browser, proves it
serves the phase diff, and follows `$ui-ux-browser-review`. Record its model,
effort, target, proof, coverage, findings, limitations, and outcome in durable
state. Return actionable findings to an edit-capable implementation worker, then
rerun affected checks and review coverage before independent verification; reuse
unaffected accepted evidence under Delivery And Evidence Discipline.

For a non-UI phase, record `UI/UX review: N/A` with the reason. A UI-affecting
phase cannot be GREEN without that review, or an explicit user waiver when the
required browser evidence cannot be obtained. A waiver must state the untested
scope and resulting risk; it is not implied by passing functional tests.

## Common Phase State Machine

For each phase:

1. Reconfirm the approved capability assessment, then write a phase brief with
   objective, scope, likely files, constraints, acceptance checks, risks, stop
   conditions, capability delivered/blocker removed, and criterion/invariant
   served. Resolve any required `add plan detail` or `use stronger
   implementer` action before delegation.
2. When substantive planning is needed, delegate under Planning And Replanning
   above and reconcile the approved result before implementation. Perform any
   triggered drift checkpoint directly under Delivery And Evidence Discipline.
3. Select and record the implementation route, model, and reasoning/effort.
4. Delegate implementation with Ponytail/minimal-diff and drive it to a terminal
   result under `delegated-jobs.md`. Factual bookkeeping follows the Role Contract.
5. Inspect `git status --short` and the actual diff. Confirm every changed path
   belongs to the phase and no unrelated work was overwritten.
6. Run the smallest relevant verification, then broaden according to risk and
   repository norms.
7. For a UI-affecting phase, complete the UI/UX Review Gate above. For a non-UI
   phase, record its N/A decision.
8. For substantive work, run the verifier chain in `delegated-jobs.md`. Classify
   findings and repairs under its Finding And Repair Scope rules; repeat affected
   verification only. Factual bookkeeping alone needs orchestrator inspection.
9. If a repair exposes interpretation drift or capability mismatch, reassess
   plan detail and implementation strength before another attempt. After two
   materially similar red repair cycles without new evidence or a distinct fix,
   stop with the exact blocker or decision needed.
10. Update durable state before the mode-specific commit/continuation gate.
    Check context health and perform a due, authorized rollover under Context
    Health And Rollover; do not start another substantive step in degraded context.

A phase is GREEN only when its acceptance criteria are met, the orchestrator has
inspected the diff, relevant tests pass or have an explicit approved waiver, the
substantive work has independent verification with no unresolved blocker at
confidence appropriate to the risk (factual bookkeeping alone has orchestrator
inspection), no unrelated change is staged, no delegated job remains in flight,
and durable state can reconstruct the result. The chosen implementation route
must remain compatible with the approved capability assessment. A UI-affecting phase
additionally requires a completed UI/UX review or explicit user waiver.

## Shared Fallback And Stop Rules

- Planning unavailable: try Astra High, then Opus 5.5. The orchestrator may plan
  directly for substantive planning only after both are unavailable, with the
  degradation recorded. Routine reconciliation and drift checks need no planner.
- Implementation unavailable: choose another edit-capable agent; never collapse
  implementation into orchestration.
- Verification unavailable: follow `delegated-jobs.md` and disclose degradation.
- Do not repeat the same failed command, prompt, provider call, or repair without
  new information.
- Stop for material scope/architecture decisions, unexpected partial writes,
  unavailable important tests, conflicting high-risk findings, uncertain
  workspace ownership, sensitive
  actions outside established authority (including destructive/live actions,
  secrets/credentials, deploy/release/push), or exhausted fallbacks.

Use one concise mutable current-status summary, in the canonical plan or its
existing state artifact, pointing to immutable historical evidence. It records
what is now unblocked, evidence scope/conditions/invalidation triggers, phase
status, branch, changed files, planning/replanning route and result, capability
assessment, approved plan-detail/implementer
decision, implementation route and model, verification commands/results, UI/UX
review result or N/A decision, verifier tier/model/verdict, commit when
available, blockers, deferrals, next phase, and exact user decisions. At rollover,
include the transfer generation/owner, handoff pointer, preserved gate, and exact
next authorized action; do not create a second status ledger.
