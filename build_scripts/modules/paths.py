import argparse
import errno
import re
from dataclasses import dataclass
from pathlib import Path

from modules.logger import logger


@dataclass
class AvatarPaths:
	root: Path = Path(__file__).parent.parent.parent.resolve()
	"""
	レポジトリのルートディレクトリ
	"""

	_source_dir: Path = root / "src"
	"""
	ソースファイルが格納されるディレクトリ
	"""

	_distribution_dir: Path = root / "dist"
	"""
	ビルド済みアバターの出力先ディレクトリ
	"""

	@property
	def source_dir(self) -> Path:
		"""
		ソースファイルが格納されるディレクトリ
		"""

		return self._source_dir

	@source_dir.setter
	def source_dir(self, path: Path) -> None:
		"""
		source_dirのセッター関数

		Args:
			path (Path): source_dirのパス
		"""

		self._source_dir = path

	@property
	def core_dir(self) -> Path:
		"""
		アバターの共通基盤のリソースが格納されるディレクトリ
		"""

		return self._source_dir / "core"

	@property
	def character_dir(self) -> Path:
		"""
		キャラクター固有のリソースが格納されるディレクトリ
		"""

		return self._source_dir / "avatars"

	@property
	def distribution_dir(self) -> Path:
		"""
		ビルド済みアバターの出力先ディレクトリ
		"""

		return self._distribution_dir

	@distribution_dir.setter
	def distribution_dir(self, path: Path) -> None:
		"""
		distribution_dirのセッター関数

		Args:
			path (Path): distribution_dirのパス
		"""

		self._distribution_dir = path

	def check_directories(self) -> tuple[Path, ...]:
		"""
		ビルドに必要なディレクトリの存在を確認する。

		Returns:
			tuple[Path, ...]: 存在しないディレクトリのタプル
		"""

		required_dirs: tuple[Path, ...] = (self.source_dir, self.core_dir, self.character_dir)
		missing_dirs: list[Path] = []
		for dir in required_dirs:
			if not dir.exists():
				missing_dirs.append(dir)
		return tuple(missing_dirs)

	def get_avatar_names(self) -> tuple[str, ...]:
		"""
		キャラクターのアバター名のリストをディレクトリから返す。

		Returns:
			tuple[str, ...]: アバター名のタプル

		Raises:
			FileNotFoundError: キャラクターディレクトリが存在しない場合
			NotADirectoryError: キャラクターディレクトリがディレクトリでない場合
			PermissionError: キャラクターディレクトリの読み取り権限がない場合
		"""

		try:
			return tuple(avatar.name for avatar in self.character_dir.iterdir() if avatar.is_dir() and re.match(r"\d{2}\w_", avatar.name))
		except FileNotFoundError:
			logger.print_error(f"Character directory not found ({self.character_dir})")
			exit(errno.ENOENT)
		except NotADirectoryError:
			logger.print_error(f"Character directory is not a directory ({self.character_dir})")
			exit(errno.ENOTDIR)
		except PermissionError:
			logger.print_error(f"No permission to operate on character directory ({self.character_dir})")
			exit(errno.EACCES)
		except:
			logger.print_error(f"An unexpected error occurred while accessing the character directory ({self.character_dir})")
			exit(errno.EIO)


	def get_valid_avatar_names(self) -> tuple[str, ...]:
		"""
		ビルドスクリプトでキャラクターを指定してビルドする際の、有効なアバター名のリストを返す。

		Returns:
			tuple[str, ...]: 有効なアバター名のタプル
		"""

		valid_avatar_names: list[str] = []

		for avatar in self.get_avatar_names():
			valid_avatar_names.extend([*avatar.split("_", 1), avatar])

		return tuple(valid_avatar_names)

	def _set_debug_args(self) -> None:
		"""
		デバッグ用コマンドライン引数を設定する。
		"""

		# 引数の設定
		parser = argparse.ArgumentParser(description="Path manager for FBAC avatar build tool")
		parser.add_argument("--src-dir", "-s", type=Path, default=self.source_dir, help=f"Overrides default source directory path. Default: {self.source_dir}")
		parser.add_argument("--dist-dir", "-d", type=Path, default=self.distribution_dir, help=f"Overrides default distribution directory path. Default: {self.distribution_dir}")

		# パスの設定
		args = parser.parse_args()
		self.source_dir = args.src_dir
		self.distribution_dir = args.dist_dir

	def debug(self) -> None:
		"""
		パスマネージャークラスのデバッグ出力をする。
		"""

		self._set_debug_args()

		# ファイルパスの出力
		logger.print_info("Path manager for FBAC avatar build tool")
		logger.print_spacer(1)
		logger.print_debug(f"ROOT_DIR:\t{self.root}")
		logger.print_debug(f"SOURCE_DIR:\t{self.source_dir}")
		logger.print_debug(f"CORE_DIR:\t{self.core_dir}")
		logger.print_debug(f"CHARACTER_DIR:\t{self.character_dir}")
		logger.print_debug(f"DISTRIBUTION_DIR:\t{self.distribution_dir}")
		logger.print_spacer(1)
		logger.print_info("Checking required directories...")

		# ビルドに必要なディレクトリの存在を確認
		missing_dirs = self.check_directories()
		if len(missing_dirs) == 0:
			logger.print_info("No missing directories found.")
		else:
			for missing_dir in missing_dirs:
				logger.print_info(f"Missing directory found: {missing_dir}")

paths = AvatarPaths()

if __name__ == "__main__":
	paths.debug()
