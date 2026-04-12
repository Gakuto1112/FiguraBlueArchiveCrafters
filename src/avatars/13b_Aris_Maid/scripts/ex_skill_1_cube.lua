---@class (exact) ExSkill1Cube : SpawnObject Exスキル1で使用するキューブの単一を管理するクラス
---@field public new fun(): ExSkill1Cube コンストラクタ
---@field package object ModelPart インスタンスで制御するオブジェクト
---@field package objectPos Vector3 オブジェクトの基準となるアバター座標
---@field package shotHeight number オブジェクトを打ち出す高さ
---@field package animationCount integer アニメーションのタイミングを計るカウンター
local ExSkill1Cube = {
    ---コンストラクタ
    ---@return ExSkill1Cube
    new = function ()
        ---@type ExSkill1Cube
        local instance = MiscUtils.instantiate(ExSkill1Cube, SpawnObject)

        instance.object = models.models.ex_skill_1.Cube:copy(instance.uuid)
        instance.objectPos = vectors.vec3(math.random() * 400 + 150, 0, math.random() * 100 + 10)
        instance.shotHeight = math.random() * 8
        instance.animationCount = 0

        instance.callbacks = {
            ---@param self ExSkill1Cube
            onInit = function (self)
                models.script_ex_skill_1_cube:addChild(self.object)
                local widthScale = math.max(self.shotHeight * -2 + 5, 1)
                self.object:setScale(vectors.vec3(widthScale, 1, widthScale):scale(math.random() * 1 + 0.25))
                self.object:setVisible(true)
            end;

            ---@param self ExSkill1Cube
            onDeinit = function (self)
                models.script_ex_skill_1_cube:removeChild(self.object)
                self.object:remove()
            end;

            ---@param self ExSkill1Cube
            onTick = function (self)
                if self.animationCount % 4 == 0 then
                    local palette = {vectors.vec3(1, 0.996, 0.31), vectors.vec3(0.988, 0.773, 0.227), vectors.vec3(1, 0.486, 0.482), vectors.vec3(0.376, 0.925, 0.231)}
                    self.object:setColor(palette[math.random(1, #palette)])
                end
                self.animationCount = self.animationCount + 1
            end;

            ---@param self ExSkill1Cube
            onRender = function (self, delta)
                self.object:setPos(self.objectPos:copy():add(0, math.sin(math.rad(math.min(self.animationCount + delta, 10) * 9)) * 16 * self.shotHeight, 0))
            end;
        }

        return instance
    end;
}

return ExSkill1Cube
