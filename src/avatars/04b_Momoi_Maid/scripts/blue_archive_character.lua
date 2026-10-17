---右目のテクスチャの列挙型
---@alias Character04b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "SURPRISED2" # 驚いて下を見る目
---| "ANGRY" # 怒っている目
---| "ANXIOUS" # 不満な目
---| "UNEQUAL" # ><
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目

---左目のテクスチャの列挙型
---@alias Character04b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "SURPRISED2" # 驚いて下を見る目
---| "ANGRY" # 怒っている目
---| "ANGRY2" # 怒っている目
---| "ANXIOUS" # 不満な目
---| "UNEQUAL" # ><
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "CENTER" # 少し反対側を見る目

---口のテクスチャの列挙型
---@alias Character04b.MouthTextures
---| "NORMAL" # 通常
---| "FUN" # 「美味しそう」な口
---| "ANXIOUS" # 口を膨らませる
---| "SHOCK" # あんぐり
---| "OPENED" # 開いた口
---| "SMILE" # こっちを舐め腐っているにっこり
---| "TRIANGLE" # 三角口
---| "ANGRY" # 怒った口

---@class (exact) Character04b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character04b.RightEyeTextures 右目の表情名
---@field public leftEye Character04b.LeftEyeTextures 左目の表情名
---@field public mouth Character04b.MouthTextures 口の表情名

---@class (exact) Character04b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character04b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character04b.EmotionSet ベッドで寝ているとき

---@class (exact) Character04b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character04b, right: Character04b.RightEyeTextures, left: Character04b.LeftEyeTextures, mouth: Character04b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character04b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character04b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character04b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character04b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character04b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character04b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character04b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character04b.FacePartsStruct 目や口による表情

