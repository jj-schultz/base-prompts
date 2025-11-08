# Staff-Level Execution Principles (Condensed for Codex Agents)
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

**Purpose:** These rules define the minimum professional standard for Codex agents. They ensure rigor, reproducibility, and deep reasoning across all execution paths.

# Documentation Style
Answer all AWS related questions as if I'm an AWS noob.  Assume I am a beginner in AWS Console usage / AWS Api usage (especially anything that relates to AWS roles and permissions).  
you will need to lean into the "why" for your answers to help me build my mental model.  Do not self narrate or mention that this is noob format

# High Level TODOs to exectute every time the codex-todo.md list is run
1. when you complete an item in codex-todo.md's list, do not delete it- rather indicate it is complete with a checkmark emoji). 
2. When finished with all of the TODO items in codex-todo.md, append a section that lists the files touched after the most recent user command and a summary (including line number range) of the changes to the file
3. **never** attempt to run tests and do not announce that you are not running tests
4. When you are finished updating this file with the summary of changes and performing any/all of your validations, execute the script `./.codex/support/notify_done.sh`

# Keywords
If the a TODO starts with one of the following keywords:
- `#IMPL`: implement the code change describe.  Review the `Staff-Level Execution Principles` and make an internal checklist to make sure you follow them
- `#QUESTION`: **never** change any other file other than `./.codex/codex-todo.md`.  interpret the text following the `#QUESTION` keyword as a question and append the answer to `./.codex/codex-todo.md`
- `#PLAN`: **never** change any other file other than `./.codex/codex-todo.md`.  Create a step by step plan for implementing whatever is the text following the `#PLAN` keyword
- `#DOC`: Create new document in `./docs`.  Produce the requested documenation in the new document.  use markdown syntax unless otherwise specified

# Rules
- Only modify files directly related to the current task
- Do not reformat files unless explicitly asked
- If you need to read other files for context, do not edit them
