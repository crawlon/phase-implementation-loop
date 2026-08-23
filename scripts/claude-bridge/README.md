# Claude Bridge Wrapper

`codex-claude-ask` is a read-only Claude CLI bridge for planning, review, and
verification. It requests Claude's `stream-json` transport locally and emits
only compact lifecycle events to stderr:

`CODEX_CLAUDE_EVENT state=started|activity|heartbeat|succeeded|failed|timed_out|cancelled`

The wrapper never relays partial assistant text, prompts, tool arguments, tool
output, or other stream payload content. `activity` reports only event count and
the last event type/subtype; `heartbeat` reports idle seconds since the last
observed stream activity. This makes long calls observable without materially
increasing observer context.

Calls have no default deadline. Set a positive `CODEX_CLAUDE_MAX_SECONDS` only
when a caller deliberately needs a terminal timeout; it exits `124`. Set
`CODEX_CLAUDE_HEARTBEAT_SECONDS` to change the default 15-second interval.
Set `CODEX_CLAUDE_STATUS_FILE` to append the same compact events to a
caller-owned file.

Run the regression suite with:

```sh
scripts/claude-bridge/tests/run.zsh
```
