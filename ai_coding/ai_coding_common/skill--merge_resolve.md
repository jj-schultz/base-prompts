When the todo starts with `$MERGE_RESOLVE`, resolve unresolved merge markers in uncommitted files.

Required behavior:

0.  Take your time with this task.  Use a lot of reasoning.  Accuracy is much more important than spead or low token cost.  Accuracy is PARAMOUNT

1. Read all todo guidance first.

2. Detect conflict source:
   - Check for `.git/MERGE_HEAD` (merge), `.git/rebase-merge/` (rebase), or `.git/CHERRY_PICK_HEAD` (cherry-pick).
   - Adapt strategy: rebase conflicts are sequential per commit; merge conflicts are holistic.

3. Acquire context before editing any file:
   - For merges: run `git log --oneline HEAD..MERGE_HEAD` and `git log --oneline MERGE_HEAD..HEAD` to understand both sides. If MERGE_HEAD contains multiple refs (octopus merge), log each ref separately.
   - For rebases: read `.git/rebase-merge/message` and inspect the current patch with `git diff`.
   - For cherry-picks: run `git log -1 CHERRY_PICK_HEAD`.
   - Read commit messages from both sides before resolving any conflict.

4. Identify all conflicted files using both methods and union the results:
   - `git diff --name-only --diff-filter=U`
   - `git ls-files -u | awk '{print $4}' | sort -u`
   This catches unmerged files, delete/modify conflicts, and add/add conflicts.
   - If the workspace contains nested git repos or IDE VCS mappings (for example separate `backend/` and `frontend/` roots), repeat these commands inside each git root and union those results too. Do not assume the top-level cwd is the only git index that matters.

5. Resolve conflicts in dependency order: shared libraries and utilities first, then consumers.

6. For each conflicted file, understand the surrounding module behavior before editing. Then resolve deterministically:
   - Decide what code to keep from each side based on branch intent.
   - Preserve required imports, symbols, and call sites.
   - Remove all merge markers (`<<<<<<<`, `=======`, `>>>>>>>`).
   - Prefer existing utilities and project patterns; do not introduce duplicate helpers.
   - Keep the change set as small as possible while producing working code.

7. Handle special file types:
   - Binary file conflicts: accept incoming or current version based on branch intent; do not attempt manual merge.
   - Generated files (lock files, build artifacts): regenerate rather than merge when possible.
   - Files added only by the incoming branch with no conflict markers: stage directly with `git add`.
   - Files where both branches created the same path: treat as a conflict and resolve normally.
   - Delete/modify conflicts: if the branch intent is to delete the file, run `git rm <file>`; if the intent is to keep it, resolve and stage.

8. Validate no remaining merge markers:
   - Run `git ls-files -u | awk '{print $4}' | sort -u | xargs grep -l '<<<<<<<'` to check exactly the files git knows were conflicted.
   - Run `git diff --check` to catch remaining markers and whitespace errors.
   - Also verify there are no remaining unmerged index entries in every relevant git root, even if file contents no longer contain markers. A clean file with `UU`, `AA`, `DU`, or `UA` status is still unresolved and IDEs like PyCharm will continue to report merge conflicts until it is staged or removed appropriately.

9. Stage resolved files with `git add <file>`. Do NOT commit or continue the merge/rebase automatically 
   - This includes files whose content is already resolved but whose git index still shows them as unmerged.
   - For delete/modify or rename/remove outcomes, use `git rm <file>` when the branch intent is deletion, then re-check `git ls-files -u`.

10. Run post-stage validation:
    - If a project lint, typecheck, or build command is identifiable (Makefile, package.json scripts, pyproject.toml), run it against staged files.
    - If validation fails due to the merge resolution, fix the issue before proceeding.

11. If any conflict cannot be resolved confidently, append follow-up notes to `todo.md` with:
    - File path.
    - Unresolved context (both sides of the conflict).
    - Why it is uncertain.
    - Exact human input needed to finish the merge.
