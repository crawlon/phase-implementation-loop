# Execution Modes

Read at startup/adoption, a proposed mode change, or recovery of commit authority.
The assignment records `execution: gated | autopilot` separately from
`coordination: standalone | owner-managed`. Preserve both through handoff.

## Authority

Reuse valid original human authority and profile selections; resolve only missing
scope. Gated execution requests human approval before each phase commit. Autopilot
requires an explicit envelope covering the concrete assignment or bounded future
assignment eligibility, owned-path staging, local commits and automatic continuation.
The word autopilot, an owner instruction, silence or a skill change alone is not
that authority. Missing execution approval is requested directly in the executing
chat; owner notification is awareness, not a second human-approval gate.

The envelope records plan revision/phase range, host/repository/worktree/branch,
allowed edits and checks, profile/capability routes and fallbacks, exact targets,
risks/incidental effects, retry bounds, exclusions, frozen objectives/acceptance/
dependencies/order, durable state and mandatory stops. Include authorized tracker,
communication and automatic handoff scope; each action still needs actual coverage.
Do not start with an unresolved incompatible implementer/profile. Resolve plan
detail versus stronger implementer under the capability assessment.

For owner-managed future plans, original bounded future-plan authority plus the
owner's recorded eligibility decision can bind a later concrete assignment. The
original message need not enumerate a then-nonexistent revision or worktree if it
explicitly delegated those choices. Preserve the original bounds and local commit
and continuation authority; the owner's eligibility record cannot create them.

Autopilot grants no implicit push, deployment, release, production/live database
access, destructive actions, credentials, risky branch changes, issue closure or
cross-plan integration. Each requires its own established scope. Platform approval
and repository policy remain binding in both modes.

## Commit and continuation

1. Run the selected coordination contract to GREEN with required evidence,
   valid dependencies, correct revision and all owned jobs terminal. If not GREEN,
   preserve dirty work and report the failed gate, attempts, last green commit,
   owned paths and next decision; do not commit partial work.
2. **Gated:** present one concrete request to commit Phase N and, when appropriate,
   continue to Phase N+1. Include assignment/revision, diff/HEAD, checks/verifier
   pointers and material risks. Reuse an existing explicit approval valid for this
   phase, diff and scope; reconcile material changes against the original human
   instruction. Commit-only approval means stop; commit-and-continue means both.
   Owner requests or outcome inspection never replace human commit approval.
3. **Autopilot:** when GREEN and inside the approved envelope, commit without a
   routine approval request. Update durable state before the commit. Keep commit
   hashes, current/next phase, fallback reasons, attempts and pending gates; the
   current state file may be committed without self-referencing that commit hash.
4. Recheck `git status --short`, stage explicit phase-owned paths, inspect the
   staged diff and create one focused local commit. Tracker updates require their
   existing authority; status/ownership changes and closure are separate actions.
   In a non-git workspace disclose that commits are unavailable; skip git-only
   steps without weakening checks or continuation authority.
5. Continue immediately after a successful or validly skipped commit when that
   continuation is authorized, dependencies hold and no applicable stop remains.
   In owner-managed work, an explicitly agreed owner outcome/drift checkpoint
   pauses the dependent phase starts/actions named in that checkpoint until the
   inspection occurs; preserve any explicit assignment-wide pause. Ordinary GREEN reports
   require neither an owner receipt nor a planner signature. In standalone work,
   the orchestrator performs due outcome checks without importing owner gates.
6. Check context and perform due authorized rollover before the next substantial
   step. Preserve both settings and the envelope; handoff grants no new authority.

## Stop and decision routing

Both modes retain the applicable phase protocol's repair, review, ownership and
permission stops. Stop affected work for missing required evidence/checks,
insufficient or conflicting high-risk verification, exhausted repair/fallback
bounds, no separate implementer, unexpected partial writes, uncertain dirty-path
custody, branch/worktree divergence, incompatible capability/profile, unrecoverable
authority/state or degraded context without safe authorized handoff.

Autopilot additionally stops when required tests remain red after two distinct
repairs, important tests cannot run, unexpected security/auth/public-contract/
migration/concurrency/data-loss/production/credential/destructive/live-service risk
appears, or the next action needs an unresolved product decision or lies outside
the envelope. Preserve the separate stop for two materially similar red cycles
without new evidence or a distinct fix; advice does not reset either repair bound.

- **Standalone:** material changes to frozen scope, order, dependencies, acceptance,
  behavior, architecture or risk require human approval. Required retained-planner
  input unavailable without authorized recovery pauses dependent work; without a
  retained planner, standalone autopilot requires an explicit envelope allowance
  for degraded planning after both routes are exhausted. Standalone gated execution
  retains the shared protocol's disclosed, bounded direct-planning fallback after
  both routes are unavailable. Advisory silence alone is not a stop.
- **Owner-managed:** send plan/assignment/cross-plan changes to the owner. It may
  amend within delegated bounds using acknowledged revisions; a plan amendment
  alone neither cancels valid autopilot authority nor creates a human gate.
  Preserve frozen ordering and actual hard restrictions. Human approval is needed
  for reserved choices or expanded authority. An unavailable owner pauses decisions
  requiring that owner, not independent authorized work. Required owner inspections
  remain gates distinct from human approvals.

A human stop takes effect immediately. Preserve state/handles and use safe
interruption; do not launch more work. Other material human interventions in
managed work require owner reconciliation of affected plans. Never reset, clean,
discard or overwrite uncertain work to recover convenience. Ask the responsible
actor for the concrete missing decision, not a fresh approval of settled work.
