---@class (exact) ExSkillSpriteManager : SpawnObjectManager Exスキル内で使用するスプライトのオブジェクトのマネージャークラス
---@field public objects ExSkillSprite[] インスタンスで制御するオブジェクト
local ExSkillSpriteManager = {
    ---コンストラクタ
    ---@return ExSkillSpriteManager
    new = function ()
        ---@type ExSkillSpriteManager
        local instance = MiscUtils.instantiate(ExSkillSpriteManager, SpawnObjectManager)

        instance.managerName = "ex_skill_sprite"

        return instance
    end;

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_ex_skill_sprites", "World")
    end;

    ---Exスキルフレームのパーティクルのインスタンスを生成して返す。
    ---@param objectModel ModelPart スプライトとしてコピーする元のモデルパーツ
    ---@param targetParent ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param size number スプライトの大きさ
    ---@param color? Vector3 スプライトの色
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param velocity Vector3 オブジェクトの移動速度
    ---@param rot Vector3 オブジェクトの初期角度
    ---@param rotVelocity Vector3 オブジェクトの角速度
    ---@param gravity? number オブジェクトにかかる重力（1 = 標準重力）
    ---@param scaleTracker? ModelPart スプライトの大きさの参照元のモデルパーツ
    ---@param lifetime integer このインスタンスを破棄するまでの時間
    ---@param shouldSeeCamera boolean カメラを見続けるべきかどうか
    ---@return ExSkillSprite
    getObject = function (_, objectModel, targetParent, size, color, pos, velocity, rot, rotVelocity, gravity, scaleTracker, lifetime, shouldSeeCamera)
        return ExSkillSprite.new(objectModel, targetParent, size, color, pos, velocity, rot, rotVelocity, gravity, scaleTracker, lifetime, shouldSeeCamera)
    end;

    ---Exスキルフレームのパーティクルをスポーンさせる。
    ---@param self ExSkillSpriteManager
    ---@param objectModel ModelPart スプライトとしてコピーする元のモデルパーツ
    ---@param targetParent ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param size number スプライトの大きさ
    ---@param color? Vector3 スプライトの色
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param velocity Vector3 オブジェクトの移動速度
    ---@param rot Vector3 オブジェクトの初期角度
    ---@param rotVelocity Vector3 オブジェクトの角速度
    ---@param gravity? number オブジェクトにかかる重力（1 = 標準重力）
    ---@param scaleTracker? ModelPart スプライトの大きさの参照元のモデルパーツ
    ---@param lifetime integer このインスタンスを破棄するまでの時間
    ---@param shouldSeeCamera boolean カメラを見続けるべきかどうか
    spawn = function (self, objectModel, targetParent, size, color, pos, velocity, rot, rotVelocity, gravity, scaleTracker, lifetime, shouldSeeCamera)
        SpawnObjectManager.spawn(self, objectModel, targetParent, size, color, pos, velocity, rot, rotVelocity, gravity, scaleTracker, lifetime, shouldSeeCamera)
    end
}

return ExSkillSpriteManager
