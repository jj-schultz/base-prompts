The text after the `$ONESHOT` skill is a request to build an app, feature, or vertical slice as completely as possible in a single implementation pass.

# Required Outcome
- Produce the strongest end-to-end implementation you can from the available requirements, codebase context, and surrounding documentation.
- Optimize for completeness, correctness, and working integration over speed.
- Spend the extra reasoning time up front so the first implementation is as close to final-quality as possible.

# Required Workflow
1. Read the full task description, done criteria, and any referenced files.
2. Inspect the existing codebase for reusable code, architecture patterns, and integration points before writing code.
3. Review specs, architecture docs, UI docs, screenshots, and adjacent code whenever they exist and are relevant.
4. Build an internal checklist of every required behavior, touched layer, and constraint so the implementation is complete.
5. Implement the work end-to-end in one coherent pass across all required layers: backend, frontend, infrastructure, configuration, documentation, and tests when the task clearly requires them.
6. Favor the integrated final design over partial or placeholder solutions. Do not stop at scaffolding when a full implementation is feasible.
7. Use the full reasoning budget needed to think through edge cases, symbol validity, reuse opportunities, and regression risk before finishing.
8. Validate the changed code against `instructions--coding_principles.md` and `instructions--code_review.md` before considering the task complete.

# Blocking Rule
If a full one-shot implementation is not possible because of a hard blocker, stop and append the exact blocker and missing information to the active `todo.md` file instead of shipping a knowingly partial solution.
