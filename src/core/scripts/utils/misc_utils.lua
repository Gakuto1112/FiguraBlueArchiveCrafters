---@class (exact) MiscUtils その他のユーティリティ関数群
local MiscUtils = {
	---クラスをインスタンス化する。
	---@generic S
	---@generic C
	---@param class `C` インスタンス化するクラス
	---@param super? `S` インスタンス化するクラスのスーパークラス
	---@param ... any クラスのインスタンス時に渡される引数
	---@return C instance インスタンス化されたクラスのオブジェクト
    instantiate = function (class, super, ...)
        local instance = super and super.new(...) or {}
        setmetatable(instance, {__index = class})
        setmetatable(class, {__index = super})
		return instance
    end;
}

return MiscUtils
