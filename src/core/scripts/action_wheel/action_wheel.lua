---@class (exact) ActionWheel アクションホイールを管理するクラス
---@field package page Page アクションホイールのページのインスタンス
---@field package isActionWheelOpenedPrev boolean 前ティックにアクションホイールが開いていたかどうか
local ActionWheel = {
	page = action_wheel:newPage("main");
	isActionWheelOpenedPrev = false;

    ---初期化関数
    ---@param self ActionWheel
    init = function (self)
		if host:isHost() then
			self:setMainPage()

			events.TICK:register(function ()
				if not client:isPaused() then
					local isActionWheelOpened = action_wheel:isEnabled()
					if isActionWheelOpened ~= self.isActionWheelOpenedPrev then
						if not isActionWheelOpened then
							EventManager.events["ON_ACTION_WHEEL_CLOSE"]:fire()
						end
						self.isActionWheelOpenedPrev = isActionWheelOpened
					end
				end
			end)
		end
	end;

	---アクションホイールのメインページを設定する。
	---@param self ActionWheel
	setMainPage = function (self)
		action_wheel:setPage(self.page)
	end;

	---アクションホイールのページにアクションを登録する。
	---@param self ActionWheel
	---@param action Action 登録対象のアクションのインスタンス
	---@param index? integer アクションのインデックス（1-8）。`nil`の場合は空いている最初のスロットに登録される。
	setAction = function (self, action, index)
		self.page:setAction(index or -1, action)
	end;

	---アクションの雛形を生成して返す。
	---@return Action actionTemplate アクションの雛形
	getAction = function ()
		return action_wheel:newAction()
			:setColor(0.78, 0.78, 0.78)
			:setHoverColor(1, 1, 1)
	end;

	---トグルアクションの雛形を生成して返す。
	---@return Action toggleActionTemplate トグルアクションの雛形
	getToggleAction = function ()
		return action_wheel:newAction()
			:setColor(0.67, 0, 0)
			:setToggleColor(0, 0.67, 0)
			:setHoverColor(1, 0.33, 0.33)
	end;

	---入力されたトグルアクションのトグル状態を返す。
	---@param action Action トグル状態を取得したいアクションのインスタンス
	---@return boolean state トグルアクションのトグル状態
	getToggleActionState = function (action)
		return action:getHoverColor() == vectors.vec3(0.33, 1, 0.33)
	end;

	---トグルアクションのホバーカラーを設定する。
	---@param action Action 設定対象のトグルアクションのインスタンス
	---@param state boolean トグルアクションのトグル状態
	setActionToggleHoverColor = function (action, state)
		if state then
			action:setHoverColor(0.33, 1, 0.33)
		else
			action:setHoverColor(1, 0.33, 0.33)
		end
	end
}

return ActionWheel
