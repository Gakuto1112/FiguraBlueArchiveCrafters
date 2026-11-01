#!/bin/sh
set -eu

filter_name="bbmodel-normalize"
script_directory=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

shell_quote() {
	printf "'%s'" "$(printf '%s' "$1" | sed "s/'/'\\\\''/g")"
}

if [ "$#" -gt 1 ]; then
	printf '%s\n' "Usage: sh scripts/setup_bbmodel_filter.sh [repository-root]" >&2
	exit 2
fi

if [ "$#" -eq 1 ]; then
	repository_root=$1
else
	repository_root=$(git -C "$script_directory" rev-parse --show-toplevel)
fi

clean_command="uv run --project $(shell_quote "$script_directory") --directory $(shell_quote "$script_directory") python -m bbmodel_normalizer.bbmodel_normalizer"

git -C "$repository_root" config --local "filter.$filter_name.clean" "$clean_command"
git -C "$repository_root" config --local "filter.$filter_name.smudge" cat
git -C "$repository_root" config --local "filter.$filter_name.required" true

printf '%s\n' "Configured the BBModel clean filter."
