---@class ExSkill1TextObjectManager : SpawnObjectManager Exスキル1で使用するテキストオブジェクトのマネージャークラス
---@field public getObject fun(self: ExSkill1TextObjectManager, parentModel: ModelPart): ExSkill1TextObject テキストオブジェクトのインスタンスを生成して返す
---@field public spawn fun(self: ExSkill1TextObjectManager, parentModel: ModelPart) テキストオブジェクトを生成する

local ExSkill1TextObjectManager = {
    ---コンストラクタ
    ---@return ExSkill1TextObjectManager
    new = function ()
        ---@type ExSkill1TextObjectManager
        local instance = MiscUtils.instantiate(ExSkill1TextObjectManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_text_object"

        return instance
    end;

    ---テキストオブジェクトのインスタンスを生成して返す。
    ---@param parentModel ModelPart このオブジェクトをアタッチする親パーツ
    ---@return ExSkill1TextObject instance 生成したインスタンス
    getObject = function (_, parentModel)
        return ExSkill1TextObject.new(parentModel)
    end;

    ---テキストオブジェクトを生成する。
    ---@param self ExSkill1TextObjectManager
    ---@param parentModel ModelPart このオブジェクトをアタッチする親パーツ
    spawn = function (self, parentModel)
        SpawnObjectManager.spawn(self, parentModel)
    end;
}

return ExSkill1TextObjectManager
