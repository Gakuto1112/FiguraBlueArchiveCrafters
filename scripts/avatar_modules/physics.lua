---@class (exact) Physics : AvatarModule 物理演算を制御するクラス
---@field public velocityData number[][] 速度データ：1. 頭前後, 2. 上下, 3. 頭左右, 4. 頭角速度, 5. 体前後, 6. 体左右, 7. 体角速度
---@field public velocityAverage number[][] 速度の平均値：1. 頭前後, 2. 上下, 3. 頭左右, 4. 頭角速度, 5. 体前後, 6. 体左右, 7. 体角速度
---@field package directionPrev number[] 前ティックのdirectionテーブル
---@field public getValueBetweenTicks fun(tickData: number[], delta: number): number 2つのティックデータの間からレンダーのデルタ値を加味した値を返す
---@field package decomposeHorizontalVelocity fun(self: Physics, direction: number, index: integer): number, number, number 速度を指定された方向から見て前後方向、左右方向に分解する
---@field package getPhysicRot fun(self: Physics, physicData: BlueArchiveCharacter.PhysicCoreData, delta: number): number 物理演算で計算した角度を返す
---@field public enable fun(self: Physics) 物理演算を初期化し、有効にする
---@field public disable fun(self: Physics) 物理演算を無効にする。物理演算で管理していたモデルの回転をリセットする

