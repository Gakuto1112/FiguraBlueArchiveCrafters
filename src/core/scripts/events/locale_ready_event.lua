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
}

return LocaleReadyEvent
