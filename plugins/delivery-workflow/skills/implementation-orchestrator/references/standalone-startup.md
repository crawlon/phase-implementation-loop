# Standalone Startup

Read only for `coordination: standalone`. Existing assignments resume their
checkpoint rather than repeating Phase 1 startup.

1. Read repository/workspace instructions; reconcile host, checkout/worktree,
   branch/HEAD, dirty-path custody and relevant process identity. Preserve existing
   approved settings and the optional retained planner binding.
2. Have the designated planning writer reconcile sources into canonical Markdown;
   prepare the exact Linear create/update
   mapping under [Canonical Plan And Linear](shared-protocol.md#canonical-plan-and-linear).
   Include absent issues rather than silently dropping tracking. Prepare the
   mapping before requesting missing tracker authority. Start implementation only
   after an authorized update/re-read proves complete synchronization.
3. Read the phase capability assessment. Reuse or propose one compact execution
   profile: planning/replanning route, implementers per phase, permitted fallbacks,
   independent verifier chain, UI reviewer where needed, exact models/efforts,
   useful phase boundaries, design/early-integration checks and outcome milestones.
   Resolve incompatible basic implementers by adding adequate plan detail or using
   a stronger implementer; risk requirements still apply. Obtain missing profile
   approval for material work; do not re-ask a valid selection each phase.
4. Establish the [selected execution mode](execution-modes.md#authority) and
   original action authority for this repository/plan, targets, risks, incidental
   effects, repair limits and exclusions. Include approved context monitoring and
   automatic fresh-orchestrator handoff, unless manual handoff was chosen. Present
   missing permissions together; do not treat the word autopilot as an envelope.
5. Name a durable-state location containing the shared protocol's required fields;
   an explicitly assigned section in the canonical plan may serve when sufficient;
   preserve the planner's separate content custody. Record current/next phase,
   coordinator/execution settings, actual profile and exact pending gates. With a
   retained planner, set the shared [Planner checkpoint and time backstop](../../roadmap-planner/references/retained-planning.md#direction-reviews)
   in that brief at startup or adoption.
6. Use one dedicated branch for the whole plan, following repository conventions
   or `codex/<plan-slug>`. Reuse suitable authorized workspaces. Unattended/parallel
   work can use an authorized separate worktree with clear resource ownership.
   Require a clean start or precisely attributed pre-existing changes; do not
   reset, clean or stash to obtain it. In non-git directories disclose unavailable
   commits and skip git-only steps while preserving other gates.

Proceed with the Common Phase State Machine in the shared protocol. Execution
approval/readiness, adoption receipts and execution dispatch stay here unless an
explicit coordination change establishes an owner. A selected retained planner
owns planning content and edits under the shared workflow agreement.
