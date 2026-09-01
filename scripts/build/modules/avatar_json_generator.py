import errno
import json
import re

from common_modules.logger import Logger
from build.modules.paths import paths
from .models.avatar_json.avatar_json_data import AvatarJsonData
from .models.avatar_json.avatar_json_config import AvatarJsonConfig


class AvatarJsonGenerator:
	"""
	テンプレートとアバターメタデータから最終的な`avatar.json`を生成するクラス
	"""

	@staticmethod
	def _get_template_avatar_json() -> AvatarJsonData:
		"""
		コアディレクトリ内にある`avatar_template.json`を読み込み、そのオブジェクトを返す。

		Returns:
			AvatarJsonData: avatar.jsonの内容を格納したオブジェクト

		Raises:
			FileNotFoundError: テンプレートファイルが存在しない場合
			IsADirectoryError: テンプレートファイルがディレクトリである場合
			PermissionError: テンプレートファイルの読み取り権限がない場合
			json.JSONDecodeError: テンプレートファイルのJSONパースが失敗した場合
			IOError: その他の入出力エラーが発生した場合
		"""

		with open(paths.core_dir / "avatar_template.json", "r") as f:
			return json.load(f)

	@staticmethod
	def _get_avatar_json_config(avatar_name: str) -> AvatarJsonConfig:
		"""
		キャラクターディレクトリ内にある`avatar_json_config.json`を読み込み、そのオブジェクトを返す。

		Args:
			avatar_name (str): avatar_json_configを読み込むアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。

		Returns:
			AvatarJsonConfig: avatar_json_configの内容を格納したオブジェクト

		Raises:
			ValueError: `avatar_name`が`paths.get_avatar_names()`で取得できる名前のいずれでもない場合
			FileNotFoundError: アバターJSON設定ファイルが存在しない場合
			IsADirectoryError: アバターJSON設定ファイルがディレクトリである場合
			PermissionError: アバターJSON設定ファイルの読み取り権限がない場合
			json.JSONDecodeError: アバターJSON設定ファイルのJSONパースが失敗した場合
			IOError: その他の入出力エラーが発生した場合
		"""

		# 入力の確認
		if not avatar_name in paths.get_avatar_names():
			raise ValueError(f"The specified avatar name \"{avatar_name}\" is not valid.")

		# メタデータの取得
		with open(paths.character_dir / avatar_name / "avatar_json_config.json", "r") as f:
			return json.load(f)

	@staticmethod
	def _merge_avatar_json(avatar_name: str, no_ignored_textures: bool = False) -> AvatarJsonData:
		"""
		テンプレートjsonデータを基に、指定したアバターのメタデータを結合し、最終的な`avatar.json`の内容オブジェクトを返す。

		Args:
			avatar_name (str): 結合するアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。
			no_ignored_textures (bool): "avatar.json"内の`ignoredTextures`フィールドを空にするかどうか。開発版Figuraの不具合への対応。これを`true`にするとアバターの容量が増加する。

		Returns:
			AvatarJsonData: 結合された`avatar.json`の内容を格納したオブジェクト

		Raises:
			ValueError: `avatar_name`が`paths.get_avatar_names()`で取得できる名前のいずれでもない場合
			FileNotFoundError: テンプレートファイル、アバターJSON設定ファイルのいずれかが存在しない場合
			IsADirectoryError: テンプレートファイル、アバターJSON設定ファイルのいずれかがディレクトリである場合
			PermissionError: テンプレートファイル、アバターJSON設定ファイルのいずれかの読み取り権限がない場合
			json.JSONDecodeError: テンプレートファイル、アバターJSON設定ファイルのいずれかのJSONパースが失敗した場合
			IOError: その他の入出力エラーが発生した場合
		"""

		# 入力の確認
		if not avatar_name in paths.get_avatar_names():
			raise ValueError(f"The specified avatar name \"{avatar_name}\" is not valid.")

		# avatar.jsonデータの取得
		template = AvatarJsonGenerator._get_template_avatar_json()
		meta = AvatarJsonGenerator._get_avatar_json_config(avatar_name)

		match = re.match(r'(\d{2}\w)', avatar_name)
		if match is None:
			raise ValueError(f"The specified avatar name \"{avatar_name}\" is not valid.")

		meta["placeholders"]["avatar_id"] = match.group(1)
		meta["placeholders"]["costume_name"] = f"({value})" if (value := meta["placeholders"].get("costume_name")) is not None else ""

		# プレイスホルダーの置換
		for template_key in ("name", "description"):
			template_value = template.get(template_key)
			if not isinstance(template_value, str):
				raise ValueError(f"The field named \"{template_key}\" does not exist in the template.")

			for meta_key, meta_value in meta["placeholders"].items():
				if type(meta_value) is not str:
					raise ValueError(f"The type of the placeholder value \"{meta_key}\" is not str.")

				template_value = template_value.replace(f"{{{{{meta_key.upper()}}}}}", meta_value or "")

			template_value = template_value.strip()
			template_value = re.sub(r"\s+", " ", template_value)
			template[template_key] = template_value

		# リスト・辞書型の結合
		if (template_auto_anims := template.get("autoAnims")) is not None and (meta_auto_anims := meta.get("autoAnims")) is not None:
			template["autoAnims"] = list(set(template_auto_anims) | set(meta_auto_anims))
		if not no_ignored_textures and (template_ignored_textures := template.get("ignoredTextures")) is not None and (meta_ignored_textures := meta.get("ignoredTextures")) is not None:
			template["ignoredTextures"] = list(set(template_ignored_textures) | set(meta_ignored_textures))
		if (template_customizations := template.get("customizations")) is not None and (meta_customizations := meta.get("customizations")) is not None:
			template["customizations"] = template_customizations | meta_customizations

		if no_ignored_textures:
			del template["ignoredTextures"]

		return template

	@staticmethod
	def write_merged_avatar_json(avatar_name: str, no_ignored_textures: bool = False) -> None:
		"""
		結合した`avatar.json`データを出力先ディレクトリの該当アバターフォルダ内に出力する。

		Args:
			avatar_name (str): 出力するアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。
			no_ignored_textures (bool): "avatar.json"内の`ignoredTextures`フィールドを空にするかどうか。開発版Figuraの不具合への対応。これを`true`にするとアバターの容量が増加する。

		Raises:
			ValueError: `avatar_name`が`paths.get_avatar_names()`で取得できる名前のいずれでもない場合
			FileNotFoundError: テンプレートファイル、アバターJSON設定ファイルのいずれかが存在しない場合
			IsADirectoryError: テンプレートファイル、アバターJSON設定ファイルのいずれかがディレクトリである場合
			PermissionError: テンプレートファイル、アバターJSON設定ファイルのいずれかの読み取り権限がない場合や出力された`avatar.json`の書き込み権限がない場合
			json.JSONDecodeError: テンプレートファイル、アバターJSON設定ファイルのいずれかのJSONパースが失敗した場合
			IOError: その他の入出力エラーが発生した場合
		"""

		# 入力の確認
		if not avatar_name in paths.get_avatar_names():
			raise ValueError(f"The specified avatar name \"{avatar_name}\" is not valid.")

		# 結合されたavatar.jsonデータの取得
		merged_data = AvatarJsonGenerator._merge_avatar_json(avatar_name, no_ignored_textures)

		# avatar.jsonの書き込み
		with open(paths.distribution_dir / avatar_name / "avatar.json", "w") as f:
			json.dump(merged_data, f, indent=4)

	@staticmethod
	def debug() -> None:
		"""
		`avatar.json`ジェネレーターのデバッグ動作を実行する。
		"""

		Logger.print_info("avatar.json generator for FBAC avatar build tool")
		Logger.print_spacer(1)

		Logger.print_info(f"Generating merged avatar.json (00a_Base)...")

		try:
			AvatarJsonGenerator.write_merged_avatar_json("00a_Base")
		except FileNotFoundError:
			Logger.print_error(f"Avatar JSON template file or avatar JSON config file not found.")
			exit(0)
		except IsADirectoryError:
			Logger.print_error(f"Avatar JSON template file or avatar JSON config file is a directory.")
			exit(errno.EISDIR)
		except PermissionError:
			Logger.print_error(f"No permission to read avatar JSON template file or avatar JSON config file, or no permission to write output avatar.json.")
			exit(errno.EACCES)
		except json.JSONDecodeError:
			Logger.print_error(f"Failed to parse avatar JSON template file or avatar JSON config file.")
			exit(errno.EINVAL)
		except IOError:
			Logger.print_error(f"An unexpected error occurred while processing avatar JSON files.")
			exit(errno.EIO)

		Logger.print_info(f"Completed generating merged avatar.json (00a_Base)")

if __name__ == "__main__":
	AvatarJsonGenerator.debug()
