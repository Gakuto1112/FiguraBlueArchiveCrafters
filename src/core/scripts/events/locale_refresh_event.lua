---@class (exact) LocaleRefreshEvent : AbstractEvent ロケールデータが更新された際のイベントクラス
---@field package isEventFired boolean 現在ティック内でイベントが発火したかどうか
local LocaleRefreshEvent = {
	isEventFired = false;

	---コンストラクタ
	---@return LocaleRefreshEvent instance
	new = function ()
		---@type LocaleRefreshEvent
		local instance = MiscUtils.instantiate(LocaleRefreshEvent, AbstractEvent)

		instance.test = "TEST"

		return instance
	end;

	---初期化関数
	init = function (self)
		EventManager.events["ON_LOCALE_REFRESH"] = self:new()
	end;

    ---登録された全てのコールバック関数を呼ぶ。
    ---@param self LocaleRefreshEvent
    fire = function (self)
		if not self.isEventFired then
			for _, eventTable in pairs(self.registerTable) do
				for _, callback in ipairs(eventTable) do
					callback()
				end
			end

			self.isEventFired = true

			events.TICK:register(function ()
				self.isEventFired = false
				events.TICK:remove("locale_refresh_event_tick")
			end, "locale_refresh_event_tick")
		end
    end;
}

return LocaleRefreshEvent
