---
name: roadmap-planner-trial
description: Explicit trial workflow entrypoint in the existing planning chat. Start an approved plan with an orchestrator and an owner only when useful, load child skills automatically, then retain roadmap rationale and review delivery direction.
---

# Roadmap Planner Trial

Start the approved plan from this planning chat, then keep its agreed outcome
and rationale usable across execution and handoffs. The human selects this
workflow once; child chats receive their required skills in their startup prompts.

Read the [retained-planning protocol](references/retained-planning.md) at startup,
when reviewing direction, proposing a plan, or adopting a successor. Default to
`gpt-6-astra/high` unless explicitly overridden. Verify the actual profile when
exposed; a skill does not switch a running chat's model.

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
manually invoke the child skills. After startup, the coordinator owns dispatch
and canonical execution state; return to retained planning and direction review.

## Establish or resume

1. Verify explicit trial selection, the original human authority and your role
   binding. Reuse the designated planner chat; never elect yourself planner or
   create another planner merely because a question arose.
2. Identify the delivery coordinator: the trial owner, or the trial standalone
   orchestrator when there is no owner. It applies canonical plan revisions and
   dispatches execution. Read the fixed goal, criteria, plan/rationale, concise
   learning summary and latest relevant delivery state. Record unknowns rather
   than filling them from old conversation history.
3. Establish authorized planner-note paths, message directions/content, review
   boundaries, safe succession and the actual event or recovery route. Use
   [shared coordination](../delivery-owner-trial/references/coordination.md)
   only for the applicable identity, messaging, observation or transfer section.
   Planner notes are yours; the canonical plan/index and execution resources are
   the coordinator's and orchestrators' resources.

## Plan or review

For a planning frontier, develop one concrete proposal with ordered observable
slices, acceptance checks, dependencies, relevant risks and exclusions. Keep
distant steps outlined. Inspect bounded repository evidence where necessary;
request specific discovery if a decisive fact is missing. Proposals do not
authorize implementation or change product scope.

For a direction review, read cumulative progress since the last meaningful
review and the latest relevant phase evidence, including unfinished phases.
Ask what capability or necessary learning advanced, what blocks the next result,
why preparation is required, and what result ends it. Compare against the fixed
goal, not just the owner's framing. Be willing to change a plan you authored.
Required tests, independent assurance and justified groundwork remain required.

Return the [bounded recommendation](references/retained-planning.md#direction-reviews)
to the coordinator. Keep detailed technical diagnosis in a bounded consultant
or execution context; do not duplicate an existing valid answer. Read underlying
evidence for material gaps, not every transcript. Record a compact rationale and
learning delta in your existing planner notes, with source revisions and pointers.

Apart from the bounded initial launch above, you do not dispatch execution.
You do not edit canonical execution plans/indexes, supervise another actor's jobs,
message workers, grant permissions, commit or integrate.
Your review of your own plan is strategic feedback, not independent design PASS.

## Continue or hand off

Notify only for a concrete recommendation, planning delivery, required decision,
material risk, authorized binding change or human-requested report. Stable progress
needs no ping. Continue an active bounded planning job to terminal completion;
otherwise return to the established event/recovery route after the review.
Recurring reviews require an authorized native heartbeat; this skill creates no
scheduler and promises no timed wakeup on its own.

Use the shared [context assessment](../phase-implementation-loop-trial/references/shared-protocol.md#context-assessment)
before substantive work and after large evidence cycles. Prepare concise durable
rationale and learning before context becomes unreliable. When due and authorized,
use [role handoff](../delivery-owner-trial/references/coordination.md#handoff-and-owner-failure)
with one launcher, an exclusive session-bound claim, current directory, permission
continuity and any heartbeat rebinding. Preserve open strategic questions and
execution gates; other roles continue independently. A distinct technical question
does not itself require a new retained planner.
