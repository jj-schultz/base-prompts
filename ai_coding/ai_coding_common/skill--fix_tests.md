The `$FIX_TESTS` skill is a request to run the shared test wrapper, inspect failures, decide whether the tests or the code should change, implement the fix, and repeat until the test wrapper succeeds.

# Required Workflow
1. Inspect the active `todo.md` content before the first test run.
2. Execute `./developer-tools/scripts/run_tests_with_summary.sh`.
3. If all tests pass, stop.
4. If there are test failures, read the current failure output and any summary emitted by the wrapper.
5. Decide what to fix next:
   - If the active `todo.md` contains explicit guidance about whether the tests should change or the code should change, follow that guidance.
   - If the active `todo.md` does not contain that guidance, inspect the current uncommitted changes by following [instructions--fetch_uncomitted_changes.md](instructions--fetch_uncomitted_changes.md), then compare the failing assertions with the changed behavior to decide whether the code regressed or the tests are stale.
6. Make a short plan for the next fix based on step 5.
7. Implement the planned fix, including test updates when the changed behavior is correct and the assertions are outdated.
8. Loop back to step 2 and repeat until all of the tests in`./developer-tools/scripts/run_tests_with_summary.sh` succeed.
9. If human input is required to choose between valid behaviors or unblock the failure, stop iterating and append the specific help needed to the active `todo.md` file.

If you think it will speed up the fixing of the tests to run a subset of the tests after step 7 (prior to fully re-running run_tests_with_summary.sh), you can do so by utilizing run_tests_with_summary.sh's "--tests=" parameter

# Hard Constraints
- Use the `todo.md` guidance first when it explicitly says whether tests or production code should change.
- When that guidance is absent, review the uncommitted diff before changing tests so the decision is based on the actual behavior change.
- When implementing fixes, follow all implementation requirements that apply to `$FIX` / `$IMPL`, including [instructions--coding_principles.md](../../../.ai_coding/ai_coding_common/instructions--coding_principles.md).

# Required Outpot
Once all tests pass, if you've made any code changes you must write a summary of the changes made to the TODO file
- highlight explicitly if you changed app behavior in response to test failures or if you changed the tests to reflect the new app behavior
- the audience for this summary is an engineer who will need to review it to confirm the changes were good changes.