---@class (exact) Character22a.PlacementObjectCubeManager : SpawnObjectManager 設置物で使用するキューブのオブジェクトのマネージャークラス
---@field public objects Character22a.PlacementObjectCube[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: Character22a.PlacementObjectCubeManager, target: ModelPart, pos: Vector3, color: Vector3): Character22a.PlacementObjectCube 設置物キューブのインスタンスを生成して返す
---@field public spawn fun(self: Character22a.PlacementObjectCubeManager, target: ModelPart, pos: Vector3, color: Vector3) 設置物キューブをスポーンさせる
local PlacementObjectCubeManager = {
    ---コンストラクタ
    ---@return Character22a.PlacementObjectCubeManager
    new = function ()
        ---@type Character22a.PlacementObjectCubeManager
        local instance = MiscUtils.instantiate(Character22a_PlacementObjectCubeManager, SpawnObjectManager)

        instance.managerName = "placement_object_cube"

        return instance
    end;

    ---設置物キューブのインスタンスを生成して返す。
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param color Vector3 キューブの色
    ---@return Character22a.PlacementObjectCube  instance 生成したインスタンス
    getObject = function (_, target, pos, color)
        return Character22a_PlacementObjectCube.new(target, pos, color)
    end;

    ---設置物キューブをスポーンさせる。
    ---@param self Character22a.PlacementObjectCubeManager
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param color Vector3 キューブの色
    spawn = function (self, target, pos, color)
        SpawnObjectManager.spawn(self, target, pos, color)
    end;
}

return PlacementObjectCubeManager
