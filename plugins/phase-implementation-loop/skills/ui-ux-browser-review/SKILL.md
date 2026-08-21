---
name: ui-ux-browser-review
description: Inspect built, changed, or existing product UI with the Browser skill for visual quality, concise information design, and user experience. Use when asked to review UI/UX, check a frontend change in a live app, assess consistency with an existing product, find redundant copy or duplicate links, validate responsiveness or interactions, or give evidence-based design feedback before or after implementation.
---

# Browser UI/UX Review

## Overview

Use the in-app Browser to judge the experience people actually receive, not only source code or a static screenshot. Review the intended flow in context, compare it with representative existing UI, and make claims traceable to observed state.

## Inspect the product context

1. Establish the review target: route, changed component or flow, intended user, task to complete, and any supplied acceptance criteria. Inspect the implementation only enough to locate the target and identify meaningful states; do not substitute code review for UI review.
2. Find one or two representative established surfaces in the same app: the shared shell/navigation, similar controls, related page types, and the closest analogous task. Follow supplied design-system or brand documentation when present. Treat the current product as the consistency baseline unless the user requests a redesign.
3. Start the app from the workspace containing the target changes, or reuse an app only after proving it serves that exact workspace and change. Do not treat a stale server, another worktree, older build, or deployed environment as evidence for the requested UI. If the target requires authentication or data that is unavailable, inspect every available state and name the untested state as a limitation. Do not invent visual evidence.

## Exercise the UI in the Browser

Load and follow the complete `control-in-app-browser` skill before controlling a browser. Use its required browser selection, documentation, and interaction procedures.

Test the real user sequence rather than a single resting page. Include the primary task and meaningful adjacent states: initial/empty, loading where observable, validation or error, success/confirmation, menus or overlays, keyboard focus where relevant, and back/close/cancel behavior. Let pointer-driven UI settle after moving the pointer or closing an overlay; verify the final state, not only the immediate post-click state.

Inspect desktop and a narrow mobile viewport unless the task is explicitly limited to one. At each viewport check reading order, tap-target practicality, text wrapping/truncation, horizontal overflow, fixed/sticky elements, and whether the primary action remains discoverable.

## Apply the review lens

Prioritize issues that prevent a person from understanding, deciding, or completing the task. Then assess:

- Information architecture: clear purpose, logical grouping and sequence, predictable navigation, and visible status or next step.
- Comprehension: plain and specific labels, helpful instructions, unambiguous icon meaning, appropriate defaults, feedback, and recovery.
- Content economy: each message, link, and control earns its space by adding information or a distinct action the person needs at that moment.
- Visual hierarchy: one clear primary action, scanable headings, purposeful emphasis, balanced density, and readable content order.
- Consistency: shell placement, typography, spacing rhythm, colour meaning, component states, radii, icons, controls, and interaction patterns match established app conventions.
- Aesthetic quality: alignment, whitespace, proportion, contrast, visual calm, and absence of accidental visual noise. Describe the observable reason rather than calling something merely "bad" or "nice".
- Inclusive usability: legibility, contrast concerns visible in the product, focus visibility, keyboard reachability where practical, semantic cues beyond colour, and responsive usability. This is a focused UI/UX inspection, not a conformance audit unless requested.

Do not turn subjective preferences into defects without a user goal, product convention, or concrete usability consequence. Clearly distinguish verified behaviour, reasoned inference, and preference.

## Check for duplicate information

Review each task area as a person reads it: heading, supporting copy, fields or choices, primary action, secondary links, status/help rows, and nearby navigation. Flag repeated information when two or more elements communicate substantially the same purpose, destination, instruction, or outcome without adding a necessary distinction.

Common cases include a self-explanatory heading followed by copy that only restates it; body copy, button label, and helper row all explaining the same action; several links to the same destination; or repeated status and instructions across adjacent panels. Prefer one canonical explanation and one clear action. Let a heading say what the area is for; add supporting copy only when it provides a needed why, constraint, consequence, or next-step detail that the heading and controls do not already convey. Use action labels that name the action, not a second paragraph of explanation.

Do not treat deliberate reinforcement as redundant when it serves a distinct moment or need: irreversible or high-risk confirmation, validation/error recovery, accessibility, a genuinely different audience, or a separately useful navigation route. Do not recommend removing global navigation merely because the destination is also linked in task content. State what unique value, if any, each repeated element provides before calling it duplication.

When reporting a redundancy, identify the repeated elements, the single message or destination they duplicate, the user cost (noise, slower scanning, uncertainty, or visual clutter), and the smallest consolidation that preserves required context.

## Report actionable evidence

Lead with the overall outcome: ready, ready with follow-ups, or needs revision. Include the target, tested viewports and states, and limitations. For each finding provide:

- Severity: blocking, significant, or polish.
- Evidence: route, viewport, interaction/state, and the observed result.
- Why it matters: user impact or inconsistency with an observed app pattern.
- Recommendation: the smallest clear change; name the comparable in-app pattern when useful.

If no issues are found, state the scope and evidence that supports that conclusion; do not claim the entire product is flawless. Do not modify UI unless the user separately asks for changes.
