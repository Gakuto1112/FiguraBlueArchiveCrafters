---@class Character06b.DroneMissileManager : SpawnObjectManager 視覚的なミサイルオブジェクトを管理するクラス
---@field public new fun(): Character06b.DroneMissileManager コンストラクタ
---@field public init fun(self: Character06b.DroneMissileManager) 初期化関数
---@field public getObject fun(self: Character06b.DroneMissileManager, startPos: Vector3, rot: Vector3): Character06b.DroneMissile ミサイルのインスタンスを生成して返す
---@field public spawn fun(self: Character06b.DroneMissileManager, startPos: Vector3, rot: Vector3) ミサイルをスポーンさせる
local DroneMissileManager = {
    ---コンストラクタ
    ---@return Character06b.DroneMissileManager
    new = function ()
        ---@type Character06b.DroneMissileManager
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
    ---@return  Character06b.DroneMissile instance 生成したインスタンス
    getObject = function (_, startPos, rot)
        return DroneMissile.new(startPos, rot)
    end;

    ---ミサイルをスポーンさせる。
    ---@param self Character06b.DroneMissileManager
    ---@param startPos Vector3 ミサイルの出現位置
    ---@param rot Vector3 ミサイルが飛んでいく方向
    spawn = function (self, startPos, rot)
        SpawnObjectManager.spawn(self, startPos, rot)
    end;
}

return DroneMissileManager
