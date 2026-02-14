Implement the code change described following all principles in [instructions--coding_principles.md](../../../.ai_coding/ai_coding_common/instructions--coding_principles.md)

# Special handling for first Chat with no history

If the current llm chat lacks context history (like this is the first message in the chat), you may attempt to understand context by running git diff:

## If the current directory is a git repo:
```
git diff 
```

## If the current directory is NOT a git repo:
Run for each immediate child directory:
```
(cd <child_dir> && git diff)
```

