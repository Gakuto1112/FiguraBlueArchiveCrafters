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
---@field public play fun(self: Bubble, type: Bubble.BubbleType, duration: integer, shouldShowInHud: boolean) 吹き出しエモートを再生する
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

        animations["models.bubble"].bubble_show:setSpeed(-1)
        animations["models.bubble"].bubble_show:play()

        models.models.bubble:addChild(models:newPart("Gui", "Gui"))
        local guiBubble = models.models.main.Avatar.UpperBody.Body.Bubble:copy("FirstPersonBubble")
        guiBubble:setScale(4, 4, 4)
        guiBubble:setPivot(6, 27, 0)
        guiBubble:setParentType("None")
        models.models.bubble.Gui:addChild(guiBubble)

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
                    self:play("RELOAD", -1, false)
                    self.isAutoBubble = true
                end
            elseif self.isChatOpened and self.parent.exSkill.transitionCount == 0 and player:getPose() ~= "SLEEPING" then
                if self:canShowBubble() and self.emoji ~= "DOTS" then
                    self:play("DOTS", -1, false)
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
        if self.parent.characterData.bubble.callbacks ~= nil and self.parent.characterData.bubble.callbacks.additionalCheckFunc ~= nil then
            return firstCheck and self.parent.characterData.bubble.callbacks.additionalCheckFunc(self.parent.characterData)
        else
            return firstCheck
        end
    end;

    ---吹き出しエモートを再生する。
    ---@param self Bubble
    ---@param type Bubble.BubbleType 再生する絵文字の種類
    ---@param duration integer 吹き出しを表示している時間。-1にすると停止するまでずっと表示する。
    ---@param shouldShowInHud boolean 一人称用にHUDに吹き出しを表示するかどうか
    play = function (self, type, duration, shouldShowInHud)
        self.emoji = type
        self.duration = duration
        self.shouldShowInHud = shouldShowInHud
        self.bubbleCount = 1
        self.emojiAnimationCount = 0
        models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner.Emoji:setPrimaryTexture("CUSTOM", textures["textures.emojis."..self.parent.stringUtils.lower(self.emoji)])
        models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner.Bullets:setVisible(self.emoji == "RELOAD")
        models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner.Dots:setVisible(self.emoji == "DOTS")
        animations["models.bubble"].bubble_show:setSpeed(1)
        models.models.main.Avatar.UpperBody.Body.Bubble:setVisible(true)
        if self.shouldShowInHud then
            sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:entity.item.pickup"), self.parent.modelUtils.getModelWorldPos(models.models.main.Avatar))
            models.models.bubble.Gui.FirstPersonBubble:setVisible(true)
        end

        if events.TICK:getRegisteredCount("bubble_tick") == 0 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    models.models.bubble.Gui.FirstPersonBubble:setVisible(self.shouldShowInHud and renderer:isFirstPerson())
                    self.bubbleCount = self.bubbleCount + 1
                    if self.bubbleCount == 0 then
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner, models.models.bubble.Gui.FirstPersonBubble, models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner.Bullets, models.models.bubble.Gui.FirstPersonBubble.Bullets}) do
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
                                models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner.Dots["Dot"..i]:setVisible(self.emojiAnimationCount >= 6 * i)
                            end
                        end
                    end
                end
            end, "bubble_tick")
        end

        if events.RENDER:getRegisteredCount("bubble_render") == 0 then
            events.RENDER:register(function (delta, context)
                models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner:setVisible(context ~= "OTHER")
                if not client:isPaused() then
                    if host:isHost() and self.shouldShowInHud then
                        local windowSize = client:getScaledWindowSize()
                        models.models.bubble.Gui.FirstPersonBubble:setPos(windowSize.x * -1, windowSize.y * -1 + (action_wheel:isEnabled() and 95 or -22), 0)
                    end
                    if self.emoji == "RELOAD" then
                        local bullet1Counter = math.clamp((self.emojiAnimationCount + delta) * 0.2 - 1, 0, 1)
                        models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner.Bullets.Bullet1:setPos(0, 1 - bullet1Counter, 0)
                        models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner.Bullets.Bullet1:setOpacity(bullet1Counter)
                        local bullet2Counter = math.clamp((self.emojiAnimationCount + delta) * 0.2 - 2, 0, 1)
                        models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner.Bullets.Bullet2:setPos(0, 1 - bullet2Counter, 0)
                        models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner.Bullets.Bullet2:setOpacity(bullet2Counter)
                        local bullet3Counter = math.clamp((self.emojiAnimationCount + delta) * 0.2 - 3, 0, 1)
                        models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner.Bullets.Bullet3:setPos(0, 1 - bullet3Counter, 0)
                        models.models.main.Avatar.UpperBody.Body.Bubble.BubbleInner.Bullets.Bullet3:setOpacity(bullet3Counter)
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
        animations["models.bubble"].bubble_show:setSpeed(-1)
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
    AvatarInstance.bubble:play(type, 50, true)
    AvatarInstance.bubble.isAutoBubble = false
end

---Bubbleのチャットを開けているフラグを更新する。
---@param value boolean 新しい値
function pings.setChatOpen(value)
    AvatarInstance.bubble.isChatOpened = value
end