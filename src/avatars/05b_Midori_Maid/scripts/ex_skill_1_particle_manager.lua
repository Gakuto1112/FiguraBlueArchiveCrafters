---@class Character05b.ExSkill1ParticleManager : SpawnObjectManager Exスキル1で使用する独自定義のパーティクルのマネージャークラス
---@field public getObject fun(self: Character05b.ExSkill1ParticleManager, text: string): Character05b.ExSkill1Particle 独自定義のパーティクルのインスタンスを生成して返す
local ExSkill1ParticleManager = {
    ---コンストラクタ
    ---@return Character05b.ExSkill1ParticleManager
    new = function ()
        ---@type Character05b.ExSkill1ParticleManager
        local instance = MiscUtils.instantiate(ExSkill1ParticleManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_particle"

        return instance
    end;

    ---独自定義のパーティクルのインスタンスを生成して返す。
    ---@return Character05b.ExSkill1Particle instance 生成したインスタンス
    getObject = function ()
        return ExSkill1Particle.new()
    end;
}

return ExSkill1ParticleManager