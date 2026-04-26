---@class ExSkill1WaveParticle : SpawnObject 水着のExスキルアニメーション後の波を表現するパーティクルの1グループを管理するクラス
---@field package object Particle[] インスタンスで制御するオブジェクト
---@field package pos Vector3 パーティクルの基準位置
---@field package rot number パーティクルの向き（度数法）
---@field package animationCount integer パーティクルの速度調整のためのティックカウンター
---@field public new fun(pos: Vector3, rot: number): ExSkill1WaveParticle コンストラクタ
local ExSkill1WaveParticle = {
    ---コンストラクタ
    ---@param pos Vector3 パーティクルの基準位置
    ---@param rot number パーティクルの向き（度数法）
    ---@return ExSkill1WaveParticle
    new = function (pos, rot)
        ---@type ExSkill1WaveParticle
        local instance = MiscUtils.instantiate(ExSkill1WaveParticle, SpawnObject)

        instance.object = {}
        instance.pos = pos:copy()
        instance.rot = rot
        instance.animationCount = 0

        instance.callbacks = {
            ---@param self ExSkill1WaveParticle
            onInit = function (self)
                local particlePos = vectors.rotateAroundAxis(self.rot * -1 + 120, 0, 0, 0.5, 0, 1, 0):add(self.pos)
                local particleOffset = vectors.rotateAroundAxis(self.rot * -1 + 120, -1, 0, 0, 0, 1, 0)
                for i = -0.5, 0.5, 0.5 do
                    for _ = 1, 3 do
                        local colorFactor = math.random()
                        table.insert(instance.object, particles:newParticle("minecraft:dust 1 1 1 1", particlePos:copy():add(particleOffset:copy():scale(i))):setScale(1):setVelocity(vectors.rotateAroundAxis(self.rot * -1 + 120, math.random() * 0.1 - 0.05, 0, 0.3, 0, 1, 0)):setColor(colorFactor, 1, 1):setLifetime(colorFactor * 25 + 5))
                    end
                end
            end;

            ---@param self ExSkill1WaveParticle
            onTick = function (self)
                local velocityAddition = vectors.rotateAroundAxis(self.rot * -1 + 120, 0, math.cos(self.animationCount / 60 * 2 * math.pi) * 0.03, math.cos(self.animationCount / 80 * math.pi) * -0.02, 0, 1, 0)
                for _, particle in ipairs(self.object) do
                    particle:setVelocity(particle:getVelocity():add(velocityAddition))
                end
                if self.animationCount == 30 then
                    self.shouldDeinit = true
                else
                    self.animationCount = self.animationCount + 1
                end
            end;
        }

        return instance
    end;
}

return ExSkill1WaveParticle
