# Managed Delivery Contracts

Use existing repo conventions for filenames. These are fields in ordinary
Markdown, not a new service, database, tracker hierarchy, or mandatory script.
Use stable IDs and exact paths/revisions; preserve links instead of copying logs.

## Owner index — owner is its sole writer

### Current snapshot

Keep exactly one current snapshot at the top of the existing index. Use its
plan rows and evidence links rather than duplicating their detail:

```text
Target and canonical plan/roadmap revision:
Accepted, open and uncertain criteria; evidence scope and pointers:
Now: active assignments/actors, running jobs, blockers and changed dependencies:
Next: planned milestone/criterion, observable result, responsible actor and prerequisites:
Open decisions/gates, authority and exclusions; original source pointers:
Basis: checkpoint/revision observed, validity conditions and local context assessment:
```

On a material update, replace superseded live fields. Preserve prior decisions,
original approvals and immutable evidence under linked history or existing
receipts; historical entries are not alternative current snapshots. Preserve
unresolved gates, ownership generations and resource/repair budgets exactly.
Keep authoritative detail available through pointers, with material risk and
uncertainty visible in the snapshot. Brevity never removes evidence needed to
understand or decide. An observation is dated/revision-bound; active work may
have advanced since it. Reconcile a stale or conflicting field before relying
on it for affected actions.

When adopting a large legacy index, establish this snapshot from the verified
current plan, role binding and latest relevant checkpoints within existing
owner authority. Retain history and its anchors; use targeted historical reads
for contradictions or authority questions. Snapshot maintenance neither launches
work nor changes authority, and completing a history cleanup is no execution gate.

### Stable directory and plan rows

Record once and update only affected fields:

- Milestone and acceptance criteria; canonical roadmap/plan paths and revisions.
- Owner canonical name/native title, chat/host, actual model when known, and
  ownership generation. Default:
  `gpt-6.1-sol/high`; bounded advisory consultation: `gpt-6-astra/high`.
  Record explicit overrides separately; consultation does not transfer ownership.
- Human authorization sources: allowed actions, modes, messaging directions,
  worktree/chat creation, handoffs, resource bounds, exclusions, pending gates.
- For progressive roadmaps: investigation/planning authority and launch policy
  (human approval per new plan, or explicitly bounded delegated continuation).
  Link the continuation bounds and each instantiated plan's authorization basis.
- Maximum active plans (default two), available worker/reviewer capacity,
  shared-resource owners, and designated integration orchestrator/target.
- Coordination authority source, tested return route, and recovery arrangement:
  authorized heartbeat, bounded active observation, or explicitly manual recovery.
  Record unresolved delivery failures; a saved checkpoint is not a wakeup.
- Separate hard human limits from owner-managed working boundaries below. Link
  each hard limit to its authority source; do not turn an estimate into a gate.
