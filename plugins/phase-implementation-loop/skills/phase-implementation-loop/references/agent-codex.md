# Codex Agent Reference

Use this reference when the execution profile assigns Codex to planning,
implementation, review, verification, exploration, or fallback roles.

## Capabilities

- Planning: main Codex can plan directly; use a Codex subagent when available
  and independent exploration would save context.
- Implementation: main Codex can edit directly. A Codex worker/subagent may be
  used when available, but the main Codex agent still owns the diff.
- Verification: use a separate Codex reviewer/subagent when available and
  independence matters. If none is available, the main Codex agent performs an
  explicit second-pass review and reports degraded independence.

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

Review this implementation as an independent verifier.

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
