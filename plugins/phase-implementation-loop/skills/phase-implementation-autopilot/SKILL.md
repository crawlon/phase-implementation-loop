---
name: phase-implementation-autopilot
description: Execute an approved multi-phase plan continuously, with the invoking agent as orchestrator, delegated implementation, independent verification, automatic green-phase commits, and strict operator stop gates. Use only when the user requests autopilot or no per-phase approval. Requires the companion phase-implementation-loop skill from this plugin.
---

# Phase Implementation Autopilot

Run an approved canonical plan continuously on one dedicated branch. The invoking
agent is the orchestrator and does not implement code. Commit each GREEN phase and
start the next without routine approval; preserve state and stop whenever work
leaves the approved execution envelope.

```text
Continue only while the phase is GREEN and inside the frozen envelope.
Otherwise preserve state and ask one focused operator question.
```

## Shared Protocol

This mode depends on its packaged companion skill. Before planning, read:

- `../phase-implementation-loop/references/shared-protocol.md`
- `../phase-implementation-loop/references/delegated-jobs.md` before delegation
- `../phase-implementation-loop/references/agent-prompts.md`
- only the selected `agent-codex.md`, `agent-cursor.md`, or `agent-claude.md`

Those files are authoritative for plan synchronization, role separation,
deterministic routing, Codex worker selection, terminal handling, verification,
fallbacks, and prompt contracts. This file defines only autopilot authorization,
commit behavior, and stop gates.

## Startup Envelope

Before Phase 1, inspect repository instructions, worktree, branch, git status,
plan sources, and required tools. Then present one compact envelope containing:

- repository/worktree and canonical markdown plan
- synchronized Linear issue range and authorized tracker mutations
- dedicated branch for the whole plan
- implementation routes/fallbacks and verifier chain
- permission to edit, test, stage exact phase-owned paths, create focused local
  commits, and continue through every listed phase
- durable-state artifact
- prohibited actions and mandatory stop conditions

Obtain one explicit approval unless the user's autopilot request already names
the same repository, plan/phase range, local commit-and-continue authority, and
prohibited-action boundary. Never infer broader authority from the word
“autopilot.”

Use `shared-protocol.md` to reconcile markdown and Linear. Tracker creation or
material updates must be listed in the envelope; otherwise prepare the mapping
and stop for authorization. Begin implementation only after a re-read proves
complete synchronization.

Establish one dedicated branch using repository conventions or
`agent/<plan-slug>`. Prefer a separate worktree for unattended or parallel work.
Require a clean start or precisely attributed pre-existing changes.

Standing authorization never includes push, deploy, release, production/live
database access, destructive operations, secrets/credentials, risky branch
changes, closing issues, or material scope changes unless each action is
explicitly added. Platform approvals and repository policy still apply.

## Frozen Envelope And State

Freeze phase order, objectives, acceptance criteria, dependencies, and
out-of-scope boundaries at startup. Evidence and status may evolve; material
behavior, scope, architecture, or risk changes require operator approval.

Name one repo-appropriate markdown state artifact, preferably beside the plan.
Update it before every phase commit and before any stop or handoff. In addition
to the common durable state, record the frozen envelope, current and next phase,
phase commit hashes, fallback reasons, retries, and exact operator decision
needed. The current phase's state update may live in its commit without
self-referencing that commit hash.

## Autopilot Phase Loop

For each phase:

1. Run the Common Phase State Machine in `shared-protocol.md` through its GREEN or
   stop decision. Drive every delegated handle to terminal completion.
2. If not GREEN, do not commit partial work. Preserve the workspace, update state,
   and stop with the failed gate, evidence, attempted repairs, last green commit,
   uncommitted paths, and one focused question.
3. If GREEN, update durable state, recheck `git status --short`, stage only
   explicit phase-owned paths, inspect the staged diff, and create one focused
   phase commit.
4. With tracker authority, update linked issues with branch, commit, verification,
   blockers, deferrals, and next step. Do not close or change status/ownership
   without explicit authority.
5. Emit a compact checkpoint containing phase, commit, tests, verifier verdict,
   fallback/degradation, and deferrals. Do not ask a routine question.
6. If another approved phase remains and no stop gate applies, begin it
   immediately. Never push automatically.

## Mandatory Stop Gates

Stop and ask for operator guidance when:

- scope, order, dependencies, acceptance criteria, behavior, or architecture
  must change materially
- unexpected auth/security, public-contract, migration, concurrency, data-loss,
  production, credential, destructive, or live-service risk appears
- important tests cannot run or remain red after two distinct repairs
- verifier findings conflict on a high-risk issue
- verifier confidence is insufficient, including a critical phase that reaches
  only the Codex verifier fallback
- no separate edit-capable implementation agent is available
- pre-existing/concurrent changes make path ownership uncertain
- branch, worktree, or history identity diverges unexpectedly
- an action outside the startup envelope requires permission
- the next phase needs an operator/product decision
- durable state cannot confidently reconstruct the result

On stop, never reset, discard, revert, or clean uncertain work.

## Completion

After the final phase, run combined plan-level verification appropriate to risk,
confirm branch/worktree state, update durable state, and report phase commits,
tests, verifier tiers, fallbacks, deferrals, remaining risks, and every unperformed
push, deploy, release, or tracker action.
