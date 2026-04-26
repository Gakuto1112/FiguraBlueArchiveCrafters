---@class (exact) ExSkill1Sprite : SpawnObject Exスキル内で使用するスプライトのオブジェクトのクラス
---@field package object SpriteTask インスタンスで制御するオブジェクト
---@field package spriteType ExSkill1SpriteManager.SpriteType スプライトの種類
---@field package currentPos Vector2 オブジェクトの現在位置
---@field package nextPos Vector2 次ティックのオブジェクトの位置
---@field package velocity Vector2 オブジェクトの速度
---@field package lifetimeCount integer オブジェクトの残り時間を計るカウンター
---@field public new fun(type: ExSkill1SpriteManager.SpriteType, pos: Vector2, velocity: Vector2): ExSkill1Sprite コンストラクター
local ExSkill1Sprite = {
    ---コンストラクタ
    ---@param type ExSkill1SpriteManager.SpriteType スプライトの種類
    ---@param pos Vector2 オブジェクトの初期位置
    ---@param velocity Vector2 オブジェクトの移動速度
    ---@return ExSkill1Sprite
    new = function (type, pos, velocity)
        ---@type ExSkill1Sprite
        local instance = MiscUtils.instantiate(ExSkill1Sprite, SpawnObject)

        instance.object = models.script_ex_skill_1_sprite:newSprite(instance.uuid)
        instance.spriteType = type
        instance.currentPos = pos:copy()
        instance.nextPos = instance.currentPos:copy()
        instance.velocity = velocity:copy()
        instance.lifetimeCount = 28

        instance.callbacks = {
            ---@param self ExSkill1Sprite
            onInit = function (self)
                self.object:setTexture(textures["textures.ex_skill_1"])
                self.object:setDimensions(textures["textures.ex_skill_1"]:getDimensions())
                if self.spriteType == "STAR" then
                    self.object:setRegion(15, 15)
                    self.object:setUVPixels(25, 9)
                    self.object:setSize(50, 50)
                    self.object:setRot(0, 0, math.random() * 60 - 30)
                    self.object:setColor(math.random() < 0.5 and vectors.vec3(0.996, 0.4, 0.455) or vectors.vec3(0.231, 0.725, 0.988))
                else
                    self.object:setRegion(5, 5)
                    self.object:setSize(25, 25)
                    self.object:setColor(vectors.hsvToRGB(math.random(), 1, 1))
                    if self.spriteType == "MINISTAR" then
                        self.object:setUVPixels(40, 9)
                    else
                        self.object:setUVPixels(40, 14)
                    end
                end
                self.object:setPos(self.currentPos:copy():augmented(self.spriteType == "STAR" and -3 or -2))
            end;

            ---@param self ExSkill1Sprite
            onDeinit = function (self)
                models.script_ex_skill_1_sprite:removeTask(self.uuid)
            end;

            ---@param self ExSkill1Sprite
            onTick = function (self)
                --パーティクル位置を強制更新
                if self.velocity:length() > 0 then
                    self.currentPos = self.nextPos:copy()
                    self.object:setPos(self.currentPos:copy():add(25, 25):augmented(self.spriteType == "STAR" and -3 or -2))
                end

                --次の位置を計算
                self.nextPos = self.currentPos:copy():add(self.velocity)
                self.velocity:scale(0.7)

                --カウンターを更新
                if self.lifetimeCount == 14 then
                    if self.spriteType == "MINISTAR" then
                        self.object:setUVPixels(45, 9)
                    elseif self.spriteType == "MINISTAR2" then
                        self.object:setUVPixels(45, 14)
                    end
                elseif self.lifetimeCount == 0 then
                    self.shouldDeinit = true
                end
                self.lifetimeCount = self.lifetimeCount - 1
            end;

            ---@param self ExSkill1Sprite
            onRender = function (self, delta)
                self.object:setPos(self.currentPos:copy():add(self.nextPos:copy():sub(self.currentPos):scale(delta)):add(25, 25):augmented(self.spriteType == "STAR" and -3 or -2))
            end;
        }

        return instance
    end;
}

return ExSkill1Sprite
