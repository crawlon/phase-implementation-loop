---
name: phase-implementation-loop
description: Execute multi-phase implementation plans with Codex as orchestrator and selected Codex, Cursor, or Claude agents for implementation, review, and verification according to current tool capabilities. Use when the user asks to implement or execute a plan phase by phase from a markdown plan, Linear issues, a Linear parent issue with sub-issues, or a mixed plan source; reconcile plans and Linear issues into a canonical markdown phase plan before Phase 1; choose or confirm an execution profile for implementation and verification agents; run a relatively autonomous phase-gated build; set a goal for a multi-phase implementation; keep one branch across phases; or create durable phase handoffs before continuing.
---

# Phase Implementation Loop

Use this skill to run a relatively autonomous implementation loop inside any
repository. Codex remains the process owner: peer-agent output is advisory and
untrusted until Codex inspects the actual files, diff, and verification results.
Cursor, Claude, and Codex can each be assigned implementation, review, or
verification roles when the available tools support that role.

Autonomy applies within each phase. Do not commit, push, deploy, expose secrets,
change credentials, run destructive commands, or start the next phase without the
required user approval.

## Start-Up

1. Read the active repo and workspace instructions before planning work.
2. If the user explicitly says "set a goal" or asks for goal mode, create one
   goal for the whole plan.
3. Identify the working directory, whether it is a git repository, the current
   branch, and `git status --short` when available.
4. Reconcile the plan source into a canonical markdown phase plan with ordered
   phases small enough to verify independently. If the phase list is missing or
   materially ambiguous, draft it and ask for approval before Phase 1.
5. Establish the execution profile for implementation and verification. Ask the
   user to confirm when the plan is material and the profile was not already
   specified; recommend a profile yourself instead of asking open-endedly.
6. Establish one dedicated branch for the whole plan before Phase 1
   implementation when working in git. If already on a suitable branch, keep it.
   Otherwise create a `codex/` branch unless the user or repo conventions specify
   another prefix.
7. If branch setup is risky because of unrelated dirty worktree changes, ask the
   user how to proceed. If the directory is not a git repo, skip branch and commit
   steps and report that mode.

User-facing reports may be in the user's language. Prompts sent to peer agents
should be in English by default.

## Plan Sources

Accept plans from markdown files, chat, Linear issue lists, a single Linear issue
with sub-issues, or mixed sources. Do not create separate workflows for each
format. Before Phase 1, reconcile every source into one canonical markdown phase
plan. Execute from that markdown plan, with Linear issues preserved as linked
tracker references.

If the markdown plan is missing and Linear issues exist, create the markdown plan
from the issues/sub-issues. If the markdown plan exists but Linear issues are
missing and Linear-backed tracking is requested or clearly expected, create or
prepare the missing issues from the plan; ask before bulk creation when the
mapping or project/team is ambiguous. If both markdown and Linear issues exist,
verify they are 100% synchronized before implementation starts.

The canonical plan should include:

- phase number and title
- source reference such as file heading, Linear issue id, or sub-issue id
- objective and acceptance criteria
- dependencies or ordering constraints
- likely verification
- known blockers, deferrals, or out-of-scope items

Use the user's explicit order when given. Otherwise infer order from dependencies,
Linear project/order, parent issue sub-issue order, priority, or the markdown
structure, and say what ordering rule was used. Treat each Linear issue or
sub-issue as a phase by default, but split an oversized issue or group tiny
related issues when that makes verification cleaner. Preserve the source ids in
phase briefs, reports, durable state, and commit messages when useful.

100% synchronized means every planned phase has matching issue links when Linear
tracking is in use, every relevant issue/sub-issue appears in the markdown plan,
phase order and dependencies agree, objectives and acceptance criteria do not
conflict, and blockers/deferrals are represented in both places. Fix mismatches
before Phase 1, or document the gap and ask for approval if fixing it would
change scope or external project state.

If sources disagree, prefer explicit user instructions, then the most specific
source attached to the phase, then the broader plan. Ask only when the conflict
changes scope, product behavior, risk, or phase order. Do not mark Linear issues
done, close them, or change ownership/status unless the user explicitly asks or
the repo/team convention is clear.

## Execution Profile

Before Phase 1, choose or confirm how implementation and verification should be
done. If the user already specified agents, models, or effort, use that. Otherwise
make a recommendation and ask for a compact confirmation such as:

```text
Recommended execution profile:
- Planning: Codex by default; add Cursor or Claude for risky/unclear phases.
- Implementation: Cursor via codex-cursor-impl or Codex direct; use Claude as implementation advisor unless an edit-capable Claude tool is available and permitted.
- Verification: Claude Opus 4.8, Cursor, or Codex reviewer; use at least one independent verifier for material phases.
- Codex role: orchestrator, diff owner, test runner, and commit gatekeeper.
- Continuation: after you approve a green phase, commit it and continue directly to the next phase unless you say stop.

Approve this profile?
```

