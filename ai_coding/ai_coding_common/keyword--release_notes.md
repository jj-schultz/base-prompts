Create a release notes doc for recent changes.  The todo file will likely include instructions what changes to look at.  they might be a request to only look at uncommitted changes or might specificy a date range on how far to look back.  if no guidance supplied, look back 1 week

if the current directory is a git repo, look only in the current directories git repo, otherwise if the current directory is NOT a git repo, look in the immediate child directories for the git repos

if the release notes are for uncomitteched changes:
- review the code changes.  only comment on the current uncomitted file changes
- look in history.md to fill in any gaps or questions about the uncomitted file changes
else if the release notes are for a time range,
- Read the descriptions of the commits for the given time range and the applicable repos and then assemble release notes

The audience for the release notes is a non-engineer human.  Group notes together in a logical way
- don't have a group per note.  
- look to have between 1 and 3 groups total
