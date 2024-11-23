---@class (exact) Barrier : AvatarModule バリアの視覚効果を管理するクラス
---@field package animationCounts number[] バリアのアニメーションのカウンター
---@field public isBarrierVisible boolean バリアが可視化状態かどうか
---@field package hadAbsorptionPrev boolean 前ティックの衝撃吸収のハートを持っていたかどうか
---@field package colorFactor number バリアの色の係数
---@field public enable fun(self: Barrier) バリア機能を有効にする
---@field public disable fun(self: Barrier) バリア機能を無効にする

Barrier = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Barrier
    new = function (parent)
        ---@type Barrier
        local instance = Avatar.instantiate(Barrier, AvatarModule, parent)

        instance.animationCounts = {}
        instance.isBarrierVisible = false
        instance.hadAbsorptionPrev = false
        instance.colorFactor = client:hasShaderPack() and 0.5 or 1

        for i = 1, 32 do
            instance.animationCounts[i] = math.random(0, 39)
        end

        return instance
    end;

    ---初期化関数
    ---@param self Barrier
    init = function (self)
        AvatarModule.init(self)

        models.models.main.Avatar.barrier:setLight(15)

        events.TICK:register(function ()
            local hasAbsorption = player:getAbsorptionAmount() > 0 and player:getHealth() > 0
            if hasAbsorption and not self.hadAbsorptionPrev then
                self:enable()
            elseif not hasAbsorption and self.hadAbsorptionPrev then
                self:disable()
            end
            self.hadAbsorptionPrev = hasAbsorption
        end)
    end;

    ---バリア機能を有効にする。
    ---@param self Barrier
    enable = function (self)
        for i = 1, 32 do
            self.animationCounts[i] = math.random(0, 39)
        end

        events.TICK:register(function ()
            for i = 1, 32 do
                self.animationCounts[i] = self.animationCounts[i] + 1
                if self.animationCounts[i] == 40 then
                    self.animationCounts[i] = 0
                end
            end
            self.colorFactor = client:hasShaderPack() and 0.5 or 1
        end, "barrier_tick")

        events.RENDER:register(function (delta, context)
            if context == "FIRST_PERSON" or context == "RENDER" then
                models.models.main.Avatar.barrier:setVisible(true)
                for i = 1, 32 do
                    local opacity = math.abs(-0.025 * (self.animationCounts[i] + delta) + 0.5) + 0.5
                    models.models.main.Avatar.barrier.Barrier["Barrier"..i]:setOpacity(opacity)
                    models.models.main.Avatar.barrier.Barrier["Barrier"..i]:setColor(opacity * self.colorFactor, opacity * self.colorFactor, 1)
                end
            else
                models.models.main.Avatar.barrier:setVisible(false)
            end
        end, "barrier_render")

        self.isBarrierVisible = true
    end;

    ---バリア機能を無効にする。
    ---@param self Barrier
    disable = function (self)
        models.models.main.Avatar.barrier:setVisible(false)
        events.TICK:remove("barrier_tick")
        events.RENDER:remove("barrier_render")
        self.isBarrierVisible = false
    end;
}