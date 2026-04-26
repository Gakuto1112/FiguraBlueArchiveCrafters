---@class TankShell : SpawnObject 視覚的な砲弾オブジェクトのクラス
---@field package object ModelPart インスタンスで制御するモデルパーツ
---@field package currentPos Vector3 現ティックでのオブジェクトの位置
---@field package nextPos Vector3 次ティックでのオブジェクトの位置
---@field package rot Vector3 ミサイルモデルの向き
---@field package velocity Vector3 ミサイルが飛んでいく方向を示すベクトル
---@field package explosionCount integer ミサイルが爆発するまでのカウンタ
---@field package missileSound Sound ミサイルが飛んでいく方向を示すベクトル
---@field public new fun(startPos: Vector3, rot: Vector3): TankShell コンストラクタ
---@field package explode fun(self: TankShell) 砲弾を爆破させる
local TankShell = {
    ---コンストラクタ
    ---@param startPos Vector3 砲弾の出現位置
    ---@param rot Vector3 砲弾が飛んでいく方向
    ---@return TankShell
    new = function (startPos, rot)
        ---@type TankShell
        local instance = MiscUtils.instantiate(TankShell, SpawnObject)

        instance.object = models.models.ex_skill_1.Shell:copy(instance.uuid)
        instance.currentPos = startPos:copy()
        instance.nextPos = instance.currentPos:copy()
        instance.rot = rot:copy()
        instance.velocity = vectors.rotateAroundAxis(instance.rot.z, vectors.rotateAroundAxis(instance.rot.y, vectors.rotateAroundAxis(instance.rot.x, 0, 0, 1, 1, 0, 0), 0, 1, 0), 0, 0, 1)
        instance.explosionCount = 200
        instance.missileSound = sounds:playSound("minecraft:entity.firework_rocket.launch", instance.currentPos, 1, 2)

        instance.callbacks = {
            ---@param self TankShell
            onInit = function (self)
                models.script_tank_shell:addChild(self.object)
                self.object:setPos(self.currentPos:copy():scale(16))
                self.object:setRot(math.deg(math.atan2(self.velocity.y, math.sqrt(self.velocity.x ^ 2 + self.velocity.z ^ 2))) * -1, self.rot.y, self.rot.z)
                self.object:setVisible(true)
            end;

            ---@param self TankShell
            onDeinit = function (self)
                models.script_tank_shell:removeChild(self.object)
                self.object:remove()
            end;

            ---@param self TankShell
            onTick = function (self)
                if self.explosionCount == 0 then
                    self:explode()
                end

                --砲弾の位置を強制更新
                self.currentPos = self.nextPos
                self.object:setPos(self.currentPos:copy():scale(16))
                self.missileSound:setPos(self.currentPos)

                particles:newParticle("minecraft:large_smoke", self.currentPos):setVelocity(vectors.rotateAroundAxis(self.rot.z, vectors.rotateAroundAxis(self.rot.y, vectors.rotateAroundAxis(self.rot.x, math.random() * 0.05 - 0.025, math.random() * 0.05 - 0.025, 0, 1, 0, 0), 0, 1, 0), 0, 0, 1))
                particles:newParticle("minecraft:flame", self.currentPos):setScale(1.5):setVelocity(vectors.rotateAroundAxis(self.rot.z, vectors.rotateAroundAxis(self.rot.y, vectors.rotateAroundAxis(self.rot.x, math.random() * 0.05 - 0.025, math.random() * 0.05 - 0.025, 0, 1, 0, 0), 0, 1, 0), 0, 0, 1)):setLifetime(4)

                --次ティックの砲弾の位置を算出
                self.nextPos = self.currentPos:copy():add(self.velocity:copy():scale(4))
                self.velocity.y = self.velocity.y - 0.01
                self.object:setRot(math.deg(math.atan2(self.velocity.y, math.sqrt(self.velocity.x ^ 2 + self.velocity.z ^ 2))) * -1, self.rot.y, self.rot.z)

                --当たり判定チェック
                local block, _, _ = raycast:block(self.currentPos, self.nextPos, "COLLIDER", "NONE")
                if block.id ~= "minecraft:air" and block.id ~= "minecraft:cave_air" and block.id ~= "minecraft:void_air" then
                    self:explode()
                end

                self.explosionCount = self.explosionCount - 1
            end;

            onRender = function (self, delta)
                self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):scale(16))
            end;
        }

        return instance
    end;

    ---砲弾を爆破させる。
    ---@param self TankShell
    explode = function (self)
        particles:newParticle("minecraft:explosion_emitter", self.currentPos)
        for _ = 1, 50 do
            local randomOffset = vectors.vec3(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1)
            particles:newParticle("minecraft:large_smoke", self.currentPos:copy():add(randomOffset:copy():scale(5))):setScale(10):setVelocity(randomOffset:copy():scale(0.1)):setLifetime(100 + math.random(-20, 20))
        end
        sounds:playSound("minecraft:entity.generic.explode", self.currentPos, 0.5, 1):setAttenuation(5)
        --host:sendChatCommand("/summon creeper "..self.currentPos.x.." "..(self.currentPos.y + 1).." "..self.currentPos.z.." {NoGravity:1b,Silent:1b,Invulnerable:1b,NoAI:1b,ExplosionRadius:5b,Fuse:0,ignited:1b}")
        self.explosionCount = -1
        self.shouldDeinit = true
    end;
}

return TankShell
