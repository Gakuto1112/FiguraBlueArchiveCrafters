---@class (exact) ExSkillShootingStarManager : SpawnObjectManager Exスキル内で使用する流れ星のマネージャークラス
---@field public objects ExSkillShootingStar[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: ExSkillShootingStar, pos: Vector3, dir: Vector3): ExSkill1Sprite 流れ星パーティクルのインスタンスを生成して返す
---@field public spawn fun(self: ExSkillShootingStar, pos: Vector3, pos: Vector3) 流れ星パーティクルをスポーンさせる
local ExSkillShootingStarManager = {
	---コンストラクタ
	---@return ExSkillShootingStarManager
	new = function ()
		---@type ExSkillShootingStarManager
		local instance = MiscUtils.instantiate(ExSkillShootingStarManager, SpawnObjectManager)

		instance.managerName = "ex_skill_shooting_star"

		return instance
	end;

	---流れ星パーティクルのインスタンスを生成して返す。
	---@param pos Vector3 流れ星をスポーンするワールド座標
	---@param dir Vector3 流れ星を流す方向
	---@return ExSkillShootingStar instance 生成したインスタンス
	getObject = function (_, pos, dir)
		return ExSkillShootingStar.new(pos, dir)
	end;

    ---流れ星パーティクルをスポーンさせる。
	---@param self ExSkillShootingStarManager
	---@param pos Vector3 流れ星をスポーンするワールド座標
	---@param dir Vector3 流れ星を流す方向
    spawn = function (self, pos, dir)
        SpawnObjectManager.spawn(self, pos, dir)
    end;
}

return ExSkillShootingStarManager
