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

Before work commits to a novel shared interface, irreversible migration, or
similarly high-impact design, assign one independent read-only review of the
decision and dependent assumptions. Record the triggering risk, precise question,
plan/contract revision, evidence, and dependent work it gates. The reviewer did
not author that design; the owner cannot review its own plan independently.
Use the approved independent reviewer route and the existing
[verdict, repair, and fallback rules](../../phase-implementation-loop/references/delegated-jobs.md),
loading only relevant provider guidance. Do not launch a new planner or multiple
reviewers merely for comparison.

Resolve blocking findings before affected implementation or parallel consumers
rely on the design; unrelated authorized work can proceed. A prior independent
review covering the same unchanged decision can satisfy this gate. Routine,
settled designs need no extra design review; record a short applicability reason
in the assignment. Design PASS grants no execution/migration authority and does
not replace implementation, phase verification, or later integration checks.

## Earliest useful integration check

For each interacting pair or group of plans, name the earliest executable shared
boundary and a concrete compatibility check when planning. For example, check
the first API response against its actual consumer before building the remaining
consumer flows. Record the triggering deliverables, exact input revisions/commits,
responsible integration orchestrator, authorized target, and work gated by it.

Run the focused check as soon as those verified inputs are ready, rather than
waiting for both complete plans. Reuse existing checks where they prove the same
boundary. Dependent expansion waits for a passing result; independent work may
continue. If the check cannot run, preserve the gate and route the missing
evidence question to the owner or missing human authority to the executing chat.
Do not merge unapproved commits, invent
live-service access, or treat separate worktrees as proof of compatibility.

Use the existing integration assignment and mode-specific authority. Record the
checked revisions and evidence invalidation conditions. This early result is
narrow evidence; combined milestone acceptance still requires its final checks.
When inputs remain unchanged, reuse the early coverage instead of rerunning it
solely because the milestone ended.

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
material risk. Record the result and the last phase/checkpoint sequence covered.
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

During the pilot, use existing receipts to record review elapsed time, owner
turns/context and actual usage when exposed, rework, and defects first discovered
at integration. Adjust future phase sizes/checkpoints from that evidence with
required authorization. Do not claim token savings without measurement or reduce
acceptance/required assurance to improve a cost metric.
