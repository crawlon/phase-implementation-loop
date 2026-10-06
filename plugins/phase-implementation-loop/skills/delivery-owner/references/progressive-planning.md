# Progressive Roadmap Planning

Use when later implementation plans depend on learning from earlier steps.
Keep milestone outcomes, acceptance criteria, compatibility obligations, and
constraints fixed; leave unresolved implementation detail visibly unresolved.
This is owner work. Managed orchestrators still receive concrete phase plans.

## Select, investigate, plan, execute, learn

1. Select the earliest actionable roadmap step from the existing dependency
   graph. Record its criterion, unknowns, and planning state in the owner index.
   Keep distant steps OUTLINED; do not repeatedly elaborate the whole roadmap.
2. If a consequential question lacks evidence, mark NEEDS_INVESTIGATION and
   name the specific question, necessary evidence, and stopping condition.
   Use existing evidence first; delegate bounded read-only discovery to a cheaper
   capable worker when authorized and useful. Prototype edits, live calls, and
   other side effects require their own scope. Discovery is not implicit
   implementation authority. Stop or escalate an exhausted investigation bound.
3. Mark READY_TO_PLAN when sufficient evidence exists. The current owner drafts one
   executable plan with ordered phases, acceptance checks, settled interfaces,
   dependencies, likely verification, capability assessment, and exclusions.
   Surface unresolved product decisions instead of guessing. Use existing
   planning conventions; length is not a measure of completeness.
4. Establish launch authority under the policy below. Record the concrete plan
   revision and its authority source; resolve dependencies, execution profile,
   resource ownership, and required tracker reconciliation before dispatch.
   Mark READY_TO_EXECUTE only when these conditions hold. A blocked gate remains
   visible even if drafting is complete.
5. Assign a managed loop or autopilot orchestrator through the normal contract.
   Keep its phase plan frozen during execution except for acknowledged revisions
   and required human decisions. Do not delegate “figure out the next roadmap
   step and implement whatever is necessary.”
6. At delivery, assess evidence at its actual scope, including integration where
   required. Record what was learned, criteria closed, and dependencies now
   satisfied. Select the next actionable step and continue planning within
   established authority. If execution needs approval, present its concrete
   plan rather than asking generically whether to continue the roadmap.

Planning an independent upcoming step may overlap current execution when
capacity permits. Do not finalize decisions dependent on unfinished results or
consume worker/reviewer capacity needed for current delivery. Evidence changes
invalidate only affected assumptions, plans, approvals, and checks. Revisit
those boundaries, not every accepted plan. Preserve earlier evidence/history.

## Authority for newly prepared plans

Record one policy explicitly:

- **Human approval per new plan:** the default when broader launch authority is
  absent. The owner may investigate/prepare plans within existing authority,
  then presents the exact plan revision, mode/profile, actions, evidence, risks,
  and outstanding decisions for approval before implementation starts.
- **Bounded delegated continuation:** requires original human authorization for
  plans that will be created later. Record the covered roadmap steps/outcomes,
  allowed implementation decisions and dependency refinements, repositories,
  permitted actions/modes, risk exclusions, resource/repair limits, and stopping
  conditions. Chat/worktree creation and messaging must cover the evolving
  roadmap cohort explicitly; approving the first cohort does not imply this.

For delegated continuation, before every dispatch record a short eligibility
decision binding the new plan ID/revision to the original human authority and
each relevant bound. The orchestrator verifies both the original authorization
and this concrete assignment. This is application of standing authority, not a
new human approval manufactured by Astra. Missing or ambiguous bounds require
the specific human decision; the word “roadmap” or “autopilot” alone is inadequate.

Refining previously unresolved implementation detail inside explicitly delegated
bounds is permitted. Changing approved outcomes, acceptance, compatibility,
contracts, frozen dependencies, or material risk still requires the applicable
human decision. New plans cannot silently expand that authority. New-plan launch
policy is separate from phase mode: managed loop retains human phase commit
approval; managed autopilot needs explicit local commit-and-continue authority.

## Completion and cost

All currently dispatched plans being green does not complete a roadmap. Map
evidence to every milestone criterion and account for outlined/unplanned steps.
If evidence already satisfies a step's outcome, record that coverage instead of
inventing a redundant plan. An unmet criterion keeps the roadmap incomplete;
removing it requires human scope approval. Preserve the integration acceptance
gate and any human acceptance gate.

Load this reference at a planning frontier, not every worker checkpoint. Keep
one compact learning/decision delta in existing state. Plan the next actionable
step; reuse settled decisions. No routine extra Astra planner or roadmap rewrite.
