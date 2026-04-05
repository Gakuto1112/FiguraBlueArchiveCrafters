---@class (exact) ActionWheelClosedEvent : AbstractEvent アクションホイールが閉じられた際のイベントクラス
---@field public register fun(self: ActionWheelClosedEvent, callback: fun(), name?: string) イベントにコールバック関数登録する。
---@field public fire fun(self: ActionWheelClosedEvent) 登録された全てのコールバック関数を呼ぶ。
local ActionWheelClosedEvent = {
	---コンストラクタ
	---@return ActionWheelClosedEvent instance
	new = function ()
		---@type ActionWheelClosedEvent
		---@diagnostic disable-next-line: undefined-global
		local instance = MiscUtils.instantiate(ActionWheelClosedEvent, AbstractEvent)

		return instance
	end;

	---初期化関数
	init = function (self)
		EventManager.events["ON_ACTION_WHEEL_CLOSE"] = self:new()
	end;
}

return ActionWheelClosedEvent
