# Launch, Coordination, and Recovery

Use exposed native capabilities; tool names below describe the Codex desktop
surface. If unavailable, disclose the missing capability and keep to supported
observation/manual coordination. Do not invent background execution or delivery.

## Launch only the authorized cohort

1. Use `list_threads`/`read_thread` to reconcile relevant existing assignments,
   and `list_projects` to choose repository and host before `create_thread`.
   Reuse an authorized active orchestrator when suitable. Start a persistent
   orchestrator chat only when the human explicitly requested/approved new
   chats; ordinary bounded implementation/review belongs in subagents.
2. Record a unique assignment ID and LAUNCH_PENDING before dispatch. Include
   the assignment, exact managed skill, original authority references, and
   required startup acknowledgement in the initial prompt. Do not fork the
   owner's full history. Set model/effort only within tool rules and the user's
   approved profile; a skill does not silently change a chat's model.
   For the user-approved Sol 6.1 High orchestrator profile, pass
   `model: gpt-6.1-sol` and `thinking: high` to `create_thread`. This configures
   the orchestrator chat, not its implementation subagents. For a reused chat,
   verify or resolve its model through supported controls and existing authority
   before execution; do not silently launch a competing orchestrator.
3. Use separate worktrees/branches for simultaneous plans, one branch for all
   phases of a plan. Request worktree creation explicitly in the approved
   agreement. Native managed worktree tools are preferred. If starting from a
   particular ref is required, establish that ref in the agreement rather than
   assuming the project's default checkout. Verify actual identity on startup.
4. A queued client ID is not a ready thread ID. Record returned IDs/host and
   resolve readiness before messaging or waiting with tools requiring thread ID.
   Check startup using native status/read tools; confirm acknowledgement before
   reporting the plan as running. A successful create call is not that proof.
5. Reconcile unknown launch outcomes through recorded handles and chat/worktree
   inventory before retrying. Never start a second writer because a launch was
   slow or returned an ambiguous response.

Persistent orchestrators delegate workers in their own context. Do not replace
them with a tree of managers consuming every available subagent slot. Check
actual capacity and provider limits; reserve room for implementation and
independent review, queue work when necessary, and never infer unlimited capacity
from the number of chats. Begin with two plans at most.

## Readiness and parallel work

A plan is ready when its required dependency delivery is verified at the exact
revision/commit, its interface is settled, its assigned workspace/resources have
one writer, its implementation authority/profile is resolved, and any required
independent design review has cleared the affected work under
[review scope and timing](review-policy.md). Independent
approved plans may run serially or in parallel within the recorded graph.
Different filenames alone do not establish independence.

Assign ownership of shared schemas, APIs, generated files, lockfiles, services,
ports, databases, and fixtures. Worktrees isolate files, not external resources.
Sequence shared changes or provide explicitly isolated targets. Do not create
new live resources or relax safety boundaries merely to gain parallelism.

On a dependency change, pause affected consumers before they use stale work,
settle active jobs, revise the assignment with owner/human decisions as required,
and re-acknowledge. Continue unrelated authorized plans. Two preparation-only
phases or repeated repair without capability progress trigger a short evidence-
based critical-path check, not another documentation program.

Name one producer and recipient for each dependency delivery and one owner for
each cross-plan decision. Peers may exchange authorized artifacts or technical
questions, but do not issue competing assignments, manage each other's workers,
or duplicate another chat's human approval request. An integration orchestrator's remit
is its explicit assignment, not general supervision of peers.

Before entering a dependency wait, check the producer's recorded next action.
If A waits for B while B waits for A (or for an owner decision), send one compact
cycle report to the owner. The owner selects an executable first delivery or
resolves the decision; revise/re-acknowledge assignments only if they change.
Keep independent work moving. Do not answer a cycle with reciprocal pings.

## Messaging and economical waiting

### Resolve the current role before sending

