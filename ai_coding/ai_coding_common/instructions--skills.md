# SKILLS - **required rules**.  (if a sentence starts with the char `$` that's an indicator it references one of the following skills)

If a TODO starts with one of the following skills, **you must** follow the related instructions exactly.

## Mandatory Dispatch Algorithm
1. Read the first non-empty line of the todo file before planning, analysis, or edits.
2. If that line starts with `$`, that exact skill is active and overrides generic requests such as "do the TODO items".
3. Resolve the active skill before taking any other action.
4. Apply the skill's allowed scope before editing files.
5. Only if no line starts with `$`, default to `$IMPL`.
6. If the active skill is non-mutating, only edit the todo file.

## File-backed skills
All skills in this section point to an instructions file. Execute that file exactly.
Base directory for relative instruction paths: `./.ai_coding/ai_coding_common/`

- `$BRANCH_REVIEW`: `skill--branch_review.md`
- `$COMMIT_MSG`: `skill--commit_msg.md`
- `$DEBUG`: `skill--debug.md`
- `$DOC`: `skill--doc.md`
- `$TEACH`: `skill--teach.md`
- `$E2E_TESTS`: `skill--e2e_tests.md`
- `$ESTIMATE`: `skill--estimate.md`
- `$EVAL`: `skill--eval.md`
- `$FIX`: `skill--fix.md`
- `$FIX_AND_REVIEW`: `skill--fix_and_review.md`
- `$FIX_TESTS`: `skill--fix_tests.md`
- `$GAMEPLAN`: `skill--branch_review.md`
- `$GAP-CLOSE`: `skill--gap_close.md`
- `$GAP`: `skill--gap_analysis.md` (analysis only; never implement)
- `$IMPL-ERR`: `skill--impl_err.md`
- `$IMPL`: `skill--impl.md`
- `$ITERATE`: `skill--iterate.md`
- `$LOOP`: `skill--loop.md`
- `$MERGE_RESOLVE`: `skill--merge_resolve.md`
- `$ONESHOT`: `skill--oneshot.md`
- `$PERFORMANCE_CHECK`: `skill--performance_check.md`
- `$PLAN`: `skill--plan.md`
- `$PROD_MERGE_REVIEW`: `skill--product_merge_review.md`
- `$PR_REVIEW`: `skill--pr_review.md`
- `$QAPLAN`: `skill--qa_plan.md`
- `$QUESTION`: `skill--question.md`
- `$REFACTOR`: `skill--refactor.md`
- `$REGRESSION_CHECK`: `skill--regression_check.md`
- `$RELEASE_NOTES_PROD`: `skill--release_notes_prod.md`
- `$RELEASE_NOTES`: `skill--release_notes.md`
- `$REPRODUCE`: `skill--reproduce.md`
- `$RETRO`: `skill--retro.md`
- `$REVIEW-FIX`: `skill--review_fix.md`
- `$REVIEW`: `skill--code_review.md`
- `$SIMPLIFY`: `skill--simplify.md`
- `$STATUS`: `skill--status.md`
- `$TASKS`: `skill--task_breakdown.md`
- `$TESTS`: `skill--tests.md`
- `$THEORIES`: `skill--theories.md`
- `$THEORY`: `skill--theory.md`

## SKILLS: Allowed Scope
if the skill is one of [ `$QUESTION`, `$DEBUG`, `$THEORIES`, `$GAP`, `$THEORY`, `$REVIEW`, `$REGRESSION_CHECK`, `$PERFORMANCE_CHECK`, `$EVAL`, `$PLAN`, `$TASKS`, `$STATUS`, `$$BRANCH_REVIEW`, `$PR_REVIEW`, `$COMMIT_MSG`, `$CURRICULUM`, `$SIMPLIFY`],
- **never** change any other file other than this todo file  
- **never** provide time to implement estimates - time estimates are not of use 
- **you must** append the response to the todo file unless the user specifically asks for a separate file  
For non-mutating skills, the required "files touched" summary must explicitly state that no files were modified.

### `$TAKEHOME_REVIEW` Mutating Scope Exception
- `$TAKEHOME_REVIEW` is explicitly allowed to create or update the project-root file `./eval_startup_script.sh`.
- For `$TAKEHOME_REVIEW`, updating `todo.md` plus `eval_startup_script.sh` is the required default behavior unless the user explicitly says otherwise.

## SKILLS: Mandatory Pre-Implementation Checks
If the skill is one of [`$IMPL`, `$IMPL-ERR`, `$FIX_AND_REVIEW`, `$FIX_TESTS`, `$GAP-CLOSE`, `$REFACTOR`, `$ITERATE`, `$E2E_TESTS`, `$MERGE_RESOLVE`, `$ONESHOT`]
- **REQUIRED** Before you implement any code changes, review the [instructions--coding_principles.md](instructions--coding_principles.md)  make an internal checklist to make sure you follow them  
- Before you implement any code changes, **you must** research the existing codebase to see what methods might be reusable (small backwards compatible modifications are ok) - look to reuse as much existing code as possible
- **Code Organization Check** - Before adding any new function or method:
  1. **Identify if the function is general-purpose**: Does it perform a utility operation (date formatting, string manipulation, HTML escaping, validation, etc.) that could be useful beyond the current module?
  2. **Check common/utility modules first**: Search for similar functionality in files like `*.js`, `common.py`, utility modules, or shared libraries. If found, use the existing function.
  3. **Place general-purpose code in common modules**: If the function is general-purpose and doesn't exist, add it to the appropriate common/utility module (e.g., `*-common.js` for JavaScript utilities, shared Python modules for backend). Do NOT add general-purpose functions as methods in specific classes or modules.
  4. **Keep module-specific code focused**: Only add methods/functions to a specific module if they are tightly coupled to that module's domain logic and unlikely to be reused elsewhere.
  5. **Example violations to avoid**:
     - Adding `escapeHtml()` in a specific component when it already exists in utilities
     - Adding generic validation functions in a domain-specific class
- Take as much time as you need - the more reasoning the better.  
