---@class (exact) ActionWheelConfig アクションホイールで設定するアバター設定の管理を行うクラス
---@field package page Page アクションホイールのアバター設定ページのインスタンス
---@field package openAvatarConfigAction Action アクションホイールでアバター設定ページを開くアクション
---@field package vehicleVisibilityAction Action 乗り物モデルの置き換えオプションのトグルアクション
---@field public shouldReplaceVehicleModel boolean 乗り物のモデルを置き換えるべきかどうか
local ActionWheelConfig = {
	page = action_wheel:newPage("config");
	openAvatarConfigAction = nil;
	customVehicleVisibilityAction = nil;

	shouldReplaceVehicleModel = true;

	---初期化関数
	---@param self ActionWheelConfig
	init = function (self)
		if host:isHost() then
			self.openAvatarConfigAction = ActionWheel:getAction()
				:setItem("minecraft:comparator")
				:setOnLeftClick(function (action)
					action_wheel:setPage(self.page)
				end)
			ActionWheel:setAction(self.openAvatarConfigAction, 4)

			--　アクション1. 乗り物モデルの置き換え
			self.vehicleVisibilityAction = ActionWheel.getToggleAction()
				:setItem("minecraft:oak_boat")

			self.shouldReplaceVehicleModel = Config:loadConfig("PRIVATE", "action_wheel_config.is_vehicle_replacement_enabled", true)
			if self.shouldReplaceVehicleModel then
				if BlueArchiveCharacter.actionWheelConfig.isVehicleReplacementEnabled then
					pings.actionWheelConfig_setVehicleReplacement(true)
					self.vehicleVisibilityAction:setToggled(true)
					ActionWheel.setActionToggleHoverColor(self.vehicleVisibilityAction, true)
					Config.syncConfigs["isVehicleReplacementEnabled"] = true
				else
					self.shouldReplaceVehicleModel = false
				end
			elseif not BlueArchiveCharacter.actionWheelConfig.isVehicleReplacementEnabled then
				Config:saveConfig("PRIVATE", "action_wheel_config.is_vehicle_replacement_enabled", true)
			end

			if BlueArchiveCharacter.actionWheelConfig.isVehicleReplacementEnabled then
				self.vehicleVisibilityAction
					:setOnToggle(function (_, action)
						pings.actionWheelConfig_setVehicleReplacement(true)
						ActionWheel.setActionToggleHoverColor(action, true)
						Config:saveConfig("PRIVATE", "action_wheel_config.is_vehicle_replacement_enabled", true)
					end)
					:setOnUntoggle(function (_, action)
						pings.actionWheelConfig_setVehicleReplacement(false)
						ActionWheel.setActionToggleHoverColor(action, false)
						Config:saveConfig("PRIVATE", "action_wheel_config.is_vehicle_replacement_enabled", false)
					end)
			else
				self.vehicleVisibilityAction
					:setColor(0.16, 0.16, 0.16)
					:setOnToggle(function (_, action)
						action:setToggled(false)
						print(Locale:getLocalizedText("message.action_wheel_config.custom_vehicle_replacement.unavailable"))
						MiscUtils.playErrorSound()
					end)
			end
			self.page:setAction(1, self.vehicleVisibilityAction)

			EventManager.events["ON_LOCALE_REFRESH"]:register(function ()
				self.openAvatarConfigAction:setTitle(Locale:getLocalizedText("action_wheel.main_page.open_avatar_config.title"))

				if BlueArchiveCharacter.actionWheelConfig.isVehicleReplacementEnabled then
					self.vehicleVisibilityAction
						:setTitle(Locale:getLocalizedText("action_wheel.config_page.custom_vehicle_replacement.title") .. "§c" .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
						:setToggleTitle(Locale:getLocalizedText("action_wheel.config_page.custom_vehicle_replacement.title") .. "§a" .. Locale:getLocalizedText("action_wheel.action.toggle_on"))
				else
					self.vehicleVisibilityAction:setTitle("§8" .. Locale:getLocalizedText("action_wheel.config_page.custom_vehicle_replacement.title") .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
				end
			end)

			EventManager.events["ON_CONFIG_SYNC"]:register(function (configData)
				if configData["isVehicleReplacementEnabled"] == false then
					self.shouldReplaceVehicleModel = false
				end
			end)

			EventManager.events["ON_ACTION_WHEEL_CLOSE"]:register(function ()
				ActionWheel:setMainPage()
			end)
		end
	end;
}

---乗り物モデルの置き換え機能のオンオフを切り替える。
---@param isEnabled boolean 置き換え機能を有効にするかどうか
function pings.actionWheelConfig_setVehicleReplacement(isEnabled)
	ActionWheelConfig.shouldReplaceVehicleModel = isEnabled
end

return ActionWheelConfig
