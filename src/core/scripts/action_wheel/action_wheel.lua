---アクションホイールのページを示す列挙型
---@alias ActionWheel.Page
---| "MAIN" #メインページ
---| "CONFIG" #アバター設定ページ

---@class (exact) ActionWheel アクションホイールを管理するクラス
---@field package mainPage Page アクションホイールのメインページのインスタンス
---@field package configPage Page アクションホイールのアバター設定ページのインスタンス
---@field package isActionWheelOpenedPrev boolean 前ティックにアクションホイールが開いていたかどうか
local ActionWheel = {
	mainPage = action_wheel:newPage("main");
	configPage = action_wheel:newPage("config");
	isActionWheelOpenedPrev = false;

    ---初期化関数
    ---@param self ActionWheel
    init = function (self)
		if host:isHost() then
			action_wheel:setPage(self.mainPage)

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

	---アクションホイールのページにアクションを登録する。
	---@param self ActionWheel
	---@param action Action 登録対象のアクションのインスタンス
	---@param target ActionWheel.Page アクションを登録するページ
	---@param index? integer アクションのインデックス（1-8）。`nil`の場合は空いている最初のスロットに登録される。
	setAction = function (self, action, target, index)
		if target == "MAIN" then
			self.mainPage:setAction(index or -1, action)
		elseif target == "CONFIG" then
			self.configPage:setAction(index or -1, action)
		end
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
