<!-- markdownlint-disable MD041 -->
Language: 　**English**　|　[日本語](./README_jp.md)
<!-- markdownlint-enable MD041 -->

# FBAC Scripts

This directory contains external scripts that are not directly related to the use of FBAC avatars.
The available scripts are as follows.

## BBModel Editor-State Normalization When Staging

When staged, `.bbmodel` files have the following BlockBench editor state normalized to `false`:

- `groups[].isOpen`, `groups[].selected`, and `groups[].primary_selected`
- `animations[].selected`
- `isOpen` on every tree node under `outliner`

Other fields are left unchanged. Normalization applies to the content added to the Git index; it does not modify the working-tree file.

Git filter configuration is local to each clone. After installing `uv`, run the following command from the repository root. This setup is required once per clone.

```sh
sh scripts/setup_bbmodel_filter.sh
```

Before setup, Git does not run the filter and stages the content unchanged.

## Build Script

This command-line script converts (builds) source files for FBAC avatars into data that can be used in the game.

For more information, please refer to the [README](./build/README.md) of the Build Script.

## README Generate Script

This script creates the Markdown README document for this repository (FBAC) and the README text files to be included in the distribution data from templates.

For more information, please refer to the [README](./readme_generate/README.md) of the README Generate Script.

## Test Script

These scripts check whether builds for FBAC avatars succeed and whether source files contain correct configuration values.

For more information, please refer to the [README](./test/README.md) of the Test Script.
