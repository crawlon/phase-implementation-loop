# Retained Planning And Workflow Agreement

Shared by the retained planner, owner and execution modes. Read at workflow selection
or adoption and for substantial planning/direction decisions; routine phases
reuse the recorded agreement. Legacy assignments adopt explicitly at a safe checkpoint.

## Selection and responsibility

Record explicit human workflow selection and one configuration in existing delivery
state: owner-managed execution, or standalone orchestration. In either configuration
record `retained planner: [verified binding] | none`. The human can start the
whole workflow once from the existing planner using [workflow startup](workflow-startup.md):
one standalone orchestrator by default, or an owner that launches managed execution
when continuing cross-plan coordination is useful. Reuse approved actors; do not
add another planner. Adding chats, messages, worktrees, trackers or schedules needs
original human authority for those actions and their scope. Selecting the workflow
does not require separate manual selection of every child skill.

The coordinator is the owner for managed execution and the invoking orchestrator
for standalone execution. It owns execution adoption/readiness, evidence disposition,
assignments and execution routing under its mode. The retained planner owns planning
content, canonical roadmap/plan edits, strategic rationale and its own notes. It
writes authorized planning documents directly or commissions a bounded edit-capable
subagent itself; the coordinator is not an editing relay. Its bounded startup launch
transfers execution dispatch, not planning ownership, after acknowledgement.

Record one writer for each planning document or explicitly separated section and
each execution resource. The planner integrates execution findings into plan revisions;
coordinators keep factual progress, evidence and adoption receipts in their own state
or assigned sections. Use concurrent section-level writes only with section-aware
edits/merging that preserve concurrent changes; otherwise serialize all writes to
the physical document across roles. For a delegated edit, the planner gives the subagent exclusive
temporary custody of the named paths/sections, suspends overlapping writes, inspects
the diff and reclaims custody at terminal completion. Planning writes do not include
source code, owner indexes, execution state or tracker fields assigned to other roles.

A plan revision is a proposal for execution until the coordinator records its
adoption against existing authority. Keep the active assignment bound to a retrievable
adopted revision in existing version history/state, not the latest mutable document.
Before affected work changes, reconcile dependencies, safely settle affected
in-flight work, acknowledge the changed assignment and revalidate only affected checks
or approvals. Unchanged authorized work continues. Neither the coordinator nor its
worker rewrites planner-owned content; send the concrete conflict or requested change
to the planner. With no retained planner, the coordinator owns planning under its
existing fallback; standalone substantive plan edits still use an edit-capable worker.

The coordinator may adopt a supported revision only within existing authority.
Fixed outcomes, acceptance, compatibility obligations, hard limits and reserved
human choices remain human-controlled. The planner neither grants execution
authority nor replaces independent verification. A design author cannot provide
its independent review. A strategic recommendation is not a verification waiver.

With a retained planner, apply the request scope check below for substantive
roadmap/next-plan proposals and direction reviews. Keep bounded technical
consultation separate when its specific question justifies it.
Without a planner, the delivery owner follows progressive planning with consultation
when needed; standalone uses its existing bounded planning/fallback route.
Do not launch both routes for routine comparison or silently replace an unavailable
retained planner. Pause only a decision that genuinely requires its unresolved
input; continue independent work. Disclose a missing route and the precise recovery
need. A different planner/provider requires the corresponding established authority.

## Delegation within each role

Each role directly commissions and supervises subagents for work within its own
responsibility; another retained role is not a relay or approval gate for that work.

| Commissioning role | Supporting work it owns |
| --- | --- |
| Planner | Research, read-only repository investigation, option/dependency analysis, plan drafting/edits and challenges to planning assumptions. It checks findings and owns canonical planning content and notes. |
| Owner | Delivery/dependency analysis, milestone evidence assessment and bounded advice for owner decisions; progressive planning when no retained planner is selected. It retains canonical plan adoption and assignments. |
| Orchestrator | Execution investigation, technical consultation within its assignment, separate implementation workers, checks and independent review under its execution protocol. |

