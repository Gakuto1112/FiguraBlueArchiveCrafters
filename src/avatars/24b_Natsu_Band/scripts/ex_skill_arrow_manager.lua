---@class (exact) ExSkillArrowManager : SpawnObjectManager Exスキルアニメーションで使用する矢のオブジェクトのマネージャークラス
---@field public objects ExSkillArrow[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: ExSkillArrowManager, pos: Vector3, velocity: Vector3): ExSkillArrow Exスキルアニメーションで使用する矢のオブジェクトインスタンスを生成して返す
---@field public spawn fun(self: ExSkillArrowManager, pos: Vector3, velocity: Vector3) Exスキルアニメーションで使用する矢のオブジェクトをスポーンさせる
local ExSkillArrowManager = {
	---コンストラクタ
	---@return ExSkillArrowManager
	new = function ()
		---@type ExSkillArrowManager
		local instance = MiscUtils.instantiate(ExSkillArrowManager, SpawnObjectManager)

		instance.managerName = "ex_skill_arrow"

		return instance
	end;

	---初期化関数
	init = function ()
		---@diagnostic disable-next-line: discard-returns
		models:newPart("script_ex_skill_arrow", "World")
	end;

	---Exスキルアニメーションで使用する矢のオブジェクトインスタンスを生成して返す
	---@param pos Vector3 矢のオプジェクトをスポーンさせるワールド位置
	---@param velocity Vector3 矢のオブジェクトの初速
	---@return ExSkillArrow instance 生成したインスタンス
	getObject = function (_, pos, velocity)
		return ExSkillArrow.new(pos, velocity)
	end;

    ---Exスキルアニメーションで使用する矢のオブジェクトをスポーンさせる
	---@param self ExSkillArrowManager
	---@param pos Vector3 矢のオブジェクトをスポーンさせるワールド位置
	---@param velocity Vector3 矢のオブジェクトの初速
    spawn = function (self, pos, velocity)
        SpawnObjectManager.spawn(self, pos, velocity)
    end;
}

return ExSkillArrowManager
