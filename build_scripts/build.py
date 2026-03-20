import argparse
from pathlib import Path

from modules.paths import paths


# サムネイル画像を生成するかどうかのフラグ
should_generate_thumbnails: bool = True

# スクリプトが監視モードかどうかのフラグ
is_observe_mode: bool = False

def build() -> None:
	pass

def main() -> None:
	"""
	エントリー関数
	"""
	# 引数の設定
	parser = argparse.ArgumentParser(description="Builds avatars for Figura Blue Archive Characters (FBAC).")

	parser.add_argument("--character", "-c", type=str, choices=paths.get_valid_avatar_names(), help="Specifies the character avatar to build. If not specified, all avatars will be built.")
	parser.add_argument("--src-dir", "-s", type=str, default=paths.source_dir, help="Overrides default source directory path. Default: ../src/")
	parser.add_argument("--dist-dir", "-d", type=str, default=paths.distribution_dir, help="Overrides default distribution directory path. Default: ../dist/")
	parser.add_argument("--skip-thumbnails", "-t", action="store_true", help="Skips thumbnail generation.")
	parser.add_argument("--observe", "-o", action="store_true", help="Observes the source directory for changes and automatically rebuilds the affected avatars.")

	args = parser.parse_args()
	paths.source_dir = Path(args.src_dir)
	paths.distribution_dir = Path(args.dist_dir)
	global should_generate_thumbnails, is_observe_mode
	should_generate_thumbnails = not args.skip_thumbnails
	is_observe_mode = args.observe

	target_avatars: list[str] = []
	if args.character:
		target = next((avatar for avatar in paths.get_avatar_names() if args.character in avatar), None)
		if target is None:
			raise ValueError(f"Specified character '{args.character}' does not exist in the character directory.")

		target_avatars.append(target)
	else:
		target_avatars = list(paths.get_avatar_names())

if __name__ == "__main__":
	main()
