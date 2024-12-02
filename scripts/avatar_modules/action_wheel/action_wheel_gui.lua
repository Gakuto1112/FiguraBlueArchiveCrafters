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

                    local bubbleGuideTextTasks = {models.models.action_wheel_gui.Gui.BubbleGuide:getTask("action_wheel.gui.bubble_guide.title"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.GoodEmoji:getTask("bubble_guide.bubble_1.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.HeartEmoji:getTask("bubble_guide.bubble_2.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.NoteEmoji:getTask("bubble_guide.bubble_3.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.QuestionEmoji:getTask("bubble_guide.bubble_4.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.SweatEmoji:getTask("bubble_guide.bubble_5.key_name")}
                    bubbleGuideTextTasks[1]:setText(self.parent.locale:getLocale("action_wheel.gui.bubble_guide.title"))
                    for i = 2, #bubbleGuideTextTasks do
                        bubbleGuideTextTasks[i]:setText("§0"..self.parent.keyManager.keyMappings["bubble_"..(i - 1)]:getKeyName())
                    end

                    local bubbleGuideTitleWidth = client.getTextWidth(bubbleGuideTextTasks[1]:getText()) / 2 + 4
                    local bubbleGuideBodyWidth = 0
                    for i = 2, #bubbleGuideTextTasks do
                        bubbleGuideBodyWidth = math.max(bubbleGuideBodyWidth, client.getTextWidth(bubbleGuideTextTasks[i]:getText()) * 0.5)
                    end
                    local bubbleGuideWidth = math.max(bubbleGuideTitleWidth + 6, bubbleGuideBodyWidth + 22)
                    bubbleGuideWidth = math.max(bubbleGuideWidth, 39)

                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.TitleBar:setPos((bubbleGuideWidth - bubbleGuideTitleWidth) / 2, 0, 0)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.TitleBar:setScale(bubbleGuideTitleWidth, 1, 1)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.TitleCenter:setScale(bubbleGuideWidth - 25, 1, 1)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.TitleLeft:setPos(bubbleGuideWidth - 26, 0, 0)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.BodyTop:setScale(bubbleGuideWidth, 1, 1)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.BodyBottomCenter:setScale(bubbleGuideWidth - 39, 1, 1)
                    models.models.action_wheel_gui.Gui.BubbleGuide.BubbleGuideBackground.BodyBottomLeft:setPos(bubbleGuideWidth - 40, 0, 0)
                    models.models.action_wheel_gui.Gui.BubbleGuide.Emojis:setPos((bubbleGuideWidth - (bubbleGuideBodyWidth + 22)) / 2 + bubbleGuideBodyWidth + 9, 0, 0)
                    bubbleGuideTextTasks[1]:setPos(bubbleGuideWidth / 2, 0, 0)
                    for i = 2, #bubbleGuideTextTasks do
                        bubbleGuideTextTasks[i]:setPos(bubbleGuideBodyWidth / -2 - 4, 1.5, 0)
                    end

                    local exSkillGuideTextTasks = {models.models.action_wheel_gui.Gui.ExSkillGuide:getTask("action_wheel.gui.ex_skill_guide.title"), models.models.action_wheel_gui.Gui.ExSkillGuide:getTask("action_wheel.gui.ex_skill_guide.body_1"), models.models.action_wheel_gui.Gui.ExSkillGuide:getTask("action_wheel.gui.ex_skill_guide.body_2")}
                    exSkillGuideTextTasks[1]:setText(self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.title"))
                    exSkillGuideTextTasks[2]:setText(self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill == nil and "§0§l\""..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.ex_skill_"..self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].exSkill..".name").."\"" or "§0§l\""..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.ex_skill_"..self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].exSkill..".name").."\"§r§0 - \""..self.parent.keyManager.keyMappings.ex_skill:getKeyName().."\"")
                    exSkillGuideTextTasks[3]:setText(self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill == nil and "§0"..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.key_pre")..self.parent.keyManager.keyMappings.ex_skill:getKeyName()..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.key_post") or "§0§l\""..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.ex_skill_"..self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill..".name").."\"§r§0 - \""..self.parent.keyManager.keyMappings.ex_skill_sub:getKeyName().."\"")

                    local exSkillGuideTitleWidth = client.getTextWidth(exSkillGuideTextTasks[1]:getText()) / 2 + 4
                    local exSkillGuideWidth = exSkillGuideTitleWidth
                    for i = 2, #exSkillGuideTextTasks do
                        exSkillGuideWidth = math.max(exSkillGuideWidth, client.getTextWidth(exSkillGuideTextTasks[i]:getText()) / 2 + 10)
                    end
                    exSkillGuideWidth = math.max(exSkillGuideWidth, 39)

                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.TitleBar:setPos((exSkillGuideWidth - exSkillGuideTitleWidth) / 2, 0, 0)
                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.TitleBar:setScale(exSkillGuideTitleWidth, 1, 1)
                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.TitleCenter:setScale(exSkillGuideWidth - 25, 1, 1)
                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.TitleLeft:setPos(exSkillGuideWidth - 26, 0, 0)
                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.BodyBottomCenter:setScale(exSkillGuideWidth - 39, 1, 1)
                    models.models.action_wheel_gui.Gui.ExSkillGuide.ExSkillGuideBackground.BodyBottomLeft:setPos(exSkillGuideWidth - 40, 0, 0)
                    exSkillGuideTextTasks[1]:setPos(exSkillGuideWidth / 2, 0, 0)
                    for i = 2, #exSkillGuideTextTasks do
                        exSkillGuideTextTasks[i]:setPos(exSkillGuideWidth / 2, (i - 2) * -5 - 8)
                    end
                elseif not isActionWheelOpened and self.isActionWheelOpenedPrev then
                    models.models.action_wheel_gui.Gui:setVisible(false)
                end
                self.isActionWheelOpenedPrev = isActionWheelOpened
            end)

            models.models.action_wheel_gui.Gui:setScale(2, 2, 2)
            local bubbleGuideTitle = models.models.action_wheel_gui.Gui.BubbleGuide:newText("action_wheel.gui.bubble_guide.title")
            bubbleGuideTitle:setScale(0.5, 0.5, 0.5)
            bubbleGuideTitle:setText()
            bubbleGuideTitle:setAlignment("CENTER")

            for _, keyNameText in ipairs({models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.GoodEmoji:newText("bubble_guide.bubble_1.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.HeartEmoji:newText("bubble_guide.bubble_2.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.NoteEmoji:newText("bubble_guide.bubble_3.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.QuestionEmoji:newText("bubble_guide.bubble_4.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.SweatEmoji:newText("bubble_guide.bubble_5.key_name"), models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel.gui.ex_skill_guide.title"), models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel.gui.ex_skill_guide.body_1"), models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel.gui.ex_skill_guide.body_2")}) do
                keyNameText:setScale(0.5, 0.5, 0.5)
                keyNameText:setAlignment("CENTER")
            end
        end
    end;
}