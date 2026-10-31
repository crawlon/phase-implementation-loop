# Delivery Workflow 1.0.0

Three role skills replace the earlier trial and phase-loop variants:

| Skill | Responsibility |
| --- | --- |
| `$roadmap-planner` | Usual entrypoint: start an approved plan, retain planning rationale and assess progress toward the fixed goal. |
| `$delivery-owner` | Optional delivery coordination across interacting plans, dependencies and successive planning steps. |
| `$implementation-orchestrator` | Execute a concrete plan with separate implementers and independent verification. |

Start from the existing planning chat:

```text
Use $roadmap-planner to start delivery of this approved plan.
Create an orchestrator and add an owner only when the roadmap needs one.
Preserve my approved execution profile and permissions.
```

The planner launches the standalone orchestrator or the owner; only the owner
launches managed orchestrators. Each child loads its role skill automatically.
Creating chats, messaging and operational actions still require their actual
human authority. Planning alone does not authorize execution.

For direct execution of an already prepared plan:

```text
Use $implementation-orchestrator to execute this plan.
Use standalone coordination and gated execution.
```

Execution settings replace four separate skills:

- `coordination: standalone | owner-managed` records canonical ownership and routing.
- `execution: gated | autopilot` records phase-commit and continuation authority.

Preserve existing settings. New work is gated unless explicitly authorized for
autopilot. A skill name, owner request or handoff never enables autopilot. Both
settings survive context handoffs; the orchestrator reads only its coordination
contract plus the shared mode rules. Independent review, repair stops, runtime
model verification, custody and approval boundaries remain mandatory.

Each role directly delegates support within its responsibility. Planner research,
analysis and drafts need no owner/orchestrator relay. Execution tests, code edits
and live operations remain with execution. Luna Max handles compatible bounded
support and simpler code; the approved profile/capability assessment governs
stronger routes. Retained agents keep their actual selected models.

The planner regularly assesses cumulative capability, learning, blockers and the
shortest credible route to the goal. Review cadence is agreed, not a deadline.
Recurring wakeups need an authorized native heartbeat. Routine progress stays
local; each role maintains a compact current brief with linked evidence/history.

## Install and migrate

Install this whole bundle, not isolated entrypoint files. Select only one copy
if both mirror repositories are available. For local development, link its three
skill folders into `~/.agents/skills`; preserve unrelated installed skills.
Disable retired local entries by their SKILL.md path instead of deleting paths
still referenced by running work. Codex configuration changes require an app
restart to refresh discovery; they do not restart the underlying assignment.

Existing assignments adopt explicitly at a safe checkpoint, preserving role,
settings, authority, evidence and pending gates. Follow the
[migration and rollback procedure](skills/roadmap-planner/references/migration.md).
Legacy source bundles remain frozen and absent from the active marketplace for
saved-path continuity; they are not additional supported workflow choices.

## Validate

With Python and PyYAML, run `scripts/validate_bundle.py`, then skill-creator's
`quick_validate.py` for each of the three skills. The validator checks packaging,
marketplace registration, metadata, local links/anchors and legacy isolation.
Maintenance scenarios in the owner/orchestrator references exercise role behavior;
they are not routine execution work. Evaluate all four coordination/execution
combinations, promotion with pending jobs/approvals, and safe successor handoffs.
These checks do not establish live adoption, provider availability or token savings.
