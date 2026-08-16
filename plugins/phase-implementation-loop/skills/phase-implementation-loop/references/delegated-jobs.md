# Delegated Jobs And Verification

This is the authoritative lifecycle, supervision, and verifier contract for both
phase execution modes.

## Terminal Lifecycle

Treat every delegated implementation, exploration, or verification call as:

```text
launched -> in flight -> terminal success | terminal failure
```

A running cell, process, session, or tool handle is `in flight` even when it has
no model text. Resume that exact handle with the active wait/poll mechanism in
windows of up to about one minute until terminal exit. Do not duplicate the
request, begin the next role, report an empty response, ask for approval, commit,
advance, or end the task while the original job is active.

Only a terminal result or explicit terminal error settles a job. Record role,
agent/model, handle, start time, and expected artifact when durable recovery may
be needed.

When `functions.exec` wraps a terminal tool, explicitly emit the completed nested
result after driving any session to completion:

```javascript
text(JSON.stringify({
  exit_code: result.exit_code,
  output: result.output ?? "",
  session_id: result.session_id ?? null,
}));
```

Zero-byte outer output without exit code or stderr is an indeterminate forwarding
state, not provider failure. Repair or bypass forwarding before invoking a
fallback.

## Supervision Budget

Supervise at checkpoints: implementation returned, diff inspected, tests
finished, verifier returned, and phase gate reached. Poll only to drive the same
handle to terminal completion or respond to a concrete error, auth/permission
prompt, or hang signal. Do not narrate or relay routine agent activity.

External verification can take several minutes for large diffs, high effort, or
provider latency. Keep user updates short and about phase state. A one-minute
wait window limits status churn; it is not a timeout or permission to abandon the
job.

## Verifier Contract

Every verifier prompt requests this terminal response with no prose before it:

```text
VERDICT: PASS | BLOCKED | INCONCLUSIVE
FINDINGS:
- none, or concrete issues with evidence
EVIDENCE:
- tests, diff paths, or inspection basis
```

Classify terminal results as follows:

- Matching contract: structured and usable.
- Non-empty review without the contract: unstructured evidence, not bridge
  failure. Extract findings and make a disclosed orchestrator verdict with
  reduced formatting confidence.
- Non-zero exit or whitespace-only terminal output: transport/provider failure.
  Before fallback, record agent/model, wrapper/tool, handle, exit code, stdout
  byte count, and concise stderr/error evidence.
- `INCONCLUSIVE`: usable but cannot make the phase green. Resolve its stated gap
  or continue down the fallback chain.
- `BLOCKED`: return the finding to an implementation agent, then re-run the same
  verifier tier after the fix. Never shop for another verifier to overrule it.

## Verification Chain

Use one verifier at a time:

1. Claude Opus 5.0 via `codex-claude-ask --model opus`; choose effort from phase
   risk and verify the alias when provider mapping is uncertain.
2. Cursor GLM 5.2 via `codex-cursor-ask --model glm-5.2-high` only when Claude is
   terminally unavailable or `INCONCLUSIVE`, unless the user explicitly approved
   GLM as the starting verifier.
3. A fresh read-only Codex verifier subagent, preferably `gpt-5.6-terra` with
   high reasoning when available or a comparable strong Codex model. It must not
   have implemented the phase.

Use a fallback only after documented terminal failure, unavailability, or
`INCONCLUSIVE`. An orchestrator self-review may add evidence but is never
independent and cannot by itself satisfy the GREEN verifier gate. If no fresh
verifier subagent exists, stop or obtain an explicit verification waiver under
the active mode.

A last-resort Codex verifier `PASS` may green ordinary work when the report marks
`degraded-independent-verification`. It cannot by itself green auth/security,
credentials, destructive operations, live migrations, irreversible or
production-data changes, or similarly high-impact work after both external
tiers fail.
