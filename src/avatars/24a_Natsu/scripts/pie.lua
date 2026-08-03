---@class (exact) Pie : SpawnObject 投げるパイオブジェクトのインスタンスクラス
---@field package BULGE number パイオブジェクトが飛んでいく放物線の膨らみ具合
---@field package BOUNDING_LENGTH integer パイが跳ね飛ぶ時間の長さ（ティック）
---@field package object ModelPart インスタンスで制御するモデルパーツ
---@field package currentPos Vector3 パイオブジェクトの現ティックのワールド位置
---@field package nextPos Vector3 パイオブジェクトの次ティックのワールド位置
---@field package currentTargetPos Vector3 パイオブジェクトが飛んでいく元のワールド位置
---@field package nextTargetPos Vector3 パイオブジェクトが飛んでいく次のワールド位置
---@field package lifetime integer パイオブジェクトのインスタンスを廃棄するまでの時間（ティック）
---@field package boundingTick integer パイが跳ね飛ぶ時間のカウンター
local Pie = {
	---コンストラクタ
	---@param startPos Vector3 スポーンさせるパイの初期ワールド位置
	new = function (startPos)
		---@type Pie
		local instance = MiscUtils.instantiate(Pie, SpawnObject)

		instance.BULGE = 2
		instance.BOUNDING_LENGTH = 10

		instance.object = ModelUtils:copyModel(ModelAlias.alias.avatar.rightArmBottom.Pie, instance.uuid)
		instance.currentPos = startPos:copy()
		instance.nextPos = instance.currentPos:copy()
		instance.velocity = vectors.vec3()
		instance.currentTargetPos = instance.currentPos:copy()
		instance.nextTargetPos = instance.currentPos:copy()
		instance.lifetime = 100
		instance.boundingTick = instance.BOUNDING_LENGTH

		instance.callbacks = {
			---@param self Pie
			onInit = function (self)
				models.script_pie:addChild(self.object)
				self.nextTargetPos = vectors.rotateAroundAxis(player:getBodyYaw(), 0, 0, -3, 0, 1, 0):add(player:getPos())
				self.object:setVisible(true)
			end;

			---@param self Pie
			onDeinit = function (self)
				models.script_pie:removeChild(self.object)
				self.object:remove()
			end;

			---@param self Pie
			onTick = function (self)
				---オブジェクトの位置を強制更新
				self.object:setPos(self.nextPos:copy():scale(16))
				self.currentPos = self.nextPos:copy()

				---次のオブジェクトの位置を計算
				self.nextPos = self:getPiePos(self.currentTargetPos, self.nextTargetPos, 1 - (self.boundingTick / self.BOUNDING_LENGTH))

				---ブロックの当たり判定のチェック
				local block = raycast:block(self.currentPos, self.nextPos, "COLLIDER", "ANY")
				if block ~= nil and block.id ~= "minecraft:air" and block.id ~= "minecraft:cave_air" and block.id ~= "minecraft:void_air" then
					self.shouldDeinit = true
				end

				---ライフタイムの計算
				if self.lifetime == 0 then
					self.shouldDeinit = true
				end
				self.lifetime = self.lifetime - 1

				---跳ね飛ぶ時間の計算
				if self.boundingTick == 0 then
					self.boundingTick = self.BOUNDING_LENGTH
				end
				self.boundingTick = self.boundingTick - 1
			end;

			---@param self Pie
			onRender = function (self, delta)
				self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):scale(16))
			end;
		};

		return instance
	end;

	---地点Aから地点Bまでパイを投げ、放物線を描きながら飛んでいくときの、指定した進行度での速度を返す。
	---@param self Pie
	---@param posA Vector3 地点Aのワールド位置
	---@param posB Vector3 地点Bのワールド位置
	---@param delta number 進行度（0.0～1.0）
	---@return Vector3 pos 指定した進行度におけるワールド位置
	getPiePos = function(self, posA, posB, delta)
		local x = posA.x + (posA.x - posB.x) * delta
		local z = posA.z + (posB.z - posA.z) * delta

		local linearY = posA.y + (posB.y - posA.y) * delta
		local arcY = 4 * self.BULGE * delta * (1 - delta)
		local y = linearY + arcY

		return vectors.vec3(x, y, z)
	end;
};

return Pie;