---@class ActionWheelGui アクションホイールに表示する追加のGUIを管理するクラス
local ActionWheelGui = {
    ---初期化関数
    ---@param self ActionWheelGui
    init = function (self)
        if host:isHost() then
            models.models.action_wheel_gui.Gui:setScale(2, 2, 2)
            for _, textTask in ipairs({models.models.action_wheel_gui.Gui.BubbleGuide:newText("action_wheel.gui.bubble_guide.title"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.GoodEmoji:newText("bubble_guide.bubble_1.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.HeartEmoji:newText("bubble_guide.bubble_2.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.NoteEmoji:newText("bubble_guide.bubble_3.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.QuestionEmoji:newText("bubble_guide.bubble_4.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.SweatEmoji:newText("bubble_guide.bubble_5.key_name"), models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel.gui.ex_skill_guide.title"), models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel.gui.ex_skill_guide.body_1"), models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel.gui.ex_skill_guide.body_2")}) do
                textTask:setScale(0.5, 0.5, 0.5)
                textTask:setAlignment("CENTER")
            end
            for i = 1, 3 do
                local textTask = models.models.action_wheel_gui.Gui.VersionDisplay:newText("action_wheel.gui.version_display.l"..i)
                textTask:setScale(0.25, 0.25, 0.25)
                textTask:setShadow(true)
                if i == 1 then
                    textTask:setText("Figura Blue Archive Characters (FBAC)")
                end
            end

			EventManager.events["ON_ACTION_WHEEL_OPEN"]:register(function ()
				models.models.action_wheel_gui.Gui:setVisible(true)

				local windowSize = client:getScaledWindowSize()
				models.models.action_wheel_gui.Gui.BubbleGuide:setPos(windowSize.x * -0.5 + 44, windowSize.y * -0.5 + 5, 0)
				models.models.action_wheel_gui.Gui.ExSkillGuide:setPos(windowSize.x * -0.5 + 57, -21, 0)
				models.models.action_wheel_gui.Gui.VersionDisplay:setPos(-0.75, -0.5, 0)

				local bubbleGuideTextTasks = {models.models.action_wheel_gui.Gui.BubbleGuide:getTask("action_wheel.gui.bubble_guide.title"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.GoodEmoji:getTask("bubble_guide.bubble_1.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.HeartEmoji:getTask("bubble_guide.bubble_2.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.NoteEmoji:getTask("bubble_guide.bubble_3.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.QuestionEmoji:getTask("bubble_guide.bubble_4.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.Emojis.SweatEmoji:getTask("bubble_guide.bubble_5.key_name")}
				for i = 2, #bubbleGuideTextTasks do
					bubbleGuideTextTasks[i]:setText("§0" .. KeyManager.keyMappings["bubble_"..(i - 1)].keybind:getKeyName())
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

				local versionDisplayTextTasks = {}
				for i = 1, 3 do
					table.insert(versionDisplayTextTasks, models.models.action_wheel_gui.Gui.VersionDisplay:getTask("action_wheel.gui.version_display.l"..i))
				end

				for i = 2, 3 do
					versionDisplayTextTasks[i]:setPos(0, (i - 1) * -2.25, 0)
				end

				self.setGuiText()
			end)

			EventManager.events["ON_ACTION_WHEEL_CLOSE"]:register(function ()
				models.models.action_wheel_gui.Gui:setVisible(false)
			end)

			EventManager.events["ON_LOCALE_REFRESH"]:register(function ()
				models.models.action_wheel_gui.Gui.BubbleGuide:getTask("action_wheel.gui.bubble_guide.title"):setText(Locale:getLocalizedText("action_wheel.gui.bubble_guide.title"))
				models.models.action_wheel_gui.Gui.ExSkillGuide:getTask("action_wheel.gui.ex_skill_guide.title"):setText(Locale:getLocalizedText("action_wheel.gui.ex_skill_guide.title"))
				self.setGuiText()
			end)
        end
    end;

	---Exスキルガイド・吹き出しエモートガイド上のテキストを更新する。
	setGuiText = function ()
		models.models.action_wheel_gui.Gui.ExSkillGuide:getTask("action_wheel.gui.ex_skill_guide.body_1"):setText((BlueArchiveCharacter.exSkill.secondary == nil and ("§0§l\"" .. Locale:getLocalizedText("ex_skill.primary_name") .. "\"") or ("§0§l\"" .. Locale:getLocalizedText("ex_skill.primary_name").."\"§r§0 - \"" .. KeyManager.keyMappings.ex_skill.keybind:getKeyName() .. "\"")))
		models.models.action_wheel_gui.Gui.ExSkillGuide:getTask("action_wheel.gui.ex_skill_guide.body_2"):setText(BlueArchiveCharacter.exSkill.secondary == nil and ("§0" .. Locale:getLocalizedText("action_wheel.gui.ex_skill_guide.key"):format(KeyManager.keyMappings.ex_skill.keybind:getKeyName())) or ("§0§l\"" .. Locale:getLocalizedText("ex_skill.secondary_name") .. "\"§r§0 - \"" .. KeyManager.keyMappings.ex_skill_sub.keybind:getKeyName().."\""))
	end;
}

return ActionWheelGui
