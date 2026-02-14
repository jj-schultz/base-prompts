 Analyze requirements or PRD from to todo file, understand affected code, and produce a list of tasks that will be manually added to Asana. 
 
# Task Definition Instructions

This document provides instructions to break down work into human-readable tasks suitable for manual addition to Asana.

## Core Principles

### 1. Use Active Voice

Every task must use active voice where the subject performs the action.

**Good:**
- "User submits login credentials and receives authentication token"
- "System validates registration form fields before submission"
- "Admin resets user password and system sends confirmation email"

**Bad:**
- "User authentication endpoint is implemented"
- "Form validation should be added"
- "Email is sent"

### 2. Specify All Four Elements

Every task must clearly identify:

1. **Who/What takes the action** (the actor: a user role like "User", "Admin", "Customer" or a system like "System", "Scheduler", "API")
2. **What is the action** (the verb/operation)
3. **Who/What receives the action** (the target)
4. **What is the expected outcome** (the result)

**Template:**
> [Actor] [action] [target] so that [expected outcome].

**Examples:**
- "User requests profile data from `/api/users/profile` and system returns account information so that the user can view their settings."
- "System records `last_login` timestamp when user authenticates so that admins can track user activity."
- "Customer enters credit card details and checkout form validates expiration date so that customer receives immediate feedback on invalid input."

### 3. Prioritize Accuracy

- State only what is known and verifiable
- Do not invent requirements, behaviors, or implementation details
- Reference existing code, documentation, or specifications when available
- If uncertain, state the uncertainty explicitly rather than guessing

### 4. Optimize for Human Comprehension

- Use clear, unambiguous language
- Avoid jargon unless the audience universally understands it
- Break complex concepts into digestible pieces
- Lead with the most important information

## Task Sizing Guidelines

### Right-Sized Tasks

A well-sized task:
- Represents approximately 0.5 to 2 days of focused work
- Can be completed, reviewed, and merged independently
- Does not require coordination with multiple parallel efforts
- Has clear start and end criteria

### Grouping Rules

Use your **best judgement** when grouping work items. The goal is to avoid creating many small tasks for the same working area while maintaining enough granularity that each task has clear scope and can be reviewed independently.

**Group together:**
- All database schema modifications for a single feature (migrations, model updates, seed data)
- Multiple fields being added to the same model—these belong in a single task, not one task per field
- Multiple models that must be modified together to implement a single piece of functionality
- Related API endpoint changes that must deploy together
- Frontend component and its associated styling
- Multiple similar changes to the same UI view (e.g., adding several form fields, updating multiple list columns, applying consistent styling changes)

**Keep separate:**
- Backend and frontend work (different assignees, different review cycles)
- Independent features that can ship separately
- Testing tasks that verify completed functionality

**Judgement guidance:**
- When in doubt, prefer fewer well-scoped tasks over many small ones
- Ask: "Would these changes naturally be reviewed and committed together?" If yes, group them
- Ask: "Does splitting these into separate tasks add clarity or just overhead?" If just overhead, keep them together
- A task that touches one model or one view extensively is usually better than five tasks that each touch it slightly

### Task Must Include Testing

Every implementation task implicitly includes:
- Writing unit tests for new code
- Updating existing tests affected by changes
- Manual verification that the feature works as specified

If testing requires special setup or is particularly complex, create a separate testing task.

### Commits Must Not Break the Build

Each task's code changes must:
- Pass all existing tests when committed
- Not introduce regressions in unrelated functionality
- Be deployable without depending on uncommitted work from other tasks

If a feature requires multiple tasks to function, explicitly state the dependency and deployment order.

## Writing Effective Task Names

Task names should:
- Start with an imperative verb (Create, Add, Update, Remove, Fix, Refactor)
- Identify the component or area affected
- Be specific enough to distinguish from similar tasks
- **Be self-contained and readable on their own**—a reader should understand the task without needing to see the parent task or surrounding context

**Subtasks must also be self-descriptive.** A subtask like "Add missing fields" or "Update the model" is useless in isolation. Instead, state what is being added and why.

