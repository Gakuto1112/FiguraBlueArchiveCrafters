import sys


class Logger:
	"""
	標準出力を管理するユーティリティクラス
	"""

	should_print_debug_log: bool = True
	"""
	DEBUGレベルのログを出力するかどうかのフラグ
	"""

	def print_debug(self, message: str) -> None:
		"""
		DEBUGレベルのメッセージを標準出力する。
		`should_print_debug_log`がFalseの場合は何も出力しない。
		"""
		if self.should_print_debug_log:
			print(f"DEBUG: {message}")

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
