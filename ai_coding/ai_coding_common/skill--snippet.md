Write a runnable code snippet into `todo.md` for the request described after `$SNIPPET`.

The text after the `$SNIPPET` line is the snippet brief.

## Required workflow
1. Read the full todo text after the `$SNIPPET` line and identify the requested outcome, target language or runtime, and any explicit constraints.
2. Read only the files needed to understand the request. If the brief references existing code, reuse the repository's real imports, APIs, models, helpers, and naming patterns instead of inventing new ones.
3. Write one concrete snippet that directly satisfies the ask.
4. Include every import, require, or setup statement needed by the snippet itself. Do not omit imports because the surrounding shell or console might preload some state.
5. If the snippet depends on placeholders, environment variables, or preconditions, state them immediately above the code block in short bullets.
6. Append the result to the active `todo.md`.

## Output format
```markdown
## $SNIPPET Result
- Language/runtime: <language or shell>
- Assumptions: None
```<language>
<full snippet with all required imports>
```
```

If assumptions are required, replace `- Assumptions: None` with short bullets.

## Rules
- Modify only the active `todo.md`.
- Do not change application code, tests, configs, or docs.
- Do not execute the snippet unless the todo explicitly asks for execution.
- Prefer the smallest runnable snippet that solves the requested task.
- When the brief does not specify a delivery format, prefer a snippet that is ready to paste into the target shell or console.
- If the brief is ambiguous, make the minimum reasonable assumptions and state them explicitly above the snippet.
