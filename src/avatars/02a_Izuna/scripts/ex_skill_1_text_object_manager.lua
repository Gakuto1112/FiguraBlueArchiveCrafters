---@class ExSkillTextObjectManager : SpawnObjectManager Exスキルで使用するテキストオブジェクトのマネージャークラス
---@field package objects ExSkillTextObject[] インスタンスで制御するオブジェクト
local ExSkillTextObjectManager = {
    ---コンストラクタ
    ---@return ExSkillTextObjectManager
    new = function ()
        ---@type ExSkillTextObjectManager
		---@diagnostic disable-next-line: undefined-global
        local instance = MiscUtils.instantiate(ExSkillTextObjectManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_text_object"

        return instance
    end;

    ---テキストオブジェクトのインスタンスを生成して返す。
    ---@param pos Vector2 テキストオブジェクトオブジェクトを設置する座標
    ---@param text string オブジェクトに設定するテキスト
    ---@return ExSkillTextObject instance 生成したインスタンス
    getObject = function (self, pos, text)
        return ExSkillTextObject.new(self, pos, text)
    end;

    ---テキストオブジェクトを生成する。
    ---@param self ExSkillTextObjectManager
    ---@param pos Vector2 テキストオブジェクトオブジェクトを設置する座標
    ---@param text string オブジェクトに設定するテキスト
    spawn = function (self, pos, text)
        SpawnObjectManager.spawn(self, pos, text)
    end;

    ---スポーン中のテキストオブジェクトを全て黒くする。
    ---@param self ExSkillTextObjectManager
    ---@param isBlack boolean テキストオブジェクトを黒くするかどうか
    setBlack = function (self, isBlack)
        for _, object in ipairs(self.objects) do
            object.object:setText("§"..(isBlack and "0" or "d")..object.text)
        end
    end;
}

return ExSkillTextObjectManager
