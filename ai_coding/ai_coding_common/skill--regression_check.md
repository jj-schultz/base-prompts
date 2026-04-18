Review the uncomitted changes with a strict regression-detection focus.

Required steps:

# First: Fetch the code changes
Follow instructions here:  [instructions--fetch_uncomitted_changes.md](instructions--fetch_uncomitted_changes.md)

if no uncomitted changes, look for the regression candidate from the todo content in the diff between the repo's local branch and the repo's `production` branch


## Files to ignore
- Any file in a changelist named "DO NOT SUBMIT"
- Any file named settings.py

# Then: Understand the existing behavior
Before identifying issues, inspect the surrounding code, impacted callers, replaced logic, and adjacent state/data flow so you understand what behavior existed before the change.

# Then: perform the review
Follow all of the instructions in [instructions--code_review.md](instructions--code_review.md)

# Regression review emphasis
- Spend the majority of the review on ways the diff could break existing functionality
- Read unchanged supporting code whenever needed to verify assumptions instead of guessing
- Trace changed inputs, outputs, ordering, side effects, persistence, API contracts, and state propagation across call sites
- Look hard for removed guards, changed defaults, broken backward compatibility, partial updates, stale state, sequencing races, and missing regression coverage for behavior the diff changes
- Do not dilute the review with style feedback unless it creates a real regression or a clear regression risk
- Take as much time as needed.  Accuracy matters more than speed
- It's ok to find no issues if the risk is suitably low.  If no issues are found, append `No data loss risks identified.`
