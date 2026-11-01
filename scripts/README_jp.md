<!-- markdownlint-disable MD041 -->
言語: 　[English](./README.md)　|　**日本語**
<!-- markdownlint-enable MD041 -->

# FBACスクリプト

このディレクトリには、Figura Blue Archive Crafters（FBAC）アバターの動作には直接関係のない外部スクリプトが格納されています。
利用可能なスクリプトは次のとおりです。

## BBModel編集状態のステージング時正規化

`.bbmodel`ファイルは、ステージング時に次のBlockBench編集状態を`false`へ正規化します。

- `groups[].isOpen`、`groups[].selected`、`groups[].primary_selected`
- `animations[].selected`
- `outliner`内の全ツリーノードの`isOpen`

正規化はインデックスに登録する内容に対して行われ、作業ツリー上のファイルは変更されません。

Gitのフィルター設定はクローンごとのローカル設定です。`uv`を用意したうえで、リポジトリのルートから次のコマンドを実行してください。各クローンで一度実行する必要があります。

```sh
sh scripts/setup_bbmodel_filter.sh
```

セットアップ前はGitがフィルターを実行せず、内容をそのままステージします。

## ビルドスクリプト

このスクリプトはFBACアバターのソースファイルを、ゲーム内で実際に使用可能なデータに変換(ビルド)するコマンドラインツールです。

詳しくはビルドスクリプトの[README](./build/README_jp.md)を参照してください。

## README生成スクリプト

このスクリプトは本レポジトリ（のREADMEのマークダウンドキュメントおよび配布データに含めるREADMEテキストファイルをテンプレートから作成するツールです。

詳しくはREADME生成スクリプトの[README](./readme_generate/README_jp.md)を参照してください。

## テストスクリプト

このスクリプトはFBACアバターのビルドが成功するかやソースファイルを設定値が正しいかを検査するスクリプトです。

詳しくはテストスクリプトの[README](./test/README_jp.md)を参照してください。
