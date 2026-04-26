---@class (exact) Portrait ポートレート（Tabキーで表示できるプレイヤーリストに表示される顔）のモデルを制御するクラス
local Portrait = {

    ---初期化関数
    init = function ()
		---@diagnostic disable-next-line: discard-returns
		models:newPart("script_portrait")
    end;

	---頭ブロックのモデルを作成する。
	---@param self Portrait
	generatePortraitModel = function (self)
		self.deletePortraitModel()
		ModelUtils:copyHeadModel(models.script_portrait, "Portrait")
		models.script_portrait.Portrait:setParentType("Portrait")
		models.script_portrait.Portrait.Halo:remove()

		for _, modelPart in ipairs(BlueArchiveCharacter.portrait.includeModels) do
			local model = ModelUtils:copyModel(modelPart)
			if model ~= nil then
				models.script_portrait.Portrait:addChild(model)
			end
		end
	end;

	---頭ブロックを削除する。
	deletePortraitModel = function ()
		if models.script_portrait.Portrait ~= nil then
			models.script_portrait.Portrait:remove()
		end
	end;
}

return Portrait
