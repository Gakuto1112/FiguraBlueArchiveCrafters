import argparse
from pathlib import Path
import subprocess
import re

from modules.logger import Logger

class TextureCompressor:
	_debug_input_path: Path = Path()

	@staticmethod
	def _compress_texture(texture_path: Path) -> None:
		"""
		指定されたパスのテクスチャ（PNG画像）をpngquantを用いて圧縮する。
		インデックスカラーに変換する過程で、画像の色が256色より多い場合は、256色に減色される。

		Args:
			texture_path (Path): 圧縮するテクスチャ画像までのパス

		Raises:
			RuntimeError: pngquantの実行に失敗した場合
		"""
		result = subprocess.run(["pngquant", "--speed", "1", "--ext", ".png", "--skip-if-larger", "--verbose", "--strip", "--force", texture_path], capture_output=True, text=True)

		if result.returncode != 0 and result.returncode != 98:
			# pngquant側でエラーが発生
			raise RuntimeError(f"Failed to compress texture \"{texture_path}\" with pngquant. Error code = {result.returncode}")

		palette_color_match: re.Match[str] | None = re.search(r"made\shistogram\.\.\.(\d+)\scolors\sfound", result.stdout)
		palette_color: int = int(palette_color_match.group(1)) if palette_color_match else 0

		if palette_color == 0:
			Logger.print_warning(f"Failed to get texture palette color count ({texture_path})")
		elif palette_color > 256:
			Logger.print_warning(f"The texture \"{texture_path}\" has {palette_color} colors, but reduced to 256 colors by pngquant. Please check the texture's quality.")

	@staticmethod
	def _set_debug_args() -> None:
		"""
		デバッグ用コマンドライン引数を設定する。
		"""

		# 引数の設定
		parser = argparse.ArgumentParser(description="Texture compressor for FBAC avatar build tool")
		parser.add_argument("input", type=str, help="Path to the texture to be compressed")

		# パスの設定
		args = parser.parse_args()
		TextureCompressor._debug_input_path = Path(args.input)

	@staticmethod
	def debug() -> None:
		"""
		ファイルオペレータークラスのデバッグ動作を実行する。
		"""

		TextureCompressor._set_debug_args()

		# デバッグ出力
		Logger.print_info("Texture compressor for FBAC avatar build tool")
		Logger.print_spacer(1)
		Logger.print_info(f"Compressing texture ({TextureCompressor._debug_input_path})...")

		try:
			TextureCompressor._compress_texture(TextureCompressor._debug_input_path)
		except RuntimeError as e:
			Logger.print_error(str(e))
			exit(1)

if __name__ == "__main__":
	TextureCompressor.debug()