Profiles are role assignments, not fixed agent-role pairs. Any capable selected
agent may be used for implementation, review, or verification, but do not ask an
agent to edit unless the current tools explicitly support edit delegation for
that agent. If an agent can only plan or review, treat its output as guidance for
Codex or another edit-capable implementer.

Before recommending a profile, check current capabilities with lightweight
commands or tool discovery:

- `command -v codex-cursor-impl`
- `command -v codex-cursor-plan`
- `command -v codex-cursor-ask`
- `command -v codex-claude-ask`
- `command -v cursor-agent`
- `command -v claude`
- available Codex subagent tools

Global wrappers are thin transport commands; do not assume they inject
guardrails, models, or role prompts. Put those details in the prompt using the
selected agent reference. If a wrapper is missing but the underlying CLI exists,
use the direct command pattern from that agent reference.

Adjust the recommendation based on the repo and phase risk. For small or
low-risk phases, Codex may implement directly and use Cursor, Claude, or Codex
review. For large, unfamiliar, security-sensitive, data-loss, migration, or
cross-module work, prefer an edit-capable implementer plus one independent
verifier. If a selected agent is unavailable, use the fallback rules and report
the degraded profile.

Load agent-specific instructions only for agents selected in the profile or used
as fallbacks:

- Codex: `references/agent-codex.md`
- Cursor: `references/agent-cursor.md`
- Claude: `references/agent-claude.md`

## Supervision Budget

Keep orchestration supervision bounded. Codex must know whether delegated work is
progressing, what changed, and whether the result is safe, but should not
continuously narrate or relay a peer agent's routine step-by-step activity.

Default supervision pattern:

1. Send the selected agent a bounded prompt with required final output.
2. Let the agent work without live commentary unless a meaningful state change,
   question, error, timeout, or approval need appears.
3. Use sparse health checks for long-running work. Check for completion, hangs,
   repeated failures, or unexpected prompts; avoid summarizing ordinary logs.
4. After an implementation agent returns, read the final report, inspect
   `git status --short` and the actual diff, then run verification.
5. After a verification agent returns, read its verdict and blocker list. Do not
   relay its reasoning transcript unless a specific finding needs evidence.
6. In user-facing updates and phase reports, summarize decisions, changed files,
   verification, risks, and blockers. Do not paste or paraphrase a full peer
   agent transcript unless it contains a decision or blocker the user needs.

For long phases, prefer explicit checkpoint boundaries over constant monitoring:
planning complete, implementation returned, diff inspected, verification passed
or failed, verifier returned, phase report ready. If an active system/developer
instruction requires periodic user updates, keep those updates short and about
phase state, not detailed peer-agent narration.

## Phase Loop

For each phase:

1. Read the current phase from the canonical markdown plan, then write a concise
   phase brief before editing:
   - objective
   - in scope and out of scope
   - likely files or modules
   - active repo constraints
   - verification commands or acceptance checks
   - known risks and stop conditions
2. Run planning/exploration according to the execution profile when it would
   reduce risk or clarify the implementation path. Codex may plan directly, or
   ask selected agents for bounded plans using their reference prompts.
3. Delegate implementation according to the execution profile only when bounded
   delegation is useful. Use an edit-capable agent for workspace edits, or have
   a planning/review-only agent produce guidance that Codex applies after
   inspection. Include Ponytail/minimal-diff by default unless the user requested
   another style. Apply the Supervision Budget while delegated work runs.
4. After delegated implementation or Codex edits, run `git status --short` and
   inspect the actual diff yourself before trusting the result or running broad
   verification.
5. Run the smallest relevant verification first, then broaden based on risk,
   touched surfaces, failures, or repo norms.
6. Run verifier review according to the execution profile using an independent
   agent where practical. Use selected agent references for exact wrapper,
   model, effort, and prompt details. Apply the Supervision Budget to verifier
   work as well as implementation work.
7. If Codex review, tests, or verifier output are red, fix directly or redelegate
   a targeted follow-up. Repeat review and verification until green or until a
   real blocker or user decision is needed.
8. Check whether durable state is sufficient for the next phase. If context is
   getting heavy, update a plan document, ledger, changelog, issue, or handoff
   note before asking to continue.
9. End with a phase report and ask for one approval covering both the phase
   commit and continuation to the next phase, unless a stop condition applies.
10. After approval, create a focused phase commit unless the user says not to, the
   repo is not under git, or there are no changes. Do not push unless separately
   requested.
