from enum import Enum

class AvatarDataSubdirectory(Enum):
	"""
	アバターデータのサブディレクトリを表す列挙型
	"""

	MODELS = "models"
	"""
	モデルディレクトリ
	"""

	TEXTURES = "textures"
	"""
	テクスチャディレクトリ
	"""

	SCRIPTS = "scripts"
	"""
	スクリプトディレクトリ
	"""
