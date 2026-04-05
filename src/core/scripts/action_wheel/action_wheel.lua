---アクションホイールのページを示す列挙型
---@alias ActionWheel.Page
---| "MAIN" #メインページ
---| "CONFIG" #アバター設定ページ

---@class (exact) ActionWheel アクションホイールを管理するクラス
---@field package mainPage Page アクションホイールのメインページのインスタンス
---@field package configPage Page アクションホイールのアバター設定ページのインスタンス
local ActionWheel = {
	mainPage = nil;
	configPage = nil;

    ---初期化関数
    ---@param self ActionWheel
    init = function (self)
		if host:isHost() then
			self.mainPage = action_wheel:newPage("main")
			self.configPage = action_wheel:newPage("config")

			action_wheel:setPage(self.mainPage)
		end
	end;

	---アクションホイールのページにアクションを登録し、そのアクションのインスタンスを返す。
	---@param self ActionWheel
	---@param target ActionWheel.Page アクションを登録するページ
	---@param index? integer アクションのインデックス（1-8）。`nil`の場合は空いている最初のスロットに登録される。
	---@return Action action アクションホイールに登録したアクションのインスタンス
	setAction = function (self, target, index)
		if target == "MAIN" then
			return self.mainPage:newAction(index)
		elseif target == "CONFIG" then
			return self.configPage:newAction(index)
		else
			return nil
		end
	end;
}

return ActionWheel
