---@class (exact) ExSkill1MelodyParticle : SpawnObject Exスキル2で使用する音符の独自パーティクルのクラス
---@field package object ModelPart インスタンスで制御するモデルパーツ
---@field public subObject ModelPart インスタンスで制御するサブモデルパーツ
---@field package currentPos Vector3 現ティックのパーティクルの位置
---@field package nextPos Vector3 次ティックのパーティクルの位置
---@field package rot Vector3 パーティクルの向き
---@field package size Vector2 パーティクルの大きさ
---@field package velocity Vector3 パーティクルの移動速度
---@field package lifeTime integer このパーティクルが破棄されるまでの時間
---@field package shouldSeeCamera boolean パーティクルがカメラワークの方向を見るべきかどうか
---@field public new fun(pos: Vector3, rot: Vector3, size: Vector2, velocity: Vector3, lifeTime: integer, shouldSeeCamera: boolean): ExSkill1MelodyParticle コンストラクタ
local ExSkill1MelodyParticle = {
    ---コンストラクタ
    ---@param pos Vector3 パーティクルの初期位置
    ---@param rot Vector3 パーティクルの向き
    ---@param size Vector2 パーティクルの大きさ
    ---@param velocity Vector3 パーティクルの移動方向と速度
    ---@param lifeTime integer パーティクルの表示時間
    ---@param shouldSeeCamera boolean パーティクルがカメラワークの方向を見るべきかどうか
    ---@return ExSkill1MelodyParticle
    new = function (pos, rot, size, velocity, lifeTime, shouldSeeCamera)
        ---@type ExSkill1MelodyParticle
        local instance = MiscUtils.instantiate(ExSkill1MelodyParticle, SpawnObject)

        instance.object = models.script_ex_skill_1_melody_particle:newPart(instance.uuid)
        instance.subObject = models.models.ex_skill_1.Notes["Note"..math.random(1, 3)]:copy(client.intUUIDToString(client.generateUUID()))
        instance.currentPos = pos:copy()
        instance.nextPos = instance.currentPos:copy()
        instance.rot = rot:copy()
        instance.size = size:copy()
        instance.velocity = velocity:copy()
        instance.shouldSeeCamera = shouldSeeCamera
        instance.lifeTime = lifeTime

        instance.callbacks = {
            ---@param self ExSkill1MelodyParticle
            onInit = function (self)
                self.subObject:setVisible(true)
                self.subObject:setScale(self.size:copy():augmented(1))
                if not self.shouldSeeCamera then
                    self.object:setRot(0, player:getBodyYaw() * -1, 0)
                    self.subObject:setRot(self.rot)
                end
                self.object:addChild(self.subObject)
            end;

            ---@param self ExSkill1MelodyParticle
            onDeinit = function (self)
                self.object:removeChild(self.subObject)
                self.subObject:remove()
                models.script_ex_skill_1_melody_particle:removeChild(self.object)
                self.object:remove()
            end;

            ---@param self ExSkill1MelodyParticle
            onTick = function (self)
                if self.lifeTime == 0 then
                    self.shouldDeinit = true
                end

                --パーティクルの位置を強制更新
                self.currentPos = self.nextPos:copy()
                self.object:setPos(self.currentPos:copy():scale(16))

                --次の位置を計算
                self.nextPos = self.currentPos:copy():add(self.velocity)

                --カウンター更新
                self.lifeTime = self.lifeTime - 1
            end;

            ---@param self ExSkill1MelodyParticle
            onRender = function (self, delta, context)
                if self.shouldSeeCamera then
                    self.object:setRot(client:getCameraRot():mul(1, -1, 1))
                end
                if self.velocity:length() > 0 then
                    self.object:setPos(self.currentPos:copy():add(self.nextPos:copy():sub(self.currentPos):scale(delta)):scale(16))
                end
            end;
        }

        return instance
    end;
}

return ExSkill1MelodyParticle
