---@alias Bubble.BubbleType
---| "NONE" # 絵文字なし
---| "GOOD" # 👍
---| "HEART" # 💗
---| "NOTE" # 🎵
---| "QUESTION" # ❓
---| "SWEAT" # 💦
---| "RELOAD" # 弾薬をリロードする絵文字
---| "DOTS" # …
---| "V" # ✌

---@class (exact) Bubble : AvatarModule 吹き出しエモートを管理するクラス
---@field public bubbleCount integer 吹き出しの表示時間を測るカウンター
---@field public emoji Bubble.BubbleType 吹き出しの絵文字
---@field package duration integer 吹き出しを表示する時間。-1は時間無制限を示す。
---@field package isAutoBubble boolean 吹き出しエモートが自動で出たものかどうか
---@field package shouldShowInHud boolean 一人称用にHUDに吹き出しを表示するかどうか
---@field package emojiAnimationCount number 絵文字のアニメーションのタイミングを測るカウンター
---@field package isForcedStop boolean 吹き出しエモートが強制停止させられたかどうか
---@field public isChatOpened boolean チャットを開けているかどうか
---@field package isChatOpenedPrev boolean 前ティックにチャットを開けていたかどうか
---@field package canShowBubble fun(self: Bubble): boolean 吹き出しエモートを表示できるかどうかを取得する
---@field public play fun(self: Bubble, type: Bubble.BubbleType, duration: integer, offsetPos: Vector2, offsetRot: number, shouldShowInHud: boolean) 吹き出しエモートを再生する
---@field public stop fun(self: Bubble) 吹き出しエモートを停止する

