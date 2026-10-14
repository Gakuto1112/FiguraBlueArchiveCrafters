import re
import unittest
from pathlib import Path

from common_modules.base_path import base_path

AVATARS_DIR = base_path.root / "src" / "avatars"
TYPES_FILE = base_path.root / "src" / "core" / "types" / "blue_archive_character.lua"
DECL = re.compile(r"^\s*---@(class|alias)\s+(?:\(exact\)\s+)?([\w.]+)")


def character_lua_files():
    for d in sorted(AVATARS_DIR.iterdir()):
        if d.is_dir() and not d.name.startswith("."):
            for f in sorted((d / "scripts").glob("*.lua")):
                yield d.name[:3], f


class TestCharacterTypes(unittest.TestCase):
    def test_types_file_exists_and_is_meta(self) -> None:
        """共通の型定義はビルド対象外の`src/core/types`にあり、`---@meta`で始まる。"""
        self.assertTrue(TYPES_FILE.is_file())
        self.assertTrue(TYPES_FILE.read_text(encoding="utf-8").startswith("---@meta"))
        self.assertNotIn("scripts", TYPES_FILE.relative_to(base_path.root / "src" / "core").parts)

    def test_declarations_use_character_namespace(self) -> None:
        """キャラクター側の`---@class`/`---@alias`は`Character<ID>`名前空間に属し、共通型を再宣言しない。"""
        for cid, f in character_lua_files():
            for line in f.read_text(encoding="utf-8").splitlines():
                m = DECL.match(line)
                if m is None:
                    continue
                name = m.group(2)
                self.assertTrue(name.startswith(f"Character{cid}"), f"{f}: {name}")
                self.assertFalse(name.startswith("BlueArchiveCharacter"), f"{f}: {name}")

    def test_character_sheet_inherits_base(self) -> None:
        """各`blue_archive_character.lua`は`Character<ID> : BlueArchiveCharacter`を1つだけ宣言し、本体にその型を付ける。"""
        for cid, f in character_lua_files():
            if f.name != "blue_archive_character.lua":
                continue
            text = f.read_text(encoding="utf-8")
            self.assertEqual(len(re.findall(rf"^---@class (?:\(exact\) )?Character{cid} : BlueArchiveCharacter\b", text, re.M)), 1, str(f))
            self.assertEqual(len(re.findall(rf"^---@type Character{cid}$", text, re.M)), 1, str(f))

    def test_no_duplicate_declarations_across_characters(self) -> None:
        """同名の`---@class`/`---@alias`がキャラクター間で重複しない。"""
        seen: dict[str, Path] = {}
        for _, f in character_lua_files():
            for line in f.read_text(encoding="utf-8").splitlines():
                m = DECL.match(line)
                if m is None:
                    continue
                self.assertNotIn(m.group(2), seen, f"{f} duplicates {seen.get(m.group(2))}")
                seen[m.group(2)] = f


if __name__ == "__main__":
    unittest.main()
