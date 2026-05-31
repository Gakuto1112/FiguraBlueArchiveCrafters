---@class ExSkill1ItemObject : SpawnObject Exスキル1で使用するアイテムオブジェクト
---@field package object ModelPart インスタンスで制御するモデルパーツ
---@field package subObject ModelPart インスタンスで制御するサブモデルパーツ
---@field package spriteTask SpriteTask subObject内にアタッチするスプライトレンダータスク
---@field package spriteType ExSkill1ItemObjectManager.SpriteType このスプライトの種類
---@field package spriteIndex integer このアイテムオブジェクトで表示するアイテムテクスチャのインデックス番号
---@field package currentPos Vector3 現ティックの位置
---@field package nextPos Vector3 次ティックの位置
---@field package velocity Vector3 このオブジェクトの移動速度
---@field package lifeTimeCount integer スプライトの残り時間
---@field public new fun(type: ExSkill1ItemObjectManager.SpriteType, launchRot?: number): ExSkill1ItemObject コンストラクター
local ExSkill1ItemObject = {
    ---コンストラクタ
    ---@param type ExSkill1ItemObjectManager.SpriteType 表示するスプライトの種類
    ---@param launchRot? number スプライトの射出角度。スプライトタイプが"ITEM"以外は無視される。
    ---@return ExSkill1ItemObject
    new = function (type, launchRot)
        ---@type ExSkill1ItemObject
        local instance = MiscUtils.instantiate(ExSkill1ItemObject, SpawnObject)

        instance.object = models.script_ex_skill_1_item_object:newPart(instance.uuid)
        instance.subObject = instance.object:newPart(client.intUUIDToString(client:generateUUID()), "Camera")
        instance.spriteType = type
        instance.spriteTask = instance.subObject:newSprite(client.intUUIDToString(client:generateUUID()))
        instance.spriteIndex = instance.spriteType == "CROSS" and 5 or (instance.spriteType == "DOT" and 6 or math.random(1, 4))
        instance.currentPos = player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1 + 180, 0, 2, 1, 0, 1, 0))
        instance.nextPos = instance.currentPos
        instance.velocity = vectors.rotateAroundAxis(player:getBodyYaw() * -1, vectors.rotateAroundAxis(instance.spriteType == "ITEM" and launchRot or (math.random() * 360), instance.spriteType == "ITEM" and (math.random() * 0.3 + 0.2) or (math.random() * 0.5), 0, 0, 0, 0, 1):mul(client:getScaledWindowSize().x / client:getScaledWindowSize().y, 1, 1), 0, 1, 0)
        instance.lifeTimeCount = 25

        instance.callbacks = {
            ---@param self ExSkill1ItemObject
            onInit = function (self)
                self.spriteTask:setTexture(textures["textures.ex_skill_1"])
                self.spriteTask:setDimensions(textures["textures.ex_skill_1"]:getDimensions())
                self.spriteTask:setRenderType("CUTOUT_EMISSIVE_SOLID")
                if self.spriteIndex == 1 then
                    self.spriteTask:setRegion(12, 21)
                    self.spriteTask:setUVPixels(0, 17)
                    self.spriteTask:setSize(5.7143, 10)
                    self.spriteTask:setRot(0, 0, math.random() * 20 - 10)
                elseif self.spriteIndex == 2 then
                    self.spriteTask:setRegion(14, 14)
                    self.spriteTask:setUVPixels(12, 17)
                    self.spriteTask:setSize(10, 10)
                    self.spriteTask:setRot(0, 0, math.random() * 20 - 10)
                elseif self.spriteIndex == 3 then
                    self.spriteTask:setRegion(10, 12)
                    self.spriteTask:setUVPixels(26, 17)
                    self.spriteTask:setSize(8.3333, 10)
                    self.spriteTask:setRot(0, 0, math.random() * 20 - 10)
                elseif self.spriteIndex == 4 then
                    self.spriteTask:setRegion(12, 12)
                    self.spriteTask:setUVPixels(36, 17)
                    self.spriteTask:setSize(10, 10)
                    self.spriteTask:setRot(0, 0, math.random() * 20 - 10)
                elseif self.spriteIndex == 5 then
                    self.spriteTask:setRegion(5, 5)
                    self.spriteTask:setUVPixels(48, 17)
                    self.spriteTask:setSize(5, 5)
                    self.spriteTask:setColor(vectors.hsvToRGB(math.random(), 1, 1))
                elseif self.spriteIndex == 6 then
                    self.spriteTask:setRegion(1, 1)
                    self.spriteTask:setUVPixels(50, 17)
                    self.spriteTask:setSize(2, 2)
                    self.spriteTask:setColor(vectors.hsvToRGB(math.random(), 1, 1))
                end
            end;

            ---@param self ExSkill1ItemObject
            onDeinit = function (self)
                self.subObject:removeTask(self.spriteTask:getName())
                self.object:removeChild(self.subObject)
                self.subObject:remove()
                models.script_ex_skill_1_item_object:removeChild(self.object)
                self.object:remove()
            end;

            ---@param self ExSkill1ItemObject
            onTick = function (self)
                --オブジェクトの状態を強制更新
                self.currentPos = self.nextPos
                self.object:setPos(self.currentPos:copy():scale(16))

                --次の位置を計算
                self.nextPos = self.currentPos:copy():add(self.velocity)
                self.velocity:scale(0.7)

                --残り時間の計算
                if self.lifeTimeCount == 0 then
                    self.shouldDeinit = true
                end
                self.lifeTimeCount = self.lifeTimeCount - 1
            end;

            ---@param self ExSkill1ItemObject
            onRender = function (self, delta)
                self.object:setPos(self.currentPos:copy():scale(16):add(self.nextPos:copy():sub(self.currentPos):scale(16 * delta)))
            end;
        }

        return instance
    end
}

return ExSkill1ItemObject