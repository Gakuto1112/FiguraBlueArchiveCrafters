import time
from pathlib import Path

from modules.file_ops import FileOperator
from modules.logger import logger
from modules.paths import paths
from watchdog.events import (DirCreatedEvent, DirDeletedEvent,
                             DirModifiedEvent, DirMovedEvent, FileCreatedEvent,
                             FileDeletedEvent, FileModifiedEvent,
                             FileMovedEvent, FileSystemEventHandler)
from watchdog.observers import Observer


class AvatarFileEventHandler(FileSystemEventHandler):
	"""
	アバターのアセットファイルが更新された際のイベントハンドラークラス
	"""

	def on_created(self, event: DirCreatedEvent | FileCreatedEvent) -> None:
		"""
		ファイル/ディレクトリの作成イベントのハンドラー関数

		Args:
			event (DirCreatedEvent | FileCreatedEvent): 作成イベントのオブジェクト
		"""

		target_path: Path = Path(str(event.src_path))
		if target_path.is_relative_to(paths.core_dir) or target_path.is_relative_to(paths.character_dir):
			if isinstance(event, FileCreatedEvent):
				logger.print_info(f"File creation detected: {event.src_path}")

				FileOperator.copy_single_asset_path(target_path)
			else:
				logger.print_info(f"Directory creation detected: {event.src_path}")

				FileOperator.copy_single_asset_path(target_path)

	def on_modified(self, event: DirModifiedEvent | FileModifiedEvent) -> None:
		"""
		ファイル/ディレクトリの変更イベントのハンドラー関数

		Args:
			event (DirModifiedEvent | FileModifiedEvent): 変更イベントのオブジェクト
		"""

		target_path: Path = Path(str(event.src_path))
		if isinstance(event, FileModifiedEvent) and (target_path.is_relative_to(paths.core_dir) or target_path.is_relative_to(paths.character_dir)):
			logger.print_info(f"File modification detected: {event.src_path}")

			FileOperator.copy_single_asset_path(target_path)

	def on_moved(self, event: DirMovedEvent | FileMovedEvent) -> None:
		return super().on_moved(event)

	def on_deleted(self, event: DirDeletedEvent | FileDeletedEvent) -> None:
		if isinstance(event, FileDeletedEvent):
			logger.print_info(f"File deletion detected: {event.src_path}")
		else:
			logger.print_info(f"Directory deletion detected: {event.src_path}")

class AvatarFileObserver():
	"""
	アバターのアセットファイルを監視し、必要に応じて再ビルドするクラス
	"""

	@staticmethod
	def observe():
		"""
		アバターアセットの更新監視を開始する。
		"""
		observer = Observer()
		observer.schedule(AvatarFileEventHandler(), str(paths.source_dir), recursive=True)
		observer.start()

		try:
			while True:
				time.sleep(1)
		except KeyboardInterrupt:
			observer.stop()

	@staticmethod
	def debug() -> None:
		"""
		アバファイルオブザーバークラスのデバッグ動作を実行する。
		"""

		logger.print_info("Avatar asset observer for FBAC avatar build tool")
		logger.print_spacer(1)
		logger.print_info(f"Starting observation of avatar asset files in source directory ({paths.source_dir})")
		logger.print_info("Press Ctrl+C to stop observation.")
		logger.print_spacer(1)
		AvatarFileObserver.observe()

observer: AvatarFileObserver = AvatarFileObserver()

if __name__ == "__main__":
	AvatarFileObserver.debug()
