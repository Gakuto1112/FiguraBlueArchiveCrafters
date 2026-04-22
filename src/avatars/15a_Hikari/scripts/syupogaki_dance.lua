---@alias SyupogakiDance.DanceState
---| "NOT_STANDBY" # 非スタンバイ状態
---| "STANDBY" # スタンバイ状態
---| "PLAYING" # ダンス再生中

---@class (exact) SyupogakiDance シュポガキダンスを制御するクラス
---@field public danceState SyupogakiDance.DanceState シュポガキダンスの状態
---@field package isHost boolean このアバターが親かどうか
---@field package offsetPos Vector3 ダンスを行う位置のオフセット
---@field package rot number ダンスをする際のアバターの向き
---@field package targetPlayer string|nil 相手プレイヤーのUUID
---@field package waitTick integer スタンバイ時間を測るカウンター
---@field package animationTick integer ダンスアニメーションのタイミングを測るティック変数
---@field package isRotating boolean ダンスの回転パートかどうか
---@field package cameraAdjustCount integer カメラの補正トランジションのタイミングを測るティック変数
---@field package isTipShowed boolean ヒント表示をしたかどうか
---@field package canPlayDance fun(self: SyupogakiDance): boolean シュポガキダンスが再生可能か（スタンバイ可能か）を返す。
---@field public standby fun(self: SyupogakiDance) シュポガキダンスをスタンバイ状態にする。
---@field public stop fun(self: SyupogakiDance) シュポガキダンスを終了する（スタンバイ状態を含む）。
local SyupogakiDance = {
    danceState = "NOT_STANDBY";
    isHost = false;
    offsetPos = vectors.vec3();
    rot = 0;
    targetPlayer = nil;
    waitTick = -1;
    animationTick = -1;
    isRotating = false;
    cameraAdjustCount = -1;
    isTipShowed = false;

    ---初期化関数
    ---@param self SyupogakiDance
    init = function (self)
        if host:isHost() then
            KeyManager:register("syupogaki_dance", "Syupogaki Dance", "key.keyboard.v"):onPress(function ()
                if self:canPlayDance() and self.danceState == "NOT_STANDBY" then
                    pings.standbyDance()
                else
                    print(Locale:getLocalizedText("message.ex_skill.unavailable" .. (renderer:isFirstPerson() and "_firstperson" or "")))
                    MiscUtils.playErrorSound()
                end
            end)
        end

        avatar:store("FBAC_Hikari", true)
        avatar:store("dance_state", "NOT_STANDBY")
        avatar:store("dance_animation_time", 0)
        avatar:store("dance_pos", vectors.vec3())
        avatar:store("dance_rot", 0)
        avatar:store("target_player", "")
        avatar:store("dance_tick", -1)
    end;

    ---シュポガキダンスが再生可能か（スタンバイ可能か）を返す。
    ---@param self SyupogakiDance
    ---@return boolean canPlayDance シュポガキダンスが再生可能かどうか
    canPlayDance = function (self)
        local firstCheck = player:getPose() == "STANDING" and not player:isMoving() and player:isOnGround() and not player:isInWater() and not player:isInLava() and player:getFrozenTicks() == 0 and not renderer:isFirstPerson() and player:getSwingArm() == nil and player:getActiveItem().id == "minecraft:air" and ExSkill.transitionCount == 0
        if self.targetPlayer ~= nil then
            local targetVar = world.avatarVars()[self.targetPlayer]
            if targetVar ~= nil and targetVar.FBAC_Nozomi then
                return firstCheck and targetVar.dance_state ~= "NOT_STANDBY"
            else
                return false
            end
        else
            return firstCheck
        end
    end;

    ---シュポガキダンスをスタンバイ状態にする。
    ---@param self SyupogakiDance
    standby = function (self)
        animations["models.main"]["syupogaki_dance_standby"]:play()
        Physics:disable()
        avatar:store("dance_state", "STANDBY")
        Arms:setArmState("DEFAULT", "DEFAULT")
        sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 1, 0.5)

        ---既にスタンバイ状態である相手を検索
        ---ここで発見した場合、こちらが子になる。
        local playerPos = player:getPos()
        local playerFound = false
        for uuid, avatarVar in pairs(world.avatarVars()) do
            if avatarVar.FBAC_Nozomi and avatarVar.dance_state == "STANDBY" and avatarVar.dance_pos:copy():sub(playerPos):length() <= 2  then
                self.isHost = false
                self.danceState = "PLAYING"
                avatar:store("dance_state", "PLAYING")
                self.targetPlayer = uuid
                avatar:store("target_player", uuid)
                playerFound = true
                self.offsetPos = avatarVar.dance_pos:copy():sub(playerPos):scale(1 / 0.9375)
                self.rot = avatarVar.dance_rot
                animations["models.main"]["syupogaki_dance_standby"]:stop()
                animations["models.main"]["syupogaki_dance"]:play()
                renderer:setShadowRadius(0)
                self.cameraAdjustCount = 0
                events.RENDER:register(function (delta)
                    if self.danceState == "PLAYING" then
                        CameraManager.setCameraPivot(self.offsetPos:copy():scale(math.min(self.cameraAdjustCount + delta, 3) / 3))
                    else
                        CameraManager.setCameraPivot(self.offsetPos:copy():scale(math.max(self.cameraAdjustCount - delta + 1, 0) / 3))
                    end
                end, "syupogaki_dance_camera_render")
            end
        end
        if not playerFound then
            self.danceState = "STANDBY"
            avatar:store("dance_state", "STANDBY")
            avatar:store("dance_pos", playerPos)
            self.rot = player:getBodyYaw() % 360
            avatar:store("dance_rot", self.rot)
            self.waitTick = 0
            if host:isHost() and not self.isTipShowed then
                print(Locale:getLocalizedText("message.syupogaki_dance.tip"))
                self.isTipShowed = true
            end
        end

        events.TICK:register(function ()
            if not self:canPlayDance() then
                self:stop()
            end

            if self.danceState == "STANDBY" then
                ---相手が承認してくれるのを待つ。
                ---ここで発見した場合、こちらが親になる。
                for uuid, avatarVar in pairs(world.avatarVars()) do
                    if avatarVar.FBAC_Nozomi and avatarVar.target_player == player:getUUID()  then
                        self.isHost = true
                        self.danceState = "PLAYING"
                        avatar:store("dance_state", "PLAYING")
                        self.targetPlayer = uuid
                        self.waitTick = -1
                        animations["models.main"]["syupogaki_dance_standby"]:stop()
                        animations["models.main"]["syupogaki_dance"]:play()
                    end
                end

                FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 1, true)
                local anchorPos = player:getPos():add(0, 0.1, 0)
                local targetVar = world.avatarVars()[client:getViewer():getUUID()]
                if host:isHost() or (targetVar ~= nil and targetVar.FBAC_Nozomi) then
                    particles:newParticle("minecraft:happy_villager", anchorPos:copy():add(vectors.rotateAroundAxis((self.waitTick % 36) * 10, 0, 0, 2, 0, 1, 0))):setLifetime(27)
                end
                self.waitTick = self.waitTick + 1
            elseif self.danceState == "PLAYING" then
                local avatarVars = world.avatarVars()
                if self.isHost then
                    animations["models.main"]["syupogaki_dance"]:setTime(avatarVars[self.targetPlayer].dance_animation_time)
                    self.animationTick = avatarVars[self.targetPlayer].dance_tick
                else
                    self.animationTick = self.animationTick + 1
                    avatar:store("dance_animation_time", animations["models.main"]["syupogaki_dance"]:getTime())
                    avatar:store("dance_tick", self.animationTick)
                    self.cameraAdjustCount = math.min(self.cameraAdjustCount + 1, 3)
                end
            end

            if self.animationTick == 0 then
                FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 8, true)
            elseif self.animationTick == 8 then
                FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 2, true)
            elseif self.animationTick == 10 then
                FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", 20, true)
            elseif self.animationTick == 30 then
                FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", 2, true)
            elseif self.animationTick == 32 then
                FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 35, true)
            elseif self.animationTick == 67 then
                FaceParts:setEmotion("CLOSED2", "CLOSED2", "TRIANGLE", 2, true)
            elseif self.animationTick == 69 then
                FaceParts:setEmotion("CENTER", "NORMAL", "TRIANGLE", 20, true)
            elseif self.animationTick == 89 then
                FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 30, true)
                self.isRotating = true
            elseif self.animationTick == 116 then
                self.isRotating = false
            elseif self.animationTick == 119 then
                FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 37, true)
            elseif self.animationTick == 121 then
                local anchorPos = player:getPos():add(self.offsetPos):add(0, 1, 0)
                sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 1.5)
                for _ = 1, 20 do
                    local offset = vectors.vec3(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1)
                    particles:newParticle("minecraft:happy_villager", anchorPos:copy():add(offset)):setVelocity(offset:copy():scale(0.025)):setLifetime(35)
                end
            elseif self.animationTick == 156 then
                self:stop()
            end
        end, "syupogaki_dance_tick")

        events.RENDER:register(function (delta)
            local turnTableRot = models.models.main.SyupogakiTurnTable:getAnimRot().y
            local bodyYaw = player:getBodyYaw(delta)
            models.models.main:setPos(vectors.rotateAroundAxis(bodyYaw, self.offsetPos:copy():scale(16):mul(-1, 1, -1), 0, 1, 0))
            local animPos = models.models.main.Avatar:getAnimPos()
            models.models.main.Avatar:setPos(vectors.rotateAroundAxis(turnTableRot, animPos, 0, 1, 0):sub(animPos))
            models.models.main:setRot(0, bodyYaw + self.rot * -1 + turnTableRot, 0)
        end, "syupogaki_dance_render")

        events.DAMAGE:register(function ()
            self:stop()
        end, "syupogaki_dance_damage")
    end;

    ---シュポガキダンスを終了する（スタンバイ状態を含む）。
    ---@param self SyupogakiDance
    stop = function (self)
        events.TICK:remove("syupogaki_dance_tick")
        events.RENDER:remove("syupogaki_dance_render")
        events.DAMAGE:remove("syupogaki_dance_damage")
        for _, modelPart in ipairs({models.models.main, models.models.main.Avatar}) do
            modelPart:setPos()
        end
        models.models.main:setRot()
        for _, animationName in ipairs({"syupogaki_dance_standby", "syupogaki_dance"}) do
            animations["models.main"][animationName]:stop()
        end
        renderer:setShadowRadius()
        FaceParts:resetEmotion()
        Physics:enable()
        self.danceState = "NOT_STANDBY"
        avatar:store("dance_state", "NOT_STANDBY")
        avatar:store("dance_animation_time", 0)
        avatar:store("dance_pos", vectors.vec3())
        self.rot = 0
        avatar:store("dance_rot", 0)
        self.targetPlayer = nil
        avatar:store("target_player", "")
        self.waitTick = -1
        self.animationTick = -1
        avatar:store("dance_tick", -1)
        self.isRotating = false
        if Gun.currentGunPosition == "RIGHT" then
            Arms:setArmState("GUN_MAIN_HAND", "DEFAULT")
        elseif Gun.currentGunPosition == "LEFT" then
            Arms:setArmState("DEFAULT", "GUN_MAIN_HAND")
        end

        if not self.isHost then
            self.cameraAdjustCount = 2
            events.TICK:register(function ()
                if self.cameraAdjustCount == -1 then
                    events.TICK:remove("syupogaki_dance_camera_tick")
                    events.RENDER:remove("syupogaki_dance_camera_render")
                    self.offsetPos = vectors.vec3()
                end
                self.cameraAdjustCount = self.cameraAdjustCount - 1
            end, "syupogaki_dance_camera_tick")
        end

        self.isHost = false
    end;
}

---シュポガキダンスをスタンバイ状態にする。
function pings.standbyDance()
    SyupogakiDance:standby()
end

return SyupogakiDance
