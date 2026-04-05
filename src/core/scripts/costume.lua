---@class (exact) Costume キャラクターのコスチュームを管理するクラス
local Costume = {
	---初期化関数
    ---@param self Costume
    init = function (self)
		local isAltCostumeProcessed = false
		if host:isHost() then
			if Config:loadConfig("PRIVATE", "costume.is_alt_costume", false) then
				self.setAltCostume(true)
				Config.syncConfigs["isAltCostume"] = true;
				isAltCostumeProcessed = true
			end
		end
		if not isAltCostumeProcessed then
			HeadBlock:generateHeadBlockModel()
			Portrait:generatePortraitModel()
		end

		EventManager.events["ON_CONFIG_SYNC"]:register(function (configData)
			if configData["isAltCostume"] then
				self.setAltCostume(true)
			end
		end)
    end;

	---バリエーション衣装(通常衣装と少し異なる衣装、以前の「別衣装」ではない)を設定する。
	---@param isAlt boolean `false`: 通常衣装, `true`: バリエーション衣装
	setAltCostume = function (isAlt)
		if BlueArchiveCharacter.costume.isAltCostumeEnabled and BlueArchiveCharacter.costume.callbacks ~= nil and BlueArchiveCharacter.costume.callbacks.onAltChange ~= nil then
			BlueArchiveCharacter.costume.callbacks.onAltChange(BlueArchiveCharacter, isAlt)
			HeadBlock:generateHeadBlockModel()
			Portrait:generateHeadModel()
		end
	end;
}

---バリエーション衣装を設定する。
---@param isAlt boolean `false`: 通常衣装, `true`: バリエーション衣装
function pings.costume_setAltCostume(isAlt)
	Costume.setAltCostume(isAlt)
end

return Costume
