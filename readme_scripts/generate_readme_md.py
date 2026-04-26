import argparse
from pathlib import Path

from modules.paths import paths
from modules.logger import Logger


def main():
	# 引数の設定
	parser = argparse.ArgumentParser(description="Readme generation tool for Figura Blue Archive Crafters (FBAC).")
	parser.add_argument("--template-dir", "-t", type=str, default=paths.template_dir, help="Overrides default template directory path. Default: ./template/")
	parser.add_argument("--dist-dir", "-o", type=str, default=paths.distribution_dir, help="Overrides default distribution directory path. Default: ../")
	parser.add_argument("--colored", "-l", action="store_true", help="Enables colored output in the terminal.")

	args = parser.parse_args()

	paths.template_dir = Path(args.template_dir)
	paths.distribution_dir = Path(args.dist_dir)
	Logger.is_colored = args.colored


if __name__ == "__main__":
    main()
