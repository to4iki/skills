---
name: git-wt
description: >
  `git wt` で Git worktree を作成し、作業ディレクトリを分離して実装を行う。
  作業完了後はユーザー確認を経て worktree を削除する。
  ユーザーが「worktree」「ワークツリー」「ブランチを分けて」「wt」「git-wt」などと明示したときに使う。
---

# Git Wt

## 実行手順

### Step 1: worktree を作成する

タスク内容からブランチ名を決め、worktree を作成する。

```bash
git wt <branch-name> --nocd
```

`--nocd` を付けると、worktree 作成後もカレントディレクトリを移動せず、作成パスのみを標準出力に返す。
`.wt/<branch-name>/` 配下に worktree が作成され、出力されたパスをエージェント文脈の論理変数 `WORKTREE_PATH` として保持する（シェルの環境変数ではなく、以降の手順で参照するための名前として扱う）。

### Step 2: worktree 内で作業する

以降の操作はすべて `WORKTREE_PATH` 配下で行う。

- Read/Edit/Write ツール: `$WORKTREE_PATH/src/...` のように絶対パスで指定
- Bash: `cd $WORKTREE_PATH && <command>`

### Step 3: 完了報告

作業完了後、ユーザーに以下を伝える:
- 変更ファイル一覧と概要
- worktree パス
- マージ方法（例: `cd $WORKTREE_PATH && git push -u origin <branch-name>` → PR作成）

### Step 4: クリーンアップ

変更の有無でクリーンアップを分岐する。

#### 変更なし（未コミット・未変更）の場合

worktree とブランチを自動削除する。ユーザー確認は不要。

```bash
git wt -d <branch-name>
```

#### 変更またはコミットがある場合

ユーザーに「保持」か「削除」かを確認する。

- **保持**: worktree とブランチをそのまま残す。後で `cd $WORKTREE_PATH` で戻れることを伝える。
- **削除**: 未コミットの変更とコミットがすべて破棄されることを警告した上で削除する。

```bash
# 通常削除（マージ済みブランチ）
git wt -d <branch-name>

# 強制削除（未マージの変更がある場合、ユーザーが明示的に指示した場合のみ）
git wt -D <branch-name>
```

## ブランチ命名

worktree は `.wt/<branch-name>/` に作られる。ブランチ名に `/` があると実パスもネストし、参照や `git wt -d` などの操作が分かりにくくなる。
そのため **フラットな1段の名前** にする。`/` で区切らない（`feat/...` のような形式は使わない）。

種別はハイフン区切りのプレフィックスで表す。エージェント名（`codex-` など）ではなく作業内容に合わせる（例: `codex-auth-module` ではなく `feat-auth-module`）。

| 種別 | プレフィックス | 例 |
|-----|-------------|-----|
| 新機能 | `feat-` | `feat-add-dark-mode` |
| バグ修正 | `fix-` | `fix-image-upload-error` |
| リファクタリング | `refactor-` | `refactor-auth-module` |
| ドキュメント | `docs-` | `docs-update-readme` |
| 設定変更 | `chore-` | `chore-update-deps` |

## 複数エージェントの並行作業

複数のサブエージェントを並行起動する場合、それぞれ別ブランチ名で worktree を作成する。
各エージェントに worktree パスを明示的に伝える。

```bash
git wt feat-feature-a --nocd  # → .wt/feat-feature-a
git wt feat-feature-b --nocd  # → .wt/feat-feature-b
```

## リファレンス

- [k1LoW/git-wt](https://github.com/k1LoW/git-wt) — 本スキルが前提とする `git wt` コマンドの実装。
