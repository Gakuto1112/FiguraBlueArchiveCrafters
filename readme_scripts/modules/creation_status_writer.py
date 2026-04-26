import json
from pathlib import Path
from typing import NotRequired, TypedDict

from modules.paths import paths
from modules.logger import Logger
from modules.enums.template_locale import TemplateLocale


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

class CreationStatusWriter:
	"""
	アバターの作成状況をjsonファイルから読み出し、マークダウン形式に整えて出力するクラス
	"""

	CREATION_STATUS_JSON_PATH: Path = paths.root / "readme_scripts" / "creation_status.json"
	"""
	作成状況のjsonファイルまでのパス
	"""

	@staticmethod
	def read_creation_status() -> CreationStatusData:
		"""
		作成状況のjsonファイルを読み出し、そのデータをオブジェクトとして返す。
		読み出し元のjsonファイルのパスはクラスのメンバー定数から取得する。

		Returns:
			CreationStatusData: 作成状況のデータを格納したオブジェクト

		Raises:
			FileNotFoundError: 作成状況のjsonファイルが存在しない場合
			IsADirectoryError: 作成状況のjsonファイルがディレクトリである場合
			PermissionError: 作成状況のjsonファイルの読み取り権限がない場合
			json.JSONDecodeError: 作成状況のjsonファイルのJSONパースが失敗した場合
			TypeError: 作成状況のjsonファイルの内容がCreationStatusDataの構造に合わない場合
			IOError: その他の入出力エラーが発生した場合
		"""

		with open(CreationStatusWriter.CREATION_STATUS_JSON_PATH, "r") as f:
			return CreationStatusData(**json.load(f))

	@staticmethod
	def get_entries_md(creation_status_entries: list[CreationStatusEntry], locale: TemplateLocale, include_issue: bool) -> str:
		"""
		アバター作成状況データを受け取り、そこからのエントリーのリストをロケールに応じたマークダウンの形式に整えて返す。

		Args:
			creation_status_entries (list[CreationStatusEntry]): 作成状況のエントリーのリスト
			locale (TemplateLocale): 出力するマークダウンのロケール
			include_issue (bool): エントリーに関連するissueの番号やリンクをマークダウンに含めるかどうかのフラグ

		Returns:
			str: 作成済みエントリーのマークダウン形式の文字列
		"""

		result: str = ""
		for entry in creation_status_entries:
			result += "- "
			if locale == TemplateLocale.JP:
				result += f"{entry['character_name']['last_name']['jp']} {entry['character_name']['first_name']['jp']}".strip()
			else:
				result += f"{entry['character_name']['first_name']['en']} {entry['character_name']['last_name']['en']}".strip()
			if "costume_name" in entry and entry["costume_name"] is not None:
				if locale == TemplateLocale.JP:
					result += f"（{entry['costume_name']['jp']}）"
				else:
					result += f" ({entry['costume_name']['en']})"
			if include_issue and "issue_number" in entry and entry["issue_number"] is not None:
				if locale == TemplateLocale.JP:
					result += f"（[#{entry['issue_number']}](https://github.com/Gakuto1112/FiguraBlueArchiveCrafters/issues/{entry['issue_number']})）"
				else:
					result += f" ([#{entry['issue_number']}](https://github.com/Gakuto1112/FiguraBlueArchiveCrafters/issues/{entry['issue_number']}))"
			result += "\n"

		return result

	def debug() -> None:
		"""
		作成状況ライターのデバッグ動作を実行する。
		"""

		# デバッグ出力
		Logger.print_info("Creation status writer for FBAC readme generation tool")
		Logger.print_spacer(1)

		Logger.print_info(f"Reading creation status from {CreationStatusWriter.CREATION_STATUS_JSON_PATH}...")
		Logger.print_spacer(1)

		try:
			creation_status_data: CreationStatusData = CreationStatusWriter.read_creation_status()
		except Exception as e:
			Logger.print_error("Failed to read creation status data.")
			raise e

		Logger.print_info("Completed reading creation status data.")
		Logger.print_spacer(1)

		Logger.print_info("Writing done entries to standard output...")
		Logger.print_spacer(1)

		Logger.print_info(CreationStatusWriter.get_entries_md(creation_status_data['done'], TemplateLocale.JP, False))
		Logger.print_spacer(1)

		Logger.print_info("Writing in-progress entries to standard output...")
		Logger.print_spacer(1)

		Logger.print_info(CreationStatusWriter.get_entries_md(creation_status_data['in_progress'], TemplateLocale.JP, True))
		Logger.print_spacer(1)

		Logger.print_info("Writing planned entries to standard output...")
		Logger.print_spacer(1)

		Logger.print_info(CreationStatusWriter.get_entries_md(creation_status_data['planned'], TemplateLocale.JP, True))
		Logger.print_spacer(1)

		Logger.print_info("Writing requested entries to standard output...")
		Logger.print_spacer(1)

		Logger.print_info(CreationStatusWriter.get_entries_md(creation_status_data['requested'], TemplateLocale.JP, True))
		Logger.print_spacer(1)

if __name__ == "__main__":
	CreationStatusWriter.debug()