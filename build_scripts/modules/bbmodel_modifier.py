import argparse
import errno
import json
import base64
from pathlib import Path

from modules.logger import Logger

class BBModelModifier:
	"""
	BBModelファイルを解析し、データを変更するクラス
	"""

	_debug_input_path: Path = Path()
	"""
	コマンドライン引数から受け取った、編集を行うBBModelファイルまでのパス（デバッグ用変数）
	"""

	texture_base64_caches: dict[str, str] = {}
	"""
	テクスチャ画像をbase64エンコードしたのちに、この辞書テーブルにキャッシュする。
	2回目以降の同じテクスチャ画像のエンコードは、このキャッシュからbase64文字列を取得することで、テクスチャ更新処理を高速化する。
	キーはテクスチャ画像のパスの文字列、値はエンコードされたbase64文字列。
	"""

	@staticmethod
	def _read_bbmodel_data(bbmodel_path: Path) -> dict:
		"""
		指定されたパスのBBModelファイルを読み込み、そのデータを辞書型で返す。

		Args:
			bbmodel_path (Path): 読み込むBBModelファイルのパス

		Returns:
			dict: 読み込んだBBModelファイルのデータを格納した辞書

		Raises:
			FileNotFoundError: 指定されたパスにBBModelファイルが存在しない場合
			IsADirectoryError: 指定されたパスがディレクトリである場合
			PermissionError: 指定されたパスのファイルに対する読み取り権限がない場合
			IOError: その他の入出力エラーが発生した場合
			json.JSONDecodeError: BBModelファイルの内容が有効なJSON形式でない場合
		"""

		with bbmodel_path.open("r", encoding="utf-8") as f:
			return json.load(f)

	@staticmethod
	def _write_bbmodel_data(bbmodel_path: Path, bbmodel_data: dict) -> None:
		"""
		指定されたパスのBBModelファイルに、指定されたデータを書き込む。
		BBModelのフォーマットに合うようにJSON整形も行う。

		Args:
			bbmodel_path (Path): 書き込むBBModelファイルのパス
			bbmodel_data (dict): 書き込むデータを格納した辞書

		Raises:
			FileNotFoundError: 指定されたパスにBBModelファイルが存在しない場合
			IsADirectoryError: 指定されたパスがディレクトリである場合
			PermissionError: 指定されたパスのファイルに対する書き込み権限がない場合
			IOError: その他の入出力エラーが発生した場合
		"""

		with bbmodel_path.open("w", encoding="utf-8") as f:
			json.dump(bbmodel_data, f, ensure_ascii=False, indent=4)

	@staticmethod
	def _remove_reference_images(bbmodel_data: dict) -> dict:
		"""
		BBModelデータ内に含まれている参考画像を削除し、変更後のBBModelデータを返す。
		参考画像は作成時のみ必要であり、その後は不要なデータとなるため、ビルドの際に参考画像は削除することを推奨する。

		Args:
			bbmodel_data (dict): 参照画像を削除するBBModelデータ

		Returns:
			dict: 参照画像が削除されたBBModelデータ
		"""

		if "reference_images" in bbmodel_data:
			del bbmodel_data["reference_images"]

		return bbmodel_data

	@staticmethod
	def _remove_texture_absolute_paths(bbmodel_data: dict) -> dict:
		"""
		BBModelデータ内のテクスチャの絶対パスを削除し、変更後のBBModelデータを返す。
		BBModelデータ内のテクスチャには相対パスもあるため、絶対パスは不要である。

		Args:
			bbmodel_data (dict): テクスチャの絶対パスを削除するBBModelデータ

		Returns:
			dict: テクスチャの絶対パスが削除されたBBModelデータ
		"""

		if "textures" in bbmodel_data:
			for texture in bbmodel_data["textures"]:
				if "path" in texture:
					del texture["path"]

		return bbmodel_data

	@staticmethod
	def _get_texture_base64_string(texture_path: Path) -> str:
		"""
		指定されたテクスチャ画像をbase64エンコードし、その文字列を返す。

		Args:
			texture_path (Path): エンコードするテクスチャ画像のパス

		Returns:
			str: エンコードされたテクスチャ画像のbase64文字列

		Raises:
			FileNotFoundError: 指定されたパスにテクスチャ画像が存在しない場合
			IsADirectoryError: 指定されたパスがディレクトリである場合
			PermissionError: 指定されたパスのファイルに対する読み取り権限がない場合
			IOError: その他の入出力エラーが発生した場合
		"""

		path_str: str = texture_path.as_posix()
		if path_str not in BBModelModifier.texture_base64_caches:
			with texture_path.open("rb") as f:
				BBModelModifier.texture_base64_caches[path_str] = f"data:image/png;base64,{base64.b64encode(f.read()).decode("utf-8")}"

		return BBModelModifier.texture_base64_caches[path_str]

	@staticmethod
	def _update_embedded_texture_data(bbmodel_path: Path, bbmodel_data: dict) -> dict:
		"""
		BBModelデータ内のテクスチャのbase64エンコードされたデータを更新し、変更後のBBModelデータを返す。

		Args:
			bbmodel_path (Path): 処理対象のBBmodelのファイルパス
			bbmodel_data (dict): テクスチャのデータを更新するBBModelデータ

		Returns:
			dict: テクスチャのデータが更新されたBBModelデータ
		"""

		if "textures" in bbmodel_data:
			for texture in bbmodel_data["textures"]:
				if "source" in texture:
					texture["source"] = BBModelModifier._get_texture_base64_string((bbmodel_path.parent / texture["relative_path"]).resolve())

		return bbmodel_data

	@staticmethod
	def modify_bbmodel(bbmodel_path: Path) -> None:
		"""
		指定されたパスのBBModelファイルを変更する。
		変更内容は以下の通り。
		- 参考画像の削除
		- テクスチャの絶対パスの削除
		- テクスチャのbase64エンコードされたデータの更新

		Args:
			bbmodel_path (Path): 変更するBBModelファイルのパス

		Raises:
			FileNotFoundError: 指定されたパスにBBModelファイルが存在しない場合
			IsADirectoryError: 指定されたパスがディレクトリである場合
			PermissionError: 指定されたパスのファイルに対する読み取り/書き込み権限がない場合
			IOError: その他の入出力エラーが発生した場合
			json.JSONDecodeError: BBModelファイルの内容が有効なJSON形式でない場合
		"""

		bbmodel_data: dict = BBModelModifier._read_bbmodel_data(bbmodel_path)
		bbmodel_data = BBModelModifier._remove_reference_images(bbmodel_data)
		bbmodel_data = BBModelModifier._remove_texture_absolute_paths(bbmodel_data)
		bbmodel_data = BBModelModifier._update_embedded_texture_data(bbmodel_path, bbmodel_data)
		BBModelModifier._write_bbmodel_data(bbmodel_path, bbmodel_data)

	@staticmethod
	def _set_debug_args() -> None:
		"""
		デバッグ用コマンドライン引数を設定する。
		"""

		# 引数の設定
		parser = argparse.ArgumentParser(description="BBModel modifier for FBAC avatar build tool")
		parser.add_argument("input", type=str, help="Path to the BBModel file to be modified")

		# パスの設定
		args = parser.parse_args()
		BBModelModifier._debug_input_path = Path(args.input)

	@staticmethod
	def debug() -> None:
		"""
		BBモデル内部データ変更クラスのデバッグ動作を実行する。
		"""

		BBModelModifier._set_debug_args()

		# デバッグ出力
		Logger.print_info("BBModel modifier for FBAC avatar build tool")
		Logger.print_spacer(1)
		Logger.print_info(f"Modifying BBModel ({BBModelModifier._debug_input_path})...")

		try:
			BBModelModifier.modify_bbmodel(BBModelModifier._debug_input_path)
		except FileNotFoundError:
			Logger.print_error(f"The specified BBModel file was not found ({BBModelModifier._debug_input_path})")
			exit(errno.ENOENT)
		except IsADirectoryError:
			Logger.print_error(f"The specified BBModel file is a directory ({BBModelModifier._debug_input_path})")
			exit(errno.EISDIR)
		except PermissionError:
			Logger.print_error(f"No permission to read/write the specified BBModel file ({BBModelModifier._debug_input_path})")
			exit(errno.EACCES)
		except json.JSONDecodeError:
			Logger.print_error(f"Failed to parse the specified BBModel file ({BBModelModifier._debug_input_path})")
			exit(errno.EINVAL)
		except IOError:
			Logger.print_error(f"An unexpected error occurred while modifying the BBModel file ({BBModelModifier._debug_input_path})")
			exit(errno.EIO)

		Logger.print_info(f"Completed modifying BBModel ({BBModelModifier._debug_input_path})")

if __name__ == "__main__":
	BBModelModifier.debug()
