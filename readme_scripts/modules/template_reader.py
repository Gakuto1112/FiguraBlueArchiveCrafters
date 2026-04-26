from modules.enums.template_locale import TemplateLocale
from modules.paths import paths
from modules.logger import Logger


class TemplateReader:
	"""
	テンプレートファイルからテンプレート文章を読み出すユーティリティクラス。
	"""

	@staticmethod
	def read_template(locale: TemplateLocale) -> str:
		"""
		指定されたロケールのテンプレート文章を読み出す。

		Args:
			local (TemplateLocale): 読み出すテンプレートのロケール

		Returns:
			str: 読み出されたテンプレート文章

		Raises:
			FileNotFoundError: テンプレートファイルが存在しない場合
			IsADirectoryError: テンプレートファイルがディレクトリである場合
			PermissionError: テンプレートファイルの読み取り権限がない場合
			IOError: その他の入出力エラーが発生した場合
		"""

		with open(paths.template_dir / f"{locale.name.lower()}.md", "r") as f:
			return f.read()

	@staticmethod
	def debug() -> None:
		"""
		テンプレートリーダーのデバッグ動作を実行する。
		"""

		Logger.print_info("Template reader for FBAC readme generation tool")
		Logger.print_spacer(1)

		Logger.print_info("Reading EN template...")
		print(TemplateReader.read_template(TemplateLocale.EN))
		Logger.print_info("Completed reading EN template.")
		Logger.print_spacer(1)

		Logger.print_info("Reading JP template...")
		print(TemplateReader.read_template(TemplateLocale.JP))
		Logger.print_info("Completed reading JP template.")
		Logger.print_spacer(1)

if __name__ == "__main__":
	TemplateReader.debug()
