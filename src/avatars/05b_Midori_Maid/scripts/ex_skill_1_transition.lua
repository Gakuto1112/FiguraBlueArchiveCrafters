---@class ExSkill1TransitionSprite : SpawnObject Exスキル1のトランジションで使用するスプライトのクラス
---@field package object SpriteTask インスタンスで制御するスプライト
---@field package pos Vector2 スプライトの位置（左からx番目、上からy番目のスプライト）
---@field package animationCount integer スプライトアニメーションのカウンター
local ExSkill1TransitionSprite = {
    ---コンストラクタ
    ---@param pos Vector2 スプライトの位置（左からx番目、上からy番目のスプライト）
    ---@return ExSkill1TransitionSprite
    new = function (pos)
        ---@type ExSkill1TransitionSprite
        local instance = MiscUtils.instantiate(ExSkill1TransitionSprite, SpawnObject)

        instance.object = models.models.ex_skill_1.Gui.TransitionAnchor:newSprite(instance.uuid)
        instance.pos = pos
        instance.animationCount = 0

        instance.callbacks = {
            ---@param self ExSkill1TransitionSprite
            onInit = function (self)
                self.object:setTexture(textures["textures.ex_skill_1"])
                self.object:setDimensions(textures["textures.ex_skill_1"]:getDimensions())
                self.object:setRegion(1, 1)
                self.object:setUVPixels(47, 115)
            end;

            ---@param self ExSkill1TransitionSprite
            onDeinit = function (self)
                models.models.ex_skill_1.Gui.TransitionAnchor:removeTask(self.uuid)
            end;

            ---@param self ExSkill1TransitionSprite
            onTick = function (self)
                if self.animationCount == 4 then
                    self.object:setColor(0.8, 0.7, 0.7)
                elseif self.animationCount == 14 then
                    self.shouldDeinit = true
                end
                self.animationCount = self.animationCount + 1
            end;

            ---@param self ExSkill1TransitionSprite
            onRender = function (self, delta)
                local actualTick = self.animationCount + delta
                local scale = actualTick <= 2 and actualTick * 25 or (actualTick <= 10 and 50 or (actualTick <= 12 and actualTick * -25 + 300 or 0))
                local rot = actualTick <= 2 and actualTick * 45 or (actualTick <= 10 and 90 or (actualTick <= 12 and actualTick * 45 - 360 or 180))
                self.object:setPos(self.pos.x * -50 - 25 + math.cos(math.rad(rot * -1 + 45)) * scale * math.sqrt(2) / 2, self.pos.y * -50 - 25 + math.sin(math.rad(rot * -1 + 45)) * scale * math.sqrt(2) / 2, 0)
                self.object:setRot(0, 0, rot * -1)
                self.object:setSize(vectors.vec2(1, 1):scale(scale))
            end;
        }

        return instance
    end;
}

return ExSkill1TransitionSprite
