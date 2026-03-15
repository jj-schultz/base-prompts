Generate a GitHub-ready commit message for the current uncommitted changes.

Required steps:

# First: fetch and review the current work
1. Follow instructions here: [instructions--fetch_uncomitted_changes.md](instructions--fetch_uncomitted_changes.md)
2. Review the active `todo.md` file and `.ai_coding/history.md` for context on why the change was made.
3. If needed, inspect the changed files to confirm the key technical details.

# Then: write one best-practice commit message
- Produce exactly one commit message unless the user explicitly asks for alternatives.
- Use imperative mood and keep the subject line concise (target <= 72 characters).
- Include a short body only when it improves clarity; keep it "goldilocks" length (not too short, not too long).
- Ensure the message reflects both "what changed" and "why".
- Mention notable files/components only when it adds clarity.

# Required output behavior
- **Never** run `git commit` or `git push`.
- Append the commit message to the active `todo.md` file under this heading:

## Suggested Commit Message
```text
<subject line>

<optional body>
```

- If there are no uncommitted changes, append: `No commit message generated: no uncommitted changes found.`
