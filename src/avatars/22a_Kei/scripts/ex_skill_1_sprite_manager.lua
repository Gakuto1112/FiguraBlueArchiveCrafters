---@class (exact) ExSkill1SpriteManager : SpawnObjectManager Exスキル内で使用するスプライトのオブジェクトのマネージャークラス
---@field public objects ExSkillSprite[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: ExSkill1SpriteManager, target: ModelPart, pos: Vector3): ExSkill1Sprite Exスキルフレームのパーティクルのインスタンスを生成して返す
---@field public spawn fun(self: ExSkill1SpriteManager, target: ModelPart, pos: Vector3) Exスキルフレームのパーティクルをスポーンさせる
local ExSkill1SpriteManager = {
    ---コンストラクタ
    ---@return ExSkill1SpriteManager
    new = function ()
        ---@type ExSkill1SpriteManager
        local instance = MiscUtils.instantiate(ExSkill1SpriteManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_sprite"

        return instance
    end;

    ---Exスキルフレームのパーティクルのインスタンスを生成して返す。
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@return ExSkillSprite instance 生成したインスタンス
    getObject = function (_, target, pos)
        return ExSkill1Sprite.new(target, pos)
    end;

    ---Exスキルフレームのパーティクルをスポーンさせる。
    ---@param self ExSkill1SpriteManager
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    spawn = function (self, target, pos)
        SpawnObjectManager.spawn(self, target, pos)
    end;
}

return ExSkill1SpriteManager
