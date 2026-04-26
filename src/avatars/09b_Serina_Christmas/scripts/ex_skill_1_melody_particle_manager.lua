---@class ExSkill1MelodyParticleManager : SpawnObjectManager Exスキル1で使用する音符の独自パーティクルを管理するクラス
---@field package getObject fun(self: ExSkill1MelodyParticleManager, pos: Vector3, rot: Vector3, size: Vector2, velocity: Vector3, lifeTime: integer, shouldSeeCamera: boolean): ExSkill1MelodyParticle 音符パーティクルのインスタンスを生成して返す
---@field public spawn fun(self: ExSkill1MelodyParticleManager, pos: Vector3, rot: Vector3, size: Vector2, velocity: Vector3, lifeTime: integer, shouldSeeCamera: boolean) 音符パーティクルをスポーンさせる
local ExSkill1MelodyParticleManager = {
    ---コンストラクタ
    ---@return ExSkill1MelodyParticleManager
    new = function ()
        ---@type ExSkill1MelodyParticleManager
        local instance = MiscUtils.instantiate(ExSkill1MelodyParticleManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_melody_particle"

        return instance
    end;

    ---初期化関数
    ---@param self ExSkill1MelodyParticleManager
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_ex_skill_1_melody_particle", "World")
    end;

    ---音符パーティクルのインスタンスを生成して返す。
    ---@param pos Vector3 パーティクルの初期位置
    ---@param rot Vector3 パーティクルの向き
    ---@param size Vector2 パーティクルの大きさ
    ---@param velocity Vector3 パーティクルの移動方向と速度
    ---@param lifeTime integer パーティクルの表示時間
    ---@param shouldSeeCamera boolean パーティクルがカメラワークの方向を見るべきかどうか
    ---@return ExSkill1MelodyParticle instance 生成したインスタンス
    getObject = function (_, pos, rot, size, velocity, lifeTime, shouldSeeCamera)
        return ExSkill1MelodyParticle.new(pos, rot, size, velocity, lifeTime, shouldSeeCamera)
    end;

    ---音符パーティクルをスポーンさせる。
    ---@param self ExSkill1MelodyParticleManager
    ---@param pos Vector3 パーティクルの初期位置
    ---@param rot Vector3 パーティクルの向き
    ---@param size Vector2 パーティクルの大きさ
    ---@param velocity Vector3 パーティクルの移動方向と速度
    ---@param lifeTime integer パーティクルの表示時間
    ---@param shouldSeeCamera boolean パーティクルがカメラワークの方向を見るべきかどうか
    spawn = function (self, pos, rot, size, velocity, lifeTime, shouldSeeCamera)
        SpawnObjectManager.spawn(self, pos, rot, size, velocity, lifeTime, shouldSeeCamera)
    end;
}

return ExSkill1MelodyParticleManager
