---
name: phase-implementation-loop
description: Execute a multi-phase implementation plan in gated mode, with the invoking agent as orchestrator, delegated implementation, independent verification, and approval before each phase commit. Use for markdown plans, Linear issues, parent issues with sub-issues, or mixed sources. Codex implementation always uses a separate worker subagent.
---

# Phase Implementation Loop

Run one approved phase at a time. The invoking agent is the orchestrator and does
not implement code. A green phase waits for user approval before its focused
commit; approval may also authorize immediate continuation to the next phase.

```text
canonical plan -> delegated implementation -> diff/tests -> verifier ->
phase report -> approval -> commit -> continue when approved
```

## Shared Protocol

This skill is distributed with `phase-implementation-autopilot`. Before planning,
read `references/shared-protocol.md`. Before the first delegated call, read
`references/delegated-jobs.md`. Load `references/agent-prompts.md` plus only the
selected agent references:

- `references/agent-codex.md`
- `references/agent-cursor.md`
- `references/agent-claude.md`

Those files are authoritative for plan synchronization, role separation,
deterministic routing, Codex worker selection, terminal handling, verification,
fallbacks, and prompt contracts. This file defines only gated-mode behavior.

## Startup Gate

Before Phase 1:

1. Read repository/workspace instructions and inspect working directory, git
   status, branch, and relevant process identity.
2. Reconcile all plan sources into the canonical markdown plan under
   `shared-protocol.md`. Prepare Linear mutations first and ask for explicit
   authorization before applying them. Start only after a re-read proves complete
   synchronization.
3. Use the user's execution profile or recommend one compactly. The recommendation
   names the orchestrator, implementation route/fallback, verifier chain, models,
   reasoning/effort, and continuation behavior. Obtain confirmation for material
   work when the profile was not already approved.
4. Name a durable-state location for multi-phase work. The canonical plan may
   carry phase status when it can record every field required by the shared
   protocol; otherwise use a repo-appropriate adjacent markdown artifact.
5. If the orchestration surface supports persistent goals, set one process goal
   after the plan and profile are fixed. For Cursor use `/mål` or `/goal`; include
   the same goal in ordinary prompts because slash-command state may not persist.
6. Establish one dedicated branch for the whole plan. Follow repository naming;
   otherwise use `agent/<plan-slug>`. If unrelated changes make branch or path
   ownership uncertain, stop for guidance. In a non-git directory, disclose that
   commits are unavailable and skip git-only gates.

Compact profile shape:

```text
Recommended execution profile
- Orchestrator: [agent]
- Implementation: [agent/model/reasoning and fallback]
- Verification: Claude Opus -> Cursor GLM 5.2 -> fresh Codex verifier
- Continuation: after approval, commit Phase N and immediately start Phase N+1

Approve this profile?
```

## Gated Phase Loop

For each phase:

1. Run the Common Phase State Machine in `references/shared-protocol.md` through
   its GREEN or stop decision. Refresh a supported phase goal with objective,
   acceptance criteria, out-of-scope items, and stop conditions.
2. Confirm every delegated handle is terminal and durable state is sufficient
   for another agent to reconstruct the phase.
3. If not GREEN, do not commit. Preserve the workspace and report the failed gate,
   evidence, attempted repairs, and one focused decision request.
4. If GREEN, produce the phase report below and request one explicit approval:
   `Approve committing Phase N and proceeding to Phase N+1?`
5. Interpret approval literally. Approval for both actions means commit and
   continue. Approval for commit only means commit and stop. No approval means no
   commit.
6. Before committing, recheck `git status --short`, stage only explicit
   phase-owned paths, inspect the staged diff, and create one focused phase commit.
   Never push unless separately authorized.
7. When continuation was approved, the commit succeeded or was validly skipped,
   another phase remains, and no stop gate applies, start the next phase
   immediately without asking for a second continuation prompt.

## Phase Report

Report only decision-relevant state:

- phase status: GREEN, BLOCKED, or NEEDS DECISION
- changed files and behavior
- branch and current commit
- tests and results
- verifier tier/model/verdict, including fallback or degraded confidence
- skipped/deferred work and remaining risks
- Linear update made or intentionally pending
- durable-state or handoff location
- the single approval request, or the exact stop question

Do not relay peer-agent transcripts or routine progress logs.

## Tracker And Handoff

With established tracker authority, update linked issues at phase boundaries with
branch, commit, verification, blockers, deferrals, and next step. Do not close or
change issue status/ownership unless that authority is explicit.

When context becomes noisy or the next phase depends on exact commands, ids,
counts, logs, or decisions, update durable state before recommending a fresh
task. A handoff points to that artifact and states completed phase, commit,
verification, verifier verdict, deferrals, blockers, and next phase.

## Completion

After the final approved phase commit, run plan-level verification when the
combined change warrants it, update durable state, and report all phase commits,
verification, fallbacks, deferrals, and remaining unperformed tracker, push,
deploy, or release actions.
