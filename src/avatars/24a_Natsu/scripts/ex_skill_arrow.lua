---@class (exact) ExSkillArrow : SpawnObject Exスキルアニメーションで使用する矢のオブジェクトのインスタンスクラス
---@field package object ModelPart インスタンスで制御するモデルパーツ
---@field package currentPos Vector3 矢のオブジェクトの現ティックのワールド位置
---@field package nextPos Vector3 矢のオブジェクトの次ティックのワールド位置
---@field package currentRot Vector3 矢のオブジェクトの現ティックのワールド角度
---@field package nextRot Vector3 矢のオブジェクトの次ティックのワールド角度
---@field package velocity Vector3 矢のオブジェクトが飛んでいく速度
---@field package lifetime integer 矢のオブジェクトのインスタンスを廃棄するまでの時間（ティック）
local ExSkillArrow = {
	---コンストラクタ
	---@param pos Vector3 矢のオプジェクトをスポーンさせるワールド位置
	---@param velocity Vector3 矢のオブジェクトの初速
	new = function (pos, velocity)
		---@type ExSkillArrow
		local instance = MiscUtils.instantiate(ExSkillArrow, SpawnObject)

		instance.object = models.models.ex_skill_1.AnimationArrow:copy(instance.uuid)
		instance.currentPos = pos:copy()
		instance.nextPos = instance.currentPos:copy()
		instance.currentRot = vectors.vec3()
		instance.nextRot = vectors.vec3()
		instance.velocity = velocity:copy()
		instance.lifetime = 100

		instance.callbacks = {
			---@param self ExSkillArrow
			onInit = function (self)
				models.script_ex_skill_arrow:addChild(self.object)
				self.currentRot = vectors.vec3(math.deg(math.atan2(self.velocity.y, math.sqrt(self.velocity.x ^ 2 + self.velocity.z ^ 2))), math.deg(math.atan2(self.velocity.x, self.velocity.z)) + 180, 0)
				self.nextRot = self.currentRot:copy()
				self.object:setVisible(true)
			end;

			---@param self ExSkillArrow
			onDeinit = function (self)
				models.script_ex_skill_arrow:removeChild(self.object)
				self.object:remove()
			end;

			---@param self ExSkillArrow
			onTick = function (self)
				-- オブジェクトの位置を強制更新
				self.object:setPos(self.nextPos:copy():scale(16))
				self.currentPos = self.nextPos:copy()
				self.object:setRot(self.nextRot:copy())
				self.currentRot = self.nextRot:copy()

				-- 次のオブジェクトの位置を計算
				self.nextPos = self.currentPos:copy():add(self.velocity)
                self.velocity.y = self.velocity.y - 0.01
                self.nextRot.x = math.deg(math.atan2(self.velocity.y, math.sqrt(self.velocity.x ^ 2 + self.velocity.z ^ 2)))

				-- 当たり判定チェック
				local block = raycast:block(self.currentPos, self.nextPos, "COLLIDER", "ANY")
				if block ~= nil and block.id ~= "minecraft:air" and block.id ~= "minecraft:cave_air" and block.id ~= "minecraft:void_air" then
					self.shouldDeinit = true
				end

				-- ライフタイムの計算
				if self.lifetime == 0 then
					self.shouldDeinit = true
				end

				self.lifetime = self.lifetime - 1
			end;

			---@param self ExSkillArrow
			onRender = function (self, delta)
				self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):scale(16))
				self.object:setRot(self.nextRot:copy():sub(self.currentRot):scale(delta):add(self.currentRot))
			end;
		}

		return instance
	end;
}

return ExSkillArrow
