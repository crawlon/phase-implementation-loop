# Shared Agent Prompt Contracts

Use these shapes with the selected agent's transport and model instructions.
Prompts are English by default; user-facing reports may use the user's language.

## Planning

```text
Plan Phase [N]: [title].

Objective: [objective]
In scope: [items]
Out of scope: [items]
Repository constraints: [constraints]
Likely files/modules: [paths]

Return only:
- minimal implementation approach
- risks or unclear requirements
- suggested verification
- stop conditions
```

## Implementation

```text
Implement Phase [N]: [title] as the selected implementation agent.

Objective: [objective]
In scope: [items]
Out of scope: [items]
Acceptance checks: [checks]
Repository constraints: [constraints]
Selected model/reasoning: [selection and rationale]

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
Repository constraints: [constraints]

Check correctness, regressions, scope compliance, security/auth/data risks, and
test sufficiency. Do not edit, stage, commit, push, deploy, access secrets, or
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
Selected model/reasoning: [selection and rationale]

Start the app from the current worktree, open the target route in the in-app
Browser, and prove it serves the current phase diff. Then follow
`$ui-ux-browser-review`. Do not edit, stage, commit, push, deploy, access
secrets or credentials, or perform destructive or live actions.

Return only:
- review target, worktree/diff proof, routes, states, and viewports covered
- outcome: ready, ready with follow-ups, or needs revision
- findings with severity, observed evidence, user impact, and smallest change
- limitations or untested scope
```
