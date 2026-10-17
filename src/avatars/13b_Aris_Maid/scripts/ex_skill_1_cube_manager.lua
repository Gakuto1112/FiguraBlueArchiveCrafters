---@class Character13b.ExSkill1CubeManager : SpawnObjectManager Exスキル1で使用するキューブを管理するクラス
---@field public objects Character13b.ExSkill1Cube[] インスタンスで制御するオブジェクト
---@field package getObject fun(self: Character13b.ExSkill1CubeManager): Character13b.ExSkill1Cube キューブのインスタンスを生成して返す
---@field public spawn fun(self: Character13b.ExSkill1CubeManager) キューブをスポーンさせる
local ExSkill1CubeManager = {
    ---コンストラクタ
    ---@return Character13b.ExSkill1CubeManager
    new = function ()
        ---@type Character13b.ExSkill1CubeManager
        local instance = MiscUtils.instantiate(Character13b_ExSkill1CubeManager, SpawnObjectManager)

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
    ---@return Character13b.ExSkill1Cube instance 生成したインスタンス
    getObject = function (_)
        return Character13b_ExSkill1Cube.new()
    end;

    ---キューブをスポーンさせる。
    ---@param self Character13b.ExSkill1CubeManager
    spawn = function (self)
        SpawnObjectManager.spawn(self)
    end;
}

return ExSkill1CubeManager
