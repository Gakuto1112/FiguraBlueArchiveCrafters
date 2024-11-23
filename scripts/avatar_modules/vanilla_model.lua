---@class (exact) VanillaModel : AvatarModule バニラーのモデルの管理クラス

VanillaModel = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return VanillaModel
    new = function (parent)
        ---@type VanillaModel
        local instance = Avatar.instantiate(VanillaModel, AvatarModule, parent)

        return instance
    end;

    ---初期化関数
    ---@param self AvatarModule
    init = function (self)
		AvatarModule.init(self)
		for _, vanillaModel in ipairs({vanilla_model.PLAYER, vanilla_model.CHESTPLATE_RIGHT_ARM, vanilla_model.CHESTPLATE_LEFT_ARM, vanilla_model.LEGGINGS_RIGHT_LEG, vanilla_model.LEGGINGS_LEFT_LEG, vanilla_model.BOOTS}) do
			vanillaModel:setVisible(false)
		end
    end;
}