---@class (exact) StringUtils : AvatarModule 文字列操作に関するユーティリティ関数群
---@field public lower fun(str: string): string 入力された文字列を小文字に置き換える。トルコ語の「ı」を一般的な「i」に置き換える。
---@field public upper fun(str: string): string 入力された文字列を大文字に置き換える。トルコ語の「İ」を一般的な「I」に置き換える。

StringUtils = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return StringUtils
    new = function (parent)
        ---@type StringUtils
        local instance = Avatar.instantiate(StringUtils, AvatarModule, parent)

        return instance
    end;

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
}