---@class (exact) ExSkillShootingStar : SpawnObject Exスキル内で使用する流れ星のオブジェクトクラス
---@field package object Particle インスタンスで制御するメインのパーティクル
---@field package currentPos Vector3 流れ星の現在のティックの位置
---@field package nextPos Vector3 流れ星の次のティックの位置
---@field package dir Vector3 流れ星を流す方向
---@field package color Vector3 流れ星パーティクルの色
---@field package lifetime integer 流れ星の残り時間を測るカウンター
local ExSkillShootingStar = {
    ---コンストラクタ
	---@param pos Vector3 流れ星をスポーンするワールド座標
	---@param dir Vector3 流れ星を流す方向
	new = function (pos, dir)
		---@type ExSkillShootingStar
		local instance = MiscUtils.instantiate(ExSkillShootingStar, SpawnObject)

		instance.object = nil
		instance.currentPos = pos:copy()
		instance.nextPos = instance.currentPos:copy()
		instance.dir = dir:copy():normalize()
		instance.color = nil
		instance.lifetime = 50 + math.random() * 10

		instance.callbacks = {
			---@param self ExSkillShootingStar
			onInit = function (self)
				local color1 = vectors.vec3(1, 0.75, 1)
				local color2 = vectors.vec3(0.75, 1, 1)
				self.color = color2:copy():sub(color1):scale(math.random()):add(color1)
				self.object = particles:newParticle("minecraft:firework", self.currentPos)
					:setScale(25)
					:setColor(self.color)
					:setLifetime(self.lifetime)
			end;

			---@param self ExSkillShootingStar
			onDeinit = function (self)
			end;

			---@param self ExSkillShootingStar
			onTick = function (self)
				--オブジェクトの位置を強制更新
				self.object:setPos(self.nextPos)
				self.currentPos = self.nextPos:copy()

				--次のオブジェクトの位置を計算
				self.nextPos = self.currentPos:copy():add(self.dir:copy():scale(10))

				for i = 0, 3 do
					particles:newParticle("minecraft:end_rod", self.nextPos:copy():sub(self.currentPos):scale(i / 4):add(self.currentPos))
						:setScale(10)
						:setColor(self.color)
						:setLifetime(16)
				end

				--オブジェクトの残り時間を更新
				if self.lifetime <= 0 then
					self.shouldDeinit = true
				end
				self.lifetime = self.lifetime - 1
			end;

			---@param self ExSkillShootingStar
			onRender = function (self, delta, context)
				self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos))
			end;
		}

		return instance
	end;
}

return ExSkillShootingStar
