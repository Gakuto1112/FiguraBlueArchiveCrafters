import sys


class Logger:
	"""
	標準出力を管理するユーティリティクラス
	"""

	should_print_debug_log: bool = True
	"""
	DEBUGレベルのログを出力するかどうかのフラグ
	"""

	_last_spacer_count: int = 0
	"""
	直前に出力したスペーサーの連続数
	"""

	@staticmethod
	def print_debug(message: str) -> None:
		"""
		DEBUGレベルのメッセージを標準出力する。
		`should_print_debug_log`がFalseの場合は何も出力しない。
		"""

		if Logger.should_print_debug_log:
			print(f"[DEBUG] {message}")
			Logger._last_spacer_count = 0

	@staticmethod
	def print_info(message: str) -> None:
		"""
		INFOレベルのメッセージを標準出力する。
		"""

		print(message)
		Logger._last_spacer_count = 0

	@staticmethod
	def print_warning(message: str) -> None:
		"""
		WARNレベルのメッセージを標準出力する。
		"""

		print(f"[WARN] {message}")
		Logger._last_spacer_count = 0

	@staticmethod
	def print_error(message: str) -> None:
		"""
		ERRORレベルのメッセージを標準エラー出力する。
		"""

		print(f"[ERROR] {message}", file=sys.stderr)
		Logger._last_spacer_count = 0

	@staticmethod
	def print_spacer(max_spacers: int = 0) -> None:
		"""
		空行を標準出力する。

		Args:
			max_spacers (int, optional): 連続して出力するスペーサーの最大数。0は制限なし。デフォルトは0。
		"""

		if max_spacers == 0 or Logger._last_spacer_count < max_spacers:
			print()
			Logger._last_spacer_count += 1
