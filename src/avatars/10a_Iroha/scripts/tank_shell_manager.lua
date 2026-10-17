---@class Character10a.TankShellManager : SpawnObjectManager 視覚的な砲弾オブジェクトを管理するクラス
---@field public new fun(): Character10a.TankShellManager コンストラクタ
---@field public getObject fun(self: Character10a.TankShellManager, startPos: Vector3, rot: Vector3): Character10a.TankShell 砲弾のインスタンスを生成して返す
---@field public spawn fun(self: Character10a.TankShellManager, startPos: Vector3, rot: Vector3) 砲弾をスポーンさせる
local TankShellManager = {
    ---コンストラクタ
    ---@return Character10a.TankShellManager
    new = function ()
        ---@type Character10a.TankShellManager
        local instance = MiscUtils.instantiate(Character10a_TankShellManager, SpawnObjectManager)

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
    ---@return  Character10a.TankShell instance 生成したインスタンス
    getObject = function (_, startPos, rot)
        return Character10a_TankShell.new(startPos, rot)
    end;

    ---砲弾をスポーンさせる。
    ---@param self Character10a.TankShellManager
    ---@param startPos Vector3 砲弾の出現位置
    ---@param rot Vector3 砲弾が飛んでいく方向
    spawn = function (self, startPos, rot)
        SpawnObjectManager.spawn(self, startPos, rot)
    end;
}

return TankShellManager
