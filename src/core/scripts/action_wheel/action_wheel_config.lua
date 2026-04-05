---@class (exact) ActionWheelConfig アクションホイールで設定するアバター設定の管理を行うクラス
---@field package page Page アクションホイールのアバター設定ページのインスタンス
---@field package openAvatarConfigAction Action アクションホイールでアバター設定ページを開くアクション
---@field package vehicleVisibilityAction Action 乗り物モデルの置き換えオプションのトグルアクション
---@field package haloForceRenderModeAction Action ヘイロー強制描画モードのトグルアクション
---@field public shouldReplaceVehicleModel boolean 乗り物のモデルを置き換えるべきかどうか
---@field public isHaloForceRenderMode boolean ヘイロー強制描画モードが有効かどうか
local ActionWheelConfig = {
	page = action_wheel:newPage("config");
	openAvatarConfigAction = nil;
	customVehicleVisibilityAction = nil;
	haloForceRenderModeAction = nil;

	shouldReplaceVehicleModel = true;
	isHaloForceRenderMode = false;

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
						Config.syncConfigs["isVehicleReplacementEnabled"] = true
						Config:saveConfig("PRIVATE", "action_wheel_config.is_vehicle_replacement_enabled", true)
					end)
					:setOnUntoggle(function (_, action)
						pings.actionWheelConfig_setVehicleReplacement(false)
						ActionWheel.setActionToggleHoverColor(action, false)
						Config.syncConfigs["isVehicleReplacementEnabled"] = false
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

			--　アクション2. ヘイロー強制描画モード
			self.haloForceRenderModeAction = ActionWheel.getToggleAction()
				:setItem("minecraft:glowstone")

			self.haloForceRenderModeAction
				:setOnToggle(function (_, action)
					pings.actionWheelConfig_setHaloForceRenderMode(true)
					ActionWheel.setActionToggleHoverColor(action, true)
					Config.syncConfigs["isHaloForceRenderMode"] = true
				end)
				:setOnUntoggle(function (_, action)
					pings.actionWheelConfig_setHaloForceRenderMode(false)
					ActionWheel.setActionToggleHoverColor(action, false)
					Config.syncConfigs["isHaloForceRenderMode"] = false
				end)
			self.page:setAction(2, self.haloForceRenderModeAction)

			EventManager.events["ON_LOCALE_REFRESH"]:register(function ()
				self.openAvatarConfigAction:setTitle(Locale:getLocalizedText("action_wheel.main_page.open_avatar_config.title"))

				if BlueArchiveCharacter.actionWheelConfig.isVehicleReplacementEnabled then
					self.vehicleVisibilityAction
						:setTitle(Locale:getLocalizedText("action_wheel.config_page.custom_vehicle_replacement.title") .. "§c" .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
						:setToggleTitle(Locale:getLocalizedText("action_wheel.config_page.custom_vehicle_replacement.title") .. "§a" .. Locale:getLocalizedText("action_wheel.action.toggle_on"))
				else
					self.vehicleVisibilityAction:setTitle("§8" .. Locale:getLocalizedText("action_wheel.config_page.custom_vehicle_replacement.title") .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
				end
				self.haloForceRenderModeAction
					:setTitle(Locale:getLocalizedText("action_wheel.config_page.halo_force_render_mode.title") .. "§c" .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
					:setToggleTitle(Locale:getLocalizedText("action_wheel.config_page.halo_force_render_mode.title") .. "§a" .. Locale:getLocalizedText("action_wheel.action.toggle_on"))
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

---乗り物モデルの置き換え機能のオンオフを設定する。
---@param isEnabled boolean 置き換え機能を有効にするかどうか
function pings.actionWheelConfig_setVehicleReplacement(isEnabled)
	ActionWheelConfig.shouldReplaceVehicleModel = isEnabled
end

---ヘイロー強制描画モードのオンオフを設定する。
---@param isEnabled boolean ヘイロー強制描画モードを有効にするかどうか
function pings.actionWheelConfig_setHaloForceRenderMode(isEnabled)
	ActionWheelConfig.isHaloForceRenderMode = isEnabled
end

return ActionWheelConfig
