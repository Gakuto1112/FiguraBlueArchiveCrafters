import argparse
import errno
from pathlib import Path

from modules.avatar_json_generator import json_generator
from modules.file_ops import file_ops
from modules.logger import logger
from modules.paths import paths
from modules.thumbnail_generator import thumbnail_generator

should_generate_thumbnails: bool = True
"""
サムネイル画像を生成するかどうかのフラグ
"""

is_observe_mode: bool = False
"""
スクリプトが監視モードかどうかのフラグ
"""

def build(target_avatars: tuple[str, ...]) -> None:
	"""
	アバターをビルドし、Figuraで使用可能な形式にする。

	Args:
		target_avatars (list[str]): ビルドするアバターの名前のリスト。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。
	"""

	# 出力先ディレクトリの準備
	logger.print_info("Preparing distribution directory...")
	if len(target_avatars) > 1:
		file_ops.prepare_directory(paths.distribution_dir)
	elif len(target_avatars) == 1:
		file_ops.prepare_directory(paths.distribution_dir / target_avatars[0])
	else:
		logger.print_error("No target avatars specified for build.")
		exit(errno.EINVAL)
	logger.print_info("Completed preparing distribution directory.")
	logger.print_spacer(1)

	# アバターアセットのコピー
	logger.print_info("Copying avatar assets...")
	for target_avatar in target_avatars:
		logger.print_info(f"Copying assets for avatar \"{target_avatar}\" ({target_avatars.index(target_avatar) + 1}/{len(target_avatars)}) ...")
		file_ops.copy_assets(target_avatar)
	logger.print_info("Completed copying avatar assets.")
	logger.print_spacer(1)

	# avatar.jsonの生成
	logger.print_info("Generating avatar.json files...")
	for target_avatar in target_avatars:
		logger.print_info(f"Generating avatar.json for avatar \"{target_avatar}\" ({target_avatars.index(target_avatar) + 1}/{len(target_avatars)}) ...")
		json_generator.write_merged_avatar_json(target_avatar)
	logger.print_info("Completed generating avatar.json files.")
	logger.print_spacer(1)

	# サムネイル画像の生成
	if should_generate_thumbnails:
		logger.print_info("Generating thumbnail images...")
		for target_avatar in target_avatars:
			logger.print_info(f"Generating thumbnail image for avatar \"{target_avatar}\" ({target_avatars.index(target_avatar) + 1}/{len(target_avatars)}) ...")
			thumbnail_generator.save_thumbnail(target_avatar, thumbnail_generator.generate_thumbnail(target_avatar))
		logger.print_info("Completed generating thumbnail images.")
		logger.print_spacer(1)
	else:
		logger.print_info("Skipping thumbnail generation as per command line argument.")
		logger.print_spacer(1)

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

	logger.print_info("Figura Blue Archive Characters (FBAC) Avatar Build Tool")
	logger.print_spacer(1)

	paths.source_dir = Path(args.src_dir)
	paths.distribution_dir = Path(args.dist_dir)
	global should_generate_thumbnails, is_observe_mode
	should_generate_thumbnails = not args.skip_thumbnails
	is_observe_mode = args.observe

	target_avatars: list[str] = []
	if args.character:
		target = next((avatar for avatar in paths.get_avatar_names() if args.character in avatar), None)
		if target is None:
			logger.print_error(f"Specified character \"{args.character}\" does not exist in the character directory.")
			exit(errno.EPERM)

		target_avatars.append(target)
	else:
		target_avatars = list(paths.get_avatar_names())

	logger.print_debug(f"Target avatars: {", ".join(target_avatars)}")
	logger.print_debug(f"Source directory: {paths.source_dir}")
	logger.print_debug(f"Distribution directory: {paths.distribution_dir}")
	logger.print_spacer(1)

	build(tuple(target_avatars))

if __name__ == "__main__":
	main()
