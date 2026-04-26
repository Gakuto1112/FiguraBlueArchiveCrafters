---@class (exact) Costume キャラクターのコスチュームを管理するクラス
---@field public isAltCostume boolean バリエーション衣装かどうか
---@field package changeAltCostumeAction Action キャラクターのバリエーション衣装を切り替えるアクション
local Costume = {
	isAltCostume = false;
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
					pings.costume_setAltCostume(true)
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
						pings.costume_setAltCostume(true)
						ActionWheel.setActionToggleHoverColor(action, true)
						sounds:playSound("minecraft:item.armor.equip_leather", player:getPos())
						Config.syncConfigs["isAltCostume"] = true
						Config:saveConfig("PRIVATE", "costume.is_alt_costume", true)
					end)
					:setOnUntoggle(function (_, action)
						pings.costume_setAltCostume(false)
						ActionWheel.setActionToggleHoverColor(action, false)
						sounds:playSound("minecraft:item.armor.equip_leather", player:getPos())
						Config.syncConfigs["isAltCostume"] = false
						Config:saveConfig("PRIVATE", "costume.is_alt_costume", false)
					end)
			else
				self.changeAltCostumeAction
					:setColor(0.16, 0.16, 0.16)
					:setOnToggle(function (_, action)
						action:setToggled(false)
						print(Locale:getLocalizedText("message.action_wheel.change_alt_costume.unavailable"))
						MiscUtils.playErrorSound()
					end)
			end
			ActionWheel:setAction(self.changeAltCostumeAction, 1)
		end

		if not isAltCostumeProcessed then
			HeadBlock:generateHeadBlockModel()
			Portrait:generatePortraitModel()
		end

		EventManager.events["ON_LOCALE_REFRESH"]:register(function ()
			if BlueArchiveCharacter.costume.isAltCostumeEnabled then
				self.changeAltCostumeAction
					:setTitle(Locale:getLocalizedText("action_wheel.main_page.change_alt_costume.title") .. "§c" .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
					:setToggleTitle(Locale:getLocalizedText("action_wheel.main_page.change_alt_costume.title") .. "§a" .. Locale:getLocalizedText("action_wheel.action.toggle_on"))
			else
				self.changeAltCostumeAction:setTitle("§8" .. Locale:getLocalizedText("action_wheel.main_page.change_alt_costume.title") .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
			end
		end)

		EventManager.events["ON_CONFIG_SYNC"]:register(function (configData)
			if configData["isAltCostume"] then
				self:setAltCostume(true)
			end
		end)
    end;

	---バリエーション衣装(通常衣装と少し異なる衣装、以前の「別衣装」ではない)を設定する。
	---@param self Costume
	---@param isAlt boolean `false`: 通常衣装, `true`: バリエーション衣装
	setAltCostume = function (self, isAlt)
		if BlueArchiveCharacter.costume.isAltCostumeEnabled and BlueArchiveCharacter.costume.callbacks ~= nil and BlueArchiveCharacter.costume.callbacks.onAltChange ~= nil then
			BlueArchiveCharacter.costume.callbacks.onAltChange(BlueArchiveCharacter, isAlt)
			HeadBlock:generateHeadBlockModel()
			Portrait:generatePortraitModel()
		end
		self.isAltCostume = isAlt
	end;
}

---バリエーション衣装を設定する。
---@param isAlt boolean `false`: 通常衣装, `true`: バリエーション衣装
function pings.costume_setAltCostume(isAlt)
	Costume:setAltCostume(isAlt)
end

return Costume
