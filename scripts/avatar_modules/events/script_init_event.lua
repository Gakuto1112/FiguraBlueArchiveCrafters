---@class ScriptInitEvent : AbstractEvent 全てのスクリプトの初期化が完了した後に1度だけ呼ばれるイベント
---@field public register fun(self: AbstractEvent, callback: fun(), name?: string) イベントにコールバック関数登録する
---@field public fire fun(self: AbstractEvent) 登録された全てのコールバック関数を呼ぶ

ScriptInitEvent = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return ScriptInitEvent
    new = function (parent)
        ---@type ScriptInitEvent
        local instance = Avatar.instantiate(ScriptInitEvent, AbstractEvent, parent)

        return instance
    end;

    ---登録された全てのコールバック関数を呼ぶ。
    ---@param self ScriptInitEvent
    fire = function (self, ...)
        for _, eventTable in pairs(self.registerTable) do
            for _, callback in ipairs(eventTable) do
                callback()
            end
        end
    end;
}