---@class (exact) Character22a.ExSkill1SpriteManager : SpawnObjectManager Exスキル内で使用するスプライトのオブジェクトのマネージャークラス
---@field public objects Character22a.ExSkill1Sprite[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: Character22a.ExSkill1SpriteManager, target: ModelPart, pos: Vector3): Character22a.ExSkill1Sprite Exスキルフレームのパーティクルのインスタンスを生成して返す
---@field public spawn fun(self: Character22a.ExSkill1SpriteManager, target: ModelPart, pos: Vector3) Exスキルフレームのパーティクルをスポーンさせる
local ExSkill1SpriteManager = {
    ---コンストラクタ
    ---@return Character22a.ExSkill1SpriteManager
    new = function ()
        ---@type Character22a.ExSkill1SpriteManager
        local instance = MiscUtils.instantiate(Character22a_ExSkill1SpriteManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_sprite"

        return instance
    end;

    ---Exスキルフレームのパーティクルのインスタンスを生成して返す。
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@return Character22a.ExSkill1Sprite instance 生成したインスタンス
    getObject = function (_, target, pos)
        return Character22a_ExSkill1Sprite.new(target, pos)
    end;

    ---Exスキルフレームのパーティクルをスポーンさせる。
    ---@param self Character22a.ExSkill1SpriteManager
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    spawn = function (self, target, pos)
        SpawnObjectManager.spawn(self, target, pos)
    end;
}

return ExSkill1SpriteManager
