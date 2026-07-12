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

    ---指定されたバージョン文字列が、比較対象のバージョン文字列より新しいものか比較する。
    ---@param targetVersion string 比較対象のバージョン文字列
    ---@param comparedVersion string 比較するバージョン文字列
    ---@return boolean isNewerVersion 指定されたバージョン文字列が比較対象のバージョン文字列より新しいかどうか。
    ---@return boolean isIncomparable 指定されたバージョン文字列が比較不可能だったかどうか。
    isNewerVersion = function (targetVersion, comparedVersion)
        local major1, minor1, patch1 = targetVersion:match("^v?(%d+)%.(%d+)%.?(%d*)")
        local major2, minor2, patch2 = comparedVersion:match("^v?(%d+)%.(%d+)%.?(%d*)")
        major1 = tonumber(major1)
        minor1 = tonumber(minor1)
        patch1 = patch1 ~= nil and tonumber(patch1) or 0
        major2 = tonumber(major2)
        minor2 = tonumber(minor2)
        patch2 = patch2 ~= nil and tonumber(patch2) or 0
        if major1 == nil or minor1 == nil or patch1 == nil or major2 == nil or minor2 == nil or patch2 == nil then
            return false, true
        end
        return major1 > major2 or (major1 == major2 and minor1 > minor2) or (major1 == major2 and minor1 == minor2 and patch1 > patch2), false
    end;

    ---指定されたバージョン文字列が、比較対象のバージョン文字列以上かどうかを比較する。
    ---@param targetVersion string 比較対象のバージョン文字列
    ---@param comparedVersion string 比較するバージョン文字列
    ---@return boolean isNewerOrEqualVersion 指定されたバージョン文字列が比較対象のバージョン文字列以上かどうかを返す。比較不可能だった場合は常にfalseを返す。
    ---@return boolean isIncomparable 指定されたバージョン文字列が比較不可能だったかどうか。
    isNewerOrEqualVersion = function (targetVersion, comparedVersion)
        if targetVersion == comparedVersion then
            return true, false
        end
        return StringUtils.isNewerVersion(targetVersion, comparedVersion)
    end;
}

return StringUtils
