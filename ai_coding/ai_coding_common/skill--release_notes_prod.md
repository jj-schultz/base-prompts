Create "release notes" by identifying commits on the `release` branch that are not yet on the `production` branch.

# Fetch the changes
For each immediate child directory, check if it is a git repo with both `release` and `production` branches:
```
(cd <child_dir> && git show-ref --verify --quiet refs/heads/production || git show-ref --verify --quiet refs/remotes/origin/production)
(cd <child_dir> && git show-ref --verify --quiet refs/heads/release || git show-ref --verify --quiet refs/remotes/origin/release)
```
Only include repos that have both branches. For qualifying repos, list commits on `release` not yet on `production`:
```
(cd <child_dir> && git log production..release --oneline)
```
for each commit defined above, query git for the code diff to understand the changes


# Release Notes Assembly
- Both read the descriptions of the commits and the code diffs to understand the changes going out.  
- If there is a ticket mention, include the ticket url in the release notes 
- The audience for the release notes is a non-engineer human. 
- Group notes together in a logical way:
    - Don't have a group per note
    - Look to have between 1 and 3 groups total
