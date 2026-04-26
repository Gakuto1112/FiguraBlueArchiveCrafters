---@class ExSkill1TextObjectManager : SpawnObjectManager Exスキル1で使用するテキストオブジェクトのマネージャークラス
local ExSkill1TextObjectManager = {
    ---コンストラクタ
    ---@return ExSkill1TextObjectManager
    new = function ()
        ---@type ExSkill1TextObjectManager
        ---@diagnostic disable-next-line: undefined-global
        local instance = MiscUtils.instantiate(ExSkill1TextObjectManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_text_object"

        return instance
    end;

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_ex_skill_1_text_object")
    end;

    ---テキストオブジェクトのインスタンスを生成して返す。
    ---@param text string オブジェクトに設定するテキスト
    ---@return ExSkill1TextObject instance 生成したインスタンス
    getObject = function (_, text)
        ---@diagnostic disable-next-line: undefined-global
        return ExSkill1TextObject.new(text)
    end;

    ---テキストオブジェクトを生成する。
    ---@param self ExSkill1TextObjectManager
    ---@param text string オブジェクトに設定するテキスト
    spawn = function (self, text)
        SpawnObjectManager.spawn(self, text)
    end;
}

return ExSkill1TextObjectManager
