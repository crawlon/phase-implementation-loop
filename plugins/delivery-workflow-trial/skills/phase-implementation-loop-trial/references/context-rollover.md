# Context Rollover

Read only when context rollover is due or a successor resumes. This transfers
the recorded retained role: orchestrator, owner or planner, never implementation.
Managed and planner transfers also use the role-specific overlay in
[coordination](../../delivery-owner-trial/references/coordination.md#handoff-and-owner-failure).
A planner successor owns only planner notes/proposals and claims, never execution;
an owner successor owns the index/decisions, never child jobs. Settle the
transferring actor's own jobs; independent other roles can continue. Monitoring and factual handoff
preparation need no planner, verifier, separate phase, or routine approval.

## Safe Transfer

Resolve the actual retained role from the assignment and writer responsibilities,
not the chat title or a historical combined label. A planner uses
`roadmap-planner-trial`; an owner uses `delivery-owner-trial`; an orchestrator
retains its exact managed/standalone and gated/autopilot trial entrypoint. Record
the skill name and verified absolute `SKILL.md` path. Resolve the selected
model/effort, permitted fallback and original human selection under the shared
[role profiles](shared-protocol.md#role-profiles) before relinquishment or dispatch;
use the approved role row, not an incidental predecessor/app default. Renaming an index writer
"Planner" does not make it an advisory planner; changing that responsibility
requires explicit adoption and canonical-writer handover under the
[trial agreement](../../roadmap-planner-trial/references/retained-planning.md#adoption-and-switching-back).

1. Use an existing checkpoint before the next substantial step. Drive every
   owned delegated handle to terminal completion under `delegated-jobs.md`; preserve
   services and workspace changes. Do not launch a successor while a worker,
   verifier, or operational write is still in flight. If safe quiescence is
   impossible, save known state/handles and report the limitation without
   launching a competing orchestrator.
2. Update the shared [current brief](../../delivery-owner-trial/references/contracts.md#current-snapshot)
   in the existing role state. Link exact workspace/dirty ownership, evidence
   validity, authority, gates and next-action technical references. Preserve the
   last meaningful milestone, goal assessment/rationale, assumptions, next result
   and review cadence/route. Link useful execution knowledge such as the working
   verifier invocation and known environment limitations; do not copy transcripts.
   Carry [provider consent](shared-protocol.md#external-provider-consent) and its
   original source/profile selection, scope, successor coverage and actual route
   limitations. Retain superseded allowances as history, not revived stop gates.
3. Write a compact transfer envelope to a unique OS temporary file, pointing to
   the canonical plan and current brief/revision. Add source chat/original approval
   references, actual role and exact trial entrypoint, generation, unique transfer
   token, exclusive-claim location/mechanism, preserved gate and next action.
   Reference existing investigation and receipts rather than restating them. Omit
   secrets, credentials and unnecessary personal data. The durable role state
   retains these transfer facts if the temporary file expires.
4. Verify that automatic successor creation is explicitly authorized by the
   user or approved envelope and supported by the active surface. Record the
   new generation, handoff pointer, transfer token/claim location, and source relinquishment
   before dispatch. After dispatch, the source performs no more workspace,
   tracker, operational, or phase mutations; it may only observe startup and
   report the successor. This prevents simultaneous primary owners.
5. Launch exactly one fresh primary task/session with the continuation prompt
   below and access to the existing phase workspace. Do not use an ordinary
   implementation subagent or a history-preserving fork as a context reset.
   Do not create a new checkout, reset/clean/stash work, or restart services to
   make rollover convenient. Pass the approved model and reasoning explicitly
   through native controls, carrying their selection source and fallback scope.
6. Observe startup through the returned handle and a compact status snapshot.
   Confirm the successor has reconciled workspace identity and claimed the
   recorded generation after native model/effort verification, read the matching
   trial skill and identified the next observable result before confirming transfer. Do not wait for
   the whole remaining plan or repeatedly poll unchanged progress. Report the
   successor chat/session and preserved next step, then end source execution.

On the Codex desktop, use `create_thread` for fresh history. For repository work,
call `list_projects` and select the matching project/host with local execution;
include the exact phase worktree in the prompt. A saved project's default
checkout may differ from that worktree: the successor must establish access to
and use the recorded worktree for every command, not the default checkout.
If the surface cannot provide that access, stop without workspace mutation.
Reuse the explicit human role-profile selection for model and reasoning. Missing
selection or an unsupported pair is resolved before launch under Role profiles;
never silently substitute the surface default. A queued creation id is not a ready thread id.
Use native startup/status tools and report the created-thread reference where
supported. Initial creation carries continuation instructions; it does not
authorize messaging unrelated chats.

## Successor Contract

Read the envelope, exact trial entrypoint/required references and current brief;
follow next-action evidence links before loading wider history. Reconcile the
actual role, loaded skill/path, writer responsibilities, assignment and next
authorized action before claiming ownership. Verify native model/effort against
the approved role row under Role profiles before claim or role writes; expose
mismatch/unobservable settings and resolve in the same chat. A title, prompt or
historical skill path cannot establish this binding. Resolve conflicting role instructions
read-only; preserve independent execution while a binding decision is missing.
Before any action beyond read-only reconciliation, verify recorded host,
repository/worktree, branch/HEAD, changed-path ownership, service/evidence
conditions, and inherited human authority. Check that the generation and transfer
token match and the source is relinquished. Claim that generation exclusively
before other mutations, using a native atomic ownership primitive or atomic
create-if-absent of a small claim file at the recorded location beside the
temporary packet. Bind the claim to the actual successor chat/session identity
or a fresh per-session identity, not the shared transfer token alone. Reject a
generation already claimed in the status summary or ownership primitive;
a duplicate successor stops without phase writes. Only the existing claimant
may reuse its verified exclusive ownership when resuming that same session.
If exclusivity cannot be established, stop rather than use read/check/overwrite
as a lock. Record the successful claimant in the existing status summary.
Unexpected divergence or insufficient access/authority
requires the mode's stop gate; do not rebind the plan to another checkout.

Resume the recorded next step within the original envelope. Gated mode carries
pending commit/continuation approval unchanged; autopilot carries its frozen
scope, commit authority, and stop gates unchanged. Do not restart Phase 1,
rerun valid audits, waive blockers, or infer permission from a handoff summary
alone. Reconcile authorization against available original user approval evidence;
if it cannot be established, ask for the missing decision before dependent work.
Verify inherited provider coverage under the shared rule; a thread change alone
creates no new external-sharing approval gate.
Preserve [delegation within each role](../../roadmap-planner-trial/references/retained-planning.md#delegation-within-each-role):
carry settled findings, unresolved follow-ups and approved support profiles in the
role's current brief. The successor resumes its own supporting work, not another
role's jobs; do not relaunch completed research without an evidence gap.
Monitor context at later checkpoints.

## Failure And Recovery

If creation or startup fails, preserve the workspace and packet and report the
exact limitation. An unknown launch outcome must be reconciled using returned
handles, recorded ownership, or native chat/status lookup before any retry;
never blindly create another successor. The source may reclaim ownership only
after confirming that no successor is active or can still start. Otherwise stop
and keep ownership unresolved. Do not automatically archive chats or tear down
the worktree or remove another actor's claim. If all approved work is complete,
update state and report completion rather than launching an idle successor.
Pending approval for remaining approved work may transfer when rollover is
authorized; the successor retains that gate without advancing past it. If the
only possible next work is outside the approved plan, report that decision
instead of launching a successor merely because context is large.

## Continuation Prompt

```text
Continue [assignment] as its fresh [orchestrator | owner | planner].
Retained role and permitted note/index/execution writes: [role/boundaries].
Exact trial skill name and absolute SKILL.md to read: [name/path].
Read [absolute transfer envelope] and [canonical plan/current brief revision].
Host and exact phase workspace: [host/path]; branch/HEAD: [identity].
Transfer generation/token and exclusive-claim location: [generation/token/path].
Mode: [approved skill]. Model/effort, permitted fallback and original human selection: [row/source].
Preserved gate and next authorized action/outcome: [gate/action/result].

Follow the exact trial entrypoint, required references and successor contract.
Use the brief's original authority, assessment, technical evidence and verified
coordination/heartbeat routes; resolve missing or conflicting bindings read-only.
Verify native model/effort under Role profiles before claiming. Then exclusively claim the generation with your distinct session identity before
other mutations. Stop if already claimed or exclusivity cannot be established.
Briefly report actual role, native model/effort evidence, skill/path, assignment,
exclusive claim and next result.
Use the recorded workspace for every command, preserve gates/exclusions and
still-valid evidence, and continue only authorized work. Do not import a legacy
skill from history or turn proposed technical mechanisms into new approval gates.
```
