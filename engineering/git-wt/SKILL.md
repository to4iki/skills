---
name: git-wt
description: >
  Creates a Git worktree with `git wt` and implements changes in an isolated directory.
  After the work is done, removes the worktree pending user confirmation.
  Use when the user explicitly says "worktree", "branch off", "wt", "git-wt", etc.
---

# Git Wt

## Workflow

### Step 1: Create the worktree

Pick a branch name from the task description and create the worktree.

```bash
git wt <branch-name> --nocd
```

`--nocd` keeps the current directory in place after creation and only prints the new worktree path to stdout.
The worktree is created under `.wt/<branch-name>/`. Hold on to the printed path as a logical variable `WORKTREE_PATH` in the agent's context — this is a name used to reference the path in later steps, not a shell environment variable.

### Step 2: Work inside the worktree

Every subsequent operation must happen under `WORKTREE_PATH`.

- Read/Edit/Write tools: pass absolute paths like `$WORKTREE_PATH/src/...`
- Bash: `cd $WORKTREE_PATH && <command>`

### Step 3: Report completion

After the work is done, tell the user:
- The list of changed files and a brief summary
- The worktree path
- How to merge (e.g. `cd $WORKTREE_PATH && git push -u origin <branch-name>` → open a PR)

### Step 4: Cleanup

Branch cleanup based on whether there are changes.

#### No changes (nothing committed, nothing modified)

Automatically delete the worktree and branch. No user confirmation needed.

```bash
git wt -d <branch-name>
```

#### Changes or commits exist

Ask the user whether to **keep** or **delete**:

- **Keep**: leave the worktree and branch in place. Tell the user they can return later via `cd $WORKTREE_PATH`.
- **Delete**: warn that all uncommitted changes and commits will be lost, then delete.

```bash
# Normal delete (branch already merged)
git wt -d <branch-name>

# Force delete (unmerged changes; only when the user explicitly authorizes)
git wt -D <branch-name>
```

## Branch naming

Worktrees are created under `.wt/<branch-name>/`. A `/` in the branch name nests the filesystem path further and makes references and operations like `git wt -d` harder to track.
Therefore, use a **flat, single-segment name** — do not use slashes (avoid `feat/...`).

Use hyphenated prefixes for the kind of work. Do not name branches after an agent (e.g. `codex-`); match the task instead (e.g. `feat-auth-module`, not `codex-auth-module`).

| Kind | Prefix | Example |
|-----|--------|---------|
| New feature | `feat-` | `feat-add-dark-mode` |
| Bug fix | `fix-` | `fix-image-upload-error` |
| Refactoring | `refactor-` | `refactor-auth-module` |
| Documentation | `docs-` | `docs-update-readme` |
| Config / chores | `chore-` | `chore-update-deps` |

## Parallel sub-agents

When spawning multiple sub-agents in parallel, create a separate worktree per branch name.
Pass each worktree path explicitly to its agent.

```bash
git wt feat-feature-a --nocd  # → .wt/feat-feature-a
git wt feat-feature-b --nocd  # → .wt/feat-feature-b
```

## References

- [k1LoW/git-wt](https://github.com/k1LoW/git-wt) — implementation of the `git wt` command this skill assumes.
