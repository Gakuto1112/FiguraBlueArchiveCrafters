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

def copy_assets(avatar_name: str) -> None:
	"""
	コアアセットとキャラクター固有アセットの統合し、出力先ディレクトリにコピーする。
	コアアセットとキャラクター固有アセットに同じ相対パスのファイルが存在する場合、キャラクター固有アセットのほうで上書きされる。

	Args:
		avatar_name (str): コピーするアバターの名前。paths.get_avatar_names()で取得できる名前のいずれかを指定する。

	Raises:
		ValueError: avatar_nameがpaths.get_avatar_names()で取得できる名前のいずれでもない場合
		NotADirectoryError: 出力先ディレクトリ、コアアセットのサブディレクトリ、キャラクター固有アセットのサブディレクトリのいずれかがディレクトリでない場合
		PermissionError: 出力先ディレクトリ、コアアセットのサブディレクトリ、キャラクター固有アセットのサブディレクトリのいずれかの書き込み権限がない場合
		FileNotFoundError: コアアセットのサブディレクトリ、キャラクター固有アセットのサブディレクトリのいずれかが存在しない場合
	"""
	# 入力及びディレクトリの確認
	if not avatar_name in paths.get_avatar_names():
		raise ValueError(f"Avatar name \"{avatar_name}\" is not valid.")
	elif not paths.distribution_dir.is_dir():
		raise NotADirectoryError(f"Distribution directory is not a directory ({paths.distribution_dir})")
	elif not os.access(paths.distribution_dir, os.W_OK):
		raise PermissionError(f"Distribution directory is not writable ({paths.distribution_dir})")

	# アセットのコピー
	subdirectories: tuple[str, ...] = ("models", "textures", "scripts")
	for subdirectory in subdirectories:
		# コピー元のサブディレクトリの確認
		if not (paths.core_dir / subdirectory).exists():
			raise FileNotFoundError(f"Required core subdirectory not found ({paths.core_dir / subdirectory})")
		elif not (paths.core_dir / subdirectory).is_dir():
			raise NotADirectoryError(f"Required core subdirectory is not a directory ({paths.core_dir / subdirectory})")
		elif not os.access(paths.core_dir / subdirectory, os.R_OK):
			raise PermissionError(f"Required core subdirectory is not readable ({paths.core_dir / subdirectory})")
		elif not (paths.character_dir / avatar_name / subdirectory).exists():
			raise FileNotFoundError(f"Required character subdirectory not found ({paths.character_dir / avatar_name / subdirectory})")
		elif not (paths.character_dir / avatar_name / subdirectory).is_dir():
			raise NotADirectoryError(f"Required character subdirectory is not a directory ({paths.character_dir / avatar_name / subdirectory})")
		elif not os.access(paths.character_dir / avatar_name / subdirectory, os.R_OK):
			raise PermissionError(f"Required character subdirectory is not readable ({paths.character_dir / avatar_name / subdirectory})")

		(paths.distribution_dir / avatar_name / subdirectory).mkdir(parents=True)
		shutil.copytree(paths.core_dir / subdirectory, paths.distribution_dir / avatar_name / subdirectory, dirs_exist_ok=True)
		shutil.copytree(paths.character_dir / avatar_name / subdirectory, paths.distribution_dir / avatar_name / subdirectory, dirs_exist_ok=True)

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
