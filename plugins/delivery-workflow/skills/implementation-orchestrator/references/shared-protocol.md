# Shared Phase Protocol

The implementation orchestrator uses this protocol. Its recorded coordination
selects standalone ownership here or the managed overlay; its recorded execution
setting selects gated or autopilot authority in [execution modes](execution-modes.md).

Workflow selection/adoption reads the
[workflow agreement](../../roadmap-planner/references/retained-planning.md).
An optional retained planner owns planning content/edits without adding an owner.
Reuse the recorded configuration and permissions in ordinary phases.

## Role Contract

The orchestrator owns execution reconciliation, routing, supervision, diff inspection,
tests, verification gates, commits, and reporting. It may directly maintain
factual phase status, receipt links, commit ids, and handoff summaries. Delegate
implementation and operational scripts to an edit-capable worker; substantive
verification remains independent. Planning edits follow Planning And Replanning
and the shared workflow agreement. A correction
to permissions, acceptance, dependencies, or evidence meaning is substantive
even in Markdown. Factual bookkeeping must not upgrade an evidence claim.

The invoking surface qualifies as orchestrator only when it can inspect the
workspace/diff, run required checks, supervise delegated jobs, and enforce the
active mode's git gates. Otherwise stop before Phase 1 and hand off to a capable
orchestrator.

Keep the invoking agent as orchestrator; no fixed model or maximum reasoning is
required for this role.

The orchestrator owns execution decisions and adoption of a plan revision within
authority. A retained planner owns canonical planning content; without one, use
Planning And Replanning below. Routine status updates,
evidence reconciliation, and critical-path checks need no planning agent.

Codex implementation always runs as a separate worker subagent. It must never be
the orchestrator's current context or a user-owned task/thread created as a
substitute for a worker. Agent output is advisory until the orchestrator inspects
the actual workspace and evidence.

Implementation and verification are separate roles. A verifier must not have
implemented the phase. Do not ask delegated agents to commit, push, deploy,
handle secrets or credentials, approve prompts, or perform destructive or live
actions.

For a UI-affecting phase, UI/UX review is a separate non-editing role. Its
findings return to an edit-capable implementation worker; the orchestrator
inspects the follow-up diff and evidence before deciding GREEN.

## Delivery And Evidence Discipline

Optimize for verified delivery of the approved outcome, not completion of an
expanding verification process. Add two short fields to the existing phase brief:
`capability delivered/blocker removed` and `criterion/invariant served`.
A new prerequisite must show why that criterion or safety invariant cannot be
met without it, with evidence. Otherwise schedule it as a nonblocking follow-up;
preserve the full end goal and all explicitly required dependencies.

Distinguish usable capability/current environment, repeatable setup/recovery,
and production hardening. Do not assume earlier milestones require every later
assurance. At each accepted milestone, state what is unblocked and advance the
next authorized critical-path step. Changing frozen order, dependencies, scope,
or acceptance materially still requires the active mode's approval.

Record accepted evidence's scope, target, relevant code/configuration and
conditions, and invalidation triggers in the existing state summary. Reuse it
until a relevant change or contradictory evidence invalidates it; recheck the
affected boundary only. A new agent re-establishes workspace, ownership, target,
and evidence conditions, without automatically replaying whole audits. Status
prose, receipt pointers, or unrelated commits do not invalidate runtime evidence;
preserve any material safety binding and immutable historical receipts.

