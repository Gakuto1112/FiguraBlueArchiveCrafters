---@class (exact) Character24a.PieManager : SpawnObjectManager 投げるパイオブジェクトのマネージャークラス
---@field public objects Character24a.Pie[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: Character24a.PieManager, startPos: Vector3): Character24a.Pie 投げるパイオブジェクトインスタンスを生成して返す
---@field public spawn fun(self: Character24a.PieManager, startPos: Vector3) 投げるパイオブジェクトをスポーンさせる
local PieManager = {
	---コンストラクタ
	---@return Character24a.PieManager
	new = function ()
		---@type Character24a.PieManager
		local instance = MiscUtils.instantiate(PieManager, SpawnObjectManager)

		instance.managerName = "pie"

		return instance
	end;

	---初期化関数
	init = function ()
		---@diagnostic disable-next-line: discard-returns
		models:newPart("script_pie", "World")
	end;

	---パイオブジェクトインスタンスを生成して返す
	---@param startPos Vector3 パイオブジェクトをスポーンさせるワールド位置
	---@return Character24a.Pie instance 生成したインスタンス
	getObject = function (_, startPos)
		return Pie.new(startPos)
	end;

    ---パイオブジェクトをスポーンさせる
	---@param self Character24a.PieManager
	---@param startPos Vector3 パイオブジェクトをスポーンさせるワールド位置
    spawn = function (self, startPos)
        SpawnObjectManager.spawn(self, startPos)
    end;
}

return PieManager
