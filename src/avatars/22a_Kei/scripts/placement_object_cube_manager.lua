---@class (exact) PlacementObjectCubeManager : SpawnObjectManager 設置物で使用するキューブのオブジェクトのマネージャークラス
---@field public objects PlacementObjectCube[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: PlacementObjectCubeManager, target: ModelPart, pos: Vector3, color: Vector3): PlacementObjectCube 設置物キューブのインスタンスを生成して返す
---@field public spawn fun(self: PlacementObjectCubeManager, target: ModelPart, pos: Vector3, color: Vector3) 設置物キューブをスポーンさせる
local PlacementObjectCubeManager = {
    ---コンストラクタ
    ---@return PlacementObjectCubeManager
    new = function ()
        ---@type PlacementObjectCubeManager
        local instance = MiscUtils.instantiate(PlacementObjectCubeManager, SpawnObjectManager)

        instance.managerName = "placement_object_cube"

        return instance
    end;

    ---設置物キューブのインスタンスを生成して返す。
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param color Vector3 キューブの色
    ---@return ExSkillSprite instance 生成したインスタンス
    getObject = function (_, target, pos, color)
        return PlacementObjectCube.new(target, pos, color)
    end;

    ---設置物キューブをスポーンさせる。
    ---@param self PlacementObjectCubeManager
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param color Vector3 キューブの色
    spawn = function (self, target, pos, color)
        SpawnObjectManager.spawn(self, target, pos, color)
    end;
}

return PlacementObjectCubeManager