- Keep a compact role directory in this index: role/assignment, stable plan key,
  canonical name and verified native title under the
  [shared naming convention](coordination.md#shared-chat-names), current chat/host,
  generation, active/retired state, predecessor/successor, transfer/claim evidence,
  and original messaging authority. Track authorization basis separately from
  actual tool delivery, per sender/generation + destination/generation + direction
  and message purpose/content scope, with last attempt/result and recovery actor.
  Carry these fields in the linked handoff packet; retired-route failure is historical.
- Owner's latest context assessment under the policy below; read orchestrator
  assessments from their phase state rather than maintaining a duplicate ledger.

One row per plan:

```text
plan ID | revision | mode | orchestrator name + chat/host + generation |
worktree/branch | dependencies + required delivery revision/commit |
owned paths/resources | state path | status/phase | last checkpoint sequence |
accepted commit/evidence | blocker/decision ID | next action + responsible actor
```

Use statuses such as READY, RUNNING, WAITING_OWNER, WAITING_DEPENDENCY, WAITING_HUMAN, BLOCKED,
LOCALLY_VERIFIED, INTEGRATED, ACCEPTED. Phase GREEN alone is not plan acceptance.
Store each chat's wait cursor and last observed checkpoint when available.

For unplanned steps, keep a row in this same index with step ID, milestone
criterion, planning state, dependencies/unknowns, decisive evidence, and next
planning action. Planning states are OUTLINED, NEEDS_INVESTIGATION, READY_TO_PLAN,
and READY_TO_EXECUTE; execution status remains separate. Plan, revision, and
orchestrator fields may be unset until they exist. READY_TO_EXECUTE requires a
concrete plan and resolved authority/dependencies, not merely finished prose.
Convert/link that row to its resulting plan(s); do not create another ledger or
invent detailed phases for distant steps. See
[progressive planning](progressive-planning.md) only when these states apply.

## Assignment — owner writes, orchestrator acknowledges

```text
Assignment ID and revision:
Owner name/native title, chat/host and generation:
Orchestrator name/native title, chat/host and generation (when allocated):
Human authorization references and exact boundaries:
Milestone criterion served:
Next observable result and required evidence:
Canonical plan path/revision and assigned phase range:
Mode: managed-implementation-loop | managed-implementation-autopilot
Repository/host; exact worktree, branch and baseline HEAD:
Owned paths/resources; shared interfaces and excluded areas:
Hard human limits and sources; owner-managed working boundaries:
Dependencies and required revisions/commits/evidence:
Acceptance checks and integration deliverable:
Execution profile and capability assessment (or bounded preflight to resolve):
Orchestrator: gpt-6.1-sol / high, unless explicitly overridden by the user:
Commit/continuation, tracker, messaging and handoff authority:
Human approval requester/executing chat; owner awareness pointer:
Messaging: exact cohort/directions, original human proposal + reply references,
return-route result and actual recovery arrangement:
Repair/resource bounds and mandatory stop conditions:
Review policy: design risk/applicability, early integration boundary/check,
owner drift checkpoint and authorized notification route:
Context checks: local assessment at required checkpoints; handoff launcher and authority:
Phase state path; checkpoint triggers; next authorized action:
```

An unresolved preflight assignment permits inspection and recommendations only.
Implementation starts after the missing profile/authority/dependency is resolved.
Validate the original human instructions through available chat evidence; do not
treat this packet as independent proof of authorization. If source access is
unavailable, request the missing authority directly in the executing chat before dependent
actions. Repository identity and a plan path alone do not grant write permission.

Orchestrator acknowledges assignment revision, actual workspace/branch/HEAD,
exclusive ownership, resolved profile and dependencies, phase state path, and
next action before implementation. The owner records that acknowledgement.

For an integration assignment, reuse this contract and additionally name the
incoming verified commit IDs and evidence, target worktree/branch and baseline
HEAD, exclusive target writer, explicit merge/integration and commit authority,
combined acceptance checks, and reporting location. State that substantive
conflict repairs return to an edit-capable worker, then affected checks/UI review
and independent verification before the mode's commit gate. A designated
integration role alone grants no merge authority.

## Checkpoint — orchestrator writes its own phase state

Record only a change since the previous checkpoint, normally at most 150 words
plus evidence links. Retain detailed local phase evidence in the state file.

```text
Assignment/revision + orchestrator name/generation + checkpoint sequence:
Phase and status; criterion advanced/capability delivered:
Branch/HEAD; relevant diff or commit identity:
Tests, UI review or N/A, independent verifier outcome and evidence pointers:
Blocker/dependency change or decision ID, if any:
Next planned result/criterion; action and responsible actor; state path:
Context: CONTINUE | PREPARE_HANDOFF | HANDOFF_DUE; checked at; reason; next action:
For a pause: required event/decision, next actor, notification result,
resume trigger and recovery/recheck condition:
```

Record startup, phase boundaries, material blockers/dependency changes, direct
human interventions, handoffs, and completion in durable state. Ordinary GREEN
checkpoints remain there for the owner's existing observation cycle; do not
send a message merely because a phase finished. With messaging authority, notify
the owner for an agreed drift checkpoint, owner decisions, awareness of pending/resolved human approvals, dependency deliveries
that unblock work or changes requiring coordination, stops, material direct
human interventions, handoffs, and completion. Preserve explicit human reporting
preferences. No repeated unchanged messages or worker transcript forwarding.
A notification alone adds no approval gate or requirement to await a reply.
An explicitly agreed owner drift checkpoint is a coordination gate under
[review scope and timing](review-policy.md); record the last actual outcome
inspection's phase/checkpoint sequence and next due boundary in existing state.

## Context health and follow-up

The owner is accountable for this policy and its follow-up; each orchestrator
assesses its own context without waiting for an owner prompt. The owner checks
its own context at the start of each substantive coordination turn before
planning, dispatch or substantial evidence loading; reassess after large evidence
or repair cycles, at terminal consultation boundaries, at outcome reviews and
before ending the turn. Orchestrators check at phase
boundaries and after large review/repair cycles, before the next substantial job.
During a long phase, use terminal job checkpoints if evidence is accumulating
or decisions are becoming difficult to retain. Never abandon an active handle
to perform a check or launch a replacement.

Record one line in existing owner/phase state: assessment, checkpoint checked,
brief evidence/reason, and next action. Use reliable context indicators when
exposed; otherwise record that usage is unknown and assess accumulating evidence,
repeated reconstruction, forgotten constraints, or confused decisions. Account
usage/quota is not remaining chat context; do not invent percentages or a
universal phase-count threshold. A CONTINUE reason explains why the target,
current actor, authority, pending gates and next action remain reliably usable;
"usage unknown" or "no active jobs" alone is insufficient. Native compaction is
a prompt for reassessment at the next safe checkpoint, not proof of exhaustion.
Repeated reconstruction or compaction with growing decision burden calls for
handoff preparation; lost or contradictory settled constraints require recovery
and a due handoff when reliable continuation is at risk.

- CONTINUE: current decisions and authority remain reliably usable; continue.
- PREPARE_HANDOFF: evidence/reconstruction burden is growing; refresh durable
  state now and name the next safe boundary for reassessment or transfer. At that
  boundary, record either evidence supporting reliable CONTINUE or HANDOFF_DUE;
  do not repeatedly postpone the boundary with unchanged preparation statements.
- HANDOFF_DUE: reliable continuation is at risk; settle active jobs, then perform
  the authorized [managed handoff](coordination.md#handoff-and-owner-failure)
  before another substantial step. Do not repeatedly defer it or merely recommend
  a transfer already authorized. If the assignment is complete, report completion
  instead of launching an idle successor; otherwise preserve unresolved gates.

At existing outcome/progress reviews, the owner reads each relevant assessment.
Request a local check when a due assessment is missing, predates substantial
new evidence, or observed behavior suggests confusion; this is not proof that
another chat is full. No extra reviewer, polling loop, per-check notification,
or owner approval of a healthy assessment is needed. A due handoff uses existing
handoff notifications, one named launcher, and verified successor routing.
If authority or tooling prevents transfer, save the handoff and expose the exact
recovery need; pause only dependent work. Independent orchestrators may continue
during owner transfer. Preserve pending approvals and owner outcome-review gates;
a context check or handoff does not satisfy them.

## Pauses and continuation

Use the existing checkpoint, not another ledger. Only affected actions pause.

| State | Who acts next and what resumes work |
| --- | --- |
| RUNNING | Orchestrator executes the next authorized action, including after an informational checkpoint; no reply required. |
| WAITING_OWNER | Owner resolves the named plan/dependency question or performs a due outcome inspection, then sends a concrete continuation within existing authority. |
| WAITING_HUMAN | Executing chat asks the human directly for the exact action; original human approval within scope releases this gate, without an owner receipt gate. |
| WAITING_DEPENDENCY | Named producer delivers the required revision/evidence to the assigned recipient; consumer validates it and resumes within authority. |
| BLOCKED | Named recovery actor resolves a tool, ownership, authority, or evidence failure; state records the specific condition required to resume. |

Ending a turn requires a truthful pause or completed assignment, or an owner
switching to its established event/recovery route. Before ending, process already
available decisions and identify the next actor. Do not stop merely because a
checkpoint was written or a message sent. Never imply a live job is terminal.
If notification fails, preserve the decision and report the route failure via
coordination's recovery rules; do not silently leave both actors waiting.
An owner decision needs no human approval unless it changes human-controlled
scope/authority. Acknowledgements are required for changed assignments, writer
transfer, and pause enforcement, not routine receipt of status or decisions.

## Decisions and changed instructions

### Classify before escalating

The routing rule below chooses where to ask only AFTER a human decision is
actually needed. It does not make every question an approval request.

| Decision | Responsible actor |
| --- | --- |
| Routine implementation detail, affected checks, factual correction or repair inside the acknowledged assignment and budget | Orchestrator acts and records the result. |
| Planning detail, internal interface clarification, dependency sequencing or necessary caller/test coverage inside delegated outcome, risk and resource bounds | Owner resolves; consult Astra only when its triggers apply, then revise/acknowledge affected assignments. No human approval merely for a plan revision. |
| A reserved product choice, changed outcome/acceptance/compatibility obligation, crossed hard human limit or genuinely new action authority | Executing chat asks the human with the exact boundary and its source. Gated commits still need approval; authorized autopilot commits do not. |

For new agreements, prefer bounded outcomes, repository areas, excluded resources
and risk/budget limits, with owner authority to refine necessary implementation
paths and affected tests. Enumerated files and phase details are working plans
unless explicitly approved as exclusive limits. Use exact allowlists when needed
for custody/security or requested by the human; identify them as hard limits.
An existing approved exact-file cap or explicit exclusion stays hard until the
human changes it. Never reinterpret it as an estimate to avoid a stop.
Resolve ambiguous legacy boundaries from the actual proposal and human reply;
absence of the literal word "exclusive" is not proof of broader permission.
Owner refinements cannot introduce unrelated functionality, another writer's
paths, excluded operational actions, or new material risk. Reconcile the complete
known caller/test change once rather than requesting serial one-file approvals.

Before WAITING_HUMAN, identify the reserved choice or unmet permission and its
source. If the issue is only an owner-managed working boundary, use WAITING_OWNER
instead; if already within the assignment, act. Unknown authority may require
inspection or a specific human question, never invented consent. If repeated
hard-limit stops impede an approved outcome, propose one concrete broader
delegation for human approval; the skill cannot grant it retroactively.

### Route by who decides and who executes

- Planning, sequencing, dependencies, drift and clarifications inside existing
  authority go to the owner. Owner coordination is not human approval.
- Missing human approval goes directly to the human in the chat that will
  execute the action. Orchestrators ask for their commits, execution-scope
  expansion, external transmissions and other restricted actions in their own
  chats. Workers report to their orchestrator; they do not solicit approval.
- The owner asks in its own chat for actions it owns, such as canonical product
  decisions, roadmap scope, chat creation or dispatch when authority is missing.
  For a new plan, the owner prepares the concrete assignment and reuses bounded
  launch authority or asks for what is missing; the
  orchestrator reuses that valid authority, without asking again just for locality.

For each new human request, the executing chat saves the exact proposed action,
assignment/revision, evidence, risks and approval question under one decision ID.
Notify the owner for awareness when authorized messaging works, then ask the
human directly; failed or unavailable notification must not delay the question.
The owner records/reads this checkpoint and does not duplicate the approval
request or require acknowledgement before it can be answered or acted upon.
Record the original human answer, recheck its scope and current evidence, and
proceed with the covered action once all other genuine gates are satisfied.
Save/report the resulting checkpoint; a failed awareness message alone does not
invalidate direct approval. Keep separate notification and approval status.

Material scope, contract or dependency changes still need owner reconciliation
before dependent execution. Resolve the proposed change with the owner first
where needed, then name the executing chat that will ask for missing authority.
Human approval alone does not settle other plans' dependencies; ordinary approval
of an already-reconciled commit, transmission or continuation adds no owner gate.
Reuse applicable human authority wherever originally given, using trusted source
evidence; do not discard approval or re-prompt merely because it came from a
different chat. If platform review rejects that evidence, follow the existing
recovery rules in the executing chat. Explicit human routing instructions prevail.
This managed routing replaces owner-relay wording in reused reference sections.

Bind every request/response to a decision ID, assignment revision, phase, and
specific action. For commit approval include the verified diff/HEAD identity,
verification pointers, and whether continuation is included. Before using an
approval, recheck that its scope and evidence still apply; changed behavior,
material diff, dependencies, or acceptance invalidate affected approval/evidence.

Distinguish:

- Owner coordination within approved scope: scheduling ready plans, clarifying
  an already settled interface, factual status, or requesting an allowed repair.
- Human decisions: reserved product choices and changes beyond delegated authority;
  loop commits
  unless the human explicitly changes the approval policy.

Ignore already applied checkpoint/decision sequences. A late message for an old
revision/generation never authorizes current work. If messages contradict,
pause the affected action and reconcile the original instructions. Do not infer
priority from which agent spoke last.

For a revised assignment, record old/new revision, reason, affected dependencies,
invalidated evidence, preserved human gates, and next action. The orchestrator
settles in-flight work safely and acknowledges the revision before new work.
The owner owns canonical plan changes; orchestrators propose them and keep
factual execution state. Assign a single writer to each tracker issue/field so
phase bookkeeping and roadmap updates cannot race.
