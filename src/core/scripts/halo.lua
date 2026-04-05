---@class (exact) Halo ヘイロー（頭の輪っか）を制御するクラス
---@field public initialHaloRot number ヘイローの初期角度
---@field package headRotData number[] 一定期間内の頭の角度を保持するテーブル
---@field package headRotAverage number[] 頭の角度の移動平均値
---@field package floatCount integer ヘイローが上下するアニメーションのカウンター
---@field package isForceRenderMode boolean ヘイローが強制レンダリングモードになっているかどうか
---@field package didSleepPrev boolean 前ティックに寝ていたかどうか
local Halo = {
	initialHaloRot = 0;
	headRotData = {};
	headRotAverage = {0, 0};
	floatCount = 0;
	isForceRenderMode = false;
	didSleepPrev = false;

    ---初期化関数
    ---@param self Halo
    init = function (self)
		self.initialHaloRot = ModelAlias.alias.avatar.halo:getRot().x
        self.floatCount = math.random(0, 80)

        events.TICK:register(function ()
            if not client:isPaused() then
                --移動平均値の算出
                local headRot = ExSkill.animationCount > -1 and ModelAlias.alias.avatar.head:getAnimRot().x or math.deg(math.asin(player:getLookDir().y))
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

                --寝る時の処理
                local isSleeping = player:getPose() == "SLEEPING"
                if isSleeping and not self.didSleepPrev then
                    animations["models.main"].halo_sleep:setSpeed(1)
                    sounds:playSound("block.beacon.deactivate", player:getPos(), 0.2, 5)
                elseif not isSleeping and self.didSleepPrev then
                    animations["models.main"].halo_sleep:setSpeed(-1)
                    sounds:playSound("block.beacon.activate", player:getPos(), 0.2, 5)
                end
                self.didSleepPrev = isSleeping
            end
        end)

        events.WORLD_TICK:register(function ()
            if not client:isPaused() then
                self.floatCount = self.floatCount + 1
                self.floatCount = self.floatCount == 80 and 0 or self.floatCount
            end
        end)

        events.RENDER:register(function (delta, context)
            if not client:isPaused() then
                if context ~= "MINECRAFT_GUI" then
                    --ヘイローの位置・角度を設定
                    local playerPose = player:getPose()
                    local headRot = Physics.getValueBetweenTicks(self.headRotAverage, delta)
                    local floatOffset = math.sin((self.floatCount + delta) / 80 * 2 * math.pi) * 0.25
                    if playerPose == "SWIMMING" or playerPose == "FALL_FLYING" then
                        ModelAlias.alias.avatar.halo:setPos(Physics.velocityAverage[3][2] * 3, math.cos(math.rad(headRot)) * Physics.velocityAverage[1][2] * -1 + math.sin(math.rad(headRot)) * Physics.velocityAverage[2][2] * -1 + floatOffset, math.cos(math.rad(headRot)) * Physics.velocityAverage[2][2] * -3 + math.sin(math.rad(headRot)) * Physics.velocityAverage[1][2])
                    else
                        ModelAlias.alias.avatar.halo:setPos(Physics.velocityAverage[3][2] * -3, math.cos(math.rad(headRot)) * Physics.velocityAverage[2][2] * -1 + math.sin(math.rad(headRot)) * Physics.velocityAverage[1][2] + floatOffset, math.cos(math.rad(headRot)) * Physics.velocityAverage[1][2] * 3 + math.sin(math.rad(headRot)) * Physics.velocityAverage[2][2])
                    end
                    if ModelAlias.alias.dummy_avatar ~= nil then
                        ModelAlias.alias.dummy_avatar.halo:setPos(0, floatOffset, 0)
                    end
                    ModelAlias.alias.avatar.halo:setRot(headRot - (ExSkill.animationCount > -1 and ModelAlias.alias.avatar.head:getAnimRot().x or math.deg(math.asin(player:getLookDir().y))) + self.initialHaloRot, 0, 0)
                else
                    ModelAlias.alias.avatar.halo:setRot(self.initialHaloRot, 0, 0)
                end
            end
            if context == "OTHER" and client:hasShaderPack() and not self.isForceRenderMode then
                ModelAlias.alias.avatar.halo:setVisible(false)
                if ModelAlias.alias.dummy_avatar ~= nil then
                    ModelAlias.alias.dummy_avatar.halo:setVisible(false)
                end
            else
				ModelAlias.alias.avatar.halo:setVisible(true)
                if ModelAlias.alias.dummy_avatar ~= nil then
                    ModelAlias.alias.dummy_avatar.halo:setVisible(true)
                end
            end
        end)

        events.WORLD_RENDER:register(function (delta)
            if not client:isPaused() and models.script_head_block.Skull ~= nil and models.script_head_block.Skull.Halo ~= nil then
                models.script_head_block.Skull.Halo:setPos(0, math.sin((self.floatCount + delta) / 80 * 2 * math.pi) * 0.25, 0)
            end
        end)

        ModelAlias.alias.avatar.halo:setLight(15, 15)
        animations["models.main"].halo_sleep:setSpeed(-1)
    end;
}

---ヘイローの強制レンダリングモードを切り替える。
---@param value boolean 強制レンダリングモードを有効にするかどうか。
function pings.halo_setHaloForceRender(value)
    Halo.isForceRenderMode = value
end

return Halo
