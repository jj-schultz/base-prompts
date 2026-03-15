# AI Coding Assistant Framework

A structured framework for working with AI coding assistants (Claude Code, GitHub Copilot/Codex, Gemini) using shared instructions and todo-based workflows.

## What This Tool Is

This framework provides a standardized way to interact with multiple AI coding assistants by:

- **Centralized Instructions**: Shared high-level coding principles and execution rules that all AI assistants follow
- **Todo-Based Workflow**: Each AI assistant works from a dedicated `todo.md` file with keyword-based task directives
- **Consistent Standards**: Staff-level engineering principles including DRY, fail-fast error handling, algorithmic soundness, and proper git hygiene
- **Keyword System**: Structured task types (`$IMPL`, `$REFACTOR`, `$QUESTION`, `$EVAL`, etc.) that define exactly how each task should be executed
- **Notification Protocol**: Automated completion notifications when tasks are done

## How to Use

### 1. Add Tasks to Todo List

Edit the appropriate `todo.md` file (e.g., `.ai_coding/claude/todo.md`) and add tasks using keyword prefixes.  List of all keywords lives here [keywords.md](keywords.md)

Here's some examples:

```markdown
$IMPL 

Add user authentication to the login page

Add automated tests
```

```markdown
$REFACTOR 

Extract database query logic into a separate service module
```

```markdown
$QUESTION 
What's the best approach for caching API responses in this architecture?
```

```markdown
$REVIEW ./src/auth/login.py
```

### 2. Run Your AI Assistant

Invoke your AI coding assistant (Claude Code, Copilot, etc.) and point it to the todo file. For Claude Code:

```bash
/todo
```

The assistant will:
- Read the shared `instructions---top_level.md`
- Process tasks in order from the `todo.md` file
- Follow keyword-specific execution rules
- Mark completed items with checkmarks
- Append a summary of changes to the `todo.md` file
- Execute the notification protocol

### 3. Review Results

Check the `todo.md` file for:
- Completed tasks (marked with )
- Summary of files modified and changes made
- Any questions or blockers the assistant encountered

## Installation

### Install in a New Codebase

Run the installation script from your project root:

```bash
# Clone or copy the ai_coding framework to your project
cd /path/to/your/project

# Run the installer
bash /path/to/ai_coding/install_local_coders.sh
```

The installer will:
1. Create `.ai_coding/` directory structure with `claude/`, `codex/`, and `gemini/` subdirectories
2. Initialize `todo.md` files in each assistant directory
3. Create symbolic link to `ai_coding_common/` (assumes shared instructions at `~/src/base-prompts/ai_coding/ai_coding_common`)
4. Add `/.ai_coding` to your `.gitignore` file

### Manual Installation

If you prefer manual setup:

```bash
# Create directory structure
mkdir -p .ai_coding/{claude,codex,gemini}

# Copy or symlink the ai_coding_common directory
ln -s /path/to/ai_coding/ai_coding_common .ai_coding/ai_coding_common

# Create todo.md files
echo "# TODO List - **you must** first read and execute all the rules and steps defined in \`<./.ai_coding/ai_coding_common/instructions---top_level.md>\`, then proceed to the following todo items:

" > .ai_coding/claude/todo.md

# Add to .gitignore
echo "/.ai_coding" >> .gitignore
```

## Core Principles

The framework enforces staff-level engineering practices:

- **DRY Principle**: Reuse existing code, avoid duplication
- **Fail Fast**: Let exceptions propagate, no defensive error handling
- **Algorithmic Soundness**: Avoid N+1 queries and poor asymptotic complexity
- **Type Safety**: Use explicit types, avoid dynamic lookups
- **Git Hygiene**: Immediately `git add` new files, focused commits
- **No Over-Engineering**: Implement only what's requested, keep solutions simple

## Requirements

- AI coding assistant (Claude Code, GitHub Copilot, or Gemini)
- Bash shell (for installation and notification scripts)
- The shared `ai_coding_common` directory with `instructions---top_level.md`
