---設置物の設置モードの列挙型
---@alias PlacementObjectManager.PlacementMode
---| "COPY" # コピーモード。BBアニメーションは使えないが、複数の設置物を設置可能。
---| "MOVE" # 移動モード。同時に1つしか設置物を設置できないが、BBアニメーションが使える。

---設置物が削除された理由の列挙型
---@alias PlacementObjectManager.RemoveReason
---| "REMOVED_BY_SCRIPTS" # スクリプトによって削除
---| "OVERLAPPED" # 設置物がブロックと重なって削除
---| "BURNT" # 炎に焼かれて削除
---| "TOO_LOW" # 設置物のY座標が低過ぎて削除
---| "TOO_HIGH" # 設置物のY座標が高過ぎて削除

---@class (exact) PlacementObjectManager : SpawnObjectManager 設置物を管理するマネージャークラス
---@field public objects PlacementObject[] インスタンスで制御するオブジェクト
---@field public getObject fun(self: PlacementObjectManager, index: integer, pos: Vector3, rot: number): PlacementObject 設置物のインスタンスを生成して返す
---@field public spawn fun(self: PlacementObjectManager, index: integer, pos: Vector3, rot: number) 設置物を設置する
---@field public applyFunc fun(self: PlacementObjectManager, index: integer, func: fun(object: PlacementObject, i: integer)) 設置済み設置物の指定した設置物データのインデックス番号のみに関数を適用する

PlacementObjectManager = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return PlacementObjectManager
    new = function (parent)
        ---@type PlacementObjectManager
        local instance = Avatar.instantiate(PlacementObjectManager, SpawnObjectManager, parent)

        instance.managerName = "placement_object"

        return instance
    end;

    ---初期化関数
    ---@param self PlacementObjectManager
    init = function (self)
        SpawnObjectManager.init(self)

        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_placement_object", "World")
        for _, data in ipairs(self.parent.characterData.placementObjects) do
            if data.placementMode == "MOVE" then
                data.model = data.model:moveTo(models.script_placement_object)
                data.model:setVisible(false)
            end
        end
    end;


    ---設置物のインスタンスを生成して返す。
    ---@param self PlacementObjectManager
    ---@param index integer 設置物データのインデックス番号
    ---@param pos Vector3 設置物を設置するワールド座標
    ---@param rot number 設置物を設置するワールド方向（Y軸のみ）
    ---@return PlacementObject instance 生成したインスタンス
    getObject = function (self, index, pos, rot)
        if self.parent.characterData.placementObjects[index].placementMode == "MOVE" then
            for i, placementObject in ipairs(self.objects) do
                if placementObject.index == index then
                    self:remove(i)
                    break
                end
            end
        end
        return PlacementObject.new(self.parent, index, pos, rot)
    end;

    ---設置物を設置する。
    ---@param self PlacementObjectManager
    ---@param index integer 設置物データのインデックス番号
    ---@param pos Vector3 設置物を設置するワールド座標
    ---@param rot number 設置物を設置するワールド方向（Y軸のみ）
    spawn = function (self, index, pos, rot)
        SpawnObjectManager.spawn(self, index, pos, rot)
    end;

    ---設置済み設置物の、指定した設置物データのインデックス番号のみに関数を適用する。
    ---@param self PlacementObjectManager
    ---@param index integer 関数実行対象の設置物データのインデックス番号
    ---@param func fun(object: PlacementObject, i: integer) 実行する関数
    applyFunc = function (self, index, func)
        for i, obj in ipairs(self.objects) do
            if obj.index == index then
                func(obj, i)
            end
        end
    end;
}