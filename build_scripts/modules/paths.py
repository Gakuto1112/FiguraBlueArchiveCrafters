from pathlib import Path
import re

# レポジトリのルートディレクトリ
ROOT_DIR: Path = Path(__file__).parent.parent.parent.resolve()

# ソースファイルが格納されるディレクトリ
SOURCE_DIR: Path = ROOT_DIR / "src"

# アバターの共通基盤のリソースが格納されるディレクトリ
CORE_DIR: Path = SOURCE_DIR / "core"

# キャラクター固有のリソースが格納されるディレクトリ
CHARACTER_DIR: Path = SOURCE_DIR / "avatars"

# ビルド済みアバターの出力先ディレクトリ
DISTRIBUTION_DIR: Path = ROOT_DIR / "dist"

def get_avatar_names() -> tuple[str, ...]:
	"""
	キャラクターのアバター名のリストをディレクトリから返す。

	Returns:
        tuple[str, ...]: アバター名のタプル
	"""

	return tuple(avatar.name for avatar in CHARACTER_DIR.iterdir() if avatar.is_dir() and re.match(r"\d{2}\w_", avatar.name))

def get_valid_avatar_names() -> tuple[str, ...]:
	"""
	ビルドスクリプトでキャラクターを指定してビルドする際の、有効なアバター名のリストを返す。

	Returns:
		tuple[str, ...]: 有効なアバター名のタプル
	"""

	valid_avatar_names: list[str] = []

	for avatar in get_avatar_names():
		valid_avatar_names.extend([*avatar.split("_", 1), avatar])

	return tuple(valid_avatar_names)
