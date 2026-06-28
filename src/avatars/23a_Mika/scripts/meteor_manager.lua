---@class (exact) MeteorManager : SpawnObjectManager 隕石のマネージャークラス
---@field public objects Meteor[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: Meteor, targetPos: Vector3): Meteor 隕石のインスタンスを生成して返す
---@field public spawn fun(self: Meteor, targetPos: Vector3) 隕石をスポーンさせる
local MeteorManager = {
	---コンストラクタ
	---@return MeteorManager
	new = function ()
		---@type MeteorManager
		local instance = MiscUtils.instantiate(MeteorManager, SpawnObjectManager)

		instance.managerName = "ex_skill_meteor"

		return instance
	end;

	---初期化関数
	init = function ()
		---@diagnostic disable-next-line: discard-returns
		models:newPart("script_meteor", "World")
	end;

	---隕石のインスタンスを生成して返す。
	---@param targetPos Vector3 隕石を落とす目標座標
	---@return MeteorManager instance 生成したインスタンス
	getObject = function (_, targetPos)
		return Meteor.new(targetPos)
	end;

    ---隕石をスポーンさせる。
	---@param self MeteorManager
	---@param targetPos Vector3 隕石を落とす目標座標
    spawn = function (self, targetPos)
        SpawnObjectManager.spawn(self, targetPos)
    end;
}

return MeteorManager
