# Codex Agent Reference

Use this reference when the execution profile assigns Codex to planning,
implementation, review, verification, exploration, or fallback roles.

## Capabilities

- Planning: main Codex can plan directly; use a Codex subagent when available
  and independent exploration would save context.
- Implementation: main Codex can edit directly. A Codex worker/subagent may be
  used when available, but the main Codex agent still owns the diff.
- Verification: use a fresh separate Codex reviewer/subagent as the last-resort
  verifier after Claude Opus and Cursor GLM 5.2 are terminally unavailable or
  inconclusive. Prefer `gpt-5.6-terra` with high reasoning when available, or a
  comparable strong Codex coding model with high reasoning or effort. If no
  subagent is available, the main Codex agent may perform an explicit second
  pass, but it is not independent and must be reported as degraded.

Codex is always the orchestrator, test runner, diff owner, approval gatekeeper,
and final reporter even when another agent contributes work.

## External Tool Continuation

Treat an execution handle as a live delegated job, not as agent output. Do not
end the task, report an empty response, or start verification while that job is
still running.

When the available Codex tools return `Script running with cell ID <id>`, call
the matching wait tool for that exact cell immediately with a wait window of up
to about 60 seconds. If it remains running, repeat the same wait on the same
cell. When a terminal command returns a session id, resume that exact session
with the terminal's wait/poll tool on the same pattern. Do not issue a second
implementation or verification command while the first handle remains active.

The one-minute window limits status churn; it does not mean sleeping for a minute
or leaving the task between polls. Only a terminal result or terminal error is
available for phase decisions.

## Nested Command Forwarding

When using `functions.exec` to call `tools.exec_command`, an awaited nested result
is not automatically emitted from the outer cell. Do not leave that call as the
last statement or the outer cell may complete with zero-byte output and hide the
terminal exit/error details. Drive any returned terminal session to completion,
then explicitly emit the result:

```javascript
let result = await tools.exec_command({ /* command options */ });
while (result.session_id) {
  result = await tools.write_stdin({
    session_id: result.session_id,
    chars: "",
    yield_time_ms: 60000,
  });
}
text(JSON.stringify({
  exit_code: result.exit_code,
  output: result.output ?? "",
  session_id: result.session_id ?? null,
}));
```

If `functions.exec` itself yields a running cell, resume that exact cell with its
wait tool until it emits this terminal payload. A zero-byte outer cell with no
exit code or stderr is an indeterminate forwarding defect, not a Claude or Cursor
bridge failure and not grounds for a verifier fallback.

## Planning Prompt Shape

Use this shape for a Codex subagent or internal planning pass:

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

Use this shape for a Codex worker/subagent. For main-Codex implementation, use
the same brief internally before editing:

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
- Make the implementation changes if this agent has edit capability.
- Return a concise final report, not a step-by-step activity transcript.
- Report files changed and why.
- Report anything skipped or deferred.
- Report verification commands run or recommended.
```

## Verification Prompt Shape

Use this shape for a Codex reviewer/subagent or for a main-agent second pass:

```text
Verify phase [N]: [short title].

Review this implementation as a read-only verifier. You did not implement this
phase. Do not edit, stage, commit, push, deploy, access secrets, or perform
destructive or live actions.

Inputs:
- Phase objective: [objective]
- Frozen acceptance criteria: [criteria]
- Repository path and base commit: [path/base]
- Actual diff scope: [paths/modules]
- Test commands and results: [commands/results]
- Known constraints: [repo rules/security/auth/i18n/etc.]

Please check:
1. Does the diff satisfy the phase objective?
2. Any correctness, security, auth, data-loss, migration, UX, or regression risks?
3. Are tests/verifications sufficient for this phase?
4. Any blockers before the phase can be marked green?

Return no prose before this exact contract:
VERDICT: PASS, BLOCKED, or INCONCLUSIVE
FINDINGS:
- none, or concrete issue(s) with evidence
EVIDENCE:
- tests, diff paths, or inspection basis
```

For a last-resort Codex verifier, start with fresh context and disable unrelated
user configuration, connectors, or MCP startup when the active surface supports
it. Do not provide the implementer's reasoning transcript or the orchestrator's
desired verdict. Record the actual model, reasoning effort, verifier session,
and any isolation option used.

The orchestrator must check concrete claims against the files and test output.
A Codex subagent `PASS` has degraded cross-provider independence. It cannot by
itself green critical auth/security, irreversible or production-data,
destructive, live-migration, or credential work after both external verifiers
fail. The main orchestrator's second pass must never be described as independent.
