---@class (exact) ExSkill1WaterManager : SpawnObjectManager Exスキル1で使用する水スプライトを管理するクラス
---@field public objects ExSkill1Water[] インスタンスで制御するオブジェクト
---@field package getObject fun(self: ExSkill1WaterManager, pos: Vector3, velocity: Vector3): ExSkill1Water 水スプライトのインスタンスを生成して返す
---@field public spawn fun(self: ExSkill1WaterManager, pos: Vector3, velocity: Vector3) 水スプライトスポーンさせる
local ExSkill1WaterManager = {
    ---コンストラクタ
    ---@return ExSkill1WaterManager
    new = function ()
        ---@type ExSkill1WaterManager
        local instance = MiscUtils.instantiate(ExSkill1WaterManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_water"

        return instance
    end;

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_ex_skill_1_water", "World")
        models.models.ex_skill_1.Water:setPrimaryTexture("RESOURCE", "minecraft:textures/block/water_still.png")
    end;

    ---水スプライトのインスタンスを生成して返す。
    ---@param pos Vector3 水スプライトをスポーンさせるワールド座標
    ---@param velocity Vector3 水スプライトを移動させる速度
    ---@return ExSkill1Water instance 生成したインスタンス
    getObject = function (_, pos, velocity)
        return ExSkill1Water.new(pos, velocity)
    end;

    ---水スプライトをスポーンさせる。
    ---@param self ExSkill1WaterManager
    ---@param pos Vector3 水スプライトをスポーンさせるワールド座標
    ---@param velocity Vector3 水スプライトを移動させる速度
    spawn = function (self, pos, velocity)
        SpawnObjectManager.spawn(self, pos, velocity)
    end;
}

return ExSkill1WaterManager