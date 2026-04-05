---@class (exact) ActionWheelConfig アクションホイールで設定するアバター設定の管理を行うクラス
---@field package page Page アクションホイールのアバター設定ページのインスタンス
---@field package openAvatarConfigAction Action アクションホイールでアバター設定ページを開くアクション
local ActionWheelConfig = {
	page = action_wheel:newPage("config");
	openAvatarConfigAction = nil;

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

			EventManager.events["ON_LOCALE_REFRESH"]:register(function ()
				self.openAvatarConfigAction:setTitle(Locale:getLocalizedText("action_wheel.main_page.open_avatar_config.title"))
			end)

			EventManager.events["ON_ACTION_WHEEL_CLOSE"]:register(function ()
				ActionWheel:setMainPage()
			end)
		end
	end;
}

return ActionWheelConfig
