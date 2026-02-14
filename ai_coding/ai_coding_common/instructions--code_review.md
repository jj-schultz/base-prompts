Evaluate every changed line against these criteria. Flag noteable violations.

**Import discernment principles** 
Don't be overly pedantic just to have review feedback  
- Use your best judgement, but it's totally fine to say "looks good" if that's the case

## 0. Validate code against our coding principles
[instructions--coding_principles.md](instructions--coding_principles.md)

## 1. No Bugs
- Verify logic correctness: conditionals, loops, edge cases
- Check null/undefined handling where data flows from external sources
- Confirm state mutations are intentional and complete
- Validate error paths propagate correctly (no swallowed exceptions)
- Ensure new code does not break existing functionality

## 2. Codebase Consistency
- Match existing naming conventions (variables, functions, files)
- Follow established directory and module structure
- Use existing patterns for similar operations (API calls, data transforms, component structure)
- Maintain consistent formatting with surrounding code
- Reuse existing utilities rather than duplicating functionality

## 3. Idiomatic Implementation
- Use language-native constructs (list comprehensions, destructuring, pattern matching)
- Apply framework conventions (React hooks patterns, Django ORM idioms, etc.)
- Prefer standard library solutions over custom implementations
- Follow established community patterns for the technology stack

## 4. Performance at Scale
- Prevent N+1 query patterns: use joins, prefetch_related, select_related, bulk operations
- Evaluate time complexity: flag O(n²) or worse when O(n) or O(n log n) alternatives exist
- Check for unbounded loops or recursive calls without termination guarantees
- Identify memory accumulation in loops or long-running processes
- Verify database indexes exist for filtered/sorted columns in new queries

## 5. Clean and Maintainable Code
- Functions and methods should have single, clear responsibilities
- Names must communicate intent without requiring comments
- Complex logic requires explanatory comments; obvious code does not
- Avoid deep nesting: extract early returns or helper functions
- Keep functions short enough to understand in one screen view
- Remove dead code, unused imports, and commented-out blocks

## 6.  No Dead Code
- Is the the code creating dead coded?  ie did it introduce methods that are no actually used.  Did it cause some existing methods to become dead code (ie their usage fully removed)?

## 7. Database Migrations and Data Safety
- **Any database migration or schema change requires explicit data loss risk assessment**
- Review migrations for destructive operations: DROP TABLE, DROP COLUMN, TRUNCATE, DELETE without WHERE
- Validate that the DB schema is **backwards compatible**.  The code running in production **must** be able to run with the new schema prior to the related code changes being pushed.  
- Validate that column type changes preserve existing data (e.g., reducing VARCHAR length, changing numeric precision)
- Check for NOT NULL constraints added to columns with existing NULL values
- Verify foreign key constraints won't orphan or cascade-delete existing records
- Ensure index removals won't cause unacceptable query performance degradation
- Confirm migrations are reversible when data preservation matters
- Flag any migration that could cause data loss as **MUST FIX** with explicit validation required before deployment

# Review Output Format

**you must** append the results of the review to the todo file that contained your original instructions. For each issue found, report:
```
PRIORITY: <MUST FIX | HIGH PRIORITY | NICE TO HAVE | LOW PRIORITY>
FILE: <path>
LINE: <number>
CATEGORY: <1-6 from above>
ISSUE: <concise description>
FIX: <recommended change>
```

If no issues found, state: "No code quality issues identified."

Order the issues is order:  "MUST FIX" then "HIGH PRIORITY" then "NICE TO HAVE" then "LOW PRIORITY"

## Priority Definitions 
- MUST FIX: correctness, data loss, security, crashes, broken behavior
- HIGH PRIORITY: likely bugs, performance issues at scale, significant maintainability risks
- NICE TO HAVE: improvements to clarity, idioms, minor performance gains
- LOW PRIORITY: stylistic or cosmetic issues with minimal impact
