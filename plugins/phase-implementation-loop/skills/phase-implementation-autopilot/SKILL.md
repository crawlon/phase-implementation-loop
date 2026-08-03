---
name: phase-implementation-autopilot
description: Execute an approved multi-phase implementation plan autonomously across phases, with adaptive Codex, Cursor Composer 2.5, or Cursor Grok 4.5 implementation; automatic local commits for green phases; Claude Opus, Cursor GLM 5.2, and Codex sub-agent verification fallbacks; durable state; and strict operator stop gates. Use when the user explicitly asks for autopilot, unattended, continuous, or no-per-phase-approval execution from a markdown plan, Linear issues, a Linear parent issue with sub-issues, or mixed plan sources. Do not use for ordinary phase-gated work that should pause for approval before each commit.
---

# Phase Implementation Autopilot

Run an approved canonical plan continuously on one dedicated branch. Commit each
green phase and start the next phase without asking for routine approval. Stop
when the execution leaves the approved envelope, verification confidence is
insufficient, or operator judgment is required.

The invariant is:

```text
Continue only while the current phase is GREEN and remains inside the frozen
execution envelope. Otherwise preserve state and stop for operator guidance.
```

## Startup Authorization

Before Phase 1, present one compact autopilot envelope and obtain one explicit
approval unless the user's invocation already states the same authority. Record:

- repository and worktree
- canonical markdown plan and linked issue range
- dedicated branch for the whole plan
- implementation routes and verification chain
- permission to edit, test, stage exact phase-owned paths, create focused local
  commits, and continue across all approved phases
- durable state artifact
- actions that remain prohibited
- stop conditions

Prefer a separate worktree for unattended or parallel work. Require a clean
starting state or a precisely understood set of pre-existing changes. Do not
absorb unrelated changes into the autopilot envelope.

Standing authorization never includes push, deploy, release, production or live
database access, destructive operations, secret or credential handling, risky
branch changes, closing issues, or changing the approved scope unless the user
explicitly adds that authority. Platform approval prompts and repository policy
still apply.

## Canonical Plan And Frozen Envelope

Accept markdown plans, chat plans, Linear issue lists, a Linear parent with
sub-issues, or mixed sources. Before execution, reconcile them into one canonical
markdown plan containing ordered phases, source ids, objectives, acceptance
criteria, dependencies, verification, blockers, deferrals, and out-of-scope
items.

If markdown and Linear both exist, require complete synchronization before
autopilot starts. Creating or materially updating Linear issues is external
state: do it only when included in startup authorization. Otherwise stop with a
prepared mapping when tracker changes are required.

Freeze the phase order, objectives, acceptance criteria, dependencies, and
out-of-scope boundaries at startup. Status notes and evidence may evolve;
material scope or product changes require operator approval. Use explicit user
instructions over tracker text, and the most specific phase source over broader
planning text, but never silently resolve a conflict that changes behavior or
risk.

## Durable State

Name one repo-appropriate markdown state artifact in the startup envelope,
preferably adjacent to the canonical plan. Update it before each phase commit
and before any stop or context handoff. Record:

- frozen envelope and branch
- current and next phase
- implementation agent/model and routing rationale
- files changed
- verification commands and results
- verifier tier, model, verdict, and fallback reason
- prior phase commit hashes when available; the current phase commit is the
  commit containing its state update and need not self-reference its own hash
- blockers, deferrals, retries, and exact operator decision needed

Keep reports compact. At a successful phase boundary, emit a short checkpoint
without asking a question, then continue immediately.

## Adaptive Implementation Routing

Choose once per phase using the phase brief and repository facts already needed
for execution. Do not call a model to choose a model, run comparison prompts, or
try multiple implementers merely to compare them.

- Use Codex direct for a tiny, familiar, low-risk change, normally one or two
  files with clear acceptance checks and no material ambiguity, migration, auth,
  public-contract, concurrency, or cross-module impact.
- Use Cursor Composer 2.5 (`composer-2.5-fast`) for bounded routine work with
  clear acceptance criteria and established local patterns.
- Use Cursor Grok 4.5 (`cursor-grok-4.5-high`) for ambiguous bugs, broad or
  cross-package work, complex state or data flow, migrations or contracts,
  security-sensitive changes, or phases likely to need substantial exploration.

Keep the route unless scope, risk, or a terminal provider failure materially
changes. Include Ponytail/minimal-diff in delegated implementation prompts by
default. Read `references/agent-routing.md` before the first delegated agent or
Codex sub-agent call.

## External Job Lifecycle

Treat delegated work as `launched -> in flight -> terminal success/failure`.
A running cell, session, process, or handle is non-terminal even when it contains
no model text. Resume the exact handle in wait windows of up to about one minute
until terminal exit. Do not duplicate the request, start verification, commit,
advance, or stop merely because the first yield has no text.