Physics = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Physics
    new = function (parent)
        ---@type Physics
        local instance = Avatar.instantiate(Physics, AvatarModule, parent)

        instance.velocityData = {{}, {}, {}, {}, {}, {}, {}}
        instance.velocityAverage = {{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}}
        instance.directionPrev = {}

        return instance
    end;

    ---2つのティックデータの間からレンダーのデルタ値を加味した値を返す。
    ---@param tickData number[] ティックデータ：1. 前ティック, 2. 現ティック
    ---@param delta number デルタ値
    ---@return number deltaValue 2つのティックデータの間からデルタ値で補完した値
    getValueBetweenTicks = function (tickData, delta)
        return tickData[1] + (tickData[2] - tickData[1]) * delta
    end;

    ---速度を指定された方向から見て前後方向、左右方向に分解する。
    ---@param self Physics
    ---@param direction number 基準にする方向
    ---@param index integer データ管理用のインデックス番号（呼び出しの度に異なるインデックス番号になるようにする）
    ---@return number velocityFront 指定された方向から見た前後方向の速度
    ---@return number velocityRight 指定された方向から見た左右方向の速度
    ---@return number velocityRot 指定された方向を基準とした角速度
    decomposeHorizontalVelocity = function (self, direction, index)
        local velocity = player:getVelocity()
        if self.directionPrev[index] == nil then
            self.directionPrev[index] = 0
        end
        local velocityRot = math.deg(math.atan2(velocity.z, velocity.x))
        velocityRot = velocityRot < 0 and 360 + velocityRot or velocityRot
        local directionAbsFront = math.abs(velocityRot - (direction) % 360)
        directionAbsFront = directionAbsFront > 180 and 360 - directionAbsFront or directionAbsFront
        local directionAbsRight = math.abs(velocityRot - (direction + 90) % 360)
        directionAbsRight = directionAbsRight > 180 and 360 - directionAbsRight or directionAbsRight
        local directionDelta = direction - self.directionPrev[index]
        directionDelta = directionDelta > 180 and (360 - directionDelta) * 20 or (directionDelta < -180 and (360 + directionDelta) * 20 or directionDelta * 20)
        self.directionPrev[index] = direction
        return math.sqrt(velocity.x ^ 2 + velocity.z ^ 2) * math.cos(math.rad(directionAbsFront)), math.sqrt(velocity.x ^ 2 + velocity.z ^ 2) * math.cos(math.rad(directionAbsRight)), directionDelta
    end;

    ---物理演算で計算した角度を返す。
    ---@param self Physics
    ---@param physicData BlueArchiveCharacter.PhysicCoreData 物理演算データ
    ---@param delta number デルタ値
    ---@return number physicDirection 物理演算で計算したモデルの角度
    getPhysicRot = function (self, physicData, delta)
        local rot = physicData.neutral
        local waterMultiplayer = player:isUnderwater() and 2 or 1
        if physicData.headX ~= nil then
            rot = rot + math.clamp(self.getValueBetweenTicks(self.velocityAverage[1], delta) * physicData.headX.multiplayer * waterMultiplayer, physicData.headX.min - physicData.neutral, physicData.headX.max - physicData.neutral)
        end
        if physicData.headZ ~= nil then
            rot = rot + math.clamp(self.getValueBetweenTicks(self.velocityAverage[3], delta) * physicData.headZ.multiplayer * waterMultiplayer, physicData.headZ.min - physicData.neutral, physicData.headZ.max - physicData.neutral)
        end
        if physicData.headRot ~= nil then
            rot = rot + math.clamp(math.abs(self.getValueBetweenTicks(self.velocityAverage[4], delta)) * -1 * physicData.headRot.multiplayer, physicData.headRot.min - physicData.neutral, physicData.headRot.max - physicData.neutral)
        end
        if physicData.bodyX ~= nil then
            rot = rot + math.clamp(self.getValueBetweenTicks(self.velocityAverage[5], delta) * physicData.bodyX.multiplayer * waterMultiplayer, physicData.bodyX.min - physicData.neutral, physicData.bodyX.max - physicData.neutral)
        end
        if physicData.bodyY ~= nil then
            rot = rot + math.clamp(self.getValueBetweenTicks(self.velocityAverage[2], delta) * physicData.bodyY.multiplayer * waterMultiplayer, physicData.bodyY.min - physicData.neutral, physicData.bodyY.max - physicData.neutral)
        end
        if physicData.bodyZ ~= nil then
            rot = rot + math.clamp(self.getValueBetweenTicks(self.velocityAverage[player:getVehicle() == nil and 6 or 3], delta) * physicData.bodyZ.multiplayer * waterMultiplayer, physicData.bodyZ.min - physicData.neutral, physicData.bodyZ.max - physicData.neutral)
        end
        if physicData.bodyRot ~= nil then
            rot = rot + math.clamp(-math.abs(self.getValueBetweenTicks(self.velocityAverage[7], delta)) * physicData.bodyRot.multiplayer, physicData.bodyRot.min - physicData.neutral, physicData.bodyRot.max - physicData.neutral)
        end
        rot = math.clamp(rot, physicData.min, physicData.max)
        if physicData.headRotMultiplayer ~= nil then
            rot = rot + math.deg(math.asin(player:getLookDir().y)) * physicData.headRotMultiplayer
        end
        if physicData.sneakOffset ~= nil and player:isCrouching() then
            rot = rot + physicData.sneakOffset
        end
        return rot
    end;

    ---物理演算を初期化し、有効にする。
    ---@param self Physics
    enable = function (self)
        self.velocityData = {{}, {}, {}, {}, {}, {}, {}}
        self.velocityAverage = {{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}}
        self.directionPrev = {}

        if events.TICK:getRegisteredCount("physics_tick") == 0 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    local lookDir = player:getLookDir()
                    local velocityHeadFront, velocityHeadRight, velocityHeadRot = self:decomposeHorizontalVelocity(math.deg(math.atan2(lookDir.z, lookDir.x)), 1)
                    local velocityAverage = {self.velocityAverage[1][2], self.velocityAverage[2][2], self.velocityAverage[3][2], self.velocityAverage[4][2], self.velocityAverage[5][2], self.velocityAverage[6][2], self.velocityAverage[7][2]}
                    local velocityY = player:getVelocity().y
                    velocityAverage[1] = (#self.velocityData[1] * velocityAverage[1] + velocityHeadFront) / (#self.velocityData[1] + 1)
                    table.insert(self.velocityData[1], velocityHeadFront)
                    velocityAverage[2] = (#self.velocityData[2] * velocityAverage[2] + velocityY) / (#self.velocityData[2] + 1)
                    table.insert(self.velocityData[2], velocityY)
                    velocityAverage[3] = (#self.velocityData[3] * velocityAverage[3] + velocityHeadRight) / (#self.velocityData[3] + 1)
                    table.insert(self.velocityData[3], velocityHeadRight)
                    velocityAverage[4] = (#self.velocityData[4] * velocityAverage[4] + velocityHeadRot) / (#self.velocityData[4] + 1)
                    table.insert(self.velocityData[4], velocityHeadRot)
                    local velocityBodyFront, velocityBodyRight, velocityBodyRot = self:decomposeHorizontalVelocity((player:getBodyYaw() + models.models.main.Avatar.UpperBody:getTrueRot().y - 90) % 360 - 180, 2)
                    velocityAverage[5] = (#self.velocityData[5] * velocityAverage[5] + velocityBodyFront) / (#self.velocityData[5] + 1)
                    table.insert(self.velocityData[5], velocityBodyFront)
                    velocityAverage[6] = (#self.velocityData[6] * velocityAverage[6] + velocityBodyRight) / (#self.velocityData[6] + 1)
                    table.insert(self.velocityData[6], velocityBodyRight)
                    velocityAverage[7] = (#self.velocityData[7] * velocityAverage[7] + velocityBodyRot) / (#self.velocityData[7] + 1)
                    table.insert(self.velocityData[7], velocityBodyRot)
                    --古いデータの切り捨て
                    for index, velocityTable in ipairs(self.velocityData) do
                        if #velocityTable > 5 then
                            velocityAverage[index] = (#velocityTable * velocityAverage[index] - velocityTable[1]) / (#velocityTable - 1)
                            table.remove(velocityTable, 1)
                        end
                        table.insert(self.velocityAverage[index], velocityAverage[index])
                        table.remove(self.velocityAverage[index], 1)
                    end
                end
            end, "physics_tick")

            events.RENDER:register(function (delta)
                local playerPose = player:getPose()
                local isHorizontal = playerPose == "SWIMMING" or playerPose == "FALL_FLYING"

                for _,  physicData in ipairs(self.parent.characterData.physics.physicData) do
                    for _, modelPart in ipairs(physicData.models) do
                        if modelPart:getVisible() then
                            local rot = vectors.vec3()
                            if physicData.x ~= nil then
                                if isHorizontal and physicData.x.horizontal then
                                    rot.x = self:getPhysicRot(physicData.x.horizontal, delta)
                                elseif not isHorizontal and physicData.x.vertical then
                                    rot.x = self:getPhysicRot(physicData.x.vertical, delta)
                                end
                            end
                            if physicData.y ~= nil then
                                if isHorizontal and physicData.y.horizontal then
                                    rot.y = self:getPhysicRot(physicData.y.horizontal, delta)
                                elseif not isHorizontal and physicData.y.vertical then
                                    rot.y = self:getPhysicRot(physicData.y.vertical, delta)
                                end
                            end
                            if physicData.z ~= nil then
                                if isHorizontal and physicData.z.horizontal then
                                    rot.z = self:getPhysicRot(physicData.z.horizontal, delta)
                                elseif not isHorizontal and physicData.z.vertical then
                                    rot.z = self:getPhysicRot(physicData.z.vertical, delta)
                                end
                            end
                            modelPart:setRot(rot)
                            if self.parent.characterData.physics.callbacks ~= nil and self.parent.characterData.physics.callbacks.onPhysicPerformed ~= nil then
                                self.parent.characterData.physics.callbacks.onPhysicPerformed(self.parent.characterData, modelPart)
                            end
                        end
                    end
                end
            end, "physics_render")
        end
    end;

    ---物理演算を無効にする。物理演算で管理していたモデルの回転をリセットする。
    ---@param self Physics
    disable = function (self)
        events.TICK:remove("physics_tick")
        events.RENDER:remove("physics_render")
        for _, physicData in ipairs(self.parent.characterData.physics.physicData) do
            local initialRot = vectors.vec3()
            if physicData.x ~= nil and physicData.x.vertical ~= nil then
                initialRot.x = physicData.x.vertical.neutral
            end
            if physicData.y ~= nil and physicData.y.vertical ~= nil then
                initialRot.y = physicData.y.vertical.neutral
            end
            if physicData.z ~= nil and physicData.z.vertical ~= nil then
                initialRot.z = physicData.z.vertical.neutral
            end
            for _, modelPart in ipairs(physicData.models) do
                modelPart:setRot(initialRot)
            end
        end
    end;
}