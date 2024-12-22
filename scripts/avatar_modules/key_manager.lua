---@class (exact) KeyManager : AvatarModule アバターのキー割り当てを管理するクラス。ここで管理する割り当ては設定で変更された場合はそれが保存される。
---@field public keyMappings {[string]: KeyMappingObject} キーの割り当てのテーブル
---@field public register fun(self: KeyManager, assignName: string, keyName: Minecraft.keyCode): Keybind キー割り当てを登録する

---@class (exact) KeyMappingObject キーの割り当てオブジェクト
---@field public keybind Keybind キーバインドのオブジェクト
---@field package keyNamePrev Minecraft.keyCode 前ティックの割り当てキーの名前

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
                if not client:isPaused() then
                    for keyName, keyObject in pairs(self.keyMappings) do
                        local newKey = keyObject.keybind:getKey()
                        if keyObject.keybind:getKey() ~= keyObject.keyNamePrev then
                            self.parent.config:saveConfig("PRIVATE", "keybind."..keyName, newKey)
                            keyObject.keybind:setKey(newKey)
                            keyObject.keyNamePrev = newKey
                        end
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
        if self.keyMappings[assignName] == nil then
            ---@diagnostic disable-next-line: missing-fields
            self.keyMappings[assignName] = {}
        end
        self.keyMappings[assignName].keybind = keybinds:newKeybind(self.parent.locale:getLocale("key_name."..assignName), keyName)
        local loadedKey = self.parent.config:loadConfig("PRIVATE", "keybind."..assignName, keyName)
        if loadedKey ~= keyName then
            self.keyMappings[assignName].keybind:setKey(loadedKey)
        end
        self.keyMappings[assignName].keyNamePrev = self.keyMappings[assignName].keybind:getKey()
        return self.keyMappings[assignName].keybind
    end;
}