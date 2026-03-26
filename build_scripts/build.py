import argparse
import errno
from json import JSONDecodeError
from pathlib import Path

from modules.avatar_json_generator import AvatarJsonGenerator
from modules.errors.operation_cancelled_error import OperationCancelledError
from modules.file_ops import FileOperator
from modules.logger import Logger
from modules.paths import paths
from modules.thumbnail_generator import ThumbnailGenerator

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
	Logger.print_info("Preparing distribution directory...")

	try:
		if len(target_avatars) > 1:
			FileOperator.prepare_directory(paths.distribution_dir)
		elif len(target_avatars) == 1:
			FileOperator.prepare_directory(paths.distribution_dir / target_avatars[0])
		else:
			Logger.print_error("No target avatars specified for build.")
			exit(errno.EINVAL)
	except OperationCancelledError:
		Logger.print_info("Cancelled preparing the distribution directory.")
		exit(0)
	except NotADirectoryError:
		Logger.print_error("The specified distribution directory path is not a directory.")
		exit(errno.ENOTDIR)
	except PermissionError:
		Logger.print_error("No permission to prepare the distribution directory.")
		exit(errno.EACCES)
	except IOError:
		Logger.print_error("An unexpected error occurred while preparing the distribution directory.")
		exit(errno.EIO)

	Logger.print_info("Completed preparing distribution directory.")
	Logger.print_spacer(1)

	# アバターアセットのコピー
	Logger.print_info("Copying avatar assets...")

	try:
		for target_avatar in target_avatars:
			Logger.print_info(f"Copying assets for avatar \"{target_avatar}\" ({target_avatars.index(target_avatar) + 1}/{len(target_avatars)}) ...")
			FileOperator.copy_assets(target_avatar)
	except NotADirectoryError:
		Logger.print_error("The specified character directory path is not a directory.")
		exit(errno.ENOTDIR)
	except PermissionError:
		Logger.print_error("No permission to copy avatar assets.")
		exit(errno.EACCES)
	except FileNotFoundError:
		Logger.print_error("The specified character directory or core asset subdirectory does not exist.")
		exit(errno.ENOENT)
	except IOError:
		Logger.print_error("An unexpected error occurred while copying avatar assets.")
		exit(errno.EIO)

	Logger.print_info("Completed copying avatar assets.")
	Logger.print_spacer(1)

	# avatar.jsonの生成
	Logger.print_info("Generating avatar.json files...")

	try:
		for target_avatar in target_avatars:
			Logger.print_info(f"Generating avatar.json for avatar \"{target_avatar}\" ({target_avatars.index(target_avatar) + 1}/{len(target_avatars)}) ...")
			AvatarJsonGenerator.write_merged_avatar_json(target_avatar)
	except FileNotFoundError:
		Logger.print_error("Avatar JSON template file or avatar JSON config file not found.")
		exit(errno.ENOENT)
	except IsADirectoryError:
		Logger.print_error("Avatar JSON template file or avatar JSON config file is a directory.")
		exit(errno.EISDIR)
	except PermissionError:
		Logger.print_error("No permission to generate avatar.json files.")
		exit(errno.EACCES)
	except JSONDecodeError:
		Logger.print_error("Failed to parse avatar JSON template file or avatar JSON config file.")
		exit(errno.EINVAL)
	except IOError:
		Logger.print_error("An unexpected error occurred while generating avatar.json files.")
		exit(errno.EIO)

	Logger.print_info("Completed generating avatar.json files.")
	Logger.print_spacer(1)

	# サムネイル画像の生成
	if should_generate_thumbnails:
		Logger.print_info("Generating thumbnail images...")

		try:
			for target_avatar in target_avatars:
				Logger.print_info(f"Generating thumbnail image for avatar \"{target_avatar}\" ({target_avatars.index(target_avatar) + 1}/{len(target_avatars)}) ...")
				ThumbnailGenerator.save_thumbnail(target_avatar, ThumbnailGenerator.generate_thumbnail(target_avatar))
		except FileNotFoundError:
			Logger.print_error("Thumbnail config file not found.")
			exit(errno.ENOENT)
		except IsADirectoryError:
			Logger.print_error("Thumbnail config file or template image file is a directory.")
			exit(errno.EISDIR)
		except PermissionError:
			Logger.print_error("No permission to save generated thumbnail image.")
			exit(errno.EACCES)
		except JSONDecodeError:
			Logger.print_error("Failed to parse thumbnail config file.")
			exit(errno.EINVAL)
		except IOError:
			Logger.print_error("An unexpected error occurred while generating thumbnail images.")
			exit(errno.EIO)

		Logger.print_info("Completed generating thumbnail images.")
		Logger.print_spacer(1)
	else:
		Logger.print_info("Skipping thumbnail generation as per command line argument.")
		Logger.print_spacer(1)

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

	Logger.print_info("Figura Blue Archive Characters (FBAC) Avatar Build Tool")
	Logger.print_spacer(1)

	paths.source_dir = Path(args.src_dir)
	paths.distribution_dir = Path(args.dist_dir)
	global should_generate_thumbnails, is_observe_mode
	should_generate_thumbnails = not args.skip_thumbnails
	is_observe_mode = args.observe

	target_avatars: list[str] = []
	if args.character:
		target = next((avatar for avatar in paths.get_avatar_names() if args.character in avatar), None)
		if target is None:
			Logger.print_error(f"The specified character \"{args.character}\" does not exist in the character directory.")
			exit(errno.EPERM)

		target_avatars.append(target)
	else:
		target_avatars = list(paths.get_avatar_names())

	Logger.print_debug(f"Target avatars: {", ".join(target_avatars)}")
	Logger.print_debug(f"Source directory: {paths.source_dir}")
	Logger.print_debug(f"Distribution directory: {paths.distribution_dir}")
	Logger.print_spacer(1)

	build(tuple(target_avatars))

if __name__ == "__main__":
	main()
