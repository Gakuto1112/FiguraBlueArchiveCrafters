---@class (exact) ActionWheelCloseEvent : AbstractEvent アクションホイールが閉じられた際のイベントクラス
local ActionWheelCloseEvent = {
	---コンストラクタ
	---@return ActionWheelCloseEvent instance
	new = function ()
		---@type ActionWheelCloseEvent
		---@diagnostic disable-next-line: undefined-global
		local instance = MiscUtils.instantiate(ActionWheelCloseEvent, AbstractEvent)

		return instance
	end;

	---初期化関数
	init = function (self)
		EventManager.events["ON_ACTION_WHEEL_CLOSE"] = self:new()
	end;
}

return ActionWheelCloseEvent
