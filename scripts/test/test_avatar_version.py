import argparse
import re
import sys
import unittest

from common_modules.base_path import base_path


class TestAvatarVersion(unittest.TestCase):
    tag_name: str = ""
    """
    比較を行うタグ（バージョン）の名前
    """

    def test_avatar_version(self) -> None:
        """
        "core/scripts/action_wheel/update_checker.lua"内の`AVATAR_VERSION`フィールドが、指定されたタグ名と一致することを確認する。
        """

        if len(self.tag_name) == 0:
            self.skipTest("Target tag name is not provided. Skipping avatar version test.")

        updater_path = base_path.root / "src" / "core" / "scripts" / "action_wheel" / "update_checker.lua"

        if not updater_path.exists():
            self.fail(f"\"src/core/scripts/action_wheel/update_checker.lua\" does not exist.")

        match = re.search(r"AVATAR_VERSION\s*=\s*\"(v\d+\.\d+\.\d+)\"", updater_path.read_text(encoding="utf-8"))

        if match is None:
            self.fail(f"Field \"AVATAR_VERSION\" does not exist in \"update_checker.lua\".")

        self.assertEqual(match.group(1), self.tag_name, f"Avatar version mismatch detected.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument("tag_name", type=str, help="The tag name to compare with the avatar version.")

    args, other_args = parser.parse_known_args()

    TestAvatarVersion.tag_name = args.tag_name
    unittest.main(argv=[sys.argv[0]] + other_args)
