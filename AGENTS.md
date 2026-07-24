# AGENTS.md - maintenance notes

This repo is the upstream source for to4iki's agent skills. Skills live under category directories (`engineering/`, `misc/`, `productivity/`, …). Each skill directory is distributed via [APM](https://github.com/microsoft/apm) (Agent Package Manager).

## When editing a skill in this repo

Skills here are installed to `~/.claude/skills/<skill-name>/` via:

```sh
apm install -g to4iki/skills/<category>/<skill-name>
```

Edits in this repo do NOT propagate to the installed copy automatically. While editing, mirror each change under `<category>/<skill-name>/` to `~/.claude/skills/<skill-name>/` so the running Claude Code session reflects it immediately.

Use the same skill name — e.g. editing `./engineering/git-wt/SKILL.md` means also writing `~/.claude/skills/git-wt/SKILL.md`. Deletions and renames propagate the same way.

After commit + push, run `apm install -g --update` on the maintainer's own machine to realign the installed copy with the published source.

## Before committing

- Skill directory name must match the `name:` in its `SKILL.md` frontmatter.
- Each skill must ship with `SKILL.md` in English. `SKILL-ja.md` is an optional Japanese counterpart and may exist on its own only while drafting.
- Do not commit secrets or anything that should not be publicly distributable.

## Language policy

`SKILL.md` (English) is the source of truth. Update `SKILL-ja.md` only when a non-trivial content change needs to be kept in sync for Japanese readers — small wording fixes to the English file don't require touching the Japanese copy.
