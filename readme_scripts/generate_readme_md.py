import argparse
import errno
from pathlib import Path

from modules.paths import paths
from modules.logger import Logger
from modules.enums.template_locale import TemplateLocale
from modules.template_reader import TemplateReader


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