**Avoid defect-implying language.** Words like "missing", "fix", or "broken" suggest something is wrong with the existing code. When adding new functionality to support a feature, describe what you are adding and its purpose—not that something was "missing."

**Good:**
- "Create user registration API endpoint"
- "Add email validation to signup form"
- "Add status and priority fields to Project model for workflow tracking"
- "Extend Order model with shipping_address and billing_address fields for checkout flow"

**Bad:**
- "Work on authentication"
- "Update backend"
- "Bug fix"
- "Add missing Project model fields" (implies defect; doesn't say what fields or why)
- "Update the model" (requires parent context to understand)


**Single Subtask Rules**
- If a Task would have only a single subtask, then include the subtask data in the Task's fields and **do not** create the single subtask

**Single Task Rules**
- If a Phase would have only a single task, then include the task data in the Phase's fields and **do not** create the single task.  Do not label it has a Phase in this case - just label it like a task

### Phase Suppression Rule (Strict)

If a Phase would contain exactly one task:
- DO NOT emit the Phase name, Phase label, or any Phase-derived phrasing.
- DO NOT prefix task names with the Phase name.
- DO NOT prefix task names with area (like BACKEND or FRONTEND) - just describe the task
- DO NOT create placeholder rows, section headers, or grouping artifacts for the Phase.
- Emit ONLY a single task, written as a standalone task, at the same hierarchy level as other tasks.

This rule applies to:
- Task names
- Task descriptions
- Acceptance criteria
- CSV output (no Phase rows, no Phase text in any column)


## Writing Effective Descriptions

A description answers three questions:
1. **What** needs to happen?
2. **Who** initiates the action (user role or system)?
3. **Why** is this necessary?

**Example:**
> User submits registration form with email, password, and name fields. System validates input, creates a user record in the database, and returns a JWT token. This enables users to create accounts through the web application.

## Writing Effective Acceptance Criteria

Acceptance criteria must be:
- **Specific:** No ambiguous terms like "fast" or "user-friendly"
- **Measurable:** Can be verified with a test or observation
- **Binary:** Either met or not met, no partial credit

**Good:**
- "Endpoint returns 201 status code with JWT token on successful registration"
- "Endpoint returns 400 status code with validation errors when email format is invalid"
- "User record appears in database with hashed password after successful registration"

**Bad:**
- "Registration works correctly"
- "Errors are handled properly"
- "Performance is acceptable"

## Dependency Management

### When to Declare Dependencies

Declare a dependency when:
- Task B literally cannot begin until Task A completes (e.g., API must exist before frontend can call it)
- Task B's implementation approach depends on decisions made in Task A

### How to Express Dependencies

- Reference the exact task name
- Explain why the dependency exists if not obvious
- Consider whether the dependency is hard (cannot start) or soft (should wait)

**Example:**
> **Depends on:** "Create user registration API endpoint"
> **Reason:** Frontend form submission requires the API endpoint to exist.

## Common Anti-Patterns

### Avoid These Mistakes

| Anti-Pattern     | Problem             | Fix                                                      |
|------------------|---------------------|----------------------------------------------------------|
| Vague actors     | "Someone should..." | Name the role: "User submits...", "System validates..."  |
| Passive voice    | "Data is saved..."  | Active voice: "System saves data..."                     |
| Missing outcomes | "Add validation"    | Include why: "...so user gets feedback"                  |
| Monolithic tasks | "Build the feature" | Break into independent pieces                            |
| Assumed context  | "Fix the bug"       | Specify: "Fix null pointer when user submits empty form" |
| Time estimates   | "This takes 2 days" | Remove; sizing is separate from definition               |


## Asana Export Format and example

When outputting tasks for Asana import, you **must** use the CSV format defined in [asana_export_template.csv](./asana_export_template.csv).

This template contains example tasks that demonstrate the correct column structure and formatting. When generating your output:
- Follow the column structure exactly as shown in the template
- Do not include the example tasks from the template in your output
- Include only the tasks you have defined for the current work

Put the .csv containing the Asana tasks in a directory named `asana_exports` in the project's root directory
