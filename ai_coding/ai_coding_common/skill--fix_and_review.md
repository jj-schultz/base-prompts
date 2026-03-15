The text after the `$FIX_AND_REVIEW` skill is a request to repeatedly review the current uncommitted changes, fix only the review findings that matter most, and stop once no `HIGH PRIORITY` or `MUST FIX` issues remain.

# Required Workflow
1. Inspect the active `todo.md` content before the loop begins.
2. If the `todo.md` contains instructions that describe work to do or something to fix, run `$FIX` on those instructions before the first review pass.
3. If the `todo.md` does not contain instructions that describe work to do or something to fix, skip the initial `$FIX` step and start with the review pass.
4. Fetch and review the current uncommitted changes using the same workflow and standards as `$REVIEW`:
   - follow [instructions--fetch_uncomitted_changes.md](instructions--fetch_uncomitted_changes.md)
   - evaluate the changes using [instructions--code_review.md](instructions--code_review.md)
5. Store the current loop's review output in the active `todo.md` file under this heading:
   - `## FIX_AND_REVIEW Review`
6. Before appending the new review output, remove the entire previous `## FIX_AND_REVIEW Review` section if it exists so the current review fully overwrites the prior loop's review results.
7. Inside `## FIX_AND_REVIEW Review`, use the exact review output format required by [instructions--code_review.md](instructions--code_review.md).
8. After the review is written, inspect only the current `## FIX_AND_REVIEW Review` section.
9. If that section contains no `PRIORITY: MUST FIX` or `PRIORITY: HIGH PRIORITY` findings, stop looping.
10. If that section contains one or more `PRIORITY: MUST FIX` or `PRIORITY: HIGH PRIORITY` findings, run `$FIX` on only those findings.
11. After the fixes are implemented, loop back to step 4 and repeat until the stop condition in step 9 is true.

# Hard Constraints
- The initial `$FIX` step is conditional and runs only once before the first review pass.
- Do not keep stale review results from earlier loop iterations.
- Do not fix `NICE TO HAVE` or `LOW PRIORITY` findings as part of this loop unless the user explicitly asks for them.
- Each review pass must reevaluate the latest uncommitted state before deciding whether more fixes are required.
- When executing the fix step, follow all implementation requirements that apply to `$FIX` / `$IMPL`, including [instructions--coding_principles.md](../../../.ai_coding/ai_coding_common/instructions--coding_principles.md).