Bubble = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Bubble
    new = function (parent)
        ---@type Bubble
        local instance = Avatar.instantiate(Bubble, AvatarModule, parent)

        instance.bubbleCount = 0
        instance.emoji = "NONE"
        instance.duration = 0
        instance.isAutoBubble = false
        instance.shouldShowInHud = false
        instance.emojiAnimationCount = 0
        instance.isForcedStop = false
        instance.isChatOpened = false
        instance.isChatOpenedPrev = false

        return instance
    end;

    ---初期化関数
    ---@param self Bubble
    init = function (self)
        AvatarModule.init(self)

        models.models.bubble:addChild(models:newPart("Gui", "Gui"))
        models.models.bubble.Gui:addChild(models.models.bubble.Camera.AvatarBubble:copy("FirstPersonBubble"))
        models.models.bubble.Gui.FirstPersonBubble:setVisible(false)
        for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble, models.models.bubble.Gui.FirstPersonBubble}) do
            modelPart:setScale(0, 0, 0)
        end

        --エモートガイド
        if host:isHost() then
            self.parent.keyManager:register("bubble_1", "key.keyboard.j"):onPress(function ()
                if self:canShowBubble() then
                    pings.showBubbleEmote("GOOD")
                end
            end)
            self.parent.keyManager:register("bubble_2", "key.keyboard.k"):onPress(function ()
                if self:canShowBubble() then
                    pings.showBubbleEmote("HEART")
                end
            end)
            self.parent.keyManager:register("bubble_3", "key.keyboard.n"):onPress(function ()
                if self:canShowBubble() then
                    pings.showBubbleEmote("NOTE")
                end
            end)
            self.parent.keyManager:register("bubble_4", "key.keyboard.m"):onPress(function ()
                if self:canShowBubble() then
                    pings.showBubbleEmote("QUESTION")
                end
            end)
            self.parent.keyManager:register("bubble_5", "key.keyboard.comma"):onPress(function ()
                if self:canShowBubble() then
                    pings.showBubbleEmote("SWEAT")
                end
            end)
        end

        events.TICK:register(function ()
            if host:isHost() then
                local isChatOpened = host:isChatOpen()
                if isChatOpened ~= self.isChatOpened then
                    pings.setChatOpen(isChatOpened)
                end
                self.isChatOpenedPrev = isChatOpened
            end

            if player:getActiveItem().id == "minecraft:crossbow" then
                if self:canShowBubble() and self.emoji ~= "RELOAD" then
                    self:play("RELOAD", -1, vectors.vec2(), 0, false)
                    self.isAutoBubble = true
                end
            elseif self.isChatOpened and self.parent.exSkill.transitionCount == 0 and player:getPose() ~= "SLEEPING" then
                if self:canShowBubble() and self.emoji ~= "DOTS" then
                    self:play("DOTS", -1, vectors.vec2(), 0, false)
                    self.isAutoBubble = true
                end
            elseif self.isAutoBubble then
                self:stop()
                self.isAutoBubble = false
            end
        end)
    end;

    ---吹き出しエモートを表示できるかどうかを取得する。
    ---@param self Bubble
    ---@return boolean canShowBubble 吹き出しエモートを表示できるかどうか
    canShowBubble = function(self)
        local firstCheck = self.parent.exSkill.animationCount == -1 and (self.bubbleCount == 0 or self.isAutoBubble)
        if self.parent.characterData.bubble.callbacks ~= nil and self.parent.characterData.bubble.callbacks.addtionalCheckFunc ~= nil then
            return firstCheck and self.parent.characterData.bubble.callbacks.addtionalCheckFunc(self.parent.characterData)
        else
            return firstCheck
        end
    end;

    ---吹き出しエモートを再生する。
    ---@param self Bubble
    ---@param type Bubble.BubbleType 再生する絵文字の種類
    ---@param duration integer 吹き出しを表示している時間。-1にすると停止するまでずっと表示する。
    ---@param offsetPos Vector2 吹き出しの位置のオフセット値
    ---@param offsetRot number アバター周回上の、吹き出しが表示される位置のオフセット値
    ---@param shouldShowInHud boolean 一人称用にHUDに吹き出しを表示するかどうか
    play = function (self, type, duration, offsetPos, offsetRot, shouldShowInHud)
        self.emoji = type
        self.duration = duration
        self.shouldShowInHud = shouldShowInHud
        self.bubbleCount = 1
        self.emojiAnimationCount = 0
        models.models.bubble.Camera.AvatarBubble.Emoji:setPrimaryTexture("CUSTOM", textures["textures.emojis."..self.parent.stringUtils.lower(self.emoji)])
        models.models.bubble.Camera.AvatarBubble.Bullets:setVisible(self.emoji == "RELOAD")
        models.models.bubble.Camera.AvatarBubble.Dots:setVisible(self.emoji == "DOTS")
        if self.shouldShowInHud then
            models.models.bubble.Gui.FirstPersonBubble.Emoji:setPrimaryTexture("CUSTOM", textures["textures.emojis."..self.parent.stringUtils.lower(self.emoji)])
            sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:entity.item.pickup"), self.parent.modelUtils.getModelWorldPos(models.models.main.Avatar))
        end

        if events.TICK:getRegisteredCount("bubble_tick") == 0 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    models.models.bubble.Gui.FirstPersonBubble:setVisible(self.shouldShowInHud and renderer:isFirstPerson())
                    self.bubbleCount = self.bubbleCount + 1
                    if self.bubbleCount == 0 then
                        for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble, models.models.bubble.Gui.FirstPersonBubble, models.models.bubble.Camera.AvatarBubble.Bullets, models.models.bubble.Gui.FirstPersonBubble.Bullets}) do
                            modelPart:setVisible(false)
                        end
                        events.TICK:remove("bubble_tick")
                        events.RENDER:remove("bubble_render")
                        if self.parent.characterData.bubble.callbacks ~= nil and self.parent.characterData.bubble.callbacks.onStop ~= nil then
                            self.parent.characterData.bubble.callbacks.onStop(self.parent.characterData, type, self.isForcedStop)
                        end
                    elseif self.duration >= 0 and self.bubbleCount == self.duration + 2 then
                        self:stop()
                    end
                    if self.emoji == "RELOAD" or self.emoji == "DOTS" then
                        self.emojiAnimationCount = self.emojiAnimationCount + 1
                        self.emojiAnimationCount = self.emojiAnimationCount == 25 and 0 or self.emojiAnimationCount
                        if self.emoji == "DOTS" then
                            for i = 1, 3 do
                                models.models.bubble.Camera.AvatarBubble.Dots["Dot"..i]:setVisible(self.emojiAnimationCount >= 6 * i)
                            end
                        end
                    end
                end
            end, "bubble_tick")
        end

        if events.RENDER:getRegisteredCount("bubble_render") == 0 then
            events.RENDER:register(function (delta, context)
                models.models.bubble.Camera.AvatarBubble:setVisible(context ~= "OTHER")
                if not client:isPaused() then
                    local bubbleScale = math.min(math.abs(0.5 * (self.bubbleCount + delta)), 1)
                    models.models.bubble.Camera.AvatarBubble:setScale(vectors.vec3(1, 1, 1):scale(bubbleScale))
                    local playerPos = self.parent.modelUtils.getModelWorldPos(models.models.main.Avatar)
                    local avatarBubblePos = context == "PAPERDOLL" and vectors.vec3(0, 32, 0) or vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, playerPos:copy():sub(player:getPos(delta)):scale(17.067):add(0, 32 + offsetPos.y, 0), 0, 1, 0)
                    if not renderer:isFirstPerson() then
                        local cameraPos = client:getCameraPos()
                        avatarBubblePos:add(vectors.rotateAroundAxis(math.deg(math.atan2(cameraPos.z - playerPos.z, cameraPos.x - playerPos.x) - math.pi / 2) % 360 - (player:getBodyYaw(delta) + offsetRot) % 360, 12 + offsetPos.x, 0, 0, 0, -1, 0))
                    else
                        avatarBubblePos:add(12 + offsetPos.x, 0, 0)
                    end
                    models.models.bubble.Camera:setOffsetPivot(avatarBubblePos)
                    models.models.bubble.Camera.AvatarBubble:setPos(avatarBubblePos)
                    if host:isHost() and self.shouldShowInHud then
                        local windowSize = client:getScaledWindowSize()
                        models.models.bubble.Gui.FirstPersonBubble:setPos(-windowSize.x + 10, -windowSize.y + (action_wheel:isEnabled() and 125 or 10), 0)
                        models.models.bubble.Gui.FirstPersonBubble:setScale(vectors.vec3(1, 1, 1):scale(bubbleScale * 4))
                    end
                    if self.emoji == "RELOAD" then
                        local bullet1Counter = math.clamp((self.emojiAnimationCount + delta) * 0.2 - 1, 0, 1)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet1:setPos(0, 1 - bullet1Counter, 0)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet1:setOpacity(bullet1Counter)
                        local bullet2Counter = math.clamp((self.emojiAnimationCount + delta) * 0.2 - 2, 0, 1)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet2:setPos(0, 1 - bullet2Counter, 0)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet2:setOpacity(bullet2Counter)
                        local bullet3Counter = math.clamp((self.emojiAnimationCount + delta) * 0.2 - 3, 0, 1)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet3:setPos(0, 1 - bullet3Counter, 0)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet3:setOpacity(bullet3Counter)
                    end
                end
            end, "bubble_render")
        end
        if self.parent.characterData.bubble.callbacks ~= nil and self.parent.characterData.bubble.callbacks.onPlay ~= nil then
            self.parent.characterData.bubble.callbacks.onPlay(self.parent.characterData, type, duration, shouldShowInHud)
        end
    end;

    ---吹き出しエモートを停止する。
    ---@param self Bubble
    stop = function (self)
        self.emoji = "NONE"
        if self.bubbleCount > 0 then
            self.isForcedStop = self.duration == -1 or self.bubbleCount < self.duration + 2
            self.bubbleCount = -2
        end
    end;
}

---吹き出しエモートを表示する。
---@param type Bubble.BubbleType 表示する絵文字の種類
function pings.showBubbleEmote(type)
    AvatarInstance.bubble:play(type, 50, vectors.vec2(), 0, true)
    AvatarInstance.bubble.isAutoBubble = false
end

---Bubbleのチャットを開けているフラグを更新する。
---@param value boolean 新しい値
function pings.setChatOpen(value)
    AvatarInstance.bubble.isChatOpened = value
end