---@class (exact) Pie : SpawnObject 投げるパイオブジェクトのインスタンスクラス
---@field package BULGE number パイオブジェクトが飛んでいく放物線の膨らみ具合
---@field package BOUNDING_LENGTH integer パイが跳ね飛ぶ時間の長さ（ティック）
---@field package MAX_PIE_DISTANCE number パイがターゲットとするプレイヤーの最大距離（ブロック）
---@field package object ModelPart インスタンスで制御するモデルパーツ
---@field package currentPos Vector3 パイオブジェクトの現ティックのワールド位置
---@field package nextPos Vector3 パイオブジェクトの次ティックのワールド位置
---@field package currentTargetPos Vector3 パイオブジェクトが飛んでいく元のワールド位置
---@field package nextTargetPos Vector3 パイオブジェクトが飛んでいく次のワールド位置
---@field package lifetime integer パイオブジェクトのインスタンスを廃棄するまでの時間（ティック）
---@field package boundingTick integer パイが跳ね飛ぶ時間のカウンター
---@field package targetPlayer Player|nil パイ投げのターゲットとなっているプレイヤーのインスタンス。ターゲットになるプレイヤーがいない場合は`nil`になる。
---@field package targetHistory table<string, boolean> パイ投げのターゲットになったことがあるプレイヤーの名前を記録するテーブル。キーがプレイヤー名、値が`true`になる。
---@field package velocity Vector3|nil ターゲットのロスト時にパイを飛ばす速度
local Pie = {
	---コンストラクタ
	---@param startPos Vector3 スポーンさせるパイの初期ワールド位置
	new = function (startPos)
		---@type Pie
		local instance = MiscUtils.instantiate(Pie, SpawnObject)

		instance.BULGE = 2
		instance.BOUNDING_LENGTH = 10
		instance.MAX_PIE_DISTANCE = 5

		instance.object = ModelUtils:copyModel(ModelAlias.alias.avatar.rightArmBottom.Pie, instance.uuid)
		instance.currentPos = startPos:copy()
		instance.nextPos = instance.currentPos:copy()
		instance.velocity = vectors.vec3()
		instance.currentTargetPos = instance.currentPos:copy()
		instance.nextTargetPos = instance.currentPos:copy()
		instance.lifetime = 100
		instance.boundingTick = 0
		instance.targetPlayer = nil
		instance.targetHistory = {}
		instance.velocity = nil

		instance.callbacks = {
			---@param self Pie
			onInit = function (self)
				models.script_pie:addChild(self.object)
				self.object:setVisible(true)

				self.targetHistory[player:getName()] = true
			end;

			---@param self Pie
			onDeinit = function (self)
				models.script_pie:removeChild(self.object)
				self.object:remove()
			end;

			---@param self Pie
			onTick = function (self)
				-- 跳ね飛ぶ時間の計算
				if self.boundingTick == 0 then
					if self.velocity == nil then
						-- 跳ね飛び座標の更新
						self.currentTargetPos = self.nextTargetPos:copy()

						-- 次の跳ね飛び先の探索
						self.targetPlayer = self:getTargetPlayer()
						if self.targetPlayer ~= nil then
							self.nextTargetPos = self.targetPlayer:getPos():copy():add(0, 1.5, 0)
							self.targetHistory[self.targetPlayer:getName()] = true
						else
							self.velocity = self.nextPos:copy():sub(self.currentPos)
							self.velocity.y = self.velocity.y * -1
						end

						self.boundingTick = self.BOUNDING_LENGTH
					end
				end
				self.boundingTick = self.boundingTick - 1

				-- オブジェクトの位置を強制更新
				self.object:setPos(self.nextPos:copy():scale(16))
				self.currentPos = self.nextPos:copy()

				-- 次のオブジェクトの位置を計算
				if self.velocity == nil then
					self.nextPos = self:getPiePos(self.currentTargetPos, self.nextTargetPos, 1 - (self.boundingTick / self.BOUNDING_LENGTH))
				else
					self.nextPos = self.currentPos:copy():add(self.velocity)
					self.velocity.y = math.max(self.velocity.y - 0.15, -0.49)
				end

				-- ブロックの当たり判定のチェック
				local block = raycast:block(self.currentPos, self.nextPos, "COLLIDER", "ANY")
				if not self.getIsAir(block) then
					self.shouldDeinit = true
				end

				-- ライフタイムの計算
				if self.lifetime == 0 then
					self.shouldDeinit = true
				end
				self.lifetime = self.lifetime - 1
			end;

			---@param self Pie
			onRender = function (self, delta)
				self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos):scale(16))
			end;
		};

		return instance
	end;

	---指定したブロックステートが空気ブロックに属するものかどうかを返す。
	---@param block BlockState チェックするブロックステート
	---@return boolean isAir 指定したブロックステートが空気ブロックに属するものかどうか。
	getIsAir = function (block)
		return block ~= nil and (block.id == "minecraft:air" or block.id == "minecraft:cave_air" or block.id == "minecraft:void_air")
	end;

	---地点Aから地点Bまでパイを投げ、放物線を描きながら飛んでいくときの、指定した進行度での速度を返す。
	---@param self Pie
	---@param posA Vector3 地点Aのワールド位置
	---@param posB Vector3 地点Bのワールド位置
	---@param delta number 進行度（0.0～1.0）
	---@return Vector3 pos 指定した進行度におけるワールド位置
	getPiePos = function(self, posA, posB, delta)
		local x = posA.x + (posB.x - posA.x) * delta
		local z = posA.z + (posB.z - posA.z) * delta

		local linearY = posA.y + (posB.y - posA.y) * delta
		local arcY = 4 * self.BULGE * delta * (1 - delta)
		local y = linearY + arcY

		return vectors.vec3(x, y, z)
	end;

	---地点Aから地点Bまでを描く放物線上の点のうち、Y座標が最も大きくなる点のワールド座標を返す。
	---@param self Pie
	---@param posA Vector3 地点Aのワールド位置
	---@param posB Vector3 地点Bのワールド位置
	---@return Vector3 pos 指定した地点Aと地点Bの放物線上で最もY座標が大きくなる点のワールド位置
	getMaxHeightPos = function (self, posA, posB)
		local denominator = 8 * self.BULGE
		local delta = 0.5 + ((posB.y - posA.y) / denominator)
		delta = math.max(0, math.min(1, delta))

		return self:getPiePos(posA, posB, delta)
	end;

	---パイ投げの軌道上に当たり判定のあるブロックが存在するか返す。
	---当たり判定のチェックは、①地点Aからパイの軌道の最高点、②パイの軌道の最高点から地点Bまでの二分割にして行う。
	---@param self Pie
	---@param posA Vector3 地点Aのワールド位置
	---@param posB Vector3 地点Bのワールド位置
	---@return boolean isBlocking パイ投げの軌道上に当たり判定のあるブロックが存在するかどうか。
	getIsBlockingPieArc = function (self, posA, posB)
		local block1 = raycast:block(posA, self:getMaxHeightPos(posA, posB), "COLLIDER", "ANY")
		if not self.getIsAir(block1) then
			return true
		end

		local block2 = raycast:block(self:getMaxHeightPos(posA, posB), posB, "COLLIDER", "ANY")
		return not self.getIsAir(block2)
	end;

	---パイ投擲先のプレイヤーのインスタンスを返す。
	---ターゲットとなるプレイヤーは以下の条件に合うプレイヤーのうち、パイから最寄りのプレイヤーが選ばれる。
	--- 1. パイから半径5ブロック以内にいる。
	--- 2. パイの投擲ルートにブロックが存在しない。
	--- 3. このパイが初めてターゲットにするプレイヤーである。
	--- 4. 自分自身ではない。
	---@param self Pie
	---@return Player|nil targetPlayer ターゲットとなるプレイヤーのインスタンス。条件に合うプレイヤーがいない場合はnilを返す。
	getTargetPlayer = function (self)
		local nearestPlayer = nil
		local nearestDistance = self.MAX_PIE_DISTANCE
		for name, instance in pairs(world:getPlayers()) do
			if self.targetHistory[name] then
				goto continue
			end

			if instance:getPos():copy():sub(self.currentPos):length() > self.MAX_PIE_DISTANCE then
				goto continue
			end

			if self:getIsBlockingPieArc(self.currentPos, instance:getPos()) then
				goto continue
			end

			if nearestPlayer == nil or instance:getPos():copy():sub(self.currentPos):length() < nearestDistance then
				nearestPlayer = instance
				nearestDistance = instance:getPos():copy():sub(self.currentPos):length()
			end

			::continue::
		end

		return nearestPlayer
	end;
};

return Pie;
