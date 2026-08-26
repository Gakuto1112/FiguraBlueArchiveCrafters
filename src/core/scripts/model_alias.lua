---@alias ModelAlias.AliasType
---| "root" # アバターのルートパーツ
---| "head" # 頭
---| "faceParts" # 目や口のグループ
---| "rightEye" # 右目
---| "rightSpyglassPivot" # 右目で望遠鏡を覗くときの望遠鏡の接点
---| "leftEye" # 左目
---| "leftSpyglassPivot" # 左目で望遠鏡を覗くときの望遠鏡の接点
---| "mouth" # 口
---| "halo" # ヘイロー（頭の輪っか）
---| "helmetItemPivot" # 頭にかぶったアイテム（ヘルメットではない）の接点
---| "upperBody" # 上半身
---| "body" # 体
---| "arms" # 両腕のグループ
---| "rightArm" # 右腕の上部
---| "rightArmBottom" # 右腕の下部
---| "rightItemPivot" # 右手に持ったアイテムの接点
---| "leftArm" # 左腕の上部
---| "leftArmBottom" # 左腕の下部
---| "leftItemPivot" # 左手に持ったアイテムの接点
---| "rightElytraPivot" # エリトラの右翼の接点
---| "leftElytraPivot" # エリトラの左翼の接点
---| "gun" # 固有武器
---| "muzzleAnchor" # 固有武器のマズル部分
---| "lowerBody" # 下半身
---| "legs" # 両脚のグループ
---| "rightLeg" # 右脚の上部
---| "rightLegBottom" # 右脚の下部
---| "leftLeg" # 左脚の上部
---| "leftLegBottom" # 左脚の下部
---| "nameplate" # ネームプレートのアンカー

