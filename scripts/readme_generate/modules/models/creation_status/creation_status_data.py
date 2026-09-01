from typing import TypedDict

from .creation_status_entry import CreationStatusEntry


class CreationStatusData(TypedDict):
	"""
	アバターの作成状況のjsonデータの構造体
	"""

	done: list[CreationStatusEntry]
	"""
	作成済みのエントリーのリスト
	"""

	in_progress: list[CreationStatusEntry]
	"""
	作成中のエントリーのリスト
	"""

	planned: list[CreationStatusEntry]
	"""
	作成予定のエントリーのリスト
	"""

	requested: list[CreationStatusEntry]
	"""
	様々なところで作成をお願いされたエントリーのリスト
	"""
