Language: 　**English**　|　[日本語](./README_jp.md)

# README Generation Tool

This tool creates the Markdown README document for this repository (Figura Blue Archive Crafters, FBAC) and the README text files to be included in the distribution data from templates.

## Template Files

The files that serve as templates for the README are located in the "[templates/](./templates/)" directory.
"en" is the English template, and "jp" is the Japanese template.
Also, `.md` is the Markdown file for the repository's README, and `.txt` is the text file for the distribution data.

### Anchor Tags in Template Markdown

The template Markdown files ("[en.md](./templates/en.md)" and "[jp.md](./templates/jp.md)") contain anchor tags written in the Markdown comment format (`<!-- -->`).
These anchor tags are used as markers in the README generation tool.

Anchor tags are written in the following format:

```md
<!-- ${AnchorTagName} --->
```

It is assumed that the anchor tag is placed alone on its line.
If there is text on the same line as the anchor tag, that text may be ignored.

Below is a list of anchor tags and their roles:

| Anchor Tag Name | Description |
| --- | --- |
| DESCRIPTION_START | The start tag for the repository description. <br> Used as a pair with `DESCRIPTION_END`. This block is used when creating the README text file. |
| DESCRIPTION_END | The end tag for the repository description. <br> Used as a pair with `DESCRIPTION_START`. |
| USAGE_START | The start tag for the avatar usage instructions. <br> Used as a pair with `USAGE_END`. This block is used when creating the README text file. |
| USAGE_END | The end tag for the avatar usage instructions. <br> Used as a pair with `USAGE_START`. |
| NOTES_START | The start tag for the avatar notes/precautions. <br> Used as a pair with `NOTES_END`. This block is used when creating the README text file. |
| NOTES_END | The end tag for the avatar notes/precautions. <br> Used as a pair with `NOTES_START`. |
| CREATION_STATUS_DONE | The line with this tag is replaced with the "list of completed characters". |
| CREATION_STATUS_IN_PROGRESS | The line with this tag is replaced with the "list of currently in-progress characters". |
| CREATION_STATUS_PLANNED | The line with this tag is replaced with the "list of planned characters". |
| CREATION_STATUS_REQUESTED | The line with this tag is replaced with the "list of requested characters". |

### Anchor Tags in Template Text

The template text files ("[en.txt](./templates/en.txt)" and "[jp.txt](./templates/jp.txt)") contain anchor tags written in the format `${AnchorName}`.
These anchor tags are used as markers in the README generation tool.

Below is a list of anchor tags and their roles:

| Anchor Tag Name | Description |
| --- | --- |
| TAG_NAME | An anchor tag that will be replaced with the tag name input from the arguments (e.g., `v3.0.0`). |
| RELEASE_DATE | An anchor tag that will be replaced with the date input from the arguments (the version release date). |
| DESCRIPTION | The line with this tag will be replaced by the repository description (the part from `<!-- DESCRIPTION_START --->` to `<!-- DESCRIPTION_END --->` in the template Markdown file). |
| USAGE | The line with this tag will be replaced by the avatar usage instructions (the part from `<!-- USAGE_START --->` to `<!-- USAGE_END --->` in the template Markdown file). |
| NOTES | The line with this tag will be replaced by the avatar notes/precautions (the part from `<!-- NOTES_START --->` to `<!-- NOTES_END --->` in the template Markdown file). |

When replacing tags with portions of the template Markdown file, Markdown syntax (such as bold or URLs) is removed during the replacement process, and it is inserted as plain text.

## Creation Status

The creation status replacement content included in the template Markdown files is generated based on "[creation_status.json](./creation_status.json)".
The structure of this json file is as follows:

```
📃 creation_status.json
├ 📁 done[]
│ └ 📁 character_entry{}
├ 📁 in_progress[]
│ └ 📁 character_entry{}
├ 📁 planned[]
│ └ 📁 character_entry{}
└ 📁 requested[]
  └ 📁 character_entry{}
```

