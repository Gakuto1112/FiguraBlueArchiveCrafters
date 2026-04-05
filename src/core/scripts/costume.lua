---@class (exact) Costume キャラクターのコスチュームを管理するクラス
---@field package changeAltCostumeAction Action キャラクターのバリエーション衣装を切り替えるアクション
local Costume = {
	changeAltCostumeAction = nil;

	---初期化関数
    ---@param self Costume
    init = function (self)
		local isAltCostumeProcessed = false
		if host:isHost() then
			self.changeAltCostumeAction = ActionWheel:getToggleAction()
				:setItem("minecraft:leather_chestplate")

			if Config:loadConfig("PRIVATE", "costume.is_alt_costume", false) then
				if BlueArchiveCharacter.costume.isAltCostumeEnabled then
					self.setAltCostume(true)
					self.changeAltCostumeAction:setToggled(true)
					ActionWheel.setActionToggleHoverColor(self.changeAltCostumeAction, true)
					Config.syncConfigs["isAltCostume"] = true
					isAltCostumeProcessed = true
				else
					Config:saveConfig("PRIVATE", "costume.is_alt_costume", false)
				end
			end

			if BlueArchiveCharacter.costume.isAltCostumeEnabled then
				self.changeAltCostumeAction
					:setOnToggle(function (_, action)
						self.setAltCostume(true)
						ActionWheel.setActionToggleHoverColor(action, true)
						self:setChangeAltCostumeActionTitle()
						Config:saveConfig("PRIVATE", "costume.is_alt_costume", true)
					end)
					:setOnUntoggle(function (_, action)
						self.setAltCostume(false)
						ActionWheel.setActionToggleHoverColor(action, false)
						self:setChangeAltCostumeActionTitle()
						Config:saveConfig("PRIVATE", "costume.is_alt_costume", false)
					end)
			else
				self.changeAltCostumeAction
					:setColor(0.16, 0.16, 0.16)
					:setOnToggle(function (_, action)
						action:setToggled(false)
						print(Locale:getLocalizedText("action_wheel.main_page.change_alt_costume.unavailable"))
						MiscUtils.playErrorSound()
					end)
			end
			self:setChangeAltCostumeActionTitle()

			ActionWheel:setAction(self.changeAltCostumeAction, "MAIN", 1)
		end

		if not isAltCostumeProcessed then
			HeadBlock:generateHeadBlockModel()
			Portrait:generatePortraitModel()
		end

		EventManager.events["ON_LOCALE_REFRESH"]:register(function ()
			self:setChangeAltCostumeActionTitle()
		end)

		EventManager.events["ON_CONFIG_SYNC"]:register(function (configData)
			if configData["isAltCostume"] then
				self.setAltCostume(true)
			end
		end)
    end;

	---バリエーション衣装変更アクションのタイトルを更新する。
	---@param self Costume
	setChangeAltCostumeActionTitle = function (self)
		local text = ""
		if not BlueArchiveCharacter.costume.isAltCostumeEnabled then
			text = Locale:getLocalizedText("text_format.color_dark_gray")
		end
		text = text .. Locale:getLocalizedText("action_wheel.main_page.change_alt_costume.title")
		if BlueArchiveCharacter.costume.isAltCostumeEnabled then
			if ActionWheel.getToggleActionState(self.changeAltCostumeAction) then
				text = text .. " " .. Locale:getLocalizedText("text_format.color_green") .. Locale:getLocalizedText("action_wheel.action.toggle_on")
			else
				text = text .. " " .. Locale:getLocalizedText("text_format.color_red") .. Locale:getLocalizedText("action_wheel.action.toggle_off")
			end
		else
			text = text .. Locale:getLocalizedText("action_wheel.action.toggle_off")
		end
		self.changeAltCostumeAction:setTitle(text)
	end;

	---バリエーション衣装(通常衣装と少し異なる衣装、以前の「別衣装」ではない)を設定する。
	---@param isAlt boolean `false`: 通常衣装, `true`: バリエーション衣装
	setAltCostume = function (isAlt)
		if BlueArchiveCharacter.costume.isAltCostumeEnabled and BlueArchiveCharacter.costume.callbacks ~= nil and BlueArchiveCharacter.costume.callbacks.onAltChange ~= nil then
			BlueArchiveCharacter.costume.callbacks.onAltChange(BlueArchiveCharacter, isAlt)
			HeadBlock:generateHeadBlockModel()
			Portrait:generateHeadModel()
		end
	end;
}

---バリエーション衣装を設定する。
---@param isAlt boolean `false`: 通常衣装, `true`: バリエーション衣装
function pings.costume_setAltCostume(isAlt)
	Costume.setAltCostume(isAlt)
end

return Costume
