# Managed Phase Execution

This protocol applies only to the two managed skills. Standalone skills retain
their own orchestration and approval modes. An assignment is not permission to weaken their
verification or safety requirements.

## Reference boundaries

Read the [assignment/checkpoint contract](../../delivery-owner/references/contracts.md)
and this protocol first. Reuse the following sections of the existing
[shared protocol](../../phase-implementation-loop/references/shared-protocol.md):

- Delivery And Evidence Discipline
- Bounded Authorization
- Canonical Plan And Linear
- Execution Profile (worker/reviewer routing; planning ownership is below)
- UI/UX Review Gate
- The GREEN definition following Common Phase State Machine
- The final durable-state field list

Do not import the standalone Role Contract, Planning And Replanning, or its
startup/approval flow. The managed role/phase/stop rules below replace those
sections and resolve ownership/planning references in reused material. Do not
load either standalone SKILL.md during managed execution.

Before implementation read the existing
[capability assessment](../../phase-implementation-loop/references/phase-capability.md).
Before delegation read
[delegated jobs](../../phase-implementation-loop/references/delegated-jobs.md),
the [prompt contracts](../../phase-implementation-loop/references/agent-prompts.md),
and only the selected provider references:
[Codex](../../phase-implementation-loop/references/agent-codex.md),
[Cursor](../../phase-implementation-loop/references/agent-cursor.md), or
[Claude](../../phase-implementation-loop/references/agent-claude.md).
Reuse their implementation/UI/verification mechanics. Where they route
substantive planning to a fresh planner, route the bounded question to the
delivery owner instead. Do not spawn a redundant Astra planner.

## Managed orchestrator model

Run the plan orchestrator on **GPT-6.1 Sol High** (`gpt-6.1-sol`, reasoning
`high`) unless the user explicitly selects another orchestrator profile. Record
this separately from implementation and review roles. A skill cannot change its
current chat's model: verify the active selection when exposed and disclose an
unknown or mismatched model. Resolve it through the owner before execution;
do not claim the requested model ran merely because the assignment names it.

Implementation keeps the reused protocol's existing defaults, capability
assessment and fallback rules: a separate `gpt-6-luna` worker at `max` reasoning
by default. Explicitly select the worker profile at launch rather than inheriting
the Sol orchestrator's model. Owner and reviewer profiles are also unchanged.

## Role and startup

The owner controls canonical plan revisions, dependencies, cross-plan scope, and
milestone acceptance. You control execution of the assigned plan: capability
assessment, worker routing, diff inspection, checks, independent verification,
owned local commits, factual phase state, and agreed tracker bookkeeping.
Propose substantive plan changes to the owner; do not edit shared plans or the
owner index concurrently. A shared file/tracker field has one assigned writer.

Implementation always uses a separate edit-capable worker, not this context or
a user-owned chat created in place of a worker. Independent reviewers did not
implement the work; the delivery owner cannot fill their place. Workers never
commit/push/deploy or acquire approval on the orchestrator's behalf.

Before acknowledgement, verify repository instructions, actual host/worktree,
branch/HEAD, dirty-path ownership, exclusive assignment generation, original
human authority, dependencies, profile, required tools, and access to the
canonical plan/state. Use the exact assigned checkout, not a saved project's
default. All phases use one dedicated branch following repo conventions or
`codex/<plan-slug>`. Parallel plans need separate worktrees and resource ownership.

Reuse the assigned capability assessment if still valid; resolve incompatible
plan detail/model choices through the owner before implementation. Preserve the
managed orchestrator profile above and choose the least expensive capable worker
under the existing capability/profile rules; do not change an approved model
silently. Do not downgrade risky phases to meet a cost preference.

Reconcile canonical Markdown and Linear coverage under the reused protocol,
scoped to the assigned concrete plan's phases and relevant dependencies. A
roadmap parent or sibling issue does not expand that assignment: retain links
and dependency facts for outlined future steps without inventing their phases
or making their detailed synchronization a gate for the ready plan. Missing
evidence for an actual dependency still blocks its consumer.
Have the assigned writer apply authorized mappings and re-read the sources.
Reuse current proof; do not create duplicate issues for an owner-managed plan.
Missing tracker authority/synchronization is a startup blocker routed to the
owner, not a reason to mutate another writer's issues.

