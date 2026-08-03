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
