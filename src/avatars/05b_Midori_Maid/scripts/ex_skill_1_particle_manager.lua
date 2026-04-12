---@class ExSkill1ParticleManager : SpawnObjectManager Exスキル1で使用する独自定義のパーティクルのマネージャークラス
---@field public getObject fun(self: ExSkill1ParticleManager, text: string): ExSkill1Particle 独自定義のパーティクルのインスタンスを生成して返す
local ExSkill1ParticleManager = {
    ---コンストラクタ
    ---@return ExSkill1ParticleManager
    new = function ()
        ---@type ExSkill1ParticleManager
        ---@diagnostic disable-next-line: undefined-global
        local instance = MiscUtils.instantiate(ExSkill1ParticleManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_particle"

        return instance
    end;

    ---独自定義のパーティクルのインスタンスを生成して返す。
    ---@return ExSkill1Particle instance 生成したインスタンス
    getObject = function ()
        return ExSkill1Particle.new()
    end;
}

return ExSkill1ParticleManager