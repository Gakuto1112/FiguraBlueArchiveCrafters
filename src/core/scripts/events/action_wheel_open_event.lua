---@class (exact) ActionWheelOpenEvent : AbstractEvent アクションホイールが開かれた際のイベントクラス
local ActionWheelOpenEvent = {
	---コンストラクタ
	---@return ActionWheelOpenEvent instance
	new = function ()
		---@type ActionWheelOpenEvent
		---@diagnostic disable-next-line: undefined-global
		local instance = MiscUtils.instantiate(ActionWheelOpenEvent, AbstractEvent)

		return instance
	end;

	---初期化関数
	init = function (self)
		EventManager.events["ON_ACTION_WHEEL_OPEN"] = self:new()
	end;
}

return ActionWheelOpenEvent