At terminal job/checkpoint boundaries, including within unfinished phases, apply
the [direction-review triggers](../../roadmap-planner/references/retained-planning.md#direction-reviews)
for expanding preparation, postponed results and repairs without new learning.
A retained planner reviews cumulative evidence when local checks cannot justify
continuation; its advice does not release a gate or reset a repair bound.

After two consecutive preparation-only phases, or growing tooling/review effort
without closing capability criteria, the orchestrator briefly reassesses the
critical path against the last meaningful capability milestone, including
accumulated prerequisites and whether a different sequence would reach the fixed
goal more directly. Use the shared direction review; continue evidenced preparation;
otherwise schedule it as follow-up and advance authorized work. This checkpoint
requires no additional planner, artifact, tracker hierarchy, or approval cycle.
It does not authorize changes to frozen order or dependencies.

## Review Boundaries And Outcome Checkpoints

At startup, shape phase boundaries under `phase-capability.md` and record the
applicable checks in the canonical plan and existing state. The common design
and integration rules below apply to both standalone and managed execution;
their assignment/decision ownership remains with the active workflow. Standalone
orchestrators need no delivery owner, extra chat, fixed model or ledger. Managed
workflows retain their own outcome-review timing, not a second checkpoint cycle.

### Consequential design review

Before implementation relies on a novel shared contract, irreversible migration,
or similarly consequential design, obtain one independent read-only review of
the decision and dependent assumptions. Record the triggering risk, precise
question, design revision, affected work, evidence and required checks. The reviewer must not have
authored the design. Use the approved verifier route and verdict/repair/fallback
rules in `delegated-jobs.md`, with the Design Review prompt in `agent-prompts.md`.
Reuse equivalent valid prior review; routine settled designs need no extra call.
Exploratory planning is not independent verification of its own proposed design.
Resolve blockers before affected implementation; a design PASS grants no action
authority and does not replace phase implementation verification. If a triggering
risk appears later, apply this gate before further dependent work.

### Early integration check

For interacting phases/plans, identify the earliest executable shared boundary,
concrete compatibility check, required input revisions/commits, responsible actor,
authorized target and dependent work. Run that check
as soon as verified inputs are usable together, before dependent expansion, not
only at plan completion. Split/revise a phase under existing authority if needed
to expose that checkpoint before a large dependent implementation. Record exact
input revisions, target, result, and evidence invalidation conditions. A missing
or failing required check blocks its consumer under the active mode; do not use
a local phase PASS as evidence for an untested interaction. Reuse still-valid
boundary coverage at completion while performing remaining combined checks;
an early PASS is narrow evidence, not final combined acceptance. Use the active
workflow's integration assignment/authority; worktree isolation alone proves no
compatibility and grants no merge or live-service permission.

### Standalone outcome checkpoints

For long plans, name meaningful delivery milestones for a compact cumulative
outcome check. At each named boundary or authorized scheduled review, the same
orchestrator applies the shared [goal-progress assessment](../../roadmap-planner/references/retained-planning.md#direction-reviews)
to cumulative evidence, including unfinished work: capability/necessary learning,
remaining blocker, convergence judgment and next observable result. Routine checks
remain local; use the retained planner only under its existing scope and triggers.
Record coverage, rationale and the next checkpoint in the existing
phase report/state. Local phase success alone does not prove overall alignment.
Short plans may use completion; choose boundaries from delivery/risk rather than
a universal phase count or elapsed-time limit. Known drift/risk still triggers
immediate reassessment, including the preparation-drift rule above.

If aligned, continue under existing authority without another planner,
independent whole-plan review, or human approval. If changes to scope, order,
dependencies, acceptance, or risk are needed, use the active mode's existing
decision gate. Reuse an equivalent outcome check already performed at that
boundary; handoff alone neither invalidates evidence nor counts as inspection.
Carry covered work and the next named checkpoint through rollover.

## Context Health And Rollover

### Context assessment

Use this same assessment for planners, owners and both orchestrator configurations.
Read it at startup/adoption; reuse it at checkpoints. Check before substantial work,
after large evidence/repair cycles, at phase/owned-job completion, and after native
compaction at the next safe checkpoint. Reuse an unchanged assessment. Use the
existing current brief and already-available signals; no routine transcript scans,
delegated self-reviews, extra polling, notifications or separate ledger.

Replace one line in existing role state only when evidence, decision or the named
boundary changes. Keep it within 60 words, with a concrete basis and next action:

```text
CTX <CONTINUE|PREPARE_HANDOFF|HANDOFF_DUE> @<checkpoint> | usage=<value/source|?> | compact=<count/source|?>@<last> | brief=<ok|recovered|gap> | load=<ordinary|raised:reason> | basis=<evidence> | next=<action/safe boundary>
```

Assess these together; use no numerical complexity score:

- **Usage:** current session context from a reliable exposed source, or `?` when
  unavailable/stale. Account quota and lifetime tokens are different measures;
  invent no percentages or universal cutoff.
- **Compaction:** count unique completed compactions and the last event/checkpoint;
  use a verified total, or partial observation as
  `>=N since <checkpoint>`, never an assumed total or zero. Otherwise use `?`.
  Reconcile the brief after an observed compaction; the count alone does not force
  transfer. Keep each session's counters separate from subagents and predecessors.
- **Brief:** verify goal/adopted revision, role/workspace, authority/gates,
  evidence/open decisions and next action/owned handles match current evidence.
  For a gap, make one targeted reread of the decisive source, not the whole history.
  A correctly recorded unresolved work/permission blocker is not a context gap.
- **Load:** raised when integrating consequential interacting decisions, changing
  assumptions, conflicting/large results, repeated rework or interdependent jobs.
  Bounded delegation with concise settled outputs can reduce parent burden;
  agent count or complex work alone does not establish context pressure. Reduce
  the next intake/batch when load rises; do not reread child transcripts routinely.

- **CONTINUE:** the brief accurately represents anchors/blockers and context supports
  the next bounded step plus safe supervision, within existing gates. This is context
  readiness, not execution permission. Unknown usage or no active jobs alone is insufficient.
- **PREPARE_HANDOFF:** native pressure threatens the next step; repeated compaction
  accompanies raised load; or settled state repeatedly needs reconstruction. Also
  prepare before large evidence intake when usage is unknown and load is raised.
  Refresh the existing brief now and name the next safe boundary, usually terminal
  completion of owned jobs. At that boundary choose CONTINUE with new supporting
  evidence or HANDOFF_DUE; unchanged PREPARE statements cannot defer it again.
- **HANDOFF_DUE:** after that bounded reconciliation, context still cannot support
  the next step/supervision reliably, or measured headroom cannot cover it and safe
  state preservation. Settle owned handles and perform the authorized exclusive
  rollover before new substantial work. A missing permission or unresolved source
  conflict remains its actual blocker; transferring does not resolve it.

Pressure never makes a handle terminal: preserve state and supervise the same owned
worker/verifier/consultant/operational handle to completion; no abandonment,
cancellation, duplicates or competing successor for context relief. Independent
other-role work continues. Preserve gates and use the role's authorized transfer
route; if blocked, save the brief and expose the precise recovery need. If no
approved work remains, report completion or the outside-scope decision rather
than launching an idle successor.

### Standalone rollover

Include automatic fresh-orchestrator rollover in the execution profile or
approved envelope. An explicit user request for automatic handoffs supplies
that authority within its stated scope; a skill alone does not authorize new
chats. When rollover is due and authorized, read `context-rollover.md`, update
the existing status summary, prepare a concise handoff, and launch one fresh
primary orchestrator. Preserve pending gates and prevent concurrent owners; do
not substitute an implementation subagent or a fork retaining the heavy history.
No routine user prompt, planner, or extra review is needed for an authorized
rollover. If tooling, authority, or exact-workspace access prevents safe launch,
preserve the handoff and report the limitation rather than claiming a transfer.

## Bounded Authorization

Use the existing phase approval or autopilot envelope to name targets, allowed
actions, risks, incidental effects, repair/retry bounds, and exclusions. Reuse
explicit authority from the session: ordinary steps, approved verifier use, and
repairs within that boundary need no repeated approval. The gated commit approval
and autopilot startup gate remain distinct. New authority, material scope/risk
changes, or unexpected partial writes require preservation and the appropriate
stop/decision. Platform permissions and sensitive-action gates still apply.

### External provider consent

Before delegating to Claude or Cursor, verify existing human authorization for
that provider, content and purpose. An applicable global `Peer Agent Bridge`
workflow-wide grant plus the actual opt-in request or approved execution profile
can supply it; the skill or an agent assignment alone cannot. Reuse valid coverage
for planning, implementation, review and correction rounds. Request only missing
or expanded scope, or recovery from an actual platform rejection. Preserve
no-sharing restrictions and exclude secrets, credentials and unrelated private
data from prompts and delegated file access. Internal chat consent and provider
consent are distinct; neither grants operational actions or bypasses command rules.
Provider or transport fallbacks must fit the grant: wrapper-specific consent does
not automatically cover a direct CLI or another surface. Resolve uncovered scope
before transfer; reuse any existing grant that already covers it.

Record the original consent source, workflow/profile selection, covered provider/
content/purpose, exclusions and duration in existing authority state. At handoff,
carry that reference and verify same-assignment successor coverage before reuse;
a new generation alone requires no renewal. Preserve narrower/revoked grants and
actual rejection evidence. If the source or coverage cannot be established,
resolve that gap before the dependent transfer; other authorized work continues.

## Canonical Plan And Linear

Accept a markdown plan, chat plan, Linear issue list, one Linear parent with
sub-issues, or mixed sources. Before Phase 1, have the designated planning writer
reconcile them into one canonical
markdown plan containing:

- ordered phase number and title
- source file heading and linked issue/sub-issue ids
- objective and checkable acceptance criteria
- dependencies and ordering constraints
- likely verification
- blockers, deferrals, and out-of-scope items

If only Linear exists, the planning writer creates the local markdown plan from the issues. If a
canonical plan has no linked Linear coverage, prepare an exact create/update
mapping that gives every planned phase its intended issue or sub-issue, ordered
dependencies, objective, acceptance criteria, and known blockers or deferrals.
Treat that mapping as a required startup artifact, not an optional follow-up.
Creating or materially updating tracker state still requires explicit user
authority: ask in gated mode or include it in the autopilot startup envelope.
Once that authority exists, the assigned tracker writer applies the mapping and
the planning writer records created issue ids in the canonical plan. Re-read both
sources after mutation. Plan ownership grants no tracker-write authority; serialize
any shared fields under the workflow agreement rather than acquiring a second writer.

100% synchronization is complete only when every planned phase maps to the intended
issue, every relevant issue appears in markdown, order and dependencies agree,
objectives and acceptance criteria do not conflict, and blockers/deferrals exist
in both places. Do not start Phase 1 with a known synchronization gap.

Use explicit user instructions first, then the most specific phase source, then
the broader plan. Ask when a conflict changes scope, behavior, risk, or order.
Otherwise preserve source ids and state the ordering rule used. Do not close
issues or change status, ownership, or priority without explicit authority or a
separately established tracker policy.

## Role profiles

Read at startup, role launch, profile change and handoff. This is the workflow's
single model/effort specification; it imports no other role's authority.
Explicit human selections override these proposed defaults when capability permits.

| Role | Proposed model / reasoning | Scope |
| --- | --- | --- |
| Retained roadmap planner | `gpt-6-astra` / `high` | Goal direction, strategic planning and cumulative progress assessment. |
| Delivery owner | `gpt-6.1-sol` / `high` | Delivery decisions, dependencies and assignments. |
| Managed orchestrator | `gpt-6.1-sol` / `high` | Execution coordination, supervision and gates. |
| Standalone orchestrator | Existing explicitly approved model / reasoning | Preserve its profile; resolve an unspecified choice before launching a successor. |
| Bounded researcher | `gpt-6-luna` / `max` | Bounded evidence gathering, analysis and planning drafts under Bounded Research below. |
| Planning editor | `gpt-6-luna` / `max` for bounded settled edits; approved stronger profile for consequential reasoning | Planner-commissioned planning-document edits under exclusive temporary custody; no implementation or execution authority. |
| Implementation worker | `gpt-6-luna` / `max` for compatible TINY/ROUTINE phases | Apply `phase-capability.md`; inherent high risk or novel complexity requires a suitable strong implementer. |
| Bounded strategic/technical consultant | `gpt-6-astra` / `high` | Consequential unresolved reasoning; retain managed/standalone routing. |
| UI/UX reviewer | `gpt-6-luna` / `max` | Preserve the existing non-editing browser review gate. |
| Independent verifier | Existing selected [verification chain](delegated-jobs.md#verification-chain) | Preserve provider order, independence and critical-work restrictions. |

Keep one compact row per selected role in existing assignment/profile state:
`role | model ID | reasoning | permitted fallback or none | human selection source | successor coverage`.
Present missing retained-role selections together in the existing startup
agreement, with exact IDs/effort and fallback scope. Approval of that explicit
profile can cover same-role successors; skill invocation or a suggested default
alone is not human model selection. Reuse valid grants instead of asking per
launch. Preserve existing overrides; do not migrate a running assignment merely
because these defaults or the model catalog changed.

Before creating a retained chat, verify the approved pair against the destination
host's supported models/efforts. Pass both through the native launch controls
(`model` and `thinking` for desktop `create_thread`), with the selection source.
Never omit them to let an unrelated app default choose the successor. If explicit
selection is missing, resolve that one gap before launch; if the model is unavailable,
use only an explicitly permitted fallback or obtain a concrete replacement choice.
Subagents use their native model/effort controls and the role's approved fallback
policy; preserve fresh contexts and worker/reviewer separation.

On startup/adoption, compare native runtime model/effort evidence with the selected
pair before role writes or exclusive ownership claim. Prompt text, chat title and
skill readback are not runtime evidence. If settings are mismatched or unobservable,
record that limitation and resolve it in the same chat through supported controls
or a specific human decision, preserving independent work. Do not report verified
adoption or start a competing chat to repair it. Confirmation carries actual
role/model/effort, evidence source, assignment and next result. Reuse valid runtime
evidence until the model, effort, host or session changes.

Fallbacks retain their existing mode-specific rules below and in the managed
consultation/verification protocols; this table grants no additional provider,
write, launch or commit authority. A handoff preserves the selected pair and
fallback scope, not a newly chosen default.

### Opt-in Fable consultation and review

Use `claude-fable-5-2` / `high` only when the human selects it for the job or in
the approved profile and the Claude data-sharing scope covers the evidence. Choose
it for a consequential question that calls for a new approach or a challenge to
interacting assumptions, such as a mixed-version migration, coupled rollback and
retry behavior, or a repair loop that has stopped producing new evidence. State
what decision, counterexample or discriminating check the job should deliver.
Astra High remains the default consultant for consequential bounded questions,
especially when decisive evidence depends on native Codex state. Opus 5.5 remains
the default independent verifier under the [verification chain](delegated-jobs.md#verification-chain).

Use `codex-claude-ask --model claude-fable-5-2 --effort high` with a bounded read-only
brief. Verify the actual model using the [Claude reference](agent-claude.md#transport-and-effort).
Claude Code requires 2.1.321 or later and Fable account access. Treat a provider
substitution as a different model and apply only the approved fallback. The commissioning role owns
the result and supervises one job to terminal completion. Keep design contributors
out of that design's independent review. Fable changes no review, approval, or
execution requirement.

## Bounded Research

The planner, owner or orchestrator directly delegates research supporting its own
role under [Delegation within each role](../../roadmap-planner/references/retained-planning.md#delegation-within-each-role).
Use a fresh read-only Luna researcher for source discovery, documentation comparison,
repository mapping, bounded analysis or planning drafts when
the question, evidence access and expected result are bounded. Supply the question,
source scope, relevant constraints and an observable completion condition; require
source pointers, findings and uncertainties. Small lookups can stay local. Use
existing authority, provider and data-sharing limits; no additional retained chat.

The researcher gathers evidence, not strategic decisions, canonical plan changes
or independent acceptance. The commissioning role checks decisive sources and
owns interpretation within its remit; it uses approved stronger support when needed
and routes only decisions outside its remit to the responsible role.
High-stakes/ambiguous interpretation, conflicting evidence that cannot be resolved
from the sources, or findings that change risk require that stronger judgment
before dependent action. Research may still collect facts for such questions.
If Luna is unavailable or the question exceeds its capabilities, record partial
evidence and use a permitted stronger route or resolve the missing choice; do not
repeat an unproductive research loop or weaken the question. Retain owned-job
supervision, terminal handoff boundaries and required independent verification.

## Execution Profile

Before Phase 1, read `phase-capability.md` and run its phase capability
assessment across the canonical plan. Use the user's stated roles, models, and
effort only where they are compatible with that assessment. Otherwise make a
compact recommendation and obtain the approval required by the active mode. The
profile records:

- orchestrator and selected [role-profile rows](#role-profiles)
- planning/replanning route and fallback
- per-phase complexity, plan detail, implementation route, and required action
- implementation fallback
- UI/UX review route when any phase is UI-affecting
- verifier chain
- selected models and reasoning/effort when configurable
- one-line routing rationale

Check only capabilities needed by the proposed profile. Use `command -v` on
macOS/Linux, `Get-Command` in PowerShell, or `where` in Windows cmd. Wrappers are
transport only; role and safety policy belongs in prompts and these references.

After the assessment identifies the required capabilities, use these defaults
unless the user selects another implementation profile:

1. A separate Codex worker under [Role profiles](#role-profiles), matched to the
   phase capability assessment; do not use Luna merely because it is available
   when the phase requires a stronger implementer.
2. If unavailable, an edit-capable Cursor Grok 4.7 worker. Choose its effort for
   the phase and use the corresponding surfaced model id, such as
   `grok-4.7-high` for high effort.
3. If both routes are unavailable, the orchestrator selects an available
   edit-capable implementation model and reasoning level appropriate to the
   task, required capabilities, and risk. Record the choice and reason; do not
   automatically choose the largest model or maximum reasoning.

Do not call a model to choose the route or compare multiple implementers. Do not
silently use an implementer that lacks the capabilities required by
`phase-capability.md`. Retain the same phase brief and acceptance criteria on
fallback; model choice does not reduce the goal or risk requirements. For a
Codex worker, use `agent-codex.md`. If no separate edit-capable implementer is
available, stop for operator guidance; the orchestrator does not take over.

Read only the selected agent references:

- `agent-codex.md`
- `agent-cursor.md`
- `agent-claude.md`
- `agent-prompts.md` when constructing a delegated prompt

## Planning And Replanning

When a retained planner is selected, use the
[retained-planning route](../../roadmap-planner/references/retained-planning.md#selection-and-responsibility)
for substantive roadmap/next-plan proposals and direction reviews. Apply the shared
[request scope check](../../roadmap-planner/references/retained-planning.md#request-scope-and-routing)
before contacting it; without an owner, you retain routine coordinator decisions
and commission distinct technical consultation under the bounded route below.
The orchestrator remains execution coordinator. The retained planner writes or
directly delegates planning edits, and supplies a revision/delta for execution
adoption under the shared agreement. Report feasibility conflicts and missing work
to it rather than expanding the plan or commissioning an editing relay. Establish
original human messaging authority and verified generations via
[shared coordination](../../delivery-owner/references/coordination.md),
reading only the identity/messaging/recovery sections needed. Do not spawn a new
Astra subagent for the same strategic question or silently substitute a provider
if the retained planner is unavailable. Required unresolved input pauses only
dependent actions; advisory silence does not pause valid execution. A distinct
technical question may use a bounded read-only planning job under the route below,
with actual authority and no duplicate consultation. Use the
[opt-in Fable profile](#opt-in-fable-consultation-and-review) for that distinct
technical question only when selected.

With no retained planner, delegate one bounded read-only planning job when unresolved implementation
decisions or risks require substantive exploration or replanning. Do not launch
a planner merely for a new phase, factual bookkeeping, or the drift checkpoint.
Use the [opt-in Fable profile](#opt-in-fable-consultation-and-review) when selected
for this job. Otherwise the default is a fresh Codex subagent using the consultant
profile in [Role profiles](#role-profiles). If that route terminates unsuccessfully
or is unavailable, use Claude Opus 5.5 through `codex-claude-ask --model
claude-opus-5-5` under the existing authority. Use the Planning prompt in
`agent-prompts.md` for the selected route.

With no retained planner, this read-only planning consultant may inspect the plan
and repository evidence but must not edit the
workspace, mutate Linear, commit, push, deploy, or decide unresolved product
questions. The orchestrator reviews the advice, presents decisions to the user
when needed, and owns reconciliation into the canonical plan, Linear mapping,
capability assessment, and durable state. Delegate substantive plan edits to a
worker; factual status and pointer updates remain direct orchestrator work.

Use one consultant per question. Use Opus 5.5 only after a terminal Astra
failure/unavailability or explicit user selection. If the approved routes are
unavailable, the orchestrator may plan directly only as a disclosed degraded
fallback; record the reason, keep the task bounded, and do not bypass user or
tracker authority.

## UI/UX Review Gate

Classify each phase as UI-affecting when it changes a user-visible screen,
interaction, responsive layout, navigation, or user-facing information flow or
copy. For every UI-affecting phase, after functional checks and before the
independent verifier, delegate a fresh non-editing Codex UI/UX review subagent.
Use the selected UI/UX reviewer from [Role profiles](#role-profiles).
If unavailable, select an appropriate non-editing browser-capable reviewer and
record its model, effort, and fallback reason.
Read `agent-codex.md` and the UI/UX Review prompt in `agent-prompts.md`, then
give the reviewer the phase brief and current-worktree target. The reviewer
starts or reuses the relevant app, opens the target in the in-app Browser, proves it
serves the phase diff, and follows `$ui-ux-browser-review`. Record its model,
effort, target, proof, coverage, findings, limitations, and outcome in durable
state. Return actionable findings to an edit-capable implementation worker, then
rerun affected checks and review coverage before independent verification; reuse
unaffected accepted evidence under Delivery And Evidence Discipline.

For a non-UI phase, record `UI/UX review: N/A` with the reason. A UI-affecting
phase cannot be GREEN without that review, or an explicit user waiver when the
required browser evidence cannot be obtained. A waiver must state the untested
scope and resulting risk; it is not implied by passing functional tests.

## Common Phase State Machine

For each phase:

1. Reconfirm the approved capability assessment, then write a phase brief with
   objective, scope, likely files, constraints, acceptance checks, risks, stop
   conditions, capability delivered/blocker removed, and criterion/invariant
   served. Cite current repository principles that apply to the affected
   boundaries and carry the citations into the existing verifier brief.
   Resolve any required `add plan detail` or `use stronger
   implementer` action before delegation.
2. When substantive planning is needed, delegate under Planning And Replanning
   above and reconcile the approved result before implementation. Perform any
   triggered drift checkpoint directly under Delivery And Evidence Discipline.
   Satisfy any applicable independent design review under Review Boundaries And
   Outcome Checkpoints before affected implementation relies on that decision.
3. Select and record the implementation route, model, and reasoning/effort.
4. Delegate implementation with Ponytail/minimal-diff and drive it to a terminal
   result under `delegated-jobs.md`. Factual bookkeeping follows the Role Contract.
5. Inspect `git status --short` and the actual diff. Confirm every changed path
   belongs to the phase and no unrelated work was overwritten.
6. Run the smallest relevant verification, then broaden according to risk and
   repository norms. Run a planned early compatibility check when its inputs
   become usable; preserve its gate before dependent expansion.
7. For a UI-affecting phase, complete the UI/UX Review Gate above. For a non-UI
   phase, record its N/A decision.
8. For substantive work, run the verifier chain in `delegated-jobs.md`. Classify
   findings and repairs under its Finding And Repair Scope rules; repeat affected
   verification only. Factual bookkeeping alone needs orchestrator inspection.
9. If a repair exposes interpretation drift or capability mismatch, reassess
   plan detail and implementation strength before another attempt. After two
   materially similar red repair cycles without new evidence or a distinct fix,
   stop with the exact blocker or decision needed.
10. Update durable state before the mode-specific commit/continuation gate.
    Perform a due cumulative outcome check and record its coverage and next
    checkpoint; it adds no routine approval or independent-review cycle.
    Check context health and perform a due, authorized rollover under Context
    Health And Rollover; do not start another substantive step in degraded context.

A phase is GREEN only when its acceptance criteria are met, the orchestrator has
inspected the diff, relevant tests pass or have an explicit approved waiver, the
substantive work has independent verification with no unresolved blocker at
confidence appropriate to the risk (factual bookkeeping alone has orchestrator
inspection), no unrelated change is staged, no delegated job remains in flight,
and durable state can reconstruct the result. The chosen implementation route
must remain compatible with the approved capability assessment. A UI-affecting phase
additionally requires a completed UI/UX review or explicit user waiver.

## Shared Fallback And Stop Rules

- Planning unavailable: with a retained planner follow the recorded recovery and
  authority; do not silently switch planner/provider. Without one, use the selected
  consultation profile and its fallback above. The orchestrator may plan
  directly for substantive planning only after both are unavailable, with the
  degradation recorded. Routine reconciliation and drift checks need no planner.
- Implementation unavailable: choose another edit-capable agent; never collapse
  implementation into orchestration.
- Verification unavailable: follow `delegated-jobs.md` and disclose degradation.
- Do not repeat the same failed command, prompt, provider call, or repair without
  new information.
- Stop for material scope/architecture decisions, unexpected partial writes,
  unavailable important tests, conflicting high-risk findings, uncertain
  workspace ownership, sensitive
  actions outside established authority (including destructive/live actions,
  secrets/credentials, deploy/release/push), or exhausted fallbacks.

Use the shared [replaceable current brief](../../delivery-owner/references/contracts.md#current-snapshot)
in the canonical plan or existing phase state; this imports state format, not
managed ownership or gates. Record goal/remaining criteria, role/skill/assignment, coordination/execution settings,
actual blocker and next result/actor, latest assessment, authority and pending
gates. Link exact branch/HEAD/diff custody, capability/profile, implementation
route, tests/UI/verifier results, accepted commits and evidence validity. Preserve
superseded decisions and failed attempts in append-only history. At rollover,
link the transfer record and next-action technical references; no second ledger.
