import argparse
import os
import re
import textwrap
from dataclasses import dataclass
from pathlib import Path


@dataclass
class AvatarPaths:
	# レポジトリのルートディレクトリ
	root: Path = Path(__file__).parent.parent.parent.resolve()

	# ソースファイルが格納されるディレクトリ
	_source_dir: Path = root / "src"

	# ビルド済みアバターの出力先ディレクトリ
	_distribution_dir: Path = root / "dist"

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

		Raises:
			FileNotFoundError: 指定されたパスが存在しない場合
			NotADirectoryError: 指定されたパスがディレクトリでない場合
			PermissionError: 指定されたパスの読み取り権限がない場合
		"""
		if not path.exists():
			raise FileNotFoundError(f"Specified source directory does not exist ({path})")
		elif not path.is_dir():
			raise NotADirectoryError(f"Specified source directory is not a directory ({path})")
		elif not os.access(path, os.R_OK):
			raise PermissionError(f"Specified source directory is not readable ({path})")
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

		Raises:
			NotADirectoryError: 指定されたパスがディレクトリでない場合
			PermissionError: 指定されたパスの書き込み権限がない場合
		"""
		if path.exists():
			if not path.is_dir():
				raise NotADirectoryError(f"Specified distribution directory is not a directory ({path})")
			elif not os.access(path, os.W_OK):
				raise PermissionError(f"Specified distribution directory is not writable ({path})")
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
		if not self.character_dir.exists():
			raise FileNotFoundError(f"Character directory not found ({self.character_dir})")
		elif not self.character_dir.is_dir():
			raise NotADirectoryError(f"Character directory is not a directory ({self.character_dir})")
		elif not os.access(self.character_dir, os.R_OK):
			raise PermissionError(f"Character directory is not readable ({self.character_dir})")

		return tuple(avatar.name for avatar in self.character_dir.iterdir() if avatar.is_dir() and re.match(r"\d{2}\w_", avatar.name))

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

	def set_debug_args(self) -> None:
		"""
		デバッグ用コマンドライン引数を設定する。
		"""
		# 引数の設定
		parser = argparse.ArgumentParser(description="Path manager for FBAC avatar build tool")
		parser.add_argument("--src-dir", "-s", type=Path, default=self.source_dir, help=f"Overrides default source directory path. Default: {self.source_dir}")
		parser.add_argument("--dist-dir", "-d", type=Path, default=self.distribution_dir, help=f"Overrides default distribution directory path. Default: {self.distribution_dir}")
		args = parser.parse_args()

		# パスの設定
		self.source_dir = args.src_dir
		self.distribution_dir = args.dist_dir

	def print_debug(self) -> None:
		"""
		パスマネージャークラスのデバッグ出力をする。
		"""
		print(textwrap.dedent(f"""
			Path manager for FBAC avatar build tool

			ROOT_DIR:\t{self.root}
			SOURCE_DIR:\t{self.source_dir}
			CORE_DIR:\t{self.core_dir}
			CHARACTER_DIR:\t{self.character_dir}
			DISTRIBUTION_DIR:\t{self.distribution_dir}

			Checking required directories...
		""").strip())
		missing_dirs = self.check_directories()
		if len(missing_dirs) == 0:
			print("> No missing directories found.")
		else:
			for missing_dir in missing_dirs:
				print(f"> Missing directory found: {missing_dir}")

paths = AvatarPaths()

if __name__ == "__main__":
	paths.set_debug_args()
	paths.print_debug()
