---@class DroneMissileManager : SpawnObjectManager 視覚的なミサイルオブジェクトを管理するクラス
---@field public new fun(): DroneMissileManager コンストラクタ
---@field public init fun(self: DroneMissileManager) 初期化関数
---@field public getObject fun(self: DroneMissileManager, startPos: Vector3, rot: Vector3): DroneMissile ミサイルのインスタンスを生成して返す
---@field public spawn fun(self: DroneMissileManager, startPos: Vector3, rot: Vector3) ミサイルをスポーンさせる
local DroneMissileManager = {
    ---コンストラクタ
    ---@return DroneMissileManager
    new = function ()
        ---@type DroneMissileManager
        local instance = MiscUtils.instantiate(DroneMissileManager, SpawnObjectManager)

        instance.managerName = "drone_missile"

        return instance
    end;

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_drone_missile", "World")
    end;

    ---ミサイルのインスタンスを生成して返す。
    ---@param startPos Vector3 ミサイルの出現位置
    ---@param rot Vector3 ミサイルが飛んでいく方向
    ---@return  DroneMissile instance 生成したインスタンス
    getObject = function (_, startPos, rot)
        return DroneMissile.new(startPos, rot)
    end;

    ---ミサイルをスポーンさせる。
    ---@param self DroneMissileManager
    ---@param startPos Vector3 ミサイルの出現位置
    ---@param rot Vector3 ミサイルが飛んでいく方向
    spawn = function (self, startPos, rot)
        SpawnObjectManager.spawn(self, startPos, rot)
    end;
}

return DroneMissileManager
