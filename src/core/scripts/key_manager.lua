---@class (exact) KeyMappingObject キーの割り当てオブジェクト
---@field public keybind Keybind キーバインドのオブジェクト
---@field package keyNamePrev Minecraft.keyCode 前ティックの割り当てキーの名前

---@class (exact) KeyManager アバターのキー割り当てを管理するクラス。ここで管理する割り当ては設定で変更された場合はそれが保存される。
---@field public keyMappings {[string]: KeyMappingObject} キーの割り当てのテーブル
local KeyManager = {
	keyMappings = {};

    ---初期化関数
    ---@param self KeyManager
    init = function (self)
        if host:isHost() then
            events.TICK:register(function ()
                if not client:isPaused() then
                    for keyName, keyObject in pairs(self.keyMappings) do
                        local newKey = keyObject.keybind:getKey()
                        if keyObject.keybind:getKey() ~= keyObject.keyNamePrev then
                            Config:saveConfig("PRIVATE", "key_manager.key_assignment." .. keyName, newKey)
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
    ---@param id string キーアサインのID
    ---@param displayName string キー設定に表示する名前
    ---@param keyName Minecraft.keyCode 割当先のキー
    ---@return Keybind assignedKey キーマネージャーによって登録がされたキーバインド
    register = function (self, id, displayName, keyName)
        if self.keyMappings[id] == nil then
            ---@diagnostic disable-next-line: missing-fields
            self.keyMappings[id] = {}
        end
        self.keyMappings[id].keybind = keybinds:newKeybind(displayName, keyName)
        local loadedKey = Config:loadConfig("PRIVATE", "key_manager.key_assignment." .. displayName, keyName)
        if loadedKey ~= keyName then
            self.keyMappings[id].keybind:setKey(loadedKey)
        end
        self.keyMappings[id].keyNamePrev = self.keyMappings[id].keybind:getKey()
        return self.keyMappings[id].keybind
    end;
}

return KeyManager
