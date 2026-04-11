---@class (exact) ExSkillSplashParticle : SpawnObject Exスキルのスプラッシュで使用するパーティクルの単一を管理するクラス
---@field package object SpriteTask インスタンスで制御するオブジェクト
---@field package currentPos Vector2 パーティクルの現在位置
---@field package nextPos Vector2 次ティックのパーティクルの位置
---@field package velocity Vector2 パーティクルの速度
local ExSkillSplashParticle = {
    ---コンストラクタ
    ---@param pos Vector2 パーティクルをスポーンさせるスクリーン上の座標。GUIスケールも考慮される。
    ---@param velocity Vector2 パーティクルの秒間移動距離（ピクセル）
    ---@return ExSkillSplashParticle
    new = function (parent, pos, velocity)
        ---@type ExSkillSplashParticle
        local instance = MiscUtils.instantiate(ExSkillSplashParticle, SpawnObject, parent)

        instance.object = models.models.ex_skill_1.Gui.script_ex_skill_1_splash_particles:newSprite(instance.uuid)
        instance.currentPos = pos
        instance.nextPos = instance.currentPos
        instance.velocity = velocity

        instance.callbacks = {
            ---@param self ExSkillSplashParticle
            onInit = function (self)
                self.object:setTexture(textures["textures.ex_skill_1"])
                self.object:setDimensions(textures["textures.ex_skill_1"]:getDimensions())
                self.object:setRegion(1, 1)
                self.object:setSize(5, 5)
                self.object:setUVPixels(33, 15)
            end;

            ---@param self ExSkillSplashParticle
            onDeinit = function (self)
                models.models.ex_skill_1.Gui.script_ex_skill_1_splash_particles:removeTask(self.uuid)
            end;

            ---@param self ExSkillSplashParticle
            onTick = function (self)
                --パーティクル位置を強制更新
                self.currentPos = self.nextPos:copy()
                self.object:setPos(self.currentPos:copy():augmented(0))

                --次ティックの位置を計算
                if self.velocity:length() > 0 then
                    self.nextPos = self.currentPos:copy():add(self.velocity:copy():scale(1))
                    self.velocity:scale(0.85)
                end
            end;

            ---@param self ExSkillSplashParticle
            onRender = function (self, delta)
                self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):augmented(0))
            end;
        }

        return instance
    end;
}

return ExSkillSplashParticle
