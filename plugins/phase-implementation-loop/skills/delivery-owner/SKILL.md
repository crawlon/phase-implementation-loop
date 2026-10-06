---
name: delivery-owner
description: Own the planning and delivery of one plan or a roadmap across managed implementation orchestrators, including roadmaps planned progressively as results arrive. Use for coordinating plans, controlling dependencies, preventing drift, and consolidating human decisions. Supports observation without launch authority.
---

# Delivery Owner

Own the outcome and cross-plan decisions; let managed orchestrators own phase
execution. Use one owner for a single plan or a roadmap milestone containing
several plans. Prefer an Astra owner at high reasoning when the user selects
that profile. A skill cannot change the current chat's model: record the actual
model when exposed, otherwise unknown; never claim a model switch occurred.

Read [the assignment and checkpoint contract](references/contracts.md) at startup.
Read [coordination](references/coordination.md) only before launch, a dependency
change, integration, or recovery. Do not load worker protocols, provider manuals,
or all plan histories merely to supervise.
When preparing assignments or reaching a named review checkpoint, apply
[review scope and timing](references/review-policy.md); do not reload it for
routine worker updates.
For roadmap steps whose implementation plans are not yet known, read
[progressive planning](references/progressive-planning.md) when selecting or
planning the next step. Fully planned work does not need that extra cycle.

## Establish the delivery agreement

1. Read repository instructions and reconcile existing plans, state, chats,
   workspace ownership, and human authorization. For observation-only requests,
   inspect and recommend; do not launch workers or send messages.
2. Define the milestone outcome, checkable acceptance criteria, exclusions,
   plans or outlined roadmap steps, dependencies, and integration checks. Write
   or refine canonical planning documents within authorized scope. Do not shrink the outcome to
   fit cheaper models. Preserve lifecycle and compatibility requirements.
3. Present only unresolved choices. Establish a bounded agreement covering
   plan revisions, managed mode per plan, model profiles, repository/host,
   worktrees and branches, tracker actions, local commit/integration authority,
   human approval gates, resource limits, and exclusions. Reuse authority already
   given; planning alone does not authorize execution. For progressively planned
   roadmaps, distinguish authority to investigate/plan from authority to launch
   newly prepared plans; record the launch policy in the owner index.
4. For persistent orchestrator chats, obtain explicit human authorization to
   create those chats and worktrees, send owner-to-orchestrator and return
   messages, and perform successor handoffs if wanted. Name the managed cohort;
   unrelated chats are excluded. Peer-to-peer messaging is optional and requires
   its own human-authorized scope. Preserve links to the actual human instructions.
5. Maintain one compact owner index beside the roadmap/plan, using the contract.
   Each orchestrator maintains its own phase state. Start with at most two active
   plans; lower this when worker/reviewer capacity or shared resources require it.

Use `$managed-implementation-loop` where the human retains phase approval and
`$managed-implementation-autopilot` only for explicitly approved commit-and-
continue execution. Do not silently change modes. The two standalone phase
skills remain independent, with their own orchestration and approval modes.

Assign each managed plan orchestrator to **GPT-6.1 Sol High**
(`gpt-6.1-sol`, reasoning `high`) unless the user explicitly selects another
orchestrator profile. Carry that selection into each assignment and authorized
chat launch. Implementer defaults and fallbacks, owner and reviewer profiles
remain unchanged; do not apply the orchestrator selection to its workers.

## Supervise with a small Astra context

- Read the index and new checkpoint deltas first. Orchestrators own routine
  exploration, diffs, tests, verification, retries, and local status updates.
  Do not request their reasoning transcripts or re-summarize unchanged evidence.
- Process events at startup, a decision/blocker, a dependency delivery, a phase
  checkpoint, handoff, or completion. An ordinary autopilot green checkpoint
  stays in durable state for observation. Notify for an agreed owner drift
  checkpoint or requested reporting, not every green phase. A notification alone
  adds no gate; the assignment explicitly names any coordination checkpoint.
- Use cursor-based status waits for the authorized cohort, then inspect only
  changed tasks. A heartbeat may resume supervision after the owner turn ends
  only when requested/authorized; a skill is not a scheduler. Without one,
  report when active supervision ends. Never claim unattended monitoring exists.
- Default checkpoint payloads to roughly 150 words plus evidence pointers.
  Batch related human questions; preserve urgent blockers and all material risk.
  Never sacrifice evidence needed for a decision to meet a word limit.
- For a decision, read the relevant plan section and decisive evidence. Expand
  to full diffs/logs only for contradictions, material risk, suspected drift,
  or an acceptance claim that the compact evidence cannot establish.
- Routine routing, factual bookkeeping, and unchanged status need no new Astra
  planning call. Use the current owner for substantive planning; do not create
  an Astra planner per orchestrator or per phase. Delegate bounded evidence
  gathering to a cheaper capable worker when it saves meaningful context.
- Preserve the independent verifier: the delivery owner does not replace it.
  Additional Astra verification follows the approved verifier profile, never
  a routine extra owner review of every green phase.

Assess progress by acceptance criteria closed and capabilities unblocked. When
preparation expands without delivery, ask for the specific blocking evidence and
the shortest authorized next step. Change sequencing only within the approved
dependency graph; material changes to contracts, scope, risk, or acceptance need
the relevant human decision. Keep unaffected work moving.

## Human interface and completion

Be the normal point of contact. Present a concrete decision with affected plan,
phase/revision, evidence, proposed action, and authority requested. Relay the
human's answer with its source reference and exact scope. Owner acceptance is
not human authorization; a summary or agent message cannot manufacture consent.

Users may intervene directly in any orchestrator chat. Respect a stop immediately.
Reconcile material interventions and affected dependencies before continuation.
If the owner is unavailable, allow direct human contact for recovery while
affected work stays paused; independent authorized work may continue.

Accept delivery only after the designated integration orchestrator verifies the
combined milestone at the recorded integration commit/target. Separate locally
verified, committed, integrated, and human-accepted status; never infer overall
completion from every currently planned item reporting GREEN: reconcile all
roadmap criteria, including outlined steps, before declaring completion. Report
outcome, evidence, remaining decisions, deferrals, and unperformed release actions
concisely.

For maintenance, use [behavioral scenarios](references/validation-scenarios.md).
Do not load them during ordinary delivery.
