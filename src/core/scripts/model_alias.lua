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
---@field lowerBody ModelPart 下半身
---@field legs ModelPart 両脚のグループ
---@field rightLeg ModelPart 右脚の上部
---@field rightLegBottom ModelPart 右脚の下部
---@field leftLeg ModelPart 左脚の上部
---@field leftLegBottom ModelPart 左脚の下部

---@class (exact) ModelAlias モデルパーツのエイリアスを管理するクラス
---@field alias { avatar: ModelAliasTable, dummy_avatar: ModelAliasTable } モデルのエイリアスを格納するテーブル
local ModelAlias = {
	alias = {};

	---初期化関数
	---@param self ModelAlias
	init = function (self)
		self.alias.avatar = self.getAliasTable(models.models.main.Avatar)
	end;

	---アバターのルートモデルパーツからエイリアステーブルを生成し返す
	---@param rootModel ModelPart アバターのルートモデルパーツ（例: models.models.main.Avatar）
	---@return ModelAliasTable aliasTable 生成されたエイリアステーブル
	getAliasTable = function (rootModel)
		---@type ModelAliasTable
		---@diagnostic disable-next-line: missing-fields
		local aliasTable = {}

		aliasTable.root = rootModel
		aliasTable.head = aliasTable.root.Head
		aliasTable.faceParts = aliasTable.head.FaceParts
		aliasTable.rightEye = aliasTable.faceParts.Eyes.RightEye
		aliasTable.rightSpyglassPivot = aliasTable.faceParts.Eyes.RightSpyglassPivot
		aliasTable.leftEye = aliasTable.faceParts.Eyes.LeftEye
		aliasTable.leftSpyglassPivot = aliasTable.faceParts.Eyes.LeftSpyglassPivot
		aliasTable.mouth = aliasTable.faceParts.Mouth
		aliasTable.halo = aliasTable.head.Halo
		aliasTable.helmetItemPivot = aliasTable.head.HelmetItemPivot
		aliasTable.upperBody = aliasTable.root.UpperBody
		aliasTable.body = aliasTable.upperBody.Body
		aliasTable.arms = aliasTable.upperBody.Arms
		aliasTable.rightArm = aliasTable.arms.RightArm
		aliasTable.rightArmBottom = aliasTable.rightArm.RightArmBottom
		aliasTable.rightItemPivot = aliasTable.rightArmBottom.RightItemPivot
		aliasTable.leftArm = aliasTable.arms.LeftArm
		aliasTable.leftArmBottom = aliasTable.leftArm.LeftArmBottom
		aliasTable.leftItemPivot = aliasTable.leftArmBottom.LeftItemPivot
		aliasTable.rightElytraPivot = aliasTable.upperBody.RightElytraPivot
		aliasTable.leftElytraPivot = aliasTable.upperBody.LeftElytraPivot
		aliasTable.lowerBody = aliasTable.root.LowerBody
		aliasTable.legs = aliasTable.lowerBody.Legs
		aliasTable.rightLeg = aliasTable.legs.RightLeg
		aliasTable.rightLegBottom = aliasTable.rightLeg.RightLegBottom
		aliasTable.leftLeg = aliasTable.legs.LeftLeg
		aliasTable.leftLegBottom = aliasTable.leftLeg.LeftLegBottom

		return aliasTable
	end;
}

return ModelAlias
