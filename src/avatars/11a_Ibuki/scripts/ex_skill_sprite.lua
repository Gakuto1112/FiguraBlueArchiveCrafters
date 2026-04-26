---@class (exact) ExSkillSprite : SpawnObject Exスキル内で使用するスプライトのオブジェクトのクラス
---@field package object ModelPart インスタンスで制御するオブジェクト
---@field package subObject ModelPart インスタンスで制御するサブオブジェクト
---@field package sprite SpriteTask インスタンスで制御するメインのスプライト
---@field package target ModelPart インスタンスオブジェクトをアタッチする親モデル
---@field package index integer テクスチャの種類を決めるインデックス番号
---@field package currentPos Vector3 オブジェクトの現在位置
---@field package nextPos Vector3 次ティックのオブジェクトの位置
---@field package currentRot integer オブジェクトの現在角度
---@field package nextRot integer 次ティックのオブジェクトの角度
---@field package velocity Vector3 オブジェクトの速度
---@field package rotVelocity integer オブジェクトの角速度
---@field package size number スプライトの大きさ
---@field package scaleTracker? ModelPart スプライトの大きさの参照元のモデルパーツ
---@field package speedFactor number 速度の変化係数
---@field package lifetimeCount integer オブジェクトの残り時間を計るカウンター
local ExSkillSprite = {
    ---コンストラクタ
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param index integer テクスチャの種類を決めるインデックス番号
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param velocity Vector3 オブジェクトの移動速度
    ---@param rotVelocity number オブジェクトの角速度
    ---@param size number スプライトの大きさ
    ---@param scaleTracker? ModelPart スプライトの大きさの参照元のモデルパーツ
    ---@param lifetime integer このインスタンスを破棄するまでの時間
    ---@param shouldSeeCamera boolean カメラを見続けるべきかどうか
    ---@param speedFactor number 速度の変化係数
    ---@return ExSkillSprite
    new = function (target, index, pos, velocity, rotVelocity, size, scaleTracker, lifetime, shouldSeeCamera, speedFactor)
        ---@type ExSkillSprite
        local instance = MiscUtils.instantiate(ExSkillSprite, SpawnObject)

        instance.target = target
        instance.object = instance.target:newPart(instance.uuid)
        instance.subObject = instance.object:newPart(client.intUUIDToString(client.generateUUID()), shouldSeeCamera and "Camera" or "None")
        instance.sprite = instance.subObject:newSprite(client.intUUIDToString(client.generateUUID()))
        instance.index = index
        instance.currentPos = pos:copy()
        instance.nextPos = instance.currentPos:copy()
        instance.currentRot = 0
        instance.nextRot = 0
        instance.velocity = velocity:copy()
        instance.rotVelocity = rotVelocity
        instance.size = size ~= nil and size or 0
        instance.scaleTracker = scaleTracker
        instance.speedFactor = speedFactor
        instance.lifetimeCount = lifetime

        instance.callbacks = {
            ---@param self ExSkillSprite
            onInit = function (self)
                self.sprite:setTexture(textures["textures.ex_skill_1"])
                self.sprite:setDimensions(16, 70)
                self.sprite:setRegion(11, 11)
                self.sprite:setUVPixels(0, 11 * (self.index - 1) + 10)
                self.sprite:setSize(vectors.vec2(1, 1):scale(self.size))
                self.object:setPos(self.currentPos:copy())
                self.sprite:setPos(vectors.vec2(1, 1):scale(self.size * 0.5):augmented(1))
            end;

            ---@param self ExSkillSprite
            onDeinit = function (self)
                self.subObject:removeTask(self.sprite:getName())
                self.object:removeChild(self.subObject)
                self.subObject:remove()
                self.target:removeChild(self.object)
                self.object:remove()
            end;

            ---@param self ExSkillSprite
            onTick = function (self)
                --パーティクル位置を強制更新
                if self.velocity:length() > 0 then
                    self.currentPos = self.nextPos:copy()
                    self.object:setPos(self.currentPos:copy())
                end
                if self.rotVelocity ~= 0 or self.scaleTracker ~= nil then
                    local trueScale = self.size * (self.scaleTracker ~= nil and self.scaleTracker:getAnimScale().x or 1)
                    self.currentRot = self.nextRot
                    self.sprite:setPos(trueScale / 2 * (math.cos(math.rad(self.currentRot + 45)) * math.sqrt(2)), trueScale / 2 * (math.sin(math.rad(self.currentRot + 45)) * math.sqrt(2)), 0)
                    self.sprite:setRot(0, 0, self.currentRot)
                end

                --カウンターを更新
                if self.lifetimeCount == 0 then
                    self.shouldDeinit = true
                end
                self.lifetimeCount = self.lifetimeCount - 1

                --次ティックの位置を計算
                if self.velocity:length() > 0 then
                    self.nextPos = self.currentPos:copy():add(self.velocity:copy():scale(0.05))
                end
                if self.rotVelocity ~= 0 then
                    self.nextRot = self.currentRot + self.rotVelocity * 0.05
                end
                if self.speedFactor ~= 1 then
                    self.velocity:scale(self.speedFactor)
                end
            end;

            ---@param self ExSkillSprite
            onRender = function (self, delta)
                if self.velocity:length() > 0 then
                    self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos))
                end
                if self.rotVelocity ~= 0 or self.scaleTracker ~= nil then
                    local actualRot = (self.nextRot - self.currentRot) * delta + self.currentRot
                    local trueScale = self.size * (self.scaleTracker ~= nil and self.scaleTracker:getAnimScale().x or 1)
                    self.sprite:setPos(trueScale / 2 * (math.cos(math.rad(actualRot + 45)) * math.sqrt(2)), trueScale / 2 * (math.sin(math.rad(actualRot + 45)) * math.sqrt(2)), 0)
                    self.sprite:setRot(0, 0, actualRot)
                    if self.scaleTracker ~= nil then
                        self.sprite:setScale(self.scaleTracker:getAnimScale().x, self.scaleTracker:getAnimScale().x, 1)
                    end
                end
            end;
        }

        return instance
    end;
}

return ExSkillSprite
