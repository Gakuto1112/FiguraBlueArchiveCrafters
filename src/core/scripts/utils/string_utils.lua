---@class (exact) StringUtils 文字列操作に関するユーティリティ関数群
local StringUtils = {
    ---入力された文字列を小文字に置き換える。
    ---トルコ語の「ı」を一般的な「i」に置き換える。
    ---@param str string 小文字に変換する対象の文字列
    ---@return string loweredString 小文字に変換された文字列
    lower = function (str)
        local result = str:lower()
        result = result:gsub("ı", "i")
        return result
    end;

    ---入力された文字列を大文字に置き換える。
    ---トルコ語の「İ」を一般的な「I」に置き換える。
    ---@param str string 大文字に変換する対象の文字列
    ---@return string loweredString 大文字に変換された文字列
    upper = function (str)
        local result = str:upper()
        result = result:gsub("İ", "I")
        return result
    end;

    ---2つのバージョン文字列を比較し、新しい方を返す。
    ---@param version1 string 比較するバージョン文字列1
    ---@param version2 string 比較するバージョン文字列2
    ---@return string|nil newerVersion 新しい方のバージョン文字列。比較不可能だった場合はnilを返す。
    compareVersions = function (version1, version2)
        local major1, minor1, patch1 = version1:match("^v?(%d+)%.(%d+)%.?(%d*)")
        local major2, minor2, patch2 = version2:match("^v?(%d+)%.(%d+)%.?(%d*)")
        major1 = tonumber(major1)
        minor1 = tonumber(minor1)
        patch1 = patch1 ~= nil and tonumber(patch1) or 0
        major2 = tonumber(major2)
        minor2 = tonumber(minor2)
        patch2 = patch2 ~= nil and tonumber(patch2) or 0
        if major1 ~= nil and minor1 ~= nil and patch1 ~= nil and major2 ~= nil and minor2 ~= nil and patch2 ~= nil then
            return (major1 > major2 or (major1 == major2 and minor1 > minor2) or (major1 == major2 and minor1 == minor2 and patch1 > patch2)) and version1 or version2
        end
    end;
}

return StringUtils
