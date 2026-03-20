import argparse
from modules import paths

def build():
	pass

def main():
	# 引数の設定
	parser = argparse.ArgumentParser(description="Builds avatars for Figura Blue Archive Characters (FBAC).")

	parser.add_argument("--character", "-c", type=str, choices=paths.get_valid_avatar_names(), help="Specifies the character avatar to build. If not specified, all avatars will be built.")
	parser.add_argument("--src-dir", "-s", type=str, default=paths.SOURCE_DIR, help=f"Overrides default source directory path. Default: {paths.SOURCE_DIR}")
	parser.add_argument("--dist-dir", "-d", type=str, default=paths.DISTRIBUTION_DIR, help=f"Overrides default distribution directory path. Default: {paths.DISTRIBUTION_DIR}")
	parser.add_argument("--skip-thumbnails", "-t", action="store_true", help="Skips thumbnail generation.")
	parser.add_argument("--observe", "-o", action="store_true", help="Observes the source directory for changes and automatically rebuilds the affected avatars.")

	args = parser.parse_args()

if __name__ == "__main__":
	main()
