---@class (exact) ActionWheelConfig アクションホイールで設定するアバター設定の管理を行うクラス
---@field package page Page アクションホイールのアバター設定ページのインスタンス
---@field package openAvatarConfigAction Action アクションホイールでアバター設定ページを開くアクション
---@field package localeCacheResetAction Action ロケールキャッシュリセットのアクション
---@field public shouldReplaceVehicleModel boolean 乗り物のモデルを置き換えるべきかどうか
---@field public isHaloForceRenderMode boolean ヘイロー強制描画モードが有効かどうか
---@field package isConfigPageOpenedPrev boolean 前ティックにアクションホイールの設定ページが開いていたかどうか
---@field package localeDataCheckLeft integer 前ティックのロケールデータのチェックを行う残り回数
---@field package fpmMassageShowed boolean First-person Model互換モードの警告メッセージを表示したかどうか
---@field public isLocaleDataFetchErrorOccurred boolean ロケールデータの取得時にエラーが発生したかどうか
---@field public isLocaleReloadedByAction boolean アクション実行によってロケールデータが再読み込みされたかどうか
---@field package actionWheelOpenTime integer アクションホイールを開けた瞬間の時間（UNIX時間）
local ActionWheelConfig = {
	page = action_wheel:newPage("config");
	openAvatarConfigAction = nil;
	localeCacheResetAction = nil;

	shouldReplaceVehicleModel = true;
	isHaloForceRenderMode = false;

	isConfigPageOpenedPrev = false;
	localeDataCheckLeftPrev = 0;
	fpmMassageShowed = false;
	isLocaleDataFetchErrorOccurred = false;
	isLocaleReloadedByAction = false;
	actionWheelOpenTime = 0;

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
			local vehicleVisibilityAction = ActionWheel.getToggleAction()
				:setItem("minecraft:oak_boat")

			self.shouldReplaceVehicleModel = Config:loadConfig("PRIVATE", "action_wheel_config.is_vehicle_replacement_enabled", true)
			if self.shouldReplaceVehicleModel then
				if BlueArchiveCharacter.actionWheelConfig.isVehicleReplacementEnabled then
					pings.actionWheelConfig_setVehicleReplacement(true)
					vehicleVisibilityAction:setToggled(true)
					ActionWheel.setActionToggleHoverColor(vehicleVisibilityAction, true)
					Config.syncConfigs["isVehicleReplacementEnabled"] = true
				else
					self.shouldReplaceVehicleModel = false
				end
			elseif not BlueArchiveCharacter.actionWheelConfig.isVehicleReplacementEnabled then
				Config:saveConfig("PRIVATE", "action_wheel_config.is_vehicle_replacement_enabled", true)
			end

			if BlueArchiveCharacter.actionWheelConfig.isVehicleReplacementEnabled then
				vehicleVisibilityAction
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
				vehicleVisibilityAction
					:setColor(0.16, 0.16, 0.16)
					:setOnToggle(function (_, action)
						action:setToggled(false)
						print(Locale:getLocalizedText("message.action_wheel_config.custom_vehicle_replacement.unavailable"))
						MiscUtils.playErrorSound()
					end)
			end
			self.page:setAction(1, vehicleVisibilityAction)

			--　アクション2. ヘイロー強制描画モード
			local haloForceRenderModeAction = ActionWheel.getToggleAction()
				:setItem("minecraft:glowstone")

			haloForceRenderModeAction
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
			self.page:setAction(2, haloForceRenderModeAction)

			--　アクション3. First-person Model互換モード
			local fpmModeAction = ActionWheel.getToggleAction()
          	if client:getVersion() >= "1.20.5" then
                fpmModeAction:setItem("minecraft:player_head[profile={name:\""..player:getName().."\"}]")
            else
                fpmModeAction:setItem("minecraft:player_head{SkullOwner: \""..player:getName().."\"}")
            end

			if Config:loadConfig("PRIVATE", "action_wheel_config.is_fpm_mode", false) then
				fpmModeAction:setToggled(true)
				ActionWheel.setActionToggleHoverColor(fpmModeAction, true)
				events.RENDER:register(self.fpmCompatibilityModeRender, "fpm_mode_render")
			end

			fpmModeAction
				:setOnToggle(function (_, action)
					Config:saveConfig("PRIVATE", "action_wheel_config.is_fpm_mode", true)
					ActionWheel.setActionToggleHoverColor(action, true)
					events.RENDER:register(self.fpmCompatibilityModeRender, "fpm_mode_render")
					if not self.fpmMassageShowed then
						print(Locale:getLocalizedText("message.action_wheel_config.fpm_mode.warning"))
						self.fpmMassageShowed = true
					end
				end)
				:setOnUntoggle(function (_, action)
					Config:saveConfig("PRIVATE", "action_wheel_config.is_fpm_mode", false)
					ActionWheel.setActionToggleHoverColor(action, false)
					events.RENDER:remove("fpm_mode_render")
					ModelAlias.alias.avatar.head:setVisible(true)
					ModelAlias.alias.avatar.head:setOpacity(1)
				end)
			self.page:setAction(3, fpmModeAction)

			-- アクション4. ロケールキャッシュのリセット
			self.localeCacheResetAction = ActionWheel.getAction()
				:setItem("minecraft:bucket")
				:setOnLeftClick(function ()
					if Locale.localeDataCheckLeft <= 0 then
						self.isLocaleDataFetchErrorOccurred = false
						Locale:flushCache()
						Locale:initializeLocale()
						self.isLocaleReloadedByAction = true
					end
				end)
			self.page:setAction(4, self.localeCacheResetAction)

			-- アクション5. アップデートの確認
            local updateCheckAction = ActionWheel.getAction()
				:setItem("minecraft:compass")
				:setOnLeftClick(function ()
					if not net:isNetworkingAllowed() or not net:isLinkAllowed(UpdateChecker.UPDATE_CHECK_ENDPOINT_URI:match("(https?://[^:/]+)")) then
						print(Locale:getLocalizedText("message.action_wheel_config.update_check.no_permission"):format(UpdateChecker.UPDATE_CHECK_ENDPOINT_URI:match("://([^:/]+)")))
					elseif UpdateChecker.checkerStatus ~= "CHECKING" then
						UpdateChecker:checkUpdate()
					else
						print(Locale:getLocalizedText("message.action_wheel_config.update_check.ongoing"))
						MiscUtils.playErrorSound()
					end
				end):onRightClick(function ()
					if UpdateChecker.latestVersion ~= nil and self.actionWheelOpenTime < UpdateChecker.lastCheckTime + 86400000 then
						host:setClipboard(UpdateChecker.RELEASE_PAGE_URL .. UpdateChecker.latestVersion)
						print(Locale:getLocalizedText("message.action_wheel_config.update_check.copy_to_clipboard"))
					else
						print(Locale:getLocalizedText("message.action_wheel_config.update_check.error_cache_expired"))
						MiscUtils.playErrorSound()
					end
				end)
			self.page:setAction(5, updateCheckAction)

			events.TICK:register(function ()
				local isConfigPageOpened = action_wheel:getCurrentPage():getTitle() == "config"
				if isConfigPageOpened and not self.isConfigPageOpenedPrev then
					if isConfigPageOpened then
						self:setLocaleCacheResetActionState()
					end
					self.isConfigPageOpenedPrev = isConfigPageOpened
				end
				if Locale.localeDataCheckLeft ~= self.localeDataCheckLeftPrev then
					self:setLocaleCacheResetActionState()
					self.localeDataCheckLeftPrev = Locale.localeDataCheckLeft
				end
			end)

			EventManager.events["ON_LOCALE_REFRESH"]:register(function ()
				self.openAvatarConfigAction:setTitle(Locale:getLocalizedText("action_wheel.main_page.open_avatar_config.title"))

				if BlueArchiveCharacter.actionWheelConfig.isVehicleReplacementEnabled then
					vehicleVisibilityAction
						:setTitle(Locale:getLocalizedText("action_wheel.config_page.custom_vehicle_replacement.title") .. "§c" .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
						:setToggleTitle(Locale:getLocalizedText("action_wheel.config_page.custom_vehicle_replacement.title") .. "§a" .. Locale:getLocalizedText("action_wheel.action.toggle_on"))
				else
					vehicleVisibilityAction:setTitle("§8" .. Locale:getLocalizedText("action_wheel.config_page.custom_vehicle_replacement.title") .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
				end

				haloForceRenderModeAction
					:setTitle(Locale:getLocalizedText("action_wheel.config_page.halo_force_render_mode.title") .. "§c" .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
					:setToggleTitle(Locale:getLocalizedText("action_wheel.config_page.halo_force_render_mode.title") .. "§a" .. Locale:getLocalizedText("action_wheel.action.toggle_on"))

				fpmModeAction
					:setTitle(Locale:getLocalizedText("action_wheel.config_page.fpm_mode.title") .. "§c" .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
					:setToggleTitle(Locale:getLocalizedText("action_wheel.config_page.fpm_mode.title") .. "§a" .. Locale:getLocalizedText("action_wheel.action.toggle_on"))

				self:setLocaleCacheResetActionState()

				updateCheckAction:setTitle(Locale:getLocalizedText("action_wheel.config_page.update_check.title_1") .. "\n" .. Locale:getLocalizedText("action_wheel.config_page.update_check.title_2"))

				if Locale.localeDataCheckLeft <= 0 and not self.isLocaleDataFetchErrorOccurred and self.isLocaleReloadedByAction then
					sounds:playSound("minecraft:item.bucket.empty", player:getPos())
					events.TICK:register(function ()
						events.TICK:remove("locale_cache_reset_message_delay")
						print(Locale:getLocalizedText("message.action_wheel_config.locale_cache_reset.done"))
					end, "locale_cache_reset_message_delay")
					self.isLocaleReloadedByAction = false
				end
			end)

			EventManager.events["ON_CONFIG_SYNC"]:register(function (configData)
				if configData["isVehicleReplacementEnabled"] == false then
					self.shouldReplaceVehicleModel = false
				end
				if configData["isHaloForceRenderMode"] == true then
					self.isHaloForceRenderMode = true
				end
			end)

			EventManager.events["ON_ACTION_WHEEL_OPEN"]:register(function ()
				ActionWheelConfig.actionWheelOpenTime = client:getSystemTime()
			end)

			EventManager.events["ON_ACTION_WHEEL_CLOSE"]:register(function ()
				ActionWheel:setMainPage()
			end)
		end
	end;

	---First-person Model互換性モードにおけるレンダー関数
    ---@param context Event.Render.context
    fpmCompatibilityModeRender = function (_, context)
        local hasShaderPack = client:hasShaderPack()
        ModelAlias.alias.avatar.head:setVisible(context ~= "OTHER" or hasShaderPack)
        if context == "OTHER" and hasShaderPack then
             ModelAlias.alias.avatar.head:setPrimaryRenderType("TRANSLUCENT")
            ModelAlias.alias.avatar.head:setOpacity(0)
        else
            ModelAlias.alias.avatar.head:setPrimaryRenderType()
            ModelAlias.alias.avatar.head:setOpacity(1)
        end
    end;

	---ロケールデータのリセットアクションの状態を設定する。
	---@param self ActionWheelConfig
	setLocaleCacheResetActionState = function (self)
		if Locale.localeDataCheckLeft > 0 then
			self.localeCacheResetAction
				:setTitle("§8" .. Locale:getLocalizedText("action_wheel.config_page.locale_cache_reset.title"))
				:setColor(0.16, 0.16, 0.16)
				:setHoverColor(1, 0.33, 0.33)
		else
			self.localeCacheResetAction
				:setTitle(Locale:getLocalizedText("action_wheel.config_page.locale_cache_reset.title"))
				:setColor(0.78, 0.78, 0.78)
				:setHoverColor(1, 1, 1)
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
