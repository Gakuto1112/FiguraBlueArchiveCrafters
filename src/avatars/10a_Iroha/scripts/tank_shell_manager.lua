---@class TankShellManager : SpawnObjectManager 視覚的な砲弾オブジェクトを管理するクラス
---@field public new fun(): TankShellManager コンストラクタ
---@field public getObject fun(self: TankShellManager, startPos: Vector3, rot: Vector3): TankShell 砲弾のインスタンスを生成して返す
---@field public spawn fun(self: TankShellManager, startPos: Vector3, rot: Vector3) 砲弾をスポーンさせる
local TankShellManager = {
    ---コンストラクタ
    ---@return TankShellManager
    new = function ()
        ---@type TankShellManager
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
    ---@return  TankShell instance 生成したインスタンス
    getObject = function (_, startPos, rot)
        return TankShell.new(startPos, rot)
    end;

    ---砲弾をスポーンさせる。
    ---@param self TankShellManager
    ---@param startPos Vector3 砲弾の出現位置
    ---@param rot Vector3 砲弾が飛んでいく方向
    spawn = function (self, startPos, rot)
        SpawnObjectManager.spawn(self, startPos, rot)
    end;
}

return TankShellManager
