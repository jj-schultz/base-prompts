# Product Merge Review - release -> production

Review **actual code diffs**, not commit descriptions.

This review must be based on reading every diff hunk for every qualifying repo.

---

## Step 1 - Identify qualifying repositories

For each immediate child directory, determine whether it is a git repo with both `release` and `production` branches (local or remote):

```bash
(cd <child_dir> && git show-ref --verify --quiet refs/heads/production || git show-ref --verify --quiet refs/remotes/origin/production)
(cd <child_dir> && git show-ref --verify --quiet refs/heads/release || git show-ref --verify --quiet refs/remotes/origin/release)
```

Only repositories with both `release` and `production` branches participate in this review.

---

## Step 2 - Enumerate changes

For each qualifying repository:

### 2.1 List commits included in the merge

```bash
(cd <child_dir> && git log production..release --oneline)
```

This list is informational only. Do not review based on commit messages.

---

## Step 3 - Inspect full code diffs (mandatory)

For each qualifying repository, inspect the **entire diff** between `production` and `release`:

```bash
(cd <child_dir> && git diff production..release)
```

If commit-by-commit context is needed:

```bash
(cd <child_dir> && git log production..release -p)
```

You must read every modified file and every diff hunk.

## Step 4 - Perform the code review

Follow all instructions in:

[instructions--code_review.md](instructions--code_review.md)

