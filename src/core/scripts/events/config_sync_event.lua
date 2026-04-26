---@class (exact) ConfigSyncEvent : AbstractEvent アバター設定データがpingによって同期された際のイベントクラス
---@field public register fun(self: ConfigSyncEvent, callback: fun(configData: {[string]: any}), name?: string) イベントにコールバック関数登録する。
---@field public fire fun(self: ConfigSyncEvent, configData: {[string]: any}) 登録された全てのコールバック関数を呼ぶ。
local ConfigSyncEvent = {
	---コンストラクタ
	---@return ConfigSyncEvent instance
	new = function ()
		---@type ConfigSyncEvent
		---@diagnostic disable-next-line: undefined-global
		local instance = MiscUtils.instantiate(ConfigSyncEvent, AbstractEvent)

		return instance
	end;

	---初期化関数
	init = function (self)
		EventManager.events["ON_CONFIG_SYNC"] = self:new()
	end;
}

return ConfigSyncEvent
