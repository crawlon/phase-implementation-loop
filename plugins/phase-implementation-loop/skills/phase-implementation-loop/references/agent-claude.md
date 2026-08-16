# Claude Agent Reference

Use this reference when Claude is selected for planning, implementation advice,
review, verification, exploration, or orchestration.

## Transport And Effort

Use the thin read-only wrapper:

```text
codex-claude-ask --model opus "..."
codex-claude-ask --model opus --prompt-file <path>
```

Prefer a prompt file for long calls. If the wrapper is unavailable but `claude`
exists, use non-interactive print/plan mode with session persistence and browser
integration disabled. Adapt quoting and prompt-file input to the installed CLI
and active shell.

```text
claude --print --permission-mode plan --no-chrome --no-session-persistence --model opus "..."
```

The `opus` alias should target Claude Opus 5.0 for this package; verify the current
CLI mapping when uncertain. Let the orchestrator choose effort from phase risk:
default for bounded work; high or maximum supported effort for large diffs,
subtle architecture, auth/security, migration, or data-loss risk. Do not hardcode
unsupported effort flags.

Apply terminal lifecycle, output classification, patience, and fallback rules
from `delegated-jobs.md`.

## Capabilities And Prompts

The current wrapper is read-only. Use it for planning, review, verification,
risk analysis, and implementation advice. Do not claim workspace edits unless an
explicitly available and authorized edit-capable Claude surface was used.

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
