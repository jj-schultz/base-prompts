
Perform a thorough retrospective on the issue.

Required process:
1. Identify the issue source in this order:
   - If a PR is supplied, review the PR description and code changes.
   - Else if an issue description is supplied in `todo.md`, use that issue.
   - Else review uncommitted code changes to infer the issue context.
2. Use git history to identify when the issue was introduced:
   - Use `git log`, `git blame`, and targeted diffs to find the introducing commit(s).
   - Record concrete commit hashes and dates for the likely introduction point.
3. Go beyond the immediate fix and explain root cause:
   - State the technical failure mechanism.
   - State why the change passed initially (process, missing guardrails, test gap, assumption, or review gap).
   - State why it was detected late or only after impact.
4. Produce a retrospective that includes:
   - Symptom and impact summary.
   - Timeline with concrete dates/commits.
   - Root cause analysis (deeper than patch-level behavior).
   - What was fixed.
   - Preventative follow-up actions (tests, instrumentation, checks, ownership, process updates).

# Output rules (Required):
- the 'Issue evidence' must be text only description.  if an image is part of the bug report, do your best to describe the contents of the image.  if the image is of text, just summarize the text from the image
- Be specific and evidence-based.
- Reference exact files/commits when possible.
- Avoid vague conclusions and generic action items.
- Place the retro in the ./docs folder
- Do not say the work "blame" in the report
- If the document references a git commit, **you must** provide an href link to the commit on github.com
