---@class (exact) ExSkillSprite : SpawnObject Exスキル内で使用するスプライトのオブジェクトのクラス
---@field package target ModelPart インスタンスオブジェクトをアタッチする親モデル
---@field package object ModelPart インスタンスで制御するオブジェクト
---@field package subObject ModelPart インスタンスで制御するサブオブジェクト
---@field package index Vector2 テクスチャの種類を決めるインデックス番号
---@field package size number スプライトの大きさ倍率
---@field package color? Vector3 スプライトの色
---@field package currentPos Vector3 オブジェクトの現在位置
---@field package nextPos Vector3 次ティックのオブジェクトの位置
---@field package currentRot integer オブジェクトの現在角度
---@field package nextRot integer 次ティックのオブジェクトの角度
---@field package velocity Vector3 オブジェクトの速度
---@field package rotVelocity Vector3 オブジェクトの角速度
---@field package scaleTracker? ModelPart スプライトの大きさの参照元のモデルパーツ
---@field package lifetime integer オブジェクトの残り時間を計るカウンター
---@field package particleColor integer トレイルのパーティクルの色
local ExSkillSprite = {
    ---コンストラクタ
    ---@param self ExSkillSprite
    ---@param objectModel ModelPart スプライトとしてコピーする元のモデルパーツ
    ---@param targetParent ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param size number スプライトの大きさ
    ---@param color? Vector3 スプライトの色
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param velocity Vector3 オブジェクトの移動速度
    ---@param rot Vector3 オブジェクトの初期角度
    ---@param rotVelocity Vector3 オブジェクトの角速度
    ---@param gravity? number オブジェクトにかかる重力（1 = 標準重力）
    ---@param scaleTracker? ModelPart スプライトの大きさの参照元のモデルパーツ
    ---@param lifetime integer このインスタンスを破棄するまでの時間
    ---@param shouldSeeCamera boolean カメラを見続けるべきかどうか
    ---@return ExSkillSprite
    new = function (objectModel, targetParent, size, color, pos, velocity, rot, rotVelocity, gravity, scaleTracker, lifetime, shouldSeeCamera)
        local instance = MiscUtils.instantiate(ExSkillSprite, SpawnObject)

        instance.target = targetParent
        instance.object = instance.target:newPart(instance.uuid, shouldSeeCamera and "Camera" or "None")
        instance.subObject = objectModel:copy(client.intUUIDToString(client.generateUUID()))
        instance.size = size
        instance.color = color ~= nil and color:copy() or nil
        instance.currentPos = pos:copy()
        instance.nextPos = instance.currentPos:copy()
        instance.currentRot = rot:copy()
        instance.nextRot = instance.currentRot:copy()
        instance.velocity = velocity:copy()
        instance.rotVelocity = rotVelocity:copy()
        instance.gravity = gravity ~= nil and gravity or 0
        instance.scaleTracker = scaleTracker
        instance.lifetime = lifetime
        instance.particleColor = math.random(1, 3)

        instance.callbacks = {
            ---@param self ExSkillSprite
            onInit = function (self)
                self.object:setPivot(0, 4, 0)
                self.object:addChild(self.subObject)
                self.subObject:setVisible(true)
                if self.size ~= 1 then
                    self.subObject:setScale(vectors.vec3(1, 1, 1):scale(self.size))
                end
                self.object:setPos(self.currentPos:copy():scale(16))
                self.subObject:setRot(self.currentRot)
                if color ~= nil then
                    self.object:setColor(self.color)
                end
            end;

            ---@param self ExSkillSprite
            onDeinit = function (self)
                self.object:removeChild(self.subObject)
                self.subObject:remove()
                self.target:removeChild(self.object)
                self.object:remove()
            end;

            ---@param self ExSkillSprite
            onTick = function (self)
                --スプライトの位置と向きを強制更新
                if self.velocity:length() > 0 then
                    self.currentPos = self.nextPos:copy()
                    self.object:setPos(self.currentPos:copy():scale(16))
                end
                if self.rotVelocity:length() > 0 then
                    self.currentRot = self.nextRot:copy()
                    self.subObject:setRot(self.currentRot)
                end

                local colorTable = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)}
                particles:newParticle("minecraft:firework", self.currentPos):setScale(0.75):setColor(colorTable[self.particleColor]):setGravity(0):setLifetime(10)

                --カウンターを更新
                if self.lifetime == 0 then
                    self.shouldDeinit = true
                end
                self.lifetime = self.lifetime - 1

                --次ティックの位置と向きを計算
                if self.velocity:length() > 0 then
                    self.nextPos = self.currentPos:copy():add(self.velocity:copy():scale(0.05))
                end
                if self.rotVelocity:length() > 0 then
                    self.nextRot = self.currentRot:copy():add(self.rotVelocity:copy():scale(0.05))
                end
                if self.gravity ~= 0 then
                    self.velocity.y = self.velocity.y - (9.81 * self.gravity * 0.05) --9.81 = 重力加速度
                end
            end;

            ---@param self ExSkillSprite
            onRender = function (self, delta)
                if self.velocity:length() > 0 then
                    self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):scale(16))
                end
                if self.rotVelocity:length() > 0 then
                    self.subObject:setRot(self.nextRot:copy():sub(self.currentRot):scale(delta):add(self.currentRot))
                end
                local trueScale = self.size * (self.scaleTracker ~= nil and self.scaleTracker:getAnimScale().x or 1) * math.clamp((self.lifetime - delta) / 2, 0, 1)
                self.subObject:setScale(vectors.vec3(1, 1, 1):scale(trueScale))
            end;
        }

        return instance
    end
}

return ExSkillSprite
