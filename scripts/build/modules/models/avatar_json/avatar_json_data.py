from typing import NotRequired, TypedDict


class AvatarJsonData(TypedDict):
	"""
	`avatar.json`の構造体
	"""

	name: NotRequired[str]
	"""
	アバターの名前
	"""

	description: NotRequired[str]
	"""
	アバターの説明文
	"""

	author: NotRequired[str]
	"""
	アバターの作者（単一）
	`authors`も指定されている場合、このフィールドは無視される。
	"""

	authors: NotRequired[list[str]]
	"""
	アバターの作者（複数）
	`author`も指定されている場合、このフィールドが優先される。
	"""

	version: NotRequired[str]
	"""
	このアバターが対応している最低のFiguraのバージョン
	"""

	color: NotRequired[str]
	"""
	アバター使用時に適用する、Figuraの三角マークの色
	16進数カラーコードで指定する。（例: "ff0000"）
	"""

	autoScripts: NotRequired[list[str]]
	"""
	アバター読み込み時に、自動的に読み込まれるスクリプトのリスト
	アバターのルートディレクトリから参照し、ディレクトリのパス区切りをピリオドで表記し、拡張子は除く。（例: `/scripts/avatar.lua` → "scripts.avatar"）
	このフィールドを指定しない場合は、アバター内に含まれる全てのスクリプトが順不同で実行される。
	"""

	autoAnims: NotRequired[list[str]]
	"""
	アバター読み込み時に、自動的に再生するBBアニメーションのリスト
	アバターのルートディレクトリから参照し、ディレクトリのパス区切りをピリオドで表記し、拡張子は除く。その後にBBアニメーションIDをピリオドから指定する。（例: `/models/model.bbmodel - idle` → "models.model.idle"）
	"""

	ignoredTextures: NotRequired[list[str]]
	"""
	アバターに含めないテクスチャ画像のリスト
	アバターのルートディレクトリから参照し、ディレクトリのパス区切りをピリオドで表記し、拡張子は除く。（例: `/textures/texture.png` → "textures.texture"）
	"""

	customizations: NotRequired[dict[str, dict[str, str|bool]]]
	"""
	アバター読み込み時に自動加工するモデルパーツのリスト
	キーはモデルパーツを指定し、値は加工のオプションを指定する。
	モデルパーツの指定は、スクリプトからモデルパーツを参照する際と同様に指定する。（例: "models.models.main.Avatar.Head"）
	"""
