---@class (exact) Character23a.MeteorManager : SpawnObjectManager 隕石のマネージャークラス
---@field public objects Character23a.Meteor[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: Character23a.Meteor, targetPos: Vector3): Character23a.Meteor 隕石のインスタンスを生成して返す
---@field public spawn fun(self: Character23a.Meteor, targetPos: Vector3) 隕石をスポーンさせる
local MeteorManager = {
	---コンストラクタ
	---@return Character23a.MeteorManager
	new = function ()
		---@type Character23a.MeteorManager
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
	---@return Character23a.MeteorManager instance 生成したインスタンス
	getObject = function (_, targetPos)
		return Meteor.new(targetPos)
	end;

    ---隕石をスポーンさせる。
	---@param self Character23a.MeteorManager
	---@param targetPos Vector3 隕石を落とす目標座標
    spawn = function (self, targetPos)
        SpawnObjectManager.spawn(self, targetPos)
    end;
}

return MeteorManager
