# Delivery Workflow Trial 0.1.0

A separately selectable experiment. The current five skills and their protocol
files remain unchanged. Trial skills use their own copied worker/verification
references; no trial entrypoint imports a current skill's mutable protocol.
Select the workflow once in the existing planning chat. Child skills stay
explicitly named in startup prompts; installing the trial does not select it
for unrelated work.

## Start from the planning chat

After planning, ask your planning agent:

```text
Use $roadmap-planner-trial to start execution of this approved plan.
Create an orchestrator and an owner only if the roadmap needs one.
```

The planner chooses the structure, reuses suitable approved chats and starts the
workflow. For one execution stream it launches the orchestrator directly. For
interacting plans or a roadmap needing continuing planning and cross-plan decisions,
it launches an owner that creates the managed orchestrator. Every child receives
and reads its exact trial skill and required references automatically. You do not
need to invoke another skill in each chat.

Existing execution mode, profiles and authority are reused. If necessary, the
planner presents one compact startup agreement for missing permissions and bounds,
including coordination messages and successor coverage. External CLI delegation
reuses applicable human provider consent, including global workflow-wide grants,
across correction rounds and verified handoffs; command rules remain separate.
Phase approvals remain
in gated mode; autopilot requires explicit bounded authority. Creation success is
reported as execution only after verified startup, with any pending gate named.
See [startup mechanics](skills/roadmap-planner-trial/references/workflow-startup.md).

After launch, the planner regularly assesses capability gained, necessary learning,
remaining blockers and whether to continue or change direction, using the agreed
review cadence and actual authorized wakeup route. Reviews compare cumulative
evidence from the last meaningful capability milestone, including the cost of
accumulated prerequisites and credible alternative sequences. A review interval
is not a deadline. Existing human limits and required assurance remain.
The planner preserves rationale and proposes later plans. The owner or standalone
orchestrator owns canonical execution
decisions and dispatch. Specific technical consultation and independent verification
remain separate. Routine GREEN phases need no planner signature or message.
Assignments bind outcomes and invariants; proposed technical mechanisms remain
delegated choices unless explicitly mandatory. Necessary preparation retains its
blocker and observable exit. Routine progress stays local; unchanged human gates
need no repeated assessment. Each role replaces one linked current brief while
preserving decisions, failed attempts, approvals and immutable evidence in history.

The shared [role specification](skills/phase-implementation-loop-trial/references/shared-protocol.md#role-profiles)
proposes Astra High for strategic planning/consultation, Sol 6.1 High for ownership
and managed orchestration, and Luna Max for bounded research and compatible simple
coding. Existing UI and independent-verification routes remain. Startup records
explicit human model/effort selections and permitted fallbacks; handoffs reuse
those rows and verify native settings before adoption, never silently substituting
an app default. Optional recurring reviews require authorized native heartbeats.

The other five entrypoints are workflow components and remain available for direct
adoption by advanced users. Existing chats adopt at safe checkpoints with their
work, approvals and pending gates preserved.

## Safe continuity and switching back

Use `Planner-<roadmap-key>-generation<N>`, `Owner-<plan-key>-generation<N>` and
`Orchestrator-<assigned-plan-key>-generation<N>` consistently in native titles,
state and requests. Stable plan keys and exclusive claims determine identity;
names and workflow selection do not grant authority or reset generations.

Each role assesses its own context. Authorized handoffs settle owned jobs and
use one launcher, exclusive session-bound claims, exact workspace custody,
compact durable state and per-direction permission/route evidence. Independent
roles can continue. Every successor reads and verifies the exact trial skill
matching its actual role/writer responsibilities. Handoffs carry the last goal
assessment and rationale, next observable outcome, review cadence and actual
heartbeat rebinding or explicit degraded recovery; titles alone cannot change roles.

To leave the trial:

```text
At the next safe checkpoint switch this assignment to [current skill name].
Preserve workspace, dirty ownership, accepted evidence, repair budgets, approvals
and due inspections. Reconcile canonical writers, current role bindings and
changed assignments. Pause or rebind trial-specific automation only within its
approved lifecycle. Report any coordination recovery needed before relying on it.
```

The current names have no `-trial` suffix. Existing current assignments do not
migrate merely because this plugin is installed. Switching skills leaves produced
implementation work intact; it does not reset, discard, commit or restart phases.
Existing frozen constraints and review gates remain until explicitly amended.

## Installation and validation

This optional plugin is available alongside the current plugin in each repository's
marketplace. Install the entire trial bundle; do not mix current/trial dependencies
or install only an entrypoint. Local development installs may link all six trial
skill directories into `~/.codex/skills` without replacing current directories.
Use one source checkout for the local links. Reload skill discovery if the app
has not picked up the new names. Installation does not launch an execution cohort.

Run `scripts/validate_bundle.py` with Python and PyYAML, then the skill-creator
`quick_validate.py` for each skill. The bundle validator checks manifests, explicit
selection, names, local references/anchors and isolation from current protocols.
Behavioral scenarios are maintenance-only; evaluate raw cases independently of
their expected-result tables. Structural and simulated checks do not prove live
coordination or lower usage.

Pilot a small authorized roadmap, retaining the same acceptance and assurance.
Use existing receipts to compare time to verified outcomes, implementation and
verification time, owner/planner/human waits, repeated repairs, integration defects
and actual role usage. Include a direction correction and safe handoff. Test both
managed and standalone configurations offline before relying on them live.
