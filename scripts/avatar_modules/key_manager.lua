---@class (exact) KeyManager : AvatarModule アバターのキー割り当てを管理するクラス。ここで管理する割り当ては設定で変更された場合はそれが保存される。
---@field public keyMappings {[string]: Keybind} キーの割り当てのテーブル
---@field public register fun(self: KeyManager, assignName: string, keyName: Minecraft.keyCode): Keybind キー割り当てを登録する

KeyManager = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return KeyManager
    new = function (parent)
        ---@type KeyManager
        local instance = Avatar.instantiate(KeyManager, AvatarModule, parent)

        instance.keyMappings = {}

        return instance
    end;

    ---初期化関数
    ---@param self KeyManager
    init = function (self)
        AvatarModule.init(self)

        if host:isHost() then
            events.TICK:register(function ()
                for key, value in pairs(self.keyMappings) do
                    if not value:isDefault() then
                        local newKey = value:getKey()
                        self.parent.config:saveConfig("keybind."..key, newKey)
                        value:setKey(newKey)
                    end
                end
            end)
        end
    end;

    ---キー割り当てを登録する。
    ---@param self KeyManager
    ---@param assignName string 割り当ての名前
    ---@param keyName Minecraft.keyCode 割当先のキー
    ---@return Keybind assignedKey キーマネージャーによって登録がされたキーバインド
    register = function (self, assignName, keyName)
        self.keyMappings[assignName] = keybinds:newKeybind(self.parent.locale:getLocale("key_name."..assignName), self.parent.config:loadConfig("keybind."..assignName, keyName))
        return self.keyMappings[assignName]
    end;
}