# Claude Agent Reference

Use this reference when the execution profile assigns Claude to planning,
implementation, review, verification, exploration, or fallback roles.

## Thin Wrapper

The global Claude wrapper should contain only CLI transport behavior: check that
`claude` exists, run non-interactively, keep the call read-only unless an
explicit edit-capable Claude tool exists, and pass through caller-provided
arguments. It should not inject phase-loop guardrails or prompt policy.

Use `codex-claude-ask --model opus` by default for Claude calls. This targets
Claude Opus 4.8 through the CLI model alias unless the user or environment
provides a more specific Opus 4.8 model id.

Pass short prompts as a final argument:
`codex-claude-ask --model opus "..."`.

For long prompts, write the prompt to a temporary text file and call:
`codex-claude-ask --model opus --prompt-file <path>`. Prefer this over shell
pipes or redirection from inside Codex, because piped commands may run in a
sandbox/auth context where Claude reports `Not logged in`.

If the wrapper is unavailable but `claude` exists, call Claude directly:
`claude --print --permission-mode plan --no-chrome --no-session-persistence --model opus "..."`.

The direct Claude command is the same on macOS, Linux, PowerShell, and
`cmd.exe` when `claude` is on `PATH`; adapt prompt quoting for the active shell.
For long direct-CLI prompts or fragile quoting, place the prompt in a temporary
text file and pass it using the supported Claude CLI input method for the
installed version.

Choose effort per phase instead of hardcoding one globally. Omit `--effort` when
default effort is enough; add `--effort high`, `xhigh`, or `max` for large
diffs, high-risk migrations, auth/security changes, data-loss risk, or subtle
architecture questions.

## Capabilities

With the current global wrapper, Claude runs in non-interactive ask/plan mode.
Use it for planning, review, verification, risk analysis, and implementation
guidance. Do not claim Claude edited files unless an explicitly approved
edit-capable Claude tool is available in the current environment and was used.

If Claude is selected for implementation but only `codex-claude-ask` is
available, use Claude as an implementation advisor and have Codex or another
edit-capable agent apply the changes after inspection. If an edit-capable Claude
tool is available and current repo/user policy permits using it, use the
Implementation Prompt Shape and keep the same Codex diff ownership gates.

## Planning Prompt Shape

Use this shape with `codex-claude-ask --model opus`:

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

Use this shape when Claude is selected for implementation. If Claude cannot edit
directly, this is implementation guidance for Codex or another edit-capable
agent to apply:

```text
Implement or advise on phase [N]: [short title].

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
- If this tool has edit capability, make the implementation changes.
- If this tool is read-only, return concrete code-level guidance instead.
- Return a concise final report, not a step-by-step activity transcript.
- Report files changed or files likely to change.
- Report risks, skipped/deferred work, and verification commands.
```

## Verification Prompt Shape

Use this shape with `codex-claude-ask --model opus`:

```text
Verify phase [N]: [short title].

Review this implementation as an external verifier.

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
