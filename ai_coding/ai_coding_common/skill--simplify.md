Review the current uncommitted changes for safe simplification opportunities.

Required steps:

# First: fetch and understand the current work
1. Follow instructions here: [instructions--fetch_uncomitted_changes.md](instructions--fetch_uncomitted_changes.md)
2. Review the active `todo.md` file and `.ai_coding/history.md` when they help explain why the change exists.
3. Inspect surrounding unchanged code whenever needed so you understand the exact behavior, constraints, and reusable helpers before proposing any simplification.

# Then: identify only safe simplifications inside the changed code
Focus on opportunities that keep the exact same behavior while reducing complexity.

Look for:
- unnecessary branches, indirection, temporary variables, or helper layers
- duplicated changed-path logic that can reuse an existing helper or be merged into one clearer path
- code bloat where a smaller expression or existing local pattern is clearer
- multiple tests or test files covering the same changed behavior; prefer one focused test or one focused test file when that preserves coverage

# Hard constraints
- Only analyze the uncommitted changes.  Do not suggest simplifications for untouched code.
- Do not suggest functionality changes, behavioral tradeoffs, or cleanup that depends on changing requirements.
- Do not simplify away validation, ordering, side effects, API contracts, concurrency controls, or regression coverage unless you have verified they are unnecessary.
- Prefer removing code, merging duplicated changed-path logic, or reusing existing helpers over adding new abstractions.
- If a change appears complex for a good reason, leave it alone.

# Required output behavior
Append the review results to the active `todo.md` file under this heading:

## Simplification Review

For each opportunity, report:
```
PRIORITY: <HIGH PRIORITY | NICE TO HAVE | LOW PRIORITY>
FILE: <path>
LINE: <number>
WHY: <what is unnecessarily complex or duplicated>
SIMPLIFICATION: <the simpler exact-behavior alternative>
REGRESSION SAFETY: <what must remain identical and why this recommendation stays within the changed scope>
```

Only report opportunities you would actually implement.

If no safe simplifications are found, append: `No safe simplifications identified.`
