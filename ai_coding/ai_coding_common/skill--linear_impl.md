Interpret the todo body as a request to implement one or more Linear issues referenced in the text.

Required workflow:

1. Scan the active `todo.md` body for Linear issue ids matching `[A-Z][A-Z0-9]+-[0-9]+`. If none are present, append that blocker to `todo.md` and stop.
2. Reuse existing Linear MCP auth when it is already available. If auth is missing, follow the repo rule to confirm with the user before starting `codex mcp login linear`.
3. For each Linear issue id, work issue-by-issue:
   - First, use the Linear MCP server to read the full issue, comments, and any linked context.
   - Identify the owning repo by inspecting the issue details and the local codebase. If the repo is not explicit, inspect the immediate child git repos and narrow the work to the smallest repo that owns the fix.
   - In the owning repo, create or switch to a feature branch named `<issue-id-lowercase>-fix`. Example: `ENG-123` -> `eng-123-fix`.
   - Treat the Linear issue plus linked context as the implementation brief and execute the workflow in [skill--gap_impl.md](skill--gap_impl.md).
   - Then inspect this repo, implement the fix, run relevant tests, and summarize:
     - root cause
     - files changed
     - test results
     - any ambiguity that remains
   - Draft a PR title and PR body that references the Linear issue id.
4. Append the per-issue result to `todo.md` using this structure:

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
- Keep each issue on its own branch.
- If multiple issue ids point to the same repo and uncommitted changes would block switching to the next issue branch, append that blocker to `todo.md` and stop before contaminating the next issue.
- Use Linear MCP to read `ENG-123` and implement the fix in this repo.
- Create a branch named `eng-123-fix`.
- Draft a PR title and PR body that references `ENG-123`.
