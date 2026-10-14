---@class Character10b.TankShellManager : SpawnObjectManager 視覚的な砲弾オブジェクトを管理するクラス
---@field public new fun(): Character10b.TankShellManager コンストラクタ
---@field public getObject fun(self: Character10b.TankShellManager, startPos: Vector3, rot: Vector3): Character10b.TankShell 砲弾のインスタンスを生成して返す
---@field public spawn fun(self: Character10b.TankShellManager, startPos: Vector3, rot: Vector3) 砲弾をスポーンさせる
local TankShellManager = {
    ---コンストラクタ
    ---@return Character10b.TankShellManager
    new = function ()
        ---@type Character10b.TankShellManager
        local instance = MiscUtils.instantiate(TankShellManager, SpawnObjectManager)

        instance.managerName = "tank_shell"

        return instance
    end;

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_tank_shell", "World")
    end;

    ---砲弾のインスタンスを生成して返す。
    ---@param startPos Vector3 砲弾の出現位置
    ---@param rot Vector3 砲弾が飛んでいく方向
    ---@return  Character10b.TankShell instance 生成したインスタンス
    getObject = function (_, startPos, rot)
        return TankShell.new(startPos, rot)
    end;

    ---砲弾をスポーンさせる。
    ---@param self Character10b.TankShellManager
    ---@param startPos Vector3 砲弾の出現位置
    ---@param rot Vector3 砲弾が飛んでいく方向
    spawn = function (self, startPos, rot)
        SpawnObjectManager.spawn(self, startPos, rot)
    end;
}

return TankShellManager
