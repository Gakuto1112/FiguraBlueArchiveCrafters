from typing import NotRequired, TypedDict

from .character_name_data import CharacterNameData
from .display_name_data import DisplayNameData


class CreationStatusEntry(TypedDict):
	"""
	作成状況のエントリー単体を格納する構造体
	"""

	character_name: CharacterNameData
	"""
	エントリー対象のキャラクターの名前
	"""

	costume_name: NotRequired[DisplayNameData]
	"""
	エントリーされたキャラクターの衣装名
	衣装違いの場合のみ値が入る。そうでない場合はNoneになる。
	"""

	issue_number: NotRequired[int]
	"""
	エントリーに関連するissueの番号
	該当のissueがない場合はNoneになる。
	"""
