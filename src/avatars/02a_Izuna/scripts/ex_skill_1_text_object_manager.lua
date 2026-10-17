---@class Character02a.ExSkillTextObjectManager : SpawnObjectManager Exスキルで使用するテキストオブジェクトのマネージャークラス
---@field package objects Character02a.ExSkillTextObject[] インスタンスで制御するオブジェクト
local ExSkillTextObjectManager = {
    ---コンストラクタ
    ---@return Character02a.ExSkillTextObjectManager
    new = function ()
        ---@type Character02a.ExSkillTextObjectManager
        local instance = MiscUtils.instantiate(Character02a_ExSkillTextObjectManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_text_object"

        return instance
    end;

    ---テキストオブジェクトのインスタンスを生成して返す。
    ---@param pos Vector2 テキストオブジェクトオブジェクトを設置する座標
    ---@param text string オブジェクトに設定するテキスト
    ---@return Character02a.ExSkillTextObject instance 生成したインスタンス
    getObject = function (self, pos, text)
        return Character02a_ExSkillTextObject.new(self, pos, text)
    end;

    ---テキストオブジェクトを生成する。
    ---@param self Character02a.ExSkillTextObjectManager
    ---@param pos Vector2 テキストオブジェクトオブジェクトを設置する座標
    ---@param text string オブジェクトに設定するテキスト
    spawn = function (self, pos, text)
        SpawnObjectManager.spawn(self, pos, text)
    end;

    ---スポーン中のテキストオブジェクトを全て黒くする。
    ---@param self Character02a.ExSkillTextObjectManager
    ---@param isBlack boolean テキストオブジェクトを黒くするかどうか
    setBlack = function (self, isBlack)
        for _, object in ipairs(self.objects) do
            object.object:setText("§"..(isBlack and "0" or "d")..object.text)
        end
    end;
}

return ExSkillTextObjectManager
