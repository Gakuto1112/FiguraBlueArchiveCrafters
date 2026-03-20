import argparse
import os
import shutil
import textwrap
from pathlib import Path

from paths import paths

# 出力先ディレクトリのパス（デバッグ用変数）
target_directory_path: Path = paths.distribution_dir

def prepare_directory(dir_path: Path) -> None:
	"""
	指定されたディレクトリの準備を行う。
	ディレクトリが存在しなければ新たに作成し、存在する場合はディレクトリ内のファイルやサブディレクトリを削除する。
	ルートディレクトリ外のパスが指定された場合はユーザーに確認を求める。

	Args:
		dir_path (Path): 準備するディレクトリのパス

	Raises:
		NotADirectoryError: 指定されたパスがディレクトリでない
		PermissionError: 指定されたパスの書き込み権限がない
	"""
	if dir_path.exists():
		# ディレクトリの確認
		if not dir_path.is_dir():
			raise NotADirectoryError(f"Distribution directory is not a directory ({dir_path})")
		elif not os.access(dir_path, os.W_OK):
			raise PermissionError(f"Distribution directory is not writable ({dir_path})")

		# 出力先ディレクトリ内のファイルを削除
		if any(dir_path.iterdir()):
			print("Cleaning up existing files in distribution directory...")
			if not dir_path.is_relative_to(paths.root):
				print(f"🚨 You specified distribution directory ({dir_path}) is outside of the root directory! All items in the distribution directory will be deleted!")
				answer = input("Are you sure you want to proceed? [y/N]: ")
				if not answer.lower() in ("y", "yes"):
					print("Directory cleanup cancelled. Build aborted.")
					exit(0)
		for item in dir_path.iterdir():
			if item.is_dir():
				shutil.rmtree(item)
			else:
				item.unlink()
	else:
		print(f"Distribution directory does not exist. Creating new directory...")
		dir_path.mkdir(parents=True)

def create_subdirectories(dir_path: Path) -> None:
	"""
	指定されたディレクトリ内に、アバターに必要なサブディレクトリを作成する。
	 * models
	 * textures
	 * scripts

	Args:
		dir_path (Path): サブディレクトリを作成する親ディレクトリのパス

	Raises:
		NotADirectoryError: 指定されたパスがディレクトリでない
		PermissionError: 指定されたパスの書き込み権限がない
	"""
	if not dir_path.is_dir():
		raise NotADirectoryError(f"Target directory is not a directory ({dir_path})")
	elif not os.access(dir_path, os.W_OK):
		raise PermissionError(f"Target directory is not writable ({dir_path})")

	subdirectories: tuple[str, ...] = ("models", "textures", "scripts")
	for subdir in subdirectories:
		subdir_path = dir_path / subdir
		subdir_path.mkdir(parents=True, exist_ok=True)

def debug() -> None:
	"""
	ファイルオペレータークラスのデバッグ動作を実行する。
	"""

	# 引数の設定
	parser = argparse.ArgumentParser(description="File operator for FBAC avatar build tool")
	parser.add_argument("--path", "-p", type=str, default=paths.distribution_dir, help="Path to the directory to operate on")

	# パスの設定
	args = parser.parse_args()
	global target_directory_path
	target_directory_path = Path(args.path)

	# デバッグ出力
	print(textwrap.dedent(f"""
		Path operator for FBAC avatar build tool

		Preparing distribution directory ({target_directory_path}) ...
	""").strip())

	prepare_directory(target_directory_path)

	print("Completed preparing distribution directory.")

if __name__ == "__main__":
	debug()
