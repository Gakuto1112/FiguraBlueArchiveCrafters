---@alias Bubble.BubbleType
---| "NONE" # 絵文字なし
---| "GOOD" # 👍
---| "HEART" # 💗
---| "NOTE" # 🎵
---| "QUESTION" # ❓
---| "SWEAT" # 💦
---| "RELOAD" # 弾薬をリロードする絵文字
---| "DOTS" # …

---@class (exact) Bubble 吹き出しエモートを管理するクラス
---@field public bubbleCount integer 吹き出しの表示時間を測るカウンター
---@field public emoji Bubble.BubbleType 吹き出しの絵文字
---@field package duration integer 吹き出しを表示する時間。-1は時間無制限を示す。
---@field package isAutoBubble boolean 吹き出しエモートが自動で出たものかどうか
---@field package shouldShowInHud boolean 一人称用にHUDに吹き出しを表示するかどうか
---@field package emojiAnimationCount number 絵文字のアニメーションのタイミングを測るカウンター
---@field package isForcedStop boolean 吹き出しエモートが強制停止させられたかどうか
---@field public isChatOpened boolean チャットを開けているかどうか
---@field package isChatOpenedPrev boolean 前ティックにチャットを開けていたかどうか
local Bubble = {
	bubbleCount = 0;
	emoji = "NONE";
	duration = 0;
	isAutoBubble = false;
	shouldShowInHud = false;
	emojiAnimationCount = 0;
	isForcedStop = false;
	isChatOpened = false;
	isChatOpenedPrev = false;

    ---初期化関数
    ---@param self Bubble
    init = function (self)
        animations["models.bubble"]["bubble_show"]:setSpeed(-1)

        models.models.bubble:addChild(models:newPart("Gui", "Gui"))
        local guiBubble = ModelAlias.alias.avatar.body.Bubble:copy("FirstPersonBubble")
        guiBubble:setScale(4, 4, 4)
        guiBubble:setPivot(6, 27, 0)
        guiBubble:setParentType("None")
        models.models.bubble.Gui:addChild(guiBubble)

        --エモートガイド
        if host:isHost() then
            KeyManager:register("bubble_1", "key.keyboard.j"):onPress(function ()
                if self:getCanShowBubble() then
                    pings.showBubbleEmote("GOOD")
                end
            end)
            KeyManager:register("bubble_2", "key.keyboard.k"):onPress(function ()
                if self:getCanShowBubble() then
                    pings.showBubbleEmote("HEART")
                end
            end)
            KeyManager:register("bubble_3", "key.keyboard.n"):onPress(function ()
                if self:getCanShowBubble() then
                    pings.showBubbleEmote("NOTE")
                end
            end)
            KeyManager:register("bubble_4", "key.keyboard.m"):onPress(function ()
                if self:getCanShowBubble() then
                    pings.showBubbleEmote("QUESTION")
                end
            end)
            KeyManager:register("bubble_5", "key.keyboard.comma"):onPress(function ()
                if self:getCanShowBubble() then
                    pings.showBubbleEmote("SWEAT")
                end
            end)
        end

        events.TICK:register(function ()
            if host:isHost() then
                local isChatOpened = host:isChatOpen()
                if isChatOpened ~= self.isChatOpened then
                    pings.setChatOpen(isChatOpened)
					Config.syncConfigs["isChatOpened"] = isChatOpened
					self.isChatOpenedPrev = isChatOpened
                end
            end

            if player:getActiveItem().id == "minecraft:crossbow" then
                if self:getCanShowBubble() and self.emoji ~= "RELOAD" then
                    self:play("RELOAD", -1, false)
                    self.isAutoBubble = true
                end
            elseif self.isChatOpened and ExSkill.transitionCount == 0 and player:getPose() ~= "SLEEPING" then
                if self:getCanShowBubble() and self.emoji ~= "DOTS" then
                    self:play("DOTS", -1, false)
                    self.isAutoBubble = true
                end
            elseif self.isAutoBubble then
                self:stop()
                self.isAutoBubble = false
            end
        end)

		EventManager.events["ON_CONFIG_SYNC"]:register(function (configData)
			if configData["isChatOpened"] then
				---@diagnostic disable-next-line: undefined-global
				Bubble.isChatOpened = true
			end
		end)
    end;

    ---吹き出しエモートを表示できるかどうかを取得する。
    ---@param self Bubble
    ---@return boolean canShowBubble 吹き出しエモートを表示できるかどうか
    getCanShowBubble = function(self)
        local firstCheck = ExSkill.animationCount == -1 and (self.bubbleCount == 0 or self.isAutoBubble)
        if BlueArchiveCharacter.bubble.callbacks ~= nil and BlueArchiveCharacter.bubble.callbacks.additionalCheckFunc ~= nil then
            return firstCheck and BlueArchiveCharacter.bubble.callbacks.additionalCheckFunc(BlueArchiveCharacter)
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
        ModelAlias.alias.avatar.body.Bubble.BubbleInner.Emoji:setPrimaryTexture("CUSTOM", textures["textures.emojis." .. StringUtils.lower(self.emoji)])
        ModelAlias.alias.avatar.body.Bubble.BubbleInner.Bullets:setVisible(self.emoji == "RELOAD")
        ModelAlias.alias.avatar.body.Bubble.BubbleInner.Dots:setVisible(self.emoji == "DOTS")
        animations["models.bubble"].bubble_show:setSpeed(1)
        ModelAlias.alias.avatar.body.Bubble:setVisible(true)
        if self.shouldShowInHud then
            if self.emoji == "NOTE" then
                sounds:playSound("minecraft:entity.experience_orb.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 1.5)
            else
                sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, self.emoji == "GOOD" and 1.2 or (self.emoji == "HEART" and 1.5 or (self.emoji == "SWEAT" and 0.75 or 1)))
            end
        end

        if events.TICK:getRegisteredCount("bubble_tick") == 0 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    models.models.bubble.Gui.FirstPersonBubble:setVisible(self.shouldShowInHud and renderer:isFirstPerson())
                    self.bubbleCount = self.bubbleCount + 1
                    if self.bubbleCount == 0 then
                        for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Bubble, models.models.bubble.Gui.FirstPersonBubble, ModelAlias.alias.avatar.body.Bubble.BubbleInner.Bullets, models.models.bubble.Gui.FirstPersonBubble.BubbleInner.Bullets}) do
                            modelPart:setVisible(false)
                        end
                        events.TICK:remove("bubble_tick")
                        events.RENDER:remove("bubble_render")
                        if BlueArchiveCharacter.bubble.callbacks ~= nil and BlueArchiveCharacter.bubble.callbacks.onStop ~= nil then
                            BlueArchiveCharacter.bubble.callbacks.onStop(BlueArchiveCharacter, type, self.isForcedStop)
                        end
                    elseif self.duration >= 0 and self.bubbleCount == self.duration + 2 then
                        self:stop()
                    end
                    if self.emoji == "RELOAD" or self.emoji == "DOTS" then
                        self.emojiAnimationCount = self.emojiAnimationCount + 1
                        self.emojiAnimationCount = self.emojiAnimationCount == 25 and 0 or self.emojiAnimationCount
                        if self.emoji == "DOTS" then
                            for i = 1, 3 do
                                ModelAlias.alias.avatar.body.Bubble.BubbleInner.Dots["Dot"..i]:setVisible(self.emojiAnimationCount >= 6 * i)
                            end
                        end
                    end
                end
            end, "bubble_tick")
        end

        if events.RENDER:getRegisteredCount("bubble_render") == 0 then
            events.RENDER:register(function (delta, context)
                ModelAlias.alias.avatar.body.Bubble.BubbleInner:setVisible(context ~= "OTHER")
                if not client:isPaused() then
                    if host:isHost() and self.shouldShowInHud then
                        local windowSize = client:getScaledWindowSize()
                        models.models.bubble.Gui.FirstPersonBubble:setPos(windowSize.x * -1, windowSize.y * -1 + (action_wheel:isEnabled() and 95 or -22), 0)
                    end
                    if self.emoji == "RELOAD" then
                        local bullet1Counter = math.clamp((self.emojiAnimationCount + delta) * 0.2 - 1, 0, 1)
                        ModelAlias.alias.avatar.body.Bubble.BubbleInner.Bullets.Bullet1:setPos(0, 1 - bullet1Counter, 0)
                        ModelAlias.alias.avatar.body.Bubble.BubbleInner.Bullets.Bullet1:setOpacity(bullet1Counter)
                        local bullet2Counter = math.clamp((self.emojiAnimationCount + delta) * 0.2 - 2, 0, 1)
                        ModelAlias.alias.avatar.body.Bubble.BubbleInner.Bullets.Bullet2:setPos(0, 1 - bullet2Counter, 0)
                        ModelAlias.alias.avatar.body.Bubble.BubbleInner.Bullets.Bullet2:setOpacity(bullet2Counter)
                        local bullet3Counter = math.clamp((self.emojiAnimationCount + delta) * 0.2 - 3, 0, 1)
                        ModelAlias.alias.avatar.body.Bubble.BubbleInner.Bullets.Bullet3:setPos(0, 1 - bullet3Counter, 0)
                        ModelAlias.alias.avatar.body.Bubble.BubbleInner.Bullets.Bullet3:setOpacity(bullet3Counter)
                    end
                end
            end, "bubble_render")
        end
        if BlueArchiveCharacter.bubble.callbacks ~= nil and BlueArchiveCharacter.bubble.callbacks.onPlay ~= nil then
            BlueArchiveCharacter.bubble.callbacks.onPlay(BlueArchiveCharacter, type, duration, shouldShowInHud)
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
    Bubble:play(type, 50, true)
    Bubble.isAutoBubble = false
end

---Bubbleのチャットを開けているフラグを更新する。
---@param value boolean 新しい値
function pings.setChatOpen(value)
    Bubble.isChatOpened = value
end

return Bubble
