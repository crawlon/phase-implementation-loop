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

## Messaging and economical waiting

Use `send_message_to_thread` only with traceable human authorization for that
direction and cohort, including orchestrator-to-owner replies. An agent asking
another to report back does not itself authorize a reply. If messaging is not
authorized, read available state and route authorization through the human.

Follow the checkpoint contract's notification triggers. Sending a message can
start an idle owner's turn and consume Astra tokens. Keep ordinary GREEN phase
checkpoints in durable state for observation; notify for agreed owner drift
checkpoints, actionable events,
or an explicit human reporting preference. Do not create a new polling schedule
just to consume routine checkpoints.

Prefer compact `wait_threads` calls with saved cursors and the tool's batch
limit; use waits up to about one minute and back off unchanged snapshots. A
commentary update may not wake a completion wait. Consume it from the next
snapshot; do not assume a push subscription. For a blocker or pending human gate,
the orchestrator saves state and ends its turn after its authorized notification
so the owner can observe an actionable completion state. For ongoing autopilot
work, publish the checkpoint locally and continue without awaiting owner assent.

Read deeper chat history only when the snapshot/state cannot resolve a decision
or original authorization. Avoid repeated full-history reads, minute-by-minute
replanning, redundant status requests, and idle commentary. Report only meaningful
changes to the human, subject to the active surface's communication requirements.

For requested later/recurring supervision, use native heartbeat automation with
the index pointer and scope; stay quiet on unchanged/non-actionable state. Do
not create one merely because work is long. No scheduler means no wakeup promise.

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
If integration is unauthorized, report locally verified results and request the
specific action through the owner; do not call the milestone delivered.

## Handoff and owner failure

For an orchestrator replacement, use the existing
[safe transfer protocol](../../phase-implementation-loop/references/context-rollover.md)
only when due. Preserve its terminal-job, exact-workspace, exclusive-claim,
generation, source-relinquishment, and unknown-outcome rules. The replacement
prompt must name the managed skill, delivery owner, assignment revision, human
authority sources, and pending gates. Exactly one actor launches the successor;
record whether that is the outgoing orchestrator or owner. Update the index
after the successor claims ownership. Do not also execute the standalone mode.

For an owner replacement, quiesce owner decisions/index writes, preserve the
index and original authority, and use the same exclusive generation/claim
mechanism for the owner role. Child orchestrators may continue already authorized
work, but owner decisions wait until they acknowledge the successor owner ID and
generation. Do not overlap owners or copy all histories into the successor.

If the owner is unavailable, save decisions and pause only dependent actions.
Direct human recovery contact is allowed; no orchestrator elects itself owner
or broadens authority. Forks are deferred in this version: an explicitly requested
exploration fork must have read-only or separately isolated scope and cannot
inherit writer ownership. A fork is not a context reset.
