---@class ExSkill1Particle : SpawnObject Exスキル2で使用する独自定義のパーティクルのクラス
---@field package object SpriteTask インスタンスで制御するスプライト
---@field package offsetPos Vector2 このパーティクルの初期位置のオフセット値
---@field package textureOffset integer このパーティクルのテクスチャのオフセット値
---@field package lifeTimeCount integer このパーティクルの出現時間
---@field package currentPos Vector2 このパーティクルの現在位置
---@field package nextPos Vector2 このパーティクルの次の位置
local ExSkill1Particle = {
    ---コンストラクタ
    ---@return ExSkill1Particle
    new = function ()
        ---@type ExSkill1Particle
        local instance = MiscUtils.instantiate(ExSkill1Particle, SpawnObject)

        instance.object = models.models.ex_skill_1.Gui.UI.ClearEffect:newSprite(instance.uuid)
        instance.offsetPos = vectors.vec2(math.random() * 200 - 100, math.random() * 70 - 35)
        instance.textureOffset = math.random(0, 1)
        instance.lifeTimeCount = 0
        instance.currentPos = instance.offsetPos:copy()
        instance.nextPos = instance.currentPos:copy()

        instance.callbacks = {
            ---@param self ExSkill1Particle
            onInit = function (self)
                self.object:setTexture(textures["textures.ex_skill_1"])
                self.object:setDimensions(textures["textures.ex_skill_1"]:getDimensions())
                self.object:setRegion(3, 3)
                self.object:setSize(10, 10)
                self.object:setUVPixels(47 + self.textureOffset, 115)
            end;

            ---@param self ExSkill1Particle
            onDeinit = function (self)
                models.models.ex_skill_1.Gui.UI.ClearEffect:removeTask(self.uuid)
            end;

            ---@param self ExSkill1Particle
            onTick = function (self)
                self.currentPos = self.nextPos:copy()
                self.nextPos = self.currentPos:copy():add(self.offsetPos:copy():normalize():scale(1.5))
                self.lifeTimeCount = self.lifeTimeCount + 1
                if self.lifeTimeCount == 12 then
                    self.object:setUVPixels(47 + 1 - self.textureOffset, 115)
                elseif self.lifeTimeCount == 24 then
                    self.shouldDeinit = true
                end
            end;

            ---@param self ExSkill1Particle
            onRender = function (self, delta, context)
                self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):augmented(0))
            end;
        }

        return instance
    end;
}

return ExSkill1Particle
