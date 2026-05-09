---@class (exact) PlacementObjectTile : SpawnObject 設置物で使用するタイルオブジェクトのクラス
---@field package object ModelPart インスタンスで制御するモデル
---@field package target ModelPart インスタンスオブジェクトをアタッチする親モデル
---@field package currentPos Vector3 タイルの現在位置
---@field package nextPos Vector3 タイルの次ティックの位置
---@field package rot Vector3 タイルをスポーンさせる向き
---@field package color Vector3 タイルの色
---@field package lifetimeCount integer タイルの残り時間を計るカウンター
---@field package shouldFadeOut boolean タイルが消える前にフェードアウトさせるかどうか
---@field package baseOpacity number タイルの基礎透明度
---@field package dummy boolean ダミーモード（透明度100でオブジェクト生成）
---@field public new fun(target: ModelPart, pos: Vector3, rot: Vector3, color: Vector3, lifetime: integer, shouldFadeOut: boolean, dummy: boolean): PlacementObjectTile コンストラクター
local PlacementObjectTile = {
    ---コンストラクタ
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param rot Vector3 タイルをスポーンさせる向き
    ---@param color Vector3 タイルの色
    ---@param lifetime integer タイルの表示時間
    ---@param shouldFadeOut boolean タイルをフェードアウトさせるまでの時間。負の数で無効化。
    ---@param dummy boolean ダミーモード（透明度100でオブジェクト生成）
    ---@return PlacementObjectTile
    new = function (target, pos, rot, color, lifetime, shouldFadeOut, dummy)
        ---@type PlacementObjectTile
        local instance = MiscUtils.instantiate(PlacementObjectTile, SpawnObject)

        instance.target = target
        instance.object = models.models.placement_object.FieldTile:copy(instance.uuid)
        instance.currentPos = pos:copy()
        instance.nextPos = instance.currentPos:copy()
        instance.rot = rot:copy()
        instance.color = color:copy()
        instance.lifetimeCount = lifetime
        instance.shouldFadeOut = shouldFadeOut
        instance.baseOpacity = math.random()
        instance.dummy = dummy

        instance.callbacks = {
            ---@param self PlacementObjectTile
            onInit = function (self)
                if not self.dummy then
                    self.target:addChild(self.object)
                end
                self.object:setPos(self.currentPos)
                self.object:setRot(self.rot)
                self.object:setUVPixels(math.random() <= 0.75 and 0 or 6, 0)
                self.object:setColor(self.color)
                self.object:setOpacity(self.baseOpacity)
                self.object:setVisible(true)
            end;

            ---@param self PlacementObjectTile
            onDeinit = function (self)
                if not self.dummy then
                    self.target:removeChild(self.object)
                end
                self.object:remove()
            end;

            ---@param self PlacementObjectTile
            onTick = function (self)
                --オブジェクトの位置を強制更新
                self.object:setPos(self.nextPos)
                self.currentPos = self.nextPos

                --次のオブジェクトの位置を計算
                self.nextPos = self.currentPos:copy():add(vectors.rotateAroundAxis(self.rot.x, 0, 0, -0.5, 1, 0, 0))

                if self.shouldFadeOut and self.lifetimeCount < 50 then
                    self.object:setOpacity(self.baseOpacity * (self.lifetimeCount / 50))
                end

                --オブジェクトの残り時間を更新
                if self.lifetimeCount <= 0 then
                    self.shouldDeinit = true
                end
                self.lifetimeCount = self.lifetimeCount - 1
            end;

            ---@param self PlacementObjectTile
            onRender = function (self, delta)
                self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos))
            end;
        }

        return instance
    end;
}

return PlacementObjectTile
