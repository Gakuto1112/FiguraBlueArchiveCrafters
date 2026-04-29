---防具の部位
---@alias Armor.ArmorPart
---| "HELMET" # ヘルメット
---| "CHEST_PLATE" # チェストプレート
---| "LEGGINGS" # レギンス
---| "BOOTS" # ブーツ

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

---@class (exact) Armor 防具の表示を制御するクラス
---@field public shouldShowArmor boolean 防具を表示するかどうか
---@field public armorSlotItems ItemStack[] 現ティックの防具スロットのアイテム
---@field package armorSlotItemsPrev ItemStack[] 前ティックの防具スロットのアイテム
---@field package hasGlintPrev boolean[] 前ティックに防具がエンチャントのキラキラを持っていたかどうか
---@field public isArmorVisible Armor.VisiblePartsSet 各防具の部位（ヘルメット、チェストプレート、レギンス、ブーツ）が可視状態かどうか
---@field package textureQueue Armor.TextureQueueData[] テクスチャ処理のキュー
---@field package toggleArmorVisibilityAction Action アクションホイールの防具表示切り替えアクション
local Armor = {
	shouldShowArmor = false;
	armorSlotItems = {world.newItem("minecraft:air"), world.newItem("minecraft:air"), world.newItem("minecraft:air"), world.newItem("minecraft:air")};
	armorSlotItemsPrev = {world.newItem("minecraft:air"), world.newItem("minecraft:air"), world.newItem("minecraft:air"), world.newItem("minecraft:air")};
	hasGlintPrev = {false, false, false, false};
	isArmorVisible = {
		helmet = false;
		chestplate = false;
		leggings = false;
		boots = false;
	};
	textureQueue = {};
	toggleArmorVisibilityAction = nil;

	---初期化関数
    ---@param self Armor
    init = function (self)
		self.shouldShowArmor = Config:loadConfig("PRIVATE", "armor.should_show_armor", false)

		if host:isHost() then
			self.toggleArmorVisibilityAction = ActionWheel:getToggleAction()
				:setItem("minecraft:iron_chestplate")
				:setOnToggle(function (_, action)
					pings.armor_setArmorVisibility(true)
					ActionWheel.setActionToggleHoverColor(action, true)
					sounds:playSound("minecraft:item.armor.equip_iron", player:getPos())
					Config.syncConfigs["shouldShowArmor"] = true
					Config:saveConfig("PRIVATE", "armor.should_show_armor", true)
				end)
				:setOnUntoggle(function (_, action)
					pings.armor_setArmorVisibility(false)
					ActionWheel.setActionToggleHoverColor(action, false)
					sounds:playSound("minecraft:item.armor.equip_iron", player:getPos())
					Config.syncConfigs["shouldShowArmor"] = false
					Config:saveConfig("PRIVATE", "armor.should_show_armor", false)
				end)
			if self.shouldShowArmor then
				self.toggleArmorVisibilityAction:setToggled(true)
				ActionWheel.setActionToggleHoverColor(self.toggleArmorVisibilityAction, true)
				Config.syncConfigs["shouldShowArmor"] = true
			end
			ActionWheel:setAction(self.toggleArmorVisibilityAction, 3)
		end

		for _, vanillaModel in ipairs({vanilla_model.HELMET, vanilla_model.CHESTPLATE, vanilla_model.LEGGINGS}) do
			vanillaModel:setVisible(false)
		end
		local gameVersion = client:getVersion()
		local isNewerPath = StringUtils.compareVersions(gameVersion, "1.21.2") == gameVersion
		for _, overlayPart in ipairs({ModelAlias.alias.avatar.head.ArmorH.Helmet.HelmetOverlay, ModelAlias.alias.avatar.body.ArmorB.Chestplate.ChestplateOverlay, ModelAlias.alias.avatar.rightArm.ArmorRA.RightChestplate.RightChestplateOverlay, ModelAlias.alias.avatar.leftArm.ArmorLA.LeftChestplate.LeftChestplateOverlay, ModelAlias.alias.avatar.rightArm.ArmorRA.RightChestplate.RightChestplateOverlay, ModelAlias.alias.avatar.rightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomOverlay, ModelAlias.alias.avatar.leftArm.ArmorLA.LeftChestplate.LeftChestplateOverlay, ModelAlias.alias.avatar.leftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomOverlay, ModelAlias.alias.avatar.rightLeg.ArmorRL.RightBoots.RightBootsOverlay, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomOverlay, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftBoots.LeftBootsOverlay, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomOverlay}) do
			overlayPart:setPrimaryTexture("RESOURCE", isNewerPath and "minecraft:textures/entity/equipment/humanoid/leather_overlay.png" or "minecraft:textures/models/armor/leather_layer_1_overlay.png")
		end
		for _, overlayPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Leggings.LeggingsOverlay, ModelAlias.alias.avatar.rightLeg.ArmorRL.RightLeggings.RightLeggingsOverlay, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomOverlay, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftLeggings.LeftLeggingsOverlay, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomOverlay}) do
			overlayPart:setPrimaryTexture("RESOURCE", isNewerPath and "minecraft:textures/entity/equipment/humanoid_leggings/leather_overlay.png" or "minecraft:textures/models/armor/leather_layer_2_overlay.png")
		end

		events.TICK:register(function ()
			self.armorSlotItems = self.shouldShowArmor and {player:getItem(6), player:getItem(5), player:getItem(4), player:getItem(3)} or {world.newItem("minecraft:air"), world.newItem("minecraft:air"), world.newItem("minecraft:air"), world.newItem("minecraft:air")}
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
						ModelAlias.alias.avatar.head.ArmorH.Helmet:setSecondaryRenderType(renderType)
					elseif index == 2 then
						for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Chestplate, ModelAlias.alias.avatar.rightArm.ArmorRA.RightChestplate, ModelAlias.alias.avatar.rightArmBottom.ArmorRAB.RightChestplateBottom, ModelAlias.alias.avatar.leftArm.ArmorLA.LeftChestplate, ModelAlias.alias.avatar.leftArmBottom.ArmorLAB.LeftChestplateBottom}) do
							armorPart:setSecondaryRenderType(renderType)
						end
					elseif index == 3 then
						for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Leggings, ModelAlias.alias.avatar.rightLeg.ArmorRL.RightLeggings, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightLeggingsBottom, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftLeggings, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftLeggingsBottom}) do
							armorPart:setSecondaryRenderType(renderType)
						end
					elseif index == 4 then
						for _, armorPart in ipairs({ModelAlias.alias.avatar.rightLeg.ArmorRL.RightBoots, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightBootsBottom, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftBoots, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftBootsBottom}) do
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
						ModelAlias.alias.avatar.head.ArmorH.Helmet.Helmet:setColor(colorVector)
					elseif index == 2 then
						for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Chestplate.Chestplate, ModelAlias.alias.avatar.rightArm.ArmorRA.RightChestplate.RightChestplate, ModelAlias.alias.avatar.rightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottom, ModelAlias.alias.avatar.leftArm.ArmorLA.LeftChestplate.LeftChestplate, ModelAlias.alias.avatar.leftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottom}) do
							armorPart:setColor(colorVector)
						end
					elseif index == 3 then
						for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Leggings.Leggings, ModelAlias.alias.avatar.rightLeg.ArmorRL.RightLeggings.RightLeggings, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottom, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftLeggings.LeftLeggings, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottom}) do
							armorPart:setColor(colorVector)
						end
					elseif index == 4 then
						for _, armorPart in ipairs({ModelAlias.alias.avatar.rightLeg.ArmorRL.RightBoots.RightBoots, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottom, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftBoots.LeftBoots, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottom}) do
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
							ModelAlias.alias.avatar.head.ArmorH.Helmet.HelmetTrim:setVisible(true)
							ModelAlias.alias.avatar.head.ArmorH.Helmet.HelmetTrim:setPrimaryTexture("CUSTOM", trimTexture)
						else
							ModelAlias.alias.avatar.head.ArmorH.Helmet.HelmetTrim:setVisible(false)
						end
					elseif index == 2 then
						local trimTexture = self:getTrimTexture(trim, self.armorSlotItems[2].id)
						if trimTexture then
							for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Chestplate.ChestplateTrim, ModelAlias.alias.avatar.rightArm.ArmorRA.RightChestplate.RightChestplateTrim, ModelAlias.alias.avatar.rightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomTrim, ModelAlias.alias.avatar.leftArm.ArmorLA.LeftChestplate.LeftChestplateTrim, ModelAlias.alias.avatar.leftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomTrim}) do
								armorPart:setVisible(true)
								armorPart:setPrimaryTexture("CUSTOM", trimTexture)
							end
						else
							for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Chestplate.ChestplateTrim, ModelAlias.alias.avatar.rightArm.ArmorRA.RightChestplate.RightChestplateTrim, ModelAlias.alias.avatar.rightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomTrim, ModelAlias.alias.avatar.leftArm.ArmorLA.LeftChestplate.LeftChestplateTrim, ModelAlias.alias.avatar.leftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomTrim}) do
								armorPart:setVisible(false)
							end
						end
					elseif index == 3 then
						local trimTexture = self:getTrimTexture(trim, self.armorSlotItems[3].id)
						if trimTexture then
							for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Leggings.LeggingsTrim, ModelAlias.alias.avatar.rightLeg.ArmorRL.RightLeggings.RightLeggingsTrim, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomTrim, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftLeggings.LeftLeggingsTrim, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomTrim}) do
								armorPart:setVisible(true)
								armorPart:setPrimaryTexture("CUSTOM", trimTexture)
							end
						else
							for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Leggings.LeggingsTrim, ModelAlias.alias.avatar.rightLeg.ArmorRL.RightLeggings.RightLeggingsTrim, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomTrim, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftLeggings.LeftLeggingsTrim, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomTrim}) do
								armorPart:setVisible(false)
							end
						end
					elseif index == 4 then
						local trimTexture = self:getTrimTexture(trim, self.armorSlotItems[4].id)
						if trimTexture then
							for _, armorPart in ipairs({ModelAlias.alias.avatar.rightLeg.ArmorRL.RightBoots.RightBootsTrim, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomTrim, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftBoots.LeftBootsTrim, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomTrim}) do
								armorPart:setVisible(true)
								armorPart:setPrimaryTexture("CUSTOM", trimTexture)
							end
						else
							for _, armorPart in ipairs({ModelAlias.alias.avatar.rightLeg.ArmorRL.RightBoots.RightBootsTrim, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomTrim, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftBoots.LeftBootsTrim, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomTrim}) do
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

		EventManager.events["ON_LOCALE_REFRESH"]:register(function ()
			self.toggleArmorVisibilityAction
				:setTitle(Locale:getLocalizedText("action_wheel.main_page.toggle_armor_visibility.title") .. "§c" .. Locale:getLocalizedText("action_wheel.action.toggle_off"))
				:setToggleTitle(Locale:getLocalizedText("action_wheel.main_page.toggle_armor_visibility.title") .. "§a" .. Locale:getLocalizedText("action_wheel.action.toggle_on"))
		end)

		EventManager.events["ON_CONFIG_SYNC"]:register(function (configData)
			if configData["shouldShowArmor"] then
				pings.armor_setArmorVisibility(true)
			else
				pings.armor_setArmorVisibility(false)
			end
		end)
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
				local gameVersion = client:getVersion()
				local texture = textures:fromVanilla(textureName, (StringUtils.compareVersions(gameVersion, "1.21.2") == gameVersion) and "minecraft:textures/trims/entity/humanoid"..(armorId:find("^minecraft:.+_leggings$") ~= nil and "_leggings" or "").."/"..normalizedPatternName..".png" or "minecraft:textures/trims/models/armor/"..normalizedPatternName..(armorId:find("^minecraft:.+_leggings$") ~= nil and "_leggings" or "")..".png")
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
		ModelAlias.alias.avatar.head.ArmorH:setVisible(helmetFound)
		if helmetFound then
			local material = helmetItem.id:match("^minecraft:(%a+)_helmet$")
			local gameVersion = client:getVersion()
			ModelAlias.alias.avatar.head.ArmorH.Helmet.Helmet:setPrimaryTexture("RESOURCE", (StringUtils.compareVersions(gameVersion, "1.21.2") == gameVersion) and "minecraft:textures/entity/equipment/humanoid/"..(material == "golden" and "gold" or (material == "turtle" and "turtle_scute" or material))..".png" or "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_1.png")
		end
		ModelAlias.alias.avatar.head.ArmorH.Helmet.HelmetOverlay:setVisible(helmetItem.id == "minecraft:leather_helmet")
		self.isArmorVisible.helmet = helmetFound or hatFound
		if BlueArchiveCharacter.costume.callbacks ~= nil and BlueArchiveCharacter.costume.callbacks.onArmorChange ~= nil then
			BlueArchiveCharacter.costume.callbacks.onArmorChange(BlueArchiveCharacter, "HELMET", self.isArmorVisible.helmet)
		end
	end;

	---チェストプレートを更新する。
	---@param self Armor
	---@param chestplateItem ItemStack チェストプレートスロットに入っているアイテム
	setChestplate = function (self, chestplateItem)
		local chestplateFound = chestplateItem.id:find("^minecraft:.+_chestplate$") ~= nil
		for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Chestplate}) do
			armorPart:setVisible(chestplateFound)
		end
		if chestplateFound then
			events.RENDER:register(function (_, context)
				for _, armorPart in ipairs({ModelAlias.alias.avatar.rightArm.ArmorRA, ModelAlias.alias.avatar.rightArmBottom.ArmorRAB, ModelAlias.alias.avatar.leftArm.ArmorLA, ModelAlias.alias.avatar.leftArmBottom.ArmorLAB}) do
					armorPart:setVisible(context ~= "FIRST_PERSON")
				end
			end, "armor_chestplate_render")
		else
			events.RENDER:remove("armor_chestplate_render")
			for _, armorPart in ipairs({ModelAlias.alias.avatar.rightArm.ArmorRA, ModelAlias.alias.avatar.rightArmBottom.ArmorRAB, ModelAlias.alias.avatar.leftArm.ArmorLA, ModelAlias.alias.avatar.leftArmBottom.ArmorLAB}) do
				armorPart:setVisible(false)
			end
		end
		self.isArmorVisible.chestplate = chestplateFound
		if self.isArmorVisible.chestplate then
			local material = chestplateItem.id:match("^minecraft:(%a+)_chestplate$")
			local gameVersion = client:getVersion()
			local isNewerPath = StringUtils.compareVersions(gameVersion, "1.21.2") == gameVersion
			for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Chestplate.Chestplate, ModelAlias.alias.avatar.rightArm.ArmorRA.RightChestplate.RightChestplate, ModelAlias.alias.avatar.rightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottom, ModelAlias.alias.avatar.leftArm.ArmorLA.LeftChestplate.LeftChestplate, ModelAlias.alias.avatar.leftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottom}) do
				armorPart:setPrimaryTexture("RESOURCE", isNewerPath and "minecraft:textures/entity/equipment/humanoid/"..(material == "golden" and "gold" or material)..".png" or "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_1.png")
			end
		end
		local overlayVisible = chestplateItem.id == "minecraft:leather_chestplate"
		for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Chestplate.ChestplateOverlay, ModelAlias.alias.avatar.rightArm.ArmorRA.RightChestplate.RightChestplateOverlay, ModelAlias.alias.avatar.rightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomOverlay, ModelAlias.alias.avatar.leftArm.ArmorLA.LeftChestplate.LeftChestplateOverlay, ModelAlias.alias.avatar.leftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomOverlay}) do
			armorPart:setVisible(overlayVisible)
		end
		if BlueArchiveCharacter.costume.callbacks ~= nil and BlueArchiveCharacter.costume.callbacks.onArmorChange ~= nil then
			BlueArchiveCharacter.costume.callbacks.onArmorChange(BlueArchiveCharacter, "CHEST_PLATE", self.isArmorVisible.chestplate)
		end
	end;

	---レギンスを更新する。
	---@param self Armor
	---@param leggingsItem ItemStack レギンススロットに入っているアイテム
	setLeggings = function (self, leggingsItem)
		local leggingsFound = leggingsItem.id:find("^minecraft:.+_leggings$") ~= nil
		for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Leggings, ModelAlias.alias.avatar.rightLeg.ArmorRL.RightLeggings, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightLeggingsBottom, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftLeggings, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftLeggingsBottom}) do
			armorPart:setVisible(leggingsFound)
		end
		self.isArmorVisible.leggings = leggingsFound
		if self.isArmorVisible.leggings then
			local material = leggingsItem.id:match("^minecraft:(%a+)_leggings$")
			local gameVersion = client:getVersion()
			local isNewerPath = StringUtils.compareVersions(gameVersion, "1.21.2") == gameVersion
			for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Leggings.Leggings, ModelAlias.alias.avatar.rightLeg.ArmorRL.RightLeggings.RightLeggings, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottom, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftLeggings.LeftLeggings, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottom}) do
				armorPart:setPrimaryTexture("RESOURCE", isNewerPath and "minecraft:textures/entity/equipment/humanoid_leggings/"..(material == "golden" and "gold" or material)..".png" or "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_2.png")
			end
		end
		local overlayVisible = leggingsItem.id == "minecraft:leather_leggings"
		for _, armorPart in ipairs({ModelAlias.alias.avatar.body.ArmorB.Leggings.LeggingsOverlay, ModelAlias.alias.avatar.rightLeg.ArmorRL.RightLeggings.RightLeggingsOverlay, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomOverlay, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftLeggings.LeftLeggingsOverlay, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomOverlay}) do
			armorPart:setVisible(overlayVisible)
		end
		if BlueArchiveCharacter.costume.callbacks ~= nil and BlueArchiveCharacter.costume.callbacks.onArmorChange ~= nil then
			BlueArchiveCharacter.costume.callbacks.onArmorChange(BlueArchiveCharacter, "LEGGINGS", self.isArmorVisible.leggings)
		end
	end;

	---ブーツを更新する。
	---@param self Armor
	---@param bootsItem ItemStack ブーツスロットに入っているアイテム
	setBoots = function (self, bootsItem)
		local bootsFound = bootsItem.id:find("^minecraft:.+_boots$") ~= nil
		for _, armorPart in ipairs({ModelAlias.alias.avatar.rightLeg.ArmorRL.RightBoots, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightBootsBottom, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftBoots, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftBootsBottom}) do
			armorPart:setVisible(bootsFound)
		end
		self.isArmorVisible.boots = bootsFound
		if self.isArmorVisible.boots then
			local material = bootsItem.id:match("^minecraft:(%a+)_boots$")
			local gameVersion = client:getVersion()
			local isNewerPath = StringUtils.compareVersions(gameVersion, "1.21.2") == gameVersion
			for _, armorPart in ipairs({ModelAlias.alias.avatar.rightLeg.ArmorRL.RightBoots.RightBoots, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottom, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftBoots.LeftBoots, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottom}) do
				armorPart:setPrimaryTexture("RESOURCE", isNewerPath and "minecraft:textures/entity/equipment/humanoid/"..(material == "golden" and "gold" or material)..".png" or "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_1.png")
			end
		end
		local overlayVisible = bootsItem.id == "minecraft:leather_boots"
		for _, armorPart in ipairs({ModelAlias.alias.avatar.rightLeg.ArmorRL.RightBoots.RightBootsOverlay, ModelAlias.alias.avatar.rightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomOverlay, ModelAlias.alias.avatar.leftLeg.ArmorLL.LeftBoots.LeftBootsOverlay, ModelAlias.alias.avatar.leftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomOverlay}) do
			armorPart:setVisible(overlayVisible)
		end
		if BlueArchiveCharacter.costume.callbacks ~= nil and BlueArchiveCharacter.costume.callbacks.onArmorChange ~= nil then
			BlueArchiveCharacter.costume.callbacks.onArmorChange(BlueArchiveCharacter, "BOOTS", self.isArmorVisible.boots)
		end
	end;
}

---防具の可視状態を切り替える。
---@param isVisible boolean 防具を可視にするかどうか
function pings.armor_setArmorVisibility(isVisible)
	Armor.shouldShowArmor = isVisible
end

return Armor
