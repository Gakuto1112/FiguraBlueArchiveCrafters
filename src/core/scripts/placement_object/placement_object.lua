---@class (exact) PlacementObject : SpawnObject 単一の設置物を管理するクラス
---@field public object ModelPart インスタンスで制御するオブジェクト
---@field public index integer 設置物データのインデックス番号。設置物のデータを参照するときに使用する。
---@field package boundingBox Vector3 設置物の当たり判定
---@field package gravity number この設置物に働く重力の大きさ
---@field package hasFireResistance boolean この設置物に炎耐性を付けるかどうか
---@field public removeReason PlacementObjectManager.RemoveReason この設置物のインスタンスが破棄される理由
---@field package offsetPos Vector3 設置物の中心座標のオフセット値
---@field public currentPos Vector3 設置物の現在位置
---@field package nextPos Vector3 設置物の次ティックの位置
---@field package fallingSpeed number 設置物の落下速度
---@field package isOnGround boolean 設置物が接地しているかどうか
local PlacementObject = {
    ---コンストラクタ
    ---@param index integer 設置物データのインデックス番号。設置物のデータを参照するときに使用する。
    ---@param pos Vector3 設置物を設置するワールド座標
    ---@param rot number 設置物のワールド方向
    ---@return PlacementObject
    new = function (index, pos, rot)
        ---@type PlacementObject
        ---@diagnostic disable-next-line: undefined-global
        local instance = MiscUtils.instantiate(PlacementObject, SpawnObject)

        instance.index = index
        instance.object = BlueArchiveCharacter.placementObjects[instance.index].placementMode == "COPY" and BlueArchiveCharacter.placementObjects[instance.index].model:copy(instance.uuid) or BlueArchiveCharacter.placementObjects[instance.index].model
        instance.boundingBox = BlueArchiveCharacter.placementObjects[instance.index].boundingBox.size:copy():scale(0.0625)
        instance.gravity = BlueArchiveCharacter.placementObjects[instance.index].gravity ~= nil and BlueArchiveCharacter.placementObjects[instance.index].gravity or 1
        instance.hasFireResistance = BlueArchiveCharacter.placementObjects[instance.index].hasFireResistance ~= nil and BlueArchiveCharacter.placementObjects[instance.index].hasFireResistance or false
        instance.removeReason = "REMOVED_BY_SCRIPTS"
        instance.offsetPos = vectors.vec3()
        instance.currentPos = pos
        instance.nextPos = instance.currentPos
        instance.fallingSpeed = 0
        instance.isOnGround = false

        instance.callbacks = {
            ---@param self PlacementObject
            onInit = function (self)
                if BlueArchiveCharacter.placementObjects[self.index].placementMode == "COPY" then
                    models.script_placement_object:addChild(self.object)
                end
                self.object:setRot(0, rot, 0)
                self.object:setVisible(true)
                if BlueArchiveCharacter.placementObjects[self.index].callbacks ~= nil and BlueArchiveCharacter.placementObjects[self.index].callbacks.onInit ~= nil then
                    BlueArchiveCharacter.placementObjects[self.index].callbacks.onInit(BlueArchiveCharacter, self)
                end
            end;

            ---@param self PlacementObject
            onDeinit = function (self)
                if BlueArchiveCharacter.placementObjects[self.index].placementMode == "COPY" then
                    models.script_placement_object:removeChild(self.object)
                    self.object:remove()
                else
                    self.object:setVisible(false)
                end
                if BlueArchiveCharacter.placementObjects[self.index].callbacks ~= nil and BlueArchiveCharacter.placementObjects[self.index].callbacks.onDeinit ~= nil then
                    BlueArchiveCharacter.placementObjects[self.index].callbacks.onDeinit(BlueArchiveCharacter, self)
                end
            end;

            ---@param self PlacementObject
            onTick = function (self)
                --設置物の位置を強制更新
                self.currentPos = self.nextPos
                self.object:setPos(self.currentPos:copy():scale(16))
                self.object:setLight(world.getBlockLightLevel(self.currentPos), world.getSkyLightLevel(self.currentPos))

                --当たり判定同士が重複しているか確認
                local boundingBoxStartPos = vectors.vec3(self.currentPos.x - self.boundingBox.x / 2, self.currentPos.y, self.currentPos.z - self.boundingBox.z / 2)
                local boundingBoxEndPos = vectors.vec3(self.currentPos.x + self.boundingBox.x / 2, self.currentPos.y + self.boundingBox.y, self.currentPos.z + self.boundingBox.z / 2)
                local boundingBoxCenter = boundingBoxEndPos:copy():sub(boundingBoxStartPos):scale(0.5):add(boundingBoxStartPos)
                for z = math.floor(boundingBoxStartPos.z), math.floor(boundingBoxEndPos.z) do
                    for y = math.floor(boundingBoxStartPos.y), math.floor(boundingBoxEndPos.y) do
                        for x = math.floor(boundingBoxStartPos.x), math.floor(boundingBoxEndPos.x) do
                            for _, collisionBox in ipairs( world.getBlockState(x, y, z):getCollisionShape()) do
                                local collisionStartPos = collisionBox[1]:copy():add(x, y, z)
                                local collisionEndPos = collisionBox[2]:copy():add(x, y, z)
                                local collisionBoxCenter = collisionStartPos:copy():add(collisionEndPos:copy():sub(collisionStartPos):scale(0.5))
                                if math.abs(collisionBoxCenter.x - boundingBoxCenter.x) < ((collisionEndPos.x - collisionStartPos.x) + (boundingBoxEndPos.x - boundingBoxStartPos.x)) / 2 and math.abs(collisionBoxCenter.y - boundingBoxCenter.y) < ((collisionEndPos.y - collisionStartPos.y) + (boundingBoxEndPos.y - boundingBoxStartPos.y)) / 2 and math.abs(collisionBoxCenter.z - boundingBoxCenter.z) < ((collisionEndPos.z - collisionStartPos.z) + (boundingBoxEndPos.z - boundingBoxStartPos.z)) / 2 then
                                    self.removeReason = "OVERLAPPED"
                                    self.shouldDeinit = true
                                    return
                                end
                            end
                        end
                    end
                end

                --落下速度を更新
                local fluidTags = world.getBlockState(self.currentPos):getFluidTags()
                if fluidTags[2] == "c:water" then
                    if self.gravity >= 0 then
                        self.fallingSpeed = math.max(self.fallingSpeed - 0.1 * self.gravity, 0.1 * self.gravity)
                    else
                        self.fallingSpeed = math.min(self.fallingSpeed - 0.1 * self.gravity, 0.1 * self.gravity)
                    end
                elseif fluidTags[2] == "c:lava" then
                    if self.gravity >= 0 then
                        self.fallingSpeed = math.max(self.fallingSpeed - 0.1 * self.gravity, 0.02 * self.gravity)
                    else
                        self.fallingSpeed = math.min(self.fallingSpeed - 0.1 * self.gravity, 0.02 * self.gravity)
                    end
                else
                    if self.gravity >= 0 then
                        self.fallingSpeed = math.min(self.fallingSpeed + 0.035 * self.gravity, 3.575 * self.gravity)
                    else
                        self.fallingSpeed = math.max(self.fallingSpeed + 0.035 * self.gravity, 3.575 * self.gravity)
                    end
                end
                self.nextPos = self.currentPos:copy():add(0, self.fallingSpeed * -1, 0)

                --現ティックと次ティックから直方体を算出
                local nextBoxStartPos = vectors.vec3()
                local nextBoxEndPos = vectors.vec3()
                if self.gravity >= 0 then
                    nextBoxStartPos = vectors.vec3(self.currentPos.x - self.boundingBox.x / 2, math.min(self.currentPos.y, self.currentPos.y - self.fallingSpeed), self.currentPos.z - self.boundingBox.z / 2)
                    nextBoxEndPos = vectors.vec3(self.currentPos.x + self.boundingBox.x / 2, math.max(self.currentPos.y, self.currentPos.y - self.fallingSpeed), self.currentPos.z + self.boundingBox.z / 2)
                else
                    nextBoxStartPos = vectors.vec3(self.currentPos.x - self.boundingBox.x / 2, math.min(self.currentPos.y, self.currentPos.y - self.fallingSpeed) + self.boundingBox.y, self.currentPos.z - self.boundingBox.z / 2)
                    nextBoxEndPos = vectors.vec3(self.currentPos.x + self.boundingBox.x / 2, math.max(self.currentPos.y, self.currentPos.y - self.fallingSpeed) + self.boundingBox.y, self.currentPos.z + self.boundingBox.z / 2)
                end
                local nextBoxCenter = nextBoxStartPos:copy():add(nextBoxEndPos:copy():sub(nextBoxStartPos):scale(0.5))

                --直方体と重なるブロック座標を全て算出
                local collisionDetected = false
                if self.gravity >= 0 then
                    local collisionYPos = math.floor(nextBoxStartPos.y)
                    for y = math.floor(nextBoxEndPos.y), math.floor(nextBoxStartPos.y) - 1, -1 do
                        for z = math.floor(nextBoxStartPos.z), math.floor(nextBoxEndPos.z) do
                            for x = math.floor(nextBoxStartPos.x), math.floor(nextBoxEndPos.x) do
                                for _, collisionBox in ipairs( world.getBlockState(x, y, z):getCollisionShape()) do
                                    local collisionStartPos = collisionBox[1]:copy():add(x, y, z)
                                    local collisionEndPos = collisionBox[2]:copy():add(x, y, z)
                                    local collisionBoxCenter = collisionStartPos:copy():add(collisionEndPos:copy():sub(collisionStartPos):scale(0.5))
                                    if math.abs(collisionBoxCenter.x - nextBoxCenter.x) < ((collisionEndPos.x - collisionStartPos.x) + (nextBoxEndPos.x - nextBoxStartPos.x)) / 2 and math.abs(collisionBoxCenter.y - nextBoxCenter.y) < ((collisionEndPos.y - collisionStartPos.y) + (nextBoxEndPos.y - nextBoxStartPos.y)) / 2 and math.abs(collisionBoxCenter.z - nextBoxCenter.z) < ((collisionEndPos.z - collisionStartPos.z) + (nextBoxEndPos.z - nextBoxStartPos.z)) / 2 then
                                        if collisionEndPos.y > self.nextPos.y then
                                            self.nextPos.y = collisionEndPos.y
                                            collisionYPos = y
                                            self.fallingSpeed = 0
                                            collisionDetected = true
                                        end
                                    end
                                end
                            end
                        end
                        if y == collisionYPos - 1 then
                            break
                        end
                    end
                else
                    local collisionYPos = math.floor(nextBoxEndPos.y)
                    for y = math.floor(nextBoxStartPos.y), math.floor(nextBoxEndPos.y), 1 do
                        for z = math.floor(nextBoxStartPos.z), math.floor(nextBoxEndPos.z) do
                            for x = math.floor(nextBoxStartPos.x), math.floor(nextBoxEndPos.x) do
                                for _, collisionBox in ipairs( world.getBlockState(x, y, z):getCollisionShape()) do
                                    local collisionStartPos = collisionBox[1]:copy():add(x, y, z)
                                    local collisionEndPos = collisionBox[2]:copy():add(x, y, z)
                                    local collisionBoxCenter = collisionStartPos:copy():add(collisionEndPos:copy():sub(collisionStartPos):scale(0.5))
                                    if math.abs(collisionBoxCenter.x - nextBoxCenter.x) < ((collisionEndPos.x - collisionStartPos.x) + (nextBoxEndPos.x - nextBoxStartPos.x)) / 2 and math.abs(collisionBoxCenter.y - nextBoxCenter.y) < ((collisionEndPos.y - collisionStartPos.y) + (nextBoxEndPos.y - nextBoxStartPos.y)) / 2 and math.abs(collisionBoxCenter.z - nextBoxCenter.z) < ((collisionEndPos.z - collisionStartPos.z) + (nextBoxEndPos.z - nextBoxStartPos.z)) / 2 then
                                        if collisionStartPos.y < self.nextPos.y + self.boundingBox.y then
                                            self.nextPos.y = collisionStartPos.y - self.boundingBox.y
                                            collisionYPos = y
                                            self.fallingSpeed = 0
                                            collisionDetected = true
                                        end
                                    end
                                end
                            end
                        end
                        if y == collisionYPos + 1 then
                            break
                        end
                    end
                end
                if collisionDetected and not self.isOnGround and BlueArchiveCharacter.placementObjects[self.index].callbacks ~= nil and BlueArchiveCharacter.placementObjects[self.index].callbacks.onGround ~= nil then
                    BlueArchiveCharacter.placementObjects[self.index].callbacks.onGround(BlueArchiveCharacter, self)
                end
                self.isOnGround = collisionDetected
                local nextBlock = world.getBlockState(self.nextPos)
                local isNextBlockFire = false
                for _, tag in ipairs(nextBlock:getTags()) do
                    if tag == "minecraft:fire" then
                        isNextBlockFire = true
                        break
                    end
                end
                if self.nextPos.y < -128 then
                    self.removeReason = "TOO_LOW"
                    self.shouldDeinit = true
                elseif self.nextPos.y > 384 then
                    self.removeReason = "TOO_HIGH"
                    self.shouldDeinit = true
                elseif not self.hasFireResistance and (nextBlock:getFluidTags()[2] == "c:lava" or isNextBlockFire) then
                    sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:block.fire.extinguish"), self.nextPos)
                    for _ = 0, self.boundingBox.x * self.boundingBox.y * self.boundingBox.z * 8 do
                        particles:newParticle(self.parent.compatibilityUtils:checkParticle("minecraft:smoke"), vectors.vec3(self.nextPos.x + math.random() * self.boundingBox.x - self.boundingBox.x / 2, self.nextPos.y + math.random() * self.boundingBox.y, self.nextPos.z + math.random() * self.boundingBox.z - self.boundingBox.z / 2))
                    end
                    self.removeReason = "BURNT"
                    self.shouldDeinit = true
                end
                if BlueArchiveCharacter.placementObjects[self.index].callbacks ~= nil and BlueArchiveCharacter.placementObjects[self.index].callbacks.onTick ~= nil then
                    BlueArchiveCharacter.placementObjects[self.index].callbacks.onTick(BlueArchiveCharacter, self)
                end
            end;

            ---@param self PlacementObject
            onRender = function (self, delta, context)
                self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):scale(16))
                if BlueArchiveCharacter.placementObjects[self.index].callbacks ~= nil and BlueArchiveCharacter.placementObjects[self.index].callbacks.onRender ~= nil then
                    BlueArchiveCharacter.placementObjects[self.index].callbacks.onRender(BlueArchiveCharacter, self, delta)
                end
            end
        }

        return instance
    end;
}

return PlacementObject