Forward nested terminal metadata and output through the orchestration surface.
Zero-byte outer output without exit code or stderr is an indeterminate capture
state, not provider failure. Repair or bypass forwarding before using a fallback.

Supervise only at checkpoints: implementation returned, diff inspected, tests
finished, verifier returned, phase committed. Do not narrate routine peer-agent
activity or poll more frequently than needed to drive the same handle to a
terminal result.

## Verification Chain

Use one verifier at a time. A `BLOCKED` finding must be fixed or escalated; never
shop for a different verifier to overrule it. Use a fallback only after a
documented terminal transport/provider failure, unavailability, or
`INCONCLUSIVE` result.

1. Prefer Claude Opus via `codex-claude-ask --model opus`; choose effort from
   phase risk.
2. Use Cursor GLM 5.2 via `codex-cursor-ask --model glm-5.2-high` when Claude is
   terminally unavailable or inconclusive.
3. As the last resort, launch a fresh read-only Codex verifier sub-agent. Select
   `gpt-5.6-terra` with high reasoning when available, or a comparable strong
   Codex coding model with high reasoning or effort when model ids differ.
   Record the actual model and effort. The sub-agent must not have implemented
   the phase, must inspect the actual diff and test evidence, and must not edit,
   stage, commit, or push. The orchestrator's own self-review does not count as
   this tier.

Require every verifier to return:

```text
VERDICT: PASS | BLOCKED | INCONCLUSIVE
FINDINGS:
- none, or concrete issues with evidence
EVIDENCE:
- tests, diff paths, or inspection basis
```

Non-empty unstructured review text is evidence, not bridge failure. Extract its
findings and apply an orchestrator verdict with reduced formatting confidence.
Before classifying a terminal result as unusable, record model, wrapper/tool,
handle, exit code, stdout byte count, and concise stderr/error evidence.

A last-resort Codex sub-agent PASS may make an ordinary phase green with
`degraded-independent-verification` recorded. It may not autonomously green a
critical phase after both external tiers fail. Critical means auth or security
boundaries, irreversible or production data changes, destructive operations,
live migrations, credential handling, or similarly high-impact work. Stop for
operator guidance in those cases.

## Phase State Machine

For each phase:

1. Read the frozen plan and write a concise phase brief: objective, scope,
   likely files, constraints, acceptance checks, risks, and stop conditions.
2. Select and record the implementation route.
3. Implement directly or delegate a bounded edit-capable task. Drive every
   delegated job to terminal completion.
4. Inspect `git status --short` and the actual diff. Confirm every changed path
   belongs to the phase and no unrelated work was overwritten.
5. Run the smallest relevant verification first, then broaden according to risk
   and repository norms.
6. Run the verification chain. Fix concrete findings directly or redelegate a
   targeted follow-up, then re-run affected tests and verification.
7. After two materially similar red repair cycles without new evidence or a
   clear new fix, stop instead of looping.
8. Evaluate the green gate. If green, update durable state, stage only explicit
   phase-owned paths including that state update, inspect the staged diff, create
   one focused phase commit, emit a compact checkpoint with the resulting hash,
   and immediately begin the next phase.
9. If not green, do not commit partial work. Preserve the worktree, update
   durable state, and stop with the exact operator decision or missing evidence.

A phase is GREEN only when:

- acceptance criteria are met inside the frozen envelope
- the orchestrator inspected the actual diff
- relevant verification passed
- verifier confidence satisfies the phase risk
- no unrelated change is staged
- no delegated job remains in flight
- durable state is sufficient to reconstruct the result

Do not create partial or checkpoint commits and call them green. Never push
automatically.

## Mandatory Stop Gates

Stop and ask for operator guidance when:

- scope, phase order, dependencies, acceptance criteria, product behavior, or
  architecture must change materially
- unexpected auth, security, public-contract, migration, concurrency, data-loss,
  production, credential, or destructive risk appears
- important tests cannot run or remain red after two distinct repair attempts
- verifier findings conflict on a high-risk issue
- the fallback chain ends without sufficient confidence
- a critical phase reaches only the Codex sub-agent fallback
- pre-existing or concurrent changes make phase ownership uncertain
- branch/worktree identity or history diverges unexpectedly
- a permission, secret, credential, deploy, push, release, live-service, or
  destructive action is needed outside startup authorization
- the next phase requires an operator or product decision
- durable state cannot reconstruct the current result confidently

On stop, never reset, discard, revert, or clean uncertain work. Report the last
green commit, current uncommitted paths, failed gate, evidence, attempted
repairs, and one focused question.

## Completion

After the final phase, run plan-level verification appropriate to the combined
change, confirm branch and worktree state, update durable state, and produce one
final report containing phase commits, verification, fallbacks, deferrals,
remaining risks, and any unperformed push/deploy/tracker actions. Do not push or
deploy without separate explicit authorization.
