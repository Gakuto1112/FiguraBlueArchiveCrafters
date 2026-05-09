---@class (exact) ExSkill1Sprite : SpawnObject Exスキル1内で使用するスプライトのオブジェクトのクラス
---@field package object SpriteTask インスタンスで制御するスプライトオブジェクト
---@field package target ModelPart インスタンスオブジェクトをアタッチする親モデル
---@field package pos Vector3 スプライトをスポーンさせる位置
---@field package lifetimeCount integer オブジェクトの残り時間を計るカウンター
---@field public new fun(target: ModelPart, pos: Vector3): ExSkill1Sprite コンストラクター
local ExSkill1Sprite = {
    ---コンストラクタ
    ---@param target ModelPart インスタンスオブジェクトをアタッチする親モデル
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
    ---@return ExSkill1Sprite
    new = function (target, pos)
        ---@type ExSkill1Sprite
        local instance = MiscUtils.instantiate(ExSkill1Sprite, SpawnObject)

        instance.target = target
        instance.object = instance.target:newSprite(instance.uuid)
        instance.pos = pos:copy()
        instance.lifetimeCount = 4

        instance.callbacks = {
            ---@param self ExSkill1Sprite
            onInit = function (self)
                self.object:setTexture(textures["textures.ex_skill_1"])
                self.object:setDimensions(textures["textures.ex_skill_1"]:getDimensions())
                self.object:setRegion(1, 1)
                self.object:setUVPixels(15, 7)
                self.object:setSize(1, 1)
                self.object:setPos(self.pos:copy():add(0.5, 0.5, 0))
				self.object:setRenderType("EMISSIVE_SOLID")
				self.object:setColor(vectors.vec3(1, 1, 1):scale(client:hasShaderPack() and 0.5 or 1))
            end;

            ---@param self ExSkill1Sprite
            onDeinit = function (self)
				self.target:removeTask(self.uuid)
            end;

            ---@param self ExSkill1Sprite
            onTick = function (self)
                if self.lifetimeCount == 0 then
                    self.shouldDeinit = true
                end
                self.lifetimeCount = self.lifetimeCount - 1
            end;
        }

        return instance
    end;
}

return ExSkill1Sprite
