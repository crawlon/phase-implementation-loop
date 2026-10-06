# Shared Agent Prompt Contracts

Use these shapes with the selected agent's transport and model instructions.
Prompts are English by default; user-facing reports may use the user's language.

Use these delegated prompts for substantive work. Factual bookkeeping, context
monitoring/handoff preparation, and the drift checkpoint remain direct
orchestrator work under `shared-protocol.md`. For a replacement primary
orchestrator, use the continuation prompt in `context-rollover.md`.

## Planning

```text
Plan Phase [N]: [title].

Planning task: [initial plan, detail expansion, or replan]
Objective: [objective]
Capability delivered/blocker removed: [approved capability or evidenced blocker]
Criterion/invariant served: [acceptance criterion or safety invariant]
In scope: [items]
Out of scope: [items]
Repository constraints: [constraints]
Likely files/modules: [paths]

Return only:
- minimal implementation approach
- implementer-critical detail gaps and the exact clarification needed
- risks or unclear requirements
- suggested verification
- stop conditions
```

Tie each proposed prerequisite to the criterion or invariant it prevents meeting,
with evidence; otherwise identify it as a scheduled nonblocking follow-up.

When the capability assessment requires more plan detail, ask the planner to
raise the phase to ADEQUATE or DETAILED without changing its goal. Require
explicit behavior, boundaries, acceptance checks, dependencies, invariants,
error states where relevant, likely seams, verification, and stop conditions.
The planner must identify unresolved product decisions rather than invent them.
The planner is read-only and returns advice to the orchestrator; it must not edit
the canonical plan, mutate Linear, or make user decisions.

## Implementation

```text
Implement Phase [N]: [title] as the selected implementation agent.

Objective: [objective]
In scope: [items]
Out of scope: [items]
Acceptance checks: [checks]
Capability delivered/blocker removed: [approved capability or evidenced blocker]
Criterion/invariant served: [acceptance criterion or safety invariant]
Repository constraints: [constraints]
Capability assessment: [TINY/ROUTINE/COMPLEX + THIN/ADEQUATE/DETAILED]
Selected model/reasoning: [selection and rationale]

Approved action envelope: [targets, actions, incidental effects, repair bounds,
and exclusions]

Follow repository instructions and Ponytail/minimal-diff: make the smallest
working change using existing patterns, with no speculative abstractions or
unrelated cleanup. Preserve required auth, validation, security, accessibility,
and verification. Do not commit, push, deploy, access secrets or credentials, or
perform destructive or live actions.

Edit the workspace, then return only:
- changed files and why
- verification run
- skipped or deferred work
- risks and blockers
```

## Verification

```text
Verify Phase [N]: [title] as a read-only verifier. You did not implement it.

Objective and acceptance criteria: [items]
Repository path and base commit: [path/base]
Actual diff scope: [paths/modules]
Tests and results: [evidence]
Accepted evidence: [scope, target, conditions, and relevant changes, if any]
Repository constraints: [constraints]

Check correctness, regressions, scope compliance, security/auth/data risks, and
test sufficiency. Reuse valid accepted evidence; verify affected boundaries.
Classify findings as blocker, nonblocking improvement, or factual/wording
correction under `delegated-jobs.md`. Substantive Markdown changes require
affected independent verification; missing required assurance cannot be treated
as a wording issue. Do not invent prerequisites without evidence of an unmet
criterion or safety invariant. Do not edit, stage, commit, push, deploy, access secrets, or
perform destructive or live actions. Return no prose before:

VERDICT: PASS | BLOCKED | INCONCLUSIVE
FINDINGS:
- none, or concrete issues with evidence
EVIDENCE:
- tests, diff paths, or inspection basis
```

## UI/UX Review

```text
Review Phase [N]: [title] as the dedicated non-editing Codex UI/UX review
subagent. You did not implement this phase.

Objective and acceptance criteria: [items]
Repository/worktree: [path]
UI target and phase diff: [route, paths, or flow]
Expected user sequence and relevant states: [items]
Accepted UI coverage and relevant changes: [evidence scope and conditions]
Selected model/reasoning: [selection and rationale]

Start or reuse an app proven to serve the current worktree and phase diff; open
the target in the in-app Browser. Reuse valid accepted coverage and review the
affected routes and states, preserving any still-required untested coverage. Follow
`$ui-ux-browser-review`. Do not edit, stage, commit, push, deploy, access
secrets or credentials, or perform destructive or live actions.

Return only:
- review target, worktree/diff proof, routes, states, and viewports covered
- outcome: ready, ready with follow-ups, or needs revision
- findings with severity, observed evidence, user impact, and smallest change
- limitations or untested scope
```
