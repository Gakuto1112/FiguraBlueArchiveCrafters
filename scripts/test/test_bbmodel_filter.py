import json
import subprocess
import tempfile
import unittest
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
SETUP_SCRIPT = REPOSITORY_ROOT / "scripts" / "setup_bbmodel_filter.sh"


class TestBBModelFilter(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary_directory = tempfile.TemporaryDirectory()
        self.repository = Path(self.temporary_directory.name)
        self._run_git("init", "--quiet")
        self._run_git("config", "user.name", "BBModel filter tests")
        self._run_git("config", "user.email", "bbmodel-filter-tests@example.invalid")
        (self.repository / ".gitattributes").write_text(
            "*.bbmodel filter=bbmodel-normalize\n",
            encoding="utf-8",
        )
        self._run_git("add", ".gitattributes")
        self._run_git("-c", "commit.gpgsign=false", "commit", "--quiet", "-m", "Add BBModel filter attribute")
        result = subprocess.run(
            ["sh", str(SETUP_SCRIPT), str(self.repository)],
            check=True,
            capture_output=True,
            text=True,
        )
        self.configure_output = result.stdout

    def tearDown(self) -> None:
        self.temporary_directory.cleanup()

    def _run_git(self, *arguments: str, check: bool = True) -> subprocess.CompletedProcess[bytes]:
        return subprocess.run(
            ["git", "-C", str(self.repository), *arguments],
            check=check,
            capture_output=True,
        )

    def test_setup_registers_required_local_filter_command(self) -> None:
        required = self._run_git("config", "--local", "--get", "filter.bbmodel-normalize.required")
        clean_command = self._run_git("config", "--local", "--get", "filter.bbmodel-normalize.clean")
        smudge_command = self._run_git("config", "--local", "--get", "filter.bbmodel-normalize.smudge")

        self.assertEqual(required.stdout.decode().strip(), "true")
        self.assertIn(b"uv", clean_command.stdout)
        self.assertIn(str(REPOSITORY_ROOT / "scripts" / "bbmodel_normalizer.py").encode(), clean_command.stdout)
        self.assertEqual(smudge_command.stdout.decode().strip(), "cat")
        self.assertEqual(self.configure_output, "Configured the BBModel clean filter.\n")

    def test_git_add_normalizes_index_without_changing_worktree(self) -> None:
        source_document = {
            "groups": [
                {
                    "isOpen": True,
                    "selected": True,
                    "primary_selected": True,
                    "_static": {"temp_data": {"preserve": "value"}},
                }
            ],
            "animations": [{"selected": True}],
            "outliner": [
                {"uuid": "root", "isOpen": True, "children": [{"uuid": "child", "isOpen": True}]}
            ],
            "elements": [{"selected": True, "isOpen": True}],
            "other": {"selected": True, "isOpen": True},
        }
        source = (json.dumps(source_document, indent="\t", ensure_ascii=False) + "\n").encode("utf-8")
        model_path = self.repository / "fixture.bbmodel"
        model_path.write_bytes(source)

        self._run_git("add", "fixture.bbmodel")

        staged = json.loads(self._run_git("show", ":fixture.bbmodel").stdout)
        self.assertFalse(staged["groups"][0]["isOpen"])
        self.assertFalse(staged["groups"][0]["selected"])
        self.assertFalse(staged["groups"][0]["primary_selected"])
        self.assertEqual(staged["groups"][0]["_static"]["temp_data"], {"preserve": "value"})
        self.assertFalse(staged["animations"][0]["selected"])
        self.assertFalse(staged["outliner"][0]["isOpen"])
        self.assertFalse(staged["outliner"][0]["children"][0]["isOpen"])
        self.assertEqual(staged["elements"][0], {"selected": True, "isOpen": True})
        self.assertEqual(staged["other"], {"selected": True, "isOpen": True})
        self.assertEqual(model_path.read_bytes(), source)

        model_path.unlink()
        self._run_git("checkout", "--", "fixture.bbmodel")
        self.assertEqual(model_path.read_bytes(), self._run_git("show", ":fixture.bbmodel").stdout)

    def test_required_filter_rejects_malformed_json(self) -> None:
        malformed_path = self.repository / "malformed.bbmodel"
        malformed_path.write_text("{invalid json", encoding="utf-8")

        result = self._run_git("add", "malformed.bbmodel", check=False)

        self.assertNotEqual(result.returncode, 0)
        self.assertNotEqual(
            self._run_git("ls-files", "--error-unmatch", "malformed.bbmodel", check=False).returncode,
            0,
        )


if __name__ == "__main__":
    unittest.main()
