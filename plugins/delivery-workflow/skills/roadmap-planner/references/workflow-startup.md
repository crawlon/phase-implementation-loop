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
2. Reuse approved mode, [role profiles](../../implementation-orchestrator/references/shared-protocol.md#role-profiles)
   and permissions. Resolve missing exact model/effort selections and coordination
   scope together in the [bounded agreement](#bounded-coordination-agreement)
   before launch; executing actors retain operational approval gates.
   Set the [Planner checkpoint and time backstop](retained-planning.md#direction-reviews)
   in the existing brief and pass its pointer to the coordinator.
3. Select the child skill from the table below. Resolve its absolute `SKILL.md`
   path in the installed stable bundle or this self-contained source bundle and
   verify it exists and matches the actual role/writer responsibilities. Reconcile
   any legacy or conflicting skill path read-only before relying on it; preserve
   independent work. Pass
   that path and explicit read instructions in the initial
   prompt; the child reads its entrypoint and the references required for its
   next action automatically. Supply explicit coordination/execution settings;
   do not import legacy protocols or the other coordination contract.
4. Follow the applicable [native launch and identity rules](../../delivery-owner/references/coordination.md#launch-only-the-authorized-cohort).
   Use fresh role prompts, not a fork of the planning transcript. Preserve human
   profile overrides; pass the approved model and reasoning explicitly under
   the shared launch contract, with original selection evidence. Record LAUNCH_PENDING and returned handles
   in existing planner notes before relying on the coordinator's state. Reconcile
   queued/unknown outcomes before retrying; a queued client ID is not a thread ID.
5. **Standalone:** the planner creates/adopts one orchestrator. **Managed:** the
   planner creates/adopts one owner; the owner establishes its index/assignment
   and creates/adopts the first orchestrator under the same bounded authority.
   The planner never also creates that managed orchestrator. An existing active
   cohort adopts only at a safe checkpoint, preserving writers, budgets and gates.
6. Observe using native status/wait/read tools until the coordinator acknowledges
   actual role/writer binding, coordination/execution settings, native model/effort
   evidence, workspace, role skill/path read and next observable result or exact pending gate.
   For managed startup the owner checks its child's acknowledgement and publishes
   the result. Creation success alone is not running execution. Report a real
   approval or recovery boundary accurately; no duplicate launch to escape it.
   After acknowledgement the coordinator maintains the role directory and owns
   later execution dispatch. Each role owns its supporting subagents under the workflow
   agreement. Planner notes retain the bootstrap receipt and planning evidence.

| Child role | Skill | Assignment settings |
| --- | --- | --- |
| Standalone orchestrator | `implementation-orchestrator` | `coordination: standalone`; approved `execution: gated | autopilot` |
| Owner | `delivery-owner` | Preserve each child's approved execution setting in its assignment |
| Owner's orchestrator | `implementation-orchestrator` | `coordination: owner-managed`; approved `execution: gated | autopilot` |

Absent approved autopilot, select gated execution; this does not waive its
execution-profile or phase-commit approval. Reuse an already approved profile.

## Bounded coordination agreement

Use the existing agreement, not another ledger. When needed, present one concrete
human approval request naming the assignment/roadmap, current actors and permitted
roles and their exact model/effort selections, permitted fallbacks and successor
coverage, sole launcher per role, necessary message directions/purposes/content,
exclusions, and same-assignment successor creation and communication coverage.
Bind future IDs through verified succession; specify the assignment's end or
other agreed expiry. State which execution grants carry forward and which
operations still lack authority. For external delegation, reuse applicable
[provider consent](../../implementation-orchestrator/references/shared-protocol.md#external-provider-consent),
including a verified global grant; request only its missing scope.

Propose coverage for the remaining assignment and its verified successors rather
than one generation at a time. If the human chooses narrower coverage, retain it.
An approved grant is reused within its actual scope; changed recipients outside
the cohort, resources, scope or reserved actions need the relevant authority.
Skill/plan selection alone grants no action authority; apply explicit standing
grants only when their actual opt-in conditions and scope are satisfied.
Before launch each actor verifies original human evidence and its binding; actual
tool delivery remains separate. A platform rejection still uses coordination
recovery. Missing authority pauses only dependent actions, not independent work.

## Child startup prompt

Populate this compact prompt with verified values and actual source references:

```text
The human selected the delivery workflow and requested this role: [original request].
Act as [canonical name/generation]. Read $[selected skill] at [absolute SKILL.md]
now, then its required startup references; do not ask for manual skill invocation.
Plan/goal/acceptance/rationale: [paths and revisions].
Planning writer and authorized documents/sections: [planner binding or no-planner fallback].
Execution adoption: [approved revision and authority; changed revisions need reconciliation].
Last goal assessment/rationale and next observable outcome: [current result or not yet assessed].
Planner checkpoint, active-work backstop and wakeup/recovery route: [current brief pointer].
Workspace and ownership: [repository, host, checkout/worktree, branch, HEAD, dirty paths].
Selected role/model/effort and permitted fallback: [approved row/source; successor coverage].
Execution assignment settings: [coordination + execution; original approval source].
Authority: [original human sources, allowed actions/mode, limits and gates].
Bindings: [planner and existing coordinator/actors, IDs/hosts, message purposes,
successor scope and actual route status; unknowns explicitly named].
Next action: [standalone: establish phase state and begin allowed work;
owner: establish index/first assignment and launch/adopt its managed orchestrator].
You are the sole coordinator; keep the canonical directory. Acknowledge your
actual role, assignment settings, native model/effort evidence, loaded role skill/path and readiness
or exact pending gate under the shared role-profile contract.
The planner observes
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
