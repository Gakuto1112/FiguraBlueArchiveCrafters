import errno
import json
from typing import NotRequired, TypedDict

from modules.logger import logger
from modules.paths import paths


class AvatarJsonData(TypedDict):
	"""
	`avatar.json`の構造体
	"""

	name: NotRequired[str]
	"""
	アバターの名前
	"""

	description: NotRequired[str]
	"""
	アバターの説明文
	"""

	author: NotRequired[str]
	"""
	アバターの作者（単一）
	`authors`も指定されている場合、このフィールドは無視される。
	"""

	authors: NotRequired[list[str]]
	"""
	アバターの作者（複数）
	`author`も指定されている場合、このフィールドが優先される。
	"""

	version: NotRequired[str]
	"""
	このアバターが対応している最低のFiguraのバージョン
	"""

	color: NotRequired[str]
	"""
	アバター使用時に適用する、Figuraの三角マークの色
	16進数カラーコードで指定する。（例: "ff0000"）
	"""

	autoScripts: NotRequired[list[str]]
	"""
	アバター読み込み時に、自動的に読み込まれるスクリプトのリスト
	アバターのルートディレクトリから参照し、ディレクトリのパス区切りをピリオドで表記し、拡張子は除く。（例: `/scripts/avatar.lua` → "scripts.avatar"）
	このフィールドを指定しない場合は、アバター内に含まれる全てのスクリプトが順不同で実行される。
	"""

	autoAnims: NotRequired[list[str]]
	"""
	アバター読み込み時に、自動的に再生するBBアニメーションのリスト
	アバターのルートディレクトリから参照し、ディレクトリのパス区切りをピリオドで表記し、拡張子は除く。その後にBBアニメーションIDをピリオドから指定する。（例: `/models/model.bbmodel - idle` → "models.model.idle"）
	"""

	ignoredTextures: NotRequired[list[str]]
	"""
	アバターに含めないテクスチャ画像のリスト
	アバターのルートディレクトリから参照し、ディレクトリのパス区切りをピリオドで表記し、拡張子は除く。（例: `/textures/texture.png` → "textures.texture"）
	"""

	customizations: NotRequired[dict[str, dict[str, str|bool]]]
	"""
	アバター読み込み時に自動加工するモデルパーツのリスト
	キーはモデルパーツを指定し、値は加工のオプションを指定する。
	モデルパーツの指定は、スクリプトからモデルパーツを参照する際と同様に指定する。（例: "models.models.main.Avatar.Head"）
	"""

class AvatarJsonConfig(TypedDict):
	"""
	テンプレートjsonデータと統合する特定のキャラクターのメタデータの構造体
	"""

	placeholders: AvatarMetaPlaceholderData
	"""
	テンプレートjsonデータ内のプレイスホルダーと置換する値のリスト
	"""

	ignoredTextures: NotRequired[list[str]]
	"""
	アバターに含めないテクスチャ画像のリスト
	アバターのルートディレクトリから参照し、ディレクトリのパス区切りをピリオドで表記し、拡張子は除く。（例: `/textures/texture.png` → "textures.texture"）
	テンプレートjsonデータ内の同名フィールドと統合される。
	"""

	autoAnims: NotRequired[list[str]]
	"""
	アバター読み込み時に、自動的に再生するBBアニメーションのリスト
	アバターのルートディレクトリから参照し、ディレクトリのパス区切りをピリオドで表記し、拡張子は除く。その後にBBアニメーションIDをピリオドから指定する。（例: `/models/model.bbmodel - idle` → "models.model.idle"）
	テンプレートjsonデータ内の同名フィールドと統合される。
	"""

	customizations: NotRequired[dict[str, dict[str, str|bool]]]
	"""
	アバター読み込み時に自動加工するモデルパーツのリスト
	キーはモデルパーツを指定し、値は加工のオプションを指定する。
	モデルパーツの指定は、スクリプトからモデルパーツを参照する際と同様に指定する。（例: "models.models.main.Avatar.Head"）
	テンプレートjsonデータ内の同名フィールドと統合される。
	"""

