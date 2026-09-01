from typing import NotRequired, TypedDict


class AvatarMetaPlaceholderData(TypedDict):
	"""
	テンプレートjsonデータ内のプレイスホルダーと置換する値の構造体
	"""

	avatar_id: str
	"""
	アバターのID
	このフィールドはスクリプトで上書きする。
	（例: "01a"）
	"""

	first_name: str
	"""
	生徒の下の名前（名）
	（例: "Shizuko"）
	"""

	last_name: str
	"""
	生徒の上の名前（姓）
	（例: "Kawawa"）
	"""

	costume_name: NotRequired[str]
	"""
	衣装名
	デフォルト衣装の場合は、このフィールドは空になる。
	（例: "Swimsuit"）
	"""
