The `$ALIGN_TESTS` skill is a request to run the shared test wrapper, inspect failures, and update stale tests so they reflect the correctly working application until the wrapper succeeds.

# Required Workflow
1. Inspect the active `todo` file content before the first test run.  the todo file may contain guidance on what tests to run or where it thinks the failure might be.  Respect this guidance - if a test is specified only focus on that test
2. If no test is specified, execute `./developer-tools/scripts/by_tests_all.sh`.  if a test is speficied, execute the command given in the file 
3. If the tests pass, stop.
4. If there are test failures, read the current failure output and any summary emitted by the wrapper.
5. Decide what test updates are needed next:
   - Review the `goal.md` file if it exists. This will contain guidance about what the changes are trying to do.
   - If the active `todo.md` contains explicit guidance about which app behavior is correct, follow that guidance.
   - If the active `todo.md` does not contain that guidance, inspect the current uncommitted changes by following [instructions--fetch_uncomitted_changes.md](instructions--fetch_uncomitted_changes.md), then compare the failing assertions with the changed behavior so the test updates match the actual application behavior.
6. Make a short plan for the next test-only fix.
7. Implement the planned fix by updating only test files or test-support files that are part of the test suite.
8. If running a focused subset will speed up iteration, use `./developer-tools/scripts/by_tests_all.sh --tests=...` before the full rerun.
9. Loop back to step 2 and repeat until all of the tests in `./developer-tools/scripts/by_tests_all.sh` succeed.
10. If the failing test can only be resolved by changing production code or if human input is required to choose between valid behaviors, stop iterating and append the specific blocker to the active `todo.md` file.

# Hard Constraints
- Assume the application is behaving correctly unless the active `todo.md` explicitly says otherwise.
- Update the tests to match the current intended behavior; do not change production code as part of this skill.
- Outside of the required `todo.md` and `.ai_coding/history.md` bookkeeping, only modify test files or test-support files such as fixtures, mocks, and test helpers.
- Reuse existing test files, fixtures, and helpers whenever possible. Prefer extending current coverage over creating new test files.
- When a failure exposes a real product bug instead of a stale assertion, stop and record that blocker in `todo.md` rather than editing production code under this skill.

# Required Output
Once all tests pass, if you've made any code changes you must write a summary of the changes made to the TODO file. Title this section `# CHANGE SUMMARY`. it must:
- highlight explicitly that you changed only tests to reflect the current app behavior
- note any failing areas that were left untouched because they would require production-code changes or human input
