from enum import IntEnum


class ThumbnailColorType(IntEnum):
	"""
	サムネイルの色付き枠で使用する色の種類を表す列挙型
	タイプ名は本家ブルーアーカイブの属性名と対応する。
	"""

	EXPLOSIVE = 0
	"""
	爆発（赤）
	"""

	PENETRATION = 1
	"""
	貫通（黄）
	"""

	CHEMICAL = 2
	"""
	分解（緑）
	"""

	MYSTIC = 3
	"""
	神秘（青）
	"""

	SONIC = 4
	"""
	振動（紫）
	"""
