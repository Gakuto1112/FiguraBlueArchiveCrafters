import errno
import json
from enum import IntEnum
from pathlib import Path
from typing import TypedDict, cast

from modules.logger import Logger
from modules.paths import paths
from PIL import Image, ImageChops


class ThumbnailColorType(IntEnum):
	"""
	サムネイルの色付き枠で使用する色の種類を表す列挙型
	タイプ名は本家ブルーアーカイブの属性名と対応する。
	"""

	EXPLOSIVE = 0
	"""
	爆発（赤）
	"""

	PENETRATION = 1
	"""
	貫通（黄）
	"""

	CHEMICAL = 2
	"""
	分解（緑）
	"""

	MYSTIC = 3
	"""
	神秘（青）
	"""

	SONIC = 4
	"""
	振動（紫）
	"""

class ThumbnailConfig(TypedDict):
	"""
	サムネイル設定ファイルの構造体
	"""

	colorType: str
	"""
	サムネイルの色付き枠で使用する色の種類
	`ThumbnailColorType`のいずれかを指定する。
	"""

class ThumbnailGenerator:
	"""
	アバターのサムネイル画像を生成するクラス
	"""

	@staticmethod
	def _open_image(path: Path):
		"""
		指定されたパスから画像を開き、そのPIL Imageオブジェクトを返す。
		try-exceptブロックによる安全なファイルアクセス実施済み。

		Args:
			path (Path): 開く画像のファイルパス

		Returns:
			Image.Image: 開いた画像のPIL Imageオブジェクト

		Raises:
			FileNotFoundError: 指定されたパスに（画像）ファイルが存在しない場合
			IsADirectoryError: 指定されたパスがディレクトリである場合
			PermissionError: 指定されたパスのファイルに対する読み取り権限がない場合
			IOError: その他の入出力エラーが発生した場合
		"""

		with Image.open(path) as img:
			return img.copy()

	@staticmethod
	def _get_thumbnail_config(avatar_name: str) -> ThumbnailConfig:
		"""
		アバターディレクトリ内にある`thumbnail_config.json`を読み込み、そのオブジェクトを返す。

		Args:
			avatar_name (str): サムネイル設定を読み込むアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。

		Returns:
			ThumbnailConfig: サムネイル設定ファイルの内容を格納したオブジェクト

		Raises:
			FileNotFoundError: サムネイル設定ファイルが存在しない場合
			IsADirectoryError: サムネイル設定ファイルがディレクトリである場合
			PermissionError: サムネイル設定ファイルの読み取り権限がない場合
			json.JSONDecodeError: サムネイル設定ファイルのJSONパースが失敗した場合
			IOError: その他の入出力エラーが発生した場合
		"""

		with open(paths.character_dir / avatar_name / "thumbnail_config.json", "r") as f:
			config: ThumbnailConfig = json.load(f)
			config["colorType"] = config["colorType"].upper()
			return config

	@staticmethod
	def generate_thumbnail(avatar_name: str) -> Image.Image:
		"""
		指定されたアバターのサムネイル画像を生成し、そのPIL Imageオブジェクトを返す。

		Args:
			avatar_name (str): サムネイルを生成するアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。

		Returns:
			Image.Image: 生成されたサムネイル画像のPIL Imageオブジェクト

		Raises:
			ValueError: `avatar_name`が`paths.get_avatar_names()`で取得できる名前のいずれでもない場合、またはサムネイル設定ファイルの`colorType`の値が`ThumbnailColorType`のいずれでもない場合
			FileNotFoundError: サムネイル設定ファイルが存在しない場合、またはサムネイル画像の生成に必要なテンプレート画像が存在しない場合
			IsADirectoryError: サムネイル設定ファイルがディレクトリである場合、またはサムネイル画像の生成に必要なテンプレート画像のいずれかがディレクトリである場合
			PermissionError: サムネイル設定ファイルの読み取り権限がない場合、またはサムネイル画像の生成に必要なテンプレート画像のいずれかに対する読み取り権限がない場合
			json.JSONDecodeError: サムネイル設定ファイルのJSONパースが失敗した場合
			IOError: その他の入出力エラーが発生した場合
		"""

		# 入力の確認
		if not avatar_name in paths.get_avatar_names():
			raise ValueError(f"The specified avatar name \"{avatar_name}\" is not valid.")

		# サムネイル設定ファイルの読み込み
		thumbnail_config: ThumbnailConfig = ThumbnailGenerator._get_thumbnail_config(avatar_name)
		if thumbnail_config["colorType"] not in ThumbnailColorType.__members__:
			raise ValueError(f"Invalid colorType \"({thumbnail_config['colorType']})\" found in thumbnail config ({avatar_name})")

		# キャンバスの作成
		canvas: Image.Image = Image.new("RGBA", (256, 256), (0, 0, 0, 0))

		# 背景とキャラクターのマスク画像
		mask_image: Image.Image = ThumbnailGenerator._open_image(paths.root / "thumbnail_templates" / "trimming_mask.png").convert("L")

		# レイヤー1: 影
		layer1: Image.Image = ThumbnailGenerator._open_image(paths.root / "thumbnail_templates" / "L1_shadow.png").convert("RGBA")
		canvas.alpha_composite(layer1)

		# レイヤー2: 背景
		layer2: Image.Image = ThumbnailGenerator._open_image(paths.root / "thumbnail_templates" / "L2_background.png").convert("RGBA")
		layer2.putalpha(mask_image)
		canvas.alpha_composite(layer2)

		# レイヤー3: 白枠
		canvas.alpha_composite(ThumbnailGenerator._open_image(paths.root / "thumbnail_templates" / "L3_frame.png").convert("RGBA"))

		# レイヤー4: キャラクター
		if (layer4_path := paths.character_dir / avatar_name / "thumbnail.png").exists():
			# キャラクター画像のトリミング
			layer4: Image.Image = ThumbnailGenerator._open_image(layer4_path).convert("RGBA")
			width, height = layer4.size
			square_size = min(width, height)
			layer4 = layer4.crop(((width - square_size) // 2, (height - square_size) // 2, (width + square_size) // 2, (height + square_size) // 2))
			layer4 = layer4.resize((256, 256), resample=Image.Resampling.LANCZOS)

			# マスクキング
			layer4.putalpha(ImageChops.multiply(mask_image, layer4.getchannel("A")))
			canvas.alpha_composite(layer4)
		else:
			Logger.print_warning(f"Character thumbnail not found ({avatar_name}). Character layer will be skipped.")

		# レイヤー5: 色付き枠
		palette: Image.Image = ThumbnailGenerator._open_image(paths.root / "thumbnail_templates" / "frame_colors.png").convert("RGBA")
		layer5: Image.Image = Image.new("RGBA", (256, 256), cast(tuple[int, int, int, int], palette.getpixel((ThumbnailColorType[thumbnail_config["colorType"]].value, 0)))) # pyright: ignore[reportUnknownMemberType]
		layer5.putalpha(ThumbnailGenerator._open_image(paths.root / "thumbnail_templates" / "L5_colored_frame.png").convert("L"))
		canvas.alpha_composite(layer5)

		# レイヤー6: ウィジェット
		canvas.alpha_composite(ThumbnailGenerator._open_image(paths.root / "thumbnail_templates" / "L6_widgets.png").convert("RGBA"))

		# レイヤー7: アバターID
		sprite_sheet: Image.Image = ThumbnailGenerator._open_image(paths.root / "thumbnail_templates" / "char_sprites.png").convert("RGBA")

		SPRITE_SIZE: tuple[int, int] = (7, 9) # スプライトシート内のスプライト1つのサイズ（x, y）
		SPRITE_MAP: dict[str, tuple[int, int]] = { # スプライトシート内の文字とスプライトの位置の対応表
			"0": (0, 0),
			"1": (1, 0),
			"2": (2, 0),
			"3": (3, 0),
			"4": (4, 0),
			"5": (0, 1),
			"6": (1, 1),
			"7": (2, 1),
			"8": (3, 1),
			"9": (4, 1),
			"a": (0, 2),
			"b": (1, 2),
			"c": (2, 2),
			"d": (3, 2),
			"e": (4, 2),
		}
		CHAR_SCALE: int = 5 # スプライトをサムネイル画像に貼り付ける際の拡大スケール
		CHAR_GAP : int = 0 # スプライト同士の間隔
		ID_ANCHOR: tuple[int, int] = (14, 178) # サムネイル上でのアバタIDの貼り付け基点（サムネイル、ID共に左上が基準点）

		layer7: Image.Image = Image.new("RGBA", (SPRITE_SIZE[0] * CHAR_SCALE * 3 + CHAR_GAP * 2, SPRITE_SIZE[1] * CHAR_SCALE), (0, 0, 0, 0))

		for i, char in enumerate(avatar_name.split("_", 1)[0]):
			if char not in SPRITE_MAP:
				Logger.print_error(f"Character \"{char}\" in avatar ID is invalid ({avatar_name})")
				exit(errno.EINVAL)

			sprite = sprite_sheet.crop((SPRITE_MAP[char][0] * SPRITE_SIZE[0], SPRITE_MAP[char][1] * SPRITE_SIZE[1], SPRITE_MAP[char][0] * SPRITE_SIZE[0] + SPRITE_SIZE[0], SPRITE_MAP[char][1] * SPRITE_SIZE[1] + SPRITE_SIZE[1]))
			sprite = sprite.resize((SPRITE_SIZE[0] * CHAR_SCALE, SPRITE_SIZE[1] * CHAR_SCALE), Image.Resampling.NEAREST)
			layer7.paste(sprite, ((SPRITE_SIZE[0] * CHAR_SCALE + CHAR_GAP) * i, 0))

		canvas.alpha_composite(layer7, ID_ANCHOR)

		return canvas

	@staticmethod
	def save_thumbnail(avatar_name: str, thumbnail: Image.Image) -> None:
		"""
		生成サムネイル画像(厳密には引数で指定されたPIL Imageオブジェクト)を指定されたアバターのサムネイル画像として保存する。

		Args:
			avatar_name (str): サムネイルを保存するアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。
			thumbnail (Image.Image): 保存するサムネイル画像のPIL Imageオブジェクト。サムネイル画像は`thumbnail_generator.generate_thumbnail()`で生成する。

		Raises:
			ValueError: `avatar_name`が`paths.get_avatar_names()`で取得できる名前のいずれでもない場合
			PermissionError: サムネイル画像の保存先ファイルに対する書き込み権限がない場合
			IOError: その他の入出力エラーが発生した場合
		"""

		# 入力の確認
		if not avatar_name in paths.get_avatar_names():
			raise ValueError(f"The specified avatar name \"{avatar_name}\" is not valid.")

		thumbnail.save(paths.distribution_dir / avatar_name / "avatar.png")

	@staticmethod
	def debug() -> None:
		"""
		サムネイルジェネレーターのデバッグ動作を実行する。
		"""

		Logger.print_info("Thumbnail generator for FBAC avatar build tool")
		Logger.print_spacer(1)

		Logger.print_info(f"Generating thumbnail image (00a_base)...")

		try:
			ThumbnailGenerator.generate_thumbnail("00a_base").show()
		except FileNotFoundError:
			Logger.print_error(f"Thumbnail config file not found.")
			exit(errno.ENOENT)
		except IsADirectoryError:
			Logger.print_error(f"Thumbnail config file or template image file is a directory.")
			exit(errno.EISDIR)
		except PermissionError:
			Logger.print_error(f"No permission to read thumbnail config file or template image file.")
			exit(errno.EACCES)
		except json.JSONDecodeError:
			Logger.print_error(f"Failed to parse thumbnail config file.")
			exit(errno.EINVAL)
		except IOError:
			Logger.print_error(f"An unexpected error occurred while generating thumbnail image.")
			exit(errno.EIO)

		Logger.print_info(f"Completed generating thumbnail image (00a_base)")
		Logger.print_spacer(1)
		Logger.print_info(f"Hint: Generated thumbnail image is being displayed using the default image viewer of your operating system.")

if __name__ == "__main__":
	ThumbnailGenerator.debug()
