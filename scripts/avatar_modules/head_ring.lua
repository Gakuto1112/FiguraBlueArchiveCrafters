---@class HeadRing : AvatarModule ヘイロー（頭の輪っか）を制御するクラス
---@field package parent Avatar アバターのメインクラスへの参照
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

        events.TICK:register(function ()
            if not client:isPaused() then
                --移動平均値の算出
                local headRot = instance.parent.exSkill.animationCount > -1 and models.models.main.Avatar.Head:getAnimRot().x or math.deg(math.asin(player:getLookDir().y))
                local headRotAverage = instance.headRotAverage[2]
                headRotAverage = (#instance.headRotData * headRotAverage + headRot) / (#instance.headRotData + 1)
                table.insert(instance.headRotData, headRot)
                --古いデータの切り捨て
                if #instance.headRotData > 5 then
                    headRotAverage = (#instance.headRotData * headRotAverage - instance.headRotData[1]) / (#instance.headRotData - 1)
                    table.remove(instance.headRotData, 1)
                end
                table.insert(instance.headRotAverage, headRotAverage)
                table.remove(instance.headRotAverage, 1)
            end
        end)

        events.WORLD_TICK:register(function ()
            if not client:isPaused() then
                instance.floatCount = instance.floatCount + 1
                instance.floatCount = instance.floatCount == 80 and 0 or instance.floatCount
            end
        end)

        events.RENDER:register(function (delta)
            if not client:isPaused() then
                --ヘイローの位置・角度を設定
                local playerPose = player:getPose()
                local headRot = instance.parent.physics.getValueBetweenTicks(instance.headRotAverage, delta)
                local floatOffset = math.sin((instance.floatCount + delta) / 80 * 2 * math.pi) * 0.25
                if playerPose == "SWIMMING" or playerPose == "FALL_FLYING" then
                    models.models.main.Avatar.Head.HeadRing:setPos(instance.parent.physics.velocityAverage[3][2] * 3, math.cos(math.rad(headRot)) * instance.parent.physics.velocityAverage[1][2] * -1 + math.sin(math.rad(headRot)) * instance.parent.physics.velocityAverage[2][2] * -1 + floatOffset, math.cos(math.rad(headRot)) * instance.parent.physics.velocityAverage[2][2] * -3 + math.sin(math.rad(headRot)) * instance.parent.physics.velocityAverage[1][2])
                else
                    models.models.main.Avatar.Head.HeadRing:setPos(instance.parent.physics.velocityAverage[3][2] * -3, math.cos(math.rad(headRot)) * instance.parent.physics.velocityAverage[2][2] * -1 + math.sin(math.rad(headRot)) * instance.parent.physics.velocityAverage[1][2] + floatOffset, math.cos(math.rad(headRot)) * instance.parent.physics.velocityAverage[1][2] * 3 + math.sin(math.rad(headRot)) * instance.parent.physics.velocityAverage[2][2])
                end
                if instance.parent.deathAnimation.dummyAvatarRoot ~= nil then
                    instance.parent.deathAnimation.dummyAvatarRoot.Head.HeadRing:setPos(0, floatOffset, 0)
                end
                models.models.main.Avatar.Head.HeadRing:setRot(headRot - (instance.parent.exSkill.animationCount > -1 and models.models.main.Avatar.Head:getAnimRot().x or math.deg(math.asin(player:getLookDir().y))), 0, 0)
            end
        end)

        events.WORLD_RENDER:register(function (delta)
            if not client:isPaused() then
                --models.script_head_block.Head.HeadRing:setPos(0, math.sin(self.FloatCount / 80 * 2 * math.pi) * 0.25, 0)
            end
        end)

        models.models.main.Avatar.Head.HeadRing:setLight(15)

        return instance
    end;
}