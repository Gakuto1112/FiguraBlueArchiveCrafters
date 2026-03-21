import errno
import json
from enum import IntEnum
from pathlib import Path
from typing import TypedDict, cast

from modules.logger import logger
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
		"""

		try:
			with Image.open(path) as img:
				return img.copy()
		except FileNotFoundError:
			logger.print_error(f"Required thumbnail template not found ({path})")
			exit(errno.ENOENT)
		except IsADirectoryError:
			logger.print_error(f"Required thumbnail template is a directory ({path})")
			exit(errno.EISDIR)
		except PermissionError:
			logger.print_error(f"No permission to read required thumbnail template ({path})")
			exit(errno.EACCES)
		except:
			logger.print_error(f"An unexpected error occurred while reading required thumbnail template ({path})")
			exit(errno.EIO)

	def _get_thumbnail_config(self, avatar_name: str) -> ThumbnailConfig:
		"""
		アバターディレクトリ内にある`thumbnail_config.json`を読み込み、そのオブジェクトを返す。

		Args:
			avatar_name (str): サムネイル設定を読み込むアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。

		Returns:
			ThumbnailConfig: サムネイル設定ファイルの内容を格納したオブジェクト
		"""

		try:
			with open(paths.character_dir / avatar_name / "thumbnail_config.json", "r") as f:
				config: ThumbnailConfig = json.load(f)
				config["colorType"] = config["colorType"].upper()
				return config
		except FileNotFoundError:
			logger.print_error(f"Thumbnail config file not found ({avatar_name}) ({paths.character_dir / avatar_name / 'thumbnail_config.json'})")
			exit(errno.ENOENT)
		except IsADirectoryError:
			logger.print_error(f"Thumbnail config file is a directory ({avatar_name}) ({paths.character_dir / avatar_name / 'thumbnail_config.json'})")
			exit(errno.EISDIR)
		except PermissionError:
			logger.print_error(f"No permission to read thumbnail config file ({avatar_name}) ({paths.character_dir / avatar_name / 'thumbnail_config.json'})")
			exit(errno.EACCES)
		except json.JSONDecodeError:
			logger.print_error(f"Thumbnail config file is not a valid JSON file ({avatar_name}) ({paths.character_dir / avatar_name / 'thumbnail_config.json'})")
			exit(errno.EINVAL)
		except:
			logger.print_error(f"An unexpected error occurred while reading thumbnail config ({avatar_name}) ({paths.character_dir / avatar_name / 'thumbnail_config.json'})")
			exit(errno.EIO)

	@staticmethod
	def generate_thumbnail(avatar_name: str) -> Image.Image:
		"""
		指定されたアバターのサムネイル画像を生成し、そのPIL Imageオブジェクトを返す。

		Args:
			avatar_name (str): サムネイルを生成するアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。

		Returns:
			Image.Image: 生成されたサムネイル画像のPIL Imageオブジェクト
		"""

		# 入力の確認
		if not avatar_name in paths.get_avatar_names():
			logger.print_error(f"Specified avatar name \"{avatar_name}\" is not valid.")
			exit(errno.EINVAL)

		# サムネイル設定ファイルの読み込み
		thumbnail_config: ThumbnailConfig = thumbnail_generator._get_thumbnail_config(avatar_name)
		if thumbnail_config["colorType"] not in ThumbnailColorType.__members__:
			logger.print_error(f"Invalid colorType \"({thumbnail_config['colorType']})\" found in thumbnail config ({avatar_name})")
			exit(errno.EINVAL)

		# キャンバスの作成
		canvas: Image.Image = Image.new("RGBA", (256, 256), (0, 0, 0, 0))

		# 背景とキャラクターのマスク画像
		mask_image: Image.Image = thumbnail_generator._open_image(paths.root / "thumbnail_templates" / "trimming_mask.png").convert("L")

		# レイヤー1: 背景
		layer1: Image.Image = thumbnail_generator._open_image(paths.root / "thumbnail_templates" / "L1_background.png").convert("RGBA")
		layer1.putalpha(mask_image)
		canvas.alpha_composite(layer1)

		# レイヤー2: 白枠
		canvas.alpha_composite(thumbnail_generator._open_image(paths.root / "thumbnail_templates" / "L2_frame.png").convert("RGBA"))

		# レイヤー3: キャラクター
		if (layer3_path := paths.character_dir / avatar_name / "thumbnail.png").exists():
			# キャラクター画像のトリミング
			layer3: Image.Image = thumbnail_generator._open_image(layer3_path).convert("RGBA")
			width, height = layer3.size
			square_size = min(width, height)
			layer3 = layer3.crop(((width - square_size) // 2, (height - square_size) // 2, (width + square_size) // 2, (height + square_size) // 2))
			layer3 = layer3.resize((256, 256), resample=Image.Resampling.LANCZOS)

			# マスクキング
			layer3.putalpha(ImageChops.multiply(mask_image, layer3.getchannel("A")))
			canvas.alpha_composite(layer3)
		else:
			logger.print_warning(f"Character thumbnail not found ({avatar_name}). Character layer will be skipped.")

		# レイヤー4: 色付き枠
		palette: Image.Image = thumbnail_generator._open_image(paths.root / "thumbnail_templates" / "frame_colors.png").convert("RGBA")
		layer4: Image.Image = Image.new("RGBA", (256, 256), cast(tuple[int, int, int, int], palette.getpixel((ThumbnailColorType[thumbnail_config["colorType"]].value, 0)))) # pyright: ignore[reportUnknownMemberType]
		layer4.putalpha(thumbnail_generator._open_image(paths.root / "thumbnail_templates" / "L4_colored_frame.png").convert("L"))
		canvas.alpha_composite(layer4)

		# レイヤー5: ウィジェット
		canvas.alpha_composite(thumbnail_generator._open_image(paths.root / "thumbnail_templates" / "L5_widgets.png").convert("RGBA"))

		# レイヤー6: アバターID
		sprite_sheet: Image.Image = thumbnail_generator._open_image(paths.root / "thumbnail_templates" / "char_sprites.png").convert("RGBA")

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
		CHAR_GAP : int = 1 # スプライト同士の間隔
		ID_ANCHOR: tuple[int, int] = (12, 178) # サムネイル上でのアバタIDの貼り付け基点（サムネイル、ID共に左上が基準点）

		layer6: Image.Image = Image.new("RGBA", (SPRITE_SIZE[0] * CHAR_SCALE * 3 + CHAR_GAP * 2, SPRITE_SIZE[1] * CHAR_SCALE), (0, 0, 0, 0))

		AVATAR_ID: str = "18a"
		for i, char in enumerate(AVATAR_ID):
			if char not in SPRITE_MAP:
				logger.print_error(f"Character \"{char}\" in avatar ID is invalid ({avatar_name})")
				exit(errno.EINVAL)

			sprite = sprite_sheet.crop((SPRITE_MAP[char][0] * SPRITE_SIZE[0], SPRITE_MAP[char][1] * SPRITE_SIZE[1], SPRITE_MAP[char][0] * SPRITE_SIZE[0] + SPRITE_SIZE[0], SPRITE_MAP[char][1] * SPRITE_SIZE[1] + SPRITE_SIZE[1]))
			sprite = sprite.resize((SPRITE_SIZE[0] * CHAR_SCALE, SPRITE_SIZE[1] * CHAR_SCALE), Image.Resampling.NEAREST)
			layer6.paste(sprite, ((SPRITE_SIZE[0] * CHAR_SCALE + CHAR_GAP) * i, 0))

		canvas.alpha_composite(layer6, ID_ANCHOR)

		return canvas

	@staticmethod
	def save_thumbnail(avatar_name: str, thumbnail: Image.Image) -> None:
		"""
		生成サムネイル画像(厳密には引数で指定されたPIL Imageオブジェクト)を指定されたアバターのサムネイル画像として保存する。

		Args:
			avatar_name (str): サムネイルを保存するアバターの名前。`paths.get_avatar_names()`で取得できる名前のいずれかを指定する。
			thumbnail (Image.Image): 保存するサムネイル画像のPIL Imageオブジェクト。サムネイル画像は`thumbnail_generator.generate_thumbnail()`で生成する。
		"""

		# 入力の確認
		if not avatar_name in paths.get_avatar_names():
			logger.print_error(f"Specified avatar name \"{avatar_name}\" is not valid.")
			exit(errno.EINVAL)

		try:
			thumbnail.save(paths.distribution_dir / avatar_name / "avatar.png")
		except PermissionError:
			logger.print_error(f"No permission to save thumbnail image ({paths.distribution_dir / avatar_name / 'avatar.png'})")
			exit(errno.EACCES)
		except:
			logger.print_error(f"An unexpected error occurred while saving thumbnail image ({paths.distribution_dir / avatar_name / 'avatar.png'})")
			exit(errno.EIO)

	@staticmethod
	def debug() -> None:
		"""
		サムネイルジェネレーターのデバッグ動作を実行する。
		"""

		logger.print_info("Thumbnail generator for FBAC avatar build tool")
		logger.print_spacer(1)

		logger.print_info(f"Generating thumbnail image (00a_base)...")
		thumbnail_generator.generate_thumbnail("00a_base").show()
		logger.print_info(f"Completed generating thumbnail image (00a_base)")
		logger.print_info(f"Hint: Generated thumbnail image is being displayed using the default image viewer of your operating system.")


thumbnail_generator = ThumbnailGenerator()

if __name__ == "__main__":
	thumbnail_generator.debug()