---@type Character04b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "04b_Momoi_Maid";

		birth = {
			month = 12;
			day = 8;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			SURPRISED2 = vectors.vec2(5, 0);
			ANGRY = vectors.vec2(6, 0);
			ANXIOUS = vectors.vec2(11, 0);
			UNEQUAL = vectors.vec2(13, 0);
			ANGRY_CENTER = vectors.vec2(7, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(2, 0); --必須
			SURPRISED2 = vectors.vec2(4, 0);
			ANGRY2 = vectors.vec2(9, 0);
			ANXIOUS = vectors.vec2(11, 0);
			UNEQUAL = vectors.vec2(12, 0);
			ANGRY = vectors.vec2(7, 0);
			ANGRY_INVERTED = vectors.vec2(8, 0);
			CENTER = vectors.vec2(13, 0);
		};

		mouth = {
			OPENED = vectors.vec2(0, 0);
			FUN = vectors.vec2(3, 0);
			ANXIOUS = vectors.vec2(2, 0);
			SHOCK = vectors.vec2(1, 0);
			ANGRY = vectors.vec2(4, 0);
			SMILE = vectors.vec2(6, 0);
			TRIANGLE = vectors.vec2(7, 0);
		};

		emotionSet = {
			onDamage = {
				rightEye = "SURPRISED";
				leftEye = "SURPRISED";
				mouth = "SHOCK";
			};
		};
	};

	arms = {
	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt1};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-0.5, 3, -8);
					left = vectors.vec3(0.5, 3, -8);
				};

				thirdPersonPos = {
					right = vectors.vec3(-2, 3, -6);
					left = vectors.vec3(2, 3, -6);
				};
			};

			put = {
				type = "HIDDEN";
			};
		};

		sound = {
			name = "minecraft:entity.firework_rocket.blast";
			pitch = 1;
		};
	};

	placementObjects = {
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_1};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(20, -155, 0);
					pos = vectors.vec3(9, 32, -47);
				};
				fin = {
					rot = vectors.vec3(45, -210, 0);
					pos = vectors.vec3(19, 36.1, -14.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						for _, modelPart in ipairs({models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Head.PillagerHead, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Head.Pillager1Nose, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Body, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1RightArm, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1LeftArm, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1RightLeg, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1LeftLeg}) do
							modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/illager/pillager.png")
						end
						for _, part in ipairs({"Head", "Body", "RightArm", "LeftArm", "RightLeg", "LeftLeg"}) do
							for i = 2, 3 do
								models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i..part]:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Pillagers.Pillager1["Pillager1"..part]))
							end
						end
						for y = 0, 1 do
							for x = 0, 1 do
								models.models.ex_skill_1.Covers.CoverLeft:newBlock("ex_skill_1_block_"..y * 2 + x):setBlock("minecraft:barrel[facing=up]"):setPos(x * 16, y * 16, 0)
							end
						end
						models.models.ex_skill_1.Covers.CoverLeft:newBlock("ex_skill_1_block_4"):setBlock("minecraft:barrel[facing=up]"):setPos(16, 0, -16)
						--models.models.ex_skill_1.Covers.CoverLeft:newBlock("ex_skill_1_block_5"):setBlock("minecraft:decorated_pot"):setPos(16, 16, -16) --ブロックタスクで何故か飾り壺が描画されない...
						for i = 0, 1 do
							models.models.ex_skill_1.Covers.CoverRight:newBlock("ex_skill_1_block_"..6 + i):setBlock("minecraft:barrel[facing=up]"):setPos(-16, i * 16, 0)
						end
						for i = 0, 1 do
							models.models.ex_skill_1.Covers.CoverRight:newBlock("ex_skill_1_block_"..8 + i):setBlock("minecraft:barrel[facing=up]"):setPos(-32, 0, i * -16)
						end
						for i = 0, 1 do
							models.models.ex_skill_1.Covers.CoverBack1:newBlock("ex_skill_1_block_"..10 + i):setBlock("minecraft:barrel[facing=up]"):setPos(i * 16, 0, 0)
						end
						models.models.ex_skill_1.Covers.CoverBack1:newBlock("ex_skill_1_block_12"):setBlock("minecraft:barrel[facing=up]"):setPos(16, 16, 0)
						--models.models.ex_skill_1.Covers.CoverBack1:newBlock("ex_skill_1_block_13"):setBlock("minecraft:decorated_pot"):setPos(0, 16, 0) --ブロックタスクで何故か飾り壺が描画されない...
						for i = 0, 1 do
							models.models.ex_skill_1.Covers.CoverBack2:newBlock("ex_skill_1_block_"..14 + i):setBlock("minecraft:chiseled_bookshelf[facing=north,slot_0_occupied=true,slot_1_occupied=true,slot_2_occupied=true,slot_3_occupied=true,slot_4_occupied=true,slot_5_occupied=true]"):setPos(-8, i * 16, -8)
						end
						for i = 0, 1 do
							models.models.ex_skill_1.Covers.CoverBack3:newBlock("ex_skill_1_block_"..16 + i):setBlock("minecraft:red_wool"):setPos(-8, i * 16, -8)
						end
						models.models.ex_skill_1.Covers.CoverBack4:newBlock("ex_skill_1_block_18"):setBlock("minecraft:dark_oak_planks"):setPos(0, 0, 0)
						--models.models.ex_skill_1.Covers.CoverBack4:newBlock("ex_skill_1_block_19"):setBlock("minecraft:decorated_pot"):setPos(-16, 16, 0) --ブロックタスクで何故か飾り壺が描画されない...
						for y = 0, 6 do
							for x = 0, 8 do
								local blockCount = y * 9 + x
								if blockCount == 13 or blockCount == 22 or blockCount == 29 or blockCount == 30 or blockCount == 32 or blockCount == 33 or blockCount == 40 or blockCount == 49 then
									models.models.ex_skill_1.Wall:newBlock("ex_skill_1_block_"..20 + blockCount):setBlock("minecraft:dark_oak_log[axis=z]"):setPos(x * 16, y * 16, 0)
								end
								models.models.ex_skill_1.Wall:newBlock("ex_skill_1_block_"..20 + blockCount):setBlock( "minecraft:dark_oak_planks"):setPos(x * 16, y * 16, 0)
							end
						end
						for j = 0, 1 do
							for i = 0, 6 do
								models.models.ex_skill_1.Wall:newBlock("ex_skill_1_block_"..83 + j * 7 + i):setBlock("minecraft:dark_oak_planks"):setPos(j * 128, i * 16, -16)
							end
						end
						--models.models.ex_skill_1.Wall.Paintings.MainPainting:newEntity("ex_skill_1_entity_1"):setPos(0, 32, 0):setRot(0, 180, 0):setLight(15, 15) --謎の影ができて、それが消せない...
						models.models.ex_skill_1.Covers.CoverLeft.DecoratedPod1.Base_Side:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/decorated_pot/decorated_pot_side.png")
						for _, potPart in ipairs({models.models.ex_skill_1.Covers.CoverLeft.DecoratedPod1.Base_Top, models.models.ex_skill_1.Covers.CoverLeft.DecoratedPod1.Neck1, models.models.ex_skill_1.Covers.CoverLeft.DecoratedPod1.Neck2}) do
							potPart:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/decorated_pot/decorated_pot_base.png")
						end
						for index, modelPart in ipairs({models.models.ex_skill_1.Covers.CoverBack1, models.models.ex_skill_1.Covers.CoverBack4}) do
							modelPart:addChild(models.models.ex_skill_1.Covers.CoverLeft.DecoratedPod1:copy("DecoratedPod"..(index + 1)))
						end
						models.models.ex_skill_1.Covers.CoverBack1.DecoratedPod2:setPos(0, 0, 160)
						models.models.ex_skill_1.Covers.CoverBack4.DecoratedPod3:setPos(-128, 0, 176)
						models.models.ex_skill_1.Wall.Paintings.MainPainting.Painting_Back:setPrimaryTexture("RESOURCE", "minecraft:textures/painting/back.png")
						for _, modelPart in ipairs({models.models.ex_skill_1.Midori.MidoriHead.MidoriHeadRing, models.models.ex_skill_1.Wall.SpecialItemGroup}) do
							modelPart:setLight(15)
						end
						for i = 1, 3 do
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."RightArm"]:newItem("ex_skill_1_pillager_"..i.."_crossbow"):setItem("minecraft:crossbow"):setPos(0, -12, -2):setRot(0, 0, -135)
						end
						---@diagnostic disable-next-line: discard-returns
						models.models.ex_skill_1.Wall.SpecialItemGroup.SpecialItem:newItem("special_item")
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI:addChild(models.models.ex_skill_1.Gui.UI.MomoiUI.UI1:copy("UI1Shadow"))
							models.models.ex_skill_1.Gui.UI.MomoiUI.UI1Shadow:setPos(-1, -1, 1)
							models.models.ex_skill_1.Gui.UI.MomoiUI.UI1Shadow:setColor(0, 0, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI:addChild(ModelAlias.alias.avatar.gun:copy("GunIcon"))
							models.models.ex_skill_1.Gui.UI.MomoiUI.GunIcon:setPos(27, 15, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.GunIcon:setRot(0, 90, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.GunIcon:setScale(2.5, 2.5, 2.5)
							models.models.ex_skill_1.Gui.UI.MomoiUI.GunIcon:setVisible(true)
							for i = 2, 3 do
								local icon = models.models.ex_skill_1.Gui.UI.MomoiUI.LifeIcon1:copy("LifeIcon"..i)
								models.models.ex_skill_1.Gui.UI.MomoiUI:addChild(icon)
								icon:setPos((i - 1) * -15, 0, 0)
							end
							for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets:getChildren()) do
								modelPart:setColor(0.5, 0.5, 0.5)
							end
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.GunIcon, models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets}) do
								modelPart:setVisible(false)
							end
							models.models.ex_skill_1.Gui:setVisible(true)
							models.models.ex_skill_1.Gui.UI:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Gui.UI.MomoiUI, "MidoriUI"))
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.GunIcon, models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets}) do
								modelPart:setVisible(true)
							end
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MidoriUI.UI1, models.models.ex_skill_1.Gui.UI.MidoriUI.UI1Shadow, models.models.ex_skill_1.Gui.UI.MidoriUI.UI2}) do
								modelPart:setRot(0, 180, 0)
							end
							models.models.ex_skill_1.Gui.UI.MidoriUI:addChild(models.models.ex_skill_1.Midori.MidoriUpperBody.MidoriArms.MidoriRightArm.MidoriRightArmBottom.Gun2:copy("GunIcon"))
							models.models.ex_skill_1.Gui.UI.MidoriUI.GunIcon:setPos(116, 15, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.GunIcon:setRot(0, 90, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.GunIcon:setScale(1.67, 1.67, 1.67)
							for i = 1, 3 do
								models.models.ex_skill_1.Gui.UI.MidoriUI["LifeIcon"..i]:setPos(22 - (i - 1) * 15, 0, 0)
							end
							models.models.ex_skill_1.Gui.UI.MidoriUI:newText("ex_skill_1_reload_text"):setText("§4§lRELOAD"):setPos(154, 190, 0):setScale(1.6, 1.6, 1.6):setVisible(false)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI:addChild(models.models.ex_skill_1.Gui.UI.MomoiHeadUI.Frame:copy("FrameShadow"))
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.FrameShadow:setPos(-1, -1, 1)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.FrameShadow:setColor(0, 0, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.Background:setColor(1, 0.643, 0.71)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll:addChild(ModelUtils:copyModel(models.script_head_block.Skull, "MomoiPaperDollHead"))
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll:getTruePivot():add(0, -24, 0))
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.Halo:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll:setScale(4.1, 4.1, 4.1)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts:addChild(ModelAlias.alias.avatar.mouth:copy("Mouth"))
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(128, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setVisible(true)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll:setVisible(false)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI:setVisible(true)
							models.models.ex_skill_1.Gui.UI:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Gui.UI.MomoiHeadUI, "MidoriHeadUI"))
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll:setVisible(true)
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.Background:setColor(0.573, 0.98, 0.604)
							---@diagnostic disable-next-line: discard-returns
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI:newPart("MidoriPaperDoll", "None")
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll:setScale(4.1, 4.1, 4.1)
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll:setOffsetPivot(33.25, 12.5, 16)
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll:setRot(0, -15, 0)
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Midori.MidoriHead, "MidoriPaperDollHead"))
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead:setPrimaryRenderType("CUTOUT")
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead:setPos(18.25, -88.5, -57)
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.MidoriHeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.MidoriFaceParts.Eyes.LeftEye:setUVPixels(-6, 0)
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollBody, "MidoriPaperDollBody"))
						end
						self.exSkill.primary.isInitialized = true
					end
					if host:isHost() then
						models.models.ex_skill_1.Gui:setVisible(true)
						local windowsSize = client:getScaledWindowSize()
						models.models.ex_skill_1.Gui.UI.MomoiUI:setPos(-90, (windowsSize.y - 20) * -1, 0)
						models.models.ex_skill_1.Gui.UI.MidoriUI:setPos(windowsSize.x * -1 + 10, (windowsSize.y - 20) * -1, 0)
						models.models.ex_skill_1.Gui.UI.MidoriHeadUI:setPos(windowsSize.x * -1 + 88, 0, 0)
						models.models.ex_skill_1.Gui.UI.MidoriHeadUI:setOffsetPivot(windowsSize.x * -1 + 88, 0, 0)
					end
					Gun:setGunPosition("NONE")
					ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
					ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
					local specialItemValue = math.random() --0.80未満で「金のマガジン」、0.80~0.90未満で「エメラルド」、0.90~1.00未満で「ダイヤモンド」
					local specialItemTask = models.models.ex_skill_1.Wall.SpecialItemGroup.SpecialItem:getTask("special_item")
					---@cast specialItemTask ItemTask
					specialItemTask:setItem(specialItemValue < 0.8 and "minecraft:spectral_arrow" or (specialItemValue < 0.9 and "minecraft:emerald" or "minecraft:diamond"))
					specialItemTask:setVisible(true)
					self.exSkill.primary.glowColor = specialItemValue < 0.8 and vectors.vec3(1, 0.984, 0.4) or (specialItemValue < 0.9 and vectors.vec3(0.686, 0.992, 0.804) or vectors.vec3(0.631, 0.984, 0.91))
					models.models.ex_skill_1.Wall.SpecialItemGroup.GlowEffects:setColor(self.exSkill.primary.glowColor)
					local paintingResources = {"minecraft:textures/painting/pointer.png", "minecraft:textures/painting/pigscene.png", "minecraft:textures/painting/burning_skull.png"}
					if StringUtils.isNewerOrEqualVersion(client:getVersion(), "1.21") then
						for _, paintingName in ipairs({"minecraft:textures/painting/orb.png", "minecraft:textures/painting/unpacked.png"}) do
							table.insert(paintingResources, paintingName)
						end
					end
					models.models.ex_skill_1.Wall.Paintings.MainPainting.Painting_Front:setPrimaryTexture("RESOURCE", paintingResources[math.ceil(math.random() * #paintingResources)])
					--[[
						local paintingVariants = {"minecraft:pointer", "minecraft:pigscene", "minecraft:burning_skull"}
						models.models.ex_skill_1.Wall.Paintings.MainPainting:getTask("ex_skill_1_entity_1"):setNbt("minecraft:painting", toJson({variant = paintingVariants[math.ceil(math.random() * #paintingVariants)]}))
					]]
					---@diagnostic disable-next-line: discard-returns
					models.models.ex_skill_1.Covers.CoverBack4:newPart("MissText", "Camera")
					models.models.ex_skill_1.Covers.CoverBack4.MissText:setOffsetPivot(8, 24, 8)
					---@diagnostic disable-next-line: discard-returns
					models.models.ex_skill_1.Covers.CoverBack1:newPart("MissText", "Camera")
					models.models.ex_skill_1.Covers.CoverBack1.MissText:setOffsetPivot(8, 24, 8)
					FaceParts:setEmotion("ANGRY_CENTER", "ANGRY", "OPENED", 4, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 1 then
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setVisible(true)
						local playerPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						local bodyYaw = player:getBodyYaw()
						particles:newParticle("minecraft:end_rod", vectors.rotateAroundAxis(bodyYaw * -1, -0.75, 1.25, 0, 0, 1, 0):add(playerPos)):setScale(1):setColor(1, 0.984, 0.4):setLifetime(20)
						particles:newParticle("minecraft:end_rod", vectors.rotateAroundAxis(bodyYaw * -1, 0.65, 1.9, 0, 0, 1, 0):add(playerPos)):setScale(0.5):setColor(1, 0.984, 0.4):setLifetime(20)
					elseif tick == 4 then
						FaceParts:setEmotion("ANGRY_CENTER", "ANGRY", "SMILE", 6, true)
					elseif tick == 10 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 4, true)
					elseif tick == 14 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "SMILE", 11, true)
					elseif tick == 25 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", 22, true)
					elseif tick == 28 and host:isHost() then
						local windowSize = client:getScaledWindowSize()
						local centerX = windowSize.x / 2 * -1
						local centerY = windowSize.y / 2 * -1
						models.models.ex_skill_1.Gui.ReticuleAnchor:setPos(centerX, centerY, 0)
						models.models.ex_skill_1.Gui.Reticule:setVisible(true)
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.Reticule:setPos(vectors.vec3(centerX, centerY, 0):add(models.models.ex_skill_1.Gui.ReticuleAnchor:getAnimPos():scale(windowSize.y / 270)))
						end, "ex_skill_1_render")
					elseif tick == 35 then
						models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye:setUVPixels(-6, 0)
					elseif tick == 42 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack2.ExSkillParticleAnchor1)
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet24:setColor()
						end
					elseif tick == 44 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack3.ExSkillParticleAnchor2)
						self.exSkill.primary.playShotSound()
					elseif tick == 47 then
						FaceParts:setEmotion("ANGRY", "ANGRY2", "ANGRY", 33, true)
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack4.ExSkillParticleAnchor3)
						self.exSkill.primary.playShotSound()
						self.exSkill.primary.playPotBreak(models.models.ex_skill_1.Covers.CoverBack4.DecoratedPod3)
						Character04b_ExSkill1TextObjectManager:spawn(models.models.ex_skill_1.Covers.CoverBack4.MissText)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.LifeIcon1:setVisible(false)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI:setColor(1, 0.75, 0.75)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye:setUVPixels(12, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye:setUVPixels(6, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet23:setColor()
						end
					elseif tick == 50 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack3.ExSkillParticleAnchor4)
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI:setColor()
						end
					elseif tick == 52 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Wall.Paintings.MainPainting.ExSkillParticleAnchor5)
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet22:setColor()
						end
					elseif tick == 55 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Wall.ExSkillParticleAnchor6)
						self.exSkill.primary.playShotSound()
					elseif tick == 60 and host:isHost() then
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye, models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye}) do
							modelPart:setUVPixels()
						end
						models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(128, 0)
					elseif tick == 68 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Wall.ExSkillParticleAnchor7)
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet21:setColor()
						end
					elseif tick == 70 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack1.ExSkillParticleAnchor8)
						self.exSkill.primary.playShotSound()
						self.exSkill.primary.playPotBreak(models.models.ex_skill_1.Covers.CoverBack1.DecoratedPod2)
						Character04b_ExSkill1TextObjectManager:spawn(models.models.ex_skill_1.Covers.CoverBack1.MissText)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.LifeIcon2:setVisible(false)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI:setColor(1, 0.75, 0.75)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye:setUVPixels(12, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye:setUVPixels(6, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 0)
						end
					elseif tick == 72 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack1.ExSkillParticleAnchor9)
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet20:setColor()
						end
					elseif tick == 73 and host:isHost() then
						models.models.ex_skill_1.Gui.UI.MomoiHeadUI:setColor()
					elseif tick == 80 then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SHOCK", 35, true)
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack1.ExSkillParticleAnchor10)
						self.exSkill.primary.playShotSound()
					elseif tick == 83 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack1.ExSkillParticleAnchor11)
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet19:setColor()
						end
					elseif tick == 86 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Covers.CoverBack1.ExSkillParticleAnchor12)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 5 do
							particles:newParticle("minecraft:electric_spark", anchorPos):setScale(1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0.1, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, 0, 1, 0)):setColor(0.98, 0.843, 0.341):setLifetime(2)
						end
						self.exSkill.primary.playShotSound()
					elseif tick == 88 or tick == 99 then
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet18:setColor()
						end
					elseif tick == 105 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack2.ExSkillParticleAnchor13)
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet17:setColor()
						end
					elseif tick == 108 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack3.ExSkillParticleAnchor14)
						self.exSkill.primary.playShotSound()
					elseif tick == 110 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Wall.Paintings.MainPainting.ExSkillParticleAnchor15)
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet16:setColor()
						end
					elseif tick == 112 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Wall.Paintings.MainPainting.ExSkillParticleAnchor16)
						self.exSkill.primary.playShotSound()
					elseif tick == 113 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Wall.Paintings.MainPainting.ExSkillParticleAnchor17)
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet15:setColor()
						end
					elseif tick == 115 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 36, true)
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Wall.Paintings.MainPainting.ExSkillParticleAnchor18)
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.Reticule:setVisible(false)
							events.RENDER:remove("ex_skill_1_render")
						end
					elseif tick == 116 then
						sounds:playSound("minecraft:entity.zombie.break_wooden_door", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Wall.Paintings.MainPainting), 0.25, 2)
					elseif tick == 128 then
						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Wall.SpecialItemGroup), 1, 1)
					elseif tick == 132 then
						local anchorPos = vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, -0.75, 2, 0, 1, 0):add(ModelUtils.getModelWorldPos(models.models.ex_skill_1.Wall.Paintings.MainPainting))
						for _ = 1, 20 do
							local xOffset = math.random() * 4 - 2
							local zOffset = math.random() * 4 - 2
							particles:newParticle("minecraft:campfire_cosy_smoke", anchorPos:copy():add(xOffset, 0, zOffset)):setScale(5):setVelocity(xOffset * 0.03, 0.025, zOffset * 0.03)
						end
						sounds:playSound("minecraft:entity.zombie.attack_wooden_door", anchorPos, 0.25, 2)
						sounds:playSound("minecraft:entity.pillager.hurt", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1), 1, 1)
					elseif tick == 138 then
						sounds:playSound("minecraft:entity.zombie.attack_wooden_door", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Wall.Paintings.MainPainting), 0.05, 2)
					elseif tick == 148 and host:isHost() then
						local windowSize = client:getScaledWindowSize()
						models.models.ex_skill_1.Gui.TransitionFilter:setScale(windowSize.x, windowSize.y, 1)
						models.models.ex_skill_1.Gui.TransitionFilter:setVisible(true)
						events.RENDER:register(function (delta)
							if ExSkill.animationCount <= 151 then
								models.models.ex_skill_1.Gui.TransitionFilter:setOpacity((ExSkill.animationCount - 149 + delta) * 0.3333)
							else
								models.models.ex_skill_1.Gui.TransitionFilter:setOpacity((ExSkill.animationCount - 152 + delta) * -0.3333 + 1)
							end
						end, "ex_skill_1_transition_filter_render")
					elseif tick == 151 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
						models.models.ex_skill_1.Wall.SpecialItemGroup:moveTo(ModelAlias.alias.avatar.leftArmBottom)
						FaceParts:setEmotion("NORMAL", "CENTER", "TRIANGLE", 3, true)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI:setVisible(false)
						end
					elseif tick == 154 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "TRIANGLE", 2, true)
						if host:isHost() then
							events.RENDER:remove("ex_skill_1_transition_filter_render")
							models.models.ex_skill_1.Gui.TransitionFilter:setVisible(false)
						end
					elseif tick == 156 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 7, true)
					elseif tick == 163 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "TRIANGLE", 2, true)
					elseif tick == 165 then
						FaceParts:setEmotion("NORMAL", "CENTER", "TRIANGLE", 6, true)
					elseif tick == 171 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "TRIANGLE", 3, true)
					elseif tick == 174 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "OPENED", 36, true)
					elseif tick == 178 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					end
					if tick >= 128 and tick < 151 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Wall.SpecialItemGroup)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 5 do
							particles:newParticle("minecraft:end_rod", vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 3 - 1.5, math.random() * 3 - 1.5, 0, 0, 1, 0):add(anchorPos)):setVelocity(0, 0.1, 0):setColor(self.exSkill.primary.glowColor):setLifetime(8)
						end
					elseif tick >= 151 and tick < 170 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.SpecialItemGroup)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 2 do
							particles:newParticle("minecraft:end_rod", vectors.rotateAroundAxis(bodyYaw * -1 + 35, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, 0, 0, 1, 0):add(anchorPos)):setScale(0.25):setVelocity(0, 0.016, 0):setColor(self.exSkill.primary.glowColor):setLifetime(8)
						end
					end
					if tick < 124 then
						for i = 1, 3 do
							if math.random() >= 0.99 then
								sounds:playSound("minecraft:entity.pillager.ambient", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers["Pillager"..i]), 0.5, 1)
							end
						end
					end
					if tick >= 105 and tick < 124 and math.random() >= 0.95 then
						sounds:playSound("minecraft:item.crossbow.shoot", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1), 0.5, 1)
					end
					if tick >= 70 and tick < 124 and math.random() >= 0.95 then
						sounds:playSound("minecraft:item.crossbow.shoot", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager2), 0.5, 1)
					end
					if tick >= 54 and tick < 124 and math.random() >= 0.95 then
						sounds:playSound("minecraft:item.crossbow.shoot", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager3), 0.5, 1)
					end
					if tick >= 22 and tick < 151 and host:isHost() then
						if (tick - 22) % 30 == 0 then
							models.models.ex_skill_1.Gui.UI.MidoriUI:getTask("ex_skill_1_reload_text"):setVisible(true)
						elseif (tick - 22) % 30 == 20 then
							models.models.ex_skill_1.Gui.UI.MidoriUI:getTask("ex_skill_1_reload_text"):setVisible(false)
						end
					end
				end;

				onPostAnimation = function (_, forcedStop)
					for _, modelPart in ipairs({models.models.ex_skill_1.Covers.CoverBack1.DecoratedPod2, models.models.ex_skill_1.Covers.CoverBack4.DecoratedPod3}) do
						modelPart:setVisible(true)
					end
					models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye:setUVPixels()
					ModelAlias.alias.avatar.gun:setVisible(false)
					if ModelAlias.alias.avatar.rightArmBottom.Gun ~= nil  then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					end

					if ModelAlias.alias.avatar.leftArmBottom.SpecialItemGroup ~= nil then
						ModelAlias.alias.avatar.leftArmBottom.SpecialItemGroup:moveTo(models.models.ex_skill_1.Wall)
					end
					models.models.ex_skill_1.Wall.SpecialItemGroup.SpecialItem:getTask("special_item"):setVisible(false)
					if host:isHost() then
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui, models.models.ex_skill_1.Gui.Reticule}) do
							modelPart:setVisible(false)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI, models.models.ex_skill_1.Gui.UI.MomoiUI.LifeIcon1, models.models.ex_skill_1.Gui.UI.MomoiUI.LifeIcon2}) do
							modelPart:setVisible(true)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye, models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye}) do
							modelPart:setUVPixels()
						end
						models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(128, 0)
						for i = 15, 24 do
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets["Bullet"..i]:setColor(0.5, 0.5, 0.5)
						end
						models.models.ex_skill_1.Gui.UI.MidoriUI:getTask("ex_skill_1_reload_text"):setVisible(false)
						if forcedStop then
							models.models.ex_skill_1.Gui.TransitionFilter:setVisible(false)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI:setColor()
							for _, event in ipairs({"ex_skill_1_render", "ex_skill_1_transition_filter_render"}) do
								events.RENDER:remove(event)
							end
						end
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---キラキラエフェクトの色
			---@type Vector3
			glowColor = vectors.vec3();

			---銃弾のパーティクルを出す。
			---@param anchor ModelPart パーティクルを出す場所を示すアンカーポイント
			spawnBulletParticle = function (anchor)
				local anchorPos = ModelUtils.getModelWorldPos(anchor)
				local bodyYaw = player:getBodyYaw()
				for _ = 1, 5 do
					particles:newParticle("minecraft:electric_spark", anchorPos):setScale(1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, 0.1, 0, 1, 0)):setColor(0.98, 0.843, 0.341):setLifetime(2)
				end
				local muzzleAnchorPos =  ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.muzzleAnchor)

				for _ = 1, 5 do
					particles:newParticle("minecraft:smoke", muzzleAnchorPos)
				end
			end;

			---射撃音を再生する。
			playShotSound = function ()
				sounds:playSound("minecraft:entity.firework_rocket.blast", ModelUtils.getModelWorldPos(host:isHost() and models.models.main.CameraAnchor or ModelAlias.alias.avatar.root), 1, math.random() * 0.25 + 0.5)
			end;

			---飾り壺を割った時の演出を再生する
			---@param potModel ModelPart 飾り壺のモデルパーツ
			playPotBreak = function (potModel)
				local potPos = ModelUtils.getModelWorldPos(potModel)
				for _ = 1, 32 do
					particles:newParticle("minecraft:block minecraft:decorated_pot", potPos:copy():add(math.random() - 0.5, math.random(), math.random() - 0.5))
				end
				sounds:playSound("minecraft:block.glass.break", potPos, 1, 0.5)
				potModel:setVisible(false)
			end;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "LEGGINGS" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt1, ModelAlias.alias.avatar.body.BackRibbon}) do
						modelPart:setVisible(not isVisible)
					end
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "FUN", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SHOCK", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("ANGRY", "ANGRY2", "ANGRY", duration, true)
					end
				end
			end;

			onStop = function(_, _, forcedStop)
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
			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.legs:setVisible(false)
				ModelAlias.alias.dummy_avatar.body.Skirt1:setRot()
				ModelAlias.alias.dummy_avatar.body.Skirt1:setScale(1.5, 0.35, 1.5)
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.body.Skirt1.Skirt2, ModelAlias.alias.dummy_avatar.body.Skirt1.Skirt2.Skirt3, ModelAlias.alias.dummy_avatar.body.Skirt1.Skirt2.Skirt3.Skirt4}) do
					modelPart:setScale()
				end
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.body.BackRibbon.RibbonBottomRight, ModelAlias.alias.dummy_avatar.body.BackRibbon.RibbonBottomLeft}) do
					modelPart:setRot(-40, 0, 0)
				end
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.legs:setVisible(true)
				ModelAlias.alias.dummy_avatar.body.Skirt1:setScale(1, 1, 1)
				ModelAlias.alias.dummy_avatar.body.Skirt1:setRot(32.5, 0, 0)
				ModelAlias.alias.dummy_avatar.body.BackRibbon.RibbonBottomRight:setRot(20, 0, 5)
				ModelAlias.alias.dummy_avatar.body.BackRibbon.RibbonBottomLeft:setRot(20, 0, -25)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.TailXPivot};
				x = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;
						sneakOffset = 15;

						bodyY = {
							multiplayer = 40;
							min = -40;
							max = 40;
						};
					};

					horizontal = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyX = {
							multiplayer = 40;
							min = -40;
							max = 40;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.TailXPivot.TailYPivot};

				y = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyZ = {
							multiplayer = -80;
							min = -40;
							max = 40;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail, ModelAlias.alias.avatar.head.HairTails.LeftHairTail},

				y = {
					vertical = {
						min = -20;
						neutral = 0;
						max = 20;
					};

					horizontal = {
						min = -20;
						neutral = 0;
						max = 20;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail.RightHairTailZPivot, ModelAlias.alias.avatar.head.HairTails.LeftHairTail.LeftHairTailZPivot},

				z = {
					vertical = {
						min = -10;
						neutral = 0;
						max = 10;
					};

					horizontal = {
						min = -10;
						neutral = 0;
						max = 10;
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
				local playerPose = player:getPose()
				local isHorizontal = playerPose == "SWIMMING" or playerPose == "FALL_FLYING"
				if model:getName():match("^RightHairTail") then
					local velocityY = math.clamp(Physics.velocityAverage[1][2] * -40, -20, 20)
					local velocityZ = math.clamp(Physics.velocityAverage[2][2] * (isHorizontal and 160 or -40), -10, 10)
					local lookRotY = math.deg(math.asin(player:getLookDir().y)) / 90
					local rotY = velocityY * (1 - math.abs(lookRotY)) + velocityZ * lookRotY
					local rotZ = velocityZ * (1 - math.abs(lookRotY)) + velocityY * lookRotY * -1
					if model == ModelAlias.alias.avatar.head.HairTails.RightHairTail then
						ModelAlias.alias.avatar.head.HairTails.RightHairTail:setRot(0, isHorizontal and rotZ or rotY, 0)
					elseif model == ModelAlias.alias.avatar.head.HairTails.RightHairTail.RightHairTailZPivot then
						ModelAlias.alias.avatar.head.HairTails.RightHairTail.RightHairTailZPivot:setRot(0, 0, isHorizontal and rotY or rotZ)
					end
				elseif model:getName():match("^LeftHairTail") then
					local velocityY = math.clamp(Physics.velocityAverage[1][2] * 40, -20, 20)
					local velocityZ = math.clamp(Physics.velocityAverage[2][2] * (isHorizontal and -160 or 40), -10, 10)
					local lookRotY = math.deg(math.asin(player:getLookDir().y)) / 90
					local rotY = velocityY * (1 - math.abs(lookRotY)) + velocityZ * lookRotY
					local rotZ = velocityZ * (1 - math.abs(lookRotY)) + velocityY * lookRotY * -1
					if model == ModelAlias.alias.avatar.head.HairTails.LeftHairTail then
						ModelAlias.alias.avatar.head.HairTails.LeftHairTail:setRot(0, isHorizontal and rotZ or rotY, 0)
					elseif model == ModelAlias.alias.avatar.head.HairTails.LeftHairTail.LeftHairTailZPivot then
						ModelAlias.alias.avatar.head.HairTails.LeftHairTail.LeftHairTailZPivot:setRot(0, 0, isHorizontal and rotY or rotZ)
					end
				elseif (model == ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomRight or model == ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomLeft) and isHorizontal then
					model:setRot(model:getRot():scale(1 - math.clamp(Physics.velocityAverage[5][2], 0, 1.6) / 1.6))
				end
			end
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---Exスキルで使用するテキストオブジェクトのマネージャークラス
		---@type Character04b.ExSkill1TextObject
		Character04b_ExSkill1TextObject = require("scripts.ex_skill_1_text_object")

		---Exスキルで使用するテキストオブジェクトのマネージャークラス
		---@type Character04b.ExSkill1TextObjectManager
		Character04b_ExSkill1TextObjectManager = require("scripts.ex_skill_1_text_object_manager")
		Character04b_ExSkill1TextObjectManager = Character04b_ExSkill1TextObjectManager.new()

		---前ティックに脚とスカートの調整をしたかどうか
		---@type boolean
		local shouldAdjustLegsPrev = false;

		---前ティックは脚を隠すべきだったかどうか
		---@type boolean
		local shouldHideLegsPrev = false;

		events.TICK:register(function ()
			if not client:isPaused() then
				local skirtVisible = ModelAlias.alias.avatar.body.Skirt1:getVisible()
				local shouldHideLegs = skirtVisible and player:getVehicle() ~= nil
				if shouldHideLegs and not shouldHideLegsPrev then
					ModelAlias.alias.avatar.legs:setVisible(false)
					ModelAlias.alias.dummy_avatar.body.Skirt1:setRot()
					ModelAlias.alias.avatar.body.Skirt1:setScale(1.5, 0.35, 1.5)
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt1.Skirt2, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3.Skirt4}) do
						modelPart:setScale()
					end
				elseif not shouldHideLegs and shouldHideLegsPrev then
					ModelAlias.alias.avatar.legs:setVisible(true)
					ModelAlias.alias.avatar.body.Skirt1:setScale()
				end

				local shouldAdjustLegs = skirtVisible and not shouldHideLegs
				if shouldAdjustLegs and not shouldAdjustLegsPrev then
					events.RENDER:register(function (delta)
						local rightLegRotX = vanilla_model.RIGHT_LEG:getOriginRot().x
						ModelAlias.alias.avatar.rightLeg:setRot(rightLegRotX * -0.45, 0, 0)
						ModelAlias.alias.avatar.leftLeg:setRot(vanilla_model.LEFT_LEG:getOriginRot().x * -0.45, 0, 0)
						local rightLegRotAbs = math.abs(rightLegRotX)
						local playerPose = player:getPose()
						local skirtFlipVal = math.min(math.abs(Physics.getValueBetweenTicks(Physics.velocityAverage[7], delta)) * 0.00025 + ((playerPose == "SWIMMING" or playerPose == "FALL_FLYING") and 0 or math.max(Physics.getValueBetweenTicks(Physics.velocityAverage[2], delta) * -0.25, 0)), 0.5)
						ModelAlias.alias.avatar.body.Skirt1:setScale(1 + skirtFlipVal, 1 - skirtFlipVal, rightLegRotAbs * 0.001 + 1 + skirtFlipVal)
						ModelAlias.alias.avatar.body.Skirt1.Skirt2:setScale(rightLegRotAbs * -0.0001 + 1, 1, rightLegRotAbs * 0.001 + 1)
						ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3:setScale(rightLegRotAbs * -0.0001 + 1, 1, rightLegRotAbs * 0.001 + 1)
						ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3.Skirt4:setScale(rightLegRotAbs * -0.00005 + 1, 1, rightLegRotAbs * 0.0005 + 1)
					end, "costume_maid_render")
				elseif not shouldAdjustLegs and shouldAdjustLegsPrev then
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

				shouldHideLegsPrev = shouldHideLegs
				shouldAdjustLegsPrev = shouldAdjustLegs
			end
		end)
	end;
}

return BlueArchiveCharacter
