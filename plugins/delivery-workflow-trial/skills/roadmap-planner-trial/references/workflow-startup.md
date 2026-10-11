# Start The Workflow From The Planner

Use this only when the human asks this planning chat to start execution of its
approved plan. Retained review alone does not launch a cohort. The planner stays
in this chat; the human need not invoke skills in each new chat.

## Choose and launch once

1. Read the approved plan, fixed outcome, acceptance and original action authority.
   Reconcile suitable existing chats and exact workspace/branch/HEAD/dirty ownership.
   Prefer one standalone orchestrator for a single execution stream, including a
   multi-phase plan. Use an owner for interacting plans, shared dependencies or a
   progressively planned roadmap needing continuing cross-plan decisions. Several
   phases alone do not justify an owner. State the choice briefly.
2. Reuse approved execution mode, profiles and permissions. If creation, execution,
   role messaging or succession scope is missing, prepare one concrete compact
   startup agreement covering the missing bounds and actors. Obtain genuinely
   required human authority before the affected action; do not ask each actor to
   reapprove valid grants. No autopilot, worktree, tracker, schedule, push or deploy
   authority follows merely from selecting this skill. Preserve executing-chat
   approval gates and actual platform trust rejection recovery.
3. Select the child skill from the table below. Resolve its absolute `SKILL.md`
   path in the installed trial bundle or this self-contained source bundle and
   verify it exists. Pass that path and explicit read instructions in the initial
   prompt; the child reads its entrypoint and the references required for its
   next action automatically. Do not load both execution modes or current skills.
4. Follow the applicable [native launch and identity rules](../../delivery-owner-trial/references/coordination.md#launch-only-the-authorized-cohort).
   Use fresh role prompts, not a fork of the planning transcript. Preserve human
   profile overrides; supply model parameters only when allowed by the tool and
   explicitly selected by the human. Record LAUNCH_PENDING and returned handles
   in existing planner notes before relying on the coordinator's state. Reconcile
   queued/unknown outcomes before retrying; a queued client ID is not a thread ID.
5. **Standalone:** the planner creates/adopts one orchestrator. **Managed:** the
   planner creates/adopts one owner; the owner establishes its index/assignment
   and creates/adopts the first orchestrator under the same bounded authority.
   The planner never also creates that managed orchestrator. An existing active
   cohort adopts only at a safe checkpoint, preserving writers, budgets and gates.
6. Observe using native status/wait/read tools until the coordinator acknowledges
   the binding, workspace, selected skill and next action or exact pending gate.
   For managed startup the owner checks its child's acknowledgement and publishes
   the result. Creation success alone is not running execution. Report a real
   approval or recovery boundary accurately; no duplicate launch to escape it.
   After acknowledgement the coordinator maintains the role directory and owns
   later dispatch. Planner notes retain only the bootstrap receipt and rationale.

| Structure | Gated execution | Explicitly approved autopilot |
| --- | --- | --- |
| Standalone child | `phase-implementation-loop-trial` | `phase-implementation-autopilot-trial` |
| Managed owner | `delivery-owner-trial` | `delivery-owner-trial` |
| Owner's orchestrator | `managed-implementation-loop-trial` | `managed-implementation-autopilot-trial` |

Absent approved autopilot, select gated execution; this does not waive its
execution-profile or phase-commit approval. Reuse an already approved profile.

## Child startup prompt

Populate this compact prompt with verified values and actual source references:

```text
The human selected the trial workflow and requested this role: [original request].
Act as [canonical name/generation]. Read $[selected skill] at [absolute SKILL.md]
now, then its required startup references; do not ask for manual skill invocation.
Plan/goal/acceptance/rationale: [paths and revisions].
Workspace and ownership: [repository, host, checkout/worktree, branch, HEAD, dirty paths].
Authority: [original human sources, allowed actions/mode/profile, limits and gates].
Bindings: [planner and existing coordinator/actors, IDs/hosts, message purposes,
successor scope and actual route status; unknowns explicitly named].
Next action: [standalone: establish phase state and begin allowed work;
owner: establish index/first assignment and launch/adopt its managed orchestrator].
You are the sole coordinator; keep the canonical directory. Acknowledge startup
and actual execution readiness or the exact pending gate. The planner observes
startup and retains strategic review; it will not dispatch a competing child.
```

An owner's child prompt uses its assignment and the same exact-skill instructions.
References to human approvals must be accessible and checked; a role prompt cannot
manufacture them. Carry launch state through authorized handoffs. After settling
its own jobs, a planner successor may inherit observation of a recorded pending
owner/orchestrator launch; it must reconcile that outcome before any retry.
This does not transfer execution resources to the planner or permit a duplicate
coordinator. Unknown creation of the planner successor itself still requires
reconciliation before retry or source recovery. Until a coordinator is available,
planner notes and exclusive claim receipts preserve its current binding; the
coordinator reconciles that binding before dependent dispatch. No heartbeat is
created by startup; recurring review remains a separately authorized option.
