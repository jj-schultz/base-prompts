Create an implementation plan that Codex or Claude Code can execute from a PRD and any referenced example images, screenshots, specs, or goal files.

The text after the `$PLAN` skill is the planning brief

If the brief refers to one or more files, read those files as primary input.

Before writing the implementation plan, perform a gap analysis against the current codebase and plan only the work needed to close the identified gap.

## Required workflow

### 1. Gather requirements inputs

- Read the full PRD or planning brief.
- If `goal.md` exists next to the active `todo.md`, read it and use it as supporting intent.
- If `docs/spec.md`, `docs/architecture.md`, or `docs/ui_spec.md` exist, read them and treat them as constraints.
- If the brief references screenshots, example images, or files in `docs/screenshots`, inspect them before planning.
- If the brief references a raw video file, follow the repository's top-level instructions for extracting frames before using it as visual input.

### 2. Extract the desired functionality and real requirements

Build an internal inventory of:

- explicit functional requirements
- explicit non-functional requirements
- visible UI expectations shown in screenshots or example images
- constraints, dependencies, and non-goals
- ambiguities or missing decisions

Rules:

- Do not invent behavior that is not supported by the PRD, images, codebase, or project docs.
- Separate confirmed requirements from reasonable inferences.
- When using image evidence, describe only what is actually visible or strongly implied.

### 3. Research the current implementation and reuse opportunities

Before writing the plan:

- inspect the existing codebase for reusable APIs, components, modules, utilities, and patterns
- identify likely files or subsystems that would be touched
- identify existing tests, fixtures, and docs related to the work
- map integration points, state boundaries, and likely regression areas
- record concrete reuse candidates and small backward-compatible extension points

Rules:

- Prefer reuse and small backwards-compatible changes over introducing new abstractions without need.
- Reuse existing APIs, components, modules, and utilities before planning new functionality.
- Do not plan duplicate functionality when a safe reuse or extension path exists.

### 4. Perform a gap analysis before planning

Before producing implementation tasks:

- define the desired functionality from the planning brief, supporting files, and visual inputs
- identify the current implementation relevant to that desired functionality
- compare desired functionality to the current implementation and define the difference as the gap
- reuse the existing `$GAP` concepts of desired functionality, current behavior, and identified gap when describing this analysis
- mark requirements that are already supported as covered so they do not become implementation tasks
- if no meaningful implementation gap remains, say so explicitly and provide a high-level overview of the existing implementation and significant related files instead of inventing work

### 5. Produce an agent-executable plan

Write a step-by-step implementation plan optimized for autonomous execution by Codex or Claude Code.

The plan must:

- close only the identified gaps
- break work into ordered tasks that are small enough for an LLM to execute safely in iterative passes
- preserve dependency order
- call out likely touched files or modules when they can be identified
- include acceptance criteria and validation notes for each task
- explicitly note reuse opportunities from the current codebase
- isolate ambiguities so implementation tasks contain only actionable, supported work

Prefer fewer, well-scoped tasks over many tiny tasks. A task should usually be something that could be implemented and reviewed as one coherent change.

### 6. Perform a coverage check

Before finalizing the plan:

- cross-reference every significant PRD requirement against at least one gap item and at least one task, or mark it already covered
- cross-reference every important screenshot-driven expectation against at least one task or an explicit open question
- cross-reference every identified gap against at least one task
- identify anything intentionally excluded from the plan
- identify blockers that would prevent safe implementation

## Output format

Append the result to `todo.md` using this structure:

```markdown
## $PLAN_FROM_PRD Inputs
- PRD sources: ...
- Visual sources: ...
- Codebase areas reviewed: ...

## $PLAN_FROM_PRD Requirements
### Confirmed
- ...

### Inferred From Visuals
- ...

### Open Questions / Ambiguities
- ...

## $PLAN_FROM_PRD Gap Analysis
### Current Behavior
- ...

### Gaps To Close
- ...

### Reuse Opportunities
- ...

## $PLAN_FROM_PRD Plan
1. Task name
   - Goal: ...
   - Gap closed: ...
   - Likely files/modules: ...
   - Reuse: ...
   - Acceptance criteria: ...
   - Validation: ...
   - Depends on: ...

## $PLAN_FROM_PRD Coverage Check
- Requirements identified: <count>
- Gaps identified: <count or "None">
- Planned tasks: <count>
- Coverage gaps: <count or "None">
- Blockers: <count or "None">
```

## Planning rules

- Optimize for LLM comprehension and execution, not for Asana import.
- Do not provide implementation time estimates.
- Do not write code.
- Do not include filler, rationale history, or meta commentary.
- Do not invent implementation tasks for behavior that the gap analysis found to be already supported.
- If the requirements are too ambiguous for a safe implementation plan, say so clearly and limit the output to the safest supported plan plus explicit open questions.
