# Special handling for first Chat with no history
If the current llm chat lacks context history (like this is the first message in the chat), you **must** attempt to understand context by fetching uncomitted changes by following these commands
[instructions--fetch_uncomitted_changes.md](instructions--fetch_uncomitted_changes.md)

1.  Implement the code change described following all principles in [instructions--coding_principles.md](../../../.ai_coding/ai_coding_common/instructions--coding_principles.md)
2.  Make sure the change(s) has test coverage (unless the changes are in .sh file - .sh files do not require tests)
   - If there are unit or end-to-end tests that assert previous behavior or are in this area, modify the tests so they now assert the new code behavior
   - If there are not unit or end-to-end tests that assert the code fix, add the tests.  It is preferred to append to existing test files rather than create new test files
   - If there are multiple items to fix in the todo file, make sure each has a test assertion using the same above two criteria
   - DO NOT CREATE TEST BLOAT!!  look to modify and/or extend existing tests before adding new tests

