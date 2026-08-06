---@class (exact) PieManager : SpawnObjectManager 投げるパイオブジェクトのマネージャークラス
---@field public objects Pie[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: PieManager, startPos: Vector3): Pie 投げるパイオブジェクトインスタンスを生成して返す
---@field public spawn fun(self: PieManager, startPos: Vector3) 投げるパイオブジェクトをスポーンさせる
local PieManager = {
	---コンストラクタ
	---@return PieManager
	new = function ()
		---@type PieManager
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
	---@return Pie instance 生成したインスタンス
	getObject = function (_, startPos)
		return Pie.new(startPos)
	end;

    ---パイオブジェクトをスポーンさせる
	---@param self PieManager
	---@param startPos Vector3 パイオブジェクトをスポーンさせるワールド位置
    spawn = function (self, startPos)
        SpawnObjectManager.spawn(self, startPos)
    end;
}

return PieManager
