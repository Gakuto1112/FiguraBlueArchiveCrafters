import re
import unittest

from common_modules.base_path import base_path


class TestInternalAvatarName(unittest.TestCase):
    def test_internal_avatar_name(self):
        """
        各キャラクターの`blue_archive_character.lua`内の`BlueArchiveCharacter.basic.avatarName`フィールドが、キャラクターのディレクトリ名と一致することを確認する。
        大文字小文字も区別してテストする。
        """

        characters_dir = base_path.root / "src" / "avatars"

        if not characters_dir.exists():
            self.fail(f"Character source directory ({characters_dir}) does not exist.")

        regex = re.compile(r"basic\s*=\s*{.+avatarName\s*=\s*\"(\d{2}[a-e]_[A-Z][a-z]+(_[A-Z][a-z]+)?)\";.+};", re.DOTALL)

        for character_dir in characters_dir.iterdir():
            character_name = character_dir.name

            if character_name.startswith("."):
                continue

            with self.subTest(character_dir=character_dir):
                character_script = character_dir / "scripts" / "blue_archive_character.lua"

                if not character_script.exists():
                    self.assertTrue(False, f"\"blue_archive_character.lua\" does not exist in {character_name}.")
                    continue

                content = character_script.read_text(encoding="utf-8")
                match = regex.search(content)

                if match is None:
                    self.assertTrue(False, f"Field \"basic.avatarName\" does not exist in \"blue_archive_character.lua\" for character {character_name}.")
                    continue

                self.assertEqual(match.group(1), character_name, f"The internal avatar name does not match the character name for character {character_name}.")

if __name__ == "__main__":
	unittest.main()
