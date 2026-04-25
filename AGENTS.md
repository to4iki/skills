# AGENTS.md - maintenance notes

This repo is the upstream source for to4iki's agent skills. Each top-level directory is a skill distributed via [gh skill](https://cli.github.com/manual/gh_skill).

## When editing a skill in this repo

Skills here are installed to `~/.claude/skills/<name>/` via:

```sh
gh skill install to4iki/skills <skill-name> --agent claude-code --scope user
```

Edits in this repo do NOT propagate to the installed copy automatically. While editing, mirror each change under `<skill-name>/` to `~/.claude/skills/<skill-name>/` so the running Claude Code session reflects it immediately.

Use the same relative path — e.g. editing `./git-wt/SKILL.md` means also writing `~/.claude/skills/git-wt/SKILL.md`. Deletions and renames propagate the same way.

After commit + push, run `gh skill update --all` on the maintainer's own machine to realign the installed copy with the published source.

## Before committing

- Skill directory name must match the `name:` in its `SKILL.md` frontmatter.
- Each skill must ship with `SKILL.md` in English. `SKILL-ja.md` is an optional Japanese counterpart and may exist on its own only while drafting.
- Do not commit secrets or anything that should not be publicly distributable.

## Language policy

`SKILL.md` (English) is the source of truth. Update `SKILL-ja.md` only when a non-trivial content change needs to be kept in sync for Japanese readers — small wording fixes to the English file don't require touching the Japanese copy.
