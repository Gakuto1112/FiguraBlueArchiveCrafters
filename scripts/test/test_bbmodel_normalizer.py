import json
import unittest

from bbmodel_normalizer import normalize_bbmodel_json


class TestBBModelNormalizer(unittest.TestCase):
    def test_normalizes_only_specified_editor_state_fields(self) -> None:
        source = json.dumps(
            {
                "groups": [
                    {
                        "name": "Accessory",
                        "uuid": "group-uuid",
                        "export": True,
                        "locked": False,
                        "scope": 0,
                        "origin": [1.0, 2.0, 3.0],
                        "rotation": [0.0, 0.0, 0.0],
                        "color": 5,
                        "children": ["element-uuid"],
                        "reset": False,
                        "shade": True,
                        "mirror_uv": False,
                        "visibility": True,
                        "autouv": 0,
                        "isOpen": True,
                        "selected": True,
                        "primary_selected": True,
                        "_static": {"temp_data": {"keep": "value"}},
                    }
                ],
                "animations": [{"selected": True}],
                "outliner": [
                    {
                        "uuid": "root",
                        "isOpen": True,
                        "children": [
                            {
                                "uuid": "child",
                                "isOpen": True,
                                "children": [{"uuid": "leaf", "isOpen": True}],
                            }
                        ],
                    }
                ],
                "elements": [{"selected": True, "isOpen": True}],
                "other": {"selected": True, "isOpen": True},
            },
            indent="\t",
        )

        result = json.loads(normalize_bbmodel_json(source))

        self.assertEqual(
            result["groups"][0],
            {
                "name": "Accessory",
                "uuid": "group-uuid",
                "export": True,
                "locked": False,
                "scope": 0,
                "origin": [1.0, 2.0, 3.0],
                "rotation": [0.0, 0.0, 0.0],
                "color": 5,
                "children": ["element-uuid"],
                "reset": False,
                "shade": True,
                "mirror_uv": False,
                "visibility": True,
                "autouv": 0,
                "isOpen": False,
                "selected": False,
                "primary_selected": False,
                "_static": {"temp_data": {"keep": "value"}},
            },
        )
        self.assertEqual(result["animations"][0]["selected"], False)
        self.assertEqual(result["outliner"][0]["isOpen"], False)
        self.assertEqual(result["outliner"][0]["children"][0]["isOpen"], False)
        self.assertEqual(result["outliner"][0]["children"][0]["children"][0]["isOpen"], False)
        self.assertEqual(result["elements"][0], {"selected": True, "isOpen": True})
        self.assertEqual(result["other"], {"selected": True, "isOpen": True})

    def test_does_not_add_missing_fields_or_arrays(self) -> None:
        source = '{"other": {"isOpen": true, "selected": true}}'

        result = json.loads(normalize_bbmodel_json(source))

        self.assertEqual(result, {"other": {"isOpen": True, "selected": True}})

    def test_rejects_malformed_json_and_invalid_structures(self) -> None:
        invalid_documents = (
            "{invalid json",
            "[]",
            '{"groups": {}}',
            '{"animations": "not an array"}',
            '{"outliner": {}}',
            '{"outliner": [{"children": {}}]}',
        )

        for source in invalid_documents:
            with self.subTest(source=source):
                with self.assertRaises(ValueError):
                    normalize_bbmodel_json(source)

    def test_normalization_is_idempotent(self) -> None:
        source = json.dumps(
            {
                "groups": [{"isOpen": True, "selected": True, "primary_selected": True}],
                "animations": [{"selected": True}],
                "outliner": [{"isOpen": True, "children": [{"isOpen": True}]}],
            },
            indent="\t",
        )

        first_result = normalize_bbmodel_json(source)
        second_result = normalize_bbmodel_json(first_result)

        self.assertEqual(second_result, first_result)


if __name__ == "__main__":
    unittest.main()
