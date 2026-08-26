---@class (exact) ModelAliasTable モデルパーツのエイリアスを格納するテーブル
---@field root ModelPart アバターのルートパーツ
---@field head ModelPart 頭
---@field faceParts ModelPart 目や口のグループ
---@field rightEye ModelPart 右目
---@field rightSpyglassPivot ModelPart 右目で望遠鏡を覗くときの望遠鏡の接点
---@field leftEye ModelPart 左目
---@field leftSpyglassPivot ModelPart 左目で望遠鏡を覗くときの望遠鏡の接点
---@field mouth ModelPart 口
---@field halo ModelPart ヘイロー（頭の輪っか）
---@field helmetItemPivot ModelPart 頭にかぶったアイテム（ヘルメットではない）の接点
---@field upperBody ModelPart 上半身
---@field body ModelPart 体
---@field arms ModelPart 両腕のグループ
---@field rightArm ModelPart 右腕の上部
---@field rightArmBottom ModelPart 右腕の下部
---@field rightItemPivot ModelPart 右手に持ったアイテムの接点
---@field leftArm ModelPart 左腕の上部
---@field leftArmBottom ModelPart 左腕の下部
---@field leftItemPivot ModelPart 左手に持ったアイテムの接点
---@field rightElytraPivot ModelPart エリトラの右翼の接点
---@field leftElytraPivot ModelPart エリトラの左翼の接点
---@field gun ModelPart 固有武器
---@field muzzleAnchor ModelPart 固有武器のマズル部分
---@field lowerBody ModelPart 下半身
---@field legs ModelPart 両脚のグループ
---@field rightLeg ModelPart 右脚の上部
---@field rightLegBottom ModelPart 右脚の下部
---@field leftLeg ModelPart 左脚の上部
---@field leftLegBottom ModelPart 左脚の下部
---@field nameplate ModelPart ネームプレートのアンカー

---@class (exact) ModelAlias モデルパーツのエイリアスを管理するクラス
---@field package alias { avatar: ModelAliasTable, dummy_avatar: ModelAliasTable } モデルのエイリアスを格納するテーブル
local ModelAlias = {
	alias = {};

	---初期化関数
	---@param self ModelAlias
	init = function (self)
		self:generateAvatarAlias()
	end;

	---アバターのルートモデルパーツからエイリアステーブルを生成する。
	---@param self ModelAlias
	generateAvatarAlias = function (self)
		---@diagnostic disable-next-line: missing-fields
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
}

return ModelAlias
