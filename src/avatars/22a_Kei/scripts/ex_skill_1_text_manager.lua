---@class (exact) ExSkill1TextManager : SpawnObjectManager Exスキル内で使用するテキストオブジェクトのマネージャークラス
---@field public objects ExSkill1Text[] インスタンスで制御するオブジェクト
local ExSkill1TextManager = {

    ---コンストラクタ
    ---@return ExSkill1TextManager
    new = function ()
        ---@type ExSkill1TextManager
        local instance = MiscUtils.instantiate(ExSkill1TextManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_text"

        return instance
    end;

    ---Exスキル内で使用するテキストオブジェクトインスタンスを生成して返す。
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
	---@param face integer テキストの向きを決定する値（1: 下面, 2: 上面, 3: 左面, 4: 右面）
    ---@return ExSkill1Text
    getObject = function (_, pos, face)
        return ExSkill1Text.new(pos, face)
    end;

	---Exスキルのテキストオブジェクトをスポーンさせる。
    ---@param self ExSkill1TextManager
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
	---@param face integer テキストの向きを決定する値（1: 下面, 2: 上面, 3: 左面, 4: 右面）
    spawn = function (self, pos, face)
        SpawnObjectManager.spawn(self, pos, face)
    end;

}

return ExSkill1TextManager
