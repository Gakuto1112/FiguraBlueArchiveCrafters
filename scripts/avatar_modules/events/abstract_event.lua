---@class AbstractEvent : AvatarModule
---@field public registerTable {[string]: fun()[]} 登録されたコールバック関数を管理するテーブル
---@field public register fun(self: AbstractEvent, callback: fun(...: any), name?: string) イベントにコールバック関数登録する
---@field public remove fun(self: AbstractEvent, name: string) 指定した名前のコールバック関数を1つ削除する
---@field public getRegisteredCount fun(self: AbstractEvent, name: string): integer 指定した名前で登録されているコールバック関数の数を返す
---@field public fire fun(self: AbstractEvent, ...: any) 登録された全てのコールバック関数を呼ぶ

AbstractEvent = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return AbstractEvent
    new = function (parent)
        ---@type AbstractEvent
        local instance = Avatar.instantiate(AbstractEvent, AvatarModule, parent)

        instance.registerTable = {}

        return instance
    end;

    ---イベントにコールバック関数登録する。
    ---@param self AbstractEvent
    ---@param callback fun(...: any) 登録するコールバック関数
    ---@param name? string コールバック関数の名前
    register = function (self, callback, name)
        local callbackName = name ~= nil and name or client.intUUIDToString(client.generateUUID())
        if self.registerTable[callbackName] ~= nil then
            table.insert(self.registerTable[callbackName], callback)
        else
            local callbackTable = {}
            table.insert(callbackTable, callback)
            self.registerTable[callbackName] = callbackTable
        end
    end;

    ---指定した名前のコールバック関数を1つ削除する。
    ---@param self AbstractEvent
    ---@param name string コールバック関数の名前
    remove = function (self, name)
        if self.registerTable[name] ~= nil then
            table.remove(self.registerTable[name])
            if #self.registerTable[name] == 0 then
                self.registerTable[name] = nil
            end
        end
    end;

    ---指定した名前で登録されているコールバック関数の数を返す。
    ---@param self AbstractEvent
    ---@param name string コールバック関数の名前
    ---@return integer registeredCount 登録されていたコールバック関数の数
    getRegisteredCount = function (self, name)
        if self.registerTable[name] ~= nil then
            return #self.registerTable[name]
        else
            return 0
        end
    end;

    ---登録された全てのコールバック関数を呼ぶ。
    ---@param self AbstractEvent
    ---@param ... any callbackArgs コールバック引数
    fire = function (self, ...)
        for _, eventTable in pairs(self.registerTable) do
            for _, callback in ipairs(eventTable) do
                ---@diagnostic disable-next-line: redundant-parameter
                callback(...)
            end
        end
    end;
}