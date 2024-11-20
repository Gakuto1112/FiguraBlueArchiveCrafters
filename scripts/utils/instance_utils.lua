---@class InstanceUtils インスタンス化に関するユーティリティ関数群
InstanceUtils = {
    ---クラスをインスタンス化する。
    ---@param class table インスタンス化させる対象のクラス
    ---@param super table インスタンス化させる対象のクラスのスーパークラス
    ---@param ... any? クラスのインスタンス引数
    ---@return table class インスタンス化されたクラスのオブジェクト
    instantiate = function (class, super, ...)
        local instance = super and super.new(...) or {}
        setmetatable(instance, {__index = class})
        setmetatable(class, super)
    end
}

return InstanceUtils