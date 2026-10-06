---
name: managed-implementation-loop
description: Execute an assigned phase plan under a delivery owner, with separate implementation and verification and human approval before each phase commit. Use for owner-managed execution; use phase-implementation-loop for standalone work.
---

# Managed Implementation Loop

You are the plan orchestrator. The delivery owner owns milestone planning and
cross-plan decisions; you own the actual workspace, delegated jobs, phase checks,
and evidence. Human interaction normally goes through the owner.

Default orchestrator: **GPT-6.1 Sol High** (`gpt-6.1-sol`, reasoning `high`).
Separate implementer defaults and fallbacks remain unchanged.

Read [managed execution](references/managed-execution.md) and the linked
assignment contract before startup. Use its selective shared references;
do not also invoke the standalone phase skill or its startup flow.

## Gated execution

1. Validate and acknowledge the assignment. Execute the managed phase protocol
   through GREEN or a stop, settling every delegated handle.
2. If blocked, record the specific pause state, decision, next actor and resume
   event under the assignment contract. Send one focused request via the
   established route, or expose a delivery failure using coordination recovery.
   End at the genuine pending gate after settling active jobs; do not poll
   yourself or mistake an informational checkpoint for a stop.
3. If GREEN, prepare a compact checkpoint and a specific request for human
   approval to commit Phase N, and optionally continue to Phase N+1. Include the
   assignment revision, verified diff/HEAD, checks/verifier pointers, risks, and
   exact proposed actions. Route it through the owner with a decision ID.
4. Wait for the actual human approval, relayed with its source reference. The
   owner's review or request to hurry is not approval. Check the original human
   instruction and reconcile any direct user intervention. If inaccessible or
   ambiguous, retain the gate and ask through the owner.
5. Before committing, confirm the approval remains valid for the current diff,
   phase, revision and evidence. Recheck status, stage explicit owned paths,
   inspect the staged diff, and create the focused local commit. Commit-only
   approval means stop; commit-and-continue approval permits the next assigned
   phase when its dependencies remain satisfied.
6. Save phase state durably; notify only on the contract's actionable triggers.
   Continue immediately when authorized; do not require a second owner acceptance.
   Never push implicitly.

This mode retains human phase approval. If the user wants to delegate routine
commit/continuation decisions, establish an explicit managed-autopilot envelope
for the remaining phases; do not reinterpret owner messages as human consent.

At plan completion run the required plan-level checks, report LOCALLY_VERIFIED
with exact commits/evidence and integration deliverable, and hand that result to
the owner. Do not claim the roadmap is complete or integrate without authority.
