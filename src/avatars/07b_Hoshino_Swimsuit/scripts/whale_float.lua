---@class (exact) WhaleFloat クジラフロートを制御するクラス
---@field public whaleFloatEnabled boolean クジラフローに乗っているか
---@field package whaleFloatEnabledPrev boolean 前ティックにクジラフロートに乗っていたかどうか
---@field package lookDirPrev Vector3 前ティックに見ていた方法
---@field package eyeHeightOffset number クジラフローに乗っているときの視点の高さのオフセット値
---@field package whaleFloatAfkCount integer クジラフロート上でのAFKカウンター
---@field public isAFK boolean AFK中かどうか
local WhaleFloat = {
    whaleFloatEnabled = false;
    whaleFloatEnabledPrev = false;
    lookDirPrev = player:getLookDir();
    eyeHeightOffset = 0;
    whaleFloatAfkCount = 0;
    isAFK = false;

    ---AFKアニメーションを停止する。
    ---@param self WhaleFloat
    stopAfk = function (self)
        self.isAFK = false
        self.whaleFloatAfkCount = 0
        for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
            animations[animationModel]["float_afk"]:setSpeed(-1)
        end
        if ActionWheelConfig.isFpmCompatibilityMode and events.RENDER:getRegisteredCount("fpm_mode_render") == 0 then
            events.RENDER:register(ActionWheelConfig.fpmCompatibilityModeRender, "fpm_mode_render")
        end
        events.TICK:remove("whale_float_afk_end_tick")
        events.TICK:register(function ()
            if animations["models.main"]["float_afk"]:getTime() == 0 then
                for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
                    animations[animationModel]["float_afk"]:stop()
                end
                if Gun.currentGunPosition == "RIGHT" then
                    Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
                elseif Gun.currentGunPosition == "LEFT" then
                    Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
                else
                    Arms:setArmState("WHALE_FLOAT", "WHALE_FLOAT")
                end
                Physics:enable()
                events.TICK:remove("whale_float_afk_end_tick")
            end
        end, "whale_float_afk_end_tick")
    end;

    ---クジラフロートの表示を終了する（検出は停止しない）。
    ---@param self WhaleFloat
    stop = function (self)
        for _, eventName in ipairs({"whale_float_tick_2", "whale_float_afk_end_tick"}) do
            events.TICK:remove(eventName)
        end
        events.RENDER:remove("whale_float_render")
        ModelAlias.alias.avatar.lowerBody.WhaleFloat:setVisible(false)
        renderer:setRenderVehicle(true)
        ModelAlias.alias.avatar.head:setRot()
        if Gun.currentGunPosition == "RIGHT" then
            Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
        elseif Gun.currentGunPosition == "LEFT" then
            Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
        else
            Arms:setArmState("DEFAULT", "DEFAULT")
        end
        for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
            animations[animationModel]["float_ride"]:stop()
            animations[animationModel]["float_afk"]:stop()
        end
        animations["models.main"]["whale_float"]:stop()
        ModelAlias.alias.avatar.root:setPos()
        CameraManager.setCameraPivot(vectors.vec3())
        renderer:setEyeOffset()
        if ActionWheelConfig.isFpmCompatibilityMode and events.RENDER:getRegisteredCount("fpm_mode_render") > 0 then
            events.RENDER:register(ActionWheelConfig.fpmCompatibilityModeRender, "fpm_mode_render")
        end
        self.whaleFloatAfkCount = 0
        self.isAFK = false
        self.whaleFloatEnabled = false
        self.whaleFloatEnabledPrev = false
    end,

    ---クジラフローを有効にする。
    ---@param self WhaleFloat
    enable = function (self)
        events.TICK:register(function ()
            local vehicle = player:getVehicle()
            if vehicle ~= nil  then
                local entityId = vehicle:getType()
                self.whaleFloatEnabled = ActionWheelConfig.shouldReplaceVehicleModel and (entityId:match("^minecraft:[%l_]*boat$") or entityId:match("^minecraft:bamboo_[%l_]*raft$")) and #vehicle:getPassengers() == 1
                if self.whaleFloatEnabled then
                    if not self.whaleFloatEnabledPrev then
                        ModelAlias.alias.avatar.lowerBody.WhaleFloat:setVisible(true)
                        renderer:setRenderVehicle(false)
                        ModelAlias.alias.avatar.head:setRot(10, 0, 0)
                        if Gun.currentGunPosition == "RIGHT" then
                            Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
                        elseif Gun.currentGunPosition == "LEFT" then
                            Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
                        else
                            Arms:setArmState("WHALE_FLOAT", "WHALE_FLOAT")
                        end
                        for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
                            animations[animationModel]["float_ride"]:play()
                        end

                        events.TICK:register(function ()
                            if world.getBlockState(player:getPos()).id == "minecraft:water" then
                                animations["models.main"]["whale_float"]:setPlaying(true)
                                if Physics.velocityAverage[5][2] >= 0.35 then
                                    FaceParts:setEmotion("CLOSED", "CLOSED", "W", 1)
                                end
                                if Physics.velocityAverage[5][2] >= 0.1 then
                                    local bodyYaw = player:getBodyYaw()
                                    local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor1):add(vectors.rotateAroundAxis(bodyYaw * -1, 0.1875, 0, 0, 0, 1, 0))
                                    for _ = 1, 5 do
                                        local particleDirection = math.random() * 60 - 30
                                        particleDirection = particleDirection > 0 and particleDirection + 30 or particleDirection - 30
                                        particles:newParticle("minecraft:dust 1 1 1 1", anchorPos):setScale(3):setColor(1, 1, 1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + particleDirection + 150, vectors.vec3(1, 1, 1), 0, 1, 0):scale(math.random()):normalize():scale(Physics.velocityAverage[5][2])):setGravity(0.5):setLifetime(10)
                                    end
                                end

                                local vehicle2 = player:getVehicle()
                                if vehicle2 ~= nil then
                                    local gameVersion = client:getVersion()
                                    local isNewerID = StringUtils.compareVersions(gameVersion, "1.21.2")
                                    if (isNewerID and vehicle2:getType():match("^minecraft:bamboo_[%l_]*raft$")) or (not isNewerID and vehicle2:getNbt().Type == "bamboo") then
                                        ModelAlias.alias.avatar.root:setPos(0, -6, 0)
                                        if host:isHost() then
                                            self.eyeHeightOffset = 0.1875
                                        end
                                    else
                                        ModelAlias.alias.avatar.root:setPos()
                                        if host:isHost() then
                                            self.eyeHeightOffset = 0.5625
                                        end
                                    end
                                end
                            else
                                animations["models.main"]["whale_float"]:setPlaying(false)
                                local vehicle2 = player:getVehicle()
                                if vehicle2 ~= nil then
                                    local gameVersion = client:getVersion()
                                    local isNewerID = StringUtils.compareVersions(gameVersion, "1.21.2")
                                    if (isNewerID and vehicle2:getType():match("^minecraft:bamboo_[%l_]*raft$")) or (not isNewerID and vehicle2:getNbt().Type == "bamboo") then
                                        ModelAlias.alias.avatar.root:setPos(0, -9, 0)
                                        if host:isHost() then
                                            self.eyeHeightOffset = 0
                                        end
                                    else
                                        ModelAlias.alias.avatar.root:setPos(0, -3, 0)
                                        if host:isHost() then
                                            self.eyeHeightOffset = 0.375
                                        end
                                    end
                                end
                            end

                            local lookDir = player:getLookDir()
                            if not player:isMoving() and self.lookDirPrev:copy():sub(lookDir):length() == 0 and not player:isSwingingArm() and player:getActiveItem().id == "minecraft:air" then
                                self.whaleFloatAfkCount = self.whaleFloatAfkCount + 1
                                if self.whaleFloatAfkCount == 1200 then
                                    self.isAFK = true
                                    for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
                                        animations[animationModel]["float_afk"]:setSpeed(1)
                                        animations[animationModel]["float_afk"]:play()
                                    end
                                    Arms:setArmState("DEFAULT", "DEFAULT")
                                    Physics:disable()
                                elseif self.whaleFloatAfkCount >= 1230 then
                                    FaceParts:setEmotion("CLOSED2", "CLOSED2", "YAWN", 1, false)
                                end
                                if self.whaleFloatAfkCount >= 1200 and events.RENDER:getRegisteredCount("fpm_mode_render") > 0 then
                                    events.RENDER:remove("fpm_mode_render")
                                    ModelAlias.alias.avatar.head:setVisible(true)
                                    ModelAlias.alias.avatar.head:setOpacity(1)
                                end
                            else
                                if self.isAFK then
                                    self:stopAfk()
                                end
                                self.lookDirPrev = lookDir
                            end
                        end, "whale_float_tick_2")

                        events.RENDER:register(function (delta)
                            if host:isHost() and self.whaleFloatEnabled then
                                local offset = models.models.main.CameraAnchor:getAnimPos().y
                                local pos = vectors.rotateAroundAxis(player:getBodyYaw(delta) * -1, 0, self.eyeHeightOffset + offset / 16, 0.3, 0, 1, 0)
                                renderer:setOffsetCameraPivot(pos)
                                renderer:setEyeOffset(pos)
                            end
                        end, "whale_float_render")
                    end
                    self.whaleFloatEnabledPrev = true
                elseif self.whaleFloatEnabledPrev then
                    self:stop()
                end
            elseif self.whaleFloatEnabledPrev then
                self.whaleFloatEnabled = false
                self:stop()
            end
        end, "whale_float_tick")

        events.DAMAGE:register(function ()
            if self.isAFK then
                self:stopAfk()
            end
        end, "whale_float_damage")
    end;

    ---クジラフロートを無効にする。
    ---@param self WhaleFloat
    disable = function (self)
        events.TICK:remove("whale_float_tick")
        self:stop()
    end;
}

return WhaleFloat
