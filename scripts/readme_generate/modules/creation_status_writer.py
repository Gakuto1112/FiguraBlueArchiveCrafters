import json

from common_modules.logger import Logger
from readme_generate.modules.enums.template_locale import TemplateLocale
from readme_generate.modules.paths import paths
from .models.creation_status.creation_status_data import CreationStatusData
from .models.creation_status.creation_status_entry import CreationStatusEntry


class CreationStatusWriter:
	"""
	アバターの作成状況をjsonファイルから読み出し、マークダウン形式に整えて出力するクラス
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

		with open(paths.creation_status_json_path(), "r") as f:
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

	@staticmethod
	def debug() -> None:
		"""
		作成状況ライターのデバッグ動作を実行する。
		"""

		# デバッグ出力
		Logger.print_info("Creation status writer for FBAC readme generation tool")
		Logger.print_spacer(1)

		Logger.print_info(f"Reading creation status from {paths.creation_status_json_path()}...")
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
