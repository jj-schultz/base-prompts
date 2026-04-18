Interpret the todo body as a request to implement one or more Linear issues referenced in the text.

Required workflow:

1. Scan the active `todo.md` body for a Linear project URL. If a project URL is found, fetch all non-complete, non-canceled issues in the project and write the issue ids to `todo.md`.
2. Scan the active `todo.md` body for all Linear issue ids matching `[A-Z][A-Z0-9]+-[0-9]+`. If none are present, append that blocker to `todo.md` and stop.
3. Reuse existing Linear MCP auth when it is already available. If auth is missing, follow the repo rule to confirm with the user before starting `codex mcp login linear`.
4. In the current code directory, choose the run branch once before implementation:
   - If there is one issue, create or switch to a feature branch named `<issue-id-lowercase>-fix`. Example: `ENG-123` -> `eng-123-fix`.
   - If there are multiple issues, create or switch to a feature branch named for the project name.
5. For each Linear issue id in the todo, work issue-by-issue on that same checkout and branch:
   - First, use the Linear MCP server to read the full issue, comments, and any linked context.
   - Confirm the issue belongs to the current code directory. If the owning repo is elsewhere, append that blocker to `todo.md` and stop instead of creating another checkout, worktree, or clone.
   - Treat the Linear issue plus linked context as the implementation brief and execute the workflow in [skill--gap_impl.md](skill--gap_impl.md).
   - Then inspect the current repo, implement the fix, run relevant tests, and summarize:
     - root cause
     - files changed
     - test results
     - any ambiguity that remains
   - Draft a PR title and PR body that references the Linear issue id.
6. Append the per-issue result to `todo.md` using this structure:

```markdown
## $LINEAR_IMPL <ISSUE-ID>
### Repo
- `<repo path>`

### Branch
- `<issue-id-lowercase>-fix`

### Summary
- Root cause: ...
- Files changed: ...
- Test results: ...
- Remaining ambiguity: ...

### PR Draft
- Title: ...
- Body:
  ...
```

Required rules:

- Use Linear MCP to read the issue, comments, and linked context before reading or changing code.
- Do not work from the issue title alone.
- Do not create or use git worktrees, extra clones, or secondary checkouts for `$LINEAR_IMPL`.
- Do all implementation work in the current code directory on the single branch selected in step 4.
- If a multi-issue run includes work that belongs in another repo, append that blocker to `todo.md` and stop.
- Draft a PR title and PR body that references each implemented issue id.
