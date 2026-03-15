# Task Keywords

The framework supports several task types:

- `$IMPL`: Implement a code change
- `$IMPL-ERR`: Fix an error described in `err.log`
- `$TESTS`: Execute test-related instructions
- `$REVIEW`: Perform code review on specified files
- `$PERFORMANCE_CHECK`: Review a diff specifically for performance, concurrency, memory, and scale risks
- `$BRANCH_REVIEW`: Review changes on a branch
- `$GAP`: Analyze gap between current and desired functionality
- `$GAP-CLOSE`: Implement code to close an identified gap
- `$TASKS`: Execute task breakdown instructions
- `$GAMEPLAN`: Create an implementation gameplan (uses branch review instructions)
- `$REFACTOR`: Perform functionality-neutral refactoring
- `$ITERATE`: Implement and test iteratively until success
- `$QUESTION`: Answer a question about the code or architecture
- `$DEBUG`: Provide manual debugging steps
- `$THEORIES`: Generate multiple theories about a problem (with probability assessment)
- `$THEORY`: Generate the most probable theory about a problem
- `$EVAL`: Evaluate an idea, approach, or existing code
- `$PLAN`: Create a detailed implementation plan
- `$DOC`: Create documentation
- `$E2E_TESTS`: Write UI-only end-to-end smoke tests using the Playwright test framework


## Examples
Some example todo.md file contents

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
