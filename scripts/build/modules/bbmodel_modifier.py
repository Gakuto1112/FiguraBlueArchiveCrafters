import argparse
import errno
import json
import base64
from pathlib import Path
import re
from uuid import UUID

from common_modules.logger import Logger
from build.modules.paths import paths

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

		def flatten_array(match: re.Match) -> str:
			"""
			文字数が118字以下の配列の改行を取り除き、1行にまとめるリプレイサー関数。
			BlockBenchのBBモデルのJSONフォーマットに合致させるための処理。

			Args:
				match (re.Match): 正規表現のマッチオブジェクト

			Returns:
				str: 処理されたJSON形式の文字列
			"""

			substring = match.group(0)
			flattened = re.sub(r"\n\s*", "", substring)

			if len(flattened) <= 118:
				return flattened.replace(",", ", ")
			return substring

		with bbmodel_path.open("w", encoding="utf-8") as f:
			f.write(re.sub(r"\[[^\[\]{}]+\]", flatten_array, json.dumps(bbmodel_data, indent="\t", ensure_ascii=False)))

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
					texture["source"] = BBModelModifier._get_texture_base64_string((bbmodel_path.parent / texture["relative_path"].replace("../../../core/textures/", "../textures/")).resolve())

		return bbmodel_data

	@staticmethod
	def _get_camera_anchor_uuid(bbmodel_data: dict) -> UUID | None:
		"""
		BBModelデータから`CameraAnchor`のモデルグループを探し、そのUUIDを返す。
		`CameraAnchor`が存在しない場合は`None`を返す。

		Args:
			bbmodel_data (dict): `CameraAnchor`を探し出す対象のBBModelデータ

		Returns:
			UUID | None: カメラアンカーのUUID。存在しない場合はNoneを返す。
		"""

		if "groups" in bbmodel_data:
			result = [element for element in bbmodel_data["groups"] if element.get("name") == "CameraAnchor"]
			if len(result) > 0:
				return UUID(result[0].get("uuid"))

	@staticmethod
	def _get_camera_model_uuids(bbmodel_data: dict, camera_anchor_uuid: UUID) -> list[UUID]:
		"""
		BBModelデータから指定したUUIDのアウトライナーを探し、その子要素のUUIDを全て返す。

		Args:
			bbmodel_data (dict): `CameraAnchor`の子要素のUUIDを探し出す対象のBBModelデータ
			camera_anchor_uuid (UUID): `CameraAnchor`のUUID

		Returns:
			list[UUID]: `CameraAnchor`の子要素のUUIDのリスト。存在しない場合は空のリストを返す。
		"""

		if "outliner" in bbmodel_data:
			result = [element for element in bbmodel_data["outliner"] if element.get("uuid") == str(camera_anchor_uuid)]
			if len(result) > 0:
				return [UUID(uuid) for uuid in result[0].get("children", [])]

		return []

	@staticmethod
	def _remove_camera_anchor_children(bbmodel_data: dict, camera_anchor_uuid: UUID) -> dict:
		"""
		BBModelデータから指定したUUIDのアウトライナーから子要素のUUIDを削除し、変更後のBBModelデータを返す。

		Args:
			bbmodel_data (dict): `CameraAnchor`のアウトライナーの子要素のUUIDを削除する対象のBBModelデータ
			camera_anchor_uuid (UUID): 子要素を削除する`CameraAnchor`のUUID

		Returns:
			dict: `CameraAnchor`のアウトライナーから子要素のUUIDが削除されたBBModelデータ
		"""

		if "outliner" in bbmodel_data:
			camera_anchor_outliner = [element for element in bbmodel_data["outliner"] if element.get("uuid") == str(camera_anchor_uuid)]
			if len(camera_anchor_outliner) > 0 and "children" in camera_anchor_outliner[0]:
				camera_anchor_outliner[0]["children"] = []

		return bbmodel_data

	@staticmethod
	def _remove_camera_model_parts(bbmodel_data: dict, camera_model_uuids: list[UUID]) -> dict:
		"""
		BBModelデータから指定したUUIDのモデルパーツを削除し、変更後のBBModelデータを返す。

		Args:
			bbmodel_data (dict): `CameraAnchor`のモデルパーツを削除する対象のBBModelデータ
			camera_model_uuids (list[UUID]): 削除する`CameraAnchor`のモデルパーツのUUIDリスト

		Returns:
			dict: `CameraAnchor`のモデルパーツが削除されたBBModelデータ
		"""

		if "elements" in bbmodel_data:
			bbmodel_data["elements"] = [element for element in bbmodel_data["elements"] if UUID(element.get("uuid")) not in camera_model_uuids]

		return bbmodel_data

	@staticmethod
	def _remove_camera_model(bbmodel_data: dict) -> dict:
		"""
		BBModelデータ内のカメラモデル（`CameraAnchor`内のモデルパーツ）を削除し、変更後のBBModelデータを返す。

		Args:
			bbmodel_data (dict): カメラモデルを削除するBBModelデータ

		Returns:
			dict: カメラモデルが削除されたBBModelデータ
		"""

		target_uuid = BBModelModifier._get_camera_anchor_uuid(bbmodel_data)
		if not target_uuid:
			return bbmodel_data

		camera_model_uuids = BBModelModifier._get_camera_model_uuids(bbmodel_data, target_uuid)
		bbmodel_data = BBModelModifier._remove_camera_model_parts(bbmodel_data, camera_model_uuids)
		bbmodel_data = BBModelModifier._remove_camera_anchor_children(bbmodel_data, target_uuid)

		return bbmodel_data

	@staticmethod
	def _modify_bbmodel(bbmodel_path: Path) -> None:
		"""
		指定されたパスのBBModelファイルを変更する。
		変更内容は以下の通り。
		- 参考画像の削除
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
		bbmodel_data = BBModelModifier._update_embedded_texture_data(bbmodel_path, bbmodel_data)
		bbmodel_data = BBModelModifier._remove_camera_model(bbmodel_data)
		BBModelModifier._write_bbmodel_data(bbmodel_path, bbmodel_data)

	@staticmethod
	def modify_avatar_bbmodels(avatar_name: str) -> None:
		"""
		指定されたアバターのBBModelファイルをすべて変更する。

		Args:
			avatar_name (str): 変更するアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。

		Raises:
			ValueError: `avatar_name`が`paths.get_avatar_names()`で取得できる名前のいずれでもない場合
			FileNotFoundError: BBModelファイルが存在しない場合
			IsADirectoryError: BBModelファイルがディレクトリである場合
			PermissionError: BBModelファイルに対する読み取り/書き込み権限がない場合
			IOError: その他の入出力エラーが発生した場合
			json.JSONDecodeError: BBModelファイルの内容が有効なJSON形式でない場合
		"""

		if not avatar_name in paths.get_avatar_names():
			raise ValueError(f"The specified avatar name \"{avatar_name}\" is not valid.")

		for bbmodel_path in (paths.distribution_dir / avatar_name / "models").rglob(f"*.bbmodel"):
			BBModelModifier._modify_bbmodel(bbmodel_path)

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
			BBModelModifier._modify_bbmodel(BBModelModifier._debug_input_path)
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
