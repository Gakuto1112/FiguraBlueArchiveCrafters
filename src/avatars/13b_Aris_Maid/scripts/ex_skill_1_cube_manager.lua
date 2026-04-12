---@class ExSkill1CubeManager : SpawnObjectManager Exスキル1で使用するキューブを管理するクラス
---@field public objects ExSkill1Cube[] インスタンスで制御するオブジェクト
---@field package getObject fun(self: ExSkill1CubeManager): ExSkill1Cube キューブのインスタンスを生成して返す
---@field public spawn fun(self: ExSkill1CubeManager) キューブをスポーンさせる
local ExSkill1CubeManager = {
    ---コンストラクタ
    ---@return ExSkill1CubeManager
    new = function ()
        ---@type ExSkill1CubeManager
        local instance = MiscUtils.instantiate(ExSkill1CubeManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_cube"

        return instance
    end;

    ---初期化関数
    init = function ()
        models.models.ex_skill_1.Cube:setLight(15)
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_ex_skill_1_cube")
    end;

    ---キューブのインスタンスを生成して返す。
    ---@return ExSkill1Cube instance 生成したインスタンス
    getObject = function (_)
        return ExSkill1Cube.new()
    end;

    ---キューブをスポーンさせる。
    ---@param self ExSkill1CubeManager
    spawn = function (self)
        SpawnObjectManager.spawn(self)
    end;
}

return ExSkill1CubeManager
