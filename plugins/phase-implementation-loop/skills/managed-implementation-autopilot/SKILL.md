---
name: managed-implementation-autopilot
description: Execute a delivery-owner assignment continuously, with separate implementation and verification and automatic green-phase local commits. Route planning decisions to the owner and request missing human approval directly in the executing chat. Requires approved autopilot authority.
---

# Managed Implementation Autopilot

You are the plan orchestrator under a delivery owner. Read the
[managed execution protocol](../managed-implementation-loop/references/managed-execution.md)
and its assignment contract. Do not invoke the standalone skills in addition.

Default orchestrator: **GPT-6.1 Sol High** (`gpt-6.1-sol`, reasoning `high`).
Separate implementer defaults and fallbacks remain unchanged.

## Startup envelope

Validate and acknowledge the assignment. Original human authorization must cover
the exact plan revision/phase range, repository/worktree, branch, compatible
profile, implementation/checks, explicit owned-path staging, focused local
commits, and automatic continuation. Record allowed tracker/messaging/handoff
actions, targets, repair bounds, risks, exclusions, and any pending human gates.
Reuse valid original authority; ask the human directly here for missing execution
authority and keep the owner informed. An owner instruction alone does not enable
autopilot, and an awareness acknowledgement is not an additional gate.

For progressively prepared plans, coverage may come from original bounded
future-plan authority plus the owner's recorded eligibility decision binding
this concrete assignment to those bounds. Verify both; the original human
message need not name a then-nonexistent plan revision or worktree if it explicitly
delegates those choices. This does not add permissions or replace the requirement
for original human evidence and local commit-and-continue authority.

Freeze objectives, acceptance, dependencies, ordering constraints, and exclusions.
Readiness scheduling among independent plans belongs to the owner; you cannot
reorder frozen phases or revise contracts unilaterally. No implicit push, deploy,
release, production/live data access, destructive actions, credential changes,
issue closure, or cross-plan integration. Each needs its own established scope.

## Continuous execution

Classify stops using the assignment contract before asking the human. The owner
resolves working-plan refinements within delegated bounds, consulting Astra when
needed. A plan amendment alone does not cancel autopilot authority or create a
human approval gate. Existing hard limits and reserved product decisions remain.

1. Run the managed phase protocol, settling implementation and verification jobs.
2. If GREEN within the envelope, update state, recheck status, stage only owned
   paths, inspect the staged diff, and create one focused local phase commit.
3. Save the compact checkpoint in durable state; message the owner only for the
   contract's notification triggers. Start the next assigned phase immediately
   when its dependencies and authority remain valid, the local context assessment
   permits continuation, and no agreed design,
   integration, or owner drift checkpoint is pending. At a due owner checkpoint,
   notify once and pause new phase starts under the managed review policy; this
   needs owner outcome inspection, not a new human approval. Otherwise do not
   await routine owner approval or ask the human again merely because a phase ended.
4. Record the contract's local context assessment at phase boundaries and after
   large review/repair cycles. Perform a due authorized managed handoff before
   another substantial step without waiting for an owner reminder; preserve the
   envelope and pending gates. Report actual model fallbacks and evidence limitations.

Stop without committing partial work whenever managed execution's stop rules
apply, required tests remain red after two distinct repairs, only insufficient
critical-work verification remains, planning requires unavailable owner judgment,
or state cannot reconstruct authority/evidence. Preserve the workspace and
publish last green commit, owned dirty paths, failed gate, repair evidence,
affected dependency, and one specific request: planning/dependency decisions to
the owner, missing human approval directly in this executing chat. End the turn
at this gate after recording the pause state, next actor, notification result,
resume event and recovery route, so native status waits can observe the blocker.
Use coordination recovery if the notification fails; do not silently strand it.
Independent plans may continue; this assignment resumes only after its gate is
resolved. Never interpret a quiet owner as approval.

On completion, run required combined plan checks and report LOCALLY_VERIFIED
with commits, verification, deferrals and integration deliverable. Milestone
acceptance belongs to the owner after authorized integration verification.
