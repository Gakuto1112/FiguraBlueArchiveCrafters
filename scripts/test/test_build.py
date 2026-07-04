import subprocess
import sys
import unittest

from common_modules.base_path import base_path

class TestBuild(unittest.TestCase):
    def test_build(self) -> None:
        """
        アバターのビルドが成功するかテストする。
        """

        try:
            result = subprocess.run(["uv", "run", "-m", "build.build"], cwd=(base_path.root / "scripts"), check=True, capture_output=True, text=True)
            print(result.stdout, end="")
        except subprocess.CalledProcessError as error:
            print(error.stdout, end="")
            print(error.stderr, end="", file=sys.stdout)
            self.fail(f"Failed to build avatars.\n{error.stderr}")

if __name__ == "__main__":
    unittest.main()
