---@class (exact) PlacementObjectCube : SpawnObject 設置物で使用するキューブオブジェクトのクラス
---@field package object ModelPart インスタンスで制御するモデル
---@field package target ModelPart インスタンスオブジェクトをアタッチする親モデル
---@field package pos Vector3 キューブの出現位置
---@field package currentScale Vector3 キューブの現在スケール
---@field package nextScale Vector3 キューブの次ティックのスケール
---@field package color Vector3 キューブの色
---@field package length integer アニメーションの長さ
---@field package lifetimeCount integer キューブの残り時間を計るカウンター
---@field public new fun(target: ModelPart, pos: Vector3, color: Vector3): PlacementObjectCube コンストラクター
local PlacementObjectCube = {
    ---コンストラクタ
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@param color Vector3 キューブの色
    ---@return PlacementObjectCube
    new = function (target, pos, color)
        ---@type PlacementObjectCube
        local instance = MiscUtils.instantiate(PlacementObjectCube, SpawnObject)

        instance.target = target
        instance.object = models.models.placement_object.FieldCube:copy(instance.uuid)
        instance.pos = pos:copy()
		instance.currentScale = vectors.vec3(1, 0, 1)
        instance.nextScale = instance.currentScale:copy()
        instance.color = color:copy()
		instance.length = math.random(10, 15)
        instance.lifetimeCount = instance.length

        instance.callbacks = {
            ---@param self PlacementObjectCube
            onInit = function (self)
                if not self.dummy then
                    self.target:addChild(self.object)
                end
                self.object:setPos(self.pos)
                self.object:setColor(self.color)
                self.object:setVisible(true)
            end;

            ---@param self PlacementObjectCube
            onDeinit = function (self)
                if not self.dummy then
                    self.target:removeChild(self.object)
                end
                self.object:remove()
            end;

            ---@param self PlacementObjectCube
            onTick = function (self)
                --オブジェクトのスケールを強制更新
                self.object:setScale(self.nextScale)
                self.currentScale = self.nextScale

                --次のオブジェクトのスケールを計算
				self.nextScale = vectors.vec3(1, (4 / math.pow(self.length, 2)) * -1 * math.pow(self.lifetimeCount, 2) + (4 / self.length) * self.lifetimeCount, 1)

                --オブジェクトの残り時間を更新
                if self.lifetimeCount <= 0 then
                    self.shouldDeinit = true
                end
                self.lifetimeCount = self.lifetimeCount - 1
            end;

            ---@param self PlacementObjectCube
            onRender = function (self, delta)
                self.object:setScale(self.nextScale:copy():sub(self.currentScale):scale(delta):add(self.currentScale))
            end;
        }

        return instance
    end;
}

return PlacementObjectCube
