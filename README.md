# Delivery Workflow

The active bundle has three skills: **roadmap-planner**, **delivery-owner** and
**implementation-orchestrator**. Start with the planner; add an owner only when
cross-plan coordination warrants it. The orchestrator supports standalone or
owner-managed coordination and gated or explicitly authorized autopilot execution.

See the [workflow guide](plugins/delivery-workflow/README.md) for invocation,
installation and validation, and the
[migration guide](plugins/delivery-workflow/skills/roadmap-planner/references/migration.md)
for running assignments and rollback.

The former phase-loop, managed-loop/autopilot and trial bundles are retired from
this marketplace. Their source paths remain frozen for existing assignments;
new work uses Delivery Workflow 1.2.0. Installing it does not migrate a running
actor or change its approvals.

Both the phase-implementation-loop and delivery-owner repositories carry the same
active bundle. Select one installation to avoid duplicate skill names. Existing
marketplace repository identities remain valid; each now offers Delivery Workflow.
Local development installs can symlink the three stable folders into
`~/.agents/skills` and disable legacy discovery entries without deleting their files.

Codex and Git are required for repository execution. Approved external profiles
may use the optional [Claude bridge](scripts/claude-bridge/README.md) or
[Cursor bridge](scripts/cursor-bridge/README.md). UI-affecting work also uses the
separately installed `ui-ux-browser-review` skill. No provider credentials or
background scheduler are included.
