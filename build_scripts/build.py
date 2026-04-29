import argparse
import errno
from json import JSONDecodeError
from pathlib import Path
import shutil

from modules.avatar_json_generator import AvatarJsonGenerator
from modules.errors.operation_cancelled_error import OperationCancelledError
from modules.file_ops import FileOperator
from modules.logger import Logger
from modules.observer import AvatarFileObserver
from modules.paths import paths
from modules.thumbnail_generator import ThumbnailGenerator
from modules.texture_compressor import TextureCompressor
from modules.bbmodel_modifier import BBModelModifier


def print_shittim_logo() -> None:
	"""
	「シッテムの箱」のロゴアスキーアートを標準出力する。

	Raises:
		FileNotFoundError: ロゴアスキーアートのテキストファイルが見つからない場合
		PermissionError: ロゴアスキーアートのテキストファイルを読み取る権限がない場合
		IOError: ロゴアスキーアートのテキストファイルの読み取り中に予期しないエラーが発生した場合
	"""

	with open(Path(__file__).parent.resolve() / "shittim.txt", "r", encoding="utf-8") as f:
		logo = f.read()
		Logger.print_spacer(1)
		if Logger.is_colored:
			print("\033[35m" if Logger.is_plana else "\033[36m", end="")
			Logger.print_info(logo)
			print("\033[0m", end="")
		else:
			Logger.print_info(logo)
		Logger.print_spacer(1)

