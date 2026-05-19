---
name: implementation-notes
description: >
  仕様を実装しながら implementation-notes.html に判断・逸脱・トレードオフ・
  未解決事項を継続記録する。/implementation-notes、@implementation-notes、
  implementation-notes.html、作業記録付きの仕様実装時に使用する。
---

# Implementation Notes

仕様を実装しつつ、`implementation-notes.html` を作業中ずっと更新する。差分を全部読まなくても追えるようにする。

## 呼び出し

```
/implementation-notes <SPEC>
```

`<SPEC>` は実装対象 — ファイルパス、URL、Issue/PR、または同じメッセージ内の要件本文。

`<SPEC>` なしでスキルだけ指定された場合は、実装内容を確認してから着手する。

## notes ファイル

- デフォルト: プロジェクトルートの `implementation-notes.html`（単体で開けること。外部アセット不要）。
- Markdown はユーザーが指定したときだけ。

終わりにまとめるのではなく、作業しながら追記する。特に:

- デザインの決定（仕様が曖昧だった箇所）
- 逸脱（意図的な変更と理由）
- トレードオフ（代替案と採用理由）
- 未解決の質問（ユーザー確認が必要なこと）

コードは貼りすぎず、パスで参照する。

## 完了時

notes の場所を伝え、未解決があれば先に伝える。
