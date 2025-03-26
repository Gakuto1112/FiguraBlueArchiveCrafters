---@alias ExSkill.TransitionPhase
---| "PRE" # Exスキルアニメーション開始前
---| "POST" # Exスキルアニメーション終了後

---@class (exact) ExSkill : AvatarModule Exスキルのアニメーションを管理するクラス
---@field public frameParticleAmount integer Exスキルフレームのパーティクルの量：1. 標準, 2. 少なめ, 3. なし, 4. Exスキルフレーム非表示、パーティクル量は標準
---@field package exSkillIndex integer 現在再生中のExスキルのインデックス番号
---@field public animationCount integer Exスキルのアニメーション再生中に増加するカウンター。-1はアニメーション停止中を示す。
---@field package animationLength number Exスキルのアニメーションの長さ。スクリプトで自動で代入する。
---@field public transitionCount number Exスキルのアニメーション前後のカメラのトランジションの進捗を示すカウンター
---@field package keyPressCount integer Exスキルキーを押下し続ける時間を計るカウンター
---@field package bodyYaw number[] プレイヤーの体の回転
---@field public canPlayAnimation fun(self: ExSkill): boolean アニメーションが再生可能かどうかを返す
---@field package transition fun(self: ExSkill, direction: ExSkill.TransitionPhase, callback: fun()) Exスキルのアニメーションの前後のカメラのトランジションを行う関数
---@field public play fun(self: ExSkill, isSubExSkill: boolean) アニメーションを再生する
---@field public stop fun(self: ExSkill) アニメーションを停止する
---@field public forceStop fun(self: ExSkill) アニメーションを停止する。終了時のトランジションも無効。

