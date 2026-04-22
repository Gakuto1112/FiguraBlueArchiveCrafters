---@class Drone クリエイティブ飛行に表示するドローンを制御するクラス
---@field public dronePosition Gun.GunPosition ドローンの位置
---@field package droneSound Sound|nil ドローンの飛行音
---@field package isMissileLaunchAllowed boolean ミサイル発射が許可されているかどうか
---@field package missileCoolDown integer ミサイル発射のクールダウン
---@field package didTipShow boolean ヒントを表示したかどうか
---@field public isFlying boolean クリエイティブ飛行中かどうか
---@field package isFlyingPrev boolean 前ティックにクリエイティブ飛行をしていたかどうか
---@field package shouldShowDronePrev boolean 前ティックにドローンが表示されていたかどうか
---@field package isLeftHandedPrev boolean 前ティックにプレイヤーが左利きだったかどうか
---@field package gunPositionPrev Gun.GunPosition 前ティックの銃の位置
local Drone = {
    dronePosition = "NONE";
    isMissileLaunchAllowed = false;
    missileCoolDown = 0;
    didTipShow = false;
    isFlying = false;
    isFlyingPrev = false;
    shouldShowDronePrev = false;
    isLeftHandedPrev = false;
    gunPositionPrev = "NONE";

    ---初期化関数
    ---@param self Drone
    init = function (self)
        KeyManager:register("missile_launch", "Launch Missile", "key.keyboard.v"):setOnPress(function ()
            if self.isMissileLaunchAllowed then
                if self.missileCoolDown == 0 then
                    pings.launchMissiles()
                    self.missileCoolDown = 200
                else
                    MiscUtils.playErrorSound()
                    print(Locale:getLocalizedText("message.drone.in_cool_down"):format(math.ceil(self.missileCoolDown / 20)))
                end
            end
        end)

        events.TICK:register(function ()
            local vehicle = player:getVehicle()
            local shouldShowDrone = self.isFlying and vehicle == nil and player:getPose() == "STANDING"
            if shouldShowDrone ~= self.shouldShowDronePrev then
                if shouldShowDrone then
                    models.models.ex_skill_1.Drone:moveTo(models.models.main.Avatar)
                    ModelAlias.alias.avatar.root.Drone:setVisible(true)
                    self.isLeftHandedPrev = player:isLeftHanded()
                    Gun:processGunTick()
                    self.gunPositionPrev = Gun.currentGunPosition
                    if self.gunPositionPrev == "RIGHT" or (self.gunPositionPrev == "NONE" and not self.isLeftHandedPrev) then
                        animations["models.main"]["creative_flying_transition_right"]:setSpeed(1)
                        animations["models.main"]["creative_flying_transition_right"]:play()
                        animations["models.ex_skill_1"]["creative_flying_start_right"]:play()
                        self.dronePosition = "RIGHT"
                    else
                        animations["models.main"]["creative_flying_transition_left"]:setSpeed(1)
                        animations["models.main"]["creative_flying_transition_left"]:play()
                        animations["models.ex_skill_1"]["creative_flying_start_left"]:play()
                        self.dronePosition = "LEFT"
                    end
                    if Gun.currentGunPosition == "RIGHT" then
                        Arms:setArmState("GUN_MAIN_HAND", "DRONE_HOLD")
                    elseif Gun.currentGunPosition == "LEFT" then
                        Arms:setArmState("DRONE_HOLD", "GUN_MAIN_HAND")
                    elseif self.dronePosition == "RIGHT" then
                        Arms:setArmState("DRONE", "DRONE_HOLD")
                    else
                        Arms:setArmState("DRONE_HOLD", "DRONE")
                    end

                    local particleAnchor = player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1 + 180, self.dronePosition == "RIGHT" and -0.40625 or 0.40625, 5.015625, 1.9375, 0, 1, 0))
                    for _ = 1, 30 do
                        particles:newParticle("minecraft:poof", particleAnchor:copy():add(math.random() * 2.4 - 1.2, math.random() * 1 - 0.5, (math.random() * 2.4 - 1.2)))
                    end
                    self.droneSound =  sounds:playSound("minecraft:entity.bee.loop", player:getPos():add(0, 3, 0), 0.1, 1, true)

                    local startCount = 0
                    events.TICK:register(function ()
                        if not client:isPaused() then
                            startCount = startCount + 1
                            self.droneSound:setPos(player:getPos():add(0, 3, 0))
                            if startCount == 5 then
                                events.TICK:remove("drone_tick_start")
                                for _, ctx in ipairs({"right", "left"}) do
                                    animations["models.main"]["creative_flying_transition_"..ctx]:stop()
                                    animations["models.ex_skill_1"]["creative_flying_start_"..ctx]:stop()
                                end
                                self.isLeftHandedPrev = player:isLeftHanded()
                                self.gunPositionPrev = Gun.currentGunPosition
                                if self.gunPositionPrev == "RIGHT" or (self.gunPositionPrev == "NONE" and not self.isLeftHandedPrev) then
                                    for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
                                        animations[animationModel]["creative_flying_right"]:play()
                                    end
                                    self.dronePosition = "RIGHT"
                                else
                                    for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
                                        animations[animationModel]["creative_flying_left"]:play()
                                    end
                                    self.dronePosition = "LEFT"
                                end
                                if not self.didTipShow and host:isHost() then
                                    print(Locale:getLocalizedText("message.drone.tip"):format(KeyManager.keyMappings["missile_launch"].keybind:getKeyName()))
                                    self.didTipShow = true
                                end
                                self.isMissileLaunchAllowed = true

                                events.TICK:register(function ()
                                    self.droneSound:setPos(player:getPos():add(0, 3, 0))
                                    local isLeftHanded = player:isLeftHanded()
                                    if (Gun.currentGunPosition == "RIGHT" or (Gun.currentGunPosition == "NONE" and not isLeftHanded)) and animations["models.main"]["creative_flying_left"]:getPlayState() == "PLAYING" then
                                        for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
                                            animations[animationModel]["creative_flying_right"]:play()
                                            animations[animationModel]["creative_flying_right"]:setTime(animations[animationModel]["creative_flying_left"]:getTime())
                                            animations[animationModel]["creative_flying_left"]:stop()
                                        end
                                        self.dronePosition = "RIGHT"
                                    elseif (Gun.currentGunPosition == "LEFT" or (Gun.currentGunPosition == "NONE" and isLeftHanded)) and animations["models.main"]["creative_flying_right"]:getPlayState() == "PLAYING" then
                                        for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
                                            animations[animationModel]["creative_flying_left"]:play()
                                            animations[animationModel]["creative_flying_left"]:setTime(animations[animationModel]["creative_flying_right"]:getTime())
                                            animations[animationModel]["creative_flying_right"]:stop()
                                        end
                                        self.dronePosition = "LEFT"
                                    end
                                    if isLeftHanded ~= self.isLeftHandedPrev and Gun.currentGunPosition == "NONE" then
                                        if isLeftHanded then
                                            Arms:setArmState("DRONE_HOLD", "DRONE")
                                        else
                                            Arms:setArmState("DRONE", "DRONE_HOLD")
                                        end
                                    end
                                    self.isLeftHandedPrev = isLeftHanded
                                    self.gunPositionPrev = Gun.currentGunPosition
                                end, "drone_tick")
                            end
                        end
                    end, "drone_tick_start")
                elseif ModelAlias.alias.avatar.root.Drone ~= nil then
                    for _, eventName in ipairs({"drone_tick_start", "drone_tick"}) do
                        events.TICK:remove(eventName)
                    end
                    for _, ctx in ipairs({"right", "left"}) do
                        animations["models.main"]["creative_flying_transition_"..ctx]:stop()
                        animations["models.ex_skill_1"]["creative_flying_start_"..ctx]:stop()
                        for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
                            animations[animationModel]["creative_flying_"..ctx]:stop()
                        end
                    end
                    if Gun.currentGunPosition == "RIGHT" or (Gun.currentGunPosition == "NONE" and not player:isLeftHanded()) then
                        animations["models.main"]["creative_flying_transition_right"]:setSpeed(-1)
                        animations["models.main"]["creative_flying_transition_right"]:play()
                        animations["models.ex_skill_1"]["creative_flying_end_right"]:play()
                        self.dronePosition = "RIGHT"
                    else
                        animations["models.main"]["creative_flying_transition_left"]:setSpeed(-1)
                        animations["models.main"]["creative_flying_transition_left"]:play()
                        animations["models.ex_skill_1"]["creative_flying_end_left"]:play()
                        self.dronePosition = "LEFT"
                    end
                    local endCount = 0
                    events.TICK:register(function ()
                        if not client:isPaused() then
                            endCount = endCount + 1
                            self.droneSound:setPos(player:getPos():add(0, 3, 0))
                            if endCount == 5 then
                                for _, eventName in ipairs({"drone_tick_end", "missile_launch_tick"}) do
                                    events.TICK:remove(eventName)
                                end
                                for _, modelPart in ipairs({ModelAlias.alias.avatar.root.Drone.LauncherRight.MissilesRight, ModelAlias.alias.avatar.root.Drone.LauncherLeft.MissilesLeft}) do
                                    for _, modelPart2 in ipairs(modelPart:getChildren()) do
                                        modelPart2:setVisible(true)
                                    end
                                end
                                ModelAlias.alias.avatar.root.Drone:moveTo(models.models.ex_skill_1)
                                models.models.ex_skill_1.Drone:setVisible(false)
                                local particleAnchor = player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1 + 180, self.dronePosition == "RIGHT" and -0.40625 or 0.40625, 5.015625, -1.9375, 0, 1, 0))
                                for _ = 1, 30 do
                                    particles:newParticle("minecraft:poof", particleAnchor:copy():add(math.random() * 2.4 - 1.2, math.random() * 1 - 0.5, (math.random() * 2.4 - 1.2)))
                                end
                                self.droneSound:stop()
                                self.dronePosition = "NONE"
                                if Gun.currentGunPosition == "RIGHT" then
                                    Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
                                elseif Gun.currentGunPosition == "LEFT" then
                                    Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
                                else
                                    Arms:setArmState("DEFAULT", "DEFAULT")
                                end
                            end
                        end
                    end, "drone_tick_end")
                end
                self.shouldShowDronePrev = shouldShowDrone
            end

            if host:isHost() then
                local isFlying = host:isFlying() and player:getGamemode() ~= "SPECTATOR"
                if isFlying ~= self.isFlyingPrev then
                    pings.setIsFlying(isFlying)
                    Config.syncConfigs["isFlying"] = isFlying
                    self.isFlyingPrev = isFlying
                end
                self.missileCoolDown = math.max(self.missileCoolDown - 1, 0)
            end
        end)

        EventManager.events["ON_CONFIG_SYNC"]:register(function (configData)
            configData["isFlying"] = self.isFlying
        end)
    end;
}

