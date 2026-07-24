---
name: git-commit
description: >
  変更を分析してステージし、Conventional Commits でコミットする。
  「コミット」「commit して」「git commit」と言われたときに使う。
---

# Git Commit

ユーザーがコミットを依頼したときだけ実行する。

## 手順

1. 並列で実行する: `git status` / `git diff` / `git diff --staged`
2. シークレット（`.env`、認証情報、トークンなど）を除き、`git add <files>` で個別にステージする（`git add .` は使わない）
3. 無関係な変更が混在していれば、分割コミットを提案する
4. Conventional Commits・英語でコミットする（ユーザーが日本語を明示したときのみ日本語）。メッセージは *why* に焦点を当てる:

```bash
git commit -m "$(cat <<'EOF'
<type>(<scope>): <subject>

<why if useful>
EOF
)"
```

   `EOF` は行頭（インデントなし）に置く。Issue / タスク番号があれば本文に含める。

5. `git status` で成功を確認する

## Gotchas

- コミット対象がなければ中断して伝える
- pre-commit などが失敗したら中断し、解消を依頼する