class AvatarMetaPlaceholderData(TypedDict):
	"""
	テンプレートjsonデータ内のプレイスホルダーと置換する値の構造体
	"""

	student_name: str
	"""
	生徒の名前
	衣装違いの場合はその衣装名も併記する。
	（例: "Shizuko", "Shizuko (Swimsuit)"）
	"""

	student_full_name: str
	"""
	生徒のフルネーム（名姓の順）
	衣装違いの場合はその衣装名も併記する。
	（例: "Shizuko Kawawa", "Shizuko Kawawa (Swimsuit)"）
	"""

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
		"""

		try:
			with open(paths.core_dir / "avatar_template.json", "r") as f:
				return json.load(f)
		except FileNotFoundError:
			logger.print_error(f"Template avatar_template.json not found ({paths.core_dir / 'avatar_template.json'})")
			exit(errno.ENOENT)
		except IsADirectoryError:
			logger.print_error(f"Template avatar_template.json is a directory ({paths.core_dir / 'avatar_template.json'})")
			exit(errno.EISDIR)
		except PermissionError:
			logger.print_error(f"No permission to read template avatar_template.json ({paths.core_dir / 'avatar_template.json'})")
			exit(errno.EACCES)
		except json.JSONDecodeError:
			logger.print_error(f"Template avatar_template.json is not a valid JSON file ({paths.core_dir / 'avatar_template.json'})")
			exit(errno.EINVAL)
		except:
			logger.print_error(f"An unexpected error occurred while reading template avatar_template.json ({paths.core_dir / 'avatar_template.json'})")
			exit(errno.EIO)

	@staticmethod
	def _get_avatar_json_config(avatar_name: str) -> AvatarJsonConfig:
		# 入力の確認
		if not avatar_name in paths.get_avatar_names():
			logger.print_error(f"Specified avatar name \"{avatar_name}\" is not valid.")
			exit(errno.EINVAL)

		# メタデータの取得
		try:
			with open(paths.character_dir / avatar_name / "avatar_json_config.json", "r") as f:
				return json.load(f)
		except FileNotFoundError:
			logger.print_error(f"Avatar json config file not found ({avatar_name}) ({paths.character_dir / avatar_name / 'avatar_json_config.json'})")
			exit(errno.ENOENT)
		except IsADirectoryError:
			logger.print_error(f"Avatar json config file is a directory ({avatar_name}) ({paths.character_dir / avatar_name / 'avatar_json_config.json'})")
			exit(errno.EISDIR)
		except PermissionError:
			logger.print_error(f"No permission to read avatar json config file ({avatar_name}) ({paths.character_dir / avatar_name / 'avatar_json_config.json'})")
			exit(errno.EACCES)
		except json.JSONDecodeError:
			logger.print_error(f"Avatar json config file is not a valid JSON file ({avatar_name}) ({paths.character_dir / avatar_name / 'avatar_json_config.json'})")
			exit(errno.EINVAL)
		except:
			logger.print_error(f"An unexpected error occurred while reading avatar json config ({avatar_name}) ({paths.character_dir / avatar_name / 'avatar_json_config.json'})")
			exit(errno.EIO)

	@staticmethod
	def _merge_avatar_json(avatar_name: str) -> AvatarJsonData:
		"""
		テンプレートjsonデータを基に、指定したアバターのメタデータを結合し、最終的な`avatar.json`の内容オブジェクトを返す。

		Args:
			avatar_name (str): 結合するアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。

		Returns:
			AvatarJsonData: 結合された`avatar.json`の内容を格納したオブジェクト
		"""

		# 入力の確認
		if not avatar_name in paths.get_avatar_names():
			logger.print_error(f"Specified avatar name \"{avatar_name}\" is not valid.")
			exit(errno.EINVAL)

		# avatar.jsonデータの取得
		template = AvatarJsonGenerator._get_template_avatar_json()
		meta = AvatarJsonGenerator._get_avatar_json_config(avatar_name)

		# プレイスホルダーの置換
		if (name := template.get("name")) is not None:
			template["name"] = name.replace("{{STUDENT_NAME}}", meta["placeholders"]["student_name"])
		if (description := template.get("description")) is not None:
			template["description"] = description.replace("{{STUDENT_FULL_NAME}}", meta["placeholders"]["student_full_name"])

		# リスト・辞書型の結合
		if (template_auto_anims := template.get("autoAnims")) is not None and (meta_auto_anims := meta.get("autoAnims")) is not None:
			template["autoAnims"] = list(set(template_auto_anims) | set(meta_auto_anims))
		if (template_ignored_textures := template.get("ignoredTextures")) is not None and (meta_ignored_textures := meta.get("ignoredTextures")) is not None:
			template["ignoredTextures"] = list(set(template_ignored_textures) | set(meta_ignored_textures))
		if (template_customizations := template.get("customizations")) is not None and (meta_customizations := meta.get("customizations")) is not None:
			template["customizations"] = template_customizations | meta_customizations

		return template

	@staticmethod
	def write_merged_avatar_json(avatar_name: str):
		"""
		結合した`avatar.json`データを出力先ディレクトリの該当アバターフォルダ内に出力する。
		"""

		# 入力の確認
		if not avatar_name in paths.get_avatar_names():
			logger.print_error(f"Specified avatar name \"{avatar_name}\" is not valid.")
			exit(errno.EINVAL)

		# 結合されたavatar.jsonデータの取得
		merged_data = AvatarJsonGenerator._merge_avatar_json(avatar_name)

		# avatar.jsonの書き込み
		try:
			with open(paths.distribution_dir / avatar_name / "avatar.json", "w") as f:
				json.dump(merged_data, f, indent=4)
		except PermissionError:
			logger.print_error(f"No permission to write merged avatar.json file ({paths.distribution_dir / avatar_name / 'avatar.json'})")
			exit(errno.EACCES)
		except:
			logger.print_error(f"An unexpected error occurred while writing merged avatar.json file ({paths.distribution_dir / avatar_name / 'avatar.json'})")
			exit(errno.EIO)

	@staticmethod
	def debug():
		"""
		`avatar.json`ジェネレーターのデバッグ動作を実行する。
		"""

		logger.print_info("avatar.json generator for FBAC avatar build tool")
		logger.print_spacer(1)

		logger.print_info(f"Generating merged avatar.json (00a_base)...")
		AvatarJsonGenerator.write_merged_avatar_json("00a_base")
		logger.print_info(f"Completed generating merged avatar.json (00a_base)")

if __name__ == "__main__":
	AvatarJsonGenerator.debug()
