---@class (exact) LocaleReadyEvent : AbstractEvent ロケールデータの準備が完了した際（成否に問わず）のイベントクラス
local LocaleReadyEvent = {
	---コンストラクタ
	---@return LocaleReadyEvent instance
	new = function ()
		---@type LocaleReadyEvent
		---@diagnostic disable-next-line: undefined-global
		local instance = MiscUtils.instantiate(LocaleReadyEvent, AbstractEvent)

		return instance
	end;

	---初期化関数
	init = function (self)
		EventManager.events["ON_LOCALE_READY"] = self:new()
	end;

    ---登録された全てのコールバック関数を呼ぶ。
    ---@param self LocaleReadyEvent
    fire = function (self)
		if events.TICK:getRegisteredCount("on_locale_ready_fire_delay") == 0 then
			events.TICK:register(function ()
				events.TICK:remove("on_locale_ready_fire_delay")
				for _, eventTable in pairs(self.registerTable) do
					for _, callback in ipairs(eventTable) do
						callback()
					end
				end
			end, "on_locale_ready_fire_delay")
		end
    end;
}

return LocaleReadyEvent
