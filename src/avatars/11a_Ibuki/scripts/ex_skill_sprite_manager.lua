---@class (exact) Character11a.ExSkillSpriteManager : SpawnObjectManager Exスキル内で使用するスプライトのオブジェクトのマネージャークラス
---@field public objects Character11a.ExSkillSprite[] インスタンスで制御するオブジェクト
Character11a_ExSkillSpriteManager = {
    ---コンストラクタ
    ---@return Character11a.ExSkillSpriteManager
    new = function ()
        ---@type Character11a.ExSkillSpriteManager
        local instance = MiscUtils.instantiate(Character11a_ExSkillSpriteManager, SpawnObjectManager)

        instance.managerName = "ex_skill_sprite"

        return instance
    end;

    ---Exスキルフレームのパーティクルのインスタンスを生成して返す。
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param index integer テクスチャの種類を決めるインデックス番号
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param velocity Vector3 オブジェクトの移動速度
    ---@param rotVelocity integer オブジェクトの角速度
    ---@param size number スプライトの大きさ
    ---@param scaleTracker? ModelPart スプライトの大きさの参照元のモデルパーツ
    ---@param lifetime integer このインスタンスを破棄するまでの時間
    ---@param shouldSeeCamera boolean カメラを見続けるべきかどうか
    ---@param speedFactor number 速度の変化係数
    ---@return Character11a.ExSkillSprite instance 生成したインスタンス
    getObject = function (_, target, index, pos, velocity, rotVelocity, size, scaleTracker, lifetime, shouldSeeCamera, speedFactor)
        return Character11a_ExSkillSprite.new( target, index, pos, velocity, rotVelocity, size, scaleTracker, lifetime, shouldSeeCamera, speedFactor)
    end;

    ---Exスキルフレームのパーティクルをスポーンさせる。
    ---@param self Character11a.ExSkillSpriteManager
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param index integer テクスチャの種類を決めるインデックス番号
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param velocity Vector3 オブジェクトの移動速度
    ---@param rotVelocity integer オブジェクトの角速度
    ---@param size number スプライトの大きさ
    ---@param scaleTracker? ModelPart スプライトの大きさの参照元のモデルパーツ
    ---@param lifetime integer このインスタンスを破棄するまでの時間
    ---@param shouldSeeCamera boolean カメラを見続けるべきかどうか
    ---@param speedFactor number 速度の変化係数
    spawn = function (self, target, index, pos, velocity, rotVelocity, size, scaleTracker, lifetime, shouldSeeCamera, speedFactor)
        SpawnObjectManager.spawn(self, target, index, pos, velocity, rotVelocity, size, scaleTracker, lifetime, shouldSeeCamera, speedFactor)
    end;
}

return Character11a_ExSkillSpriteManager
