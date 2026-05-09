---@class (exact) PlacementObjectTileManager : SpawnObjectManager 設置物で使用するタイルのオブジェクトのマネージャークラス
---@field public objects PlacementObjectTile[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: PlacementObjectTileManager, target: ModelPart, pos: Vector3, rot: Vector3, color: Vector3, lifetime: integer, shouldFadeOut: boolean, dummy: boolean): PlacementObjectTile 設置物タイルのインスタンスを生成して返す
---@field public spawn fun(self: PlacementObjectTileManager, target: ModelPart, pos: Vector3, rot: Vector3, color: Vector3, lifetime: integer, shouldFadeOut: boolean, dummy: boolean) 設置物タイルをスポーンさせる
local PlacementObjectTileManager = {
    ---コンストラクタ
    ---@return PlacementObjectTileManager
    new = function ()
        ---@type PlacementObjectTileManager
        local instance = MiscUtils.instantiate(PlacementObjectTileManager, SpawnObjectManager)

        instance.managerName = "placement_object_tile"

        return instance
    end;

    ---設置物タイルのインスタンスを生成して返す。
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param rot Vector3 タイルをスポーンさせる向き
    ---@param color Vector3 タイルの色
    ---@param lifetime integer タイルの表示時間
    ---@param shouldFadeOut boolean タイルが消える前にフェードアウトさせるかどうか
    ---@param dummy boolean ダミーモード（透明度100でオブジェクト生成）
    ---@return ExSkillSprite instance 生成したインスタンス
    getObject = function (_, target, pos, rot, color, lifetime, shouldFadeOut, dummy)
        return PlacementObjectTile.new(target, pos, rot, color, lifetime, shouldFadeOut, dummy)
    end;

    ---設置物タイルをスポーンさせる。
    ---@param self PlacementObjectTileManager
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param rot Vector3 タイルをスポーンさせる向き
    ---@param color Vector3 タイルの色
    ---@param lifetime integer タイルの表示時間
    ---@param shouldFadeOut boolean タイルが消える前にフェードアウトさせるかどうか
    ---@param dummy boolean ダミーモード（透明度100でオブジェクト生成）
    spawn = function (self, target, pos, rot, color, lifetime, shouldFadeOut, dummy)
        SpawnObjectManager.spawn(self, target, pos, rot, color, lifetime, shouldFadeOut, dummy)
    end;
}

return PlacementObjectTileManager
