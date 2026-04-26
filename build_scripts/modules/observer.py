import re
import time
from json import JSONDecodeError
from pathlib import Path

from modules.avatar_json_generator import AvatarJsonGenerator
from modules.file_ops import FileOperator
from modules.logger import Logger
from modules.paths import paths
from modules.thumbnail_generator import ThumbnailGenerator
from watchdog.events import (DirCreatedEvent, DirDeletedEvent,
                             DirModifiedEvent, DirMovedEvent, FileCreatedEvent,
                             FileDeletedEvent, FileModifiedEvent,
                             FileMovedEvent, FileSystemEventHandler)
from watchdog.observers import Observer


class AvatarFileEventHandler(FileSystemEventHandler):
	"""
	アバターのアセットファイルが更新された際のイベントハンドラークラス
	"""

	_AVATAR_JSON_RELATED_PATHS: tuple[str, ...] = (fr"{str(paths.core_dir)}/avatar_template\.json", fr"{str(paths.character_dir)}/\d{{2}}\w_\w+/avatar_json_config\.json")
	"""
	`avatar.json`の生成に関係するファイルのパスのリスト
	"""

	_THUMBNAIL_RELATED_PATHS: tuple[str, ...] = (fr"{str(paths.character_dir)}/\d{{2}}\w_\w+/thumbnail_config\.json", fr"{str(paths.character_dir)}/\d{{2}}\w_\w+/thumbnail\.png")
	"""
	アバターサムネイルの生成に関係するファイルのパスのリスト
	"""

	_compiled_avatar_json_related_paths: tuple[re.Pattern[str], ...] = tuple()
	"""
	コンパイル済み`avatar.json`関連ファイルのパスの正規表現のリスト
	"""

	_compiled_thumbnail_related_paths: tuple[re.Pattern[str], ...] = tuple()
	"""
	コンパイル済みサムネイル関連ファイルのパスの正規表現のリスト
	"""

	def __init__(self) -> None:
		"""
		コンストラクタ
		"""

		super().__init__()

		AvatarFileEventHandler._compiled_avatar_json_related_paths = tuple(re.compile(pattern) for pattern in AvatarFileEventHandler._AVATAR_JSON_RELATED_PATHS)
		AvatarFileEventHandler._compiled_thumbnail_related_paths = tuple(re.compile(pattern) for pattern in AvatarFileEventHandler._THUMBNAIL_RELATED_PATHS)

	@staticmethod
	def _create_single_asset_path(target_path: Path) -> None:
		"""
		指定されたアセットパス単体を出力先にコピーする。
		入力されたパスに基づいて生成関数を変更する。

		Args:
			target_path (Path): コピーするアセットのパス
		"""

		try:
			if AvatarFileEventHandler._compiled_avatar_json_related_paths[0].search(str(target_path)):
				for avatar_name in paths.get_avatar_names():
					AvatarJsonGenerator.write_merged_avatar_json(avatar_name)
			elif AvatarFileEventHandler._compiled_avatar_json_related_paths[1].search(str(target_path)):
				AvatarJsonGenerator.write_merged_avatar_json(target_path.relative_to(paths.character_dir).parts[0])
			elif AvatarFileEventHandler._compiled_thumbnail_related_paths[0].search(str(target_path)):
				for avatar_name in paths.get_avatar_names():
					ThumbnailGenerator.save_thumbnail(avatar_name, ThumbnailGenerator.generate_thumbnail(avatar_name))
			elif AvatarFileEventHandler._compiled_thumbnail_related_paths[1].search(str(target_path)):
				avatar_name = target_path.relative_to(paths.character_dir).parts[0]
				ThumbnailGenerator.save_thumbnail(avatar_name, ThumbnailGenerator.generate_thumbnail(avatar_name))
			else:
				FileOperator.copy_single_asset_path(target_path)
		except FileNotFoundError:
			Logger.print_warning(f"Failed to output updated asset file because of missing files ({target_path})")
		except IsADirectoryError:
			Logger.print_warning(f"Failed to output updated asset file because the target path is a directory ({target_path})")
		except PermissionError:
			Logger.print_warning(f"Failed to output updated asset file because of no permission to access required paths ({target_path})")
		except JSONDecodeError:
			Logger.print_warning(f"Failed to output updated asset file because of JSON parsing error in config files ({target_path})")
		except IOError:
			Logger.print_warning(f"Failed to output updated asset file because of an unexpected I/O error ({target_path})")

	@staticmethod
	def _delete_single_asset_path(target_path: Path) -> None:
		"""
		指定されたアセットパス単体を出力先から削除する。
		`avatar.json`やサムネイルの生成に必要なファイルが削除された場合は、警告を出力する。

		Args:
			target_path (Path): 削除するアセットのパス
		"""

		try:
			FileOperator.delete_single_asset_path(target_path)
		except PermissionError:
			Logger.print_warning(f"Failed to delete asset file because of no permission to delete assets ({target_path})")
		except FileNotFoundError:
			Logger.print_warning(f"Failed to delete asset file because the file is already deleted ({target_path})")
		except IOError:
			Logger.print_warning(f"Failed to delete asset file because of an unexpected I/O error ({target_path})")

		if any(pattern.search(str(target_path)) for pattern in AvatarFileEventHandler._compiled_avatar_json_related_paths):
			Logger.print_warning(f"You deleted required file for avatar.json generation. avatar.json generation will be skipped until the file is restored. ({target_path})")
		elif any(pattern.search(str(target_path)) for pattern in AvatarFileEventHandler._compiled_thumbnail_related_paths):
			Logger.print_warning(f"You deleted required file for thumbnail generation. Thumbnail generation will be skipped until the file is restored. ({target_path})")

	def on_created(self, event: DirCreatedEvent | FileCreatedEvent) -> None:
		"""
		ファイル/ディレクトリの作成イベントのハンドラー関数

		Args:
			event (DirCreatedEvent | FileCreatedEvent): 作成イベントのオブジェクト
		"""

		super().on_created(event)

		target_path: Path = Path(str(event.src_path))
		if target_path.is_relative_to(paths.core_dir) or target_path.is_relative_to(paths.character_dir):
			if isinstance(event, FileCreatedEvent):
				Logger.print_info(f"File creation detected: {event.src_path}")

				AvatarFileEventHandler._create_single_asset_path(target_path)
			else:
				Logger.print_info(f"Directory creation detected: {event.src_path}")

				AvatarFileEventHandler._create_single_asset_path(target_path)

	def on_modified(self, event: DirModifiedEvent | FileModifiedEvent) -> None:
		"""
		ファイル/ディレクトリの変更イベントのハンドラー関数

		Args:
			event (DirModifiedEvent | FileModifiedEvent): 変更イベントのオブジェクト
		"""

		super().on_modified(event)

		target_path: Path = Path(str(event.src_path))
		if isinstance(event, FileModifiedEvent) and (target_path.is_relative_to(paths.core_dir) or target_path.is_relative_to(paths.character_dir)):
			Logger.print_info(f"File modification detected: {event.src_path}")

			AvatarFileEventHandler._create_single_asset_path(target_path)

	def on_moved(self, event: DirMovedEvent | FileMovedEvent) -> None:
		"""
		ファイル/ディレクトリの移動イベントのハンドラー関数

		Args:
			event (DirMovedEvent | FileMovedEvent): 移動イベントのオブジェクト
		"""

		super().on_moved(event)

		from_path: Path = Path(str(event.src_path))
		to_path: Path = Path(str(event.dest_path))
		from_is_relative_to: bool = from_path.is_relative_to(paths.core_dir) or from_path.is_relative_to(paths.character_dir)
		to_is_relative_to: bool = to_path.is_relative_to(paths.core_dir) or to_path.is_relative_to(paths.character_dir)
		if from_is_relative_to or to_is_relative_to:
			if isinstance(event, FileMovedEvent):
				Logger.print_info(f"File move detected: {event.src_path} -> {event.dest_path}")

				# リソースの移動は「移動元から削除 → 移動先に再コピー」と考える。
				if from_is_relative_to:
					AvatarFileEventHandler._delete_single_asset_path(from_path)
				if to_is_relative_to:
					AvatarFileEventHandler._delete_single_asset_path(to_path)
			else:
				Logger.print_info(f"Directory move detected: {event.src_path} -> {event.dest_path}")

				if from_is_relative_to:
					AvatarFileEventHandler._delete_single_asset_path(from_path)
				if to_is_relative_to:
					AvatarFileEventHandler._delete_single_asset_path(to_path)

	def on_deleted(self, event: DirDeletedEvent | FileDeletedEvent) -> None:
		"""
		ファイル/ディレクトリの削除イベントのハンドラー関数

		Args:
			event (DirDeletedEvent | FileDeletedEvent): 削除イベントのオブジェクト
		"""

		super().on_deleted(event)

		target_path: Path = Path(str(event.src_path))
		if target_path.is_relative_to(paths.core_dir) or target_path.is_relative_to(paths.character_dir):
			if isinstance(event, FileDeletedEvent):
				Logger.print_info(f"File deletion detected: {event.src_path}")

				AvatarFileEventHandler._delete_single_asset_path(target_path)
			else:
				Logger.print_info(f"Directory deletion detected: {event.src_path}")

				AvatarFileEventHandler._delete_single_asset_path(target_path)

class AvatarFileObserver():
	"""
	アバターのアセットファイルを監視し、必要に応じて再ビルドするクラス
	"""

	@staticmethod
	def observe() -> None:
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
			Logger.print_info("\nObservation mode stopped.")
			Logger.print_spacer(1)
			if Logger.is_plana:
				Logger.print_plana("See you later, Sensei.")
			else:
				Logger.print_arona("See you next time! Sensei!")
			Logger.print_spacer(1)

	@staticmethod
	def debug() -> None:
		"""
		アバファイルオブザーバークラスのデバッグ動作を実行する。
		"""

		Logger.print_info("Avatar asset observer for FBAC avatar build tool")
		Logger.print_spacer(1)
		Logger.print_info(f"Starting observation of avatar asset files in source directory ({paths.source_dir})")
		Logger.print_info("Press Ctrl+C to stop observation.")
		Logger.print_spacer(1)
		AvatarFileObserver.observe()

observer: AvatarFileObserver = AvatarFileObserver()

if __name__ == "__main__":
	AvatarFileObserver.debug()
