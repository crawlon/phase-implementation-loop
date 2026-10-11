# Review Scope and Timing

Set this policy when preparing an assignment; reuse it at its named checkpoints.
Keep the policy in existing plan/state fields, not another ledger. Cheap tests,
orchestrator inspection, independent phase verification, and owner outcome review
serve different purposes; none substitutes for the others.

## Phase boundaries and normal verification

A phase should deliver a coherent, reviewable behavior or resolve a meaningful
risk. Group small related edits when planning; split work before a risky decision
creates substantial dependent work. Do not split by file or mechanical task just
to show progress. Do not merge frozen phases or skip required reviews mid-run to
save tokens; resolve material plan revisions through existing authority rules.

Keep independent verification before every substantive phase becomes GREEN, and
UI review for affected user-visible behavior. Factual bookkeeping follows the
existing exception. Repair reviews cover the changed boundary and its affected
behavior; reuse valid evidence elsewhere. A new reviewer, handoff, or unrelated
commit does not by itself require a whole-plan audit.

## Design review before consequential implementation

Apply the shared [consequential design review](../../phase-implementation-loop/references/shared-protocol.md#consequential-design-review)
requirements. The owner assigns the independent review and records applicability
and dependent work in the assignment; it cannot independently review its own plan.
Use approved reviewer transport only when needed. Blocking findings gate affected
implementation/consumers; unrelated authorized work may continue.

## Earliest useful integration check

Apply the shared [early integration check](../../phase-implementation-loop/references/shared-protocol.md#early-integration-check)
requirements across the interacting plans. The owner names one integration
orchestrator and an existing integration assignment with the triggering
deliverables, target and dependent work. Missing/failing evidence blocks only
dependent expansion; independent work continues. Route evidence questions to
the owner and missing human authority directly to the executing chat. Keep final
combined milestone verification; do not import standalone outcome-checkpoint timing.

## Bounded owner drift checkpoint

Agree a meaningful delivery checkpoint for long autopilot plans at startup. For
the initial pilot, default to at most three completed substantive phases since
the last owner outcome inspection while further phases remain. Short plans can
use completion; risk can justify an earlier named checkpoint. This phase count
is a pilot setting, not a proven universal optimum or a time-based audit schedule.
Count per assignment from dispatch until the first outcome inspection, then from
the last phase it covered. An inspection of another plan does not reset this one.

Record the selected checkpoint and authorized notification route in the
assignment. When due, settle active jobs, save a compact delta, and notify once.
Completed GREEN work retains its normal commit authority, but pause new phase
starts at this explicitly agreed checkpoint until the owner records its outcome
inspection. This is an owner coordination gate, not a new human approval or a
repeat independent code review. If the owner is unavailable, save state, end the
turn at the gate, and use authorized notification or direct human recovery;
never infer inspection from silence or a delivered message. Record WAITING_OWNER,
the exact inspection needed, notification result and resumer using the pause
contract. Failed delivery uses coordination recovery; a skill supplies no
scheduler. Routine GREEN checkpoints before the agreed boundary remain local.

At this existing review, apply the contract's
[context-health follow-up](contracts.md#context-health-and-follow-up) for the owner
and reviewed orchestrator. Reuse a current assessment; no separate review cycle.

The owner compares criteria actually advanced, capabilities delivered, new
prerequisites, and cross-plan assumptions with the approved outcome. Read the
relevant evidence pointers; inspect details only for a gap, contradiction, or
material risk. Include the next planned observable result and its responsible
actor. Where preparation has expanded, identify the prerequisite or uncertainty
resolved, the evidence gained and the remaining delivery blocker. Necessary
groundwork may continue when that link is supported; activity counts alone
neither establish progress nor justify discarding it. Use the existing review,
not an additional per-event audit. Record the result and the last phase/checkpoint sequence covered.
Only that actual inspection resets the count; acknowledgements, status polls,
or handoffs do not. If an earlier approval/decision already included this outcome
inspection, reuse it. Gated plans can use their owner-visible phase reports for
this check without adding another review cycle.

If aligned, authorize the next already-approved work and next checkpoint without
asking the human again. For drift, apply the contract's decision classification:
the owner resolves working-scope or dependency refinements within delegated
bounds and obtains assignment acknowledgement where needed. Only crossed hard
limits, reserved choices or missing authority need a human decision. Retain
affected gates until the responsible actor resolves them, not until a human
approves every changed plan detail.
Immediate risk/dependency events and existing two-preparation-phase drift checks
still apply; do not wait for the periodic checkpoint to raise known problems.

## Tune with evidence

Judge owner effectiveness by correct evidence-based decisions, accepted milestones,
avoidable stalls, duplicated work, rework and integration defects. During the
pilot, use existing receipts for these observations, review elapsed time, owner
turns/context and actual usage when exposed. Compare equivalent accepted outcomes;
shorter messages or fewer reads alone do not prove improvement. Adjust future
phase sizes/checkpoints with required authorization. Preserve acceptance and
required assurance; report token savings only when measured.