11. If the approval included continuation, the commit succeeded or was skipped
    for a valid reason, another phase remains, and no blocker or handoff warning
    applies, immediately start the next phase. Do not stop after committing and
    wait for a second "continue" prompt.

Green means the phase objective is met, relevant verification passed or was
explicitly waived with reason, Codex inspected the diff, the verifier found no
blocker, and durable state is adequate for the next phase.

## Agent References

Read only the reference files needed by the execution profile. They define how
each agent can be used across roles, including supported wrappers, model/effort
defaults, and prompt shapes.

- `references/agent-codex.md`: Codex as implementer, reviewer, verifier, or
  fallback.
- `references/agent-cursor.md`: Cursor as implementer, explorer, reviewer, or
  verifier.
- `references/agent-claude.md`: Claude as planner, reviewer, verifier, or
  implementation advisor when edit delegation is unavailable.

## Fallbacks

If a selected agent is unavailable because of usage, token, quota, credits,
rate-limit, subscription limits, wrapper failure, or missing access, do not keep
retrying that provider in the same phase. Switch the affected role to another
capable agent and disclose the fallback in the phase report.

- Implementation role unavailable: use another edit-capable agent. If no
  delegated edit-capable agent is available, the main Codex agent may implement
  directly while keeping the same phase brief and gates.
- Planning/exploration role unavailable: the main Codex agent plans, optionally
  using another available agent for bounded exploration.
- Verification role unavailable: prefer a different independent verifier. If no
  independent verifier is available, the main Codex agent performs an explicit
  second-pass review and marks verifier confidence as degraded.

Green is still possible with fallback when the same gates pass. Peer-agent quota
exhaustion is not automatically a blocker.

## Retry And Blocker Handling

Do not repeat the same failing command, peer-agent prompt, or fix attempt without
new information. After two similar red cycles, stop and either document a blocker
or ask the user a focused question unless there is a clear new fix to try.

Stop and ask before continuing when:

- phase scope changes materially
- a destructive action, secret exposure, credential change, deploy, push, risky
  branch switch, or pre-approval commit is needed
- important verification cannot be run
- peer agents recommend conflicting high-risk changes
- commands hang or repeatedly fail without new information
- no usable fallback exists for an exhausted peer-agent role
- the next phase depends on a product or architecture decision
- precise history needed for the next phase has not been written to durable state

## Commit Gate

Do not commit before the user approves the phase report. Ask for approval in a
form that makes continuation explicit, for example: "Approve committing Phase N
and proceeding to Phase N+1?" If the user approves both, commit and continue
without asking for another prompt. If the user approves only the commit, stop
after committing.

Before committing, check `git status --short`, review the staged diff, and stage
only the phase changes. Avoid unrelated user changes even when they are in files
touched during the phase. Never push unless the user separately requests it.

If Linear issues are linked and the tools are available, update the relevant
issues at phase boundaries with branch, commit when available, verification,
blockers, deferrals, and next steps. Linear updates do not replace the phase
report or approval gate.

## Context And Handoff

Codex is responsible for context health. At the end of each phase, and sooner if
the thread becomes noisy, decide whether a new thread would be safer.

Write or update durable state before recommending handoff when:

- peer-agent iterations, diffs, logs, or tests produced large outputs
- important product or architecture decisions happened in chat
- the next phase depends on exact commands, counts, run ids, blockers, or
  approval decisions
- the current state cannot be reconstructed from durable artifacts plus the diff

Durable state should record: phase status, files changed, commit hash if any,
verification commands and results, verifier result, blockers, deferred work, next
phase, and exact user decisions.

Handoff prompt shape:

```text
Continue the phase implementation loop from [artifact/path].

Current status:
- Completed phase: [phase]
- Commit: [hash or none]
- Verification: [commands/results]
- Verifier review: [PASS/BLOCKED/degraded summary]
- Deferred/skipped: [items]
- Blockers/risks: [items]
- Next phase to start: [phase]

Read the durable artifact first, then continue:
phase brief -> selected implementation if useful -> Codex diff inspection ->
verification -> selected verifier review -> phase report -> wait for approval ->
commit only after approval -> continue automatically when approval included
continuation.
```

## Phase Report

End each phase with:

- phase status: green, blocked, or needs user decision
- what changed
- branch name and current commit, if any
- verification run and result
- verifier result, including fallback or degraded confidence if applicable
- what was skipped or deferred and why
- remaining risks
- suggested plan updates
- Linear update made or intentionally skipped, if relevant
- context and handoff recommendation
- explicit single approval request before committing and continuing, or a clear
  stop/handoff recommendation when continuing would be unsafe
