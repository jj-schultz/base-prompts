When the todo starts with `$GAP-IMPL`, first perform a `$GAP` analysis and then execute `$GAP-CLOSE` in the same run.

Required workflow:

1. First execute the full gap-analysis workflow in [skill--gap_analysis.md](skill--gap_analysis.md).
2. If the gap analysis finds no functionality gap, append the required implementation overview to `todo.md` and stop without making code changes.
3. If the gap analysis finds a gap, append the gap-analysis plan to `todo.md`.
4. In the same run, immediately treat the newly written gap analysis as the input to [skill--gap_close.md](skill--gap_close.md).
5. Implement only the desired functionality and the gap-analysis plan you just produced.
6. Write or update automated tests that assert the implemented behavior.

Required rules:

- Do not require the user to rewrite the todo from `$GAP-IMPL` to `$GAP-CLOSE`.
- Reuse existing code and utilities before adding new helpers.
- Do not fix or add anything outside the desired functionality and the generated gap-analysis plan.
