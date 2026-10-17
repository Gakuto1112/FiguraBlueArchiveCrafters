---@class (exact) Character23b.ExSkillShootingStarManager : SpawnObjectManager Exスキル内で使用する流れ星のマネージャークラス
---@field public objects Character23b.ExSkillShootingStar[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: Character23b.ExSkillShootingStar, pos: Vector3, dir: Vector3): Character23b.ExSkillShootingStar 流れ星パーティクルのインスタンスを生成して返す
---@field public spawn fun(self: Character23b.ExSkillShootingStar, pos: Vector3, dir: Vector3) 流れ星パーティクルをスポーンさせる
local ExSkillShootingStarManager = {
	---コンストラクタ
	---@return Character23b.ExSkillShootingStarManager
	new = function ()
		---@type Character23b.ExSkillShootingStarManager
		local instance = MiscUtils.instantiate(Character23b_ExSkillShootingStarManager, SpawnObjectManager)

		instance.managerName = "ex_skill_shooting_star"

		return instance
	end;

	---流れ星パーティクルのインスタンスを生成して返す。
	---@param pos Vector3 流れ星をスポーンするワールド座標
	---@param dir Vector3 流れ星を流す方向
	---@return Character23b.ExSkillShootingStar instance 生成したインスタンス
	getObject = function (_, pos, dir)
		return Character23b_ExSkillShootingStar.new(pos, dir)
	end;

    ---流れ星パーティクルをスポーンさせる。
	---@param self Character23b.ExSkillShootingStarManager
	---@param pos Vector3 流れ星をスポーンするワールド座標
	---@param dir Vector3 流れ星を流す方向
    spawn = function (self, pos, dir)
        SpawnObjectManager.spawn(self, pos, dir)
    end;
}

return ExSkillShootingStarManager
