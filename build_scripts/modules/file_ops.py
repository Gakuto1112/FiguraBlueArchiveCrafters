import argparse
import errno
import shutil
from pathlib import Path

from modules.logger import logger
from modules.paths import paths


class FileOperator:
	"""
	ディレクトリの準備、アセットのコピーなどのファイル操作を行うクラス
	"""

	target_directory_path: Path = paths.distribution_dir
	"""
	出力先ディレクトリのパス（デバッグ用変数）
	"""

	@staticmethod
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
				# 出力先ディレクトリ内のファイルを削除
				if any(dir_path.iterdir()):
					logger.print_info(f"Distribution directory already exists and is not empty. Cleaning up directory...")
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
				logger.print_info("Completed cleaning up distribution directory.")
			else:
				logger.print_info(f"Distribution directory does not exist. Creating new directory...")
				dir_path.mkdir(parents=True)
		except NotADirectoryError:
			logger.print_error(f"The specified distribution directory is not a directory ({dir_path})")
			exit(errno.ENOTDIR)
		except PermissionError:
			logger.print_error(f"No permission to operate on specified distribution directory ({dir_path})")
			exit(errno.EACCES)

	@staticmethod
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
			logger.print_error(f"The specified avatar name \"{avatar_name}\" is not valid.")
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

	@staticmethod
	def copy_single_asset_path(src_path: Path) -> None:
		"""
		指定されたアセットパス単体を出力先にコピーする。
		コアディレクトリ内のコピーの場合は、前アバターに対してコピーを行う。同名のキャラクター固有のアセットがあればそれで上書きする。
		キャラクターディレクトリ内のコピーの場合は、そのキャラクターのアセットのみコピーする。

		Args:
			src_path (Path): コピーするアセットのパス。ソースディレクトリ内のパスである必要がある。
		"""

		# 入力されたパスの確認
		if not src_path.is_relative_to(paths.source_dir):
			logger.print_error(f"The specified asset path ({src_path}) is outside of the source directory")
			exit(errno.EINVAL)

		if src_path.is_relative_to(paths.core_dir):
			# コアディレクトリ内のファイル更新
			for avatar_name in paths.get_avatar_names():
				relative_path = src_path.relative_to(paths.core_dir)
				if src_path.is_dir():
					(paths.distribution_dir / avatar_name / relative_path).mkdir(parents=True, exist_ok=True)
					if (paths.character_dir / avatar_name / relative_path).exists():
						shutil.copytree(paths.character_dir / avatar_name / relative_path, paths.distribution_dir / avatar_name / relative_path, dirs_exist_ok=True)
				else:
					shutil.copy2(src_path, paths.distribution_dir / avatar_name / relative_path)
					if (paths.character_dir / avatar_name / relative_path).exists():
						shutil.copy2(paths.character_dir / avatar_name / relative_path, paths.distribution_dir / avatar_name / relative_path)
		elif src_path.is_relative_to(paths.character_dir):
			# キャラクターディレクトリ内のファイル更新
			if src_path.is_dir():
				(paths.distribution_dir / src_path.relative_to(paths.character_dir)).mkdir(parents=True, exist_ok=True)
			else:
				shutil.copy2(src_path, paths.distribution_dir / src_path.relative_to(paths.character_dir))

	def _set_debug_args(self) -> None:
		"""
		デバッグ用コマンドライン引数を設定する。
		"""

		# 引数の設定
		parser = argparse.ArgumentParser(description="File operator for FBAC avatar build tool")
		parser.add_argument("--path", "-p", type=str, default=paths.distribution_dir, help="Path to the directory to operate on")

		# パスの設定
		args = parser.parse_args()
		self.target_directory_path = Path(args.path)

	def debug(self) -> None:
		"""
		ファイルオペレータークラスのデバッグ動作を実行する。
		"""

		self._set_debug_args()

		# デバッグ出力
		logger.print_info("Path operator for FBAC avatar build tool")
		logger.print_spacer(1)
		logger.print_info(f"Preparing distribution directory ({self.target_directory_path})...")

		self.prepare_directory(self.target_directory_path)

		logger.print_info("Completed preparing distribution directory.")
		logger.print_spacer(1)
		logger.print_info(f"Copying avatar assets (00a_base)...")

		FileOperator.copy_assets("00a_base")

		logger.print_info("Completed copying avatar assets.")

file_ops = FileOperator()

if __name__ == "__main__":
	file_ops.debug()
