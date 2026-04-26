---@alias ExSkill1SpriteManager.SpriteType
---| "STAR" # 星
---| "MINISTAR" # 小さい星（アニメーション付き）
---| "MINISTAR2" # 斜めの小さい星（アニメーション付き）

---@class (exact) ExSkill1SpriteManager : SpawnObjectManager Exスキル2内で使用するスプライトのオブジェクトのマネージャークラス
---@field public objects ExSkill1Sprite[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: ExSkill1SpriteManager, type: ExSkill1SpriteManager.SpriteType, pos: Vector2, velocity: Vector2): ExSkill1Sprite Exスキル2のスプライトのインスタンスを生成して返す
---@field public spawn fun(self: ExSkill1SpriteManager, type: ExSkill1SpriteManager.SpriteType, pos:Vector2, velocity: Vector2) Exスキル2のスプライトをスポーンさせる
local ExSkill1SpriteManager = {
    ---コンストラクタ
    ---@return ExSkill1SpriteManager
    new = function ()
        ---@type ExSkill1SpriteManager
        local instance = MiscUtils.instantiate(ExSkill1SpriteManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_sprite"

        return instance
    end;

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_ex_skill_1_sprite", "Gui")
    end;

    ---Exスキル2のスプライトのインスタンスを生成して返す。
    ---@param type ExSkill1SpriteManager.SpriteType スプライトの種類
    ---@param pos Vector2 スプライトの初期位置
    ---@param velocity Vector2 スプライトの移動速度
    ---@return ExSkill1Sprite instance 生成したインスタンス
    getObject = function (_, type, pos, velocity)
        return ExSkill1Sprite.new(type, pos, velocity)
    end;

    ---Exスキル2のスプライトのパーティクルをスポーンさせる。
    ---@param self ExSkill1SpriteManager
    ---@param type ExSkill1SpriteManager.SpriteType スプライトの種類
    ---@param pos Vector2 スプライトの初期位置
    ---@param velocity Vector2 スプライトの移動速度
    spawn = function (self, type, pos, velocity)
        SpawnObjectManager.spawn(self, type, pos, velocity)
    end;
}

return ExSkill1SpriteManager
