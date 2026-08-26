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
		self:generateAvatarAlias()
	end;

	---アバターのルートモデルパーツからエイリアステーブルを生成する。
	---@param self ModelAlias
	generateAvatarAlias = function (self)
		self.alias.avatar = {}

		self.alias.avatar.root = models.models.main.Avatar
		self.alias.avatar.head = self.alias.avatar.root.Head
		self.alias.avatar.faceParts = self.alias.avatar.head.FaceParts
		self.alias.avatar.rightEye = self.alias.avatar.faceParts.Eyes.RightEye
		self.alias.avatar.rightSpyglassPivot = self.alias.avatar.faceParts.Eyes.RightSpyglassPivot
		self.alias.avatar.leftEye = self.alias.avatar.faceParts.Eyes.LeftEye
		self.alias.avatar.leftSpyglassPivot = self.alias.avatar.faceParts.Eyes.LeftSpyglassPivot
		self.alias.avatar.mouth = self.alias.avatar.faceParts.Mouth
		self.alias.avatar.halo = self.alias.avatar.head.Halo
		self.alias.avatar.helmetItemPivot = self.alias.avatar.head.HelmetItemPivot
		self.alias.avatar.upperBody = self.alias.avatar.root.UpperBody
		self.alias.avatar.body = self.alias.avatar.upperBody.Body
		self.alias.avatar.arms = self.alias.avatar.upperBody.Arms
		self.alias.avatar.rightArm = self.alias.avatar.arms.RightArm
		self.alias.avatar.rightArmBottom = self.alias.avatar.rightArm.RightArmBottom
		self.alias.avatar.rightItemPivot = self.alias.avatar.rightArmBottom.RightItemPivot
		self.alias.avatar.leftArm = self.alias.avatar.arms.LeftArm
		self.alias.avatar.leftArmBottom = self.alias.avatar.leftArm.LeftArmBottom
		self.alias.avatar.leftItemPivot = self.alias.avatar.leftArmBottom.LeftItemPivot
		self.alias.avatar.rightElytraPivot = self.alias.avatar.upperBody.RightElytraPivot
		self.alias.avatar.leftElytraPivot = self.alias.avatar.upperBody.LeftElytraPivot
		self.alias.avatar.gun = self.alias.avatar.body.Gun
		if self.alias.avatar.gun ~= nil then
			self.alias.avatar.muzzleAnchor = self.alias.avatar.gun.MuzzleAnchor
		end
		self.alias.avatar.lowerBody = self.alias.avatar.root.LowerBody
		self.alias.avatar.legs = self.alias.avatar.lowerBody.Legs
		self.alias.avatar.rightLeg = self.alias.avatar.legs.RightLeg
		self.alias.avatar.rightLegBottom = self.alias.avatar.rightLeg.RightLegBottom
		self.alias.avatar.leftLeg = self.alias.avatar.legs.LeftLeg
		self.alias.avatar.leftLegBottom = self.alias.avatar.leftLeg.LeftLegBottom
		self.alias.avatar.nameplate = self.alias.avatar.root.NameplateAnchor
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
}

return ModelAlias
