---@class (exact) Meteor : SpawnObject 隕石のオブジェクトクラス
---@field package object ModelPart インスタンスで制御するモデルパーツ
---@field package currentPos Vector3 隕石の現在のティックの位置
---@field package nextPos Vector3 隕石の次のティックの位置
---@field package currentRot Vector3 隕石の現在のティックの角度
---@field package nextRot Vector3 隕石の次のティックの角度
---@field package rotSpeed Vector3 隕石の回転速度
---@field package dir Vector3 隕石が落ちていく方向
---@field package isHit boolean 隕石がブロックに当たったかどうか
---@field package strikeCount integer 隕石の爆発アニメーションのカウンター
local Meteor = {
	---コンストラクタ
	---@param targetPos Vector3 隕石を落とす目標座標
	new = function (targetPos)
		---@type Meteor
		local instance = MiscUtils.instantiate(Meteor, SpawnObject)

		instance.object = ModelUtils:copyModel(models.models.meteor.Meteor, instance.uuid, true)
		instance.dir = vectors.rotateAroundAxis(math.random() * 360, 0, -1, 0.5, 0, 1, 0):normalize()
		instance.currentPos = targetPos:copy():add(instance.dir:copy():scale(-256))
		instance.nextPos = instance.currentPos:copy()
		instance.currentRot = instance.object:getRot():copy()
		instance.nextRot = instance.currentRot:copy()
		instance.rotSpeed = vectors.rotateAroundAxis(math.random() * 360, 0, 0, 10, vectors.vec3(math.random(), math.random(), math.random()):normalize())
		instance.isHit = false
		instance.strikeCount = -1

		instance.callbacks = {
			---@param self Meteor
			onInit = function (self)
				models.script_meteor:addChild(self.object)
				self.object:setVisible(true)
				self.object.ExplosionEffect:setScale(0, 0, 0)
			end;

			---@param self Meteor
			onDeinit = function (self)
				models.script_meteor:removeChild(self.object)
				self.object:remove()
			end;

			---@param self Meteor
			onTick = function (self)
				if not self.isHit then
					--オブジェクトの位置を強制更新
					self.object:setPos(self.nextPos:copy():scale(16))
					self.currentPos = self.nextPos:copy()
					self.object.MeteorCube:setRot(self.nextRot:copy())
					self.nextRot = self.currentRot

					--次のオブジェクトの位置を計算
					self.nextPos = self.currentPos:copy():add(self.dir:copy():scale(3))
					self.nextRot = self.currentRot:copy():add(self.rotSpeed)

					--当たり判定チェック
					local block, hitPos, side = raycast:block(self.currentPos, self.nextPos, "COLLIDER", "ANY")
					if block ~= nil and block.id ~= "minecraft:air" and block.id ~= "minecraft:cave_air" and block.id ~= "minecraft:void_air" then
						self:strike(hitPos)
					end

					--トレイルパーティクル
					for i = 0, 3 do
						particles:newParticle("minecraft:end_rod", self.nextPos:copy():sub(self.currentPos):scale(i / 4):add(self.currentPos)):setScale(3):setColor(0.5, 1, 1):setLifetime(16)
					end
				else
					if self.strikeCount == 0 then
						self.shouldDeinit = true
					end
					self.strikeCount = self.strikeCount - 1
				end

			end;

			---@param self Meteor
			onRender = function (self, delta)
				if not self.isHit then
					self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):scale(16))
					self.object.MeteorCube:setRot(self.nextRot:copy():sub(self.currentRot):scale(delta):add(self.currentRot):scale(16))
				else
					local trueTick = 5 - (self.strikeCount) + delta
					self.object.ExplosionEffect:setScale(vectors.vec3(1, 1, 1):scale(trueTick / 6))
					local opacity = 1 - math.clamp((trueTick - 3) / 3, 0, 1)
					self.object.ExplosionEffect:setOpacity(opacity)
				end
			end;
		}

		return instance
	end;

	---隕石を爆発させる。
	---@param self Meteor
	---@param hitPos Vector3 隕石が当たった座標
	strike = function (self, hitPos)
		self.object:setPos(hitPos:copy():scale(16))
		self.object.MeteorCube:setVisible(false)
		self.strikeCount = 5
		self.isHit = true

		for _ = 1, 100 do
			particles:newParticle("minecraft:firework", hitPos):setScale(2):setVelocity(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1):setLifetime(16)
		end
		for _ = 1, 10 do
			particles:newParticle("minecraft:explosion", hitPos:copy():add(math.random() * 7 - 3.5, math.random() * 7 - 3.5, math.random() * 7 - 3.5)):setColor(1, 0.75, 1)
		end
		for i = 0, 5 do
			for j = 0, 71 do
				particles:newParticle("minecraft:firework", hitPos:copy():add(0, 0.1, 0)):setScale(2):setVelocity(vectors.rotateAroundAxis(j * 5, 0, 0, i * 0.1 + math.random() * 0.1 - 0.05, 0, 1, 0)):setGravity(0):setColor(0.75, 1, 1)
			end
		end

		sounds:playSound("minecraft:entity.generic.explode", hitPos, 0.5, 0.5):setAttenuation(2)
		sounds:playSound("minecraft:item.trident.return", hitPos, 1, 0.5):setAttenuation(2)
	end;
}

return Meteor