def build(target_avatars: tuple[str, ...], as_release: bool = False, no_ignored_textures: bool = False) -> None:
	"""
	アバターをビルドし、Figuraで使用可能な形式にする。

	Args:
		target_avatars (list[str]): ビルドするアバターの名前のリスト。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。
		as_release (bool): リリースアセットとしてビルドするかどうか。
		no_ignored_textures (bool): "avatar.json"内の`ignoredTextures`フィールドを空にするかどうか。開発版Figuraの不具合への対応。これを`true`にするとアバターの容量が増加する。
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

	# tmpディレクトリの準備
	true_dist_dir: Path|None = None
	if not paths.distribution_dir.samefile(paths.root / "dist"):
		true_dist_dir = paths.distribution_dir
		tmp_dir = paths.root / ".fbac_build_tmp"
		if tmp_dir.exists():
			try:
				shutil.rmtree(tmp_dir)
			except PermissionError:
				Logger.print_error("No permission to clear the temporary directory.")
				exit(errno.EACCES)
			except IOError:
				Logger.print_error("An unexpected error occurred while clearing the temporary directory.")
				exit(errno.EIO)
		(paths.root / ".fbac_build_tmp").mkdir(parents=True, exist_ok=True)
		paths.distribution_dir = tmp_dir

	# アバターアセットのコピー
	Logger.print_info("Copying avatar assets...")

	try:
		for target_avatar in target_avatars:
			Logger.print_info(f"Copying assets for avatar \"{target_avatar}\" ({target_avatars.index(target_avatar) + 1}/{len(target_avatars)}) ...")
			FileOperator.copy_assets(target_avatar, as_release)
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
			AvatarJsonGenerator.write_merged_avatar_json(target_avatar, no_ignored_textures)
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

	# テクスチャの圧縮
	Logger.print_info("Compressing textures...")

	try:
		for target_avatar in target_avatars:
			Logger.print_info(f"Compressing textures for avatar \"{target_avatar}\" ({target_avatars.index(target_avatar) + 1}/{len(target_avatars)}) ...")
			TextureCompressor.compress_avatar_textures(target_avatar)
	except RuntimeError as e:
		Logger.print_error("An error occurred from pngquant while compressing textures.")
		exit(errno.EPERM)

	Logger.print_info("Completed compressing textures.")
	Logger.print_spacer(1)

	# BBモデルファイルの編集
	Logger.print_info("Modifying BBModel files...")

	try:
		for target_avatar in target_avatars:
			Logger.print_info(f"Modifying BBModel files for avatar \"{target_avatar}\" ({target_avatars.index(target_avatar) + 1}/{len(target_avatars)}) ...")
			BBModelModifier.modify_avatar_bbmodels(target_avatar)
	except FileNotFoundError as e:
		Logger.print_error(f"A BBModel file is not found for avatar \"{target_avatar}\".")
		exit(errno.ENOENT)
	except IsADirectoryError:
		Logger.print_error(f"A BBModel file for avatar \"{target_avatar}\" is a directory.")
		exit(errno.EISDIR)
	except PermissionError:
		Logger.print_error(f"No permission to read/write a BBModel file for avatar \"{target_avatar}\".")
		exit(errno.EACCES)
	except JSONDecodeError:
		Logger.print_error(f"Failed to parse a BBModel file for avatar \"{target_avatar}\".")
		exit(errno.EINVAL)
	except IOError:
		Logger.print_error(f"An unexpected error occurred while modifying BBModel files for avatar \"{target_avatar}\".")
		exit(errno.EIO)

	Logger.print_info("Completed modifying BBModel files.")
	Logger.print_spacer(1)

	if true_dist_dir is not None:
		# tmpディレクトリから本来の出力先ディレクトリへファイルを移動
		Logger.print_info("Moving built avatar assets to the distribution directory...")

		try:
			shutil.copytree(paths.distribution_dir, true_dist_dir, dirs_exist_ok=True)
			shutil.rmtree(paths.distribution_dir)
		except PermissionError:
			Logger.print_error("No permission to move built avatar assets to the distribution directory.")
			exit(errno.EACCES)
		except IOError:
			Logger.print_error("An unexpected error occurred while moving built avatar assets to the distribution directory.")
			exit(errno.EIO)

		paths.distribution_dir = true_dist_dir
		Logger.print_info("Completed moving built avatar assets to the distribution directory.")
		Logger.print_spacer(1)


def main() -> None:
	"""
	エントリー関数
	"""

	# 引数の設定
	parser = argparse.ArgumentParser(description="Builds avatars for Figura Blue Archive Crafters (FBAC).")

	parser.add_argument("--character", "-c", type=str, choices=paths.get_valid_avatar_names(), help="Specifies the character avatar to build. If not specified, all avatars will be built. This option is ignored in observe mode.")
	parser.add_argument("--src-dir", "-i", type=str, default=paths.source_dir, help="Overrides default source directory path. Default: ../src/")
	parser.add_argument("--dist-dir", "-o", type=str, default=paths.distribution_dir, help="Overrides default distribution directory path. Default: ../dist/")
	parser.add_argument("--observe", "-w", action="store_true", help="Executes the tool in observation mode. In this mode, the tool will observe the source directory for changes and automatically rebuild the affected avatars.")
	parser.add_argument("--colored", "-l", action="store_true", help="Enables colored output in the terminal.")
	parser.add_argument("--debug-output", "-d", action="store_true", help="Enables debug outputs.")
	parser.add_argument("--release", "-r", action="store_true", help="Builds avatars as release assets.")
	parser.add_argument("--no-ignored-textures", "-n", action="store_true", help="Disables texture ignorance features for avatars. The size of the avatar will be larger than normal builds.")

	args = parser.parse_args()

	# 引数の処理
	paths.source_dir = Path(args.src_dir)
	paths.distribution_dir = Path(args.dist_dir)
	if args.colored:
		Logger.is_colored = True
	if args.debug_output:
		Logger.should_print_debug_log = True

	try:
		print_shittim_logo()
	except FileNotFoundError:
		Logger.print_error("Failed to load the Shittim logo because of missing logo files.")
	except PermissionError:
		Logger.print_error("No permission to read the Shittim logo file.")
	except IOError:
		Logger.print_error("An unexpected error occurred while loading the Shittim logo.")

	if Logger.is_colored:
		Logger.print_info("\033[1mFigura Blue Archive Crafters (FBAC) Avatar Build Tool\033[0m")
		Logger.print_spacer(1)
	else:
		Logger.print_info("Figura Blue Archive Crafters (FBAC) Avatar Build Tool")
		Logger.print_spacer(1)
	if Logger.is_plana:
		Logger.print_plana("Welcome Back. Sensei.")
	else:
		Logger.print_arona("Welcome Back! Sensei!")
	Logger.print_spacer(1)

	if args.observe:
		# 監視モード
		Logger.print_info("Observation mode specified. The tool will observe the source directory for changes and automatically rebuild the affected avatars.")
		Logger.print_spacer(1)

		Logger.print_debug(f"Source directory: {paths.source_dir}")
		Logger.print_debug(f"Distribution directory: {paths.distribution_dir}")
		Logger.print_spacer(1)

		Logger.print_info("Initializing the distribution directory...")
		Logger.print_spacer(1)

		build(tuple(paths.get_avatar_names()), no_ignored_textures=args.no_ignored_textures)

		if args.character:
			Logger.print_warning("The --character / -c option is ignored in observe mode. All characters will be observed for changes.")
		if args.release:
			Logger.print_warning("The --release / -r option is ignored in observer mode. All characters will be built as debug assets.")
		Logger.print_spacer(1)

		Logger.print_info("Observation mode started. Press Ctrl+C to stop observing and exit the tool.")
		Logger.print_spacer(1)

		if Logger.is_plana:
			Logger.print_plana("Everything is ready. Good luck. Sensei.")
		else:
			Logger.print_arona("Everything is ready! Good luck! Sensei!")
		Logger.print_spacer(1)

		AvatarFileObserver.observe()

	else:
		# 通常のビルドモード
		target_avatars: list[str] = []
		if args.character:
			target = next((avatar for avatar in paths.get_avatar_names() if args.character in avatar), None)
			if target is None:
				Logger.print_error(f"The specified character \"{args.character}\" does not exist in the character directory.")
				exit(errno.EPERM)

			target_avatars.append(target)
		else:
			target_avatars = list(paths.get_avatar_names())

		if args.release:
			target_avatars.remove("00a_base")

		target_avatars.sort()

		Logger.print_debug(f"Target avatars: {", ".join(target_avatars)}")
		Logger.print_debug(f"Build mode: {'Release' if args.release else 'Debug'}")
		Logger.print_debug(f"Source directory: {paths.source_dir}")
		Logger.print_debug(f"Distribution directory: {paths.distribution_dir}")
		Logger.print_spacer(1)

		build(tuple(target_avatars), args.release, args.no_ignored_textures)

if __name__ == "__main__":
	main()
