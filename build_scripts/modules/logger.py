import sys


class Logger:
	"""
	標準出力を管理するユーティリティクラス
	"""

	def print_info(self, message: str) -> None:
		"""
		INFOレベルのメッセージを標準出力する。
		"""
		print(message)

	def print_warning(self, message: str) -> None:
		"""
		WARNレベルのメッセージを標準出力する。
		"""
		print(f"WARN: {message}")

	def print_error(self, message: str) -> None:
		"""
		ERRORレベルのメッセージを標準エラー出力する。
		"""
		print(f"ERROR: {message}", file=sys.stderr)

logger = Logger()
