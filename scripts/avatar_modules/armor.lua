---防具の部位
---@alias Armor.ArmorPart
---| "HELMET" # ヘルメット
---| "CHEST_PLATE" # チェストプレート
---| "LEGGINGS" # レギンス
---| "BOOTS" # ブーツ

---@class (exact) Armor : AvatarModule 防具の表示を制御するクラス
---@field public shouldShowArmor boolean 防具を表示するかどうか
---@field public armorSlotItems ItemStack[] 現ティックの防具スロットのアイテム
---@field package armorSlotItemsPrev ItemStack[] 前ティックの防具スロットのアイテム
---@field package hasGlintPrev boolean[] 前ティックに防具がエンチャントのキラキラを持っていたかどうか
---@field public isArmorVisible Armor.VisiblePartsSet 各防具の部位（ヘルメット、チェストプレート、レギンス、ブーツ）が可視状態かどうか
---@field package textureQueue Armor.TextureQueueData[] テクスチャ処理のキュー
---@field package getArmorColor fun(armorItem: ItemStack): number 防具の色を取得する
---@field package compareTrims fun(trim1?: Armor.TrimData, trim2?: Armor.TrimData): boolean 防具装飾が同じものか比較する
---@field package addTextureQueue fun(self: Armor, texture: Texture, paletteName: string) テクスチャの処理のキューにデータを挿入する
---@field package getTrimTexture fun(self: Armor, trimData?: Armor.TrimData, armorId: string): Texture|nil バニラパーツの防具装飾のテクスチャを取得する。テクスチャの処理は次のチック以降行われる。
---@field public setHelmet fun(self: Armor, helmetItem: ItemStack) ヘルメットを更新する
---@field public setChestplate fun(self: Armor, chestplateItem: ItemStack) チェストプレートを更新する
---@field public setLeggings fun(self: Armor, leggingsItem: ItemStack) レギンスを更新する
---@field public setBoots fun(self: Armor, bootsItem: ItemStack) ブーツを更新する

---@class (exact) Armor.VisiblePartsSet 各防具の部位の可視状態のセット
---@field public helmet boolean ヘルメット
---@field public chestplate boolean チェストプレート
---@field public leggings boolean レギンス
---@field public boots boolean ブーツ

---@class (exact) Armor.TextureQueueData テクスチャキューに入るデータの構造体
---@field public texture Texture 処理対象のテクスチャ
---@field public palette Texture 処理に使用するパレットのテクスチャ
---@field public iterationCount integer 現在の繰り返しカウンター

---@class (exact) Armor.TrimData 防具装飾のデータセット
---@field public pattern string 防具装飾の模様
---@field public material string 防具装飾の素材

