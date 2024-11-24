---@class (exact) ExSkillFrameParticle : SpawnObject Exスキルのフレームで使用するパーティクルの単一を管理するクラス
---@field package object ModelPart インスタンスで制御するオブジェクト
---@field package uuid string パーティクルのUUID
---@field package currentPos Vector2 パーティクルの現在位置
---@field package nextPos Vector2 次ティックのパーティクルの位置
---@field package velocity Vector2 パーティクルの速度
---@field package particleCount integer パーティクルのアニメーションを制御するためのカウンター
---@field public new fun(parent: Avatar, pos: Vector2, velocity: Vector2, type: ExSkillFrameParticleManager.ParticleType): ExSkillFrameParticle コンストラクター

ExSkillFrameParticle = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@param pos Vector2 パーティクルをスポーンさせるスクリーン上の座標。GUIスケールも考慮される。
    ---@param velocity Vector2 パーティクルの秒間移動距離（ピクセル）
    ---@param type ExSkillFrameParticleManager.ParticleType このインスタンスのパーティクルの種類
    ---@return ExSkillFrameParticle
    new = function (parent, pos, velocity, type)
        ---@type ExSkillFrameParticle
        local instance = Avatar.instantiate(ExSkillFrameParticle, SpawnObject, parent)

        instance.uuid = client.intUUIDToString(client:generateUUID())
        instance.object = models.models.ex_skill_frame.Particles["Particle"..(type == "NORMAL" and 1 or 2)]:copy(instance.uuid)
        instance.currentPos = pos
        instance.nextPos = instance.currentPos
        instance.velocity = velocity
        instance.particleCount = 0

        instance.callbacks = {
            ---@param self ExSkillFrameParticle
            onInit = function (self)
                models.models.ex_skill_frame.Gui.script_ex_skill_frame_particles:addChild(self.object)
                self.object:setRot(90, math.random() * 360, 180)
            end;

            ---@param self ExSkillFrameParticle
            onDeinit = function (self)
                self.object:remove()
            end;

            ---@param self ExSkillFrameParticle
            onTick = function (self)
                --パーティクル位置を強制更新
                self.currentPos = self.nextPos:copy()
                self.object:setPos(self.currentPos:copy():augmented(0))
                self.object:setScale(vectors.vec3(1, 1, 1):scale(1 - self.particleCount / 5))

                --カウンターを更新
                self.particleCount = self.particleCount + 1
                if self.particleCount == 5 then
                    self.object:remove()
                elseif self.particleCount == 6 then
                    self.shouldDeinit = true
                end

                --次ティックの位置を計算
                if self.velocity:length() > 0 then
                    self.nextPos = self.currentPos:copy():add(self.velocity:copy():scale(-0.05))
                end
            end;

            ---@param self ExSkillFrameParticle
            onRender = function (self, delta)
                self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):augmented(0))
                self.object:setScale(vectors.vec3(1, 1, 1):scale(1 - (self.particleCount + delta) / 5))
            end;
        }

        return instance
    end;
}