---
name: implementation-notes
description: >
  仕様を実装しながら implementation-notes.html に判断・逸脱・トレードオフ・
  未解決事項を継続記録する。/implementation-notes、@implementation-notes、
  implementation-notes.html、作業記録付きの仕様実装時に使用する。
---

# Implementation Notes

仕様を実装しつつ、`implementation-notes.html` を作業中ずっと更新する。差分を全部読まなくても、仕様をどう解釈し、どこで判断し、実装が仕様からどう変化したかを人間が追えるようにする。

## 呼び出し

```
/implementation-notes <SPEC>
```

`<SPEC>` は実装対象 — ファイルパス、URL、Issue/PR、または同じメッセージ内の要件本文。

`<SPEC>` なしでスキルだけ指定された場合は、実装内容を確認してから着手する。

## notes ファイル

- デフォルト: プロジェクトルートの `implementation-notes.html`（単体で開けること。外部アセット不要）。
- 目的: 最終成果物として、人間がブラウザで閲覧し、仕様解釈・実装差分・未決事項を確認できる HTML ファイルを残す。
- 実装が仕様から分岐・解釈・補完した内容を、ユーザーが確認すべき notes として残す。

終わりにまとめるのではなく、作業しながら追記する。特に:

- デザインの決定: 仕様が曖昧だった箇所で行った選択
- 逸脱: 仕様から意図的に外れた箇所と、その理由
- トレードオフ: 検討した代替案と、その案を選んだ理由
- 未解決の質問: 確認または修正してほしい事項
- 検証結果: 実行したコマンドと結果

コードは貼りすぎず、パスで参照する。

## HTML の使い方

`implementation-notes.html` はテキストを HTML に置き換えただけのファイルにしない。内容に合わせて HTML / CSS / SVG / JavaScript を使い、レビューしやすい構造にする。

詳細な表現パターンが必要な場合は `references/html-output.md` を読む。

## 完了時

notes の場所を伝え、未解決事項と検証結果を先に伝える。
