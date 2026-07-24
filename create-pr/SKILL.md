---
name: create-pr
description: >
  Push the branch and open a pull request with gh.
  Use when the user asks to create a PR, open a pull request, or push and create a PR.
  Create a draft PR only when the user explicitly requests draft.
---

# Create PR

Run only when the user asks to create a PR. Do not stage or commit. Write the title and body in English (Japanese only if the user explicitly asks).

## Procedure

1. Inspect changes in parallel (base = default branch; if `main` is missing, resolve with `git symbolic-ref refs/remotes/origin/HEAD`):
   - `git log $(git merge-base HEAD <base>)..HEAD --oneline`
   - `git diff $(git merge-base HEAD <base>)..HEAD --stat`
2. Draft title and body. Follow `.github/pull_request_template.md` if present. Otherwise:

```markdown
## Summary
<brief description>

## Changes
- <change>

## Related Issues / Links
- Fixes #<issue-number>
```

3. `git push -u origin <branch_name>`
4. Create (pass `--draft` only when the user explicitly asks for a draft):

```bash
gh pr create [--draft] --title "<title>" --body "$(cat <<'EOF'
<body>
EOF
)"
```

5. Report the PR URL

## Gotchas

- If `gh` is missing or unauthenticated, stop and ask the user to set it up
- If the push is rejected, stop and ask the user to resolve conflicts
