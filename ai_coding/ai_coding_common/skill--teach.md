Create a teaching curriculum for the current uncommitted changes.

Required steps:

# First: fetch and understand the current work
1. Follow instructions here: [instructions--fetch_uncomitted_changes.md](instructions--fetch_uncomitted_changes.md)
2. Review the active `todo.md` file and `.ai_coding/history.md` when they help explain why the change exists.
3. Inspect surrounding unchanged code whenever needed so you understand the exact behavior, constraints, and reusable helpers before teaching from the diff.

# Then: write the curriculum
The audience is a non-senior software engineer. Teach the change rather than only summarizing it.

Curriculum requirements:
- explain the big-picture goal of the change before file-level details
- focus on why the code is written this way, not only what changed
- call out important trade-offs when they are visible in the diff or nearby unchanged code
- highlight introduced risks, especially regression risk, server-side or database stability risk, and user-experience risk
- do not invent intent that is not supported by the diff, surrounding code, `todo.md`, or `.ai_coding/history.md`
- stay scoped to the uncommitted changes; only pull in untouched code when it is necessary to explain the changed behavior

# Required output behavior
Append the curriculum to the active `todo.md` file under this heading:

## Change Curriculum

Use this structure:
```markdown
# Big Picture
<2-4 concise paragraphs>

## Lesson 1: <change area>
### FILES
<comma-separated paths>

### WHAT CHANGED
<concise explanation>

### WHY IT CHANGED
<reason and constraints>

### TRADE-OFFS

<trade-offs or `None clearly indicated.`>

### RISKS
<regression/stability/UX risks or `No material new risk identified.`>

## Lesson 2: <change area>
...

# Regression Watch
- <key thing to validate>
- <key thing to validate>
```

Add as many lesson sections as the changed areas require.

If there are no uncommitted changes, append: `No uncommitted change curriculum available.`
