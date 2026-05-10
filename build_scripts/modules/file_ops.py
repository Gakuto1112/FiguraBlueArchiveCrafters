import argparse
import errno
import shutil
import re
from pathlib import Path

from modules.enums.avatar_data_subdirectory import AvatarDataSubdirectory
from modules.errors.operation_cancelled_error import OperationCancelledError
from modules.logger import Logger
from modules.paths import paths


class FileOperator:
	"""
	ディレクトリの準備、アセットのコピーなどのファイル操作を行うクラス
	"""

	_RELEASE_REMOTE_LOCALE_ENDPOINT: str = "https://raw.githubusercontent.com/Gakuto1112/FBAC_Locales/refs/heads/main/src/"
	"""
	アバターの言語データを取得する、リモートのエンドポイント
	"""

	_COPY_FILTERS: dict[AvatarDataSubdirectory, tuple[str, ...]] = {
		AvatarDataSubdirectory.MODELS: ("*.bbmodel",),
		AvatarDataSubdirectory.TEXTURES: ("*.png",),
		AvatarDataSubdirectory.SCRIPTS: ("*.lua",)
	}
	"""
	ファイルコピーのフィルター
	このフィルターに合致するもののみがコピーされる（ホワイトリスト）。
	キーはディレクトリの列挙名、値はそのディレクトリ内でコピーするファイルのフィルターのタプル。
	"""

	_target_directory_path: Path = paths.distribution_dir
	"""
	出力先ディレクトリのパス（デバッグ用変数）
	"""

	@staticmethod
	def _copy_directory_with_filters(src: Path, dst: Path, filters: tuple[str, ...]) -> None:
		"""
		指定されたディレクトリ配下のファイル/サブディレクトリを出力先ディレクトリにコピーする。
		ただし、フィルターに合致したファイル/サブディレクトリのみコピーする（ホワイトリスト）。
		コピーの対象は`src/`ディレクトリ以下とし、その範囲外のパスが指定されても何もコピーしない。

		Args:
			src (Path): コピー元のディレクトリのパス
			dst (Path): コピー先のディレクトリのパス
			filters (tuple[str, ...]): コピーするファイル/サブディレクトリのフィルター。フィルターに合致したファイル/サブディレクトリのみコピーされる（ホワイトリスト）。

		Raises:
			PermissionError: コピー元のファイル/ディレクトリに対して読み取り権限や、出力先ディレクトリに対して書き込み権限がない場合
			IOError: その他の入出力エラーが発生した場合
		"""

		for filter in filters:
			for path in src.rglob(filter):
				if path.is_relative_to(src):
					relative_path: Path = path.relative_to(src)
					if path.is_dir() and not (dst / relative_path).exists():
						(dst / relative_path).mkdir(parents=True, exist_ok=True)
					elif path.is_file():
						if not (dst / relative_path).parent.exists():
							(dst / relative_path).parent.mkdir(parents=True, exist_ok=True)
						shutil.copy2(path, dst / relative_path)

	@staticmethod
	def _get_avatar_subdirectory(path: Path) -> AvatarDataSubdirectory|None:
		"""
		指定されたパスが所属しているアバターサブディレクトリを取得する。
		いずれのサブディレクトリにも所属していない場合はNoneを返す。

		Args:
			path (Path): アバターサブディレクトリの取得を試みる対象のパス

		Returns:
			AvatarDataSubdirectory|None: 指定されたパスが所属しているアバターサブディレクトリ。
				いずれのサブディレクトリにも所属していない場合はNoneを返す。
		"""

		path_list = tuple(reversed(path.parts))
		for i, part in enumerate(path_list):
			for subdirectory in AvatarDataSubdirectory:
				if part == subdirectory.value and re.fullmatch(r"^(core|\d{2}\w_\w+)$", path_list[i + 1]):
					return subdirectory

		return None

	@staticmethod
	def _get_is_whitelisted_asset(path: Path) -> bool:
		"""
		指定されたパスのアセットがホワイトリストに合致するかどうかを取得する。
		ディレクトリが指定された場合は、アバターサブディレクトリ内に所属しているのであれば、`True`を返す。

		Args:
			path (Path): ホワイトリストの合致を試みる対象のパス

		Returns:
			bool: 指定されたパスがホワイトリストに合致するかどうか
		"""

		subdirectory: AvatarDataSubdirectory|None = FileOperator._get_avatar_subdirectory(path)
		if subdirectory is not None:
			if path.is_dir():
				return True
			for filter in FileOperator._COPY_FILTERS[subdirectory]:
				if path.match(f"**/{filter}"):
					return True

		return False

	@staticmethod
	def prepare_directory(dir_path: Path) -> None:
		"""
		指定されたディレクトリの準備を行う。
		ディレクトリが存在しなければ新たに作成し、存在する場合はディレクトリ内のファイルやサブディレクトリを削除する。
		ルートディレクトリ外のパスが指定された場合はユーザーに確認を求める。

		Args:
			dir_path (Path): 準備するディレクトリのパス

		Raises:
			OperationCancelledError: ユーザーが選択によって処理が中断された場合
			NotADirectoryError: 指定されたパスがディレクトリでない場合
			PermissionError: 指定されたパスに対するアクセス権限がない場合
			IOError: その他の入出力エラーが発生した場合
		"""

		if dir_path.exists():
			# 出力先ディレクトリ内のファイルを削除
			if any(dir_path.iterdir()):
				Logger.print_info(f"Distribution directory already exists and is not empty. Cleaning up directory...")
				if not dir_path.is_relative_to(paths.root):
					Logger.print_warning(f"You specified distribution directory ({dir_path}) is outside of the root directory! All items in the distribution directory will be deleted!")
					answer = input("Are you sure you want to proceed? [y/N]: ")
					if not answer.lower() in ("y", "yes"):
						raise OperationCancelledError("Directory cleanup cancelled.")
			for item in dir_path.iterdir():
				if item.is_dir():
					shutil.rmtree(item)
				else:
					item.unlink()
			Logger.print_info("Completed cleaning up distribution directory.")
		else:
			Logger.print_info(f"Distribution directory does not exist. Creating new directory...")
			dir_path.mkdir(parents=True)

	@staticmethod
	def copy_assets(avatar_name: str, tag_name: str|None = None, as_release: bool = False) -> None:
		"""
		コアアセットとキャラクター固有アセットの統合し、出力先ディレクトリにコピーする。
		コアアセットとキャラクター固有アセットに同じ相対パスのファイルが存在する場合、キャラクター固有アセットのほうで上書きされる。

		Args:
			avatar_name (str): コピーするアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。
			tag_name (str|None): "update_checker.lua"内のアバターのバージョン名を上書きするための文字列。指定しない場合は上書きしない。
			as_release (bool): リリースアセットとしてコピーするかどうか。
				リリースアセットでは以下の変更を行う。
				 - `debug_utils.lua`を削除
				 - `avatar.lua`から`debug_utils`の`require()`を除外
				 - `locale.lua`のリモートエンドポイントをリリース用のものに変更

		Raises:
			ValueError: `avatar_name`が`paths.get_avatar_names()`で取得できる名前のいずれでもない場合
			NotADirectoryError: 出力先ディレクトリ、コアアセットのサブディレクトリ、キャラクター固有アセットのサブディレクトリのいずれかがディレクトリでない場合
			PermissionError: 出力先ディレクトリ、コアアセットのサブディレクトリ、キャラクター固有アセットのサブディレクトリのいずれかの書き込み権限がない場合
			FileNotFoundError: コアアセットのサブディレクトリ、キャラクター固有アセットのサブディレクトリのいずれかが存在しない場合
			IOError: その他の入出力エラーが発生した場合
		"""

		# 入力の確認
		if not avatar_name in paths.get_avatar_names():
			raise ValueError(f"The specified avatar name \"{avatar_name}\" is not valid.")

		# アセットのコピー
		for subdirectory in AvatarDataSubdirectory:
			(paths.distribution_dir / avatar_name / subdirectory.value).mkdir(parents=True, exist_ok=True)
			FileOperator._copy_directory_with_filters(paths.core_dir / subdirectory.value, paths.distribution_dir / avatar_name / subdirectory.value, FileOperator._COPY_FILTERS[subdirectory])
			FileOperator._copy_directory_with_filters(paths.character_dir / avatar_name / subdirectory.value, paths.distribution_dir / avatar_name / subdirectory.value, FileOperator._COPY_FILTERS[subdirectory])

		# リリースアセット用に変更する部分
		if as_release:
			# 1. `debug_utils.lua`を削除
			debug_utils_lua_path: Path = paths.distribution_dir / avatar_name / "scripts" / "utils" / "debug_utils.lua"
			if debug_utils_lua_path.exists():
				debug_utils_lua_path.unlink()
			else:
				Logger.print_warning(f"debug_utils.lua not found in the distribution directory for avatar \"{avatar_name}\". No action taken for deleting debug_utils.lua.")

			# 2. `avatar.lua`から`debug_utils`の`require()`を除外
			avatar_lua_path: Path = paths.distribution_dir / avatar_name / "scripts" / "avatar.lua"
			if avatar_lua_path.exists():
				avatar_lua_content: str = ""
				with avatar_lua_path.open("r", encoding="utf-8") as f:
					avatar_lua_content = f.read()
				avatar_lua_content = re.sub(r"\n?--\s\[\[\sRELEASE_EXCLUSION_START\s\]\]\s--.*?--\s\[\[\sRELEASE_EXCLUSION_END\s\]\]\s--\n?", "", avatar_lua_content, flags=re.DOTALL)
				with avatar_lua_path.open("w", encoding="utf-8") as f:
					f.write(avatar_lua_content)
			else:
				Logger.print_error(f"avatar.lua not found in the distribution directory for avatar \"{avatar_name}\". This script is required for the avatar to work properly!")
				raise FileNotFoundError(f"avatar.lua not found in the distribution directory for avatar \"{avatar_name}\".")

			# 3. `update_checker.lua`内のアバターバージョン名を上書き
			if tag_name is not None:
				update_checker_lua_path: Path = paths.distribution_dir / avatar_name / "scripts" / "action_wheel" / "update_checker.lua"
				if update_checker_lua_path.exists():
					update_checker_lua_content: str = ""
					with update_checker_lua_path.open("r", encoding="utf-8") as f:
						update_checker_lua_content = f.read()
					update_checker_lua_content = re.sub(r"AVATAR_VERSION\s=\s\".*?\";", f"AVATAR_VERSION = \"{tag_name}\";", update_checker_lua_content)
					with update_checker_lua_path.open("w", encoding="utf-8") as f:
						f.write(update_checker_lua_content)
				else:
					Logger.print_error(f"update_checker.lua not found in the distribution directory for avatar \"{avatar_name}\". This script is required for the avatar to work properly!")
					raise FileNotFoundError(f"update_checker.lua not found in the distribution directory for avatar \"{avatar_name}\".")

			# 4. `locale.lua`のリモートエンドポイントをリリース用のものに変更
			locale_lua_path: Path = paths.distribution_dir / avatar_name / "scripts" / "locale.lua"
			if locale_lua_path.exists():
				locale_lua_content: str = ""
				with locale_lua_path.open("r", encoding="utf-8") as f:
					locale_lua_content = f.read()
				locale_lua_content = re.sub(r"REMOTE_LOCALE_ENDPOINT\s=\s\".*?\";", f"REMOTE_LOCALE_ENDPOINT = \"{FileOperator._RELEASE_REMOTE_LOCALE_ENDPOINT}\";", locale_lua_content)
				with locale_lua_path.open("w", encoding="utf-8") as f:
					f.write(locale_lua_content)
			else:
				Logger.print_error(f"locale.lua not found in the distribution directory for avatar \"{avatar_name}\". This script is required for the avatar to work properly!")
				raise FileNotFoundError(f"locale.lua not found in the distribution directory for avatar \"{avatar_name}\".")

	@staticmethod
	def copy_single_asset_path(src_path: Path) -> None:
		"""
		指定されたアセットパス単体を出力先にコピーする。
		コアディレクトリ内のコピーの場合は、全アバターに対してコピーを行う。同名のキャラクター固有のアセットがあればそれで上書きする。
		キャラクターディレクトリ内のコピーの場合は、そのキャラクターのアセットのみコピーする。

		Args:
			src_path (Path): コピーするアセットのパス。ソースディレクトリ内のパスである必要がある。

		Raises:
			ValueError: コピー元のパスがソースディレクトリ内のパスでない場合
			NotADirectoryError: コピー元がディレクトリ指定なのに実際のパスはファイルである場合
			IsADirectoryError: コピー元がファイル指定なのに実際のパスはディレクトリである場合
			PermissionError: コピー操作に必要なアクセス権限がない場合
			FileNotFoundError: コピー元のファイルが存在しない場合
			IOError: その他の入出力エラーが発生した場合
		"""

		# 入力されたパスの確認
		if not src_path.is_relative_to(paths.source_dir):
			raise ValueError(f"The specified asset path ({src_path}) is outside of the source directory.")
		elif not FileOperator._get_is_whitelisted_asset(src_path):
			Logger.print_warning(f"The specified asset path ({src_path}) will not be copied. The path does not match any of the whitelist filters.")
			return

		if src_path.is_relative_to(paths.core_dir):
			# コアディレクトリ内のファイル更新
			for avatar_name in paths.get_avatar_names():
				relative_path: Path = src_path.relative_to(paths.core_dir)
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
		else:
			Logger.print_warning(f"The specified asset path ({src_path}) is not in core directory or character directory. No action taken.")

	@staticmethod
	def delete_single_asset_path(src_path: Path) -> None:
		"""
		指定されたアセットパス単体を出力先から削除する。
		コアディレクトリ内の削除の場合は、全アバターに対して削除を行う。同名のキャラクター固有のアセットがあればそれを再コピーする。
		キャラクターディレクトリ内の削除の場合は、そのキャラクターのアセットのみ削除する。同名のコアアセットがあればそれを再コピーする。

		Args:
			src_path (Path): 削除するアセットのパス。ソースディレクトリ内のパスである必要がある。

		Raises:
			ValueError: 削除元のパスがコア/キャラクターディレクトリ内のパスでない場合
			NotADirectoryError: 削除元がディレクトリ指定なのに実際のパスはファイルである場合
			IsADirectoryError: 削除元がファイル指定なのに実際のパスはディレクトリである場合
			PermissionError: 削除操作に必要なアクセス権限がない場合
			FileNotFoundError: 削除元のファイルが存在しない場合
			IOError: その他の入出力エラーが発生した場合
		"""

		if src_path.is_relative_to(paths.core_dir):
			# コアディレクトリ内のファイル削除
			for avatar_name in paths.get_avatar_names():
				relative_path: Path = src_path.relative_to(paths.core_dir)
				target_path: Path = paths.distribution_dir / avatar_name / relative_path
				if target_path.exists():
					if target_path.is_dir():
						shutil.rmtree(target_path)
					else:
						target_path.unlink(missing_ok=True)

					character_asset_path: Path = paths.character_dir / avatar_name / relative_path
					if character_asset_path.exists():
						if character_asset_path.is_dir():
							shutil.copytree(character_asset_path, target_path, dirs_exist_ok=True)
						else:
							shutil.copy2(character_asset_path, target_path)
		elif src_path.is_relative_to(paths.character_dir):
			# キャラクターディレクトリ内のファイル削除
			relative_path: Path = src_path.relative_to(paths.character_dir)
			target_path: Path = paths.distribution_dir / relative_path
			if target_path.exists():
				if target_path.is_dir():
					shutil.rmtree(target_path)
				else:
					target_path.unlink(missing_ok=True)

				relative_path_parts: tuple[str, ...] = relative_path.parts
				if len(relative_path_parts) > 2:
					core_asset_path: Path = paths.core_dir / Path(*relative_path.parts[1:])
					if core_asset_path.exists():
						if core_asset_path.is_dir():
							shutil.copytree(core_asset_path, target_path, dirs_exist_ok=True)
						else:
							shutil.copy2(core_asset_path, target_path)
		else:
			raise ValueError(f"The specified asset path ({src_path}) is not in core directory or character directory.")

	@staticmethod
	def _set_debug_args() -> None:
		"""
		デバッグ用コマンドライン引数を設定する。
		"""

		# 引数の設定
		parser = argparse.ArgumentParser(description="File operator for FBAC avatar build tool")
		parser.add_argument("--path", "-p", type=str, default=paths.distribution_dir, help="Path to the directory to operate on")

		# パスの設定
		args = parser.parse_args()
		FileOperator._target_directory_path = Path(args.path)

	@staticmethod
	def debug() -> None:
		"""
		ファイルオペレータークラスのデバッグ動作を実行する。
		"""

		FileOperator._set_debug_args()

		# デバッグ出力
		Logger.print_info("Path operator for FBAC avatar build tool")
		Logger.print_spacer(1)
		Logger.print_info(f"Preparing the distribution directory ({FileOperator._target_directory_path})...")

		try:
			FileOperator.prepare_directory(FileOperator._target_directory_path)
		except OperationCancelledError:
			Logger.print_info("Cancelled preparing the distribution directory.")
			exit(errno.ECANCELED)
		except NotADirectoryError:
			Logger.print_error(f"The specified distribution directory path is not a directory.")
			exit(errno.ENOTDIR)
		except PermissionError:
			Logger.print_error(f"No permission to clean up or create the distribution directory.")
			exit(errno.EACCES)
		except IOError:
			Logger.print_error(f"An unexpected error occurred while preparing the distribution directory.")
			exit(errno.EIO)

		Logger.print_info("Completed preparing distribution directory.")
		Logger.print_spacer(1)
		Logger.print_info(f"Copying avatar assets (00a_base)...")

		try:
			FileOperator.copy_assets("00a_base")
		except NotADirectoryError:
			Logger.print_error(f"The output directory, core asset subdirectory, or character-specific asset subdirectory is not a directory.")
			exit(errno.ENOTDIR)
		except PermissionError:
			Logger.print_error(f"No permission to copy avatar assets.")
			exit(errno.EACCES)
		except FileNotFoundError:
			Logger.print_error(f"The core asset subdirectories or character asset subdirectories do not exist.")
			exit(errno.ENOENT)
		except IOError:
			Logger.print_error(f"An unexpected error occurred while copying avatar assets.")
			exit(errno.EIO)

		Logger.print_info("Completed copying avatar assets.")

if __name__ == "__main__":
	FileOperator.debug()
