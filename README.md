# Phase Implementation Loop

A Codex plugin with two standalone execution modes and an optional managed team:

- `$phase-implementation-loop`: phase-gated execution with approval before each
  commit.
- `$phase-implementation-autopilot`: bounded continuous execution with automatic
  commits for green phases and strict operator stop gates.

Both use one shared protocol and support configurable Codex, Cursor, and Claude
roles. The invoking agent orchestrates; a separate edit-capable agent implements.

For a single plan or a roadmap requiring coordinated plans:

- `$delivery-owner`: owns planning, dependencies, assignments, milestone
  acceptance, and the main human conversation. Defaults to Sol 6.1 High with
  compact, event-driven supervision and bounded Astra High consultation.
- `$managed-implementation-loop`: an assigned orchestrator executes phases and
  routes human commit/continuation approval through the owner.
- `$managed-implementation-autopilot`: an assigned orchestrator commits green
  phases within an approved envelope and routes exceptions through the owner.

Both managed modes default to a **GPT-6.1 Sol High** orchestrator
(`gpt-6.1-sol`, reasoning `high`). Implementer defaults and fallbacks remain
unchanged, as do independent-reviewer profiles. Explicit user-selected
orchestrator profiles override this default.

The standalone skills retain their own orchestration and approval modes. Managed skills use a
separate ownership protocol and reuse the existing worker and verification
mechanics. They ship together; do not install a managed mode without its owner,
managed protocol, and standalone reference dependencies.

## Managed Delivery

Start in the intended owner model's chat; a skill cannot switch its own model.
For example:

```text
Use $delivery-owner to plan delivery of this milestone. Keep the outcome and
acceptance criteria fixed. Propose at most two concurrent plans, choose managed
loop or managed autopilot per plan, and route human questions through this chat.
Keep supervision economical: compact checkpoints and evidence pointers, with
detailed inspection only when a decision or acceptance claim requires it.
Prepare the execution agreement before launching orchestrators.
```

The agreement explicitly covers creating orchestrator chats/worktrees, messaging
in both directions, execution/commit authority, integration, and any handoffs.
An approved agreement can be reused without repeated routine questions. A plan,
skill invocation, or message from another agent does not independently grant
those permissions. Direct human interventions remain supported and are
reconciled through the owner when they affect other work.

Use one owner index, a phase-state file per plan, isolated worktrees/resources,
and serial integration. The Sol owner reads changed checkpoints, resolves cross-plan
decisions, and checks milestone evidence; orchestrators handle detailed execution
and independent verification. Owner review does not replace that verification.
Ordinary autopilot green checkpoints stay in durable state without waking the
owner or waiting for approval. Actionable events trigger authorized messages.
The owner consults Astra High for unresolved consequential architecture, material
planning uncertainty, repeated repairs indicating a faulty plan, or conflicting
cross-plan acceptance evidence. Astra returns bounded advice; it does not manage
orchestrators or independently review a design it helped author. No consultation
is required for routine planning or every checkpoint. Reloading a skill does not
change an existing chat's selected model.
Gated mode still
requires the actual human's scoped approval, even when relayed by the owner.

Startup verifies the authorized return-message route. Every genuine pause names
the next actor, resume event and recovery route; informational checkpoints do
not stop authorized work. Owner observation is bounded, and routine commentary
does not renew its polling window. Peers exchange deliverables without becoming
extra managers. Failed notifications are exposed as recovery issues.

Later recurring checks require a separately requested native heartbeat; this
package installs no daemon or scheduler. A heartbeat is a modest recovery safety
net and also consumes resources. Platform approval review may still reject
cross-chat authorization evidence; skill wording cannot guarantee delivery.
Automatic forks and recursive manager teams are outside the initial managed
workflow. See the owner's validation scenarios for maintenance checks.

Roadmaps can be planned progressively: keep future steps outlined, investigate
specific unknowns, and prepare the next executable plan as evidence arrives.
The agreement separates investigation/planning authority from launching new
plans. New plans require human approval unless explicitly covered by bounded
delegated continuation; this does not remove managed-loop phase approvals.
Existing complete plans execute directly without an added replanning cycle.
Roadmap completion covers all milestone criteria, including unplanned steps.

Review timing follows risk and delivery boundaries: independent review of
consequential designs before dependent implementation, early compatibility checks
as interacting pieces become usable together, and a compact owner outcome check
at an agreed boundary for long autopilot plans (pilot default: three substantive
phases without such inspection). The last check pauses new phase starts for owner
inspection, not new human approval. Ordinary green checkpoints stay local.
Phase verification and final milestone checks remain required; valid evidence is
reused. Measure review time, actual owner usage, rework, and integration defects
before tuning this pilot setting.