Armor = {
	---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Armor
    new = function (parent)
        ---@type Armor
        local instance = Avatar.instantiate(Armor, AvatarModule, parent)
		instance.shouldShowArmor = instance.parent.config:loadConfig("PRIVATE", "showArmor", false)
		instance.armorSlotItems = {world.newItem(instance.parent.compatibilityUtils:checkItem("minecraft:air")), world.newItem(instance.parent.compatibilityUtils:checkItem("minecraft:air")), world.newItem(instance.parent.compatibilityUtils:checkItem("minecraft:air")), world.newItem(instance.parent.compatibilityUtils:checkItem("minecraft:air"))}
		instance.armorSlotItemsPrev = {world.newItem(instance.parent.compatibilityUtils:checkItem("minecraft:air")), world.newItem(instance.parent.compatibilityUtils:checkItem("minecraft:air")), world.newItem(instance.parent.compatibilityUtils:checkItem("minecraft:air")), world.newItem(instance.parent.compatibilityUtils:checkItem("minecraft:air"))}
		instance.hasGlintPrev = {false, false, false, false}
		instance.isArmorVisible = {
			helmet = false;
			chestplate = false;
			leggings = false;
			boots = false;
		}
		instance.textureQueue = {}

        return instance
    end;

	---初期化関数
    ---@param self Armor
    init = function (self)
        AvatarModule.init(self)

		events.TICK:register(function ()
			self.armorSlotItems = self.shouldShowArmor and {player:getItem(6), player:getItem(5), player:getItem(4), player:getItem(3)} or {world.newItem(self.parent.compatibilityUtils:checkItem("minecraft:air")), world.newItem(self.parent.compatibilityUtils:checkItem("minecraft:air")), world.newItem(self.parent.compatibilityUtils:checkItem("minecraft:air")), world.newItem(self.parent.compatibilityUtils:checkItem("minecraft:air"))}
			if self.armorSlotItems[1].id ~= self.armorSlotItemsPrev[1].id then
				self:setHelmet(self.armorSlotItems[1])
			end
			if self.armorSlotItems[2].id ~= self.armorSlotItemsPrev[2].id then
				self:setChestplate(self.armorSlotItems[2])
			end
			if self.armorSlotItems[3].id ~= self.armorSlotItemsPrev[3].id then
				self:setLeggings(self.armorSlotItems[3])
			end
			if self.armorSlotItems[4].id ~= self.armorSlotItemsPrev[4].id then
				self:setBoots(self.armorSlotItems[4])
			end

			for index, armorSlotItem in ipairs(self.armorSlotItems) do
				local glint = armorSlotItem:hasGlint()
				if glint ~= self.hasGlintPrev[index] then
					--エンチャント変更
					local renderType = glint and "GLINT"..(client:getVersion() == "1.21.4" and "2" or "") or "NONE"
					if index == 1 then
						models.models.main.Avatar.Head.ArmorH.Helmet:setSecondaryRenderType(renderType)
					elseif index == 2 then
						for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom}) do
							armorPart:setSecondaryRenderType(renderType)
						end
					elseif index == 3 then
						for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom}) do
							armorPart:setSecondaryRenderType(renderType)
						end
					elseif index == 4 then
						for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom}) do
							armorPart:setSecondaryRenderType(renderType)
						end
					end
					self.hasGlintPrev[index] = glint
				end
				local armorColor = self.getArmorColor(armorSlotItem)
				if armorColor ~= self.getArmorColor(self.armorSlotItemsPrev[index]) then
					--色変更
					local colorVector = vectors.intToRGB(armorColor)
					if index == 1 then
						models.models.main.Avatar.Head.ArmorH.Helmet.Helmet:setColor(colorVector)
					elseif index == 2 then
						for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.Chestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottom, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplate, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottom}) do
							armorPart:setColor(colorVector)
						end
					elseif index == 3 then
						for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.Leggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggings, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottom}) do
							armorPart:setColor(colorVector)
						end
					elseif index == 4 then
						for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBoots, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBoots, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottom}) do
							armorPart:setColor(colorVector)
						end
					end
				end
				local trim = self.armorSlotItems[index].tag.Trim
				if not self.compareTrims(trim, self.armorSlotItemsPrev[index].tag.Trim) then
					--トリム変更
					if index == 1 then
						local trimTexture = self:getTrimTexture(trim, self.armorSlotItems[1].id)
						if trimTexture then
							models.models.main.Avatar.Head.ArmorH.Helmet.HelmetTrim:setVisible(true)
							models.models.main.Avatar.Head.ArmorH.Helmet.HelmetTrim:setPrimaryTexture("CUSTOM", trimTexture)
						else
							models.models.main.Avatar.Head.ArmorH.Helmet.HelmetTrim:setVisible(false)
						end
					elseif index == 2 then
						local trimTexture = self:getTrimTexture(trim, self.armorSlotItems[2].id)
						if trimTexture then
							for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.ChestplateTrim, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplateTrim, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomTrim, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplateTrim, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomTrim}) do
								armorPart:setVisible(true)
								armorPart:setPrimaryTexture("CUSTOM", trimTexture)
							end
						else
							for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.ChestplateTrim, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplateTrim, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomTrim, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplateTrim, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomTrim}) do
								armorPart:setVisible(false)
							end
						end
					elseif index == 3 then
						local trimTexture = self:getTrimTexture(trim, self.armorSlotItems[3].id)
						if trimTexture then
							for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.LeggingsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggingsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggingsTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomTrim}) do
								armorPart:setVisible(true)
								armorPart:setPrimaryTexture("CUSTOM", trimTexture)
							end
						else
							for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.LeggingsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggingsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggingsTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomTrim}) do
								armorPart:setVisible(false)
							end
						end
					elseif index == 4 then
						local trimTexture = self:getTrimTexture(trim, self.armorSlotItems[4].id)
						if trimTexture then
							for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBootsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBootsTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomTrim}) do
								armorPart:setVisible(true)
								armorPart:setPrimaryTexture("CUSTOM", trimTexture)
							end
						else
							for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBootsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBootsTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomTrim}) do
								armorPart:setVisible(false)
							end
						end
					end
				end
			end
			--テクスチャの作成処理
			if #self.textureQueue > 0 then
				local instructionsAvailable = avatar:getMaxTickCount() - 3000 --このTICKで使用出来る残りの命令数
				while #self.textureQueue > 0 and instructionsAvailable > 0 do
					local dimension = self.textureQueue[1].texture:getDimensions()
					for y = math.floor(self.textureQueue[1].iterationCount / dimension.x), dimension.y - 1 do
						for x = self.textureQueue[1].iterationCount % dimension.x, dimension.x - 1 do
							local pixel = self.textureQueue[1].texture:getPixel(x, y)
							if pixel.w == 1 then
								self.textureQueue[1].texture:setPixel(x, y, self.textureQueue[1].palette:getPixel(7 - math.floor(pixel.x * 8), 0))
							end
							self.textureQueue[1].iterationCount = self.textureQueue[1].iterationCount + 1
							instructionsAvailable = instructionsAvailable - 45
							if instructionsAvailable <= 0 then
								break
							end
						end
						if instructionsAvailable <= 0 then
							break
						end
					end
					self.textureQueue[1].texture:update()
					if self.textureQueue[1].iterationCount == dimension.x * dimension.y then
						table.remove(self.textureQueue, 1)
					end
				end
			end
			self.armorSlotItemsPrev = self.armorSlotItems
		end)

		vanilla_model.ARMOR:setVisible(false)
		local gameVersion = client:getVersion()
		for _, overlayPart in ipairs({models.models.main.Avatar.Head.ArmorH.Helmet.HelmetOverlay, models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.ChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomOverlay, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBootsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBootsOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomOverlay}) do
			overlayPart:setPrimaryTexture("RESOURCE", gameVersion >= "1.21.2" and "minecraft:textures/entity/equipment/humanoid/leather_overlay.png" or "minecraft:textures/models/armor/leather_layer_1_overlay.png")
		end
		for _, overlayPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.LeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomOverlay}) do
			overlayPart:setPrimaryTexture("RESOURCE", gameVersion >= "1.21.2" and "minecraft:textures/entity/equipment/humanoid_leggings/leather_overlay.png" or "minecraft:textures/models/armor/leather_layer_2_overlay.png")
		end
    end;

	---防具の色を取得する。
	---@param armorItem ItemStack 調べるアイテムのオブジェクト
	---@return number color 防具モデルに設定すべき色
	getArmorColor = function (armorItem)
		if armorItem.id:find("^minecraft:leather_") then
			if armorItem.tag then
				if armorItem.tag.display then
					return armorItem.tag.display.color and armorItem.tag.display.color or 10511680
				else
					return 10511680
				end
			else
				return 10511680
			end
		else
			return 16777215
		end
	end;

	---防具装飾が同じものか比較する。
	---@param trim1? Armor.TrimData 比較する防具装飾のテーブル1
	---@param trim2? Armor.TrimData 比較する防具装飾のテーブル2
	---@return boolean isTrimSame 2つの防具装飾が同じものかどうか
	compareTrims = function (trim1, trim2)
		if type(trim1) == type(trim2) then
			if trim1 then
				if trim1.pattern ~= trim2.pattern then
					return false
				elseif trim1.material ~= trim2.material then
					return false
				else
					return true
				end
			else
				return true
			end
		else
			return false
		end
	end;

	---テクスチャの処理のキューにデータを挿入する。
	---@param self Armor
	---@param texture Texture 処理を行うテクスチャ
	---@param paletteName string 使用するパレットの名前
	addTextureQueue = function (self, texture, paletteName)
		if textures["trim_palette_"..paletteName] == nil then
			textures:fromVanilla("trim_palette_"..paletteName, "minecraft:textures/trims/color_palettes/"..paletteName..".png")
		end
		table.insert(self.textureQueue, 1, {
			texture = texture,
			palette = textures["trim_palette_"..paletteName],
			iterationCount = 0
		})
	end;

	---バニラパーツの防具装飾のテクスチャを取得する。テクスチャの処理は次のチック以降行われる。
	---@param self Armor
	---@param trimData? Armor.TrimData 防具装飾のデータ
	---@param armorId string 防具アイテムのID。
	---@return Texture|nil trimTexture 色を付けた防具装飾のテクスチャ。防具や防具装飾が非バニラの場合はnilを返す。
	getTrimTexture = function (self, trimData, armorId)
		if trimData and trimData.pattern:find("^minecraft:.+$") and trimData.material:find("^minecraft:.+$") and armorId:find("^minecraft:.+_.+$") then
			local normalizedPatternName = trimData.pattern:match("^minecraft:(%a+)$")
			local normalizedArmorMaterialName = armorId:match("^minecraft:(%a+)_.+$")
			normalizedArmorMaterialName = normalizedArmorMaterialName == "golden" and "gold" or normalizedArmorMaterialName
			local normalizedMaterialName = trimData.material:match("^minecraft:(%a+)$")
			normalizedMaterialName = normalizedMaterialName..(normalizedArmorMaterialName == normalizedMaterialName and "_darker" or "")
			local isLeggings = armorId:find("^minecraft:.+_leggings$")
			local textureName = "trim_"..normalizedPatternName.."_"..normalizedMaterialName..(isLeggings and "_leggings" or "")
			if textures[textureName] then
				return textures[textureName]
			else
				local texture = textures:fromVanilla(textureName, client:getVersion() >= "1.21.2" and "minecraft:textures/trims/entity/humanoid"..(armorId:find("^minecraft:.+_leggings$") ~= nil and "_leggings" or "").."/"..normalizedPatternName..".png" or "minecraft:textures/trims/models/armor/"..normalizedPatternName..(armorId:find("^minecraft:.+_leggings$") ~= nil and "_leggings" or "")..".png")
				self:addTextureQueue(texture, normalizedMaterialName)
				return texture
			end
		end
	end;

	---ヘルメットを更新する。
	---@param self Armor
	---@param helmetItem ItemStack ヘルメットのスロットに入っているアイテム
	setHelmet = function (self, helmetItem)
		local hatFound = helmetItem.id ~= "minecraft:air"
		local helmetFound = helmetItem.id:find("^minecraft:.+_helmet$") ~= nil
		vanilla_model.HELMET:setVisible(hatFound and not helmetFound)
		models.models.main.Avatar.Head.ArmorH:setVisible(helmetFound)
		if helmetFound then
			local material = helmetItem.id:match("^minecraft:(%a+)_helmet$")
			models.models.main.Avatar.Head.ArmorH.Helmet.Helmet:setPrimaryTexture("RESOURCE", client:getVersion() >= "1.21.2" and "minecraft:textures/entity/equipment/humanoid/"..(material == "golden" and "gold" or material)..".png" or "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_1.png")
		end
		models.models.main.Avatar.Head.ArmorH.Helmet.HelmetOverlay:setVisible(helmetItem.id == "minecraft:leather_helmet")
		self.isArmorVisible.helmet = helmetFound or hatFound
		if self.parent.characterData.costume.callbacks ~= nil and self.parent.characterData.costume.callbacks.onArmorChange ~= nil then
			self.parent.characterData.costume.callbacks.onArmorChange(self.parent.characterData, "HELMET", self.isArmorVisible.helmet)
		end
	end;

	---チェストプレートを更新する。
	---@param self Armor
	---@param chestplateItem ItemStack チェストプレートスロットに入っているアイテム
	setChestplate = function (self, chestplateItem)
		local chestplateFound = chestplateItem.id:find("^minecraft:.+_chestplate$") ~= nil
		for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate}) do
			armorPart:setVisible(chestplateFound)
		end
		if chestplateFound then
			events.RENDER:register(function (_, context)
				for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB}) do
					armorPart:setVisible(context ~= "FIRST_PERSON")
				end
			end, "armor_chestplate_render")
		else
			events.RENDER:remove("armor_chestplate_render")
			for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB}) do
				armorPart:setVisible(false)
			end
		end
		self.isArmorVisible.chestplate = chestplateFound
		if self.isArmorVisible.chestplate then
			local material = chestplateItem.id:match("^minecraft:(%a+)_chestplate$")
			for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.Chestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottom, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplate, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottom}) do
				armorPart:setPrimaryTexture("RESOURCE", client:getVersion() >= "1.21.2" and "minecraft:textures/entity/equipment/humanoid/"..(material == "golden" and "gold" or material)..".png" or "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_1.png")
			end
		end
		local overlayVisible = chestplateItem.id == "minecraft:leather_chestplate"
		for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.ChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomOverlay, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomOverlay}) do
			armorPart:setVisible(overlayVisible)
		end
		if self.parent.characterData.costume.callbacks ~= nil and self.parent.characterData.costume.callbacks.onArmorChange ~= nil then
			self.parent.characterData.costume.callbacks.onArmorChange(self.parent.characterData, "CHEST_PLATE", self.isArmorVisible.chestplate)
		end
	end;

	---レギンスを更新する。
	---@param self Armor
	---@param leggingsItem ItemStack レギンススロットに入っているアイテム
	setLeggings = function (self, leggingsItem)
		local leggingsFound = leggingsItem.id:find("^minecraft:.+_leggings$") ~= nil
		for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom}) do
			armorPart:setVisible(leggingsFound)
		end
		self.isArmorVisible.leggings = leggingsFound
		if self.isArmorVisible.leggings then
			local material = leggingsItem.id:match("^minecraft:(%a+)_leggings$")
			for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.Leggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggings, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottom}) do
				armorPart:setPrimaryTexture("RESOURCE", client:getVersion() >= "1.21.2" and "minecraft:textures/entity/equipment/humanoid_leggings/"..(material == "golden" and "gold" or material)..".png" or "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_2.png")
			end
		end
		local overlayVisible = leggingsItem.id == "minecraft:leather_leggings"
		for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.LeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomOverlay}) do
			armorPart:setVisible(overlayVisible)
		end
		if self.parent.characterData.costume.callbacks ~= nil and self.parent.characterData.costume.callbacks.onArmorChange ~= nil then
			self.parent.characterData.costume.callbacks.onArmorChange(self.parent.characterData, "LEGGINGS", self.isArmorVisible.leggings)
		end
	end;

	---ブーツを更新する。
	---@param self Armor
	---@param bootsItem ItemStack ブーツスロットに入っているアイテム
	setBoots = function (self, bootsItem)
		local bootsFound = bootsItem.id:find("^minecraft:.+_boots$") ~= nil
		for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom}) do
			armorPart:setVisible(bootsFound)
		end
		self.isArmorVisible.boots = bootsFound
		if self.isArmorVisible.boots then
			local material = bootsItem.id:match("^minecraft:(%a+)_boots$")
			for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBoots, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBoots, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottom}) do
				armorPart:setPrimaryTexture("RESOURCE", client:getVersion() >= "1.21.2" and "minecraft:textures/entity/equipment/humanoid/"..(material == "golden" and "gold" or material)..".png" or "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_1.png")
			end
		end
		local overlayVisible = bootsItem.id == "minecraft:leather_boots"
		for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBootsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBootsOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomOverlay}) do
			armorPart:setVisible(overlayVisible)
		end
		if self.parent.characterData.costume.callbacks ~= nil and self.parent.characterData.costume.callbacks.onArmorChange ~= nil then
			self.parent.characterData.costume.callbacks.onArmorChange(self.parent.characterData, "BOOTS", self.isArmorVisible.boots)
		end
	end;
}