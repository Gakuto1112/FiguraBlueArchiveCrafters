---@class (exact) FadingBlock : SpawnObject Exスキル3で使用する消えるブロックのクラス
---@field package object BlockTask インスタンスで制御するオブジェクト
---@field package shineBlockObject? ModelPart 輝くブロックのモデルパーツ
---@field package pos Vector3 このブロックの座標（親モデルパーツ基準）
---@field package lifetime integer このインスタンスが破棄されるまでの時間
---@field package shouldShine boolean `lifetime`が0になったときに光って消えるかどうか
---@field package shineTime? integer ブロックが輝く時間
local FadingBlock = {
	---コンストラクタ
	---@param pos Vector3 ブロックをスポーンさせる座標
	---@param block Minecraft.blockID このブロックの見た目
	---@param blockProperty? string `block`で設定したブロックのプロパティ（あれば）
	---@param lifetime integer このブロックが消えるまでの時間
	---@param shouldShine boolean `lifetime`が0になったときに光って消えるかどうか
	---@param shineTime? integer ブロックが輝く時間
	new = function (pos, block, blockProperty, lifetime, shouldShine, shineTime)
		local instance = MiscUtils.instantiate(FadingBlock, SpawnObject)

		instance.object = models.script_fading_block_area:newBlock(instance.uuid)
		instance.shineBlockObject = nil
		instance.pos = pos:copy()
		instance.lifetime = lifetime
		instance.shouldShine = shouldShine
		instance.shineTime = shineTime and shineTime or 100

		instance.callbacks = {
			---@param self FadingBlock
			onInit = function (self)
				self.object:setBlock(block .. (blockProperty ~= nil and blockProperty or ""))
				self.object:setPos(self.pos:copy():scale(16))
				self.object:setLight(0, 7)
			end;

			---@param self FadingBlock
			onDeinit = function (self)
				self.object:remove()
				if self.shineBlockObject ~= nil then
					models.script_fading_block_area:removeChild(self.shineBlockObject)
					self.shineBlockObject:remove()
				end
			end;

			---@param self FadingBlock
			onTick = function (self)
				if self.lifetime == 0 then
					self.object:remove()
					if self.shouldShine then
						self.shineBlockObject = models.models.ex_skill_1.ShineBlock:copy(client.intUUIDToString(client.generateUUID()))
						self.shineBlockObject:setPos(self.pos:copy():scale(16))
						self.shineBlockObject:setColor(0.25, 0.25, 0.25)
						self.shineBlockObject:setVisible(true)
						models.script_fading_block_area:addChild(self.shineBlockObject)
					else
						self.shouldDeinit = true
					end
				elseif self.lifetime == self.shineTime * -1 then
					local anchorPos = player:getPos():copy():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, self.pos:copy():add(0.5, -0.5, 0.5), 0, 1, 0))
					for _ = 1, 2 do
						local offset = vectors.vec3(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)
						--particles:newParticle("minecraft:cherry_leaves", anchorPos:copy():add(offset)):setScale(1):setVelocity(offset:copy():scale(0.5)):setColor(0.95, 0.87, 1) --花びらも捨てがたいな...
						particles:newParticle("minecraft:end_rod", anchorPos:copy():add(offset)):setScale(2):setVelocity(offset:copy():scale(0.5)):setColor(0.95, 0.87, 1):setLifetime(20 + math.random() * 20)
					end
					self.shouldDeinit = true
				end
				self.lifetime = self.lifetime - 1
			end;

			---@param self FadingBlock
			---@param delta number
			onRender = function (self, delta)
				if self.shineBlockObject ~= nil then
					self.shineBlockObject:setColor(vectors.vec3(1, 1, 1):scale(math.min((self.lifetime * -1 + delta) * 0.15 + 0.25, 1)))
				end
			end;
		}

		return instance
	end;
}

return FadingBlock
