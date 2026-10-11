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
be needed. For Cursor and Claude wrappers, `CODEX_CURSOR_EVENT` or
`CODEX_CLAUDE_EVENT` with `state=succeeded|failed|timed_out|cancelled` is
explicit terminal evidence; `started`, `activity`, and `heartbeat` are not. An
opt-in timeout exits `124`, and cancellation terminates the child process rather
than leaving it orphaned.

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

### Local CLI preflight failures

An `EPERM` from Cursor while it creates local CLI configuration before any model
request or workspace edit is a launcher-environment failure, not a provider
failure or a normal implementation retry. Once this has been observed on a local
macOS host, launch later Cursor wrapper calls with host access from the start.
If that access is denied, record a platform-permission gate and stop for
approval; do not spend a sandbox attempt on every phase or switch model/provider
as though the model failed.

## Supervision Budget

Supervise at checkpoints: implementation returned, diff inspected, tests
finished, verifier returned, and phase gate reached. Poll only to drive the same
handle to terminal completion or respond to a concrete error, auth/permission
prompt, or hang signal. Do not narrate or relay routine agent activity.

External verification can take several minutes for large diffs, high effort, or
provider latency. Keep user updates short and about phase state. A one-minute
wait window limits status churn; it is not a timeout or permission to abandon the
job. Cursor wrappers have no default upper bound; `CODEX_CURSOR_MAX_SECONDS` is
an opt-in terminal timeout, not the poll window. Set
`CODEX_CURSOR_STATUS_FILE` when the caller needs a durable event trail across a
terminal/bridge recovery.

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
- `BLOCKED`: acceptance, correctness, or safety remains blocked. Repair under
  Finding And Repair Scope below, then re-run the same verifier tier over the
  affected boundary. Never shop for another verifier to overrule it.

## Finding And Repair Scope

Classify each finding by its consequence, with evidence:

- **Blocker:** an unmet acceptance criterion or correctness/security defect.
  Delegate repair, run affected checks and UI review where applicable, then
  repeat affected independent verification with the same tier.
- **Nonblocking improvement:** acceptance and safety remain satisfied. Schedule
  the follow-up without making it a new prerequisite or narrowing the full goal.
- **Factual/wording correction:** factual status, receipt-link, commit-id, or
  handoff transcription only. The orchestrator may correct and inspect it
  without another implementation or independent-review cycle.

Permissions, acceptance, dependencies, evidence meaning, product behavior, and
operational instructions are substantive even in Markdown. Missing assurance
needed for acceptance is not a wording issue. Do not dismiss a substantive
`BLOCKED` finding or upgrade an evidence claim through reclassification.
Pure factual corrections alone do not require `BLOCKED`; if wording was the only
reported obstacle, record its classification, correction, and inspection basis.
An existing substantive-phase verifier result remains required and is reusable
only while its recorded scope and conditions remain valid.

Follow Delivery And Evidence Discipline in `shared-protocol.md` to select
affected verification. Do not repeat whole audits for unrelated documentation
changes or handoffs. Repairs inside an approved envelope proceed within its
bounds; new authority, material risk/scope changes, or unexpected partial writes
require preservation and the appropriate stop/decision.

## Verification Chain

Use one verifier at a time:

1. Claude Opus 5.5 via `codex-claude-ask --model claude-opus-5-5`; choose effort
   from phase risk.
2. A fresh read-only Codex verifier subagent using `gpt-6-astra` at high
   reasoning, only when Claude is terminally unavailable or `INCONCLUSIVE`.
   It must not have implemented the phase.
3. Cursor GLM 5.3 High via `codex-cursor-ask --model glm-5.3-high`, only when
   the Astra route is terminally unavailable or `INCONCLUSIVE`.

An explicitly approved verifier profile may select a different starting tier.
Check the configured model id on its active surface before use. If GLM 5.3 High
is unavailable, record it and stop when the chain is exhausted; do not silently
substitute GLM 5.2 or another verifier.

Use a fallback only after documented terminal failure, unavailability, or
`INCONCLUSIVE`. For substantive work, orchestrator self-review may add evidence
but is never independent and cannot by itself satisfy the GREEN verifier gate.
If no fresh independent verifier route remains, stop or obtain an explicit
verification waiver under the active mode. Factual bookkeeping alone follows
Finding And Repair Scope rather than launching this chain.

A Codex fallback verifier `PASS` may green ordinary work when the report marks
`degraded-independent-verification`. It cannot by itself green auth/security,
credentials, destructive operations, live migrations, irreversible or
production-data changes, or similarly high-impact work. If only Codex can
provide a `PASS` for such work, stop for operator guidance; do not bypass the
critical-work gate or run another verifier merely to overrule a finding.
