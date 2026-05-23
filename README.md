# to4iki/skills

A collection of agent skills, distributed via [APM](https://github.com/apm-sh/apm) (Agent Package Manager).

## Install

Install an individual skill (global / user scope):

```sh
apm install -g to4iki/skills/<skill-name>
```

Or add to a project's `apm.yml`:

```yaml
targets:
  - claude
dependencies:
  apm:
    - to4iki/skills/<skill-name>
```

Pin to a tag:

```sh
apm install -g to4iki/skills/<skill-name>#v0.1.0
```

### Alternative: GitHub CLI

If you use [gh skill](https://cli.github.com/manual/gh_skill) instead of APM:

```sh
gh skill install to4iki/skills <skill-name> --agent claude-code --scope user
```
