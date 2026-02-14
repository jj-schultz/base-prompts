Analyze requirements or PRD, understand affected code, and produce an Asana-ready plan

### Step 1: Understand the PRD
- Read and analyze the complete PRD
- Identify the core business objectives and success criteria
- Extract functional and non-functional requirements
- Note any constraints, dependencies, or assumptions
- Clarify ambiguities before proceeding
- **Inventory all work items**: Create an explicit list of every feature, requirement, and deliverable in the PRD

### Step 2: Understand the Affected Code
- Research the existing codebase to identify:
  - Files and modules that will be modified
  - Related components that may be impacted
  - Existing patterns and architectures to follow
  - Reusable code that can be leveraged
- Map out where the new functionality fits into the current system
- Identify integration points and potential conflicts
- Review existing tests and documentation

### Step 3: Determine Section Structure
The PRD structure determines how Sections are organized:

**If the PRD defines EPICs:**
- Each EPIC becomes an Asana Section
- Tasks within each EPIC become rows in the CSV under that Section
- Section names match EPIC names from the PRD

**If the PRD does not define EPICs:**
- Organize work into logical Phases (e.g., "Phase 1 - Core Infrastructure", "Phase 2 - Feature Implementation")
- Each Phase becomes an Asana Section
- Tasks within each Phase become rows in the CSV under that Section

### Step 4: Create Tasks
For each Section (EPIC or Phase), create tasks that are:
- Sized for human execution (approximately 0.5-2 days of focused work)
- Independently completable and reviewable
- Written in imperative, action-oriented language

Consider including tasks for:
- Design/architecture decisions
- Code implementation
- Unit and integration testing
- Code review and refinement
- Documentation updates
- Deployment preparation

### Step 5: Verification (REQUIRED)
Before finalizing the CSV, perform a completeness check:
1. **Cross-reference**: Compare every requirement, feature, and deliverable from the PRD inventory (Step 1) against the generated tasks
2. **Gap identification**: List any PRD items not covered by at least one task
3. **Coverage confirmation**: For each gap found, either add missing tasks or document why the item is intentionally excluded
4. **Traceability**: Each significant PRD requirement should be traceable to one or more tasks

Append a verification summary to the end of `todo.md`:
```
## $GAMEPLAN Verification
- PRD items identified: <count>
- Tasks generated: <count>
- Coverage gaps found: <count or "None">
- Resolution: <brief description if gaps existed>
```

### CSV Output Requirements

The output is a **CSV file** for direct import into Asana, created in the project root directory unless otherwise specified.

The CSV must include these columns:

| Column | Required | Description |
|--------|----------|-------------|
| `Section` | Yes | EPIC name (if PRD has EPICs) or Phase name |
| `Task Name` | Yes | Short, action-oriented title |
| `Description` | Yes | What to do and why |
| `Parent Task` | No | Task name of parent (for subtasks only) |
| `Dependencies` | No | Upstream task names, comma-separated |
| `Assignee` | No | Leave blank unless explicitly specified |
| `Due Date` | No | Leave blank unless explicitly specified |
| `Notes` | No | Acceptance criteria and extended context |

Each row represents one task or subtask.

### File Naming Convention

`gameplan_<project_or_feature_name>.csv`

Example: `gameplan_user_authentication.csv`

### Out-of-Scope Handling
- Explicit non-goals and exclusions must be in a final Section named: `Out of Scope / Non-Goals`
- Tasks in this Section should clearly describe what is intentionally excluded

### Planning Rules
- Optimize for clarity, sequencing, and human ownership
- Avoid LLM-oriented instructions or meta commentary
- Prefer fewer, well-scoped tasks over many tiny steps
- Explicitly call out reuse of existing code or systems within task descriptions
- Assume the plan will be executed and tracked by humans in Asana

### Mandatory Output Rules
- Do NOT append the gameplan to `todo.md`
- Do NOT narrate the plan in the chat output
- The CSV file is the authoritative output

