Review the code changes with a strict data-loss and destructive-change focus.

Required steps:

# First: Fetch the code changes
- If the text following the `$DATA_LOSS_CHECK` skill specifies how to get the diff, use that diff as the review input.
- Otherwise follow instructions here: [instructions--fetch_uncomitted_changes.md](instructions--fetch_uncomitted_changes.md)

# Then: Understand the data lifecycle
Before identifying issues, inspect the surrounding code, impacted write paths, deletions, migrations, backfills, cleanup jobs, and rollback behavior so you understand how existing data is created, updated, preserved, and removed.

# Then: perform the review
Follow all of the instructions in [instructions--code_review.md](instructions--code_review.md)

# Data loss review emphasis
- Spend the majority of the review on irreversible, silent, or hard-to-recover data loss risks in the diff
- Read unchanged supporting code whenever needed to verify persistence behavior instead of guessing
- Review schema changes, migrations, backfills, cleanup jobs, model hooks, delete paths, cascading relationships, import/export flows, and rollback logic
- Look hard for DROP/TRUNCATE/DELETE operations, broad predicates, destructive renames, type narrowing, lossy transforms, removed columns still read by live code, NOT NULL or unique constraints added before cleanup/backfill, orphaning or cascade-delete risks, and multi-step writes that can partially commit
- Treat database migrations and production rollout sequencing as first-class review targets; the old code must keep working until the new code is fully deployed
- Flag any path that overwrites source data before validation, removes the only copy of data, or lacks a safe rollback story as MUST FIX
- Do not dilute the review with style feedback unless it creates a real data safety risk
- Take as much time as needed.  Accuracy matters more than speed
- It's ok to find no issues if the risk is suitably low.  If no issues are found, append `No data loss risks identified.`
