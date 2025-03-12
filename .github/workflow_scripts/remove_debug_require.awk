BEGIN {
    debug_require_line_count = -1
}

{
    # デバッグスクリプトのアノテーションを削除
    if($0 == "---@field public debugUtils DebugUtils") next;

    # デバッグスクリプトのrequire()の開始を検出
    if($0 ~ /^[\s\t]*require\("scripts\.avatar_modules\.utils\.debug_utils"\)$/) debug_require_line_count = 0;

    # デバッグスクリプトのrequire()を削除
    if(debug_require_line_count >= 0 && debug_require_line_count <= 3) {
        debug_require_line_count++;
        next;
    }

    print;
}
