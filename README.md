# to4iki/skills

A collection of agent skills, distributed via [APM](https://github.com/microsoft/apm) (Agent Package Manager).
Skills follow the [Agent Skills](https://agentskills.io) specification.

## Install

Install an individual skill (global / user scope):

```sh
apm install -g to4iki/skills/<category>/<skill-name>
```

Or add to a project's `apm.yml`:

```yaml
targets:
  - agent-skills
  - claude
dependencies:
  apm:
    - to4iki/skills/<category>/<skill-name>
```

Pin to a tag:

```sh
apm install -g to4iki/skills/<category>/<skill-name>#v0.1.0
```

### Alternative: GitHub CLI

If you use [gh skill](https://cli.github.com/manual/gh_skill) instead of APM:

```sh
gh skill install to4iki/skills <category>/<skill-name> --agent claude-code --scope user
```

## Skills

### Engineering

- **[git-commit](./engineering/git-commit/SKILL.md)** — Analyze changes, stage files, and commit with Conventional Commits.
- **[create-pr](./engineering/create-pr/SKILL.md)** — Push the branch and open a pull request with `gh`.
- **[git-wt](./engineering/git-wt/SKILL.md)** — Create a Git worktree with `git wt` and implement changes in an isolated directory.
- **[hunk-session](./engineering/hunk-session/SKILL.md)** — Drive a live Hunk terminal diff review via `hunk session *`.
- **[implementation-notes](./engineering/implementation-notes/SKILL.md)** — Implement a spec while keeping a running `implementation-notes.html` work log.

### Misc

- **[cursor-edit](./misc/cursor-edit/SKILL.md)** — Delegate file edits to Cursor through the headless `cursor-agent` CLI.
- **[eli5](./misc/eli5/SKILL.md)** — Explain a topic like I'm 5, as a dead-simple HTML picture explainer.
- **[use-claude-artifact](./misc/use-claude-artifact/SKILL.md)** — Create review/explanation/design HTML as a Claude artifact instead of a repo file.
