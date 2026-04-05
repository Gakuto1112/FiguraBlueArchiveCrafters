---@alias ExSkill.TransitionPhase
---| "PRE" # Exスキルアニメーション開始前
---| "POST" # Exスキルアニメーション終了後

---@class (exact) ExSkill Exスキルのアニメーションを管理するクラス
---@field package isSecondary boolean 再生中のExスキルがサブExスキルかどうか
---@field public animationCount integer Exスキルのアニメーション再生中に増加するカウンター。-1はアニメーション停止中を示す。
---@field package animationLength number Exスキルのアニメーションの長さ。スクリプトで自動で代入する。
---@field public transitionCount number Exスキルのアニメーション前後のカメラのトランジションの進捗を示すカウンター
---@field package keyPressCount integer Exスキルキーを押下し続ける時間を計るカウンター
---@field package bodyYaw number[] プレイヤーの体の回転
---@field public getCanPlayAnimation fun(self: ExSkill): boolean アニメーションが再生可能かどうかを返す
---@field package transition fun(self: ExSkill, direction: ExSkill.TransitionPhase, callback: fun()) Exスキルのアニメーションの前後のカメラのトランジションを行う関数
---@field public play fun(self: ExSkill, isSubExSkill: boolean) アニメーションを再生する
---@field public stop fun(self: ExSkill) アニメーションを停止する
---@field public forceStop fun(self: ExSkill) アニメーションを停止する。終了時のトランジションも無効。
local ExSkill = {
    isSecondary = false;
    animationCount = -1;
    animationLength = 0;
    transitionCount = 0;
    keyPressCount = 0;
    bodyYaw = {};

    ---初期化関数
    ---@param self ExSkill
    init = function (self)
        if host:isHost() then
            local exSkills = {BlueArchiveCharacter.exSkill.primary}
            if BlueArchiveCharacter.exSkill.secondary ~= nil then
                table.insert(exSkills, BlueArchiveCharacter.exSkill.secondary)
            end
            for _, exSkill in ipairs(exSkills) do
                local offset = (exSkill.camera.legacyMode ~= nil and exSkill.camera.legacyMode) and 1 or 0.9375
                exSkill.camera.start.pos:mul(-1, 1, 1):scale(1 / 16 * offset)
                exSkill.camera.fin.pos:mul(-1, 1, 1):scale(1 / 16 *  offset)
            end

            local exSkillKey = KeyManager:register("ex_skill", "key.keyboard.g")
            exSkillKey:setOnPress(function ()
                while events.TICK:getRegisteredCount("ex_skill_keypress_tick") > 0 do
                    events.TICK:remove("ex_skill_keypress_tick")
                end
                events.TICK:register(function ()
                    if self.keyPressCount == 30 then
                        events.TICK:remove("ex_skill_keypress_tick")
                        PlacementObjectManager:removeAll()
                        sounds:playSound("minecraft:entity.zombie.break_wooden_door", player:getPos(), 0.25, 2)
                        self.keyPressCount = 0
                        return
                    end
                    self.keyPressCount = self.keyPressCount + 1
                end, "ex_skill_keypress_tick")
            end)
            exSkillKey:setOnRelease(function ()
                events.TICK:remove("ex_skill_keypress_tick")
                if self.keyPressCount > 0 then
                    if self:getCanPlayAnimation() and self.transitionCount == 0 then
                        pings.exSkill_playExSkill(false)
                    else
                        print(Locale:getLocalizedText("message.ex_skill.unavailable" .. (renderer:isFirstPerson() and "_firstperson" or "")))
                        MiscUtils.playErrorSound()
                    end
                    self.keyPressCount = 0
                end
            end)
            KeyManager:register("ex_skill_sub", "key.keyboard.h"):setOnPress(function ()
                if self:getCanPlayAnimation() and self.transitionCount == 0 and BlueArchiveCharacter.exSkill.secondary ~= nil then
                    pings.exSkill_playExSkill(true)
                else
                    print(Locale:getLocalizedText(BlueArchiveCharacter.exSkill.secondary == nil and "message.ex_skill.unavailable_secondary" or ("message.ex_skill.unavailable" .. (renderer:isFirstPerson() and "_firstperson" or ""))))
                    MiscUtils.playErrorSound()
                end
            end)
        end

        table.insert(self.bodyYaw, player:getBodyYaw() % 360) --//TODO: 使わないなら消す

        events.TICK:register(function ()
            if not renderer:isFirstPerson() then
                table.insert(self.bodyYaw, player:getBodyYaw() % 360)
                if #self.bodyYaw == 3 then
                    table.remove(self.bodyYaw, 1)
                end
            end
        end)

        events.DAMAGE:register(function ()
            if self.animationCount >= 0 then
                self:forceStop()
            end
        end)
    end;

    ---アニメーションが再生可能かどうかを返す。
    ---@param self ExSkill
    ---@return boolean canPlayAnimation Exスキルアニメーションが再生可能かどうか
    getCanPlayAnimation = function (self)
        local firstCheck = player:getPose() == "STANDING" and not player:isMoving() and self.bodyYaw[1] == self.bodyYaw[2] and player:isOnGround() and not player:isInWater() and not player:isInLava() and player:getFrozenTicks() == 0 and not renderer:isFirstPerson() and player:getSwingArm() == nil and player:getActiveItem().id == "minecraft:air"
        if BlueArchiveCharacter.exSkill.callbacks ~= nil and BlueArchiveCharacter.exSkill.callbacks.additionalCheckFunc ~= nil then
            return firstCheck and BlueArchiveCharacter.exSkill.callbacks.additionalCheckFunc(BlueArchiveCharacter)
        else
            return firstCheck
        end
    end;

    ---Exスキルのアニメーションの前後のカメラのトランジションを行う関数
    ---@param self ExSkill
    ---@param direction ExSkill.TransitionPhase カメラのトランジションの向き
    ---@param callback fun() トランジション終了時に呼び出されるコールバック関数
    transition = function (self, direction, callback)
        events.TICK:register(function ()
            if not client:isPaused() then
                if events.TICK:getRegisteredCount("ex_skill_transition_tick") == 1 then
                    self.transitionCount = direction == "PRE" and math.min(self.transitionCount + 1, 10) or math.max(self.transitionCount - 1, 0)
                end
                if (direction == "PRE" and self.transitionCount == 10) or (direction == "POST" and self.transitionCount == 0) then
                    if host:isHost() then
                        local windowSize = client:getScaledWindowSize()
                        models.models.ex_skill_frame.Gui.FrameBar:setPos(0, 0, 0)
                        if direction == "PRE" then
                            for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTopLeft, models.models.ex_skill_frame.Gui.Frame.FrameTopRight, models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottomRight}) do
                                modelPart:setVisible(true)
                            end
                            models.models.ex_skill_frame.Gui.Frame.FrameTop:setPos(-windowSize.x + 16, -16)
                            models.models.ex_skill_frame.Gui.Frame.FrameTop:setScale(windowSize.x / 16 - 2, 1, 1)
                            models.models.ex_skill_frame.Gui.Frame.FrameLeft:setPos(-16, -windowSize.y + 16)
                            models.models.ex_skill_frame.Gui.Frame.FrameLeft:setScale(1, windowSize.y / 16 - 2, 1)
                            models.models.ex_skill_frame.Gui.Frame.FrameBottom:setPos(-windowSize.x + 16, -windowSize.y)
                            models.models.ex_skill_frame.Gui.Frame.FrameBottom:setScale(windowSize.x / 16 - 2, 1, 1)
                            models.models.ex_skill_frame.Gui.Frame.FrameRight:setPos(-windowSize.x, -windowSize.y + 16)
                            models.models.ex_skill_frame.Gui.Frame.FrameRight:setScale(1, windowSize.y / 16 - 2, 1)
                        elseif direction == "POST" then
                            for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTopLeft, models.models.ex_skill_frame.Gui.Frame.FrameTopRight, models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottomRight}) do
                                modelPart:setVisible(false)
                            end
                            for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTop, models.models.ex_skill_frame.Gui.Frame.FrameLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottom, models.models.ex_skill_frame.Gui.Frame.FrameRight}) do
                                modelPart:setScale(0, 0, 0)
                            end
                        end
                    end
                    callback()
                    events.TICK:remove("ex_skill_transition_tick")
                    events.RENDER:remove("ex_skill_transition_render")
                end
                if host:isHost() then
                    local barPos = models.models.ex_skill_frame.Gui.FrameBar:getPos().x * -1
                    local windowSizeY = client:getScaledWindowSize().y
                    if self.transitionCount >= 1 and self.transitionCount <= 9 then
                        for _ = 1, windowSizeY / 20 do
                            local particleOffset = math.random() * windowSizeY
                            ExSkillFrameParticleManager:spawn(vectors.vec2(barPos - particleOffset - math.random() * 50, particleOffset):scale(-1), vectors.vec2(500, 0))
                        end
                    end
                end
            end
        end, "ex_skill_transition_tick")

        if host:isHost() then
            events.RENDER:register(function (delta)
                --カメラのトランジション
                if not client:isPaused() and host:isHost() then
                    local lookDir = player:getLookDir()
                    local cameraRot = renderer:isCameraBackwards() and vectors.vec3(math.deg(math.asin(lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) + math.pi / 2)) or vectors.vec3(math.deg(math.asin(-lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) - math.pi / 2))
                    local targetCameraPos = vectors.vec3()
                    local targetCameraRot = vectors.vec3()
                    if direction == "PRE" then
                        targetCameraPos = vectors.rotateAroundAxis(self.bodyYaw[2] * -1 + 180, BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].camera.start.pos, 0, 1):add(0, -1.62)
                        targetCameraRot = BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].camera.start.rot:copy():add(0, self.bodyYaw[2], 0)
                    else
                        targetCameraPos = vectors.rotateAroundAxis(self.bodyYaw[2] * -1 + 180, BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].camera.fin.pos, 0, 1):add(0, -1.62)
                        targetCameraRot = BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].camera.fin.rot:copy():add(0, self.bodyYaw[2], 0)
                    end
                    if math.abs(cameraRot.y - targetCameraRot.y) >= 180 then
                        if cameraRot.y < targetCameraRot.y then
                            cameraRot.y = cameraRot.y + 360
                        else
                            targetCameraRot.y = targetCameraRot.y + 360
                        end
                    end
                    local trueDelta = direction == "PRE" and delta or delta * -1
                    CameraManager.setCameraPivot(targetCameraPos:scale((self.transitionCount + trueDelta) / 10))
                    CameraManager.setCameraRot(targetCameraRot:copy():sub(cameraRot):scale((self.transitionCount + trueDelta) / 10):add(cameraRot))
                    CameraManager:setThirdPersonCameraDistance(4 - (self.transitionCount + trueDelta) / 10 * 4)

                    --フレーム演出
                    local windowSize = client:getScaledWindowSize()
                    local barPos = (windowSize.x + windowSize.y + math.sqrt(2) * 16) * (direction == "PRE" and (self.transitionCount + trueDelta) / 10 or (1 - (self.transitionCount + trueDelta) / 10))
                    models.models.ex_skill_frame.Gui.FrameBar:setPos(-barPos, 0, 0)

                    local frameTopLength = math.clamp(barPos, 32, windowSize.x)
                    local frameLeftLength = math.clamp(barPos, 32, windowSize.y)
                    local frameBottomLength = math.clamp(barPos - windowSize.y + 16, 32, windowSize.x)
                    local frameRightLength = math.clamp(barPos - windowSize.x + 16, 32, windowSize.y)

                    models.models.ex_skill_frame.Gui.Frame.FrameTopLeft:setPos(-16, -16)
                    models.models.ex_skill_frame.Gui.Frame.FrameTopRight:setPos(-windowSize.x, -16)
                    models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft:setPos(-16, -windowSize.y)
                    models.models.ex_skill_frame.Gui.Frame.FrameBottomRight:setPos(-windowSize.x, -windowSize.y)
                    if direction == "PRE" then
                        models.models.ex_skill_frame.Gui.Frame.FrameTopLeft:setVisible(barPos >= 16)
                        models.models.ex_skill_frame.Gui.Frame.FrameTopRight:setVisible(barPos >= windowSize.x + 16)
                        models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft:setVisible(barPos >= windowSize.y + 16)
                        models.models.ex_skill_frame.Gui.Frame.FrameBottomRight:setVisible(barPos >= windowSize.x + windowSize.y)
                        models.models.ex_skill_frame.Gui.Frame.FrameTop:setPos(-frameTopLength + 16, -16)
                        models.models.ex_skill_frame.Gui.Frame.FrameTop:setScale(frameTopLength / 16 - 2, 1, 1)
                        models.models.ex_skill_frame.Gui.Frame.FrameLeft:setPos(-16, -frameLeftLength + 16)
                        models.models.ex_skill_frame.Gui.Frame.FrameLeft:setScale(1, frameLeftLength / 16 - 2, 1)
                        models.models.ex_skill_frame.Gui.Frame.FrameBottom:setPos(-frameBottomLength + 16, -windowSize.y)
                        models.models.ex_skill_frame.Gui.Frame.FrameBottom:setScale(frameBottomLength / 16 - 2, 1, 1)
                        models.models.ex_skill_frame.Gui.Frame.FrameRight:setPos(-windowSize.x, -frameRightLength + 16)
                        models.models.ex_skill_frame.Gui.Frame.FrameRight:setScale(1, frameRightLength / 16 - 2, 1)
                    else
                        models.models.ex_skill_frame.Gui.Frame.FrameTopLeft:setVisible(barPos < 16)
                        models.models.ex_skill_frame.Gui.Frame.FrameTopRight:setVisible(barPos < windowSize.x + 16)
                        models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft:setVisible(barPos < windowSize.y + 16)
                        models.models.ex_skill_frame.Gui.Frame.FrameBottomRight:setVisible(barPos < windowSize.x + windowSize.y)
                        models.models.ex_skill_frame.Gui.Frame.FrameTop:setPos(-windowSize.x + 16, -16)
                        models.models.ex_skill_frame.Gui.Frame.FrameTop:setScale((windowSize.x - frameTopLength) / 16, 1, 1)
                        models.models.ex_skill_frame.Gui.Frame.FrameLeft:setPos(-16, -windowSize.y + 16)
                        models.models.ex_skill_frame.Gui.Frame.FrameLeft:setScale(1, (windowSize.y - frameLeftLength) / 16, 1)
                        models.models.ex_skill_frame.Gui.Frame.FrameBottom:setPos(-windowSize.x + 16, -windowSize.y)
                        models.models.ex_skill_frame.Gui.Frame.FrameBottom:setScale((windowSize.x - frameBottomLength) / 16, 1, 1)
                        models.models.ex_skill_frame.Gui.Frame.FrameRight:setPos(-windowSize.x, -windowSize.y + 16)
                        models.models.ex_skill_frame.Gui.Frame.FrameRight:setScale(1, (windowSize.y - frameRightLength) / 16, 1)
                    end
                end
            end, "ex_skill_transition_render")
        end
    end;

    ---アニメーションを再生する。
    ---@param self ExSkill
    ---@param isSubExSkill boolean サブExスキルを再生するかどうか
    play = function (self, isSubExSkill)
        if host:isHost() then
            renderer:setFOV(70 / client:getFOV())
            renderer:setRenderHUD(false)
            CameraManager:setCameraCollisionDenial(true)
            models.models.ex_skill_frame.Gui:setColor(BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].formationType == "STRIKER" and vectors.vec3(1, 0.75, 0.75) or vectors.vec3(0.75, 1, 1))
            models.models.ex_skill_frame.Gui.FrameBar:setScale(1, client:getScaledWindowSize().y * math.sqrt(2) / 16 + 1, 1)
        end
        Bubble:stop()
        sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 5, 2)
        if BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks ~= nil and BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPreTransition ~= nil then
            BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPreTransition(BlueArchiveCharacter)
        end

        events.TICK:register(function ()
            if not self:getCanPlayAnimation() then
                self:forceStop()
            end
        end, "ex_skill_tick")

        self:transition("PRE", function ()
            Physics:disable()
            for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
                itemModel:setVisible(false)
            end
            for _, modelPart in ipairs(BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].models) do
                modelPart:setVisible(true)
            end
            for _, modelPart in ipairs(BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].animations) do
                animations["models."..modelPart]["ex_skill_" .. (self.isSecondary and "secondary" or "primary")]:play()
            end
            if host:isHost() then
                CameraManager:setThirdPersonCameraDistance(0)
            end
            if BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks ~= nil and BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPreAnimation ~= nil then
                BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPreAnimation(BlueArchiveCharacter)
            end

            events.TICK:register(function ()
                if not client:isPaused() then
                    if self.animationCount == self.animationLength - 1 then
                        self:stop()
                    elseif self:getCanPlayAnimation() and animations["models.main"]["ex_skill_" .. (self.isSecondary and "secondary" or "primary")]:isPlaying() then
                        if BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks ~= nil and BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onAnimationTick ~= nil then
                            BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onAnimationTick(BlueArchiveCharacter, self.animationCount)
                        end
                        self.animationCount = self.animationCount > -1 and self.animationCount + 1 or self.animationCount
                    end

                    if host:isHost() then
                        local windowSize = client:getScaledWindowSize()
                        local windowCenter = windowSize:copy():scale(0.5)
                        for _ = 1, (windowSize.x * 2 + windowSize.y * 2) / 100 do
                            local particlePos = vectors.vec2(math.random() * (windowSize.x * 2 + windowSize.y * 2), math.random() * 16)
                            particlePos = particlePos.x <= windowSize.x and particlePos or (particlePos.x <= windowSize.x + windowSize.y and vectors.vec2(windowSize.x - particlePos.y, particlePos.x - windowSize.x) or (particlePos.x <= windowSize.x * 2 + windowSize.y and vectors.vec2(particlePos.x - (windowSize.x + windowSize.y), windowSize.y - particlePos.y) or vectors.vec2(particlePos.y, particlePos.x - (windowSize.x * 2 + windowSize.y))))
                            ExSkillFrameParticleManager:spawn(particlePos:copy():scale(-1), windowCenter:copy():sub(particlePos):scale(0.25))
                        end
                    end
                end
            end, "ex_skill_animation_tick")

            if host:isHost() then
                events.RENDER:register(function ()
                    if not client:isPaused() then
                        CameraManager.setCameraPivot(vectors.rotateAroundAxis(self.bodyYaw[2] * -1 + 180, models.models.main.CameraAnchor:getAnimPos():scale(1 / 16 * ((BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].camera.legacyMode ~= nil and BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].camera.legacyMode) and 1 or 0.9375)), 0, 1, 0):add(0, -1.62, 0))
                        CameraManager.setCameraRot(models.models.main.CameraAnchor:getAnimRot():scale(-1):add(0, self.bodyYaw[2], 0))
                    end
                end, "ex_skill_animation_render")
            end
            self.animationCount = 0
            Gun:processGunTick()
            self.animationLength = math.round(animations["models.main"]["ex_skill_" .. (self.isSecondary and "secondary" or "primary")]:getLength() * 20)
        end)
    end;

    ---アニメーションを停止する。
    ---@param self ExSkill
    stop = function (self)
        events.TICK:remove("ex_skill_animation_tick")
        if host:isHost() then
            events.RENDER:remove("ex_skill_animation_render")
            sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 5, 2):setAttenuation(100)
        end
        for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
            itemModel:setVisible(true)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].models) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].animations) do
            animations["models."..modelPart]["ex_skill_" .. (self.isSecondary and "secondary" or "primary")]:stop()
        end
        Physics:enable()
        renderer:setFOV()
        self.animationCount = -1
        if BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks ~= nil and BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPostAnimation ~= nil then
            BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPostAnimation(BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"], false)
        end
        self:transition("POST", function ()
            events.TICK:remove("ex_skill_tick")
            if host:isHost() then
                CameraManager.setCameraPivot()
                CameraManager.setCameraRot()
                CameraManager:setThirdPersonCameraDistance(4)
                CameraManager:setCameraCollisionDenial(false)
                renderer:setRenderHUD(true)
            end
            if BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks ~= nil and BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPostTransition ~= nil then
                BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPostTransition(BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"], false)
            end
        end)
    end;

    ---アニメーションを停止する。終了時のトランジションも無効。
    ---@param self ExSkill
    forceStop = function (self)
        events.TICK:remove("ex_skill_transition_tick")
        events.RENDER:remove("ex_skill_transition_render")
        if host:isHost() then
            events.RENDER:remove("ex_skill_animation_render")
            models.models.ex_skill_frame.Gui.FrameBar:setPos()
            for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTopLeft, models.models.ex_skill_frame.Gui.Frame.FrameTopRight, models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottomRight}) do
                modelPart:setVisible(false)
            end
            for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTop, models.models.ex_skill_frame.Gui.Frame.FrameLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottom, models.models.ex_skill_frame.Gui.Frame.FrameRight}) do
                modelPart:setScale(0, 0, 0)
            end
            FaceParts:resetEmotion()
            CameraManager.setCameraPivot()
            CameraManager.setCameraRot()
            CameraManager:setThirdPersonCameraDistance(4)
            CameraManager:setCameraCollisionDenial(false)
            renderer:setRenderHUD(true)
            renderer:setFOV()
        end
        for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
            itemModel:setVisible(true)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].models) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].animations) do
            animations["models."..modelPart]["ex_skill_" .. (self.isSecondary and "secondary" or "primary")]:stop()
        end
        for _, eventName in ipairs({"ex_skill_tick", "ex_skill_animation_tick"}) do
            events.TICK:remove(eventName)
        end
        Physics:enable()
        if self.animationCount >= 0 and BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks ~= nil and BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPostAnimation ~= nil then
            BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPostAnimation(BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"], true)
        end
        if BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks ~= nil and BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPostTransition ~= nil then
            BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"].callbacks.onPostTransition(BlueArchiveCharacter.exSkill[self.isSecondary and "secondary" or "primary"], true)
        end
        self.animationCount = -1
        self.transitionCount = 0
    end;
}

---Exスキルを再生する。
---@param isSubExSkill boolean サブExスキルを再生するかどうか
function pings.exSkill_playExSkill(isSubExSkill)
    ExSkill:play(isSubExSkill)
end

return ExSkill
