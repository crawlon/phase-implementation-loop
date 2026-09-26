# Claude Agent Reference

Use this reference when Claude is selected for planning, implementation advice,
review, verification, exploration, or orchestration.

## Transport And Effort

Use the thin read-only wrapper:

```text
codex-claude-ask --model opus "..."
codex-claude-ask --model opus --prompt-file <path>
codex-claude-ask --model claude-opus-5-5 --prompt-file <planning-prompt>
```

Prefer a prompt file for long calls. If the wrapper is unavailable but `claude`
exists, use non-interactive print/plan mode with session persistence and browser
integration disabled. Adapt quoting and prompt-file input to the installed CLI
and active shell.

```text
claude --print --permission-mode plan --no-chrome --no-session-persistence --model opus "..."
```

Use the fixed `claude-opus-5-5` model id for planning/replanning fallback. Do not
substitute the generic `opus` alias unless current CLI inspection proves it maps
to Opus 5.5. The verification chain continues to use its separately configured
Opus route. Let the orchestrator choose effort from phase risk: default for
bounded work; high or maximum supported effort for large diffs, subtle
architecture, auth/security, migration, or data-loss risk. Do not hardcode
unsupported effort flags.

Apply terminal lifecycle, output classification, patience, and fallback rules
from `delegated-jobs.md`.

The maintained wrapper source is `scripts/claude-bridge/bin/codex-claude-ask`.
It emits compact `CODEX_CLAUDE_EVENT` lifecycle records: `started`, `activity`,
`heartbeat`, `succeeded`, `failed`, `timed_out`, or `cancelled`. It uses the
Claude stream locally but never relays partial assistant text, prompts, tool
arguments, tool output, or other stream payload content. `activity` and
`heartbeat` report only event count/type/subtype and idle time. There is no
default deadline; `CODEX_CLAUDE_MAX_SECONDS` is opt-in, and
`CODEX_CLAUDE_STATUS_FILE` persists the compact records for recovery.

## Capabilities And Prompts

The current wrapper is read-only. Use it for planning, review, verification,
risk analysis, and implementation advice. Do not claim workspace edits unless an
explicitly available and authorized edit-capable Claude surface was used.

Claude Opus 5.5 is the planning/replanning fallback after terminal Astra
unavailability or failure. Give it the same bounded planning prompt and require
the same output contract; do not use both planners merely to compare answers.

When the user selects Claude implementation and an edit-capable Claude surface is
available, delegate the implementation prompt to that surface under the same
role separation and workspace gates. Otherwise Claude is an advisor only.

Use `agent-prompts.md` for the selected role. When Claude is implementation
advisor only, return concrete code-level guidance to the selected edit-capable
implementation agent. If that agent is Codex, it must be the separate worker
subagent defined in `agent-codex.md`, never the orchestrator.

Claude Opus 5.0 is the preferred external verifier. GLM follows only after documented
terminal failure, unavailability, or `INCONCLUSIVE`, or explicit user selection.
A Claude `BLOCKED` finding returns to implementation and must not be shopped to a
fallback verifier.
