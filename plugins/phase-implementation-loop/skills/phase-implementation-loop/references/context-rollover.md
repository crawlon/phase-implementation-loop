# Context Rollover

Read only when context rollover is due or a successor resumes. This transfers
primary orchestration, not implementation. Monitoring and factual handoff
preparation need no planner, verifier, separate phase, or routine approval.

## Safe Transfer

1. Use an existing checkpoint before the next substantial step. Drive every
   delegated handle to terminal completion under `delegated-jobs.md`; preserve
   services and workspace changes. Do not launch a successor while a worker,
   verifier, or operational write is still in flight. If safe quiescence is
   impossible, save known state/handles and report the limitation without
   launching a competing orchestrator.
2. Update the existing current-status summary with phase and exact gate,
   next authorized action, repository/host/worktree, branch/HEAD, dirty-path
   ownership, accepted evidence/conditions, relevant service targets, approvals
   and exclusions, unresolved decisions, model profile and latest context
   assessment/reason/boundary. Reference existing
   receipts instead of copying logs, diffs, or full chat history.
3. Write a concise handoff packet to a unique file in the OS temporary directory.
   Include absolute pointers to the canonical plan and current status, source
   chat/approval references when available, selected phase skill, transfer
   generation, unique transfer token, exclusive-claim location/mechanism,
   preserved gate, and exact next action. Summarize human authorization with its
   evidence; omit
   secrets, credentials, and unnecessary personal data. The existing status
   summary remains durable authority if the temporary file expires.
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
   make rollover convenient. Preserve the user-approved model profile; do not
   silently force a new orchestrator model.
6. Observe startup through the returned handle and a compact status snapshot.
   Confirm the successor has reconciled workspace identity and claimed the
   recorded generation before reporting successful transfer. Do not wait for
   the whole remaining plan or repeatedly poll unchanged progress. Report the
   successor chat/session and preserved next step, then end source execution.

On the Codex desktop, use `create_thread` for fresh history. For repository work,
call `list_projects` and select the matching project/host with local execution;
include the exact phase worktree in the prompt. A saved project's default
checkout may differ from that worktree: the successor must establish access to
and use the recorded worktree for every command, not the default checkout.
If the surface cannot provide that access, stop without workspace mutation.
Set a model only when explicitly selected by the user; otherwise retain the
surface's configured default. A queued creation id is not a ready thread id.
Use native startup/status tools and report the created-thread reference where
supported. Initial creation carries continuation instructions; it does not
authorize messaging unrelated chats.

## Successor Contract

Read the packet, canonical plan, current status, and applicable instructions.
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
Keep the same delegated role separation and monitor context at later checkpoints.

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
Continue the approved phase plan as its fresh primary orchestrator.
Read [absolute handoff path] and [absolute current-status/canonical-plan paths].
Source chat/approval evidence: [verified references or exact available evidence].
Host and exact phase workspace: [host/path]; branch/HEAD: [recorded identity].
Transfer generation/token and exclusive-claim location: [generation/token/path].
Mode and model profile: [approved skill/profile].
Preserved gate and next authorized action: [gate/action].

Follow the selected phase skill and its context-rollover.md successor contract.
First reconcile identity, ownership, evidence conditions, and original authority
read-only; then exclusively claim the generation using your distinct session
identity before other mutations. Stop if already claimed or exclusivity cannot
be established. Report
that startup result briefly. Use the exact phase workspace for every command;
do not substitute the task's default checkout. Preserve pending approvals and
all exclusions, reuse still-valid evidence, and continue only authorized work.
```
