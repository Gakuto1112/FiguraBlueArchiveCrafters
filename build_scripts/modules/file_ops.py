import argparse
import errno
import shutil
import textwrap
from pathlib import Path

from modules.logger import logger
from modules.paths import paths

target_directory_path: Path = paths.distribution_dir
"""
出力先ディレクトリのパス（デバッグ用変数）
"""

def prepare_directory(dir_path: Path) -> None:
	"""
	指定されたディレクトリの準備を行う。
	ディレクトリが存在しなければ新たに作成し、存在する場合はディレクトリ内のファイルやサブディレクトリを削除する。
	ルートディレクトリ外のパスが指定された場合はユーザーに確認を求める。

	Args:
		dir_path (Path): 準備するディレクトリのパス
	"""

	try:
		if dir_path.exists():
			# ディレクトリの確認

			# 出力先ディレクトリ内のファイルを削除
			if any(dir_path.iterdir()):
				logger.print_info(f"Cleaning up existing files in distribution directory...")
				if not dir_path.is_relative_to(paths.root):
					logger.print_warning(f"You specified distribution directory ({dir_path}) is outside of the root directory! All items in the distribution directory will be deleted!")
					answer = input("Are you sure you want to proceed? [y/N]: ")
					if not answer.lower() in ("y", "yes"):
						logger.print_info("Directory cleanup cancelled. Build aborted.")
						exit(0)
			for item in dir_path.iterdir():
				if item.is_dir():
					shutil.rmtree(item)
				else:
					item.unlink()
		else:
			logger.print_info(f"Distribution directory does not exist. Creating new directory...")
			dir_path.mkdir(parents=True)
	except NotADirectoryError:
		logger.print_error(f"Specified distribution directory is not a directory ({dir_path})")
		exit(errno.ENOTDIR)
	except PermissionError:
		logger.print_error(f"No permission to operate on specified distribution directory ({dir_path})")
		exit(errno.EACCES)

def copy_assets(avatar_name: str) -> None:
	"""
	コアアセットとキャラクター固有アセットの統合し、出力先ディレクトリにコピーする。
	コアアセットとキャラクター固有アセットに同じ相対パスのファイルが存在する場合、キャラクター固有アセットのほうで上書きされる。

	Args:
		avatar_name (str): コピーするアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。

	Raises:
		ValueError: avatar_nameが`paths.get_avatar_names()`で取得できる名前のいずれでもない場合
		NotADirectoryError: 出力先ディレクトリ、コアアセットのサブディレクトリ、キャラクター固有アセットのサブディレクトリのいずれかがディレクトリでない場合
		PermissionError: 出力先ディレクトリ、コアアセットのサブディレクトリ、キャラクター固有アセットのサブディレクトリのいずれかの書き込み権限がない場合
		FileNotFoundError: コアアセットのサブディレクトリ、キャラクター固有アセットのサブディレクトリのいずれかが存在しない場合
	"""

	# 入力の確認
	if not avatar_name in paths.get_avatar_names():
		logger.print_error(f"Specified avatar name \"{avatar_name}\" is not valid.")
		exit(errno.EINVAL)

	# アセットのコピー
	subdirectories: tuple[str, ...] = ("models", "textures", "scripts")
	for subdirectory in subdirectories:
		try:
			(paths.distribution_dir / avatar_name / subdirectory).mkdir(parents=True, exist_ok=True)
			shutil.copytree(paths.core_dir / subdirectory, paths.distribution_dir / avatar_name / subdirectory, dirs_exist_ok=True)
			shutil.copytree(paths.character_dir / avatar_name / subdirectory, paths.distribution_dir / avatar_name / subdirectory, dirs_exist_ok=True)
		except FileNotFoundError:
			logger.print_error(f"Required subdirectory not found ({subdirectory})")
			exit(errno.ENOENT)
		except NotADirectoryError:
			logger.print_error(f"Required subdirectory is not a directory ({subdirectory})")
			exit(errno.ENOTDIR)
		except PermissionError:
			logger.print_error(f"No permission to copy avatar assets ({subdirectory})")
			exit(errno.EACCES)
		except Exception as e:
			print(e)
			logger.print_error(f"An unexpected error occurred while copying avatar assets ({subdirectory})")
			exit(errno.EIO)

def _set_debug_args() -> None:
	"""
	デバッグ用コマンドライン引数を設定する。
	"""

	# 引数の設定
	parser = argparse.ArgumentParser(description="File operator for FBAC avatar build tool")
	parser.add_argument("--path", "-p", type=str, default=paths.distribution_dir, help="Path to the directory to operate on")

	# パスの設定
	args = parser.parse_args()
	global target_directory_path
	target_directory_path = Path(args.path)

def debug() -> None:
	"""
	ファイルオペレータークラスのデバッグ動作を実行する。
	"""

	_set_debug_args()

	# デバッグ出力
	print(textwrap.dedent(f"""
		Path operator for FBAC avatar build tool

		Preparing distribution directory ({target_directory_path})...
	""").strip())

	prepare_directory(target_directory_path)

	print(textwrap.dedent("""
		Completed preparing distribution directory.

		Copying avatar assets...
	""").strip())

	copy_assets("00a_base")

	print("Completed copying avatar assets.")

if __name__ == "__main__":
	debug()
