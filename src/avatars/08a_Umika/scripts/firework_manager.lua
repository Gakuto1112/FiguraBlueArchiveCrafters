---@class Character08a.FireworkManager : SpawnObjectManager 花火台から打たれる花火を管理するクラス
---@field public getObject fun(self: Character08a.FireworkManager, startPos: Vector3, rot: Vector3): Character08a.Firework 花火のインスタンスを生成して返す
---@field public spawn fun(self: Character08a.FireworkManager, startPos: Vector3, rot: Vector3) 花火をスポーンさせる
local FireworkManager = {
    ---コンストラクタ
    ---@return Character08a.FireworkManager
    new = function ()
        ---@type Character08a.FireworkManager
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
    ---@return Character08a.Firework instance 生成したインスタンス
    getObject = function (_, startPos, rot)
        return Firework.new(startPos, rot)
    end;

    ---花火をスポーンさせる。
    ---@param self Character08a.FireworkManager
    ---@param startPos Vector3 花火の出現位置
    ---@param rot Vector3 花火が飛んでいく方向
    spawn = function (self, startPos, rot)
        SpawnObjectManager.spawn(self, startPos, rot)
    end;
}

return FireworkManager
