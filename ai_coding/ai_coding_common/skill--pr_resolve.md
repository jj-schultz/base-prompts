When the todo starts with `$PR_RESOLVE`, the todo content will include:
- a PR link with merge conflicts
- optional conflict-handling guidance

Required behavior:
1. Read the todo guidance and inspect the repository state to identify all conflicted files and conflict blocks.
2. Resolve conflicts manually and deterministically; do not keep conflict markers and do not use one-click "accept ours/theirs" for full files unless explicitly requested in the todo guidance.
3. Preserve intended behavior from both branches by reconciling logic, imports, types, and call sites against surrounding code.
4. Reuse existing utilities/patterns in the codebase; do not introduce duplicate helpers.
5. Validate that each edited file has no remaining conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`) and no broken references caused by the merge.
6. Prefer the smallest safe change set that fully resolves the conflict while keeping behavior correct.
7. If any conflict cannot be resolved confidently, append a blocking note to the todo file with: file path, exact unresolved context, why it is blocked, and what human input is needed.
