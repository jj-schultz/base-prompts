Review the code changes with a strict performance-and-scale focus.

Required steps:

# First: Fetch the code changes
- If the text following the `$PERFORMANCE_CHECK` skill specifies how to get the diff, use that diff as the review input.
- Otherwise follow instructions here: [instructions--fetch_uncomitted_changes.md](instructions--fetch_uncomitted_changes.md)

# Then: Understand the existing behavior
Before identifying issues, inspect the surrounding code, impacted callers, replaced logic, adjacent state/data flow, and the concurrency/query/memory behavior around the changed paths so you understand how the system behaves before and after the change.

# Then: perform the review
Follow all of the instructions in [instructions--code_review.md](instructions--code_review.md)

# Performance review emphasis
- Spend the majority of the review on performance, memory, concurrency, and scale risks in the diff
- Think about many simultaneous users, very large files, very large payloads, very large result sets, and long-running sessions
- Read unchanged supporting code whenever needed to verify asymptotic behavior and resource usage instead of guessing
- Look hard for N+1 queries, repeated scans, quadratic work, unbounded loops, per-item network/database calls, missing batching/pagination, large in-memory buffers, duplicate serialization, lock contention, hot-path synchronous bottlenecks, and fan-out that grows with input size
- Check whether new queries need indexes for the new access pattern
- Prioritize issues that may appear fine at small scale but fail under production load
- Do not dilute the review with style feedback unless it creates a real performance or scale risk
- Take as much time as needed.  Accuracy matters more than speed
- If no issues are found, append `No performance or scale risks identified.`
