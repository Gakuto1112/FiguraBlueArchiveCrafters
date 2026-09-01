from typing import TypedDict

from .display_name_data import DisplayNameData


class CharacterNameData(TypedDict):
	"""
	キャラクターの名前を格納する構造体
	"""

	first_name: DisplayNameData
	"""
	下の名前（名）
	"""

	last_name: DisplayNameData
	"""
	上の名前（姓）
	"""
