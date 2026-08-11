---
name: cursor-edit
description: >
  Delegate file edits to Cursor through the headless cursor-agent CLI instead of editing files directly in the calling AI agent.
  The calling AI agent analyzes the change, writes precise edit instructions, and verifies the result; cursor-agent performs the actual file modifications.
  Use when the user says things like "let Cursor edit this", "fix it with cursor", or "have Cursor handle the file edits".
  Best for offloading large edits to Cursor to reduce token usage and speed up the overall workflow.
---

# Cursor Edit

## Overview

This skill outsources **only the act of editing files** to Cursor's headless CLI (`cursor-agent`). Use the same contract from Claude Code, Codex, or any other AI agent.

- **Calling AI agent (brain)**: reads and searches code, decides what to change, writes edit instructions, and verifies the result
- **Cursor (hands)**: rewrites files according to the received instructions

The goal is to move heavy editing work to Cursor, reducing token usage in the calling AI agent and speeding up the overall task.

This only pays off for **larger edits**. For small changes, the cost of writing self-contained instructions and reviewing `git diff` can exceed the cost of direct editing. Do not force this skill onto trivial one-line or few-line edits.

## When To Use

These tendencies apply:

- **Not suitable for trivial edits (one to a few lines)**. Startup, instruction writing, and diff review often cost more than direct editing by the calling AI agent.
- **Best for edits that are large, pattern-heavy, and have good sibling files to imitate**. Example: adding tests that follow an existing test suite. `cursor-agent` can closely follow good sibling examples and often produce convention-compliant results quickly.
- **Be careful with new features or non-obvious assumptions when no good sibling example exists**. `cursor-agent` tends to pattern-match without semantic validation, so correctness is not guaranteed. In this case, the calling AI agent must separately verify semantic correctness. See "Required Verification".
- **Cursor consumes the delegated tokens**. The calling AI agent saves tokens, but the speed and quality advantages mainly apply under the suitable conditions above.

## Operating Contract

- The calling AI agent must **not** use direct editing tools such as `Edit`, `Write`, or `apply_patch`.
- All file rewrites must go through `scripts/cursor-agent-print.sh`, which calls `cursor-agent`.
- The calling AI agent remains responsible for code reading, search, planning, writing edit instructions, git operations, build/test/lint verification, TODO management, and persistent memory updates.
- This is a soft contract. Direct editing tools are not technically blocked by hooks; the calling AI agent must follow this as discipline.

## Editing Loop

1. **Analyze and design** — The calling AI agent reads the code and decides what to change in which files.
2. **Write edit instructions** — State the target files and desired changes unambiguously. Follow the guidance below.
3. **Delegate** — Pass the instructions to `cursor-agent-print.sh` so `cursor-agent` edits the files.
4. **Verify** — Review Cursor's actual changes with `git diff`, then build/test/lint the changed scope.
5. **Retry** — If the result diverges from the intent, return to step 2 with more specific instructions.

## Calling cursor-agent

Call the wrapper from the target repository root. If working in a worktree, run it from the worktree root. `cursor-agent` reads and writes files relative to the current directory.

```bash
<cursor-edit>/scripts/cursor-agent-print.sh "<edit instructions>"
```

`<cursor-edit>` is the directory where this skill is installed.

Internally, the wrapper runs:

```bash
cursor-agent -p --force --trust --output-format text --model "${CURSOR_MODEL:-composer-2.5-fast}" "<edit instructions>"
# -p      : non-interactive print mode
# --force : apply file changes without confirmation
# --trust : trust the workspace without prompting
```

The default model is Composer2.5 Fast (`composer-2.5-fast`). Set `CURSOR_MODEL` to override it.

```bash
CURSOR_MODEL=gpt-5.5 <cursor-edit>/scripts/cursor-agent-print.sh "<edit instructions>"
```

## Writing Good Edit Instructions

`cursor-agent` is another AI. If instructions are vague, Cursor can edit in the wrong direction. Write instructions that are self-contained.

- **Name the target file paths** using relative or absolute paths.
- **Name existing sibling files to imitate**. Example: "Read the existing `foo-1.test.ts` through `foo-6.test.ts` files and follow their conventions." This is the strongest lever for quality and convention matching. `cursor-agent` follows imports, naming, helpers, and local patterns much better when it has good examples.
- **Describe the before and after concretely**. Quoting the relevant code improves accuracy.
- **Include acceptance criteria**. Example: the build must pass, or function signatures must not change.
- **Constrain the scope**. Example: "Do not modify any files other than the specified files."
- **Split large changes**. Do not pack too much into a single delegation.

Good instruction example:

```text
In server/src/domain/foo/foo.ts, add an early return at the start of Foo.validate()
that returns new EmptyNameError() when this.name.trim() === "".
Do not change the existing logic.
Do not edit any files other than the specified file.
```

## Scope And Safety

- **Delegate**: project code and configuration files.
- **Do directly in the calling AI agent**: git operations, persistent memory updates, and TODO management.
- Do not let `cursor-agent` roam freely. **Always name the files it is allowed to edit** and keep it out of unrelated scope.
- **When using a worktree**: run `cursor-agent-print.sh` from the worktree root and include "do not modify files outside this worktree" in the instructions.

## Required Verification

- After editing, **always review Cursor's actual changes with `git diff`**. Do not trust the text output from `cursor-agent` alone.
  - To preserve the token savings, review the diff first instead of rereading whole files.
- **Confirm where files were generated**. Because `cursor-agent` runs from the current working directory, verify that worktree edits stayed inside the worktree and did not dirty the parent repository, for example with `git -C <worktree> status`.
- **`cursor-agent` does not verify semantic assumptions**; it mainly pattern-matches sibling files. `git diff` and builds do not prove the semantic correctness of claims or logic. For new or non-obvious logic, such as whether an assertion is really valid or whether an API actually exists, the calling AI agent must verify the behavior against use cases and sibling tests. Be especially careful when there is no good sibling example. Confirm with search before claiming that something is absent or nonexistent.
- Build, test, and lint the changed scope according to the project's conventions.

## Gotchas

- If `cursor-agent` is missing or authentication fails, report that the execution environment does not meet the prerequisite and stop.
- If `cursor-agent` fails or edits against the instructions, make the instructions more specific and retry.
- If retrying does not resolve the issue, report the situation to the user and ask how to proceed. Even though this is a soft contract, the calling AI agent must not silently switch back to direct editing.
