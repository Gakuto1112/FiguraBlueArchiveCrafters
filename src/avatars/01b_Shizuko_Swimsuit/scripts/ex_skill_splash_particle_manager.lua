---@class (exact) ExSkillSplashParticleManager : SpawnObjectManager Exスキルでで使用するスプラッシュパーティクルを管理するクラス
---@field public objects ExSkillSplashParticle[] インスタンスで制御するオブジェクトのテーブル
local ExSkillSplashParticleManager = {
    ---コンストラクタ
    ---@return ExSkillSplashParticleManager
    new = function (parent)
        ---@type ExSkillSplashParticleManager
        local instance = MiscUtils.instantiate(ExSkillSplashParticleManager, SpawnObjectManager, parent)

        instance.managerName = "ex_skill_1_splash_particle"

        return instance
    end;

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models.models.ex_skill_1.Gui:newPart("script_ex_skill_1_splash_particles")
    end;

    ---Exスキルのスプラッシュパーティクルのインスタンスを生成して返す。
    ---@param self ExSkillSplashParticleManager
    ---@param pos Vector2 パーティクルをスポーンさせる画面上の座標
    ---@param velocity Vector2 パーティクルの速度
    ---@return ExSkillSplashParticle instance 生成したインスタンス
    getObject = function (self, pos, velocity)
        return ExSkillSplashParticle.new(self.parent, pos, velocity)
    end;

    ---Exスキルのスプラッシュパーティクルをスポーンさせる。
    ---@param self ExSkillSplashParticleManager
    ---@param pos Vector2 パーティクルをスポーンさせる画面上の座標
    ---@param velocity Vector2 パーティクルの速度
    spawn = function (self, pos, velocity)
        SpawnObjectManager.spawn(self, pos, velocity)
    end;
}

return ExSkillSplashParticleManager
