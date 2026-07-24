---
name: git-commit
description: >
  Analyze changes, stage files, and commit with Conventional Commits.
  Use when the user asks to commit or run git commit.
---

# Git Commit

Run only when the user asks to commit.

## Procedure

1. Run in parallel: `git status` / `git diff` / `git diff --staged`
2. Stage individually with `git add <files>` (never `git add .`). Skip secrets (`.env`, credentials, tokens, etc.)
3. If unrelated changes are mixed, propose separate commits
4. Commit with Conventional Commits in English (Japanese only if the user explicitly asks). Focus the message on *why*:

```bash
git commit -m "$(cat <<'EOF'
<type>(<scope>): <subject>

<why if useful>
EOF
)"
```

   Place `EOF` at the start of the line (no indentation). Include issue/task numbers in the body when available.

5. Verify with `git status`

## Gotchas

- If there is nothing to commit, stop and tell the user
- If a hook (e.g. pre-commit) fails, stop and ask the user to fix it
