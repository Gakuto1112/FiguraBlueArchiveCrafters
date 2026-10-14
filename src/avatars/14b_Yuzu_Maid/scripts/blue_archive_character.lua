---右目のテクスチャの列挙型
---@alias Character14b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "UNEQUAL" # 不等号目（><）
---| "INVERTED" # 反対側を見る目
---| "ANGRY" # 怒った目
---| "CLOSED2" # 閉じた目2
---| "FEAR" # 恐怖を感じているときの目
---| "FEAR_CENTER" # 恐怖を感じてつつ少し反対側を見る目
---| "CLOSED2_WITH_TEAR" # 涙ぐみつつ閉じた目2

---左目のテクスチャの列挙型
---@alias Character14b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "UNEQUAL" # 不等号目（><）
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "FEAR" # 恐怖を感じているときの目
---| "FEAR_CENTER" # 恐怖を感じてつつ少し反対側を見る目
---| "CLOSED2_WITH_TEAR" # 涙ぐみつつ閉じた目2
---| "ANGRY" # 怒った目
---| "INVERTED" # 反対側を見る目

---口のテクスチャの列挙型
---@alias Character14b.MouthTextures
---| "NORMAL" # 通常
---| "SHOCK" # あんぐり口
---| "FRUST" # ぐにゅぐにゅ口
---| "SMALL" # 小さく開けた口
---| "CLOSED" # 閉じた口
---| "ANGRY" # 怒った口
---| "FEAR" # 恐怖を感じているときの口
---| "SMILE" # にっこり
---| "OPENED" # 開いた口

---キャラクター固有の腕の状態
---@alias Character14b.AdditionalArmState
---| "IN_CHEST" # チェストの中に隠れている時の手

---@class (exact) Character14b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character14b.RightEyeTextures 右目の表情名
---@field public leftEye Character14b.LeftEyeTextures 左目の表情名
---@field public mouth Character14b.MouthTextures 口の表情名

---@class (exact) Character14b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character14b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character14b.EmotionSet ベッドで寝ているとき

---@class (exact) Character14b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character14b, right: Character14b.RightEyeTextures, left: Character14b.LeftEyeTextures, mouth: Character14b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character14b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character14b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character14b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character14b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character14b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character14b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character14b.ArmsCallbacksSet : BlueArchiveCharacter.ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(self: Character14b, right: Arms.BaseArmState|Character14b.AdditionalArmState, left: Arms.BaseArmState|Character14b.AdditionalArmState): {right?: Arms.BaseArmState|Character14b.AdditionalArmState, left?: Arms.BaseArmState|Character14b.AdditionalArmState}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(self: Character14b, state: Arms.BaseArmState|Character14b.AdditionalArmState): boolean? 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: Character14b, state: Arms.BaseArmState|Character14b.AdditionalArmState): boolean? 左腕の追加処理

---@class (exact) Character14b.ArmsStruct : BlueArchiveCharacter.ArmsStruct 腕のデータ構造体
---@field public callbacks? Character14b.ArmsCallbacksSet 腕の制御のコールバック関数群

---@class (exact) Character14b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character14b.FacePartsStruct 目や口による表情
---@field public arms Character14b.ArmsStruct 腕

