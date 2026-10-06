# Cursor Agent Reference

Use this reference when Cursor is selected for planning, implementation, review,
verification, exploration, or orchestration.

## Transport And Models

Preferred thin wrappers:

- Planning: `codex-cursor-plan`
- Ask/review/verification: `codex-cursor-ask`
- Implementation: `codex-cursor-impl`

Pass the selected model per call with `--model`. Wrappers may also honor
`CODEX_CURSOR_MODEL`, but per-call selection wins. Current configured routes are:

- Grok 4.7: first implementation fallback after Codex Luna 6 Max; choose effort
  for the phase and its corresponding surfaced id, such as `grok-4.7-high`.
- `glm-5.3-high`: second verification fallback after Claude Opus 5.5 and Codex
  Astra High.

Treat model ids as configured defaults, not permanent inventory. Check
`cursor-agent models` when a configured id fails or the user changes available
models. On macOS, `SecItemCopyMatching failed -50` from a restricted run means
the Keychain is unavailable in that execution context. Re-run the same read-only
command with host access before diagnosing authentication; do not log out,
replace credentials, or switch credential stores unless the host-access run also
fails. The orchestrator chooses from the phase brief under `shared-protocol.md`;
do not ask Cursor to choose or run comparison prompts.

Examples:

```text
codex-cursor-impl --model grok-4.7-high "..."
codex-cursor-ask --model glm-5.3-high "..."
```

If wrappers are unavailable but `cursor-agent` exists, use non-interactive
`--print --output-format json` with the selected `--mode`, `--model`, and target
`--workspace`. Adapt quoting/current-directory syntax to the active shell.

### Local CLI access

On a local macOS host where Cursor has already failed with `EPERM` while creating
its local CLI configuration before a model request, host access is a known
precondition for every later Cursor wrapper call. Launch the selected
`codex-cursor-*` wrapper with host access on the first attempt; do not make a
doomed sandbox probe and call the second launch a retry. This grants the launcher
access to Cursor's local runtime state, not broader phase scope: preserve the
selected workspace, prompt prohibitions, and the separate `CODEX_CURSOR_IMPL_FORCE`
opt-in.

If host access is denied, record a platform-permission gate and stop or request
approval. Do not misreport the preflight failure as a Grok/model failure, fall
back to another model, or inspect a workspace diff that Cursor never touched.

Wrappers are transport only. Apply terminal and retry classification from
`delegated-jobs.md`. On ambiguous implementation failure, inspect the workspace
before retry or fallback because files may already have changed.

The wrapper exposes its lifecycle on stderr as `CODEX_CURSOR_EVENT`: `started`,
`activity`, `heartbeat`, `succeeded`, `failed`, `timed_out`, or `cancelled`.
`activity` and `heartbeat` are compact local summaries of Cursor's stream, never
thinking text, partial assistant text, prompts, tool arguments, or tool output.
It has no default maximum duration. Set a positive `CODEX_CURSOR_MAX_SECONDS`
only when the phase has a documented reason to impose a terminal deadline;
`timed_out` then exits `124` and is terminal evidence for fallback or recovery,
not a reason to guess that Cursor is still running. `CODEX_CURSOR_STATUS_FILE`
can record the same events in a caller-owned path when a lost terminal handle
must be recoverable.

### Non-interactive implementation tests

`--trust` does not bypass Cursor's command allowlist. When the approved phase
execution profile explicitly permits the selected workspace and its relevant
test/verification commands, invoke implementation with
`CODEX_CURSOR_IMPL_FORCE=1`. The wrapper then passes Cursor's `--force` only for
`codex-cursor-impl`; it never enables command force for planning or verification
calls. Keep the implementation prompt's existing prohibitions intact, name the
expected test commands in the phase brief, and treat Cursor's test result as
implementation evidence only: the orchestrator must independently rerun the
relevant checks before declaring the phase GREEN.

## Capabilities And Prompts

Use `agent-prompts.md` for the selected role. Cursor implementation must use an
edit-capable surface such as `codex-cursor-impl`; ask/plan output is guidance for
the selected implementation agent, not code for the orchestrator to apply.

Use GLM verification only after the Claude and Astra routes are terminally
unavailable or `INCONCLUSIVE`, or when the user explicitly selects it. Never use
GLM to overrule a `BLOCKED` finding from either tier. Check availability before
use; do not silently substitute an older GLM model.

## Cursor Goal State

When Cursor orchestrates and its surface supports persistent goals, use `/mål`
or `/goal` as reinforcement:

```text
/goal Execute the canonical phase plan using the active gated or autopilot mode.
Keep orchestration separate from implementation and stop at that mode's gates.
```

Refresh the goal at phase boundaries with objective, acceptance criteria,
out-of-scope items, and stop conditions. Always include the same information in
ordinary prompts because non-interactive Cursor calls may not retain slash-command
state.