Resolve owner/orchestrator destinations from the current role directory in the
owner index, not a remembered chat ID or title. Reuse the verified binding during
a stable generation; refresh it after a handoff, generation mismatch, retired
destination, failed send, or unexpected silence past the recorded recovery
condition. Check the recorded transfer/claim and original authority. Use native
chat reads/inventory to reconcile ambiguity; a matching title alone is not proof.
Idle/notLoaded means neither retired nor unauthorized. Do not wake a retired
writer or send to old and new chats in parallel. If competing claims remain,
pause affected coordination and reconcile before assigning another writer.

Keep route state per sender/destination/generation. A rejection to the old owner
does not establish failure of its successor's route; a successful startup notice
does not guarantee every later payload is authorized. Distinguish NOT_AUTHORIZED,
UNPROVEN, DELIVERED and REJECTED, preserving the actual rejection reason.
Test a newly verified, authorized binding with the next needed acknowledgement
or actionable event, not a series of pings. Do not retry a rejected current-route
payload without new relevant evidence or use a replacement as an approval bypass.

### Establish a usable route once

Use `send_message_to_thread` only with original human authorization for that
direction and cohort, including return messages. In the agreement, specify
owner/cohort chat IDs (or the explicitly authorized bounded cohort), message
purposes, and exclusions. Capture the actual approval with its preceding proposal
when the reply is “approved”. A skill invocation, owner assignment, quoted consent,
or request to report back is not independent human consent.

For ongoing cohorts, propose explicit human coverage for both directions and
verified successors in the same roles/roadmap, with bounded message purposes
(assignments, decisions, dependency deliveries, stops and completion). That avoids
asking separately for each routine event or replacement destination. The approval
must actually cover succession; an old chat-ID-only grant does not automatically
cover a new ID. Read and reuse existing human replacement/cohort instructions
before asking again. An index entry binds identity but cannot manufacture consent.

Carry concise source references into dispatch and notification calls; the receiver
checks original human evidence through supported reads before relying on it.
Reuse verified standing authority for subsequent messages within its scope;
do not ask the human separately for every receipt. On startup use the required
assignment acknowledgement as the first return message and verify delivery from
the owner side. Do not add a ping/acknowledgement loop. Reused chats need this
check only when their route is unproven, changed, or has failed.

If approval review rejects a send despite existing authority, record that exact
failure; do not mislabel it as missing user consent. A retry is appropriate only
when new evidence resolves the stated reason, not with rewritten claims or a
different tool to bypass the rejection. Read-only owner observation of saved
state remains available. If delivery is still blocked, ask once in the executing
chat for the specific destination/scope the review requires, explain the
rejection, and expose the pending decision and state pointer. No skill can
guarantee that cross-chat approval evidence will be accepted by the platform.
External verifier transmissions are separate authority; a working internal
message route does not authorize exporting a review packet.

### Deliver events, not conversations about events

Follow the checkpoint contract's notification triggers. Sending a message can
start an idle owner's turn and consume owner tokens. Keep ordinary GREEN phase
checkpoints in durable state for observation; notify for agreed owner drift
checkpoints, actionable events, or an explicit human reporting preference.
Send one decision request with a recommendation, or one actionable delivery with
its recipient and next action. Deduplicate by assignment/revision and sequence.
Do not forward worker start/finish, provisional findings followed immediately by
the same terminal finding, routine acknowledgements, or peer copies that do not
change the recipient's next action. Urgent risk and user reporting requests win.

