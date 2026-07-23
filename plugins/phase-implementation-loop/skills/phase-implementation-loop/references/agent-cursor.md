# Cursor Agent Reference

Use this reference when the execution profile assigns Cursor to planning,
implementation, review, verification, exploration, or fallback roles.

## Thin Wrappers

The global Cursor wrappers should contain only CLI transport behavior: check
that `cursor-agent` exists, set non-interactive mode, use the current workspace,
read prompt args/stdin where applicable, pass through model selection, and
validate Cursor's structured terminal result. They should not inject phase-loop
guardrails or prompt policy.

- Planning: `codex-cursor-plan`
- Ask/review/verification/exploration: `codex-cursor-ask`
- Implementation/editing: `codex-cursor-impl`

Use `composer-2.5-fast` as the default Cursor model for this skill unless the
user asks otherwise. Prefer setting the model per call with `--model`:

- Planning: `codex-cursor-plan --model composer-2.5-fast "..."`
- Ask/review/verification/exploration: `codex-cursor-ask --model composer-2.5-fast "..."`
- Implementation/editing: `codex-cursor-impl --model composer-2.5-fast "..."`

The wrappers also honor `CODEX_CURSOR_MODEL` for a session-wide default. Set it
using syntax for the active shell:

- macOS/Linux/POSIX shells: `CODEX_CURSOR_MODEL=composer-2.5-fast codex-cursor-plan "..."`
- Windows PowerShell: `$env:CODEX_CURSOR_MODEL = "composer-2.5-fast"; codex-cursor-plan "..."`
- Windows `cmd.exe`: `set CODEX_CURSOR_MODEL=composer-2.5-fast && codex-cursor-plan "..."`

If both are present, the per-call `--model` value overrides
`CODEX_CURSOR_MODEL`.

Known Cursor model ids verified with `cursor-agent models` on 2026-07-23:

- `composer-2.5-fast`: Composer 2.5 Fast default.
- `cursor-grok-4.5-high`: Cursor Grok 4.5 High.
- `cursor-grok-4.5-high-fast`: Cursor Grok 4.5 High Fast.
- `glm-5.2-high`: GLM 5.2.
- `glm-5.2-max`: GLM 5.2 Max.

The hardened wrappers use `--output-format json` and require a successful,
non-empty terminal result. `codex-cursor-ask` and `codex-cursor-plan` retry once
after an empty/invalid result or a clearly transient provider/network error.
They do not retry authentication, permission, or invalid-model failures.

The wrappers emit an immediate start notice and periodic liveness messages while
Cursor is still running. If the execution tool yields a running cell/session ID,
poll that exact cell/session until a terminal exit is returned. A yielded call
with no model text is still in progress, not an empty Cursor result. Do not
start a duplicate Cursor request while the original process remains active.

`codex-cursor-impl` never retries automatically. A disconnected implementation
may already have edited files. On any ambiguous failure, inspect `git status
--short` and the diff before deciding whether to resume the Cursor session,
retry, or switch to a fallback agent.

Structured failures report Cursor session/request IDs when available. Preserve
those IDs in phase evidence when provider instability affects execution.

If the wrappers are unavailable but `cursor-agent` exists, call Cursor directly:

- Planning: `cursor-agent --print --output-format json --mode plan --model composer-2.5-fast --trust --workspace <current-working-directory> "..."`
- Ask/review/verification: `cursor-agent --print --output-format json --mode ask --model composer-2.5-fast --trust --workspace <current-working-directory> "..."`
- Implementation/editing: `cursor-agent --print --output-format json --model composer-2.5-fast --trust --workspace <current-working-directory> "..."`

Use the shell's current-directory expression when replacing
`<current-working-directory>`:

- macOS/Linux/POSIX shells: `$(pwd)`
- Windows PowerShell: `(Get-Location).Path`
- Windows `cmd.exe`: `%CD%`

If already running in the target repository and the wrapper or CLI uses the
current directory by default, omit `--workspace`. Omit or change `--model` when
the execution profile requests a different Cursor model.

## Cursor Goal State

When Cursor is the active orchestrator or is running the phase loop directly,
use Cursor's goal-state command as reinforcement when the environment supports
it:

- Swedish UI/command mode: `/mål`
- English UI/command mode: `/goal`

Set a process goal once after the canonical markdown plan and execution profile
are known. Keep it concise:

```text
/goal Execute the canonical phase plan phase by phase. Keep one branch for the
whole plan, respect approval gates, use the selected implementation and
verification agents, inspect diffs and verification before reporting green, and
continue to the next phase after an approved commit unless stopped.
```

Refresh the goal at each phase boundary:

```text
/goal Complete Phase [N] only: [objective]. Acceptance criteria: [criteria].
Out of scope: [items]. Stop if [stop conditions].
```

Do not rely on `/mål` or `/goal` as the only source of truth. Non-interactive
Cursor Agent calls may ignore slash commands or run without persistent goal
state. Always include the process goal or phase goal directly in the ordinary
Cursor prompt as well.

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

Return a concise final verdict, not a step-by-step reasoning transcript. Use
PASS if no blockers, otherwise BLOCKED with concrete fixes and only the evidence
needed to act.
```

Cursor verification may take several minutes on large diffs, slow models, or
long context. Wait for the command to finish rather than retrying immediately.
Retry only after a clear transient provider/network failure or a genuinely long
timeout for the phase size. Resolve authentication, permission, and model
configuration failures before issuing another request.

If Cursor reports a provider degradation, switch to the execution profile's
documented fallback instead of repeatedly retrying the same model. For an
implementation failure, inspect the actual workspace first so fallback work
does not duplicate edits from an uncertain Cursor run.
