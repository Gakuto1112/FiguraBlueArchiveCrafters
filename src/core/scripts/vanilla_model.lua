---@class (exact) VanillaModel バニラのプレイヤーモデルを管理するクラス
VanillaModel = {}

---初期化関数
function VanillaModel.init()
	for _, vanillaModel in ipairs({vanilla_model.PLAYER, vanilla_model.ARMOR, vanilla_model.CAPE}) do
		vanillaModel:setVisible(false)
	end
end

return VanillaModel
