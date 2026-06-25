# Cursor Agent Reference

Use this reference when the execution profile assigns Cursor to planning,
implementation, review, verification, exploration, or fallback roles.

## Thin Wrappers

The global Cursor wrappers should contain only CLI transport behavior: check
that `cursor-agent` exists, set non-interactive mode, use the current workspace,
read prompt args/stdin where applicable, and pass through `CODEX_CURSOR_MODEL`
when set. They should not inject phase-loop guardrails or prompt policy.

- Planning: `codex-cursor-plan`
- Ask/review/verification/exploration: `codex-cursor-ask`
- Implementation/editing: `codex-cursor-impl`

Use `composer-2.5-fast` as the default Cursor model for this skill unless the
user asks otherwise. Because the wrappers are thin, set it at call time:
`CODEX_CURSOR_MODEL=composer-2.5-fast codex-cursor-plan "..."`.

If the wrappers are unavailable but `cursor-agent` exists, call Cursor directly:

- Planning: `cursor-agent --print --mode plan --model composer-2.5-fast --trust --workspace "$PWD" "..."`
- Ask/review/verification: `cursor-agent --print --mode ask --model composer-2.5-fast --trust --workspace "$PWD" "..."`
- Implementation/editing: `cursor-agent --print --model composer-2.5-fast --trust --workspace "$PWD" "..."`

Omit or change `--model` when the execution profile requests a different Cursor
model.

## Shared Rules

Treat Cursor output as advisory until Codex inspects the actual files and diff.
Do not ask Cursor to commit, push, deploy, expose secrets, change credentials, or
run destructive commands. Put all role constraints in the prompt; do not assume
the wrapper adds them.

## Planning Prompt Shape

Use this shape with `codex-cursor-plan`:

```text
Plan phase [N]: [short title].

Inputs:
- Phase objective: [objective]
- In scope: [bullets]
- Out of scope: [bullets]
- Known repo constraints: [constraints]
- Likely files/modules: [paths/modules if known]

Return:
- Minimal implementation approach.
- Risks and unclear requirements.
- Suggested verification.
- Stop conditions.
```

## Implementation Prompt Shape

Use this shape with `codex-cursor-impl`:

```text
Implement phase [N]: [short title].

Context:
- Repo/task: [context]
- Current phase objective: [objective]
- In scope: [bullets]
- Out of scope: [bullets]
- Constraints: follow active repo instructions; no commits, pushes, deploys,
  secrets, credential changes, or destructive commands. Ask questions only when
  requirements are unclear or the answer changes scope/product behavior.
- Style: Ponytail/minimal-diff by default: smallest working diff, existing
  project patterns, no speculative abstractions, no unrelated cleanup. Preserve
  required auth, validation, security, accessibility, and verification.

Expected output:
- Make the implementation changes in the workspace.
- Return a concise final report, not a step-by-step activity transcript.
- Report files changed and why.
- Report anything skipped or deferred.
- Report verification commands run or recommended.
```

## Verification Prompt Shape

Use this shape with `codex-cursor-ask` when Cursor is selected as verifier:

```text
Verify phase [N]: [short title].

Review this implementation as an external verifier. Do not edit files.

Inputs:
- Phase objective: [objective]
- Diff summary: [summary]
- Test commands and results: [commands/results]
- Known constraints: [repo rules/security/auth/i18n/etc.]

Please check:
1. Does the diff satisfy the phase objective?
2. Any correctness, security, auth, data-loss, migration, UX, or regression risks?
3. Are tests/verifications sufficient for this phase?
4. Any blockers before the phase can be marked green?

Return: PASS if no blockers, otherwise BLOCKED with concrete fixes.
```
