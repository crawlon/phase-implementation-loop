# Agent Routing Reference

Read this reference before the first delegated implementation, external
verification, or Codex verifier sub-agent call.

## Capability Check

Check only the tools needed by the selected route:

- macOS/Linux: `command -v <tool>`
- PowerShell: `Get-Command <tool>`
- Windows cmd: `where <tool>`

Relevant optional tools are `codex-cursor-impl`, `codex-cursor-ask`,
`codex-claude-ask`, `cursor-agent`, `claude`, and available Codex sub-agent
tools. Wrappers are transport only; put scope and safety constraints in prompts.

## Cursor Implementation

Use one selected model per phase:

- Composer 2.5: `codex-cursor-impl --model composer-2.5-fast "..."`
- Grok 4.5: `codex-cursor-impl --model cursor-grok-4.5-high "..."`

Prompt shape:

```text
Implement Phase [N]: [title].

Objective: [objective]
In scope: [items]
Out of scope: [items]
Acceptance checks: [checks]
Constraints: follow repository instructions; Ponytail/minimal-diff; do not
commit, push, deploy, access secrets or credentials, or perform destructive or
live-production actions.

Edit the workspace, then return only a concise report of changed files,
verification run, skipped work, risks, and blockers.
```

On an ambiguous implementation failure, inspect the workspace before retrying;
the agent may already have changed files. Do not automatically retry an
implementation wrapper.

## Claude And GLM Verification

Preferred verifier:

`codex-claude-ask --model opus --prompt-file <path>`

Use a prompt file for long Claude prompts. Let the orchestrator choose effort
from phase risk.

Fallback verifier:

`codex-cursor-ask --model glm-5.2-high "..."`

Use GLM only after documented Claude terminal failure, unavailability, or
`INCONCLUSIVE`. Do not use it to overrule a Claude `BLOCKED` finding.

Verifier prompt shape:

```text
Verify Phase [N]: [title]. Read-only review; do not edit files.

Objective and acceptance criteria: [items]
Actual diff/base: [base and paths]
Tests and results: [evidence]
Repository constraints: [constraints]

Return no prose before:
VERDICT: PASS | BLOCKED | INCONCLUSIVE
FINDINGS:
- none, or concrete issues with evidence
EVIDENCE:
- tests, diff paths, or inspection basis
```

## Codex Verifier Sub-Agent

Use only after Claude and GLM are terminally unavailable or inconclusive. Launch
a fresh Codex sub-agent through the active surface's supported sub-agent tool.
Prefer `gpt-5.6-terra` with high reasoning when the surface exposes it. Otherwise
select a comparable strong available Codex coding model with high reasoning or
effort; do not force a model id that the current environment does not expose.
Record the selected model and effort in durable state.

The sub-agent must be independent of implementation and read-only. Give it the
phase objective, frozen acceptance criteria, base commit, actual repository path,
diff scope, test evidence, and repository constraints. Do not give it the
implementer's reasoning transcript or the orchestrator's desired verdict.

Start with a fresh context and disable unrelated user configuration, connectors,
or MCP startup when the active sub-agent surface supports an isolation option.
Record an unrelated connector startup failure separately from the code verdict;
do not call it repository verification failure when it is terminal, caused no
mutation, and did not prevent diff/test inspection. Stop if it requests operator
input, credentials, permission, or any action outside the verifier envelope.

Prompt shape:

```text
Act as the last-resort independent verifier for Phase [N]: [title].

Inspect the actual repository diff against [base]. You did not implement this
phase. Do not edit, stage, commit, push, deploy, access secrets, or perform
destructive or live actions.

Objective and frozen acceptance criteria: [items]
Expected scope: [paths/modules]
Tests and results: [evidence]
Repository constraints: [constraints]

Check correctness, regressions, scope compliance, security/auth/data risks, and
test sufficiency. Return no prose before:
VERDICT: PASS | BLOCKED | INCONCLUSIVE
FINDINGS:
- none, or concrete issues with evidence
EVIDENCE:
- tests, diff paths, or inspection basis
```

The orchestrator must verify concrete claims against files and test output. A
Codex sub-agent PASS is degraded independent confidence, not equivalent to
successful external verification. Never replace the sub-agent with an
orchestrator self-review while claiming independence.

## Terminal Handling

Drive every running handle to terminal completion using wait windows of up to
about one minute. Do not duplicate in-flight requests. Preserve terminal exit,
stdout, stderr, byte counts, model, request/session id, and wrapper/tool name
before invoking a fallback. Non-empty unstructured review text is evidence, not
a bridge failure.
