# Cursor Bridge Wrappers

These optional macOS/zsh wrappers provide a reliable non-interactive bridge from
Codex to Cursor Agent:

- `codex-cursor-ask`: read-only questions, review, verification, and exploration.
- `codex-cursor-plan`: read-only planning.
- `codex-cursor-impl`: implementation with Cursor's normal editing tools.

All three wrappers request Cursor's JSON result format, require a successful
terminal result with non-empty text, and report Cursor session/request IDs on
structured failures.

The wrappers print an immediate start notice and a liveness message every 15
seconds while Cursor is still running. Set `CODEX_CURSOR_HEARTBEAT_SECONDS` to a
different positive integer to change that interval.

Cursor calls can outlive an individual Codex tool yield. A tool result that says
the script is still running, or includes a cell/session ID without a terminal
exit, is not an empty Cursor response. Continue polling that same cell/session
until it exits. Do not launch a duplicate request merely because the first poll
has no model text yet.

`ask` and `plan` retry once after an empty/invalid terminal result or an explicit
transient provider/network error. Authentication, permission, and model errors
are not retried.

`impl` never retries automatically. A failed or empty implementation response
may follow completed file edits, so the wrapper tells the orchestrator to
inspect the workspace diff before deciding whether to resume or retry.

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
codex-cursor-ask --model cursor-grok-4.5-high \
  "Reply with exactly CURSOR_BRIDGE_OK. Do not use tools."
```

Implementation calls are write-capable and should only run with explicit access
to the intended workspace.
