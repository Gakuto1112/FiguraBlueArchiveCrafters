---@class ExSkillTextObject : SpawnObject Exスキルで使用するテキストオブジェクト
---@field public object TextTask インスタンスで制御するメインテキストレンダータスク
---@field package subObject TextTask インスタンスで制御するサブテキストレンダータスク
---@field package pos Vector2 テキストオブジェクトの位置
---@field public text string このテキストオブジェクトで表示しているテキスト内容
---@field package animationCount integer アニメーションのカウンター
local ExSkillTextObject = {
    ---コンストラクタ
    ---@param textPos Vector2 テキストの初期位置
    ---@param text string 表示するテキスト
    ---@return ExSkillTextObject
    new = function (_, textPos, text)
        ---@type ExSkillTextObject
        local instance = MiscUtils.instantiate(ExSkillTextObject, SpawnObject)

        instance.object = models.models.main.CameraAnchor:newText(instance.uuid)
        instance.subObject = models.models.main.CameraAnchor:newText(client.intUUIDToString(client:generateUUID()))
        instance.pos = textPos
        instance.text = text
        instance.animationCount = 0

        instance.callbacks = {
            ---@param self ExSkillTextObject
            onInit = function (self)
                self.object:setPos(textPos:copy():augmented(5))
                self.object:setRot(0, 180, 0)
                self.object:setScale(0.45, 0.45, 0.5)
                self.object:setText("§d"..self.text)
                self.object:setOutline(true)
                self.object:setVisible(false)
                self.subObject:setPos(textPos:copy():augmented(5))
                self.subObject:setRot(0, 180, 0)
                self.subObject:setScale(0.45, 0.45, 0)
                self.subObject:setText("§d"..self.text)
            end;

            ---@param self ExSkillTextObject
            onDeinit = function (self)
                models.models.main.CameraAnchor:removeTask(self.object:getName())
                models.models.main.CameraAnchor:removeTask(self.subObject:getName())
            end;

            ---@param self ExSkillTextObject
            onTick = function (self)
                self.animationCount = self.animationCount + 0.05
                if self.animationCount == 0.1 then
                    sounds:playSound("minecraft:block.bone_block.place", player:getPos(), 1, 0.75)
                end
            end;

            ---@param self ExSkillTextObject
            onRender = function (self, delta)
                local count = self.animationCount + delta * 0.05

                if count <= 0.1 then
                    self:setScale(self.subObject, count * -10 + 2)
                    self.subObject:setOpacity(count * 5 + 0.5)
                elseif count <= 0.2 then
                    self:setScale(self.subObject, count * 10)
                    self.subObject:setOpacity(count * -5 + 1.5)
                else
                    self.subObject:setVisible(false)
                end

                if count >= 0.05 then
                    self.object:setVisible(true)
                    if count <= 0.083 then
                        self:setScale(self.object, count * -12.12 + 1.8)
                    elseif count <= 0.1 then
                        self:setScale(self.object, count * 12.12 - 0.2)
                    else
                        self:setScale(self.object, 1)
                    end
                end
            end;
        }

        return instance
    end;

    ---テキストタスクのスケールを設定する。
    ---@param self ExSkillTextObject
    ---@param task TextTask スケールを設定するテキストタスク
    ---@param scale number 設定するスケール値
    setScale = function (self, task, scale)
        task:setPos(self.pos:copy():add(vectors.vec2(-1, 1):scale((scale - 1) * 3 / 2)):augmented(-5))
        task:setScale(vectors.vec3(1, 1, 1):scale(scale * 0.4))
    end;
}

return ExSkillTextObject
