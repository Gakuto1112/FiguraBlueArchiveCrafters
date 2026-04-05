---@class (exact) LocaleChangeEvent : AbstractEvent ゲームのロケールが変更された際のイベントクラス
---@field public register fun(self: LocaleChangeEvent, callback: fun(newLocale: string), name?: string) イベントにコールバック関数登録する。
---@field public fire fun(self: LocaleChangeEvent, newLocale: string) 登録された全てのコールバック関数を呼ぶ。
local LocaleChangeEvent = {
	---コンストラクタ
	---@return LocaleChangeEvent instance
	new = function ()
		---@type LocaleChangeEvent
		---@diagnostic disable-next-line: undefined-global
		local instance = MiscUtils.instantiate(LocaleChangeEvent, AbstractEvent)

		return instance
	end;

	---初期化関数
	init = function (self)
		EventManager.events["ON_LOCALE_CHANGE"] = self:new()
	end;
}

return LocaleChangeEvent
