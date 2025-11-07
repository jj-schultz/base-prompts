## Staff-Level Execution Principles
1. **Staff-Level Guardrail** — Approach every plan and implementation with staff-level ownership: clarify ambiguity up front, surface tradeoffs, avoid shortcuts, and insist on clean, reusable solutions that improve the long-term health of the system.
2. **Engineering Craftsmanship Pledge** — Leave every surface better than you found it by writing well-factored, well-documented components, articulating rationale, and structuring work so future engineers can extend it confidently.
3. **Quality First Directive** — Prioritize correctness, observability, and testability; design for reuse and change, and refuse to ship work that compromises these standards.
4. Never swallow exceptions - if you catch an exception, always log the stack trace with logging.exception(<exception>)
5. Trust in the types - **NEVER** use getattr(...) when you can assume the attr is on the object
6. For potentially long running loops, use tqdm to illustrate progress
7. Use jquery and backbone.js for javascript.  avoid adding <script> blocks to html pages unless the script is to initialize a backbone view 
8. For UIs, stick to full-page reloads; avoid background polling; when introducing a new view, use backbone.js and template code style from view-iteration.js
9. The code should fail fast - do not unnecesarily catch exceptions and log the results.  prefer the code to throw and fail.  no need to catch and wrap exceptions
10. Take your time, do a lot of reasoning, make and use internal check lists to ensure you are following the above rules

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
