---@class (exact) Wet 水濡れをシミュレートし、髪の水滴などを制御するクラス
---@field package MAX_WET_COUNT integer 濡れカウンターの最大値
---@field package waterDrops {model: ModelPart, sortValue: integer}[] 水滴のモデルパーツを格納するテーブル
---@field package wetCount integer 水濡れの時間を測るカウンター
---@field package isDropMasterVisible boolean 水滴モデル全体が見える状態かどうか（個別にオフになっている可能性もある）
---@field package nextDropCount integer 次の水滴パーティクルを再生するまでのカウンター
---@field package sequenceIndex integer 現在の水滴を削除している位置
local Wet = {
	MAX_WET_COUNT = 2400;

	waterDrops = {};
	wetCount = 0;
	isDropMasterVisible = false;
	nextDropCount = 0;
	sequenceIndex = 0;

	---水滴モデルを`waterDrops`テーブルに格納する。
	---@param self Wet
	insertWaterDropModels = function (self)
		for _, waterDropModelParent in ipairs({ModelAlias.alias.avatar.head.HWaterDrops, ModelAlias.alias.avatar.body.Hairs.FrontHair.FHWaterDrops, ModelAlias.alias.avatar.body.Hairs.BackHair.BHWaterDrops}) do
			for _, waterDropModel in ipairs(waterDropModelParent:getChildren()) do
				table.insert(self.waterDrops, {model = waterDropModel, sortValue = 0})
			end
		end
	end;

	---`waterDrops`テーブルに格納された水滴モデルパーツを初期化する。
	---@param self Wet
	initializeWaterDropModels = function (self)
		for _, waterDrop in ipairs(self.waterDrops) do
			waterDrop.model:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
			waterDrop.model:setOpacity(0.5)
			waterDrop.model:setVisible(false)
		end
	end;

	---`waterDrops`テーブル内の全ての水滴モデルパーツの可視性を切り替える。
	---@param self Wet
	---@param value boolean 水滴モデルを表示するかどうか。
	setDropsVisibleAll = function (self, value)
		for _, waterDrop in ipairs(self.waterDrops) do
			waterDrop.model:setVisible(value)
		end
		self.isDropMasterVisible = value
	end;

	---`waterDrops`テーブル内の要素をランダムに並び替える。
	---@param self Wet
	sortDropsRandom = function (self)
		for _, waterDrop in ipairs(self.waterDrops) do
			waterDrop.sortValue = math.random(0, 10000)
		end
		table.sort(self.waterDrops, function (a, b)
			return b.sortValue - a.sortValue >= 0
		end)
	end;

	---初期化関数
	---@param self Wet
	init = function (self)
		self:insertWaterDropModels()
		self:initializeWaterDropModels()

		events.TICK:register(function ()
			if not client:isPaused() then
				if player:isInWater() then
					self.wetCount = self.MAX_WET_COUNT
					self.nextDropCount = 0
					self.sequenceIndex = 0

					local isUnderwater = player:isUnderwater()
					if isUnderwater == self.isDropMasterVisible then
						self:setDropsVisibleAll(not isUnderwater)
					end
				else
					if self.wetCount == self.MAX_WET_COUNT then
						self:sortDropsRandom()
					elseif self.wetCount == 0 and self.isDropMasterVisible then
						self.nextDropCount = 0
						self.sequenceIndex = 0
						self:setDropsVisibleAll(false)
					end
					self.wetCount = math.max(self.wetCount - 1, 0)

					if self.wetCount > 0 then
						if self.nextDropCount == 0 then
							particles:newParticle("minecraft:falling_water", player:getPos():copy():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, ModelAlias.alias.avatar.root:getAnimPos():copy():scale(0.0625 * 0.9375):mul(-1, 1, -1), 0, 1, 0)):add(math.random() * 1 - 0.5, math.random() * 1 + 1, math.random() * 1 - 0.5)):setScale(0.5)

							if self.wetCount >= self.MAX_WET_COUNT * 0.75 then
								self.nextDropCount = math.random(1, 4)
							elseif self.wetCount >= self.MAX_WET_COUNT * 0.5 then
								self.nextDropCount = math.random(5, 8)
							elseif self.wetCount >= self.MAX_WET_COUNT * 0.25 then
								self.nextDropCount = math.random(9, 12)
							else
								self.nextDropCount = math.random(13, 16)
							end
						end
						self.nextDropCount = math.max(self.nextDropCount - 1, 0)

						while self.sequenceIndex < #self.waterDrops - math.floor(self.wetCount / self.MAX_WET_COUNT * #self.waterDrops) do
							self.waterDrops[self.sequenceIndex + 1].model:setVisible(false)
							self.sequenceIndex = self.sequenceIndex + 1
						end

						if world:getDimension() == "minecraft:the_nether" then
							self.wetCount = 0
						end
					end
				end
			end
		end)
	end;
}

return Wet