---@class (exact) ModelAlias モデルパーツのエイリアスを管理するクラス
---@field alias { avatar: table<ModelAlias.AliasType, ModelPart>, dummy_avatar: table<ModelAlias.AliasType, ModelPart> } モデルのエイリアスを格納するテーブル
---@field package defaultAvatarAlias table<ModelAlias.AliasType, ModelPart> アバターのデフォルトのエイリアスを格納するテーブル
---@field package aliasPath table<ModelAlias.AliasType, string[]> 変更されたエイリアスのパスを格納するテーブル
local ModelAlias = {
	alias = {};
	defaultAvatarAlias = {};
	aliasPath = {};

	---初期化関数
	---@param self ModelAlias
	init = function (self)
		self.alias.avatar = self:getAliasTable(models.models.main.Avatar)
	end;

	---アバターのルートモデルパーツからエイリアステーブルを生成し返す。
	---@param self ModelAlias
	---@param rootModel ModelPart アバターのルートモデルパーツ（例: models.models.main.Avatar）
	---@return table<ModelAlias.AliasType, ModelPart> aliasTable 生成されたエイリアステーブル
	getAliasTable = function (self, rootModel)
		---@type table<ModelAlias.AliasType, ModelPart>
		local aliasTable = {}

		aliasTable.root = rootModel
		aliasTable.head = self:pathToModelPart("head", aliasTable.root) or aliasTable.root.Head
		aliasTable.faceParts = self:pathToModelPart("faceParts", aliasTable.root) or aliasTable.head.FaceParts
		aliasTable.rightEye = self:pathToModelPart("rightEye", aliasTable.root) or aliasTable.faceParts.Eyes.RightEye
		aliasTable.rightSpyglassPivot = self:pathToModelPart("rightSpyglassPivot", aliasTable.root) or aliasTable.faceParts.Eyes.RightSpyglassPivot
		aliasTable.leftEye = self:pathToModelPart("leftEye", aliasTable.root) or aliasTable.faceParts.Eyes.LeftEye
		aliasTable.leftSpyglassPivot = self:pathToModelPart("leftSpyglassPivot", aliasTable.root) or aliasTable.faceParts.Eyes.LeftSpyglassPivot
		aliasTable.mouth = self:pathToModelPart("mouth", aliasTable.root) or aliasTable.faceParts.Mouth
		aliasTable.halo = self:pathToModelPart("halo", aliasTable.root) or aliasTable.head.Halo
		aliasTable.helmetItemPivot = self:pathToModelPart("helmetItemPivot", aliasTable.root) or aliasTable.head.HelmetItemPivot
		aliasTable.upperBody = self:pathToModelPart("upperBody", aliasTable.root) or aliasTable.root.UpperBody
		aliasTable.body = self:pathToModelPart("body", aliasTable.root) or aliasTable.upperBody.Body
		aliasTable.arms = self:pathToModelPart("arms", aliasTable.root) or aliasTable.upperBody.Arms
		aliasTable.rightArm = self:pathToModelPart("rightArm", aliasTable.root) or aliasTable.arms.RightArm
		aliasTable.rightArmBottom = self:pathToModelPart("rightArmBottom", aliasTable.root) or aliasTable.rightArm.RightArmBottom
		aliasTable.rightItemPivot = self:pathToModelPart("rightItemPivot", aliasTable.root) or aliasTable.rightArmBottom.RightItemPivot
		aliasTable.leftArm = self:pathToModelPart("leftArm", aliasTable.root) or aliasTable.arms.LeftArm
		aliasTable.leftArmBottom = self:pathToModelPart("leftArmBottom", aliasTable.root) or aliasTable.leftArm.LeftArmBottom
		aliasTable.leftItemPivot = self:pathToModelPart("leftItemPivot", aliasTable.root) or aliasTable.leftArmBottom.LeftItemPivot
		aliasTable.rightElytraPivot = self:pathToModelPart("rightElytraPivot", aliasTable.root) or aliasTable.upperBody.RightElytraPivot
		aliasTable.leftElytraPivot = self:pathToModelPart("leftElytraPivot", aliasTable.root) or aliasTable.upperBody.LeftElytraPivot
		aliasTable.gun = self:pathToModelPart("gun", aliasTable.root) or aliasTable.body.Gun
		if aliasTable.gun ~= nil then
			aliasTable.muzzleAnchor = self:pathToModelPart("muzzleAnchor", aliasTable.root) or aliasTable.gun.MuzzleAnchor
		end
		aliasTable.lowerBody = self:pathToModelPart("lowerBody", aliasTable.root) or aliasTable.root.LowerBody
		aliasTable.legs = self:pathToModelPart("legs", aliasTable.root) or aliasTable.lowerBody.Legs
		aliasTable.rightLeg = self:pathToModelPart("rightLeg", aliasTable.root) or aliasTable.legs.RightLeg
		aliasTable.rightLegBottom = self:pathToModelPart("rightLegBottom", aliasTable.root) or aliasTable.rightLeg.RightLegBottom
		aliasTable.leftLeg = self:pathToModelPart("leftLeg", aliasTable.root) or aliasTable.legs.LeftLeg
		aliasTable.leftLegBottom = self:pathToModelPart("leftLegBottom", aliasTable.root) or aliasTable.leftLeg.LeftLegBottom
		aliasTable.nameplate = self:pathToModelPart("nameplate", aliasTable.root) or aliasTable.root.NameplateAnchor

		return aliasTable
	end;

	---アバターのエイリアステーブルに登録するモデルパーツを変更する。
	---@param self ModelAlias
	---@param aliasType ModelAlias.AliasType 変更対象エイリアスの種類
	---@param modelPart ModelPart 変更先のモデルパーツ。必ず先祖にアバタールートが含まれる必要がある。
	modifyAvatarAlias = function (self, aliasType, modelPart)
		self.defaultAvatarAlias[aliasType] = self.alias.avatar[aliasType]
		self.alias.avatar[aliasType] = modelPart

		self.aliasPath[aliasType] = {}
		local currentModel = modelPart
		while true do
			table.insert(self.aliasPath[aliasType], 1, currentModel:getName())
			currentModel = currentModel:getParent()
			if currentModel == self.alias.avatar.root then
				break
			elseif currentModel == nil then
				error("The model part must be a descendant of the avatar root.")
			end
		end
	end;

	---パステーブルからモデルパーツを取得する。
	---@param self ModelAlias
	---@param aliasType ModelAlias.AliasType モデル取得対象エイリアスの種類
	---@return ModelPart|nil modelPart 取得したモデルパーツ。存在しない場合はnilを返す。
	pathToModelPart = function (self, aliasType, rootModel)
		if self.aliasPath[aliasType] == nil then
			return nil
		end

		local currentModel = rootModel
		for _, pathName in ipairs(self.aliasPath[aliasType]) do
			currentModel = currentModel[pathName]
			if currentModel == nil then
				return nil
			end
		end
		return currentModel
	end;
}

return ModelAlias
