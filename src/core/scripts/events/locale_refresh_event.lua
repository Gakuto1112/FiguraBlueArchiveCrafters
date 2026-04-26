---@class (exact) LocaleRefreshEvent : AbstractEvent ロケールデータが更新された際のイベントクラス
local LocaleRefreshEvent = {

	---コンストラクタ
	---@return LocaleRefreshEvent instance
	new = function ()
		---@type LocaleRefreshEvent
		---@diagnostic disable-next-line: undefined-global
		local instance = MiscUtils.instantiate(LocaleRefreshEvent, AbstractEvent)

		return instance
	end;

	---初期化関数
	init = function (self)
		EventManager.events["ON_LOCALE_REFRESH"] = self:new()
	end;

    ---登録された全てのコールバック関数を呼ぶ。
    ---@param self LocaleRefreshEvent
    fire = function (self)
		if events.TICK:getRegisteredCount("on_locale_refresh_fire_delay") == 0 then
			events.TICK:register(function ()
				events.TICK:remove("on_locale_refresh_fire_delay")
				for _, eventTable in pairs(self.registerTable) do
					for _, callback in ipairs(eventTable) do
						callback()
					end
				end
			end, "on_locale_refresh_fire_delay")
		end
    end;
}

return LocaleRefreshEvent
