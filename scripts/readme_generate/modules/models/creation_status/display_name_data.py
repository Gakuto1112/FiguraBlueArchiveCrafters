from typing import TypedDict


class DisplayNameData(TypedDict):
	"""
	表示名を格納する構造体
	"""

	en: str
	"""
	英語での表示名
	"""

	jp: str
	"""
	日本語での表示名
	"""
