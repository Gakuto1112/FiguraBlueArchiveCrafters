import argparse
from dataclasses import dataclass
from pathlib import Path

from modules.logger import Logger


@dataclass
class AvatarPaths:
	root: Path = Path(__file__).parent.parent.parent.resolve()
	"""
	レポジトリのルートディレクトリ
	"""

	_template_dir: Path = root / "readme_scripts" / "templates"
	"""
	テンプレートファイルが格納されるディレクトリ
	"""

	_distribution_dir: Path = root
	"""
	ビルド済みドキュメントの出力先ディレクトリ
	"""

	@property
	def template_dir(self) -> Path:
		"""
		テンプレートファイルが格納されるディレクトリ
		"""

		return self._template_dir

	@template_dir.setter
	def template_dir(self, path: Path) -> None:
		"""
		template_dirのセッター関数

		Args:
			path (Path): template_dirのパス
		"""

		self._template_dir = path

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



	def _set_debug_args(self) -> None:
		"""
		デバッグ用コマンドライン引数を設定する。
		"""

		# 引数の設定
		parser = argparse.ArgumentParser(description="Path manager for FBAC avatar build tool")
		parser.add_argument("--template-dir", "-t", type=Path, default=self.template_dir, help=f"Overrides default template directory path. Default: {self.template_dir}")
		parser.add_argument("--dist-dir", "-d", type=Path, default=self.distribution_dir, help=f"Overrides default distribution directory path. Default: {self.distribution_dir}")

		# パスの設定
		args = parser.parse_args()
		self.template_dir = args.template_dir
		self.distribution_dir = args.dist_dir

	def debug(self) -> None:
		"""
		パスマネージャークラスのデバッグ出力をする。
		"""

		self._set_debug_args()

		# ファイルパスの出力
		Logger.print_info("Path manager for FBAC avatar build tool")
		Logger.print_spacer(1)
		Logger.print_debug(f"ROOT_DIR:\t{self.root}")
		Logger.print_debug(f"TEMPLATE_DIR:\t{self.template_dir}")
		Logger.print_debug(f"DISTRIBUTION_DIR:\t{self.distribution_dir}")
		Logger.print_spacer(1)
		Logger.print_info("Checking required directories...")

paths = AvatarPaths()

if __name__ == "__main__":
	paths.debug()
