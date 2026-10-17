---@alias Character14c.ExSkill1ItemObjectManager.SpriteType
---| "ITEM" # アイテムテクスチャ
---| "CROSS" # 十字
---| "DOT" # ドット

---@class Character14c.ExSkill1ItemObjectManager : SpawnObjectManager Exスキル1で使用するアイテムオブジェクトのマネージャークラス
---@field public getObject fun(self: Character14c.ExSkill1ItemObjectManager, type: Character14c.ExSkill1ItemObjectManager.SpriteType, launchRot?: number): Character14c.ExSkill1ItemObject アイテムオブジェクトのインスタンスを生成して返す
---@field public spawn fun(self: Character14c.ExSkill1ItemObjectManager, type: Character14c.ExSkill1ItemObjectManager.SpriteType, launchRot?: number) アイテムオブジェクトを生成する
local ExSkill1ItemObjectManager = {
    ---コンストラクタ
    ---@return Character14c.ExSkill1ItemObjectManager
    new = function ()
        ---@type Character14c.ExSkill1ItemObjectManager
        local instance = MiscUtils.instantiate(Character14c_ExSkill1ItemObjectManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_item_object"

        return instance
    end;

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_ex_skill_1_item_object", "World")
    end;

    ---アイテムオブジェクトのインスタンスを生成して返す。
    ---@param type Character14c.ExSkill1ItemObjectManager.SpriteType 表示するスプライトの種類
    ---@param launchRot? number スプライトの射出角度。スプライトタイプが"ITEM"以外は無視される。
    ---@return Character14c.ExSkill1ItemObject instance 生成したインスタンス
    getObject = function (_, type, launchRot)
        return Character14c_ExSkill1ItemObject.new(type, launchRot)
    end;

    ---アイテムオブジェクトを生成する。
    ---@param self Character14c.ExSkill1ItemObjectManager
    ---@param type Character14c.ExSkill1ItemObjectManager.SpriteType 表示するスプライトの種類
    ---@param launchRot? number スプライトの射出角度。スプライトタイプが"ITEM"以外は無視される。
    spawn = function (self, type, launchRot)
        SpawnObjectManager.spawn(self, type, launchRot)
    end;
}

return ExSkill1ItemObjectManager