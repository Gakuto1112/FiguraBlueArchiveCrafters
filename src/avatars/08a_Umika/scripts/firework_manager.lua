---@class FireworkManager : SpawnObjectManager 花火台から打たれる花火を管理するクラス
---@field public getObject fun(self: FireworkManager, startPos: Vector3, rot: Vector3): Firework 花火のインスタンスを生成して返す
---@field public spawn fun(self: FireworkManager, startPos: Vector3, rot: Vector3) 花火をスポーンさせる
local FireworkManager = {
    ---コンストラクタ
    ---@return FireworkManager
    new = function ()
        ---@type FireworkManager
        local instance = MiscUtils.instantiate(FireworkManager, SpawnObjectManager)

        instance.managerName = "firework"

        return instance
    end;

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_firework", "World")
    end;

    ---花火のインスタンスを生成して返す。
    ---@param startPos Vector3 花火の出現位置
    ---@param rot Vector3 花火が飛んでいく方向
    ---@return Firework instance 生成したインスタンス
    getObject = function (_, startPos, rot)
        return Firework.new(startPos, rot)
    end;

    ---花火をスポーンさせる。
    ---@param self FireworkManager
    ---@param startPos Vector3 花火の出現位置
    ---@param rot Vector3 花火が飛んでいく方向
    spawn = function (self, startPos, rot)
        SpawnObjectManager.spawn(self, startPos, rot)
    end;
}

return FireworkManager
