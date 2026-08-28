# Cursor Bridge Wrappers

These optional macOS/zsh wrappers provide a reliable non-interactive bridge from
Codex to Cursor Agent:

- `codex-cursor-ask`: read-only questions, review, verification, and exploration.
- `codex-cursor-plan`: read-only planning.
- `codex-cursor-impl`: implementation with Cursor's normal editing tools.

All three wrappers request Cursor's JSON result format, require a successful
terminal result with non-empty text, and report Cursor session/request IDs on
structured failures.

Terminal failures also report the selected model, exit status, and stdout/stderr
byte counts. Preserve that evidence before classifying a failure or switching
verifiers. A successful non-empty Cursor result that misses a verifier's expected
format is unstructured review evidence, not a bridge-capture failure.

The wrappers print an immediate start notice and a liveness message every 15
seconds while Cursor is still running. Every lifecycle transition also emits one
machine-readable `CODEX_CURSOR_EVENT` line on stderr: `started`, `activity`,
`heartbeat`, `succeeded`, `failed`, `timed_out`, or `cancelled`. The wrapper
uses Cursor's `stream-json` output locally, but never relays thinking text,
partial assistant text, prompts, tool arguments, or tool output. Each heartbeat
is a compact activity summary (event count, last event type/subtype, and idle
time), so long calls remain observable without materially growing observer
context. Set
`CODEX_CURSOR_HEARTBEAT_SECONDS` to a different positive integer to change the
heartbeat interval. Set `CODEX_CURSOR_STATUS_FILE` to additionally append those
events to a caller-owned file for recovery after a lost terminal handle.

Calls have no default deadline: a healthy long-running Cursor call continues
until it reaches a terminal result. Set `CODEX_CURSOR_MAX_SECONDS` to a positive
integer only when a caller intentionally needs a supervised deadline. That
deadline is terminal: the wrapper stops Cursor, emits `state=timed_out`, and
exits with status `124`. On interruption, the wrapper stops its child process
and emits `state=cancelled` before it exits.

Cursor calls can outlive an individual Codex tool yield. A tool result that says
the script is still running, or includes a cell/session ID without a terminal
exit, is not an empty Cursor response. Continue polling that same cell/session
until it exits or the wrapper emits a terminal event. Do not launch a duplicate
request merely because the first poll has no model text yet.

`ask` and `plan` retry once after an empty/invalid terminal result or an explicit
transient provider/network error. Authentication, permission, and model errors
are not retried.

On macOS, `SecItemCopyMatching failed -50` means the current process cannot read
the login from Keychain. Re-run the same wrapper or `cursor-agent models` with
host access before changing authentication. Do not log out, replace credentials,
or switch to file-backed credentials unless the host-access run also fails.

`impl` never retries automatically. A failed or empty implementation response
may follow completed file edits, so the wrapper tells the orchestrator to
inspect the workspace diff before deciding whether to resume or retry.

## Implementation command approval

`--trust` lets Cursor use the selected workspace, but it does not permit
terminal commands that Cursor's allowlist would otherwise block. For an approved
implementation phase that needs non-interactive test execution, opt in with:

```sh
CODEX_CURSOR_IMPL_FORCE=1 codex-cursor-impl --model composer-2.5-fast "..."
```

This adds Cursor Agent's `--force` flag only to `codex-cursor-impl`; ask and plan
calls remain read-only and never receive it. The setting is disabled by default
and accepts only `0` or `1`. Enable it only when the phase execution profile
explicitly authorizes the workspace and relevant command/test scope. It does not
replace the orchestrator's independent verification run or the phase's existing
prohibitions on secrets, credentials, destructive actions, and live actions.

## Requirements

- `cursor-agent`
- `jq`
- zsh

## Install

Copy the four executable files in `bin/` to the same directory on `PATH`.
For this Mac:

```sh
rsync -az scripts/cursor-bridge/bin/ ~/.local/bin/
```

## Verify

Run the fake-CLI regression suite:

```sh
scripts/cursor-bridge/tests/run.zsh
```

Then run a harmless live read-only probe:

```sh
codex-cursor-ask --model cursor-grok-4.6-high-fast \
  "Reply with exactly CURSOR_BRIDGE_OK. Do not use tools."
```

Implementation calls are write-capable and should only run with explicit access
to the intended workspace.
