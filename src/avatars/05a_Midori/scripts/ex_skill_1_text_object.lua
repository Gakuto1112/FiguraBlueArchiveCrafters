---@class ExSkill1TextObject : SpawnObject Exスキル1で使用するテキストオブジェクト
---@field package object ModelPart インスタンスで制御するモデルパーツ
---@field package subObject ModelPart インスタンスで制御するサブモデルパーツ
---@field package textTask TextTask subObject内にアタッチするテキストレンダータスク
---@field package text string このテキストオブジェクトで表示しているテキスト内容
---@field package currentPos Vector3 現ティックの位置
---@field package nextPos Vector3 次ティックの位置
---@field package velocity Vector3 このオブジェクトの移動速度
---@field package animationCount integer アニメーションのカウンター
local ExSkill1TextObject = {
    ---コンストラクタ
    ---@param text string 表示するテキスト
    ---@return ExSkill1TextObject
    new = function (text)
        ---@type ExSkill1TextObject
        ---@diagnostic disable-next-line: undefined-global
        local instance = MiscUtils.instantiate(ExSkill1TextObject, SpawnObject)

        instance.object = models.script_ex_skill_1_text_object:newPart(instance.uuid)
        instance.subObject = instance.object:newPart(client.intUUIDToString(client:generateUUID()), "Camera")
        instance.textTask = instance.subObject:newText(client.intUUIDToString(client:generateUUID()))
        instance.text = text
        instance.currentPos = vectors.rotateAroundAxis(player:getBodyYaw() + 180, ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.GameConsole1):sub(player:getPos()), 0, 1, 0):scale(16)
        instance.nextPos = instance.currentPos
        instance.velocity = vectors.rotateAroundAxis(math.random() * 360, 0, 0.5, 0.2, 0, 1, 0)
        instance.animationCount = 0

        instance.callbacks = {
            ---@param self ExSkill1TextObject
            onInit = function (self)
                self.textTask:setText("§6"..instance.text)
                self.textTask:setAlignment("CENTER")
                self.textTask:setOutline(true)
                self.textTask:setOutlineColor(0.165, 0.165, 0)
                self.textTask:setSeeThrough(true)
            end;

            ---@param self ExSkill1TextObject
            onDeinit = function (self)
                self.subObject:removeTask(self.textTask:getName())
                self.object:removeChild(self.subObject)
                self.subObject:remove()
                models.script_ex_skill_1_text_object:removeChild(self.object)
                self.object:remove()
            end;

            ---@param self ExSkill1TextObject
            onTick = function (self)
                --オブジェクトの状態を強制更新
                self.currentPos = self.nextPos
                self.object:setPos(self.currentPos)
                self.object:setScale(vectors.vec3(1, 1, 1):scale(self.animationCount * -0.125 + 0.25))

                --次の位置を計算
                self.nextPos = self.currentPos:copy():add(self.velocity)
                self.velocity.y = self.velocity.y - 0.1

                ---カウンター更新
                self.animationCount = self.animationCount + 0.05
                if self.animationCount >= 1 then
                    self.shouldDeinit = true
                end
            end;

            ---@param self ExSkill1TextObject
            onRender = function (self, delta)
                self.object:setPos(self.currentPos:copy():add(self.nextPos:copy():sub(self.currentPos):scale(delta)))
                self.object:setScale(vectors.vec3(1, 1, 1):scale((self.animationCount + delta * 0.05) * -0.125 + 0.25))
            end;
        }

        return instance
    end
}

return ExSkill1TextObject
