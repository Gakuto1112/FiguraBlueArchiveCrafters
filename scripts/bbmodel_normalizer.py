import json
import re
import sys
from typing import Any

from common_modules.logger import Logger


def _normalize_array_fields(data: dict[str, Any], key: str, fields: tuple[str, ...]) -> None:
    if key not in data:
        return

    items = data[key]
    if not isinstance(items, list):
        raise ValueError(f"'{key}' must be an array")

    for index, item in enumerate(items):
        if not isinstance(item, dict):
            raise ValueError(f"'{key}[{index}]' must be an object")
        for field in fields:
            if field in item:
                item[field] = False


def _normalize_outliner_nodes(nodes: list[Any], path: str = "outliner") -> None:
    for index, node in enumerate(nodes):
        node_path = f"{path}[{index}]"
        if isinstance(node, str):
            continue
        if not isinstance(node, dict):
            raise ValueError(f"'{node_path}' must be an object or UUID string")

        if "isOpen" in node:
            node["isOpen"] = False

        if "children" in node:
            children = node["children"]
            if not isinstance(children, list):
                raise ValueError(f"'{node_path}.children' must be an array")
            _normalize_outliner_nodes(children, f"{node_path}.children")


def _format_bbmodel(data: dict[str, Any]) -> str:
    def flatten_array(match: re.Match[str]) -> str:
        array_text = match.group(0)
        flattened = re.sub(r"\n\s*", "", array_text)
        flattened = re.sub(r",\s*", ",", flattened)
        if len(flattened) <= 118:
            return flattened.replace(",", ", ")
        return array_text

    serialized = json.dumps(data, indent="\t", ensure_ascii=False)
    return re.sub(r"\[[^\[\]{}]+\]", flatten_array, serialized)


def normalize_bbmodel_json(source: str) -> str:
    data = json.loads(source)
    if not isinstance(data, dict):
        raise ValueError("The BBModel JSON root must be an object")

    _normalize_array_fields(data, "groups", ("isOpen", "selected", "primary_selected"))
    _normalize_array_fields(data, "animations", ("selected",))

    if "outliner" in data:
        outliner = data["outliner"]
        if not isinstance(outliner, list):
            raise ValueError("'outliner' must be an array")
        _normalize_outliner_nodes(outliner)

    return _format_bbmodel(data)


def main() -> int:
    try:
        source = sys.stdin.buffer.read().decode("utf-8")
        normalized = normalize_bbmodel_json(source)
    except (UnicodeDecodeError, json.JSONDecodeError, ValueError) as error:
        Logger.print_error(f"Failed to normalize BBModel JSON: {error}")
        return 1

    sys.stdout.buffer.write(normalized.encode("utf-8"))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
