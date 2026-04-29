言語: 　[English](./README.md)　|　**日本語**

# FBACビルドツール

このツールはFigura Blue Archive Crafters（FBAC）アバターのソースファイルを、ゲーム内で実際に使用可能なデータに変換(ビルド)するコマンドラインツールです。

## FBACのソースファイル構造

FBACのソースファイル（モデル・テクスチャ・スクリプト・その他メタ情報）は「コア部分」と「キャラクター固有部分」の2つに分かれています。

### コア部分

コア部分は全てのキャラクターに共通する系統(表情・ヘイロー・Exスキルの再生ロジックなど)に関わるリソース群を指します。
コアは"[/src/core](../src/core/)"配下に格納されています。

#### avatar_template.json

"[avatar_template.json](../src/core/avatar_template.json)"はFiguraにアバターとして認識させるための"[avatar.json](https://figura-wiki.pages.dev/start_here/Avatar%20File%20Format)"にビルドするテンプレートとなるファイルです。
テンプレートファイルの構造は、"avatar.json"の構造とほとんど同じですが、ビルドの過程で具体的な値が入れられるプレースホルダーが一部のフィールド上で有効になっています。

| プレースホルダー名 | 説明 | 具体的な値の例 | サポートされているフィールド |
| --- | --- | --- | --- |
| AVATAR_ID | キャラクターのID | "01a", "01b", ... | name |
| FIRST_NAME | キャラクターの下の名前（名） | "Shizuko", "Izuna", ... | name, description |
| LAST_NAME | キャラクターの上の名前（姓） | "Kawawa", "Kuda", ... | description |
| COSTUME_NAME | キャラクターの衣装名 <br> 括弧（"()"）も含む。デフォルト衣装では空文字になる。 | "(Swimsuit)", "(Tracksuit)", "" | name, description |

### キャラクター固有部分

キャラクター固有部分はコアをベースに、特定のキャラクター向けに具体的な実装がされたリソース群を指します。
キャラクター固有部分は"[/src/avatars](../src/avatars/)"配下に格納されており、更にそれぞれのキャラクターのサブディレクトリにそれぞれのリソースが格納されています。
ただし、"[00a_base](../src/avatars/00a_base/)"はキャラクターを作成する際のテンプレートとなるアバターとなります。
つまり、キャラクターの「素体」になるアバターになります。

キャラクターのサブディレクトリの命名規則は以下の通りです。
なお、キャラクターの名前や衣装名は英語で記述します。
また、最初の1文字は大文字とし、それ以降は小文字にします。

- （デフォルト衣装の場合） ... `${キャラクターID}_${キャラクターの下の名前}`
- （衣装違いの場合） ... `${キャラクターID}_${キャラクターの下の名前}_${衣装の名前}`

#### avatar_json_config.json

"[avatar_json_config.json](../src/avatars/00a_base/avatar_json_config.json)"はコアの"[avatar_template.json](#avatar_templatejson)"に具体的な値を挿入・統合するためのファイルです。
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

`placeholders`には"avatar_template.json"にあるプレースホルダーに入れる具体的な値を保持します。

| プレースホルダー名 | 説明 | 具体的な値の例 | 必須フィールドか |
| --- | --- | --- | --- |
| first_name | キャラクターの下の名前（名） | "Shizuko", "Izuna", ... | はい |
| last_name | キャラクターの上の名前（姓） | "Kawawa", "Kuda", ... | はい |
| costume_name | キャラクターの衣装名 <br> 括弧（"()"）は含めない。 | "Swimsuit", "Tracksuit", ... | いいえ |

`ignoredTextures`、`autoAnims`、`customizations`はビルドの際に"avatar_template.json"内にある同名のフィールドと統合されます。
キーが重複する場合は、"avatar_json_config.json"の値で上書きされます。

#### thumbnail_config.json

"[thumbnail_config.json](../src/avatars/00a_base/thumbnail_config.json)"はアバターサムネイルを生成する際に使用する設定値を格納したファイルです。
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
   uv sync
   ```

4. ビルドスクリプトを実行します。
   デフォルトパスの場合、`../dist/`にビルド済みアバターが出力されます。

   ```sh
   uv run build.py
   ```

## ビルドツールのオプション引数

本ビルドツールにはオプション引数を用意しています。

| 引数名 | 追加引数 | 説明 |
| --- | --- | --- |
| -h, --help | なし | ビルドツールの説明を出力します。 |
| -c, --character | 有効なアバター名 <br> ("01a", "Shizuko", "01a_Shizuko"など) | 特定のキャラクター1人のみビルドします。この引数を指定しない場合はベースキャラクターを含む全てのアバターをビルドします。監視モードでは効果がありません。 |
| -i, --src-dir | アバターソースのディレクトリまでのパス | アバターソースのディレクトリを指定します。この引数を指定しない場合は`../src/`になります。 |
| -o, --dist-dir | 出力先ディレクトリまでのパス | 出力先のディレクトリを指定します。この引数を指定しない場合は`../dist/`になります。 |
| -w, --observe | なし | 監視モードでビルドツールを起動します。監視モードでは通常のビルドの後、ソースファイルの変更が検知されたら該当部分のみ自動で再ビルドします。 |
| -l, --colored | なし | 標準出力に色を付けます。ログ出力などの制御文字がそのまま出力される場合はオフにしてください。 |
| -d, --debug_output | なし | より細かいデバッグ出力を有効にします。 |
| -r, --release | なし | リリースモードとしてビルドします。デバッグ用に組み込まれた機能の削除やエンドポイントをリリース用への変更を行いながらビルドします。 |

## ビルドツールの動作

ビルドツールによってアバターがビルドされている間、次のような処理が実行されています：

1. コア及びキャラクター固有のモデル・テクスチャ・スクリプトのコピー

   コア及びキャラクター固有のモデル・テクスチャ・スクリプトを同じ出力先にコピーしてリソースを統合します。
   コアとキャラクター固有側に同じ相対パスのリソースがある場合は、キャラクター固有リソースで上書きされます。

2. "avatar.json"の生成

   "[avatar_template.json](#avatar_templatejson)"を基に、具体的な値を"[avatar_json_config.json](#avatar_json_configjson)"から挿入し、"avatar.json"を生成します。
   具体的な処理は[avatar_json_config.jsonの章](#avatar_json_configjson)を確認してください。

3. サムネイルの生成

   "[/thumbnail_templates/](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/blob/build_script_documentation/thumbnail_templates)"を基に、具体的なデータを"[thumbnail_config.json](#thumbnail_configjson)"や"[thumbnail.png](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/blob/build_script_documentation/src/avatars/01a_Shizuko/thumbnail.png)"から挿入し、サムネイル画像を生成します。
   "thumbnail.png"が存在しない場合はキャラクター画像の挿入をスキップしてサムネイル画像を生成します。

4. テクスチャ画像の圧縮

   "[pngquant](https://pngquant.org)"を用いてテクスチャ画像の圧縮を行います。

5. モデルファイルの変更

   モデルファイルを以下のように変更します。

   - 埋め込みテクスチャのデータを圧縮後のものに置換
   - テクスチャ画像の絶対パスの削除
   - 参考画像の削除
