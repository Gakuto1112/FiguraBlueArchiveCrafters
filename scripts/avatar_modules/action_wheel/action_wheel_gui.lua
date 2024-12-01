---@class ActionWheelGui : AvatarModule アクションホイールに表示する追加のGUIを管理するクラス
---@field package isActionWheelOpenedPrev boolean 前ティックにアクションホイールを開けていたかどうか

ActionWheelGui = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return ActionWheelGui
    new = function (parent)
        ---@type ActionWheelGui
        local instance = Avatar.instantiate(ActionWheelGui, AvatarModule, parent)

        instance.isActionWheelOpenedPrev = false

        return instance
    end;

    ---初期化関数
    ---@param self ActionWheelGui
    init = function (self)
        AvatarModule.init(self)

        if host:isHost() then
            events.TICK:register(function ()
                local isActionWheelOpened = action_wheel:isEnabled()
                if isActionWheelOpened and not self.isActionWheelOpenedPrev then
                    models.models.action_wheel_gui.Gui:setVisible(true)

                    local windowSize = client:getScaledWindowSize()
                    models.models.action_wheel_gui.Gui.BubbleGuide:setPos(windowSize.x * -0.5 + 44, windowSize.y * -0.5 + 5, 0)
                    models.models.action_wheel_gui.Gui.ExSkillGuide:setPos(windowSize.x * -0.5 + 57, -21, 0)

                    local bubbleTitleTask = models.models.action_wheel_gui.Gui.BubbleGuide:getTask("action_wheel.gui.bubble_guide.title")
                    local goodEmojiTask = models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.GoodEmoji:getTask("bubble_guide.bubble_1.key_name")
                    local heartEmojiTask = models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.HeartEmoji:getTask("bubble_guide.bubble_2.key_name")
                    local noteEmojiTask = models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.NoteEmoji:getTask("bubble_guide.bubble_3.key_name")
                    local questionEmojiTask = models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.QuestionEmoji:getTask("bubble_guide.bubble_4.key_name")
                    local sweatEmojiTask = models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.SweatEmoji:getTask("bubble_guide.bubble_5.key_name")
                    local bubbleTitleWidth = client.getTextWidth(bubbleTitleTask:getText()) / 2 + 4
                    local bubbleWidth = bubbleTitleWidth + 6
                    goodEmojiTask:setText("§0"..self.parent.keyManager.keyMappings.bubble_1:getKeyName())
                    heartEmojiTask:setText("§0"..self.parent.keyManager.keyMappings.bubble_2:getKeyName())
                    noteEmojiTask:setText("§0"..self.parent.keyManager.keyMappings.bubble_3:getKeyName())
                    questionEmojiTask:setText("§0"..self.parent.keyManager.keyMappings.bubble_4:getKeyName())
                    sweatEmojiTask:setText("§0"..self.parent.keyManager.keyMappings.bubble_5:getKeyName())
                    local bubbleBodyWidth = client.getTextWidth(goodEmojiTask:getText()) / 2
                    bubbleBodyWidth = math.max(bubbleBodyWidth, client.getTextWidth(heartEmojiTask:getText()) / 2)
                    bubbleBodyWidth = math.max(bubbleBodyWidth, client.getTextWidth(noteEmojiTask:getText()) / 2)
                    bubbleBodyWidth = math.max(bubbleBodyWidth, client.getTextWidth(questionEmojiTask:getText()) / 2)
                    bubbleBodyWidth = math.max(bubbleBodyWidth, client.getTextWidth(sweatEmojiTask:getText()) / 2)
                    bubbleWidth = math.max(bubbleWidth, bubbleBodyWidth + 22)
                    bubbleWidth = math.max(bubbleWidth, 39)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.TitleBar:setPos((bubbleWidth - bubbleTitleWidth) / 2, 0, 0)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.TitleBar:setScale(bubbleTitleWidth, 1, 1)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.TitleCenter:setScale(bubbleWidth - 25, 1, 1)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.TitleLeft:setPos(bubbleWidth - 26, 0, 0)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.BodyTop:setScale(bubbleWidth, 1, 1)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.BodyBottomCenter:setScale(bubbleWidth - 39, 1, 1)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.BodyBottomLeft:setPos(bubbleWidth - 40, 0, 0)
                    models.models.action_wheel_gui.Gui.BubbleGuide.Emojis:setPos((bubbleWidth - (bubbleBodyWidth + 22)) / 2 + bubbleBodyWidth + 9, 0, 0)
                    bubbleTitleTask:setPos(bubbleWidth / 2, 0, 0)
                    goodEmojiTask:setPos(bubbleBodyWidth / -2 - 4, 1.5, 0)
                    heartEmojiTask:setPos(bubbleBodyWidth / -2 - 4, 1.5, 0)
                    noteEmojiTask:setPos(bubbleBodyWidth / -2 - 4, 1.5, 0)
                    questionEmojiTask:setPos(bubbleBodyWidth / -2 - 4, 1.5, 0)
                    sweatEmojiTask:setPos(bubbleBodyWidth / -2 - 4, 1.5, 0)

                    local exSkillTitleTask = models.models.action_wheel_gui.Gui.ExSkillGuide:getTask("action_wheel.gui.ex_skill_guide.title")
                    local exSkillBody1Task = models.models.action_wheel_gui.Gui.ExSkillGuide:getTask("action_wheel.gui.ex_skill_guide.body_1")
                    local exSkillBody2Task = models.models.action_wheel_gui.Gui.ExSkillGuide:getTask("action_wheel.gui.ex_skill_guide.body_2")
                    local exSkillTitleWidth = client.getTextWidth(exSkillTitleTask:getText()) / 2 + 4
                    local exSkillWidth = exSkillTitleWidth + 6
                    exSkillBody1Task:setText(self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill == nil and "§0§l\""..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.ex_skill_"..self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].exSkill..".name").."\"" or "§0§l\""..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.ex_skill_"..self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].exSkill..".name").."\"§r§0 - \""..self.parent.keyManager.keyMappings.ex_skill:getKeyName().."\"")
                    exSkillBody2Task:setText(self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill == nil and "§0"..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.key_pre")..self.parent.keyManager.keyMappings.ex_skill:getKeyName()..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.key_post") or "§0§l\""..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.ex_skill_"..self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill..".name").."\"§r§0 - \""..self.parent.keyManager.keyMappings.ex_skill_sub:getKeyName().."\"")
                    exSkillWidth = math.max(exSkillWidth, client.getTextWidth(exSkillBody1Task:getText()) / 2 + 10)
                    exSkillWidth = math.max(exSkillWidth, client.getTextWidth(exSkillBody2Task:getText()) / 2 + 10)
                    exSkillWidth = math.max(exSkillWidth, 39)
                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.TitleBar:setPos((exSkillWidth - exSkillTitleWidth) / 2, 0, 0)
                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.TitleBar:setScale(exSkillTitleWidth, 1, 1)
                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.TitleCenter:setScale(exSkillWidth - 25, 1, 1)
                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.TitleLeft:setPos(exSkillWidth - 26, 0, 0)
                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.BodyBottomCenter:setScale(exSkillWidth - 39, 1, 1)
                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.BodyBottomLeft:setPos(exSkillWidth - 40, 0, 0)
                    exSkillTitleTask:setPos(exSkillWidth / 2, 0, 0)
                    exSkillBody1Task:setPos(exSkillWidth / 2, -8, 0)
                    exSkillBody2Task:setPos(exSkillWidth / 2, -13, 0)
                elseif not isActionWheelOpened and self.isActionWheelOpenedPrev then
                    models.models.action_wheel_gui.Gui:setVisible(false)
                end
                self.isActionWheelOpenedPrev = isActionWheelOpened
            end)

            models.models.action_wheel_gui.Gui:setScale(2, 2, 2)
            local bubbleGuideTitle = models.models.action_wheel_gui.Gui.BubbleGuide:newText("action_wheel.gui.bubble_guide.title")
            bubbleGuideTitle:setScale(0.5, 0.5, 0.5)
            bubbleGuideTitle:setText(self.parent.locale:getLocale("action_wheel.gui.bubble_guide.title"))
            bubbleGuideTitle:setAlignment("CENTER")

            for _, keyNameText in ipairs({models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.GoodEmoji:newText("bubble_guide.bubble_1.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.HeartEmoji:newText("bubble_guide.bubble_2.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.NoteEmoji:newText("bubble_guide.bubble_3.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.QuestionEmoji:newText("bubble_guide.bubble_4.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.SweatEmoji:newText("bubble_guide.bubble_5.key_name")}) do
                keyNameText:setScale(0.5, 0.5, 0.5)
                keyNameText:setAlignment("CENTER")
            end

            local exSkillGuideTitle = models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel.gui.ex_skill_guide.title")
            exSkillGuideTitle:setScale(0.5, 0.5, 0.5)
            exSkillGuideTitle:setText(self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.title"))
            exSkillGuideTitle:setAlignment("CENTER")

            local exSkillGuideBody1 = models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel.gui.ex_skill_guide.body_1")
            exSkillGuideBody1:setPos(0, -8, 0)
            exSkillGuideBody1:setScale(0.5, 0.5, 0.5)
            exSkillGuideBody1:setAlignment("CENTER")

            local exSkillGuideBody2 = models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel.gui.ex_skill_guide.body_2")
            exSkillGuideBody2:setPos(0, -8, 0)
            exSkillGuideBody2:setScale(0.5, 0.5, 0.5)
            exSkillGuideBody2:setAlignment("CENTER")
        end
    end;
}