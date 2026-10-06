# Phase Capability Assessment

Run this assessment for every phase before approving the execution profile; reuse
it while the relevant scope, plan detail, and risk remain unchanged. It
matches phase difficulty and plan detail to the least expensive implementer that
can execute reliably without narrowing the goal or acceptance criteria.

Capability tiers describe phase requirements, not fixed model rankings. Use the
implementation defaults in `shared-protocol.md` when they meet those requirements.
The assessment does not automatically select the largest model or maximum
reasoning; preserve the user's compatible implementation profile.

## Classify The Phase

At startup, assess whether phase boundaries make verification useful: group
related mechanical edits into coherent, reviewable behavior, and split before a
consequential unchecked decision creates substantial dependent work. Do not
split by file or task count, or retain an oversized phase merely because a strong
implementer is available. Propose changes while preserving the outcome and
required assurance; material revisions to an approved plan still need the
active mode's authority and plan/tracker reconciliation. Do not regroup phases
mid-run solely to avoid required reviews. Record applicable early integration
checks and outcome milestones in the plan, using the active workflow's policy.

Use one complexity class:

- **TINY:** a bounded change in one familiar area, an established pattern, one
  clear acceptance check, and no material architecture, data, auth, concurrency,
  migration, public-contract, or cross-package decision.
- **ROUTINE:** several coordinated edits or normal repository exploration, but
  the behavior is understood, local patterns exist, and risks are conventional.
- **COMPLEX:** ambiguous root cause or design, cross-package behavior, novel
  architecture, migration/schema/public contract, concurrency, auth/security,
  production/shared-data risk, or likely multi-iteration exploration.

Classify the plan separately:

- **THIN:** implementer-critical behavior, scope, acceptance checks,
  dependencies, constraints, risks, verification, or stop conditions are
  missing or materially ambiguous.
- **ADEQUATE:** a routine or strong implementer can act without guessing product
  intent; objective, boundaries, checkable acceptance criteria, dependencies,
  important invariants, verification, and open decisions are explicit. Some
  bounded repository exploration may remain.
- **DETAILED:** the plan also identifies relevant seams or likely files,
  behavior and error states, sequencing, compatibility/data implications,
  concrete checks, and stop conditions closely enough that a basic implementer
  can follow it with little interpretation.

Do not reward verbosity. Detail counts only when it removes a real implementation
decision or makes verification more deterministic. New prerequisites must pass
the delivery test in `shared-protocol.md`; the drift checkpoint is a short
orchestrator reassessment, not a new planning or documentation phase.

## Choose Plan Detail Or Implementer Strength

Use this matrix as the default recommendation:

| Phase | Plan | Recommendation |
| --- | --- | --- |
| TINY | THIN | Fill the missing details to ADEQUATE, then use the simplest capable implementer. |
| TINY | ADEQUATE or DETAILED | Recommend the simplest capable implementer. |
| ROUTINE | THIN | Offer an explicit choice: raise the plan to DETAILED for a basic implementer, or fill blocking gaps to ADEQUATE and use a routine/strong implementer. Do not start from THIN. |
| ROUTINE | ADEQUATE | Use a routine implementer. |
| ROUTINE | DETAILED | Recommend a basic implementer when no unresolved or high-risk trigger remains; otherwise use a routine implementer. |
| COMPLEX | THIN | Stop. Either raise the plan to DETAILED and reassess, or fill blocking gaps to ADEQUATE and route to a strong implementer. Never silently run a basic implementer. |
| COMPLEX | ADEQUATE | Use a strong implementer. |
| COMPLEX | DETAILED | Use a strong implementer when complexity comes from inherent risk or novel reasoning. A cheaper route is allowed only when complexity came solely from breadth/repetition, all decisions are resolved, and the user explicitly approves it. |

Auth/security, concurrency, migration/schema, public-contract, destructive,
production, or shared-data risk always requires a strong implementer regardless
of plan detail. A detailed plan reduces uncertainty; it does not erase risk.

If the user requests a basic or low-cost implementer profile, show every
incompatible phase and the two available remedies: add enough plan detail, or
upgrade that phase's implementer. Do not silently upgrade the model, silently
downgrade the goal, or begin an incompatible phase. Conversely, recommend a
simpler implementer for a TINY phase with an ADEQUATE or DETAILED plan.

## Startup Output

Present one compact row per phase:

```text
| Phase | Complexity | Plan detail | Evidence | Recommended implementer | Required action |
```

Evidence names the decisive facts, not a generic score. Required action is one
of: `ready`, `add plan detail`, `use stronger implementer`, or an explicit choice
between the latter two. Record the approved result in durable state and use it
in the implementation prompt.

When adding detail, clarify the existing goal; do not invent unresolved product
decisions or reduce scope. If the refinement changes or adds objectives,
acceptance criteria, dependencies, blockers, or deferrals, reconcile the
canonical plan and Linear again under `shared-protocol.md` before implementation.

Reassess when scope, risk, acceptance criteria, or newly discovered repository
facts materially change. If an implementer repeatedly asks questions already
implicit in the plan, guesses between plausible behaviors, or returns a second
substantively similar repair, treat that as possible plan-detail or capability
mismatch. Update the assessment before another implementation attempt instead
of continuing an open-ended retry loop.
