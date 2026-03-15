# KEYWORDS - **required rules**.  (if a sentence starts with the char `$` that's an indicator it references one of the following keywords)

If the a TODO starts with one of the following keywords, **you must** following the related instuctions **exactly**:
- `$IMPL`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--impl.md](keyword--impl.md)`
- `$IMPL-ERR`: review the file `err.log` (lives in same directory as the `todo.md`).  This file contains an error message.  Understand the error and then execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--impl.md](keyword--impl.md)`
- `$QAPLAN`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--qa_plan.md](keyword--qa_plan.md)`
- `$TESTS`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--tests.md](keyword--tests.md)`
- `$RELEASE_NOTES`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--release_notes.md](keyword--release_notes.md)`
- `$RELEASE_NOTES_PROD`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--release_notes_prod.md](keyword--release_notes_prod.md)`
- `$REVIEW`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--code_review.md](keyword--code_review.md)`
- `$REVIEW-FIX`: The text after the `$REVIEW-FIX` keyword is the results of code review.  The code review analyis describes fixes that need to be implemented.  Implement the code fixes described.  When implementing both the fixes , follow all principles in [instructions--coding_principles.md](../../../.ai_coding/ai_coding_common/instructions--coding_principles.md)
- `$BRANCH_REVIEW`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--branch_review.md](keyword--branch_review.md)`
- `$PR_REVIEW`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--pr_review.md](keyword--pr_review.md)`
- `$ONE_PAGER`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword-one_pager.md](keyword-one_pager.md)`
- `$PROD_MERGE_REVIEW`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--product_merge_review.md](keyword--product_merge_review.md)`
- `$TASKS`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--task_breakdown.md](keyword--task_breakdown.md)`
- `$GAMEPLAN`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--branch_review.md](keyword--branch_review.md)`
- `$GAP`:  The text after the `$GAP` keyword describes a piece of functionality.  When you get this keyword, review the curent state of the code and identify if code currently support the functionality.  If it does, append to the todo a high level overview of the implementation and the significant related files.  If the code does not, identify the cap between the current code functionality and the desired functionality and append to the todo.md file a high-level description of the work to close the gap
- `$GAP-CLOSE`:  The text after the `$GAP-CLOSE` keyword is a gap-analyisis.  The gap analyis describes the work that needs to be done to close the gab.  Implement the code change described.  Write automated tests that assert the new functionalities behavior.  When implementing both the gap closing code changes and automated tests, follow all principles in [instructions--coding_principles.md](../../../.ai_coding/ai_coding_common/instructions--coding_principles.md)
- `$REFACTOR`: implement the code refactor described.  The change must be 'functionality neutral'.  Make a checklist as you do your work to make sure the change is functionality neutral
- `$ITERATE`: implement the code change described.  Once you've finished, run the appropriate automated tests or command.  If the tests or command fails, implement the fix and run again.  repeat until it succeeds.  If you are blocked and need human input, stop iterating and append the help needed to the end of the todo.md file.  After every iteration **you must** append to the todo.md file a description of what you changed and your evaluation of how the changes performed
- `$QUESTION`: interpret the text following the `$QUESTION` keyword as a question and provide an answer.  In your answer, be 100% bluntly truthful with no fluff, but don't feel you have to go out of your way to be critical (accuracy, positive or negative, is the **ultimate** objective).  If multiple ansers for multiple risk appetites make sense, provide the multiple answers that (only do this if it makes obvious sense).  Format the evaluation results for optimal human comprehension.  If you find problems, suggest a realistic solution.  Take your time to give the best possible answer.  What out for cases where you suggest a change, and then on subsequent $EVAL of your suggestion your evaluation is critical of your own initial answer (this has been happening and it feels like you are being critical just to be critical.  don't do that)
- `$DEBUG`: interpret the text following the `$DEBUG` keyword as a problem situation.  Provide **clear manual debuggin steps**.  The debugging steps must work towards the goal of helping a human figure out what the problem is.  The audience is a human operator
- `$THEORIES`: interpret the text following the `$THEORIES` keyword as a problem situation. Come up with at least 2 or more theories as to what is going wrong and append the theories (with a probability assessment) to this `todo.md` file
- `$THEORY`: interpret the text following the `$THEORY` keyword as a problem situation. Come up with the **most probably** theory as to what is going wrong
- `$EVAL`: review the text following the `$EVAL` keyword.  If the text refers to a file, read the file as the text input.  Provide an evaluation of the idea or text.  Be 100% bluntly truthful with no fluff, but don't feel you have to go out of your way to be critical (accuracy, positive or negative, is the **ultimate** objective).  If multiple evaluations for multiple risk appetites make sense, do that  Format the evaluation results for optimal human comprehension.  If you find problems, suggest a realistic solution.  Take your time to give the best possible answer.  What out for cases where you suggest a change, and then on subsequent $EVAL of your suggestion your evaluation is critical of your own initial suggestion (this has been happening and it feels like you are being critical just to be critical.  don't do that)
- `$PLAN`: Create a step by step plan that codex or claude code will follow to implement whatever is the text following the `$PLAN` keyword.  Before you identify the plan, research the existing codebase to see what methods might be reusable (small backwards compatible modifications are ok) - look to reuse as much existing code as possible.  Take as much time as you need - the more reasoning the better.  The plan must be accurate and detailed enough LLM to use in a vaccuum and autonomously.  Optimize for LLM comprension and execution.  Take your time here
- `$DOC`: Create new document in `./doc**s`.  Produce the requested documenation in the new document.  use markdown syntax unless otherwise specified
- `$E2E_TESTS`: execute **all** of the instructions in `./.ai_coding/ai_coding_common/[keyword--e2e_tests.md](keyword--e2e_tests.md)`

## KEYWORDS: Allowed Scope
if the keyword is one of [ `$QUESTION`, `$DEBUG`, `$THEORIES`, `$GAP`, `$THEORY`, `$REVIEW`, `$EVAL`, `$PLAN`, `$TASKS`, `$$BRANCH_REVIEW`, `$PR_REVIEW`],
- **never** change any other file other than this todo file  
- **never** provide time to implement estimates - time estimates are not of use 
- **you must** append the response to the todo file unless the user specifically asks for a separate file  
For non-mutating keywords, the required "files touched" summary must explicitly state that no files were modified.

## KEYWORDS: Mandatory Pre-Implementation Checks
If the keyword is one of [`$IMPL`, `$IMPL-ERR`, `$GAP-CLOSE`, `$REFACTOR`, `$ITERATE`, `$E2E_TESTS`]
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