---クリエイティブ飛行フラグを設定する。
---@param isFlying boolean クリエイティブ飛行をしているかどうか
function pings.setIsFlying(isFlying)
    Drone.isFlying = isFlying
end

---ミサイルを発射する。
function pings.launchMissiles()
    if ModelAlias.alias.avatar.root.Drone ~= nil then
        FaceParts:setEmotion("NARROW_ANGRY", "NARROW_ANGRY", "ANGRY", 60, true)
        local launchCounter = 0
        if events.TICK:getRegisteredCount("missile_launch_tick") == 0 then
            events.TICK:register(function ()
                if launchCounter % 5 == 0 and launchCounter <= 35 then
                    local missileNum = math.floor(launchCounter / 5) + 1
                    local missileModel = missileNum <= 4 and ModelAlias.alias.avatar.root.Drone.LauncherRight.MissilesRight["Missile"..missileNum] or ModelAlias.alias.avatar.root.Drone.LauncherLeft.MissilesLeft["Missile"..(missileNum - 4)]
                    local lookDir = player:getLookDir()
                    DroneMissileManager:spawn(ModelUtils.getModelWorldPos(missileModel), vectors.vec3(math.deg(math.asin(lookDir.y)) * -1, math.deg(math.atan2(lookDir.z, lookDir.x)) * -1 + 90, 0))
                    missileModel:setVisible(false)
                    sounds:playSound("minecraft:entity.blaze.hurt", player:getPos(), 1, 1.5)
                elseif launchCounter == 135 then
                    events.TICK:remove("missile_launch_tick")
                    for _, modelPart in ipairs({ModelAlias.alias.avatar.root.Drone.LauncherRight.MissilesRight, ModelAlias.alias.avatar.root.Drone.LauncherLeft.MissilesLeft}) do
                        for _, modelPart2 in ipairs(modelPart:getChildren()) do
                            modelPart2:setVisible(true)
                        end
                    end
                    sounds:playSound("minecraft:block.dispenser.fail", player:getPos(), 1, 2)
                end
                if launchCounter % 5 <= 1 and launchCounter <= 36 then
                    for _, modelPart in ipairs({ModelAlias.alias.avatar.root.Drone.LauncherRight.LauncherBase, ModelAlias.alias.avatar.root.Drone.LauncherLeft.LauncherBase}) do
                        local anchorPos = ModelUtils.getModelWorldPos(modelPart)
                        local bodyYaw = player:getBodyYaw()
                        local particleDir = vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -0.25, 0, 1, 0)
                        if launchCounter % 5 == 0 then
                            for _ = 1, 5 do
                                particles:newParticle("minecraft:flame", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, 0, 0, 1, 0))):setVelocity(particleDir:copy():scale(2)):setLifetime(4)
                            end
                        end
                        for _ = 1, 5 do
                            particles:newParticle("minecraft:large_smoke", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, 0, 0, 1, 0))):setVelocity(particleDir)
                        end
                    end
                end
                launchCounter = launchCounter + 1
            end, "missile_launch_tick")
        end
    end
end

return Drone
