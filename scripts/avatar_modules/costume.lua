---@class (exact) Costume : AvatarModule キャラクターのコスチュームを管理し、円滑に切り替えられるようにするクラス
---@field public costumeList string[] 利用可能なコスチューム一覧。BlueArchiveCharacterクラスから動的に生成される。
---@field public currentCostume integer 現在のコスチューム
---@field public getCostumeLocalName fun(self: Costume, costumeId: integer) 設定言語を考慮した、衣装の名前を返す
---@field public setCostumeTextureOffset fun(offset: integer) メインモデルのテクスチャのオフセット値を設定する
---@field public setCostume fun(self: Costume, costume: integer) コスチュームを設定する
---@field public resetCostume fun(self: Costume) コスチュームをリセットしデフォルトのコスチュームにする

Costume = {
	---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Costume
    new = function (parent)
        ---@type Costume
        local instance = Avatar.instantiate(Costume, AvatarModule, parent)

		instance.costumeList = {}
		instance.currentCostume = instance.parent.config:loadConfig("costume", 1)

        return instance
    end;

	---初期化関数
    ---@param self Costume
    init = function (self)
		AvatarModule.init(self)

		for _, costume in ipairs(self.parent.characterData.costume.costumes) do
			table.insert(self.costumeList, costume.name)
		end
		if self.currentCostume >= 2 then
			if self.costumeList[self.currentCostume] ~= nil then
				self:setCostume(self.currentCostume)
			else
				self.currentCostume = 1
				if host:isHost() then
					self.parent.config:saveConfig("costume", 1)
				end
			end
		end
		self.parent.headBlock:generateHeadModel()
		self.parent.portrait:generateHeadModel()
    end;

	---設定言語を考慮した、衣装の名前を返す。
	---@param self Costume
	---@param costumeId integer ローカル名を取得する衣装のID
	---@return string localCostumeName 衣装のローカル名
	getCostumeLocalName = function(self, costumeId)
		return self.parent.locale:getLocale("costume."..self.costumeList[costumeId])
	end;

	---メインモデルのテクスチャのオフセット値を設定する。
	---@param offset integer オフセット値
	setCostumeTextureOffset = function (offset)
		for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Body, models.models.main.Avatar.UpperBody.Body.BodyLayer, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArm, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmLayer, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightArmBottom, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightArmBottomLayer, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArm, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmLayer, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftArmBottom, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftArmBottomLayer, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLeg, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegLayer, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.RightLegBottom, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.RightLegBottomLayer, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLeg, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegLayer, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.LeftLegBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.LeftLegBottomLayer}) do
			modelPart:setUVPixels(0, offset * 48)
		end
	end;

	---コスチュームを設定する。
	---@param self Costume
	---@param costume integer 設定するコスチューム
	setCostume = function(self, costume)
		self:resetCostume()
		if self.parent.characterData.costume.callbacks ~= nil and self.parent.characterData.costume.callbacks.onChange ~= nil then
			self.parent.characterData.costume.callbacks.onChange(self.parent.characterData.costume.costumes[costume].name:upper())
		end
		self.parent.headBlock:generateHeadModel()
		self.parent.portrait:generateHeadModel()
		if self.parent.armor.isArmorVisible.chestplate then
			self.parent.armor:setChestPlate(self.parent.armor.armorSlotItems[2])
		end
		if self.parent.armor.isArmorVisible.leggings then
			self.parent.armor:setLeggings(self.parent.armor.armorSlotItems[3])
		end
		if self.parent.armor.isArmorVisible.boots then
			self.parent.armor:setBoots(self.parent.armor.armorSlotItems[4])
		end
		self.currentCostume = costume
	end;

	---コスチュームをリセットし、デフォルトのコスチュームにする。
	---@param self Costume
	resetCostume = function (self)
		if self.parent.exSkill.transitionCount > 0 then
			self.parent.exSkill:forceStop()
		end
		self.setCostumeTextureOffset(0)
		if self.parent.characterData.costume.callbacks ~= nil and self.parent.characterData.costume.callbacks.onReset ~= nil then
			self.parent.characterData.costume.callbacks.onReset()
		end
		self.parent.headBlock:generateHeadModel()
		self.parent.portrait:generateHeadModel()
		if self.parent.armor.isArmorVisible.chestplate then
			self.parent.armor:setChestPlate(self.parent.armor.armorSlotItems[2])
		end
		if self.parent.armor.isArmorVisible.leggings then
			self.parent.armor:setLeggings(self.parent.armor.armorSlotItems[3])
		end
		if self.parent.armor.isArmorVisible.boots then
			self.parent.armor:setBoots(self.parent.armor.armorSlotItems[4])
		end
		self.currentCostume = 1
	end;
}