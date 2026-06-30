from dataclasses import dataclass
from pathlib import Path


@dataclass
class BasePath:
	_root: Path = Path(__file__).resolve().parent.parent.parent
	"""
	レポジトリのルートディレクトリ
	"""

	@property
	def root(self) -> Path:
		"""
		レポジトリのルートディレクトリ
		"""

		return self._root


base_path = BasePath()
