---@class (exact) Firework : SpawnObject 花火台から打たれる花火のクラス
---@field package object ItemTask インスタンスで制御するオブジェクト
---@field package currentPos Vector3 ロケット花火の現在位置
---@field package nextPos Vector3 ロケット花火の次ティックの位置
---@field package rot Vector3 ロケット花火の向き
---@field package rotVec Vector3 ロケット花火が飛んでいく方向を示すベクトル
---@field package blastCount integer ロケット花火が爆発するまでのカウンタ
---@field package launchSound Sound ロケット花火を飛ばす音のインスタンス
---@field public new fun(startPos: Vector3, rot: Vector3): Firework コンストラクタ
---@field public blast fun(self: Firework) 花火を爆発させる
local Firework = {
    ---コンストラクタ
    ---@param startPos Vector3 ロケット花火の出現位置
    ---@param rot Vector3 ロケット花火が飛んでいく方向
    ---@return Firework
    new = function (startPos, rot)
        ---@type Firework
        local instance = MiscUtils.instantiate(Firework, SpawnObject)

        instance.object = models.script_firework:newItem(instance.uuid):setItem("minecraft:firework_rocket"):setScale(0.5, 0.5, 0.5)
        instance.currentPos = startPos:copy()
        instance.nextPos = instance.currentPos:copy()
        instance.rot = rot:copy()
        instance.rotVec = vectors.rotateAroundAxis(rot.z, vectors.rotateAroundAxis(rot.y, vectors.rotateAroundAxis(rot.x, 0, 0, 1, 1, 0, 0), 0, 1, 0), 0, 0, 1)
        instance.blastCount = 40
        instance.launchSound = sounds:playSound("minecraft:entity.firework_rocket.launch", instance.currentPos, 1, 0.5)

        instance.callbacks = {
            ---@param self Firework
            onInit = function (self)
                self.object:setRot(rot:copy():add(90, 0, 0))
            end;

            ---@param self Firework
            onDeinit = function (self)
                models.script_firework:removeTask(self.uuid)
            end;

            ---@param self Firework
            onTick = function (self)
                if self.blastCount == 0 then
                    self:blast()
                end
                --花火の位置を強制更新
                self.currentPos = self.nextPos
                self.object:setPos(self.currentPos:copy():scale(16))
                self.launchSound:setPos(self.currentPos)

                --当たり判定チェック
                for _, collisionBox in ipairs(world.getBlockState(self.currentPos):getCollisionShape()) do
                    local collisionBoxStart = self.currentPos:copy():floor():add(collisionBox[1])
                    local collisionBoxEnd = self.currentPos:copy():floor():add(collisionBox[2])

                    if collisionBoxStart.x <= self.currentPos.x and collisionBoxEnd.x >= self.currentPos.x and collisionBoxStart.y <= self.currentPos.y and collisionBoxEnd.y >= self.currentPos.y and collisionBoxStart.z <= self.currentPos.z and collisionBoxEnd.z >= self.currentPos.z then
                        self:blast()
                        return
                    end
                end

                particles:newParticle("minecraft:firework", self.currentPos):setVelocity(vectors.rotateAroundAxis(rot.z, vectors.rotateAroundAxis(rot.y, vectors.rotateAroundAxis(rot.x, math.random() * 0.05 - 0.025, 0.1, 0, 1, 0, 0), 0, 1, 0), 0, 0, 1))

                --次ティックの花火の位置を算出
                self.nextPos = self.currentPos:copy():add(self.rotVec:copy():scale(1.4))

                self.blastCount = self.blastCount - 1
            end;

            ---@param self Firework
            onRender = function (self, delta, context)
                self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):scale(16))
            end;
        }

        return instance
    end;

    ---花火を爆発させる。
    ---@param self Firework
    blast = function (self)
        local fireworkColor = vectors.hsvToRGB(math.random(), 0.8, 1)
        particles:newParticle("minecraft:flash", self.currentPos):setColor(fireworkColor)
        for _ = 1, 400 do
            local particleAngleX = math.random() * math.pi * 2
            local particleAngleY = math.random() * math.pi * 2
            particles:newParticle("minecraft:firework", self.currentPos):setVelocity(math.cos(particleAngleX) * math.cos(particleAngleY) * 0.4, math.sin(particleAngleY) * 0.4, math.sin(particleAngleX) * math.cos(particleAngleY) * 0.4):setColor(fireworkColor)
        end
        sounds:playSound("minecraft:entity.firework_rocket.large_blast", self.currentPos, 1, 1):setAttenuation(5)
        self.shouldDeinit = true
    end;
}

return Firework
