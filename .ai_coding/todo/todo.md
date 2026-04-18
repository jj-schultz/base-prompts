$SKILL_WRITER

modify the $LINEAR_IMPL skill such that it does not create a worktree for each task.  it should do all work in the current code director with the feature branch created as currently defined in the skill

the issue I'm having is the skill is creating a worktree for each ticket in the linear project when I tell it to do a whole project

## files touched

- `.ai_coding/ai_coding_common/skill--linear_impl.md` - lines 5-50: rewrote `$LINEAR_IMPL` to choose one run branch in the current code directory, keep multi-issue work on that same checkout, and block cross-repo work instead of creating worktrees or extra checkouts.
- `.ai_coding/history.md` - lines 1-6: prepended the required run summary and next-step note for this `$SKILL_WRITER` run.
- `.ai_coding/todo/todo.md` - lines 7-11: appended this required files-touched summary.
