# REQUIRED CHECK LIST 
On every excecution, **you must** make and use an internal checklist with the following items.  Verify your internal every item in your internal checklist is completed on every run.
1. when you complete an item in this `todo.md` file's list, do not delete it- rather indicate it is complete with a checkmark emoji). 
2. When finished with all of the TODO items in this `todo.md` file, **always** append a section to this `todo.md` file that lists the files touched and a summary (including line number range) of the changes to the file. Do NOT write the summary in the conversation output - it must be appended to this `todo.md` file itself.  **never forget to do this***
3. If you create new files or move files, **you must** `git add` (or similar) and add them to the default changelist
4. Unless you are specifically asked to run tests, **never** attempt to run tests and do not announce that you are not running tests
5. When you are finished updating this file with the summary of changes follow the follwoing `Notification Protocol` **exactly**

## Required Notification Protocol
When you are finished updating this `todo.md` file with the summary of changes and performing any/all of your validations
1. Identify if you are claude or codex.  Rember this value as `agent_service`
2. Identify the project root directory.  This should be the name of the directory you were started in, or another way to find it is it is the directory two ".."'s above the directory containing this `todo.md` file.  store this value as `project_name`
3. Identify a single sentence summary of the work you did for the `todo.md` file.  Rember this value as `summary`
4. Execute the script `./.ai_coding/common/notify_done.sh "${agent_service}" "${project_name}" "${summary}"`

---

# KEYWORDS - **required rules**
If the a TODO starts with one of the following keywords, **you must** following the related instuctions **exactly**:
- `#IMPL`: implement the code change described.  Review the `Staff-Level Execution Principles` and make an internal checklist to make sure you follow them
- `#ITERATE`: implement the code change described.  Review the `Staff-Level Execution Principles` and make an internal checklist to make sure you follow them.  Once you've finished, run the appropriate automated tests or command.  If the tests or command fails, implement the fix and run again.  repeat until it succeeds.  If you are blocked and need human input, stop iterating and append the help needed to the end of the todo.md file
- `#QUESTION`: **never** change any other file other than this `todo.md` file.  interpret the text following the `#QUESTION` keyword as a question and **you must** append the answer to this `todo.md` file
- `#THEORIES`: **never** change any other file other than this `todo.md` file.  interpret the text following the `#THEORIES` keyword as a problem situation.  Come up with at least 2 or more theories as to what is going wrong and append the theories (with a probability assessment) to this `todo.md` file
- `#THEORY`: **never** change any other file other than this `todo.md` file.  interpret the text following the `#THEORY` keyword as a problem situation.  Come up with the **most probably** theory as to what is going wrong and append the theory to this `todo.md` file
- `#REVIEW`: **never** change any other file other than this `todo.md` file.  review the code in the files defined in the text following the `#REVIEW` - do a code review looking for bugs, any potential problems, call out any inconsistencies.  Format the review results for optimal human comprehensionl.  **you must** append the review results to this `todo.md` file
- `#PLAN`: **never** change any other file other than this `todo.md` file.  Create a step by step plan for implementing whatever is the text following the `#PLAN` keyword
- `#DOC`: Create new document in `./doc**s`.  Produce the requested documenation in the new document.  use markdown syntax unless otherwise specified

---

# Staff-Level Execution Principles 
1. **Own the Work** — Approach every task with full ownership. Clarify ambiguity early, document tradeoffs, and favor reusable, maintainable solutions.  
2. **Engineer with Craft** — Write clean, factored, and documented code. Explain your reasoning and leave each surface better than you found it.  
3. **Prioritize Quality** — Correctness, observability, and testability come first. Never compromise these standards for speed.  
4. **Log Exceptions Properly** — Never suppress errors. Always use `logging.exception(<exception>)` when catching exceptions.  
5. **Trust Types** — Avoid `getattr(...)` when the attribute is guaranteed to exist.  
6. **Show Progress** — Use `tqdm` for any long-running loops or operations.  
7. **Follow JS Conventions** — Use jQuery and Backbone.js. Avoid inline `<script>` tags except when initializing Backbone views.  
8. **Simplify UI Flow** — Prefer full-page reloads and Backbone-based views. Avoid background polling.  
9. **Fail Fast** — Let code fail visibly instead of swallowing errors. Don’t wrap or log exceptions unnecessarily.  
10. **Be Deliberate** — Think deeply before acting. Use checklists and reason thoroughly.  
11. **Anti-Laziness Directive** — Never settle for plausible answers. Explore alternatives, test assumptions, and verify before concluding. When details are missing, make explicit assumptions and mark unresolved areas clearly. Work the problem until it’s either solved or transparently bounded.
12. **Git Hygiene** — If you create new files or move files, **you must** `git add` (or similar) and add them to the default changelist
13. **Limit Code Sprawl** — Code sprawl must be avoided.  Look to reuse code, modules, files.  In general, t is better to update existing code than it is to write new code

**Purpose:** These rules define the minimum professional standard for Codex agents. They ensure rigor, reproducibility, and deep reasoning across all execution paths.

---

# Documentation Style
- **Answer all AWS related questions as if I'm an AWS noob**  Assume I am a beginner in AWS Console usage / AWS Api usage (especially anything that relates to AWS roles and permissions).  You will need to lean into the "why" for your answers to help me build my mental model.  Do not self narrate or mention that this is noob format
- **Favor brevity for precision**. Every extra word risks dilution of meaning. Use the fewest words necessary to convey the full intent.

---

# Forbidden Actions
- **never** run a database migration.  These are to be manual operations 
- **never** execute a git commit or a git push
- **never** modify files unrelated to the current task.  If you need to read other files for context, do not edit them
- **never** reformat files unless explicitly asked