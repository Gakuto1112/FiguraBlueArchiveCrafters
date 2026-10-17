---@class Character06c.DroneMissileManager : SpawnObjectManager 視覚的なミサイルオブジェクトを管理するクラス
---@field public new fun(): Character06c.DroneMissileManager コンストラクタ
---@field public init fun(self: Character06c.DroneMissileManager) 初期化関数
---@field public getObject fun(self: Character06c.DroneMissileManager, startPos: Vector3, rot: Vector3): Character06c.DroneMissile ミサイルのインスタンスを生成して返す
---@field public spawn fun(self: Character06c.DroneMissileManager, startPos: Vector3, rot: Vector3) ミサイルをスポーンさせる
local DroneMissileManager = {
    ---コンストラクタ
    ---@return Character06c.DroneMissileManager
    new = function ()
        ---@type Character06c.DroneMissileManager
        local instance = MiscUtils.instantiate(Character06c_DroneMissileManager, SpawnObjectManager)

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
    ---@return  Character06c.DroneMissile instance 生成したインスタンス
    getObject = function (_, startPos, rot)
        return Character06c_DroneMissile.new(startPos, rot)
    end;

    ---ミサイルをスポーンさせる。
    ---@param self Character06c.DroneMissileManager
    ---@param startPos Vector3 ミサイルの出現位置
    ---@param rot Vector3 ミサイルが飛んでいく方向
    spawn = function (self, startPos, rot)
        SpawnObjectManager.spawn(self, startPos, rot)
    end;
}

return DroneMissileManager
