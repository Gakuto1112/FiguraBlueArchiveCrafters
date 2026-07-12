<!-- markdownlint-disable MD041 -->
Language: 　**English**　|　[日本語](./READNE_jp.md)
<!-- markdownlint-enable MD041 -->

# FBAC Test Scripts

These scripts check whether builds for Figura Blue Archive Crafters (FBAC) avatars succeed and whether source files contain correct configuration values.

## Test items

### Build test

Tests whether building an avatar using the [build script](../build/README.md) completes successfully. If the build script produces an error during the build, the test fails.

All arguments passed to the build script when running the test are the defaults (i.e., those used when no arguments are specified).

### Avatar internal name test

Checks that `BlueArchiveCharacter.basic.avatarName` in `src/avatars/${character_name}/blue_archive_character.lua` matches `character_name`. Comparison is case-sensitive.

If the two names do not match, the test fails.

The test also fails in the following cases:

- The `src/avatars/` directory does not exist.
- `src/avatars/${character_name}/blue_archive_character.lua` does not exist.
- The `BlueArchiveCharacter.basic.avatarName` field is not defined.

### Avatar version test

Checks that `UpdateChecker.AVATAR_VERSION` in [`src/core/scripts/action_wheel/update_checker.lua`](../../src/core/scripts/action_wheel/update_checker.lua) matches the specified release tag name.

This test requires the target release tag name to be provided as an additional argument. If no tag name is provided, the test is skipped.

The test also fails in the following cases:

- [`src/core/scripts/action_wheel/update_checker.lua`](../../src/core/scripts/action_wheel/update_checker.lua) does not exist.
- The `UpdateChecker.AVATAR_VERSION` field is not defined.

## Environment setup and execution

The following steps show how to clone this repository and actually build an avatar.
Please note that running this build tool requires [uv](https://docs.astral.sh/uv/), which is a Python version management tool.
The command examples in the steps are based on Mac/Linux.

1. Clone (download) this repository and extract the files onto your device.
2. Set the working directory to `/src/scripts`.

   ```sh
   cd <path_to_repository_root_directory>/scripts/
   ```

3. Install Python and dependencies.
   You can install them simply by running the following command.

   ```sh
   uv sync
   ```

4. Run the test scripts.

   - For the build test:

     ```bash
     uv run python -m test.test_build
     ```

   - For the avatar internal name test:

     ```bash
     uv run python -m test.test_internal_avatar_name
     ```

   - For the avatar version test:

     ```bash
     uv run python -m test.test_avatar_version ${release_tag_name}
     ```

If you use [Visual Studio Code]((https://code.visualstudio.com)), you can also run tests from the Testing view on the left.\
(The avatar version test is expected to run at tag push time, so it may be skipped when run manually here.)

![Test tab](./docs/images/vscode_test_tab.jpg)