If chat creation, messaging, worktree setup, integration, tracker actions, or
rollover are outside the agreement, request that specific authority through the
owner. Established authorization is reusable. Skill invocation or an agent's
assignment is not independent human consent.

## Phase loop

Apply the assignment's
[review scope and timing](../../delivery-owner/references/review-policy.md):
confirm applicable design review before affected implementation, run named early
integration checks before dependent expansion, and honor explicitly agreed owner
drift checkpoints before new phase starts. Record the relevant evidence and last
owner outcome inspection in existing state. Ordinary phase verification remains
required; these checks neither replace it nor authorize scope changes.

1. Reconcile the latest acknowledged assignment, pending decisions, dependencies,
   and relevant evidence conditions. Write a brief with objective, scope,
   acceptance checks, constraints, risk, capability delivered, criterion served,
   chosen implementation route, and stop conditions.
2. Resolve routine execution details locally. Send genuine planning gaps or
   material dependency/architecture changes to the owner with the smallest
   decisive evidence and a recommendation. Pause affected work until resolved;
   do not repeat full repository discovery or send worker transcripts.
3. Delegate implementation with the shared Ponytail/minimal-diff prompt,
   assignment boundaries, and exact workspace. Supervise the same handle to
   terminal completion under delegated-jobs.md; do not duplicate active jobs.
4. Inspect actual status/diff and ownership. Run required checks appropriate to
   risk. Complete the UI/UX gate or record N/A; reuse still-valid coverage.
5. Run independent verification under delegated-jobs.md. Preserve primary and
   fallback criteria, critical-work restrictions, terminal result handling,
   and the same-verifier repair rule. The owner is not an independent fallback.
6. Repair within bounds; after two materially similar red cycles without new
   evidence or a distinct fix, stop and send the capability/plan gap to the owner.
   Autopilot additionally stops after two distinct repairs leave required tests
   red. Never change acceptance to make a phase green.
7. Update the existing phase state. GREEN requires the reused GREEN definition,
   valid dependencies, correct assignment revision, and all jobs terminal.
   Apply the selected managed mode's commit gate; checkpoint only the delta.

Do not wake Astra for routine worker start/finish, passing tests, local repairs,
factual state changes, or ordinary GREEN phase checkpoints. Record those
checkpoints locally for observation. Follow the assignment contract's explicit
notification triggers for agreed owner drift checkpoints, decisions, actionable
dependencies, stops, material human interventions, handoffs, and completion, preserving human reporting
preferences. An ordinary green autopilot checkpoint adds no approval wait;
an explicitly agreed drift checkpoint retains its owner coordination gate.
Retain detailed evidence locally so compact messages remain auditable.

## Stops, intervention, and handoff

Preserve work and escalate through the owner for unmet required checks,
insufficient/conflicting high-risk verification, exhausted repair/fallback
bounds, no separate implementer, unknown write ownership, unexpected partial
writes, branch/worktree divergence, incompatible capability, or an action beyond
authority. Material scope/order/dependency/acceptance/architecture changes need
the owner and any required human decision before proceeding. Never reset, clean,
discard, or overwrite uncertain work to recover convenience.

Direct human stop instructions take effect immediately: stop launching work and
use available interruption safely, preserve partial state/handles, then report
to the owner. Other material direct human interventions pause affected work
until the owner reconciles dependent plans. Preserve explicit user instructions
over prior owner instructions. If the owner is unavailable, direct human contact
may recover coordination; unaffected authorized work can continue.

Do not claim that sending a message paused another agent. Require acknowledgement
before relying on a changed assignment or relinquished writer. Late decisions
for an old revision/generation cannot authorize current work.

Check context health at phase checkpoints; do not invent usage percentages.
When transfer is due, use the managed
[coordination and recovery rules](../../delivery-owner/references/coordination.md)
and their linked safe-transfer procedure. Preserve pending human approval,
original authority and exclusive ownership. No simultaneous successor launches,
automatic history forks, or restarted Phase 1. If safe handoff is unavailable,
save state and escalate; a status message does not prove transfer.
