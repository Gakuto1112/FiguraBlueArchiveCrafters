import argparse
from datetime import datetime
import errno
import json
import re
from pathlib import Path

from modules.paths import paths
from modules.logger import Logger
from modules.enums.template_locale import TemplateLocale
from modules.template_reader import TemplateReader


def read_template(locale: TemplateLocale) -> str:
	"""
	指定されたロケールのテンプレート文章を読み出す。

	Args:
		locale (TemplateLocale): 読み出すテンプレートのロケール

	Returns:
		str: 読み出されたテンプレート文章

	Raises:
		FileNotFoundError: テンプレートファイルが存在しない場合
		IsADirectoryError: テンプレートファイルがディレクトリである場合
		PermissionError: テンプレートファイルの読み取り権限がない場合
		IOError: その他の入出力エラーが発生した場合
	"""

	with open(paths.template_dir / f"{locale.name.lower()}.txt", "r") as f:
		return f.read()

def generate_readme_txt(locale: TemplateLocale, tag_name: str, release_date: datetime) -> None:
	"""
	テンプレートからREADME.txtを生成し、出力先ディレクトリに出力する。
	en.txt → README.txt, jp.txt → お読みください.txt と出力する。
	出力先ディレクトリ内に、既に同名のファイルが存在する場合は上書きする。

	Args:
		locale (TemplateLocale): 生成するREADMEのロケール
		tag_name (str): 生成するREADMEに記載するタグ名
		release_date (datetime.datetime): 生成するREADMEに記載するリリース日
	"""

	result: str = ""

	# テンプレートの読み込み
	Logger.print_info("Reading template...")

	try:
		result = read_template(locale)
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

	# マークダウンテンプレートの読み込み
	Logger.print_info("Reading markdown template...")
	md_result: str = ""

	try:
		md_result = TemplateReader.read_template(locale)
	except FileNotFoundError:
		Logger.print_error(f"Markdown template file for locale {locale.name} not found.")
		exit(errno.ENOENT)
	except IsADirectoryError:
		Logger.print_error(f"Markdown template file for locale {locale.name} is a directory.")
		exit(errno.EISDIR)
	except PermissionError:
		Logger.print_error(f"No permission to read markdown template file for locale {locale.name}.")
		exit(errno.EACCES)
	except IOError:
		Logger.print_error(f"An unexpected error occurred while reading markdown template file for locale {locale.name}.")
		exit(errno.EIO)

	Logger.print_info("Completed reading template.")
	Logger.print_spacer(1)

	Logger.print_info("Replacing anchors...")

	# タグ名とリリース日の置換
	result = result.replace("${TAG_NAME}", tag_name)
	result = result.replace("${RELEASE_DATE}", release_date.strftime("%Y/%m/%d" if locale == TemplateLocale.JP else "%m/%d/%Y"))

	# ドキュメントブロックタグの置換
	for tag in ("DESCRIPTION", "USAGE", "NOTES"):
		block_contents = re.search(rf"<!--\s*{tag}_START\s*-->(.*?)<!--\s*{tag}_END\s*-->", md_result, re.DOTALL)
		if block_contents is not None:
			block_contents_str = block_contents.group(1).strip()
			block_contents_str = re.sub(r"\[(.+?)\]\(.+?\)", r"\1", block_contents_str)
			block_contents_str = re.sub(r"\*{2}", "", block_contents_str)
			block_contents_str = re.sub(r"#{2}", "#", block_contents_str)
			result = re.sub(rf" *\${{{tag}}} *", block_contents_str, result, flags=re.DOTALL)
		else:
			Logger.print_warning(f"Failed to find content for block tag {tag} in markdown template for locale {locale.name}. The tag will be left unreplaced.")

	Logger.print_info("Completed replacing anchors.")
	Logger.print_spacer(1)

	# 生成済みドキュメントの出力
	Logger.print_info("Writing document...")

	try:
		with open(paths.distribution_dir / f"{"お読みください" if locale == TemplateLocale.JP else "README"}.txt", "w") as f:
			f.write(result)
	except PermissionError:
		Logger.print_error(f"No permission to write output README.txt for locale {locale.name}.")
		exit(errno.EACCES)
	except IOError:
		Logger.print_error(f"An unexpected error occurred while writing output README.txt for locale {locale.name}.")
		exit(errno.EIO)

	Logger.print_info("Completed writing document.")
	Logger.print_spacer(1)

def main() -> None:
	# 引数の設定
	parser = argparse.ArgumentParser(description="Readme generation tool for Figura Blue Archive Crafters (FBAC).")
	parser.add_argument("tag_name", type=str, help="Tag name to be added to the generated readme document.")
	parser.add_argument("release_date", type=str, help="Release date to be added to the generated readme document.")
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

		generate_readme_txt(locale, args.tag_name, datetime.fromisoformat(args.release_date).date())

	Logger.print_info(f"Completed generating all readme documents ({len(TemplateLocale)} locales).")

if __name__ == "__main__":
	main()
