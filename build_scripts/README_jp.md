言語: 　[English](./README.md)　|　**日本語**

# FBACビルドツール

このツールはFigura Blue Archive Crafters（FBAC）アバターのソースファイルを、ゲーム内で実際に使用可能なデータに変換(ビルド)するコマンドラインツールです。

## FBACのソースファイル構造

FBACのソースファイル（モデル・テクスチャ・スクリプト・その他メタ情報）は「コア部分」と「キャラクター固有部分」の2つに分かれています。

### コア部分

コア部分は全てのキャラクターに共通する系統(表情・ヘイロー・Exスキルの再生ロジックなど)に関わるリソース群を指します。
コアは"[/src/core](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/blob/main/src/core)"配下に格納されています。

#### avatar_template.json

"[avatar_template.json](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/blob/main/src/core/avatar_template.json)"はFiguraにアバターとして認識させるための"[avatar.json](https://figura-wiki.pages.dev/start_here/Avatar%20File%20Format)"にビルドするテンプレートとなるファイルです。
テンプレートファイルの構造は、"avatar.json"の構造とほとんど同じですが、ビルドの過程で具体的な値が入れられるプレースホルダーが一部のフィールド上で有効になっています。

| プレースホルダー名 | 説明 | 具体的な値の例 | サポートされているフィールド |
| --- | --- | --- | --- |
| AVATAR_ID | キャラクターのID | "01a", "01b", ... | name |
| FIRST_NAME | キャラクターの下の名前（名） | "Shizuko", "Izuna", ... | name, description |
| LAST_NAME | キャラクターの上の名前（姓） | "Kawawa", "Kuda", ... | description |
| COSTUME_NAME | キャラクターの衣装名 <br> 括弧（"()"）も含む。デフォルト衣装では空文字になる。 | "(Swimsuit)", "(Tracksuit)", "" | name, description |

### キャラクター固有部分

キャラクター固有部分はコアをベースに、特定のキャラクター向けに具体的な実装がされたリソース群を指します。
キャラクター固有部分は"[/src/avatars](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/blob/main/src/avatars)"配下に格納されており、更にそれぞれのキャラクターのサブディレクトリにそれぞれのリソースが格納されています。
ただし、"[00a_base](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/blob/main/src/avatars/00a_base)"はキャラクターを作成する際のテンプレートとなるアバターとなります。
つまり、キャラクターの「素体」になるアバターになります。

キャラクターのサブディレクトリの命名規則は以下の通りです。
なお、キャラクターの名前や衣装名は英語で記述します。
また、最初の1文字は大文字とし、それ以降は小文字にします。

- （デフォルト衣装の場合） ... `${キャラクターID}_${キャラクターの下の名前}`
- （衣装違いの場合） ... `${キャラクターID}_${キャラクターの下の名前}_${衣装の名前}`

#### avatar_json_config.json

"[avatar_json_config.json](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/blob/main/src/avatars/00a_base/avatar_json_config.json)"はコアの"[avatar_template.json](#avatar_templatejson)"に具体的な値を挿入・統合するためのファイルです。
このjsonファイルの構造は次の通りです：

```
📃 avatar_json_config.json
├ 📁 placeholders{}
│ ├ 🔠 first_name
│ ├ 🔠 last_name
│ └ 🔠 (costume_name)
├ 📁 ignoredTextures[]
│ └ 🔠 texture_name
├ 📁 autoAnims[]
│ └ 🔠 animation_name
└ 📁 customizations{}
  └ 📁 ...
```

（🔢: 数字型、🔠: 文字列型、▶️: ブーリアン型、📁[]: 配列型、📁{}: 辞書型、(): 任意のフィールド）

`placeHolders`には"avatar_template.json"にあるプレースホルダーに入れる具体的な値を保持します。

| プレースホルダー名 | 説明 | 具体的な値の例 | 必須フィールドか |
| --- | --- | --- | --- |
| first_name | キャラクターの下の名前（名） | "Shizuko", "Izuna", ... | はい |
| last_name | キャラクターの上の名前（姓） | "Kawawa", "Kuda", ... | はい |
| COSTUME_NAME | キャラクターの衣装名 <br> 括弧（"()"）も含めない。 | "Swimsuit", "Tracksuit" | いいえ |

`ignoredTextures`、`autoAnims`、`customizations`はビルドの際に"avatar_template.json"内にある同名のフィールドと統合されます。
キーが重複する場合は、"avatar_json_config.json"の値で上書きされます。

#### thumbnail_config.json

"[thumbnail_config.json](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/blob/main/src/avatars/00a_base/thumbnail_config.json)"はアバターサムネイルを生成する際に使用する設定値を格納したファイルです。
このjsonファイルの構造は次の通りです：

```
📃 thumbnail_config.json
└ 🔠 colorType
```

`colorType`にはサムネイル画像の色を決定する値が入ります（上記例の青色の部分）。
列挙型の値名は本家ブルーアーカイブの攻防の属性名を基にしています。
有効な値は以下の通りです。

| 値名 | 説明 | 例 |
| --- | --- | --- |
| explosive | 爆発（赤色） | ![赤色サムネイルの例](./readme_images/thumbnail_examples/explosive.png) |
| penetration | 貫通（黄色） | ![黄色サムネイルの例](./readme_images/thumbnail_examples/penetration.png) |
| chemical | 複合（緑色） | ![緑色サムネイルの例](./readme_images/thumbnail_examples/chemical.png) |
| mystic | 神秘（青色） | ![青色サムネイルの例](./readme_images/thumbnail_examples/mystic.png) |
| sonic | 振動（紫色） | ![紫色サムネイルの例](./readme_images/thumbnail_examples/sonic.png) |

## 環境構築及び実行手順

本レポジトリをクローンし、実際にアバターをビルドするまでの手順を示します。
なお、本ビルドツールの実行にはPythonのバージョン管理ツールである[uv](https://docs.astral.sh/uv/)が必要です。
また、手順内にあるコマンド例はMac/Linux準拠になります。

1. 本レポジトリをクローン（ダウンロード）し、お使いのデバイス上にファイルを展開します。
2. ワーキングディレクトリを"/src/build_script"に設定します。

   ```sh
   cd <path_to_repository_root_directory>/build_scripts/
   ```

3. Python及び依存パッケージのインストールをします。
   以下のコマンドを実行するだけでインストールできます。

   ```sh
   cd <path_to_repository_root_directory>/build_scripts/
   ```

4. ビルドスクリプトを実行します。
   デフォルトパスの場合、`../dist/`にビルド済アバターが出力されます。

   ```sh
   uv run build.py
   ```
