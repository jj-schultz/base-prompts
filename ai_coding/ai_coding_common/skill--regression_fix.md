Treat the todo body as a report that the current branch regressed from the `production` behavior.

When the todo starts with `$REGRESSION_FIX`, first confirm the regression against `production`, then fix it in the same run.

Required workflow:

1. Identify the affected repositories from the todo text. If the repo is not explicit, inspect the immediate child git repos and narrow the work to the repos that own the described behavior.
2. For each affected repo, resolve the `production` branch from `production` or `origin/production`. If no `production` ref exists, append that fact to `todo.md` and continue with the remaining repos.
3. Read the relevant `production` code and inspect the current-branch diff for the affected paths so you understand what behavior changed. Review actual code diffs, not only commit messages.
4. Identify the most likely regressing commit on the relevant paths between `production` and the current branch. If multiple commits are required to explain the regression, document the smallest justified set. If the behavior is not a regression, say so explicitly in `todo.md`.
5. Before implementation, append a `## Regression Analysis` section to `todo.md` that includes the affected repo or repos, whether the regression is confirmed, the likely regressing commit hash or hashes when identifiable, and the exact production behavior to restore.
6. After the regression analysis, execute the implementation workflow in [skill--gap_impl.md](skill--gap_impl.md).
7. Fix only the confirmed regression and the behavior required to match `production`.
8. Write or update automated tests that cover the restored behavior.

Required rules:

- Compare the current branch against `production`, not only against the todo wording.
- Reuse existing code and utilities before adding new helpers.
- If the analysis shows the current behavior is not a regression, note that in `todo.md` and continue as a normal fix only if the todo still describes a real defect.
- If no affected repo has a `production` branch, record that blocker in `todo.md` and continue with the best local evidence available.
