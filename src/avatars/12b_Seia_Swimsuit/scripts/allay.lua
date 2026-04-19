---@class (exact) Allay お供のアレイを制御するクラス
---@field package isAllayEnabled boolean アレイ制御が有効かどうか
---@field package wasAllayEnabledPrev boolean 前ティックにアレイ制御が有効だったかどうか
---@field public perchCount integer アレイが頭に止まるまでのカウンター
---@field package currentPos Vector3 アレイの現在の位置
---@field package nextPos Vector3 アレイの次ティックの位置
---@field package currentRot number アレイの現在の角度
---@field package nextRot number アレイの次ティックの角度
local Allay = {
    isAllayEnabled = false;
    wasAllayEnabledPrev = false;
    perchCount = 0;
    currentPos = vectors.vec3();
    nextPos = vectors.vec3();
    currentRot = 0;
    nextRot = 0;

    ---初期化関数
    ---@param self Allay
    init = function (self)
        events.TICK:register(function ()
            self.isAllayEnabled = ExSkill.animationCount == -1
            if self.isAllayEnabled ~= self.wasAllayEnabledPrev then
                if self.isAllayEnabled then
                    --アレイ制御を有効化
                    events.TICK:register(function ()
                        if not client:isPaused() and self.isAllayEnabled and ModelAlias.alias.avatar.head.Allay ~= nil then
                            local playerPose = player:getPose()
                            if (not player:isMoving() or player:getVehicle() ~= nil) and playerPose ~= "FALL_FLYING" and playerPose ~= "SWIMMING" and playerPose ~= "SLEEPING" then
                                if self.perchCount <= 10 and self.perchCount > 0 then
                                    if self.perchCount == 10 then
                                        animations["models.allay"].allay_fly_start:setSpeed(-1)
                                    end
                                elseif self.perchCount == 0 then
                                    events.RENDER:remove("allay_fly_render")
                                    animations["models.allay"].allay_fly_loop:stop()
                                    animations["models.allay"].allay_perch_loop:play()
                                    ModelAlias.alias.avatar.head.Allay:setParentType("None")
                                    ModelAlias.alias.avatar.head.Allay:setPos(0, Armor.isArmorVisible.helmet and 33 or 32, 3)
                                    ModelAlias.alias.avatar.head.Allay:setRot()
                                end
                                self.perchCount = self.perchCount - 1
                            else
                                if self.perchCount <= 10 then
                                    animations["models.allay"].allay_fly_start:setSpeed(1)
                                    if self.perchCount <= 0 then
                                        animations["models.allay"].allay_perch_loop:stop()
                                        animations["models.allay"].allay_fly_loop:play()
                                        ModelAlias.alias.avatar.head.Allay:setParentType("World")
                                        self.currentPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.AllayAnchor)
                                        self.nextPos = self.currentPos:copy()
                                        local deltaPos = self.nextPos:copy():sub(self.currentPos)
                                        self.currentRot = math.deg(math.atan2(deltaPos.z, deltaPos.x)) * -1 - 90
                                        self.nextRot = self.currentRot
                                        ModelAlias.alias.avatar.head.Allay:setRot(0, player:getBodyYaw() * -1 + 180, 0)
                                        events.RENDER:register(function (delta)
                                            if not client:isPaused() and self.isAllayEnabled and ModelAlias.alias.avatar.head.Allay ~= nil then
                                                local pos = self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos)
                                                local playerPos = player:getPos(delta):add(0, 1.5, 0)
                                                local headRot = 0
                                                if playerPos.y - pos.y ~= 0 then
                                                    headRot = math.deg(math.atan2(playerPos.y - pos.y, math.sqrt(math.pow(playerPos.x - pos.x, 2) + math.pow(playerPos.z - pos.z, 2)))) * math.min(self.perchCount / 10, 1)
                                                end
                                                ModelAlias.alias.avatar.head.Allay:setPos(pos:scale(16))
                                                ModelAlias.alias.avatar.head.Allay:setRot(0, (self.nextRot - self.currentRot) * delta + self.currentRot, 0)
                                                ModelAlias.alias.avatar.head.Allay.AllayHead:setRot(headRot, 0, 0)
                                            end
                                        end, "allay_fly_render")
                                    end
                                end
                                self.perchCount = 60
                            end
                            if self.perchCount > 0 then
                                self.currentPos = self.nextPos:copy()
                                self.currentRot = self.nextRot
                                local playerPos = player:getPos()
                                if self.perchCount > 10 then
                                    self.nextPos = playerPos:copy():add(0, 2, 0):sub(self.currentPos):scale(0.2):add(self.currentPos)
                                    local deltaPos = self.nextPos:copy():sub(self.currentPos)
                                    self.nextRot = math.deg(math.atan2(deltaPos.z, deltaPos.x)) * -1 - 90
                                else
                                    self.nextPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.AllayAnchor):sub(self.currentPos):scale(0.2):add(self.currentPos)
                                    local lookDir = player:getLookDir()
                                    self.nextRot = math.deg(math.atan2(lookDir.z, lookDir.x)) * -1 - 90
                                end
                                animations["models.allay"].allay_fly_loop:setSpeed(1 + math.min(self.nextPos:copy():sub(self.currentPos):length(), 1) * 2)
                                local rotDelta = self.nextRot - self.currentRot
                                if rotDelta > 180 then
                                    self.nextRot = self.nextRot - 360
                                elseif rotDelta < -180 then
                                    self.nextRot = self.nextRot + 360
                                end
                                if math.abs(self.nextRot - self.currentRot) > 30 then
                                    if self.nextRot - self.currentRot >= 0 then
                                        self.nextRot = self.currentRot + 30
                                    else
                                        self.nextRot = self.currentRot - 30
                                    end
                                end
                                if playerPos:copy():sub(self.nextPos):length() < 1.5 then
                                    self.nextPos = playerPos:copy():sub(self.nextPos):normalize():scale(-1.5):add(playerPos)
                                end
                            end
                            ModelAlias.alias.avatar.head.Allay:setVisible(self.perchCount <= 0 or not renderer:isFirstPerson())
                        end
                    end, "allay_tick")
                    models.models.allay.Allay:moveTo(ModelAlias.alias.avatar.head)
                    models.models.allay:removeChild(ModelAlias.alias.avatar.head.Allay)
                    for _, animName in ipairs({"allay", "allay_fly_start"}) do
                        animations["models.allay"][animName]:play()
                    end
                    animations["models.allay"].allay_fly_start:setSpeed(-1)

                else
                    --アレイ制御を無効化
                    events.TICK:remove("allay_tick")
                    events.RENDER:remove("allay_fly_render")
                    for _, animName in ipairs({"allay", "allay_perch_loop", "allay_fly_start", "allay_fly_loop"}) do
                        animations["models.allay"][animName]:stop()
                    end
                    for _, animName in ipairs({"allay_fly_start", "allay_fly_loop"}) do
                        animations["models.allay"][animName]:setSpeed()
                    end
                    if ModelAlias.alias.avatar.head.Allay ~= nil then
                        ModelAlias.alias.avatar.head.Allay:moveTo(models.models.allay)
                        ModelAlias.alias.avatar.head:removeChild(models.models.allay.Allay)
                    end
                    models.models.allay.Allay:setVisible(false)
                    models.models.allay.Allay:setParentType("None")
                    models.models.allay.Allay:setPos()
                    models.models.allay.Allay:setRot()
                    models.models.allay.Allay.AllayHead:setRot()
                    self.perchCount = 0
                end
                self.wasAllayEnabledPrev = self.isAllayEnabled
            end
        end)
        models.models.allay.Allay:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/allay/allay.png")
    end;
}

return Allay