Before delegating, reuse current evidence and check the relevant delivery brief
for overlapping active work. Keep small tasks local. Use bounded read-only
subagents for research/analysis/drafts; a planner may instead authorize a planning-only
editing subagent under the custody rule above. Return results to the commissioning
role, which checks decisive evidence and owns the resulting judgment. Use the approved
[role profiles](../../implementation-orchestrator/references/shared-protocol.md#role-profiles).
Use shared [Consultant selection](../../implementation-orchestrator/references/shared-protocol.md#consultant-selection)
when a material planning assumption, architectural boundary or disputed evidence
would benefit from a stronger challenge. Ask for the strongest objection and
the evidence that would settle it. The planner owns the resulting recommendation
and plan edits. Apply any required independent design review through its existing gate.

A brief names the question/result, sources, constraints and completion condition.
The commissioning role owns the handle and follows the
[terminal lifecycle and supervision rules](../../implementation-orchestrator/references/delegated-jobs.md#terminal-lifecycle),
records findings and open follow-ups in its existing state, and settles its own
jobs before handoff. Preserve original model/fallback selections, provider consent,
access limits and successor coverage; delegation adds no retained chat or authority.
Reserve execution/reviewer capacity rather than creating recursive managers.

Route a decision to another role only when it crosses that role's boundary.
Execution tests, runtime operations, prototype edits and shared implementation
changes go through the executing orchestrator and its gates. Canonical planning
edits stay with the planner when selected; execution adoption stays with the coordinator.
A planner's read-only
investigation is not permission to run the project or direct execution workers.
Keep routine subagent exchanges local; send only relevant findings, decisions or
changed dependencies to other retained roles. Design authors and their contributors
cannot supply the required independent review of their own work.

## Request scope and routing

The same check applies to requests from an owner or, with no owner, the standalone
orchestrator. Before contacting the planner, the coordinator identifies the
unresolved decision and its effect on the goal/roadmap, its proposed action or
specific missing evidence, and why strategic input is needed. Use a concise
request in existing state/messages, not another form or ledger. Difficulty choosing
or seeking reassurance alone is not an escalation trigger.

The planner classifies the request before loading detailed evidence or answering:

| Request | Responsible response |
| --- | --- |
| Roadmap assumptions, next planning frontier, milestone strategy, cumulative delivery direction or substantive planning-content edits | Planner assesses, authors the revision within planning authority and supplies the execution-relevant delta to the coordinator. |
| Specific architecture choice, debugging or technical uncertainty | The role owning the decision commissions warranted technical consultation directly: orchestrator within its assignment, owner for cross-plan or reserved delivery decisions. Reuse settled guidance; routine diagnosis stays with execution. |
| Routine sequencing/scheduling, settled elaboration or an unchanged decision | Coordinator decides within its authority, reusing recorded guidance. |
| Implementation tactics or test execution | Executing orchestrator handles it through its existing worker/execution protocol. |

For a misplaced request, the planner declines substantive advice and returns one
brief scope explanation, responsible role and concrete next action through the
existing authorized route. It does not answer the technical question as a courtesy,
forward it to execution workers or commission its diagnosis. This does not restrict
direct planning support under Delegation within each role;
reserved human decisions and actual execution gates remain unchanged.

For mixed questions, address the strategic consequence and separate the technical
diagnosis. If the latter is decisive, name the bounded evidence needed from the
consultant before the affected recommendation. Genuine strategic questions or
observed drift remain in scope even when the coordinator cannot propose a solution;
clarify only a decisive missing fact, not formatting. On repeated requests with
unchanged evidence/constraints, point to the recorded answer rather than reopening
analysis or consulting another actor. Material new evidence reopens the appropriate
route. Declining a request adds no planner-signature gate to valid execution.

## Agreement and evidence

Use the shared [current brief](../../delivery-owner/references/contracts.md#current-snapshot)
in existing role state, with linked assignment and directory fields. Record the
workflow version/configuration and original selection/action authority; coordinator
and optional planner bindings/profiles; planning writers, adopted execution revision and authorized note
paths; delegated decisions, limits and gates; required outcome reviews versus
advisory triggers; message-purpose/successor authority and actual route results;
and optional heartbeat identity, binding, scope and lifecycle. No additional ledger.

Keep rationale, rejected alternatives and assumptions in the canonical plan or
linked planner notes. Historical decisions remain evidence; a retained chat is
not the sole durable source. The brief preserves current criterion coverage,
learning/blockers, assessment/rationale, next outcome/actor and context health.

At reviews, locate evidence through the coordinator snapshot but read the latest
relevant phase checkpoints directly when accessible. Identify plan/checkpoint
revisions and running jobs; do not assume an old summary describes current work.
If sources disagree, resolve the decisive gap before recommending dependent action.
Load logs/diffs only for a named question; technical transcripts are not routine
planner inputs. A fresh retained-planner generation starts from this concise state.

## Direction reviews

For each execution assignment with a retained planner, the planner and delivery
coordinator set a named Planner review checkpoint tied to an observable outcome,
and a maximum interval between Planner reviews during active work. The coordinator
is the owner in managed delivery and the orchestrator in standalone delivery.
Record both in the coordinator's existing current brief with the last substantive
Planner review and the actual authorized wakeup or manual recovery route. A managed
assignment may link to a shared review entry that explicitly covers its outcome.

Review when the checkpoint is reached or the interval is due, whichever comes
first. The coordinator uses the existing outcome update and recorded route to
surface the checkpoint with a brief pointer and relevant independent verifier
evidence on repository adherence, including material deviations or gaps. Measure the
interval from the last substantive Planner review or the start of execution for the
first review. Use the existing brief and linked evidence, including relevant Owner
outcome evidence. Coalesce
coincident triggers and reuse an equivalent current Planner assessment that covers
the trigger, including any material delay. After a substantive review,
record its coverage and the next checkpoint in the same brief through the current
writer. Coordinators continue their existing outcome checks and execution decisions.

Review sooner when assumptions change, preparation expands, repairs add no
learning, or the next capability is repeatedly postponed. Compare cumulative
work with the **last meaningful capability milestone**, as well as the previous
review. A series of individually justified repairs can still make the overall
approach inefficient. Ask:

- What capability advanced and necessary uncertainty was resolved? What remains?
- Which added prerequisites are necessary for this capability to work safely,
  and which belong before broader adoption or release?
- Is this still the shortest credible route to the fixed goal? What alternative
  sequence or approach merits consideration, and what evidence would decide?
- Do the cumulative changes, including interacting repairs, still follow the
  applicable current repository principles at the affected boundaries?
- Continue, change approach or pause affected work: what observable result comes
  next, and who delivers it?

Reuse the verifier's evidence when judging cumulative adherence. Record the
applicable rule or contract pointers and the code revision or diff covered in
the existing review. If a material gap could change the recommendation, give one
bounded read-only subagent the affected rules and the change range from the last
relevant review or meaningful milestone to the current candidate, including any
in-scope uncommitted changes. Ask where the changes accumulated, which rule may
be at risk, and whether the next planned step could deepen the deviation. Treat
change distribution as a lead and confirm it against affected code and evidence.
Use the existing repair or decision route
for a confirmed deviation or a proposed exception to a current requirement.

Challenge the plan as well as execution. Activity/test counts alone are not
progress. Preparation needs an evidenced blocker and observable exit. Required
assurance and useful learning remain valid even before product behavior appears.
Reordering is a proposal: preserve deferred criteria and their acceptance gates,
obtain the relevant owner/human decision, and continue independent authorized work.

Two preparation-only phases or growing tooling effort retain the local critical-
path check. Two materially similar red repair cycles without new evidence retain
the execution stop. Ask the retained planner about a disputed approach when local
checks cannot justify continuation; advice neither resets repair bounds nor
releases gates. A long required verifier job is not itself drift; its supervisor
settles the same handle.

Estimates are revisable. Review intervals trigger assessment, never deadlines or
automatic stops. Propose operational limits only for a specific resource, safety,
cost or human requirement, with basis and recovery. Existing explicit human limits,
repair stops and approval gates remain binding until validly amended. Mention
limits when they affect the decision, rather than repeating unchanged counters.

Return a compact advisory result with decisive pointers:

```text
Goal/plan/checkpoints reviewed; evidence limits:
Last meaningful capability milestone -> current capability, learning and blocker:
Cumulative prerequisites: needed now vs before broader adoption; approach assessment:
Repository adherence: affected boundary, evidence, and any material deviation or gap:
Judgment: continue | change approach | pause affected work | need decisive evidence
Reason, alternative if warranted, next observable result/actor and decisive evidence:
Relevant authority/safety/resource boundary or human decision, if any:
```

The coordinator records adoption, evidence-based rejection or the exact unresolved
question and resumer before more affected work. Advice, delivered messages and
silence are not owner outcome inspection, independent PASS or execution approval.
Absent advisory input adds no gate to otherwise valid work; real decision/review
gates pause only dependent actions.

## Wakeups and economical coordination

Notify once for a recommendation, planning delivery, material risk, required
decision or authorized binding change. Use the current directory and actual
message-purpose authority; keep routine activity in state. The planner neither
dispatches execution workers nor supervises another actor's jobs; it supervises
its own planning subagents directly.

Use a suitable authorized native heartbeat for timed oversight when available.
Otherwise record a manual check at the backstop and who will prompt it.
At each wakeup first check changed checkpoint/binding/gate status and the recorded
recovery condition. If the assignment is waiting on the same human decision, no relevant evidence
changed and no recovery trigger is due, retain the last meaningful assessment and
return quietly without rereading the investigation or rewriting notes. Likewise
reuse an equivalent current/in-flight review. A new risk, failed route, changed
dependency or material delay requires assessment even if the headline status is
unchanged; never hide the first required human action or an unusable route.

For active work, perform the due cumulative review even without a help request.
Choose cadence for the workload; changing or backing it off must respect the
scheduling agreement and use authorized native controls. Preserve prompt/model,
scope, notification settings and lifecycle. At completion, cancellation, workflow
exit or succession, disable/rebind only within authority and record the actual
target/result. A missing scheduler or trusted route requires explicit manual
recovery, not a timed-wakeup promise.


## Adoption and switching back

Read [migration](migration.md) when moving an existing assignment to this bundle
or rolling back. Select the exact bundle/role and reconcile at a safe checkpoint
after each adopting actor settles its own jobs. Preserve workspace/HEAD, dirty
ownership, accepted evidence, failed attempts, repair bounds, pending approvals,
original provider/communication/launch authority and next step. Installation or a
renamed skill neither migrates a running assignment nor adds permissions.

Record the exact role skill/path, bundle version, planning/execution writers and separate
coordination/execution settings. Acknowledge changed assignments before dependent
execution. Existing frozen order, hard limits and due owner inspections survive;
resolve missing/conflicting bindings read-only. The coordinator remains sole
execution dispatcher; planner delegation stays within planning responsibility.
When adopting changed planning ownership, use the writer transfer in the migration
guide before any new writer edits; publishing a skill does not transfer live custody.

Reliable chats may adopt in place. Otherwise use an already-authorized fresh
handoff, preserving exclusive claims, original selected models and verified
communication/heartbeat bindings. No duplicate actor, restarted phase, automatic
commit or replay of valid audits. Rollback also reconciles the destination role
contract and any differing planner ownership; it never silently revives old grants
or changes the current assignment's approval mode.
