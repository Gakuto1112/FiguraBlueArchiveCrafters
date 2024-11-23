---@class (exact) HeadRing : AvatarModule ヘイロー（頭の輪っか）を制御するクラス
---@field package initialHaloRot number ヘイローの初期角度
---@field package headRotData number[] 一定期間内の頭の角度を保持するテーブル
---@field package headRotAverage number[] 頭の角度の移動平均値
---@field package floatCount integer ヘイローが上下するアニメーションのカウンター

HeadRing = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return HeadRing
    new = function (parent)
        ---@type HeadRing
        local instance = Avatar.instantiate(HeadRing, AvatarModule, parent)

        instance.initialHaloRot = models.models.main.Avatar.Head.HeadRing:getRot().x
        instance.haloRotPrev = instance.initialHaloRot
        instance.headRotData = {}
        instance.headRotAverage = {0, 0}
        instance.floatCount = 0

        return instance
    end;

    ---初期化関数
    ---@param self HeadRing
    init = function (self)
        AvatarModule.init(self)
        events.TICK:register(function ()
            if not client:isPaused() then
                --移動平均値の算出
                local headRot = self.parent.exSkill.animationCount > -1 and models.models.main.Avatar.Head:getAnimRot().x or math.deg(math.asin(player:getLookDir().y))
                local headRotAverage = self.headRotAverage[2]
                headRotAverage = (#self.headRotData * headRotAverage + headRot) / (#self.headRotData + 1)
                table.insert(self.headRotData, headRot)
                --古いデータの切り捨て
                if #self.headRotData > 5 then
                    headRotAverage = (#self.headRotData * headRotAverage - self.headRotData[1]) / (#self.headRotData - 1)
                    table.remove(self.headRotData, 1)
                end
                table.insert(self.headRotAverage, headRotAverage)
                table.remove(self.headRotAverage, 1)
            end
        end)

        events.WORLD_TICK:register(function ()
            if not client:isPaused() then
                self.floatCount = self.floatCount + 1
                self.floatCount = self.floatCount == 80 and 0 or self.floatCount
            end
        end)

        events.RENDER:register(function (delta)
            if not client:isPaused() then
                --ヘイローの位置・角度を設定
                local playerPose = player:getPose()
                local headRot = self.parent.physics.getValueBetweenTicks(self.headRotAverage, delta)
                local floatOffset = math.sin((self.floatCount + delta) / 80 * 2 * math.pi) * 0.25
                if playerPose == "SWIMMING" or playerPose == "FALL_FLYING" then
                    models.models.main.Avatar.Head.HeadRing:setPos(self.parent.physics.velocityAverage[3][2] * 3, math.cos(math.rad(headRot)) * self.parent.physics.velocityAverage[1][2] * -1 + math.sin(math.rad(headRot)) * self.parent.physics.velocityAverage[2][2] * -1 + floatOffset, math.cos(math.rad(headRot)) * self.parent.physics.velocityAverage[2][2] * -3 + math.sin(math.rad(headRot)) * self.parent.physics.velocityAverage[1][2])
                else
                    models.models.main.Avatar.Head.HeadRing:setPos(self.parent.physics.velocityAverage[3][2] * -3, math.cos(math.rad(headRot)) * self.parent.physics.velocityAverage[2][2] * -1 + math.sin(math.rad(headRot)) * self.parent.physics.velocityAverage[1][2] + floatOffset, math.cos(math.rad(headRot)) * self.parent.physics.velocityAverage[1][2] * 3 + math.sin(math.rad(headRot)) * self.parent.physics.velocityAverage[2][2])
                end
                if self.parent.deathAnimation.dummyAvatarRoot ~= nil then
                    self.parent.deathAnimation.dummyAvatarRoot.Head.HeadRing:setPos(0, floatOffset, 0)
                end
                models.models.main.Avatar.Head.HeadRing:setRot(headRot - (self.parent.exSkill.animationCount > -1 and models.models.main.Avatar.Head:getAnimRot().x or math.deg(math.asin(player:getLookDir().y))) + self.initialHaloRot, 0, 0)
            end
        end)

        events.WORLD_RENDER:register(function (delta)
            if not client:isPaused() and models.script_head_block.Head ~= nil and models.script_head_block.Head.HeadRing ~= nil then
                models.script_head_block.Head.HeadRing:setPos(0, math.sin((self.floatCount + delta) / 80 * 2 * math.pi) * 0.25, 0)
            end
        end)

        models.models.main.Avatar.Head.HeadRing:setLight(15)
    end;
}