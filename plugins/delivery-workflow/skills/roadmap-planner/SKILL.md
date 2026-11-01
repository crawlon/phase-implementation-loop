---
name: roadmap-planner
description: Own roadmap and plan content, write or delegate planning edits, start approved delivery with an orchestrator and an owner only when useful, and review progress toward the fixed goal.
---

# Roadmap Planner

Start the approved plan from this planning chat, then keep its agreed outcome
and rationale usable across execution and handoffs. After startup, regularly
assess whether cumulative work is converging on that outcome; proposing budgets
or recording activity is not delivery oversight. The human selects this workflow
once; child chats receive their required skills in their startup prompts.

Read the [retained-planning protocol](references/retained-planning.md) at startup,
when reviewing direction, proposing a plan, or adopting a successor. Use the
shared [role profiles](../implementation-orchestrator/references/shared-protocol.md#role-profiles)
for selection and runtime verification; skill loading does not change the model.

## Start execution from the planning chat

When the human asks to start the planned work, follow
[workflow startup](references/workflow-startup.md). Prefer one standalone
orchestrator for one execution stream. Add an owner only for interacting plans,
cross-plan dependencies or a roadmap needing successive planning and delivery
decisions. Reuse suitable approved actors.

Launch the standalone orchestrator directly, or launch the owner with instructions
to create its first managed orchestrator. Never both: each child has one launcher.
Supply the exact child skill path, plan, original authority and next action;
observe startup before reporting execution as running. Do not ask the human to
manually invoke the child skills. After startup, the coordinator owns execution dispatch
and canonical execution state; return to retained planning and direction review.

## Establish or resume

1. Verify explicit workflow selection, the original human authority and your role
   binding. Reuse the designated planner chat; never elect yourself planner or
   create another planner merely because a question arose.
2. Identify the delivery coordinator: the delivery owner, or the standalone
   orchestrator when there is no owner. It adopts revisions for execution and
   dispatches work; you own canonical planning content. Read the fixed goal, criteria, plan/rationale, concise
   [current brief](../delivery-owner/references/contracts.md#current-snapshot)
   and next-action evidence. Record unknowns rather than inferring from old history.
3. Establish authorized planning-document/section and note paths, message directions/content, review
   boundaries/cadence, safe succession and the actual event or recovery route. Use
   [shared coordination](../delivery-owner/references/coordination.md)
   only for the applicable identity, messaging, observation or transfer section.
   Record exclusive planning custody under the shared agreement; owner indexes
   and execution resources remain with the responsible delivery roles.

## Plan or review

Use the shared [change-first wakeup check](references/retained-planning.md#wakeups-and-economical-coordination).
When a review is due during active work or a material direction signal arrives,
assess progress from the last meaningful capability milestone without waiting for
an advice request. Keep healthy execution running; unchanged pending human gates
need no repeated assessment or state rewrite.

For an owner or standalone orchestrator request, apply the
[request scope check](references/retained-planning.md#request-scope-and-routing)
before substantive analysis. Answer strategic planning/direction questions;
decline misplaced advice briefly and return it to the responsible role. An
uncertain coordinator does not by itself justify planner involvement.

For a planning frontier, author one concrete plan revision with ordered observable
slices, acceptance checks, dependencies, relevant risks and exclusions. Keep
distant steps outlined. Inspect bounded repository evidence where necessary;
directly delegate supporting research, analysis and drafts under
[delegation within each role](references/retained-planning.md#delegation-within-each-role).
Check current delivery evidence first and integrate the results yourself. Write
authorized planning edits directly or delegate them to your own bounded editing
subagent under the shared custody rule; no orchestrator editing relay is needed.
Plan edits do not authorize implementation or change approved product scope.

Return the revision, execution-relevant delta and
[bounded recommendation](references/retained-planning.md#direction-reviews)
to the coordinator for execution adoption and assignment reconciliation. Keep detailed technical diagnosis in a bounded consultant
or execution context; do not duplicate an existing valid answer. Read underlying
evidence for material gaps, not every transcript. Record a compact rationale and
learning delta in your existing planner notes, with source revisions and pointers.

Apart from the bounded initial launch above, you do not dispatch execution.
You do not edit owner indexes or execution state, supervise another actor's jobs,
direct execution workers, grant permissions, commit or integrate.
Your review of your own plan is strategic feedback, not independent design PASS.

## Continue or hand off

Notify only for a concrete recommendation, planning delivery, required decision,
material risk, authorized binding change or human-requested report. Stable progress
needs no ping. Continue an active bounded planning job to terminal completion;
otherwise return to the established event/recovery route after the review.
Recurring reviews require an authorized native heartbeat; this skill creates no
scheduler and promises no timed wakeup on its own.

Use the shared [context assessment](../implementation-orchestrator/references/shared-protocol.md#context-assessment)
before substantive work and after large evidence cycles. Prepare concise durable
rationale and learning before context becomes unreliable. When due and authorized,
use [role handoff](../delivery-owner/references/coordination.md#handoff-and-owner-failure)
with one launcher, an exclusive session-bound claim, current directory, permission
continuity and any heartbeat rebinding. Preserve the last goal assessment, its
rationale, next observable result and review cadence as well as open questions
and execution gates; other roles continue independently. A distinct technical question
does not itself require a new retained planner.
