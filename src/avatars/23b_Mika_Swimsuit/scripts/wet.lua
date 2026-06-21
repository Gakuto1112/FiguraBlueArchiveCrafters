---@class (exact) Wet 水濡れをシミュレートし、髪の水滴などを制御するクラス
---@field package MAX_WET_COUNT integer 濡れカウンターの最大値
---@field package waterDrops {model: ModelPart, sortValue: integer}[] 水滴のモデルパーツを格納するテーブル
---@field package wetCount integer 水濡れの時間を測るカウンター
---@field package isDropMasterVisible boolean 水滴モデル全体が見える状態かどうか（個別にオフになっている可能性もある）
local Wet = {
	MAX_WET_COUNT = 2400;

	waterDrops = {};
	wetCount = 0;
	isDropMasterVisible = false;

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
			waterDrop.model:setOpacity(0.05)
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

	---初期化関数
	---@param self Wet
	init = function (self)
		self:insertWaterDropModels()
		self:initializeWaterDropModels()

		events.TICK:register(function ()
			if not client:isPaused() then
				if player:isInWater() then
					self.wetCount = self.MAX_WET_COUNT
					self.nextDropCount = 0;

					local isUnderwater = player:isUnderwater()
					if isUnderwater == self.isDropMasterVisible then
						self:setDropsVisibleAll(not isUnderwater)
					end
				else
					if self.wetCount == self.MAX_WET_COUNT then
					elseif self.wetCount == 0 and self.isDropMasterVisible then
						self.nextDropCount = 0;
						self:setDropsVisibleAll(false)
					end
					self.wetCount = math.max(self.wetCount - 1, 0)
				end
			end
		end)
	end;
}

return Wet
