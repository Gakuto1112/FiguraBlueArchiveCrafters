---@class DroneMissile : SpawnObject 視覚的なミサイルオブジェクトのクラス
---@field package object ModelPart インスタンスで制御するモデルパーツ
---@field package currentPos Vector3 現ティックでのオブジェクトの位置
---@field package nextPos Vector3 次ティックでのオブジェクトの位置
---@field package rot Vector3 ミサイルモデルの向き
---@field package velocity Vector3 ミサイルが飛んでいく方向を示すベクトル
---@field package explosionCount integer ミサイルが爆発するまでのカウンタ
---@field package missileSound Sound ミサイルが飛んでいく方向を示すベクトル
---@field public new fun(startPos: Vector3, rot: Vector3): DroneMissile コンストラクタ
---@field package explode fun(self: DroneMissile) ミサイルを爆破させる
local DroneMissile = {
    ---コンストラクタ
    ---@param startPos Vector3 ミサイルの出現位置
    ---@param rot Vector3 ミサイルが飛んでいく方向
    ---@return DroneMissile
    new = function (startPos, rot)
        ---@type DroneMissile
        local instance = MiscUtils.instantiate(DroneMissile, SpawnObject)

        instance.object = models.models.ex_skill_1.Missile:copy(instance.uuid)
        instance.currentPos = startPos:copy()
        instance.nextPos = instance.currentPos:copy()
        instance.rot = rot:copy()
        instance.velocity = vectors.rotateAroundAxis(instance.rot.z, vectors.rotateAroundAxis(instance.rot.y, vectors.rotateAroundAxis(instance.rot.x, 0, 0, 1, 1, 0, 0), 0, 1, 0), 0, 0, 1)
        instance.explosionCount = 200;
        instance.missileSound = sounds:playSound("minecraft:entity.firework_rocket.launch", instance.currentPos, 1, 0.5)

        instance.callbacks = {
            ---@param self DroneMissile
            onInit = function (self)
                models.script_drone_missile:addChild(self.object)
                self.object:setPos(self.currentPos:copy():scale(16))
                self.object:setRot(self.rot)
                self.object:setVisible(true)
                --self.object:setScale(10, 10, 10)
            end;

            ---@param self DroneMissile
            onDeinit = function (self)
                models.script_drone_missile:removeChild(self.object)
                self.object:remove()
            end;

            ---@param self DroneMissile
            onTick = function (self)
                if self.explosionCount == 0 then
                    self:explode()
                end

                --花火の位置を強制更新
                self.currentPos = self.nextPos
                self.object:setPos(self.currentPos:copy():scale(16))
                self.missileSound:setPos(self.currentPos)

                --当たり判定チェック
                for _, collisionBox in ipairs(world.getBlockState(self.currentPos):getCollisionShape()) do
                    local collisionBoxStart = self.currentPos:copy():floor():add(collisionBox[1])
                    local collisionBoxEnd = self.currentPos:copy():floor():add(collisionBox[2])

                    if collisionBoxStart.x <= self.currentPos.x and collisionBoxEnd.x >= self.currentPos.x and collisionBoxStart.y <= self.currentPos.y and collisionBoxEnd.y >= self.currentPos.y and collisionBoxStart.z <= self.currentPos.z and collisionBoxEnd.z >= self.currentPos.z then
                        self:explode()
                        return
                    end
                end

                particles:newParticle("minecraft:large_smoke", self.currentPos):setVelocity(vectors.rotateAroundAxis(self.rot.z, vectors.rotateAroundAxis(self.rot.y, vectors.rotateAroundAxis(self.rot.x, math.random() * 0.05 - 0.025, math.random() * 0.05 - 0.025, 0, 1, 0, 0), 0, 1, 0), 0, 0, 1))
                particles:newParticle("minecraft:flame", self.currentPos):setScale(1.5):setVelocity(vectors.rotateAroundAxis(self.rot.z, vectors.rotateAroundAxis(self.rot.y, vectors.rotateAroundAxis(self.rot.x, math.random() * 0.05 - 0.025, math.random() * 0.05 - 0.025, 0, 1, 0, 0), 0, 1, 0), 0, 0, 1)):setLifetime(4)

                --次ティックの花火の位置を算出
                self.nextPos = self.currentPos:copy():add(self.velocity:copy():scale(1.4))

                self.explosionCount = self.explosionCount - 1
            end;

            onRender = function (self, delta)
                self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):scale(16))
            end;
        }

        return instance
    end;

    ---ミサイルを爆破させる。
    ---@param self DroneMissile
    explode = function (self)
        particles:newParticle("minecraft:explosion_emitter", self.currentPos)
        for _ = 1, 20 do
            local randomOffset = vectors.vec3(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)
            particles:newParticle("minecraft:poof", self.currentPos:copy():add(randomOffset:copy():scale(5))):setScale(3):setVelocity(randomOffset:copy():scale(1))
        end
        sounds:playSound("minecraft:entity.generic.explode", self.currentPos, 0.5, 1):setAttenuation(5)
        self.explosionCount = -1
        self.shouldDeinit = true
    end;
}

return DroneMissile