(🔢: Number, 🔠: String, ▶️: Boolean, 📁[]: Array, 📁{}: Dictionary, (): Optional field)

Entries for completed characters are placed in `done`, characters currently in progress in `in_progress`, planned characters in `planned`, and requested characters in `requested`, each formatted as an array.
The order of the output Markdown list items is identical to the order in these arrays. Therefore, entries for completed characters should be arranged in the order they were created, and entries for planned or requested characters should be arranged in order of priority.

The structure of each character entry is as follows:

```
📁 character_entry{}
├ 📁 character_name{}
│ ├ 📁 first_name{}
│ │ ├ 🔠 en
│ │ └ 🔠 jp
│ └ 📁 last_name{}
│   ├ 🔠 en
│   └ 🔠 jp
├ 📁 (costume_name{})
| ├ 🔠 en
│ └ 🔠 jp
└ 🔢 (issue_number)
```

(🔢: Number, 🔠: String, ▶️: Boolean, 📁[]: Array, 📁{}: Dictionary, (): Optional field)

| Item | Type | Description |
| --- | --- | --- |
| character_name | Object | Character's full name |
| character_name.first_name | Object | Character's given name |
| character_name.first_name.en | String | English name of the character's given name |
| character_name.first_name.jp | String | Japanese name of the character's given name |
| character_name.last_name | Object | Character's surname |
| character_name.last_name.en | String | English name of the character's surname |
| character_name.last_name.jp | String | Japanese name of the character's surname |
| costume_name | Object or null | Character's costume name <br> Set to `null` for the default costume. |
| costume_name.en | String | English name of the character's costume |
| costume_name.jp | String | Japanese name of the character's costume |
| issue_number | Number or null | The issue number related to this entry <br> Set to `null` if none. |

If there is an array with 0 entries, a text message stating that fact will be inserted instead of a Markdown list.

## Execution Steps

Running this generation tool requires [uv](https://docs.astral.sh/uv/), which is a Python version management tool.
Also, the command examples in the steps are based on Mac/Linux.

1. Set the working directory to "/src/readme_scripts".

   ```sh
   cd <path_to_repository_root_directory>/readme_scripts/
   ```

2. Install Python and dependencies.
   You can install them simply by running the following command.

   ```sh
   uv sync
   ```

3. Execute the build scripts.
   When generating a text file, you need to pass the tag name and release date as arguments.
   With the default paths, the generated documents will be output to `../`.

   ```sh
   uv run generate_readme_md.py # For Markdown file generation
   uv run generate_readme_txt.py ${TAG_NAME} ${RELEASE_DATE} # For text file generation
   ```

## Arguments

This generation tool provides (optional) arguments.
Required arguments are listed in the order they must be specified.

### generate_readme_md.py

| Argument Name | Additional Argument | Description | Is Required? |
| --- | --- | --- | --- |
| -h, --help | None | Outputs the build tool's description. | No |
| -t, --template-dir | Path to the template directory | Specifies the directory to load templates from. Defaults to `./templates/` if not specified. | No |
| -o, --dist-dir | Path to the output directory | Specifies the output destination directory. Defaults to `../` if not specified. | No |
| -l, --colored | None | Adds color to standard output. Turn this off if control characters like log outputs are output as-is. | No |

### generate_readme_txt.py

| Argument Name | Additional Argument | Description | Is Required? |
| --- | --- | --- | --- |
| tag_name | Release tag name <br> (e.g., `v3.0.0`) | Inputs the release tag name. | Yes |
| release date | Release date <br> Pass it in a format like `2026-04-26T15:00:00Z`. | Inputs the release date. | Yes |
| -h, --help | None | Outputs the build tool's description. | No |
| -t, --template-dir | Path to the template directory | Specifies the directory to load templates from. Defaults to `./templates/` if not specified. | No |
| -o, --dist-dir | Path to the output directory | Specifies the output destination directory. Defaults to `../` if not specified. | No |
| -l, --colored | None | Adds color to standard output. Turn this off if control characters like log outputs are output as-is. | No |
