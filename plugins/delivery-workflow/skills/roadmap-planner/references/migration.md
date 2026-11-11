# Adoption and Rollback

Use only when an existing assignment explicitly adopts this stable workflow or
returns to a pinned legacy release. New assignments use the three stable roles.
Promotion changes packaging and routing; it grants no execution or messaging authority.

## Map the existing assignment

| Previous skill (including its trial variant) | Stable role | Preserve settings |
| --- | --- | --- |
| roadmap-planner-trial | roadmap-planner | Existing planner binding, notes and advisory scope |
| delivery-owner or delivery-owner-trial | delivery-owner | Existing canonical writer, child assignments and authority |
| phase-implementation-loop | implementation-orchestrator | standalone + gated |
| phase-implementation-autopilot | implementation-orchestrator | standalone + autopilot |
| managed-implementation-loop | implementation-orchestrator | owner-managed + gated |
| managed-implementation-autopilot | implementation-orchestrator | owner-managed + autopilot |

The old name is a mapping clue, not proof of the actual assignment or authority.
Resolve conflicting instructions against original human evidence. A historical
chat title cannot elect a planner, add/remove an owner or change execution mode.

## Adopt without restarting work

### Planning ownership in 1.1.0

Version 1.0.0 made the coordinator the canonical plan writer even with a retained
planner. In 1.1.0, a selected planner owns planning content and authorized plan edits;
the coordinator retains execution adoption, assignments, evidence disposition and
dispatch. Without a planner the existing coordinator planning fallback remains.

For an authorized existing assignment adopting this ownership change, record the
planning paths/sections and current writers in existing state. Settle affected
editing jobs and stop the previous writer's planning edits at a safe checkpoint;
acknowledge its relinquishment and the planner's exclusive custody before new edits.
Preserve the active adopted plan revision, pending changes and all execution gates.
Assign mixed-document sections explicitly, or keep execution status in existing
execution state. The coordinator records later execution adoption without rewriting
planner-owned content. Existing path restrictions and narrower human grants survive;
resolve only missing authority. Installing or rereading the bundle alone does not
transfer live custody, authorize messages or restart execution.

### Adoption steps

Version 1.2.0 standardizes the shared compact context assessment. At adoption,
reuse the current brief, available measurements and pending preparation/transfer
boundary; replace the old assessment line without replaying history to fill
unknown counters. This changes no role ownership, model, permission or execution gate.

For 1.3.0 and later, record or reuse the [Planner checkpoint and time backstop](retained-planning.md#direction-reviews)
in the existing brief at adoption. Carry forward the last equivalent Planner
review, existing wakeup authority and any already due check.

Version 1.4.0 offers [Fable 5.2 High](../../implementation-orchestrator/references/shared-protocol.md#opt-in-fable-consultation-and-review)
by explicit selection. Carry forward the existing models, fallbacks and provider
grants when adopting the bundle. Record a Fable selection only within its approved scope.

Version 1.5.0 adds repository adherence to the existing verifier review and
Planner checkpoint. Carry forward applicable evidence and the agreed checkpoint.

1. Reconcile the actual role, canonical writer, current assignment and both settings.
   Each adopting role settles its own jobs at a safe checkpoint. Other roles keep
   their independent authorized work; no coordinated full-cohort restart is needed.
2. Read the exact stable role's SKILL.md and its required references. Preserve
   current plan/phase, workspace/branch/HEAD, dirty-path custody, accepted and failed
   evidence, counters, hard limits, deferred criteria, next outcome and pending gates.
3. Carry original model/effort selections and fallbacks, permission sources, provider
   consent, cohort/message purposes, verified successor coverage and actual route
   limitations. A name change does not require renewed consent inside unchanged
   scope, and does not repair an actual platform rejection. Verify native settings;
   a skill read alone is not a model change or proof of adoption.
4. Record bundle version, exact stable path, role and coordination/execution settings
   in existing state. Reconcile changed assignments and writer/binding acknowledgements
   through authorized routes. Keep pending owner inspections and human approvals.
   Do not restart phases, redo valid checks, create another chat merely to reload,
   or import both old and new execution contracts.
5. Confirm the actual role/path/settings, preserved gate and next observable result,
   then continue authorized work. If reliable context is unavailable, use the normal
   authorized exclusive handoff. Its successor receives these same settings.

A compact instruction to an existing actor:

```text
At your next safe checkpoint, adopt Delivery Workflow 1.5.0 for this assignment.
Read [absolute stable role SKILL.md] and its required references. Preserve your
actual role, coordination/execution settings, approved models,
original permissions, work, evidence, repair bounds and pending gates. Settle your
own active jobs; do not restart phases or launch replacements just to reload.
For the authorized planning-ownership change, reconcile and acknowledge the previous
writer's relinquishment and the selected planner's exclusive planning paths/sections
before edits; preserve execution adoption/assignment ownership and the active revision.
Confirm the role/path/settings, remaining gate and next observable result, then
continue authorized work. Coordinate adoption with existing actors only through
already-authorized message routes; this instruction adds no new recipients.
```

## Retired discovery and rollback

The active plugin/marketplace exposes only the three stable skills. Legacy source
trees are frozen and unlisted, and old local paths can be disabled with Codex's
per-path skill configuration while remaining readable by existing assignments.
Keep those paths until their users have adopted; do not redirect an old path to
new behavior silently. Select one installed stable bundle to avoid duplicates.

Rollback sources before consolidation are phase-implementation-loop repository
commit `85f503b655e67fca12f1c66c0e935f613aa587b3` and delivery-owner mirror commit
`23f942101acf053af7c5dce61f6906db9ccc91a9`. Use a pinned copy; do not reset a dirty
checkout or unrelated work. Re-enable only the intended legacy discovery paths,
disable conflicting stable exposure and explicitly adopt at a safe checkpoint.
Reconcile old planning ownership and schedule/route bindings without reviving
superseded permissions or discarding produced work. Source preservation does not
prove live adoption or authorize automatic cleanup of legacy files.
