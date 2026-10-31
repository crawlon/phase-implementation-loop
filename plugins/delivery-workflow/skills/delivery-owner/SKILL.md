---
name: delivery-owner
description: Coordinate delivery across interacting plans and dependencies, with an optional retained planner, outcome-focused decisions and owner-managed execution. Use when a roadmap needs continuing cross-plan ownership.
---

# Delivery Owner

Own progress toward the agreed outcome. Keep the next observable result, the
actual blocker and the actor who will remove it clear. Verified milestones,
justified learning and fewer avoidable waits matter more than activity counts.

The owner adopts canonical plans, coordinates dependencies and assignments,
and assesses milestone evidence. Orchestrators supervise implementation, tests,
repairs and independent verification. An optional retained planner develops
proposals, preserves roadmap rationale and reviews cumulative direction; it
does not become a second dispatcher. Human decisions remain with the human.

## Select and establish the workflow

Use when the human selects delivery ownership, directly or through the planner's
workflow startup. Read the named skill and required references automatically;
no separate manual invocation is needed. Read the shared
[workflow agreement and retained-planning protocol](../roadmap-planner/references/retained-planning.md)
at startup/adoption. Reuse an explicitly selected existing planner; adding a
planner chat, messages or a heartbeat needs the corresponding human authority.
Record whether a planner is present. Without one, the owner plans progressively
under [progressive planning](references/progressive-planning.md).

When launched by the planner to start execution, establish the index and first
assignment, then launch/adopt its managed orchestrator under the recorded human
authority. You are that child's sole launcher. Verify its startup acknowledgement
and report actual readiness or the pending gate to the planner; do not stop at
creating an assignment. Preserve the [startup launch chain](../roadmap-planner/references/workflow-startup.md).

1. Check your [context health](references/contracts.md#context-health-and-follow-up)
   before substantial evidence loading or decisions. Read repository instructions,
   the fixed target, canonical plan and the index's single
   [current snapshot](references/contracts.md#owner-index--owner-is-its-sole-writer).
   Reconcile actors, custody, original authority and pending gates. An observation
   request permits observation and recommendations only.
2. Assign the next outcome and security/privacy/compatibility invariants,
   delegated technical choices, resources and reserved decisions. Distinguish
   proposed mechanisms from mandatory restrictions; preserve existing hard limits. Read [role profiles](references/contracts.md#managed-role-profiles);
   record the actual selected profile, or unknown, without claiming a skill
   changed the running model.
3. For dispatch, read the [assignment](references/contracts.md#assignment--owner-writes-orchestrator-acknowledges)
   and [review policy](references/review-policy.md). Name the next observable
   result, its required evidence, dependencies and review boundary. Reserve
   implementation/reviewer capacity; start with at most two active plans.
4. For launch, messaging, dependency changes or recovery, read
   [coordination](references/coordination.md). Verify original human authority,
   canonical names, current generations, route results and one writer per resource.
   Launch `$implementation-orchestrator` with `coordination: owner-managed` and
   the approved `execution: gated | autopilot`; preserve those settings in each assignment.

## Decide the next delivery step

Run this loop on an actionable event or due outcome inspection. Routine GREEN
phases stay local and continue under their existing authority.

1. **Establish progress.** Read the snapshot, affected row and changed checkpoint.
   Compare with the last meaningful capability milestone and latest inspection:
   criteria advanced, assumptions resolved, cumulative prerequisites and blockers.
   Inspect raw evidence for a gap, contradiction, material risk or stale summary;
   name the question and stop when the decision is supported.
2. **Check direction before advising.** Identify the next planned observable
   result and assess cumulative progress under the shared
   [goal-progress review](../roadmap-planner/references/retained-planning.md#direction-reviews)
   at due outcome checks and scheduled reviews, not just after an advice request.
   For proposed preparation, repairs or harness work, establish the
   blocker or required invariant served, decisive evidence and stopping condition.
   Necessary groundwork may continue. Repeated activity without new learning or
   criterion coverage requires a changed approach or a concrete missing decision.
   Apply the [direction-review triggers](../roadmap-planner/references/retained-planning.md#direction-reviews)
   even inside an unfinished phase; evaluate the original plan as well as execution.
3. **Resolve the delivery decision.** Leave authorized routine execution with its
   orchestrator. Resolve working-plan/dependency decisions within delegated bounds;
   classify requests under the shared [scope check](../roadmap-planner/references/retained-planning.md#request-scope-and-routing).
   Use the retained planner for substantial roadmap proposals and direction review,
   and [bounded consultation](references/astra-consultation.md) for a difficult
   technical question. Keep diagnosis with the executing actor. Route genuinely
   reserved choices or missing permissions directly to the executing chat.
4. **Move the responsible actor forward.** Apply supported proposals to the
   canonical plan within authority, reconcile affected dependencies, and obtain
   acknowledgement of changed assignments. Send one concrete next action and
   observable result when needed. Independent authorized work continues.
   Informational events need no receipt, duplicate status report or new review.

Record the decision, evidence limits, next result/actor and next inspection in
existing state. Process already available decisions before ending the turn.
At a genuine pause name the decision, resumer and actual recovery route. Use
bounded native waits for imminent transitions; recurring wakeups need an
authorized heartbeat. Never imply that saved state will wake another chat.

## Direction, acceptance and continuity

Use [review timing](references/review-policy.md) for meaningful outcome gates and
stagnation during unfinished work. Planner advice is not approval or independent
PASS. Assess and disposition an actionable recommendation before more affected
work; an absent advisory reply alone does not stop valid authorized continuation.

Accept a milestone only when all its criteria, including outlined steps, have
evidence and designated integration verifies the combined result at its recorded
target. Preserve the distinction between local verification, commit, integration
and human acceptance. Reuse valid evidence without repeating whole audits.

Reassess context after large review/repair cycles, terminal consultations and
before ending substantive coordination. Perform a due authorized
[exclusive handoff](references/coordination.md#handoff-and-owner-failure), carrying
pending decisions, approvals, planner binding and actual communication results.
Carry the last goal assessment/rationale, next observable result and review route;
verify that the successor reads the role entrypoint matching its actual role.
Independent children may continue while the owner transfers; settle the owner's
own jobs. Adoption or switching back follows the shared workflow agreement at a
safe checkpoint. For maintenance use [behavioral scenarios](references/validation-scenarios.md).
