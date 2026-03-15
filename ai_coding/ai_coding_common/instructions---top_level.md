# Instruction Precedence
In the event of conflicting instructions, the following precedence order applies (highest first):
1. Forbidden Actions
2. Skill-specific rules
3. Notification Protocol
4. Spec, Architecture and UI Specification Compliance
5. Mandatory Pre-Implementation Checks
6. REQUIRED CHECK LIST
7. All rules defined in [instructions--coding_principles.md](instructions--coding_principles.md)
8. Documentation Style and Voice rules


# Forbidden Actions
Any rule using the word "never" elsewhere in this document is subsumed by this section unless explicitly scoped otherwise.
- **never** run a database migration.  These are to be manual operations 
- **never** execute a git commit or a git push
- **never** modify files unrelated to the current task.  If you need to read other files for context, do not edit them
- **never** reformat files unless explicitly asked
- **never** delete the todo.md file
- **never** use <object>.hasattr() when there a reasonable probability the <object> has the field.  Be optimistic here 
- **never** run the `black` code formatter (or any code formatter) over unmodified lines of code unless explicitly instructed to do so 
- **never** forget to execute the notification script `./.ai_coding/ai_coding_common/notify_done.sh ...` when done
- **never** expose sequential numeric ids in a URL.  Strongly perfer UUID4 for IDs
- **never** edit files in the python virtual env or npm packages.  only edit the source code for the project
- **never** narrate iteration history, change logs, diffs, rationales, or evolution of code, plans, or documents unless the user explicitly requests history, comparison, rationale, or a diff. Default behavior is final-state output only.


# Skill-specific rules **REQUIRED** 
- If a line of text in the todo file starts with the character `$`, this signals that it might be a skill command.  
- If you encounter a line that starts with $, inspect the file [instructions--skills.md](instructions--skills.md) for required guidance on how to proceed.  
- If there is no skill command in the todo file, **you must** assume the skill command is `$IMPL`

## Mandatory Skill Dispatch
- Before planning, analysis, or file edits, read the first non-empty line of the todo file.
- If that line starts with `$`, that skill is the active instruction set and it overrides generic wording such as "do the TODO items".
- You must resolve the active skill through [instructions--skills.md](instructions--skills.md) before taking any further action.
- Example: if the todo starts with `$GAP`, the correct behavior is gap analysis only. You must not implement code changes unless the todo explicitly switches to an implementation skill.


# Notification Protocol
When you are finished updating this `todo.md` file with the summary of changes and performing any/all of your validations
1. Identify if you are claude or codex.  Rember this value as `agent_service`
2. Identify the project root directory.  This should be the name of the directory you were started in, or another way to find it is it is the directory two ".."'s above the directory containing this `todo.md` file.  store this value as `project_name`
3. Identify a single sentence summary of the work you did for the `todo.md` file.  Rember this value as `summary`
4. Execute the script `./.ai_coding/ai_coding_common/notify_done.sh "${agent_service}" "${project_name}" "${summary}"`

If direct script execution is not possible, output the exact command that would have been executed instead.


# Spec, Architecture and UI Specification Compliance
- If the `goal.md` exists in the same directory as the todo file, this file represents the goal of the current phrase of work. When understanding test failures or planning what work to do or if you have questions about what's the higher level goal, reference this file.  All work you do must be in support of this goal
- If the file `<project_root>/docs/spec.md` exists, this file represents the canonical specification for the requirements.  Your work must comport to this spec.  Refer to it as you build to make sure your work is aligned with the spec
- If the director [screenshots](<project_root>/docs/screenshots) exists, this folder contains screenshots of the desired functionality.  All UI work must comport to these screenshots
- If the file `<project_root>/docs/architecture.md` exists, all code, refactors, and implementations **must** strictly conform to the architecture described in that document. Before planning or writing any code, you must check for the existence of this file and consult its contents. All implementation plans must explicitly align with the defined architecture.
- If the file `<project_root>/docs/ui_spec.md` exists, all UI-related code, including HTML, CSS, JS, and interactive behaviors, **must** strictly follow the UI style, rules, and patterns defined in that document. you must check for the existence of this file before performing any UI‑related task and enforce compliance.
If these files do not exist, proceed without creating them unless explicitly requested.



# Mandatory Pre-Implementation Checklist
- On every execution, **you must** make and use an internal checklist with all of the items from the "REQUIRED CHECK LIST" section.  
- Verify your internal every item in this internal checklist is completed on every run.


# REQUIRED CHECK LIST 
1. when you complete an item in this `todo.md` file's list, do not delete it- rather indicate it is complete with a checkmark emoji). 
2. When finished with all of the TODO items in this `todo.md` file, **always** append a section to this `todo.md` file that lists the files touched and a summary (including line number range) of the changes to the file. Do NOT write the summary in the conversation output - it must be appended to the `todo.md` file itself.  **never forget to do this***
3. If you create new files or move files, **you must** `git add` (or similar) and add them to the default changelist
4. Unless you are specifically asked to run tests, **never** attempt to run tests and do not announce that you are not running tests
5. Prepend to the top of the file `.ai_coding/history.md` a single line summary describing the the skill reqested (if avail) and what you did and the suggested next step (code review, run tests, commit, etc) with short justification
```markdown
# <TIMESTAMP in YYYY-MM-DD HH:MM:SS format>
<single line summary describing the the skill reqested (if avail) and what you did in the format>

<suggested next step>

<some nice spacing for readability>
```
6. When you are finished updating this file with the summary of changes follow the following `Notification Protocol` **exactly**


# Documentation Style and Voice rules

## My Voice or Voice requests
When writing in "My Voice", **you must** use the style guide located at `./.ai_coding/ai_coding_common/jj-writing-voice.md`

## Documentation Style
- **Answer all AWS related questions as if I'm an AWS noob**  Assume I am a beginner in AWS Console usage / AWS Api usage (especially anything that relates to AWS roles and permissions).  You will need to lean into the "why" for your answers to help me build my mental model.  Do not self narrate or mention that this is noob format
- **Favor brevity for precision**. Every extra word risks dilution of meaning. Use the fewest words necessary to convey the full intent.

# Other Rules

## File Name Handling
- a dot-forward-slash (`./`) always refers to the project root directory, ie parent directory of `./.ai_coding`
- an ampersand (`@`) prepending a word means the word ins the name of a file and file lives in the same directory as the `todo.md` file.  for example `@output.log` would refer to the file named `output.log` in the same directory as the `todo.md`