ExSkill = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return ExSkill
    new = function (parent)
        ---@type ExSkill
        local instance = Avatar.instantiate(ExSkill, AvatarModule, parent)

        instance.frameParticleAmount = instance.parent.config:loadConfig("PRIVATE", "exSkillFrameParticleAmount", 1)
        instance.exSkillIndex = 1
        instance.animationCount = -1
        instance.animationLength = 0
        instance.transitionCount = 0
        instance.keyPressCount = 0
        instance.bodyYaw = {}

        return instance
    end;

    ---初期化関数
    ---@param self ExSkill
    init = function (self)
        AvatarModule.init(self)

        if host:isHost() then
            for _, exSkill in ipairs(self.parent.characterData.exSkill) do
                local offset = (exSkill.camera.fixMode ~= nil and exSkill.camera.fixMode) and 1 or 0.9375
                exSkill.camera.start.pos:mul(-1, 1, 1):scale(1 / 16 * offset)
                exSkill.camera.fin.pos:mul(-1, 1, 1):scale(1 / 16 *  offset)
            end

            local exSkillKey = self.parent.keyManager:register("ex_skill", "key.keyboard.g")
            exSkillKey:setOnPress(function ()
                while events.TICK:getRegisteredCount("ex_skill_keypress_tick") > 0 do
                    events.TICK:remove("ex_skill_keypress_tick")
                end
                events.TICK:register(function ()
                    if self.keyPressCount == 30 then
                        events.TICK:remove("ex_skill_keypress_tick")
                        self.parent.placementObjectManager:removeAll()
                        sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:entity.zombie.break_wooden_door"), player:getPos(), 0.25, 2)
                        self.keyPressCount = 0
                    else
                        self.keyPressCount = self.keyPressCount + 1
                    end
                end, "ex_skill_keypress_tick")
            end)
            exSkillKey:setOnRelease(function ()
                events.TICK:remove("ex_skill_keypress_tick")
                if self.keyPressCount > 0 then
                    if self:canPlayAnimation() and self.animationCount == -1 then
                        pings.exSkill()
                    else
                        print(self.parent.locale:getLocale("key_bind.ex_skill.unavailable"..(renderer:isFirstPerson() and "_firstperson" or "")))
                        sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:block.note_block.bass"), player:getPos(), 1, 0.5)
                    end
                    self.keyPressCount = 0
                end
            end)
            self.parent.keyManager:register("ex_skill_sub", "key.keyboard.h"):setOnPress(function ()
                if self:canPlayAnimation() and self.animationCount == -1 and self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill ~= nil then
                    pings.subExSkill()
                else
                    print(self.parent.locale:getLocale(self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill == nil and "action_wheel.main.action_6.unavailable" or "key_bind.ex_skill.unavailable"..(renderer:isFirstPerson() and "_firstperson" or "")))
                    sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:block.note_block.bass"), player:getPos(), 1, 0.5)
                end
            end)
        end

        table.insert(self.bodyYaw, player:getBodyYaw() % 360)

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
    canPlayAnimation = function (self)
        return player:getPose() == "STANDING" and not player:isMoving() and self.bodyYaw[1] == self.bodyYaw[2] and player:isOnGround() and not player:isInWater() and not player:isInLava() and player:getFrozenTicks() == 0 and not renderer:isFirstPerson() and player:getSwingArm() == nil and player:getActiveItem().id == "minecraft:air" and not self.parent.costume.isChangingCostume
    end;

    ---Exスキルのアニメーションの前後のカメラのトランジションを行う関数
    ---@param self ExSkill
    ---@param direction ExSkill.TransitionPhase カメラのトランジションの向き
    ---@param callback fun() トランジション終了時に呼び出されるコールバック関数
    transition = function (self, direction, callback)
        events.TICK:register(function ()
            if not client:isPaused() then
                self.transitionCount = direction == "PRE" and math.min(self.transitionCount + 1, 10) or math.max(self.transitionCount - 1, 0)
                if (direction == "PRE" and self.transitionCount == 10) or (direction == "POST" and self.transitionCount == 0) then
                    if host:isHost() then
                        local windowSize = client:getScaledWindowSize()
                        models.models.ex_skill_frame.Gui.FrameBar:setPos(0, 0, 0)
                        if direction == "PRE" and self.frameParticleAmount < 4 then
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
                    if self.frameParticleAmount ~= 3 and self.transitionCount >= 1 and self.transitionCount <= 9 then
                        for _ = 1, windowSizeY / (self.frameParticleAmount == 2 and 100 or 20) do
                            local particleOffset = math.random() * windowSizeY
                            self.parent.frameParticleManager:spawn(vectors.vec2(barPos - particleOffset - math.random() * 50, particleOffset):scale(-1), vectors.vec2(500, 0))
                        end
                    end
                end
            end
        end, "ex_skill_transition_tick")

        if host:isHost() then
            events.RENDER:register(function (delta)
                --カメラのトランジション
                if not client:isPaused() then
                    local lookDir = player:getLookDir()
                    local cameraRot = renderer:isCameraBackwards() and vectors.vec3(math.deg(math.asin(lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) + math.pi / 2)) or vectors.vec3(math.deg(math.asin(-lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) - math.pi / 2))
                    local targetCameraPos = vectors.vec3()
                    local targetCameraRot = vectors.vec3()
                    if direction == "PRE" then
                        targetCameraPos = vectors.rotateAroundAxis(self.bodyYaw[2] * -1 + 180, self.parent.characterData.exSkill[self.exSkillIndex].camera.start.pos, 0, 1):add(0, -1.62)
                        targetCameraRot = self.parent.characterData.exSkill[self.exSkillIndex].camera.start.rot:copy():add(0, self.bodyYaw[2], 0)
                    else
                        targetCameraPos = vectors.rotateAroundAxis(self.bodyYaw[2] * -1 + 180, self.parent.characterData.exSkill[self.exSkillIndex].camera.fin.pos, 0, 1):add(0, -1.62)
                        targetCameraRot = self.parent.characterData.exSkill[self.exSkillIndex].camera.fin.rot:copy():add(0, self.bodyYaw[2], 0)
                    end
                    if math.abs(cameraRot.y - targetCameraRot.y) >= 180 then
                        if cameraRot.y < targetCameraRot.y then
                            cameraRot.y = cameraRot.y + 360
                        else
                            targetCameraRot.y = targetCameraRot.y + 360
                        end
                    end
                    local trueDelta = direction == "PRE" and delta or delta * -1
                    self.parent.cameraManager.setCameraPivot(targetCameraPos:scale((self.transitionCount + trueDelta) / 10))
                    self.parent.cameraManager.setCameraRot(targetCameraRot:copy():sub(cameraRot):scale((self.transitionCount + trueDelta) / 10):add(cameraRot))
                    self.parent.cameraManager:setThirdPersonCameraDistance(4 - (self.transitionCount + trueDelta) / 10 * 4)

                    --フレーム演出
                    local windowSize = client:getScaledWindowSize()
                    local barPos = (windowSize.x + windowSize.y + math.sqrt(2) * 16) * (direction == "PRE" and (self.transitionCount + trueDelta) / 10 or (1 - (self.transitionCount + trueDelta) / 10))
                    models.models.ex_skill_frame.Gui.FrameBar:setPos(-barPos, 0, 0)
                    if self.frameParticleAmount < 4 then
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
                end
            end, "ex_skill_transition_render")
        end
    end;

    ---アニメーションを再生する。
    ---@param self ExSkill
    ---@param isSubExSkill boolean サブExスキルを再生するかどうか
    play = function (self, isSubExSkill)
        if isSubExSkill and self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill ~= nil then
            self.exSkillIndex = self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill
        else
            self.exSkillIndex = self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].exSkill
        end
        if host:isHost() then
            renderer:setFOV(70 / client:getFOV())
            renderer:setRenderHUD(false)
            self.parent.cameraManager:setCameraCollisionDenial(true)
            models.models.ex_skill_frame.Gui:setColor(self.parent.characterData.exSkill[self.exSkillIndex].formationType == "STRIKER" and vectors.vec3(1, 0.75, 0.75) or vectors.vec3(0.75, 1, 1))
            models.models.ex_skill_frame.Gui.FrameBar:setScale(1, client:getScaledWindowSize().y * math.sqrt(2) / 16 + 1, 1)
        end
        self.parent.bubble:stop()
        sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:entity.player.levelup"), player:getPos(), 5, 2)
        if self.parent.characterData.exSkill[self.exSkillIndex].callbacks ~= nil and self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPreTransition ~= nil then
            self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPreTransition(self.parent.characterData)
        end

        events.TICK:register(function ()
            if not self:canPlayAnimation() then
                self:forceStop()
            end
        end, "ex_skill_tick")

        self:transition("PRE", function ()
            self.parent.physics:disable()
            for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
                itemModel:setVisible(false)
            end
            for _, modelPart in ipairs(self.parent.characterData.exSkill[self.exSkillIndex].models) do
                modelPart:setVisible(true)
            end
            for _, modelPart in ipairs(self.parent.characterData.exSkill[self.exSkillIndex].animations) do
                animations["models."..modelPart]["ex_skill_"..self.exSkillIndex]:play()
            end
            if self.parent.characterData.exSkill[self.exSkillIndex].callbacks ~= nil and self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPreAnimation ~= nil then
                self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPreAnimation(self.parent.characterData)
            end
            self.parent.cameraManager:setThirdPersonCameraDistance(0)

            events.TICK:register(function ()
                if not client:isPaused() then
                    if self.animationCount == self.animationLength - 1 then
                        self:stop()
                    elseif self:canPlayAnimation() and animations["models.main"]["ex_skill_"..self.exSkillIndex]:isPlaying() then
                        if self.parent.characterData.exSkill[self.exSkillIndex].callbacks ~= nil and self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onAnimationTick ~= nil then
                            self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onAnimationTick(self.parent.characterData, self.animationCount)
                        end
                        self.animationCount = self.animationCount + 1
                    end

                    if host:isHost() then
                        local windowSize = client:getScaledWindowSize()
                        local windowCenter = windowSize:copy():scale(0.5)
                        if self.frameParticleAmount < 3 then
                            for _ = 1, (windowSize.x * 2 + windowSize.y * 2) / (self.frameParticleAmount == 1 and 100 or 500) do
                                local particlePos = vectors.vec2(math.random() * (windowSize.x * 2 + windowSize.y * 2), math.random() * 16)
                                particlePos = particlePos.x <= windowSize.x and particlePos or (particlePos.x <= windowSize.x + windowSize.y and vectors.vec2(windowSize.x - particlePos.y, particlePos.x - windowSize.x) or (particlePos.x <= windowSize.x * 2 + windowSize.y and vectors.vec2(particlePos.x - (windowSize.x + windowSize.y), windowSize.y - particlePos.y) or vectors.vec2(particlePos.y, particlePos.x - (windowSize.x * 2 + windowSize.y))))
                                self.parent.frameParticleManager:spawn(particlePos:copy():scale(-1), windowCenter:copy():sub(particlePos):scale(0.25))
                            end
                        end
                    end
                end
            end, "ex_skill_animation_tick")

            if host:isHost() then
                events.RENDER:register(function ()
                    if not client:isPaused() then
                        self.parent.cameraManager.setCameraPivot(vectors.rotateAroundAxis(self.bodyYaw[2] * -1 + 180, models.models.main.CameraAnchor:getAnimPos():scale(1 / 16 * ((self.parent.characterData.exSkill[self.exSkillIndex].camera.fixMode ~= nil and self.parent.characterData.exSkill[self.exSkillIndex].camera.fixMode) and 1 or 0.9375)), 0, 1, 0):add(0, -1.62, 0))
                        self.parent.cameraManager.setCameraRot(models.models.main.CameraAnchor:getAnimRot():scale(-1):add(0, self.bodyYaw[2], 0))
                    end
                end, "ex_skill_animation_render")
            end
            self.parent.gun:processGunTick()
            self.animationLength = math.round(animations["models.main"]["ex_skill_"..self.exSkillIndex]:getLength() * 20)
        end)
        self.animationCount = 0
    end;

    ---アニメーションを停止する。
    ---@param self ExSkill
    stop = function (self)
        events.TICK:remove("ex_skill_animation_tick")
        if host:isHost() then
            events.RENDER:remove("ex_skill_animation_render")
            renderer:setFOV()
            sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:entity.player.levelup"), player:getPos(), 5, 2):setAttenuation(100)
        end
        for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
            itemModel:setVisible(true)
        end
        for _, modelPart in ipairs(self.parent.characterData.exSkill[self.exSkillIndex].models) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs(self.parent.characterData.exSkill[self.exSkillIndex].animations) do
            animations["models."..modelPart]["ex_skill_"..self.exSkillIndex]:stop()
        end
        self.parent.physics:enable()
        if self.parent.characterData.exSkill[self.exSkillIndex].callbacks ~= nil and self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPostAnimation ~= nil then
            self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPostAnimation(self.parent.characterData, false)
        end
        self:transition("POST", function ()
            events.TICK:remove("ex_skill_tick")
            if host:isHost() then
                self.parent.cameraManager.setCameraPivot()
                self.parent.cameraManager.setCameraRot()
                self.parent.cameraManager:setThirdPersonCameraDistance(4)
                self.parent.cameraManager:setCameraCollisionDenial(false)
                renderer:setRenderHUD(true)
            end
            if self.parent.characterData.exSkill[self.exSkillIndex].callbacks ~= nil and self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPostTransition ~= nil then
                self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPostTransition(self.parent.characterData, false)
            end
            self.animationCount = -1
        end)
        self.animationCount = 0
    end;

    ---アニメーションを停止する。終了時のトランジションも無効。
    ---@param self ExSkill
    forceStop = function (self)
        events.TICK:remove("ex_skill_transition_tick")
        if host:isHost() then
            for _, eventName in ipairs({"ex_skill_transition_render", "ex_skill_animation_render"}) do
                events.RENDER:remove(eventName)
            end
        end
        for _, eventName in ipairs({"ex_skill_tick", "ex_skill_animation_tick"}) do
            events.TICK:remove(eventName)
        end
        for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
            itemModel:setVisible(true)
        end
        for _, modelPart in ipairs(self.parent.characterData.exSkill[self.exSkillIndex].models) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs(self.parent.characterData.exSkill[self.exSkillIndex].animations) do
            animations["models."..modelPart]["ex_skill_"..self.exSkillIndex]:stop()
        end
        self.parent.physics:enable()
        if host:isHost() then
            models.models.ex_skill_frame.Gui.FrameBar:setPos()
            for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTopLeft, models.models.ex_skill_frame.Gui.Frame.FrameTopRight, models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottomRight}) do
                modelPart:setVisible(false)
            end
            for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTop, models.models.ex_skill_frame.Gui.Frame.FrameLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottom, models.models.ex_skill_frame.Gui.Frame.FrameRight}) do
                modelPart:setScale(0, 0, 0)
            end
            self.parent.faceParts:resetEmotion()
            self.parent.cameraManager.setCameraPivot()
            self.parent.cameraManager.setCameraRot()
            self.parent.cameraManager:setThirdPersonCameraDistance(4)
            self.parent.cameraManager:setCameraCollisionDenial(false)
            renderer:setRenderHUD(true)
            renderer:setFOV()
        end
        if self.animationCount >= 0 and self.parent.characterData.exSkill[self.exSkillIndex].callbacks ~= nil and self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPostAnimation ~= nil then
            self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPostAnimation(self.parent.characterData, true)
        end
        if self.parent.characterData.exSkill[self.exSkillIndex].callbacks ~= nil and self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPostTransition ~= nil then
            self.parent.characterData.exSkill[self.exSkillIndex].callbacks.onPostTransition(self.parent.characterData, true)
        end
        self.animationCount = -1
        self.transitionCount = 0
    end;
}

---Exスキルを再生する。
function pings.exSkill()
    AvatarInstance.exSkill:play(false)
end

---サブExスキルを再生する。
function pings.subExSkill()
    AvatarInstance.exSkill:play(true)
end