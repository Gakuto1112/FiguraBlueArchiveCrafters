---@class (exact) ExSkill1Water : SpawnObject Exスキル1で使用する水スプライトの単一を管理するクラス
---@field package object ModelPart インスタンスで制御するオブジェクト
---@field package rot number スプライトの角度
---@field package currentPos Vector3 スプライトの現在位置
---@field package velocity Vector3 スプライトの移動速度
---@field package lifeCount integer スプライトを表示する残り時間
---@field public new fun(pos: Vector3, velocity: Vector3): ExSkill1Water コンストラクタ
local ExSkill1Water = {
    ---コンストラクタ
    ---@param pos Vector3 水スプライトをスポーンさせるワールド座標
    ---@param velocity Vector3 水スプライトを移動させる速度
    ---@return ExSkill1Water
    new = function (pos, velocity)
        ---@type ExSkill1Water
        local instance = MiscUtils.instantiate(ExSkill1Water, SpawnObject)

        instance.object = models.models.ex_skill_1.Water:copy(instance.uuid)
        instance.rot = math.random() * 360
        instance.currentPos = pos:copy()
        instance.velocity = velocity:copy()
        instance.lifeCount = 20

        instance.callbacks = {
            ---@param self ExSkill1Water
            onInit = function (self)
                models.script_ex_skill_1_water:addChild(self.object)
                self.object:setRot(0, self.rot, 0)
                self.object:setVisible(true)
            end;

            ---@param self ExSkill1Water
            onDeinit = function (self)
                models.script_ex_skill_1_water:removeChild(self.object)
                self.object:remove()
            end;

            ---@param self ExSkill1Water
            onTick = function (self)
                self.currentPos:add(self.velocity)
                self.velocity:scale(0.9)
                self.object:setColor(vectors.vec3(0.439, 0.988, 0.98):sub(0, 0.2, 0.8):scale(self.lifeCount / 20):add(0, 0.2, 0.8))
                if self.lifeCount == 0 then
                    self.shouldDeinit = true
                end
                self.lifeCount = self.lifeCount - 1
            end;

            ---@param self ExSkill1Water
            onRender = function (self, delta)
                local spriteScale = math.sin(math.rad((20 - self.lifeCount + delta) * 4.5))
                self.object:setPos(self.currentPos:copy():add(self.velocity:copy():scale(delta)):scale(16):add(0, 0.1, 0))
                self.object:setScale(spriteScale)
                self.object:setOpacity(math.min((1 - spriteScale) * 2, 1))
            end;
        }

        return instance
    end;
}

return ExSkill1Water
