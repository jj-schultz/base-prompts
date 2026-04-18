Interpret the todo body as a request to create or update data in Linear.

# Required Workflow
1. Read the full todo text after the `$LINEAR` line and identify the requested Linear mutations plus any explicit constraints.
2. Reuse existing Linear MCP auth when it is already available. If auth is missing, confirm with the user in the CLI before starting `codex mcp login linear`.
3. Before any write, read the current Linear state for every target object with the Linear MCP tools. Fetch enough context to compute an explicit delta instead of guessing.
4. When the request maps external data into Linear or needs a concrete example of safe write behavior, inspect `./developer-tools/scripts/by_linear_roadmap_sync.py` and follow the same pattern: read current state, compute the delta, preview the delta, then write.
5. Build a concrete write plan. For each intended mutation, capture:
   - object type
   - object identifier or lookup key
   - action (`create`, `update`, `comment`, `attach`, `link`, `move`, and similar)
   - fields that will change
   - current value for each changed field when the object already exists
   - desired value
   - any inference, fallback mapping, or ambiguity that could affect the write
6. Present the full write plan to the user as a preview before any Linear mutation. The preview must ask the user to reply with either `confirm` or `cancel`.
7. Do not call any mutating Linear MCP tool until the user explicitly confirms the preview.
8. If the user changes the request after seeing the preview, recompute the preview and ask again. Do not partially apply an outdated plan.
9. After explicit confirmation, perform only the previewed Linear mutations with the appropriate MCP write tools.
10. Report the outcome concisely: objects created or updated, skipped items, failures, and any manual follow-up still needed.
11. Append the run result to `todo.md` using this structure:

```markdown
## $LINEAR
### Request
- <what the todo asked Linear to change>

### Preview
- <one bullet per planned Linear mutation>

### Result
- Status: confirmed | canceled | blocked
- Created: ...
- Updated: ...
- Skipped: ...
- Follow-up: ...
```

# Required Rules
- Treat the todo as a request to update Linear data, not as a request to implement application code.
- Limit local file edits to the active `todo.md` and `.ai_coding/history.md` unless the todo explicitly asks for another local artifact.
- Never mutate Linear before showing the preview and receiving explicit user confirmation.
- Prefer minimal, idempotent writes. Do not rewrite unchanged fields just because they were read.
- If a target object cannot be identified unambiguously, stop and ask the user instead of guessing.
- If the user replies `cancel`, do not write to Linear. Append the canceled status to `todo.md` and stop.
