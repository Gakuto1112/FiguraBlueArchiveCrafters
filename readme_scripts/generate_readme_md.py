import argparse
import errno
import json
import re
from pathlib import Path

from modules.paths import paths
from modules.logger import Logger
from modules.enums.template_locale import TemplateLocale
from modules.template_reader import TemplateReader
from modules.creation_status_writer import CreationStatusWriter


def generate_readme_md(locale: TemplateLocale) -> None:
	"""
	テンプレートからREADME.mdを生成し、出力先ディレクトリに出力する。
	en.md → README.md, jp.md → README_JP.md と出力する。
	出力先ディレクトリ内に、既に同名のファイルが存在する場合は上書きする。
	"""

	result: str = ""

	# テンプレートの読み込み
	Logger.print_info("Reading template...")

	try:
		result = TemplateReader.read_template(locale)
	except FileNotFoundError:
		Logger.print_error(f"Template file for locale {locale.name} not found.")
		exit(errno.ENOENT)
	except IsADirectoryError:
		Logger.print_error(f"Template file for locale {locale.name} is a directory.")
		exit(errno.EISDIR)
	except PermissionError:
		Logger.print_error(f"No permission to read template file for locale {locale.name}.")
		exit(errno.EACCES)
	except IOError:
		Logger.print_error(f"An unexpected error occurred while reading template file for locale {locale.name}.")
		exit(errno.EIO)

	Logger.print_info("Completed reading template.")
	Logger.print_spacer(1)

	# 作成状況の置換
	Logger.print_info("Replacing creation status...")

	try:
		creation_status_data = CreationStatusWriter.read_creation_status()
		for category in ("done", "in_progress", "planned", "requested"):
			entries_md = CreationStatusWriter.get_entries_md(creation_status_data[category], locale, category != "done")
			if len(entries_md) == 0:
				if category == "done":
					entries_md = "（現在利用可能なキャラクターはいません。）" if locale == TemplateLocale.JP else "(There is no character available now.)"
				elif category == "in_progress":
					entries_md = "（現在作成中のアバターはありません。）" if locale == TemplateLocale.JP else "(There is no avatar currently being created.)"
				elif category == "planned":
					entries_md = "（作成予定のアバターはありません。）" if locale == TemplateLocale.JP else "(There is no avatar planned to be created.)"
				elif category == "not_planned":
					entries_md = "（リクエストされたアバターはありません。）" if locale == TemplateLocale.JP else "(There is no requested avatar.)"
				entries_md += "\n"

			entries_md += "\n"
			result = re.sub(rf" *<!--\sCREATION_STATUS_{category.upper()}\s-->\s*\n", entries_md, result)
	except FileNotFoundError:
		Logger.print_error(f"Creation status JSON file not found.")
		exit(errno.ENOENT)
	except IsADirectoryError:
		Logger.print_error(f"Creation status JSON file is a directory.")
		exit(errno.EISDIR)
	except PermissionError:
		Logger.print_error(f"No permission to read creation status JSON file.")
		exit(errno.EACCES)
	except json.JSONDecodeError:
		Logger.print_error(f"Failed to parse creation status JSON file.")
		exit(errno.EINVAL)
	except TypeError:
		Logger.print_error(f"Creation status JSON file has invalid structure.")
		exit(errno.EINVAL)
	except IOError:
		Logger.print_error(f"An unexpected error occurred while reading creation status JSON file.")
		exit(errno.EIO)

	# 画像URLの修正
	result = result.replace("../images/", "./readme_scripts/images/")

	# 不要なアンカータグの削除
	result = re.sub(r" *<!--.+--> *\n", "", result)

	# 生成済みドキュメントの出力
	Logger.print_info("Writing document...")

	try:
		with open(paths.distribution_dir / f"README{'' if locale == TemplateLocale.EN else '_JP'}.md", "w") as f:
			f.write(result)
	except PermissionError:
		Logger.print_error(f"No permission to write output README.md for locale {locale.name}.")
		exit(errno.EACCES)
	except IOError:
		Logger.print_error(f"An unexpected error occurred while writing output README.md for locale {locale.name}.")
		exit(errno.EIO)

	Logger.print_info("Completed writing document.")
	Logger.print_spacer(1)

def main() -> None:
	# 引数の設定
	parser = argparse.ArgumentParser(description="Readme generation tool for Figura Blue Archive Crafters (FBAC).")
	parser.add_argument("--template-dir", "-t", type=str, default=paths.template_dir, help="Overrides default template directory path. Default: ./template/")
	parser.add_argument("--dist-dir", "-o", type=str, default=paths.distribution_dir, help="Overrides default distribution directory path. Default: ../")
	parser.add_argument("--colored", "-l", action="store_true", help="Enables colored output in the terminal.")

	args = parser.parse_args()

	paths.template_dir = Path(args.template_dir)
	paths.distribution_dir = Path(args.dist_dir)
	Logger.is_colored = args.colored

	for i, locale in enumerate(TemplateLocale):
		Logger.print_info(f"Generating readme for locale {locale.name} ({i + 1}/{len(TemplateLocale)})...")
		Logger.print_spacer(1)

		generate_readme_md(locale)

	Logger.print_info(f"Completed generating all readme documents ({len(TemplateLocale)} locales).")

if __name__ == "__main__":
	main()
