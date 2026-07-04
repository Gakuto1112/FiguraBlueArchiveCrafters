import subprocess
import unittest

from common_modules.base_path import base_path

class TestBuild(unittest.TestCase):
	def test_build(self) -> None:
		"""
		アバターのビルドが成功するかテストする。
		"""

		try:
			subprocess.run(["uv", "run", "-m", "build.build"], cwd=(base_path.root / "scripts"),check=True)
		except:
			self.fail("Failed to build avatars.")

if __name__ == "__main__":
	unittest.main()