---@type Character14b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "14b_Yuzu_Maid";

		birth = {
			month = 8;
			day = 12;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			UNEQUAL = vectors.vec2(5, 0);
			INVERTED = vectors.vec2(6, 0);
			ANGRY = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(9, 0);
			FEAR = vectors.vec2(10, 0);
			FEAR_CENTER = vectors.vec2(11, 0);
			CLOSED2_WITH_TEAR = vectors.vec2(12, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			UNEQUAL = vectors.vec2(4, 0);
			ANGRY_INVERTED = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(8, 0);
			FEAR = vectors.vec2(9, 0);
			FEAR_CENTER = vectors.vec2(10, 0);
			CLOSED2_WITH_TEAR = vectors.vec2(11, 0);
			ANGRY = vectors.vec2(12, 0);
			INVERTED = vectors.vec2(13, 0);
		};

		mouth = {
			SHOCK = vectors.vec2(0, 0);
			FRUST = vectors.vec2(1, 0);
			SMALL = vectors.vec2(2, 0);
			CLOSED = vectors.vec2(3, 0);
			ANGRY = vectors.vec2(4, 0);
			FEAR = vectors.vec2(5, 0);
			SMILE = vectors.vec2(6, 0);
			OPENED = vectors.vec2(7, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (self)
				if self.costume.shouldShowChest then
					return {right = "IN_CHEST", left = "IN_CHEST"}
				end
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "IN_CHEST" then
					ModelAlias.alias.avatar.rightArm:setRot(0, 0, 15)
					ModelAlias.alias.avatar.rightArm:setParentType("Body")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "IN_CHEST" then
					ModelAlias.alias.avatar.leftArm:setRot(0, 0, -15)
					ModelAlias.alias.avatar.leftArm:setParentType("Body")
				end
			end;
		};
	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt1};
	};

	gun = {
		scale = 0.8;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 3, -4);
					left = vectors.vec3(0, 3, -4);
				};

				thirdPersonPos = {
					right = vectors.vec3(-2.25, 3, -4.5);
					left = vectors.vec3(2.25, 3, -4.5);
				};
			};

			put = {
				type = "HIDDEN";
			};
		};

		sound = {
			name = "minecraft:entity.arrow.shoot";
			pitch = 0.5;
		};

		---武器のアニメーション用のティック変数
		---@type integer
		animationTick = 0;

		---前ティックの銃の位置
		---@type Gun.GunPosition
		gunPositionPrev = "NONE";
	};

	placementObjects = {
	};

	exSkill = {
		primary = {
			formationType = "SPECIAL";

			models = {ModelAlias.alias.avatar.head.ExSkill1H.ShineEffect, models.models.ex_skill_1.Pillagers, models.models.ex_skill_1.Gui.Hotbar, models.models.ex_skill_1.Gui.Map};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 175, 0);
					pos = vectors.vec3(13, 23, -24);
				};

				fin = {
					rot = vectors.vec3(5, 195, 0);
					pos = vectors.vec3(-5.75, 17, -18.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						---@diagnostic disable-next-line: discard-returns
						models:newPart("script_ex_skill_1_wall_model")
						models.script_ex_skill_1_wall_model:setPos(-8, 0, 8)
						for i = 1, 4 do
							models.script_ex_skill_1_wall_model:newBlock("ex_skill_1_block_"..i):setBlock("minecraft:stripped_dark_oak_log"):setPos(0, (i - 1) * 16, 0)
						end
						for i = 1, 3 do
							for j = 1, 4 do
								models.script_ex_skill_1_wall_model:newBlock("ex_skill_1_block_"..((i - 1) * 4) + j + 4):setBlock("minecraft:dark_oak_planks"):setPos((i - 1) * 16 + 16, (j - 1) * 16, 0)
							end
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Head.PillagerHead, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Head.Pillager1Nose, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Body, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1RightArm, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1LeftArm, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1RightLeg, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1LeftLeg}) do
							modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/illager/pillager.png")
						end
						for _, part in ipairs({"Head", "Body", "RightArm", "LeftArm", "RightLeg", "LeftLeg"}) do
							models.models.ex_skill_1.Pillagers.Pillager2["Pillager2"..part]:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Pillagers.Pillager1["Pillager1"..part]))
						end
						for i = 1, 2 do
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."RightArm"]:newItem("ex_skill_1_pillager_"..i.."_crossbow"):setItem("minecraft:crossbow"):setPos(0, -12, -2):setRot(0, 0, -135)
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."Question"]["Pillager"..i.."Question2"]:newText("ex_skill_1_pillager_question_"..i):setText("§e?"):setPos(0, 7, 0):setAlignment("CENTER")
						end
						if host:isHost() then
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection1:newItem("ex_skill_1_hotbar_section1"):setItem("minecraft:firework_rocket"):setPos(0, 11, 0)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection2:newItem("ex_skill_1_hotbar_section2"):setItem("minecraft:comparator"):setPos(0, 11, 0)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection3:newItem("ex_skill_1_hotbar_section3"):setItem("minecraft:name_tag"):setPos(0, 11, 0)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection4:newItem("ex_skill_1_hotbar_section4"):setItem("minecraft:arrow"):setPos(0, 11, 0)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection5:newItem("ex_skill_1_hotbar_section5"):setItem("minecraft:book"):setPos(0, 11, 0)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection6:newItem("ex_skill_1_hotbar_section6"):setItem("minecraft:crossbow"):setPos(0, 11, -5)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection7:newItem("ex_skill_1_hotbar_section7"):setItem("minecraft:brush"):setPos(0, 11, -5)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection9:newItem("ex_skill_1_hotbar_section9"):setItem("minecraft:diamond"):setPos(0, 11, -5)
							models.models.ex_skill_1.Gui.Map.MapBackground:setPrimaryTexture("RESOURCE", "minecraft:textures/map/map_background.png")
							models.models.ex_skill_1.YuzuChest:setVisible(true)
							local chestModel = ModelUtils:copyModel(models.models.ex_skill_1.YuzuChest)
							chestModel:setPos(-60, -16, -2)
							chestModel:setRot(-33.4, 39.86, -22.91)
							chestModel:setScale(0.5, 0.5, 0.5)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection8:addChild(chestModel)
							models.models.ex_skill_1.Gui.ScreenEffects:setScale(8, 8, 8)
							for _, modelName in ipairs({"ScreenEffectTLBack", "ScreenEffectBRFront", "ScreenEffectBRBack"}) do
								models.models.ex_skill_1.Gui.ScreenEffects:addChild(models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectTLFront:copy(modelName))
							end
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRFront, models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRBack}) do
								modelPart:setRot(0, 0, 180)
							end
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectTLFront, models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRFront}) do
								modelPart:setColor(0.996, 0.4, 0.455)
							end
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectTLBack, models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRBack}) do
								modelPart:setColor(0.231, 0.725, 0.988)
							end
							if StringUtils.isNewerOrEqualVersion(client:getVersion(), "1.20.2") then
								for i = 1, 9 do
									models.models.ex_skill_1.Gui.Hotbar["HotbarSection"..i]["HotbarSection"..i]:setPrimaryTexture("RESOURCE", "minecraft:textures/gui/sprites/hud/hotbar.png")
								end
								models.models.ex_skill_1.Gui.Hotbar.HotbarSelection:setPrimaryTexture("RESOURCE", "minecraft:textures/gui/sprites/hud/hotbar_selection.png")
								models.models.ex_skill_1.Gui.Map.PlayerMarker:setPrimaryTexture("RESOURCE", "minecraft:textures/map/decorations/player.png")
								for i = 1, 2 do
									models.models.ex_skill_1.Gui.Map["EnemyMarker"..i]:setPrimaryTexture("RESOURCE", "minecraft:textures/map/decorations/red_marker.png")
								end
							else
								textures:fromVanilla("widgets", "minecraft:textures/gui/widgets.png")
								local hotbarTextureScale = textures["widgets"]:getDimensions().x / 256
								textures:newTexture("hotbar", 182 * hotbarTextureScale, 22 * hotbarTextureScale)
								for y = 0, 21 do
									for x = 0, 181 do
										textures["hotbar"]:setPixel(x, y, textures["widgets"]:getPixel(x, y))
									end
								end
								for i = 1, 9 do
									models.models.ex_skill_1.Gui.Hotbar["HotbarSection"..i]["HotbarSection"..i]:setPrimaryTexture("CUSTOM", textures["hotbar"])
								end
								textures:newTexture("hotbar_selection", 24 * hotbarTextureScale, 24 * hotbarTextureScale)
								for y = 0, 23 do
									for x = 0, 23 do
										textures["hotbar_selection"]:setPixel(x, y, textures["widgets"]:getPixel(x, y + 22))
									end
								end
								models.models.ex_skill_1.Gui.Hotbar.HotbarSelection:setPrimaryTexture("CUSTOM", textures["hotbar_selection"])
								textures:fromVanilla("map_icons", "minecraft:textures/map/map_icons.png")
								local mapTextureScale = textures["map_icons"]:getDimensions().x / 128
								textures:newTexture("player", 8 * mapTextureScale, 8 * mapTextureScale)
								for y = 0, 7 do
									for x = 0, 7 do
										textures["player"]:setPixel(x, y, textures["map_icons"]:getPixel(x, y))
									end
								end
								models.models.ex_skill_1.Gui.Map.PlayerMarker:setPrimaryTexture("CUSTOM", textures["player"])
								textures:newTexture("red_marker", 8 * mapTextureScale, 8 * mapTextureScale)
								for y = 0, 7 do
									for x = 0, 7 do
										textures["red_marker"]:setPixel(x, y, textures["map_icons"]:getPixel(x + 16, y))
									end
								end
								for i = 1, 2 do
									models.models.ex_skill_1.Gui.Map["EnemyMarker"..i]:setPrimaryTexture("CUSTOM", textures["red_marker"])
								end
							end

						end
						self.exSkill.primary.isInitialized = true
					else
						models.script_ex_skill_1_wall_model:setVisible(true)
					end
					if host:isHost() then
						local windowSize = client:getScaledWindowSize()
						models.models.ex_skill_1.Gui.Hotbar:setPos(windowSize.x / 2 * -1, windowSize.y * -1, 0)
						models.models.ex_skill_1.Gui.Map:setPos(windowSize.x * -1 + 50, -30, 0)
					end
					FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "CLOSED", 6)
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setVisible(true)
					elseif tick == 6 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 2)
					elseif tick == 8 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "SMALL", 22)
					elseif tick == 21 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Question):add(0, 0.25, 0)
						for j = 0, 5 do
							particles:newParticle("minecraft:electric_spark", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(j * 60, 0.1, 0, 0, 0, 0, 1), 0, 1, 0)):setColor(1, 1, 0.33):setLifetime(5)
						end
						sounds:playSound("minecraft:entity.pillager.ambient", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1), 0.5, 1)
					elseif tick == 23 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager2.Pillager2Question):add(0, 0.25, 0)
						for j = 0, 5 do
							particles:newParticle("minecraft:electric_spark", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(j * 60, 0.1, 0, 0, 0, 0, 1), 0, 1, 0)):setColor(1, 1, 0.33):setLifetime(5)
						end
					elseif tick == 29 then
						ModelAlias.alias.avatar.head.ExSkill1H.NoticeEffect:setVisible(true)
						sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 0.25, 1.5)
					elseif tick == 30 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMALL", 2)
					elseif tick == 31 then
						ModelAlias.alias.avatar.head.ExSkill1H.NoticeEffect:setVisible(false)
					elseif tick == 32 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.head.ExSkill1H.FearEffect, ModelAlias.alias.avatar.head.ExSkill1H.NoticeEffect}) do
							modelPart:setVisible(true)
						end
						FaceParts:setEmotion("FEAR_CENTER", "FEAR", "FRUST", 2)
						sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 0.25, 1.5)
					elseif tick == 34 then
						ModelAlias.alias.avatar.head.ExSkill1H.NoticeEffect:setVisible(false)
						FaceParts:setEmotion("FEAR_CENTER", "FEAR", "FEAR", 8)
					elseif tick == 42 then
						FaceParts:setEmotion("FEAR", "FEAR_CENTER", "FEAR", 4)
					elseif tick == 46 then
						FaceParts:setEmotion("FEAR_CENTER", "FEAR", "FEAR", 4)
					elseif tick == 50 then
						FaceParts:setEmotion("FEAR", "FEAR_CENTER", "FEAR", 4)
					elseif tick == 54 then
						FaceParts:setEmotion("FEAR_CENTER", "FEAR", "FEAR", 4)
					elseif tick == 58 then
						FaceParts:setEmotion("FEAR", "FEAR_CENTER", "FEAR", 4)
					elseif tick == 62 then
						FaceParts:setEmotion("FEAR_CENTER", "FEAR", "FEAR", 4)
					elseif tick == 66 then
						FaceParts:setEmotion("FEAR", "FEAR_CENTER", "FEAR", 10)
					elseif tick == 71 and host:isHost() then
						sounds:playSound("minecraft:ui.button.click", player:getPos(), 0.5, 1)
					elseif tick == 74 then
						models.models.ex_skill_1.YuzuChest:setVisible(true)
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(models.models.ex_skill_1.YuzuChest), 1, 1)
					elseif tick == 76 then
						FaceParts:setEmotion("CLOSED2_WITH_TEAR", "CLOSED2_WITH_TEAR", "SHOCK", 17)
					elseif tick == 82 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.YuzuChest)
						for i = 0, 11 do
							particles:newParticle("minecraft:campfire_cosy_smoke", anchorPos:copy():add(vectors.rotateAroundAxis(i * 30, 0, 0, 0.5, 0, 1, 0))):setVelocity(vectors.rotateAroundAxis(i * 30, 0, 0, 0.05, 0, 1, 0)):setLifetime(20)
						end
						sounds:playSound("minecraft:entity.zombie.attack_wooden_door", ModelUtils.getModelWorldPos(models.models.ex_skill_1.YuzuChest), 0.2, 1.5)
					elseif tick == 84 then
						sounds:playSound("minecraft:entity.pillager.hurt", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1), 0.5, 1)
					elseif tick == 93 then
						ModelAlias.alias.avatar.head.ExSkill1H.FearEffect:setVisible(false)
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "SMALL", 44)
						sounds:playSound("minecraft:block.chest.open", player:getPos(), 0.1, 0.75)
					elseif tick == 105 and host:isHost() then
						events.RENDER:register(function (delta)
							local opacity = (ExSkill.animationCount + delta - 1) * -0.2 + 22
							for _, modelPart in ipairs({models.models.ex_skill_1.YuzuChest.YuzuChestBottom.YuzuChestBottomFront, models.models.ex_skill_1.YuzuChest.TheYuzu, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestTopFront, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestHook}) do
								modelPart:setOpacity(opacity)
							end
						end, "ex_skill_1_yuzu_chest")
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 0.5, 1.5)
					elseif tick == 106 and host:isHost() then
						models.models.ex_skill_1.Gui.ScreenEffects:setVisible(true)
						events.RENDER:register(function ()
							local windowSize = client:getScaledWindowSize()
							models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectTLFront:setPos(models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectFrontAnchor:getAnimPos().x * (windowSize.x / 427), -10, -1)
							models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectTLBack:setPos(models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBackAnchor:getAnimPos().x * (windowSize.x / 427), -11, 0)
							models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRFront:setPos(models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectFrontAnchor:getAnimPos().x * (windowSize.x / 427) * -1 + ((windowSize.x + math.sin(math.rad(-18.8)) * windowSize.y) * -1) / 8, (windowSize.y * -1 + math.sin(math.rad(-18.8)) * windowSize.x) / 8 + 10, -1)
							models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRBack:setPos(models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBackAnchor:getAnimPos().x * (windowSize.x / 427) * -1 + ((windowSize.x + math.sin(math.rad(-18.8)) * windowSize.y) * -1) / 8, (windowSize.y * -1 + math.sin(math.rad(-18.8)) * windowSize.x) / 8 + 11, 0)
						end, "ex_skill_1_screen_effects")
					elseif tick == 107 and host:isHost() then
						models.script_ex_skill_1_sprite:setPos(client:getScaledWindowSize():scale(-0.5):augmented(0))
						local windowSize = client:getScaledWindowSize()
						for i = 0, 5 do
							local offset = vectors.vec2(math.cos(math.rad(i * 60)), math.sin(math.rad(i * 60))):mul(windowSize.x / windowSize.y, 1)
							ExSkill1SpriteManager:spawn("STAR", offset:copy():scale(50), offset:copy():scale(math.random() * 5 + 10))
						end
						for _ = 1, 5 do
							local rot = math.random() * 360
							local offset = vectors.vec2(math.cos(math.rad(rot)), math.sin(math.rad(rot))):mul(windowSize.x / windowSize.y, 1)
							ExSkill1SpriteManager:spawn(math.random() < 0.5 and "MINISTAR" or "MINISTAR2", offset:copy():scale(50), offset:copy():scale(math.random() * 5 + 10))
						end
					elseif tick == 110 and host:isHost() then
						events.RENDER:remove("ex_skill_1_yuzu_chest")
						for _, modelPart in ipairs({models.models.ex_skill_1.YuzuChest.YuzuChestBottom.YuzuChestBottomFront, models.models.ex_skill_1.YuzuChest.TheYuzu, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestTopFront, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestHook}) do
							modelPart:setOpacity(0)
						end
					end
					if tick >= 32 and tick < 76 then
						particles:newParticle("minecraft:splash", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head)):setPower(2)
						if (tick - 32) % 4 == 0 then
							sounds:playSound("minecraft:block.bubble_column.bubble_pop", player:getPos(), 0.15, 2 - math.random() * 0.5)
						end
					end
					if tick >= 37 and tick <= 67 and (tick - 37) % 4 == 0 and host:isHost() then
						sounds:playSound("minecraft:ui.button.click", player:getPos(), 0.25, 1.5)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
					ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					ModelAlias.alias.avatar.gun:setVisible(Gun.currentGunPosition ~= "NONE")

					models.script_ex_skill_1_wall_model:setVisible(false)
					models.models.ex_skill_1.YuzuChest:setVisible(self.costume.shouldShowChest)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_screen_effects")
						models.models.ex_skill_1.Gui.ScreenEffects:setVisible(false)
						for _, modelPart in ipairs({models.models.ex_skill_1.YuzuChest.YuzuChestBottom.YuzuChestBottomFront, models.models.ex_skill_1.YuzuChest.TheYuzu, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestTopFront, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestHook}) do
							modelPart:setOpacity(1)
						end
					end
					if forcedStop then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.head.ExSkill1H.FearEffect, ModelAlias.alias.avatar.head.ExSkill1H.NoticeEffect}) do
							modelPart:setVisible(false)
						end
						if host:isHost() then
							ExSkill1SpriteManager:removeAll()
						end
					end
				end;

			};

			---このExスキルの初期化処理が行われたかどうか。
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.head.HairTip2, ModelAlias.alias.avatar.head.Brim}) do
						modelPart:setVisible(not isVisible)
					end
				elseif parts == "LEGGINGS" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt1, ModelAlias.alias.avatar.body.BackRibbon}) do
						modelPart:setVisible(not isVisible)
					end
				end
			end;
		};

		---この衣装の初期化処理が行われたかどうか
		---@type boolean
		isInitialized = false;

		---前ティックに脚とスカートの調整をしたかどうか
		---@type boolean
		shouldAdjustLegsPrev = false;

		---前ティックは脚を隠すべきだったかどうか
		---@type boolean
		shouldHideLegsPrev = false;

		---チェストを表示すべきかどうか
		---@type boolean
		shouldShowChest = false;

		---前ティックにチェストを表示していたかどうか
		---@type boolean
		shouldShowChestPrev = false;

		---チェストの中に隠れていたかどうか
		---@type boolean
		shouldHideInChest = false;

		---前ティックにチェストの中に隠れていたかどうか
		---@type boolean
		shouldHideInChestPrev = false;

		---前ティックのBodyYaw
		---@type number
		bodyYawPrev = 0;

		---チェストに隠れているときのAFKカウンター
		---@type integer
		chestAFKCount = 0;

		---チェストに隠れられる機能を停止する。
		---@param self Character14b
		stopChest = function (self)
			events.TICK:remove("chest_tick")
			events.RENDER:remove("chest_render")
			events.DAMAGE:remove("chest_damage")
			models.models.ex_skill_1.YuzuChest:setVisible(false)
			for _, anim in ipairs({animations["models.ex_skill_1"]["chest_idle"], animations["models.main"]["chest_hide"], animations["models.ex_skill_1"]["chest_hide"], animations["models.main"]["chest_afk"], animations["models.main"]["chest_afk_overwrite"], animations["models.ex_skill_1"]["chest_afk"]}) do
				anim:stop()
			end
			FaceParts:resetEmotion()
			CameraManager.setCameraPivot()
			renderer:setEyeOffset()
			self.costume.shouldShowChest = false
			self.costume.shouldShowChestPrev = false
			self.costume.shouldHideInChest = false
			self.costume.shouldHideInChestPrev = false
			self.costume.chestAFKCount = 0
			if Gun.currentGunPosition == "RIGHT" then
				Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
			elseif Gun.currentGunPosition == "LEFT" then
				Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
			else
				Arms:setArmState("DEFAULT", "DEFAULT")
			end
		end;
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("ANGRY", "ANGRY", "CLOSED", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "FRUST", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("FEAR", "FEAR", "FEAR", duration, true)
						ModelAlias.alias.avatar.head.ExSkill1H.FearEffect:setVisible(true)
					end
				end
			end;

			onStop = function(_, _, forcedStop)
				ModelAlias.alias.avatar.head.ExSkill1H.FearEffect:setVisible(false)
				if forcedStop then
					FaceParts:resetEmotion()
				end
			end;
		};
	};

	headModel = {

	};

	headBlock = {
		includeModels = {};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onBeforeModelCopy = function ()
				ModelAlias.alias.avatar.head.FearEffect:setVisible(false)
			end;

			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(20, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt1:setScale(1.5, 0.5, 1.5)
				ModelAlias.alias.dummy_avatar.legs:setVisible(false)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(-15, 0, -5)
				ModelAlias.alias.dummy_avatar.body.Skirt1:setRot(20, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt1:setScale(1, 1, 1)
				ModelAlias.alias.dummy_avatar.body.BackRibbon.RibbonBottomRight:setRot(15, 0, 0)
				ModelAlias.alias.dummy_avatar.body.BackRibbon.RibbonBottomLeft:setRot(15, 0, 0)
				ModelAlias.alias.dummy_avatar.legs:setVisible(true)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
		{
			models = {ModelAlias.alias.avatar.head.HairTip2};

			x = {
				vertical = {
					min = -15;
					neutral = 52.5;
					max = 82.5;

					bodyY = {
						multiplayer = -40;
						min = -15;
						max = 82.5;
					};
				};

				horizontal = {
					min = -15;
					neutral = 52.5;
					max = 82.5;

					bodyX = {
						multiplayer = -80;
						min = -15;
						max = 82.5;
					};
				};
			};

			y = {
				vertical = {
					min = -40;
					neutral = -40;
					max = -40;
				};

				horizontal = {
					min = -40;
					neutral = -40;
					max = -40;
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairTail};

			x = {
				vertical = {
					min = -170;
					neutral = 0;
					max = 30;
					sneakOffset = -20;
					headRotMultiplayer = -1;

					headX = {
						multiplayer = -80;
						min = -90;
						max = 10;
					};

					headRot = {
						multiplayer = 0.05;
						min = -90;
						max = 0;
					};

					bodyY = {
						multiplayer = 80;
						min = -170;
						max = 0;
					};
				};

				horizontal = {
					min = -135;
					neutral = -30;
					max = -30;

					headX = {
						multiplayer = -80;
						min = -45;
						max = -30;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairTail.HairTailZPivot};

			z = {
				vertical = {
					min = -80;
					neutral = 0;
					max = 80;

					headZ = {
						multiplayer = -80;
						min = -80;
						max = 80;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopLeftYPivot};

			y = {
				vertical = {
					min = 0;
					neutral = 0;
					max = 80;
					headRotMultiplayer = 0.5;

					headX = {
						multiplayer = 160;
						min = 0;
						max = 80;
					};

					headRot = {
						multiplayer = -0.1;
						min = 0;
						max = 80;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopLeftYPivot.HairBandRibbonTopLeftZPivot};

			z = {
				vertical = {
					min = -75;
					neutral = 0;
					max = 27.5;

					bodyY = {
						multiplayer = 20;
						min = -75;
						max = 27.5;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopRightYPivot};

			y = {
				vertical = {
					min = -80;
					neutral = 0;
					max = 0;
					headRotMultiplayer = -0.5;

					headX = {
						multiplayer = -160;
						min = -80;
						max = 0;
					};

					headRot = {
						multiplayer = 0.1;
						min = -80;
						max = 0;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopRightYPivot.HairBandRibbonTopRightZPivot};

			z = {
				vertical = {
					min = -27.5;
					neutral = 0;
					max = 75;

					bodyY = {
						multiplayer = -20;
						min = -27.5;
						max = 75;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomLeftXPivot, ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomRightXPivot};

			x = {
				vertical = {
					min = -170;
					neutral = 0;
					max = 0;
					headRotMultiplayer = -1;

					headX = {
						multiplayer = -160;
						min = -80;
						max = 0;
					};

					headRot = {
						multiplayer = 0.1;
						min = -80;
						max = 0;
					};

					bodyY = {
						multiplayer = 160;
						min = -170;
						max = 0;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomLeftXPivot.HairBandRibbonBottomLeftZPivot};

			z = {
				vertical = {
					min = 0;
					neutral = 0;
					max = 30;

					headX = {
						multiplayer = 20;
						min = 0;
						max = 30;
					};

					headRot = {
						multiplayer = -0.1;
						min = 0;
						max = 30;
					};

					bodyY = {
						multiplayer = 20;
						min = 0;
						max = 30;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomRightXPivot.HairBandRibbonBottomRightZPivot};

			z = {
				vertical = {
					min = -30;
					neutral = 0;
					max = 0;

					headX = {
						multiplayer = -20;
						min = -30;
						max = 0;
					};

					headRot = {
						multiplayer = 0.1;
						min = -30;
						max = 0;
					};

					bodyY = {
						multiplayer = -20;
						min = -30;
						max = 0;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonRight};

			y = {
				vertical = {
					min = -70;
					neutral = 0;
					max = 0;

					bodyX = {
						multiplayer = -40;
						min = -70;
						max = 0;
					};

					bodyRot = {
						multiplayer = 0.025;
						min = -70;
						max = 0;
					};
				};

				horizontal = {
					min = -70;
					neutral = 0;
					max = 0;

					bodyY = {
						multiplayer = 40;
						min = -70;
						max = 0;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonRight.RibbonRightZPivot};

			z = {
				vertical = {
					min = -20;
					neutral = 0;
					max = 20;

					bodyY = {
						multiplayer = -20;
						min = -20;
						max = 20;
					};
				};

				horizontal = {
					min = -20;
					neutral = 0;
					max = 20;

					bodyX = {
						multiplayer = -20;
						min = -20;
						max = 20;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonLeft};

			y = {
				vertical = {
					min = 0;
					neutral = 0;
					max = 70;

					bodyX = {
						multiplayer = 40;
						min = 0;
						max = 70;
					};

					bodyRot = {
						multiplayer = -0.025;
						min = 0;
						max = 70;
					};
				};

				horizontal = {
					min = 0;
					neutral = 0;
					max = 70;

					bodyY = {
						multiplayer = -40;
						min = 0;
						max = 70;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonLeft.RibbonLeftZPivot};

			z = {
				vertical = {
					min = -20;
					neutral = 0;
					max = 20;

					bodyY = {
						multiplayer = 20;
						min = -20;
						max = 20;
					};
				};

				horizontal = {
					min = -20;
					neutral = 0;
					max = 20;

					bodyX = {
						multiplayer = 20;
						min = -20;
						max = 20;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomRight, ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomLeft};

			x = {
				vertical = {
					min = -140;
					neutral = 0;
					max = 0;
					sneakOffset = 30;

					bodyX = {
						multiplayer = -80;
						min = -60;
						max = 0;
					};

					bodyY = {
						multiplayer = 80;
						min = -140;
						max = 0;
					};

					bodyRot = {
						multiplayer = 0.05;
						min = -60;
						max = 0;
					};
				};

				horizontal = {
					min = -140;
					neutral = 0;
					max = 0;

					bodyY = {
						multiplayer = 80;
						min = -60;
						max = 0;
					};
				};
			};
		};


		{
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomRight.RibbonBottomRightZPivot};

			z = {
				vertical = {
					min = -22.5;
					neutral = 0;
					max = 15;

					bodyX = {
						multiplayer = 10;
						min = -22.5;
						max = 15;
					};

					bodyRot = {
						multiplayer = -0.025;
						min = -22.5;
						max = 15;
					};
				};

				horizontal = {
					min = -22.5;
					neutral = 0;
					max = 10;

					bodyX = {
						multiplayer = 10;
						min = -22.5;
						max = 15;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomLeft.RibbonBottomLeftZPivot};

			z = {
				vertical = {
					min = -15;
					neutral = 0;
					max = 22.5;

					bodyX = {
						multiplayer = -10;
						min = -15;
						max = 22.5;
					};

					bodyRot = {
						multiplayer = 0.025;
						min = -15;
						max = 22.5;
					};
				};

				horizontal = {
					min = -22.5;
					neutral = 0;
					max = 10;

					bodyX = {
						multiplayer = 10;
						min = -22.5;
						max = 15;
					};
				};
			};
		};
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model == ModelAlias.alias.avatar.head.HairTail then
					model:setRot(math.min(model:getRot().x, 30), 0, 0)
				elseif model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopRightYPivot then
					model:setRot(0, math.min(model:getRot().y, 0), 0)
				elseif model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopLeftYPivot then
					model:setRot(0, math.max(model:getRot().y, 0), 0)
				elseif model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomRightXPivot or model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomLeftXPivot then
					model:setRot(math.min(model:getRot().x, 0), 0, 0)
				end
			end
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	---@param self Character14b
	init = function (self)
		---Exスキル1で使用するスプライトインスタンスのクラス
		---@type Character14b.ExSkill1Sprite
		ExSkill1Sprite = require("scripts.ex_skill_1_sprite")

		---Exスキル1で使用するスプライトマネージャーのクラス
		---@type Character14b.ExSkill1SpriteManager
		ExSkill1SpriteManager = require("scripts.ex_skill_1_sprite_manager")
		ExSkill1SpriteManager = ExSkill1SpriteManager.new()

		ExSkill1SpriteManager.init()

		for _, modelPart in ipairs({models.models.ex_skill_1.YuzuChest.YuzuChestBottom, models.models.ex_skill_1.YuzuChest.YuzuChestTop}) do
			modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/chest/normal.png")
		end

        events.TICK:register(function ()
            if not client:isPaused() then
                if Gun.currentGunPosition ~= "NONE" or ExSkill.animationCount >= 0 then
                    if self.gun.animationTick % 4 == 0 then
                        local frame = self.gun.animationTick / 4
						ModelAlias.alias.avatar.gun.GameDisplay.Display:setUVPixels(37 * (frame % 2), 15 * (math.floor(frame / 2)))
                    end
                    self.gun.animationTick = self.gun.animationTick == 15 and 0 or self.gun.animationTick + 1
                elseif Gun.currentGunPosition == "NONE" and self.gun.gunPositionPrev ~= "NONE" then
                    ModelAlias.alias.avatar.gun.GameDisplay.Display:setUVPixels()
                    self.gun.animationTick = 0
                end
                self.gun.gunPositionPrev = Gun.currentGunPosition

				local skirtVisible = ModelAlias.alias.avatar.body.Skirt1:getVisible()
				local shouldHideLegs = skirtVisible and player:getVehicle() ~= nil
				if shouldHideLegs and not self.costume.shouldHideLegsPrev then
					ModelAlias.alias.avatar.legs:setVisible(false)
					ModelAlias.alias.avatar.body.Skirt1:setScale(1.5, 0.5, 1.5)
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt1.Skirt2, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3.Skirt4}) do
						modelPart:setScale()
					end
				elseif not shouldHideLegs and self.costume.shouldHideLegsPrev then
					ModelAlias.alias.avatar.legs:setVisible(true)
				end

				local shouldAdjustLegs = skirtVisible and not shouldHideLegs
				if shouldAdjustLegs and not self.costume.shouldAdjustLegsPrev then
					events.RENDER:register(function (delta)
						local rightLegRotX = vanilla_model.RIGHT_LEG:getOriginRot().x
						ModelAlias.alias.avatar.rightLeg:setRot(rightLegRotX * -0.45, 0, 0)
						ModelAlias.alias.avatar.leftLeg:setRot(vanilla_model.LEFT_LEG:getOriginRot().x * -0.45, 0, 0)
						if self.costume.shouldHideInChest then
							for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt1, ModelAlias.alias.avatar.body.Skirt1.Skirt2, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3.Skirt4}) do
								modelPart:setScale()
							end
						else
							local rightLegRotAbs = math.abs(rightLegRotX)
							local playerPose = player:getPose()
							local skirtFlipVal = math.min(math.abs(Physics.getValueBetweenTicks(Physics.velocityAverage[7], delta)) * 0.00025 + ((playerPose == "SWIMMING" or playerPose == "FALL_FLYING") and 0 or math.max(Physics.getValueBetweenTicks(Physics.velocityAverage[2], delta) * -0.25, 0)), 0.5)
							ModelAlias.alias.avatar.body.Skirt1:setScale(1 + skirtFlipVal, 1 - skirtFlipVal * 0.75, rightLegRotAbs * 0.001 + 1 + skirtFlipVal)
							ModelAlias.alias.avatar.body.Skirt1.Skirt2:setScale(rightLegRotAbs * -0.0001 + 1, 1, rightLegRotAbs * 0.001 + 1)
							ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3:setScale(rightLegRotAbs * -0.0001 + 1, 1, rightLegRotAbs * 0.001 + 1)
							ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3.Skirt4:setScale(rightLegRotAbs * -0.00005 + 1, 1, rightLegRotAbs * 0.0005 + 1)
						end
					end, "costume_maid_render")
				elseif not shouldAdjustLegs and self.costume.shouldAdjustLegsPrev then
					events.RENDER:remove("costume_maid_render")
					for _, modelPart in ipairs({ModelAlias.alias.avatar.rightLeg, ModelAlias.alias.avatar.leftLeg}) do
						modelPart:setRot()
					end
					if not shouldHideLegs then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt1, ModelAlias.alias.avatar.body.Skirt1.Skirt2, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3.Skirt4}) do
							modelPart:setScale()
						end
					end
				end
				self.costume.shouldHideLegsPrev = shouldHideLegs
				self.costume.shouldAdjustLegsPrev = shouldAdjustLegs

				self.costume.shouldShowChest = player:getItem(6).id == "minecraft:carved_pumpkin" and not Armor.shouldShowArmor and ExSkill.animationCount == -1 and player:getPose() ~= "SLEEPING"
				if self.costume.shouldShowChest ~= self.costume.shouldShowChestPrev then
					if self.costume.shouldShowChest then
						models.models.ex_skill_1.YuzuChest:setVisible(true)
						for _, anim in ipairs({animations["models.ex_skill_1"]["chest_idle"], animations["models.main"]["chest_hide"], animations["models.ex_skill_1"]["chest_hide"]}) do
							anim:play()
						end
						for _, anim in ipairs({animations["models.main"]["chest_hide"], animations["models.ex_skill_1"]["chest_hide"]}) do
							anim:setTime(0)
							anim:setSpeed(-1)
						end
						Arms:setArmState("IN_CHEST", "IN_CHEST")
						events.TICK:register(function ()
							if not client:isPaused() then
								self.costume.shouldHideInChest = player:isCrouching()
								if self.costume.shouldHideInChest ~= self.costume.shouldHideInChestPrev then
									if self.costume.shouldHideInChest then
										for _, anim in ipairs({animations["models.main"]["chest_hide"], animations["models.ex_skill_1"]["chest_hide"]}) do
											anim:setSpeed(1)
										end
										sounds:playSound("minecraft:block.ender_chest.close", player:getPos(), 0.1, 2)
									else
										for _, anim in ipairs({animations["models.main"]["chest_hide"], animations["models.ex_skill_1"]["chest_hide"]}) do
											anim:setSpeed(-1)
										end
										sounds:playSound("minecraft:block.chest.open", player:getPos(), 0.1, 2)
									end
									self.costume.shouldHideInChestPrev = self.costume.shouldHideInChest
								end
								local bodyYaw = player:getBodyYaw()
								if self.costume.shouldHideInChest and not player:isMoving() and bodyYaw == self.costume.bodyYawPrev and not player:isInWater() and not player:isInLava() and player:getFrozenTicks() == 0 and player:getSwingArm() == nil and player:getActiveItem().id == "minecraft:air" then
									if self.costume.chestAFKCount == -135 then
										FaceParts:setEmotion("NORMAL", "INVERTED", "FRUST", 35, true)
										sounds:playSound("minecraft:block.chest.open", player:getPos(), 0.1, 2)
									elseif self.costume.chestAFKCount == -100 then
										FaceParts:setEmotion("INVERTED", "NORMAL", "FRUST", 35, true)
									elseif self.costume.chestAFKCount == -65 then
										FaceParts:setEmotion("NORMAL", "NORMAL", "FRUST", 15, true)
									elseif self.costume.chestAFKCount == -50 then
										FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMALL", 40, true)
									elseif self.costume.chestAFKCount == -10 then
										sounds:playSound("minecraft:block.ender_chest.close", player:getPos(), 0.1, 2)
									elseif self.costume.chestAFKCount == 1200 then
										for _, anim in ipairs({animations["models.main"]["chest_afk"], animations["models.main"]["chest_afk_overwrite"], animations["models.ex_skill_1"]["chest_afk"]}) do
											anim:play()
										end
										self.costume.chestAFKCount = -140
									end
									self.costume.chestAFKCount = self.costume.chestAFKCount + 1
								else
									for _, anim in ipairs({animations["models.main"]["chest_afk"], animations["models.main"]["chest_afk_overwrite"], animations["models.ex_skill_1"]["chest_afk"]}) do
										anim:stop()
									end
									FaceParts:resetEmotion()
									self.costume.chestAFKCount = 0
								end
								self.costume.bodyYawPrev = bodyYaw
							end
						end, "chest_tick")

						events.RENDER:register(function ()
							local lookYOffset = (models.models.ex_skill_1.YuzuChest:getAnimPos().y / 16 - 0.75) * 0.5
							CameraManager.setCameraPivot(vectors.vec3(0, lookYOffset, 0))
							renderer:setEyeOffset(0, lookYOffset, 0)
						end, "chest_render")

						events.DAMAGE:register(function ()
							for _, anim in ipairs({animations["models.main"]["chest_afk"], animations["models.main"]["chest_afk_overwrite"], animations["models.ex_skill_1"]["chest_afk"]}) do
								anim:stop()
							end
							self.costume.chestAFKCount = 0
						end, "chest_damage")
					else
						self.costume.stopChest(self)
					end
					self.costume.shouldShowChestPrev = self.costume.shouldShowChest
				end
            end
        end)
	end;
}

return BlueArchiveCharacter
