# アバター作成の手順書

本ドキュメントでは、アバターの作成を行う一連の手順とTodoを記します。

新しいキャラクターの作成と、既存のキャラクターに対する新規衣装の作成手順を記します。

## アバターの作成前

アバターの作成前に行う作業の手順は次のとおりです。

1. Issueを作成する。
   - 新規キャラクターの作成は「新キャラクター」のテンプレートを、新規衣装の作成は「新衣装」のテンプレートでIssueを作成する。
   - テンプレート内のプレースホルダー（`${...}`）は適切な内容に置き換える。
2. アバター作成状況([`creation_status.json`](scripts/readme_generate/creation_status.json))を更新する。
   - 新規キャラクターの場合は`planned`の配列に以下を追加する。

     ```json
        {
            "character_name": {
                "first_name": {
                    "en": "${STUDENT_FIRST_NAME}",
                    "jp": "${生徒の名前}"
                    },
            "last_name": {
                    "en": "${STUDENT_LAST_NAME}",
                    "jp": "${生徒の名字}"
                }
            },
            "costume_name": null,
            "issue_number": ${手順1.で作成したIssue番号}
        }
     ```

   - 新規衣装の場合は`planned`の配列に以下を追加する。

     ```json
        {
            "character_name": {
                "first_name": {
                    "en": "${STUDENT_FIRST_NAME}",
                    "jp": "${生徒の名前}"
                    },
            "last_name": {
                    "en": "${STUDENT_LAST_NAME}",
                    "jp": "${生徒の名字}"
                }
            },
            "costume_name": {
                "en": "${COSTUME_NAME}",
                "jp": "${衣装名}"
            },
            "issue_number": ${手順1.で作成したIssue番号}
        }
     ```
