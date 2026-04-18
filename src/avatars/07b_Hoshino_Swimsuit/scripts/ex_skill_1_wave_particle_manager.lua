---@class ExSkill1WaveParticleManager : SpawnObjectManager 水着のExスキルアニメーション後の波を表現するパーティクルを管理するクラス
---@field package animationCount integer パーティクルの再生タイミングを計るカウンター
---@field public getObject fun(self: ExSkill1WaveParticleManager, pos: Vector3, rot: number): ExSkill1WaveParticleManager パーティクルのインスタンスを生成して返す
---@field public spawn fun(self: ExSkill1WaveParticleManager, pos: Vector3, rot: number) パーティクルを生成する
---@field public play fun(self: ExSkill1WaveParticleManager) 波のパーティクルを再生する
local ExSkill1WaveParticleManager = {
    ---コンストラクタ
    ---@return ExSkill1WaveParticleManager
    new = function (parent)
        ---@type ExSkill1WaveParticleManager
        local instance = MiscUtils.instantiate(ExSkill1WaveParticleManager, SpawnObjectManager, parent)

        instance.managerName = "ex_skill_1_particles"
        instance.animationCount = 0

        return instance
    end;

    ---パーティクルのインスタンスを生成して返す。
    ---@param pos Vector3 パーティクルの基準位置
    ---@param rot number パーティクルの向き（度数法）
    ---@return ExSkill1WaveParticle instance 生成したインスタンス
    getObject = function (_,  pos, rot)
        return ExSkill1WaveParticle.new(pos, rot)
    end;

    ---パーティクルを生成する。
    ---@param self ExSkill1WaveParticleManager
    ---@param pos Vector3 パーティクルの基準位置
    ---@param rot number パーティクルの向き（度数法）
    spawn = function (self, pos, rot)
        SpawnObjectManager.spawn(self, pos, rot)
    end;

    ---波のパーティクルを再生する。
    ---@param self ExSkill1WaveParticleManager
    play = function (self)
        events.TICK:remove("ex_skill_1_particles_play_tick")

        local playerPos = player:getPos()
        local bodyYaw = player:getBodyYaw()
        events.TICK:register(function ()
            self:spawn(playerPos, bodyYaw)
            if self.animationCount == 20 then
                events.TICK:remove("ex_skill_1_particles_play_tick")
                self.animationCount = 0
            else
                self.animationCount = self.animationCount + 1
            end
        end, "ex_skill_1_particles_play_tick")
    end;
}

return ExSkill1WaveParticleManager
