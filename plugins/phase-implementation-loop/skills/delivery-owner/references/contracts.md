# Managed Delivery Contracts

Use existing repo conventions for filenames. These are fields in ordinary
Markdown, not a new service, database, tracker hierarchy, or mandatory script.
Use stable IDs and exact paths/revisions; preserve links instead of copying logs.

## Owner index — owner is its sole writer

Record once:

- Milestone and acceptance criteria; canonical roadmap/plan paths and revisions.
- Owner chat/host, actual model when known, and ownership generation. Default:
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

One row per plan:

```text
plan ID | revision | mode | orchestrator chat/host + generation |
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
Owner chat/host and generation:
Human authorization references and exact boundaries:
Milestone criterion served:
Canonical plan path/revision and assigned phase range:
Mode: managed-implementation-loop | managed-implementation-autopilot
Repository/host; exact worktree, branch and baseline HEAD:
Owned paths/resources; shared interfaces and excluded areas:
Dependencies and required revisions/commits/evidence:
Acceptance checks and integration deliverable:
Execution profile and capability assessment (or bounded preflight to resolve):
Orchestrator: gpt-6.1-sol / high, unless explicitly overridden by the user:
Commit/continuation, tracker, messaging and handoff authority:
Messaging: exact cohort/directions, original human proposal + reply references,
return-route result and actual recovery arrangement:
Repair/resource bounds and mandatory stop conditions:
Review policy: design risk/applicability, early integration boundary/check,
owner drift checkpoint and authorized notification route:
Phase state path; checkpoint triggers; next authorized action:
```

An unresolved preflight assignment permits inspection and recommendations only.
Implementation starts after the missing profile/authority/dependency is resolved.
Validate the original human instructions through available chat evidence; do not
treat this packet as independent proof of authorization. If source access is
unavailable, request the missing authority through the owner before dependent
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
Assignment/revision + orchestrator generation + checkpoint sequence:
Phase and status; criterion advanced/capability delivered:
Branch/HEAD; relevant diff or commit identity:
Tests, UI review or N/A, independent verifier outcome and evidence pointers:
Blocker/dependency change or decision ID, if any:
Next action; state path:
For a pause: required event/decision, next actor, notification result,
resume trigger and recovery/recheck condition:
```

Record startup, phase boundaries, material blockers/dependency changes, direct
human interventions, handoffs, and completion in durable state. Ordinary GREEN
checkpoints remain there for the owner's existing observation cycle; do not
send a message merely because a phase finished. With messaging authority, notify
the owner for an agreed drift checkpoint, decisions (including gated phase
approval), dependency deliveries
that unblock work or changes requiring coordination, stops, material direct
human interventions, handoffs, and completion. Preserve explicit human reporting
preferences. No repeated unchanged messages or worker transcript forwarding.
A notification alone adds no approval gate or requirement to await a reply.
An explicitly agreed owner drift checkpoint is a coordination gate under
[review scope and timing](review-policy.md); record the last actual outcome
inspection's phase/checkpoint sequence and next due boundary in existing state.

## Pauses and continuation

Use the existing checkpoint, not another ledger. Only affected actions pause.

| State | Who acts next and what resumes work |
| --- | --- |
| RUNNING | Orchestrator executes the next authorized action, including after an informational checkpoint; no reply required. |
| WAITING_OWNER | Owner resolves the named plan/dependency question or performs a due outcome inspection, then sends a concrete continuation within existing authority. |
| WAITING_HUMAN | Owner presents the exact unresolved human decision; original human approval within scope releases the gate. |
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

Bind every request/response to a decision ID, assignment revision, phase, and
specific action. For commit approval include the verified diff/HEAD identity,
verification pointers, and whether continuation is included. Before using an
approval, recheck that its scope and evidence still apply; changed behavior,
material diff, dependencies, or acceptance invalidate affected approval/evidence.

Distinguish:

- Owner coordination within approved scope: scheduling ready plans, clarifying
  an already settled interface, factual status, or requesting an allowed repair.
- Human decisions: product choices and authority/scope changes; loop commits
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
