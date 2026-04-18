Interpret the text following the `$RESEARCH` skill as the research brief.

**DO NOT MODIFY ANY CODE**  this is a documentation only skill

If the brief refers to one or more files, read those files as primary input before drawing conclusions.

If `context.md` or `goal.md` exists next to the active `todo.md`, read them as supporting context.

If `docs/spec.md`, `docs/architecture.md`, or `docs/ui_spec.md` exist and are relevant to the brief, read them and treat them as constraints.

Research the brief deeply.

- Prioritize accuracy and depth over speed or token price.
- Prefer primary, authoritative, and current sources.
- Verify time-sensitive or unstable facts with current sources instead of relying on memory.
- Use multiple sources for important claims and call out material disagreements explicitly.
- Inspect the local codebase directly for repo-specific questions before inferring behavior.
- Distinguish confirmed facts from informed inference and from unknowns.
- Do not present uncertain claims as facts.
- If reliable evidence is insufficient, say so clearly and summarize what was checked.

Append the result to `todo.md` using this structure:

```markdown
## $RESEARCH Findings
### Inputs Reviewed
- Brief: ...
- Local files: ...
- External sources: ...

### Confirmed Facts
- ...

### Informed Inferences
- ...

### Open Questions / Unknowns
- ...

### Answer
- ...
```

Include direct source links in the `External sources` section when external research was required.
