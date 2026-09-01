from typing import TypedDict


class ThumbnailConfig(TypedDict):
	"""
	サムネイル設定ファイルの構造体
	"""

	colorType: str
	"""
	サムネイルの色付き枠で使用する色の種類
	`ThumbnailColorType`のいずれかを指定する。
	"""