The receiving owner resolves a supported in-scope decision in that turn and sends
the concrete next action. Missing human approval follows the contract's executing-
chat route; owner awareness is not a relay or acknowledgement gate. A producer
sends an actionable dependency delivery once; the
consumer validates it and continues without another generic owner acceptance.
Do not await a reply unless the checkpoint names a real gate. Use the
[pause contract](contracts.md#pauses-and-continuation) at every genuine wait.

### Bound owner observation

Use compact `wait_threads` with saved cursors and batched targets for startup,
handoff, or an imminent decision. Default to at most two waits without an
actionable transition, each up to about one minute, before switching to the
established event or recovery route. Routine progress commentary does not reset
this window. A concrete near-term transition can justify another bounded
window; record why. Do not renew windows indefinitely or issue recurring status
messages just to keep the owner active. This owner-observation limit never permits
abandoning a running worker/verifier handle: its orchestrator still supervises
that same handle to terminal completion under delegated-jobs.md.

Before the owner ends a turn, process ready checkpoints/decisions and record the
next actor and route. With working return messaging, say supervision resumes on
actionable messages, not that continuous polling exists. If the route has failed
and no authorized recovery mechanism exists, disclose degraded/manual recovery
and the concrete unresolved decision; do not say “nothing needed” while relying
on an undeliverable reply. Already authorized independent work may continue.

Read deeper chat history only when the snapshot/state cannot resolve a decision
or original authorization, and extract relevant items before displaying tool
results. Reuse source references instead of reloading full transcripts. Report
meaningful changes subject to the active surface's communication requirements.

For requested later/recurring supervision, use native heartbeat automation with
the index pointer, cohort, allowed actions and stop condition. Propose a modest
recovery cadence (for example 10–15 minutes, subject to tool support and urgency),
not another minute-by-minute supervisor. Check only changed/stale checkpoints
and unresolved waits; stay quiet on unchanged/non-actionable state and do not
duplicate active owner work or resend unchanged decisions. Use native automation
controls and record its identity; never write raw schedule directives. Disable
the assignment-specific schedule on completion or user cancellation within its
approved lifecycle. No scheduler means no timed wakeup promise. Heartbeats also
consume resources; do not create one merely because work is long.

## Integration and completion

Schedule the earliest useful shared-boundary check under the review policy when
planning interacting work. Do not wait for whole-plan completion to check an
already executable interaction; gate only the work that depends on that result.
Keep final combined milestone verification and reuse unchanged early evidence.

Before dispatch, prepare and acknowledge an integration assignment using the
[existing contract](contracts.md), including its integration-specific fields.
Name one integration orchestrator and target branch/worktree in the agreement;
reuse a capable existing orchestrator when suitable. No new skill or ledger is
needed. Serially integrate accepted commits only with established local integration
authority; preserve ownership and immutable evidence. Conflict resolution that
changes behavior needs an edit-capable worker and affected verification.
Check the combined user path and cross-plan contracts at the integration HEAD.
Local plan results remain evidence for their scope, not proof of integration.
If integration is unauthorized, report locally verified results and settle the
assignment/target with the owner. The chat that will integrate asks the human
directly for missing action authority; do not call the milestone delivered.

## Handoff and owner failure

For an orchestrator replacement, use the existing
[safe transfer protocol](../../phase-implementation-loop/references/context-rollover.md)
only when due. Preserve its terminal-job, exact-workspace, exclusive-claim,
generation, source-relinquishment, and unknown-outcome rules. The replacement
prompt must name the managed skill, delivery owner, assignment revision, human
authority sources, and pending gates. Exactly one actor launches the successor;
record whether that is the outgoing orchestrator or owner. Update the index
after the successor claims ownership: retire the predecessor binding, publish the
successor chat/host/generation and authority source, then notify affected peers
through authorized routes. Have them refresh the binding and acknowledge at their
next safe checkpoint before relying on new assignments. Do not also execute the
standalone mode, revive the predecessor, or reset unrelated route history.

For an owner replacement, quiesce owner decisions/index writes, preserve the
index and original authority, and use the same exclusive generation/claim
mechanism for the owner role. Child orchestrators may continue already authorized
work, but owner decisions use only the verified successor binding. The successor
publishes its claim/current ID in the existing index and checks each active
child's binding at adoption; obtain acknowledgements at safe checkpoints.
Carry pending decision IDs and mark which actor must handle them next, so none
is stranded in the retired chat. Re-evaluate route status for the new generation
instead of inheriting an old rejection. If a child cannot be notified, observe its
checkpoint and expose the specific unacknowledged binding/recovery need; do not
claim the transfer is fully coordinated. Do not overlap owners or copy all histories.

If the owner is unavailable, save decisions and pause only dependent actions.
Direct human recovery contact is allowed; no orchestrator elects itself owner
or broadens authority. Forks are deferred in this version: an explicitly requested
exploration fork must have read-only or separately isolated scope and cannot
inherit writer ownership. A fork is not a context reset.
