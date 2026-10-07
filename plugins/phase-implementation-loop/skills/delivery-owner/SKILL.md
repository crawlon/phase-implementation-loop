---
name: delivery-owner
description: Own the planning and delivery of one plan or a roadmap across managed implementation orchestrators, including progressive planning. Coordinate dependencies, prevent drift and maintain decision context; human execution approvals are requested in the executing chat. Supports observation without launch authority.
---

# Delivery Owner

Own the outcome and cross-plan decisions; let managed orchestrators own phase
execution. Use one owner for a single plan or a roadmap milestone containing
several plans. Default owner: **GPT-6.1 Sol High** (`gpt-6.1-sol`, reasoning
`high`), with bounded **GPT-6 Astra High** consultations for difficult decisions.
Explicit user model selections override these defaults. A skill cannot change
the current chat's model: record the actual model when exposed, otherwise unknown.
Disclose a mismatch and resolve it through supported controls or an authorized
handoff; never claim that reloading the skill switched an existing chat.

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
Read [Astra consultation](references/astra-consultation.md) only when an escalation
trigger below applies. Sol remains the sole delivery owner; human execution
approvals are requested directly in the chat performing the action.

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
   Separate hard human limits from owner-managed implementation boundaries under
   the contract. Avoid exact-file approval gates for routine caller/test changes
   unless required; never loosen already approved hard limits without authority.
4. For persistent orchestrator chats, obtain explicit human authorization to
   create those chats and worktrees, send owner-to-orchestrator and return
   messages, and perform successor handoffs if wanted. Name the managed cohort;
   unrelated chats are excluded. Peer-to-peer messaging is optional and requires
   its own human-authorized scope. Preserve links to the actual human instructions.
   If succession is wanted, include role-based messaging to verified replacements
   explicitly in that agreement; replacement chat creation remains a separate action.
   Establish the return route and recovery arrangement under
   [coordination](references/coordination.md) before relying on unattended replies.
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

## Supervise with a small owner context

- Own the [context-health policy](references/contracts.md#context-health-and-follow-up):
  include local checks and handoff responsibility in each assignment. Check your
  own context before substantial planning/dispatch, at outcome reviews, and before
  ending a substantive coordination turn. At existing reviews, inspect each
  orchestrator's recorded assessment; request a local check if missing/stale or
  behavior suggests confusion. Do not infer another chat's context usage.
- Read the index and new checkpoint deltas first. Orchestrators own routine
  exploration, diffs, tests, verification, retries, and local status updates.
  Do not request their reasoning transcripts or re-summarize unchanged evidence.
- Process events at startup, a decision/blocker, a dependency delivery, a phase
  checkpoint, handoff, or completion. An ordinary autopilot green checkpoint
  stays in durable state for observation. Notify for an agreed owner drift
  checkpoint or requested reporting, not every green phase. A notification alone
  adds no gate; the assignment explicitly names any coordination checkpoint.
- Prefer actionable messages over sustained owner polling. Use cursor waits for
  a specific imminent transition, not an entire implementation/review run.
  Before ending supervision, resolve available owner decisions and record who
  acts next and the actual wake/recovery route. Follow coordination's bounded
  waiting rules; a skill is not a scheduler.
- Default checkpoint payloads to roughly 150 words plus evidence pointers.
  Batch related human questions; preserve urgent blockers and all material risk.
  Never sacrifice evidence needed for a decision to meet a word limit.
- For a decision, read the relevant plan section and decisive evidence. Expand
  to full diffs/logs only for contradictions, material risk, suspected drift,
  or an acceptance claim that the compact evidence cannot establish.
- Handle routine planning, routing, scheduling, bookkeeping and outcome checks
  in the owner context. Consult Astra for unresolved consequential architecture
  or shared contracts, materially uncertain planning with competing approaches,
  repeated repairs indicating a faulty plan, or conflicting cross-plan evidence
  and materially ambiguous acceptance. Do not rely only on subjective confidence
  or consult automatically for every plan, phase or outcome checkpoint.
  Delegate bounded evidence gathering to a cheaper capable worker when useful.
- Preserve the independent verifier: the delivery owner does not replace it.
  Additional Astra verification follows the approved verifier profile, never
  a routine extra owner review of every green phase.

Resolve owner decisions in the receiving turn when evidence and authority allow;
dispatch the concrete continuation without waiting for a routine acknowledgement.
Do not let an orchestrator become a second manager of its peers. Each dependency
has one delivery actor and one decision owner. Informational checkpoints do not
stop authorized work; genuine waits use the contract's named state and resumer.

Assess progress by acceptance criteria closed and capabilities unblocked. When
preparation expands without delivery, ask for the specific blocking evidence and
the shortest authorized next step. Change sequencing only within the approved
dependency bounds. Classify working-plan refinements separately from changes to
human-controlled outcomes, acceptance, risk or authority. The owner resolves the
former; only the latter need missing human decisions. Keep unaffected work moving.

## Human interface and completion

Be the point of contact for planning and overall delivery. Follow the contract's
[decision routing](references/contracts.md#route-by-who-decides-and-who-executes):
the executing chat asks the human directly for its approvals. Ask here for your
own actions and canonical product/roadmap decisions; do not relay or duplicate
orchestrator approval requests. Maintain context through their checkpoint and
authorized awareness messages. No owner acknowledgement gate is added to valid
execution approval. Owner acceptance is not human consent.

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
