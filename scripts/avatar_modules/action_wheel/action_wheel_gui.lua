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

                    --models.models.action_wheel_gui.Gui.BubbleGuide.GoodEmoji:getTask("bubble_guide.bubble_1.key_name"):setText("§0"..self.parent.keyManager.keyMappings.bubble_1:getKeyName())
                    --models.models.action_wheel_gui.Gui.BubbleGuide.HeartEmoji:getTask("bubble_guide.bubble_2.key_name"):setText("§0"..self.parent.keyManager.keyMappings.bubble_2:getKeyName())
                    --models.models.action_wheel_gui.Gui.BubbleGuide.NoteEmoji:getTask("bubble_guide.bubble_3.key_name"):setText("§0"..self.parent.keyManager.keyMappings.bubble_3:getKeyName())
                    --models.models.action_wheel_gui.Gui.BubbleGuide.QuestionEmoji:getTask("bubble_guide.bubble_4.key_name"):setText("§0"..self.parent.keyManager.keyMappings.bubble_4:getKeyName())
                    --models.models.action_wheel_gui.Gui.BubbleGuide.SweatEmoji:getTask("bubble_guide.bubble_5.key_name"):setText("§0"..self.parent.keyManager.keyMappings.bubble_5:getKeyName())

                    models.models.action_wheel_gui.Gui.ExSkillGuide:getTask("action_wheel.gui.ex_skill_guide.body"):setText(self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill == nil and "§0§l\""..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.ex_skill_"..self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].exSkill..".name").."\"§r\n§0"..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.key_pre")..self.parent.keyManager.keyMappings.ex_skill:getKeyName()..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.key_post") or "§0§l\""..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.ex_skill_"..self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].exSkill..".name").."\"§r§0 - \""..self.parent.keyManager.keyMappings.ex_skill:getKeyName().."\"\n§l\""..self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.ex_skill_"..self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].subExSkill..".name").."\"§r§0 - \""..self.parent.keyManager.keyMappings.ex_skill_sub:getKeyName().."\"")
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

            for _, keyNameText in ipairs({models.models.action_wheel_gui.Gui.BubbleGuide.GoodEmoji:newText("bubble_guide.bubble_1.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.HeartEmoji:newText("bubble_guide.bubble_2.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.NoteEmoji:newText("bubble_guide.bubble_3.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.QuestionEmoji:newText("bubble_guide.bubble_4.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.SweatEmoji:newText("bubble_guide.bubble_5.key_name")}) do
                keyNameText:setPos(-15, 1.5, 0)
                keyNameText:setScale(0.5, 0.5, 0.5)
                keyNameText:setWidth(60)
                keyNameText:setAlignment("CENTER")
            end

            local exSkillGuideTitle = models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel.gui.ex_skill_guide.title")
            exSkillGuideTitle:setScale(0.5, 0.5, 0.5)
            exSkillGuideTitle:setText(self.parent.locale:getLocale("action_wheel.gui.ex_skill_guide.title"))
            exSkillGuideTitle:setAlignment("CENTER")

            local exSkillGuideBody = models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel.gui.ex_skill_guide.body")
            exSkillGuideBody:setPos(0, -8, 0)
            exSkillGuideBody:setScale(0.5, 0.5, 0.5)
            exSkillGuideBody:setAlignment("CENTER")
        end
    end;
}