## Install

Prerequisites:

- Codex installed and available as `codex` on `PATH`.
- Git available in repositories where the phase loop should create branches or
  commits.
- Optional peer agents installed and authenticated only where you want to use
  them: Cursor Agent as `cursor-agent` and Claude Code as `claude`.

Add this repository as a Codex plugin marketplace. The command is the same from
macOS/Linux shells, Windows PowerShell, and Windows `cmd.exe` when `codex` is on
`PATH`:

```text
codex plugin marketplace add crawlon/phase-implementation-loop --sparse .agents/plugins
```

Then restart Codex and install **Phase Implementation Loop** from the plugin
directory.

## Cross-Platform Notes

The plugin is platform-neutral: it is a Codex plugin manifest plus Markdown
skill instructions. No Bash-only setup script is required. The shared protocol
covers command discovery and shell adaptation on macOS, Linux, PowerShell, and
`cmd.exe`.

## What It Does

- Reconciles markdown plans and Linear issues into a canonical markdown phase
  plan before implementation starts.
- Assesses every phase as TINY, ROUTINE, or COMPLEX against THIN, ADEQUATE, or
  DETAILED plan detail, then recommends either more detail or the least expensive
  capable implementer.
- Delegates planning and replanning to Codex GPT-6 Astra at high reasoning, with
  Claude Opus 5.5 as the fallback, while the orchestrator retains plan ownership.
- Lets the invoking orchestrator recommend or confirm an execution profile for
  Codex, Cursor, and Claude roles.
- Keeps Codex implementation separate from orchestration: a selected Codex
  implementer always runs as an edit-capable worker sub-agent.
- Runs phase by phase with planning, implementation, verification, phase reports,
  approval gates, commits, and durable handoffs.
- Keeps prerequisites tied to delivery criteria, reuses still-valid evidence,
  permits direct factual bookkeeping, and checks drift without routine extra
  planner calls, artifacts, or approval cycles.
- Shapes phase boundaries around reviewable behavior, independently checks
  consequential designs before dependent implementation, tests cross-phase
  interactions at their earliest useful boundary, and checks cumulative outcomes
  at named delivery milestones. Standalone orchestrators do these within the
  existing loop; no delivery owner or additional approval cycle is required.
- Monitors context at existing checkpoints and, with approved rollover authority,
  transfers to a fresh primary orchestrator using a compact handoff while
  preserving workspace identity, evidence, and pending gates.
- Offers an explicit autopilot variant that freezes the approved scope, commits
  each green phase, continues without routine approval pauses, and stops on
  ambiguity, insufficient verification, or high-risk actions.
- Defaults implementation to a separate Codex Luna 6 Max worker, with Cursor
  Grok 4.7 as the first fallback and task-appropriate model/effort selection if
  both are unavailable. Capability assessment still preserves phase requirements.
- Delegates UI/UX browser review to a fresh non-editing Codex Luna 6 Max reviewer.
- Uses Claude Opus 5.5 as the preferred external verifier, fresh Codex Astra High
  as the first fallback, and Cursor GLM 5.3 High as the second fallback.
- Keeps wrappers transport-focused: agent policies, prompts, defaults, and
  fallbacks live in the skill references. Optional hardened macOS/zsh Cursor
  wrappers live under `scripts/cursor-bridge/`.
- Packages both execution modes together; autopilot intentionally reuses the
  gated skill's shared protocol and agent references.

## Structure

```text
.agents/plugins/marketplace.json
plugins/phase-implementation-loop/
  .codex-plugin/plugin.json
  skills/phase-implementation-loop/
    SKILL.md
    references/
      shared-protocol.md
      phase-capability.md
      delivery-policy-scenarios.md
      context-rollover.md
      delegated-jobs.md
      agent-prompts.md
      agent-codex.md
      agent-cursor.md
      agent-claude.md
  skills/phase-implementation-autopilot/
    SKILL.md
    agents/openai.yaml
  skills/delivery-owner/
    SKILL.md
    agents/openai.yaml
    references/
      contracts.md
      coordination.md
      progressive-planning.md
      review-policy.md
      validation-scenarios.md
  skills/managed-implementation-loop/
    SKILL.md
    agents/openai.yaml
    references/managed-execution.md
  skills/managed-implementation-autopilot/
    SKILL.md
    agents/openai.yaml
scripts/
  cursor-bridge/
    bin/
    tests/
```
