Review all changes in a GitHub pull request

The text following the `$PR_REVIEW` skill contains one or more GitHub pull request URLs in the format:
`https://github.com/{owner}/{repo}/pull/{number}`

Required steps:

# For each PR url
Do these steps

## First: For Fetch the code changes

Parse the PR URL to extract the owner, repo, and PR number, then run:
```
gh pr diff {number} --repo {owner}/{repo}
```

## Then: perform the review
Follow all of the instructions in [instructions--code_review.md](instructions--code_review.md)
