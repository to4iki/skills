---
name: create-pr
description: >
  ブランチをプッシュし、gh でプルリクエストを作成する。
  「PR作成」「pull request を作って」「プルリクエスト」「push して PR」と言われたときに使う。
  draft を明示されたときだけドラフト PR にする。
---

# Create PR

ユーザーが PR 作成を依頼したときだけ実行する。ステージ・コミットは行わない。タイトルと本文は英語（ユーザーが日本語を明示したときのみ日本語）。

## 手順

1. 並列で変更を把握する（base はデフォルトブランチ。`main` が無ければ `git symbolic-ref refs/remotes/origin/HEAD` で確認）:
   - `git log $(git merge-base HEAD <base>)..HEAD --oneline`
   - `git diff $(git merge-base HEAD <base>)..HEAD --stat`
2. タイトルと本文を作る。`.github/pull_request_template.md` があればそれに従う。なければ:

```markdown
## Summary
<brief description>

## Changes
- <change>

## Related Issues / Links
- Fixes #<issue-number>
```

3. `git push -u origin <branch_name>`
4. 作成する（ドラフトはユーザーが明示したときだけ `--draft`）:

```bash
gh pr create [--draft] --title "<title>" --body "$(cat <<'EOF'
<body>
EOF
)"
```

5. PR URL を報告する

## Gotchas

- `gh` が無い・未認証なら中断してセットアップを促す
- プッシュ拒否なら中断し、コンフリクト解消を依頼する
