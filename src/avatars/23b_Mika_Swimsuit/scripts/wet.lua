---@class (exact) Wet 水濡れをシミュレートし、髪の水滴などを制御するクラス
---@field package waterDrops {model: ModelPart, sortValue: integer}[] 水滴のモデルパーツを格納するテーブル
local Wet = {
	waterDrops = {};

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
		end
	end;

	---初期化関数
	---@param self Wet
	init = function (self)
		self:insertWaterDropModels()
		self:initializeWaterDropModels()
	end;
}

return Wet
