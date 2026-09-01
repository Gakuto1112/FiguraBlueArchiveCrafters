from typing import NotRequired, TypedDict

from .avatar_meta_placeholder_data import AvatarMetaPlaceholderData


class AvatarJsonConfig(TypedDict):
	"""
	テンプレートjsonデータと統合する特定のキャラクターのメタデータの構造体
	"""

	placeholders: AvatarMetaPlaceholderData
	"""
	テンプレートjsonデータ内のプレイスホルダーと置換する値のリスト
	"""

	ignoredTextures: NotRequired[list[str]]
	"""
	アバターに含めないテクスチャ画像のリスト
	アバターのルートディレクトリから参照し、ディレクトリのパス区切りをピリオドで表記し、拡張子は除く。（例: `/textures/texture.png` → "textures.texture"）
	テンプレートjsonデータ内の同名フィールドと統合される。
	"""

	autoAnims: NotRequired[list[str]]
	"""
	アバター読み込み時に、自動的に再生するBBアニメーションのリスト
	アバターのルートディレクトリから参照し、ディレクトリのパス区切りをピリオドで表記し、拡張子は除く。その後にBBアニメーションIDをピリオドから指定する。（例: `/models/model.bbmodel - idle` → "models.model.idle"）
	テンプレートjsonデータ内の同名フィールドと統合される。
	"""

	customizations: NotRequired[dict[str, dict[str, str|bool]]]
	"""
	アバター読み込み時に自動加工するモデルパーツのリスト
	キーはモデルパーツを指定し、値は加工のオプションを指定する。
	モデルパーツの指定は、スクリプトからモデルパーツを参照する際と同様に指定する。（例: "models.models.main.Avatar.Head"）
	テンプレートjsonデータ内の同名フィールドと統合される。
	"""
