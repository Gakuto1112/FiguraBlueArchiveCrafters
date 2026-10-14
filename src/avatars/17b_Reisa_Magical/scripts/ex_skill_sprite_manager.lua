---@class (exact) Character17b.ExSkillSpriteManager : SpawnObjectManager Exスキル内で使用するスプライトのオブジェクトのマネージャークラス
---@field public objects Character17b.ExSkillSprite[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: Character17b.ExSkillSpriteManager, target: ModelPart, index: Vector2, color?: Vector3, pos: Vector3, velocity: Vector3, rotVelocity: integer, size: number, scaleTracker?: ModelPart, lifetime: integer, shouldSeeCamera: boolean, speedFactor: number): Character17b.ExSkillSprite Exスキルフレームのパーティクルのインスタンスを生成して返す
---@field public spawn fun(self: Character17b.ExSkillSpriteManager, target: ModelPart, index: Vector2, color?: Vector3, pos: Vector3, velocity: Vector3, rotVelocity: integer, size: number, scaleTracker?: ModelPart, lifetime: integer, shouldSeeCamera: boolean, speedFactor: number) Exスキルフレームのパーティクルをスポーンさせる
local ExSkillSpriteManager = {
    ---コンストラクタ
    ---@return Character17b.ExSkillSpriteManager
    new = function ()
        ---@type Character17b.ExSkillSpriteManager
        local instance = MiscUtils.instantiate(ExSkillSpriteManager, SpawnObjectManager)

        instance.managerName = "ex_skill_sprite"

        return instance
    end;

    ---Exスキルフレームのパーティクルのインスタンスを生成して返す。
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param index Vector2 テクスチャの種類を決めるインデックス番号
    ---@param color? Vector3 スプライトの色
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param velocity Vector3 オブジェクトの移動速度
    ---@param rotVelocity integer オブジェクトの角速度
    ---@param size number スプライトの大きさ
    ---@param scaleTracker? ModelPart スプライトの大きさの参照元のモデルパーツ
    ---@param lifetime integer このインスタンスを破棄するまでの時間
    ---@param shouldSeeCamera boolean カメラを見続けるべきかどうか
    ---@param speedFactor number 速度の変化係数
    ---@return Character17b.ExSkillSprite instance 生成したインスタンス
    getObject = function (_, target, index, color, pos, velocity, rotVelocity, size, scaleTracker, lifetime, shouldSeeCamera, speedFactor)
        return ExSkillSprite.new(target, index, color, pos, velocity, rotVelocity, size, scaleTracker, lifetime, shouldSeeCamera, speedFactor)
    end;

    ---Exスキルフレームのパーティクルをスポーンさせる。
    ---@param self Character17b.ExSkillSpriteManager
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param index Vector2 テクスチャの種類を決めるインデックス番号
    ---@param color? Vector3 スプライトの色
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param velocity Vector3 オブジェクトの移動速度
    ---@param rotVelocity integer オブジェクトの角速度
    ---@param size number スプライトの大きさ
    ---@param scaleTracker? ModelPart スプライトの大きさの参照元のモデルパーツ
    ---@param lifetime integer このインスタンスを破棄するまでの時間
    ---@param shouldSeeCamera boolean カメラを見続けるべきかどうか
    ---@param speedFactor number 速度の変化係数
    spawn = function (self, target, index, color, pos, velocity, rotVelocity, size, scaleTracker, lifetime, shouldSeeCamera, speedFactor)
        SpawnObjectManager.spawn(self, target, index, color, pos, velocity, rotVelocity, size, scaleTracker, lifetime, shouldSeeCamera, speedFactor)
    end;
}

return ExSkillSpriteManager
