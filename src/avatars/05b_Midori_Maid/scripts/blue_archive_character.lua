---@alias Character05b.ExSkill2ShotByType
---| "MOMOI" # モモイ
---| "MIDORI" # ミドリ

---右目のテクスチャの列挙型
---@alias Character05b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANXIOUS" # 不満な目
---| "CLOSED2" # 閉じた目2
---| "ANGRY" # 怒った目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "INVERTED" # 反対側を見る目

---左目のテクスチャの列挙型
---@alias Character05b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANXIOUS" # 不満な目
---| "CLOSED2" # 閉じた目2
---| "ANGRY" # 怒った目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "CENTER" # 少し反対側を見る目

---口のテクスチャの列挙型
---@alias Character05b.MouthTextures
---| "NORMAL" # 通常
---| "FRUST" # ぐじゅぐじゅ口
---| "ANXIOUS" # 口を膨らませる
---| "CLOSED" # 閉じた口
---| "CLOSED2" # 閉じた口2
---| "SMILE" # ニッコリ
---| "SHOCK" # (つд⊂)ｴｰﾝ な口
---| "TRIANGLE" # 三角口
---| "SMILE_SMALL" # 小さくニッコリ
---| "OPENED_SMALL" # 小さく開いた口

---@class (exact) Character05b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character05b.RightEyeTextures 右目の表情名
---@field public leftEye Character05b.LeftEyeTextures 左目の表情名
---@field public mouth Character05b.MouthTextures 口の表情名

---@class (exact) Character05b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character05b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character05b.EmotionSet ベッドで寝ているとき

---@class (exact) Character05b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character05b, right: Character05b.RightEyeTextures, left: Character05b.LeftEyeTextures, mouth: Character05b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character05b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character05b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character05b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character05b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character05b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character05b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character05b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character05b.FacePartsStruct 目や口による表情

---@type Character05b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "05b_Midori_Maid";

		birth = {
			month = 12;
			day = 18;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			ANXIOUS = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(7, 0);
			ANGRY = vectors.vec2(9, 0);
			ANGRY_INVERTED = vectors.vec2(9, 0);
			INVERTED = vectors.vec2(12, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(2, 0); --必須
			ANXIOUS = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(6, 0);
			ANGRY = vectors.vec2(9, 0);
			ANGRY_INVERTED = vectors.vec2(7, 0);
			CENTER = vectors.vec2(10, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(3, 0);
			CLOSED2 = vectors.vec2(4, 0);
			FRUST = vectors.vec2(2, 0);
			ANXIOUS = vectors.vec2(1, 0);
			SMILE = vectors.vec2(0, 0);
			SHOCK = vectors.vec2(5, 0);
			TRIANGLE = vectors.vec2(7, 0);
			SMILE_SMALL = vectors.vec2(8, 0);
			OPENED_SMALL = vectors.vec2(9, 0);
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
			pitch = 0.5;
		};
	};

	placementObjects = {
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_1};

			animations = {"main", "ex_skill_1", "gun"};

			camera = {
				start = {
					rot = vectors.vec3(0, 135, 0);
					pos = vectors.vec3(-14, 22, -13);
				};
				fin = {
					rot = vectors.vec3(40, 190, 0);
					pos = vectors.vec3(-18, 36, -9);
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
						models.models.ex_skill_1.Covers.CoverRight:newBlock("ex_skill_1_block_4"):setBlock("minecraft:chest"):setPos(8, 0, 24):setRot(0, 180, 0)
						models.models.ex_skill_1.Covers.CoverRight:newBlock("ex_skill_1_block_5"):setBlock("minecraft:potted_azure_bluet"):setPos(-8, 14, 8)
						for y = 0, 1 do
							models.models.ex_skill_1.Covers.CoverRight:newBlock("ex_skill_1_block_"..y + 6):setBlock("minecraft:chiseled_bookshelf[facing=north,slot_0_occupied=true,slot_1_occupied=true,slot_2_occupied=true,slot_3_occupied=true,slot_4_occupied=true,slot_5_occupied=true]"):setPos(-24, y * 16, 8)
						end
						for y = 0, 1 do
							for x = 0, 1 do
								models.models.ex_skill_1.Covers.CoverBack1:newBlock("ex_skill_1_block_"..y * 2 + x + 8):setBlock("minecraft:barrel[facing=up]"):setPos(x * 16, y * 16, 0)
							end
						end
						for y = 0, 1 do
							models.models.ex_skill_1.Covers.CoverBack3:newBlock("ex_skill_1_block_"..y + 12):setBlock("minecraft:red_wool"):setPos(-8, y * 16, 0)
						end
						for y = 0, 1 do
							for x = 0, 1 do
								models.models.ex_skill_1.Covers.CoverBack2:newBlock("ex_skill_1_block_"..y * 2 + x + 14):setBlock("minecraft:barrel[facing=up]"):setPos(x * 16 - 32, y * 16, 0)
							end
						end
						for i = 1, 3 do
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."RightArm"]:newItem("ex_skill_1_pillager_"..i.."_crossbow"):setItem("minecraft:crossbow"):setPos(0, -12, -2):setRot(0, 0, -120)
						end
						models.models.main.Avatar.UpperBody.Body.GlowEffects:setColor(1, 0.984, 0.4)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI:addChild(models.models.ex_skill_1.Gui.UI.MomoiUI.UI1:copy("UI1Shadow"))
							models.models.ex_skill_1.Gui.UI.MomoiUI.UI1Shadow:setPos(-1, -1, 1)
							models.models.ex_skill_1.Gui.UI.MomoiUI.UI1Shadow:setColor(0, 0, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI:addChild(models.models.ex_skill_1.Momoi.MomoiUpperBody.MomoiArms.MomoiRightArm.MomoiRightArmBottom.Gun:copy("GunIcon"))
							models.models.ex_skill_1.Gui.UI.MomoiUI.GunIcon:setPos(-36, 15, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.GunIcon:setRot(0, 90, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.GunIcon:setScale(1.67, 1.67, 1.67)
							models.models.ex_skill_1.Gui.UI.MomoiUI.GunIcon:setPrimaryRenderType("CUTOUT")
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
							models.models.ex_skill_1.Gui.UI.MidoriBullets:moveTo(models.models.ex_skill_1.Gui.UI.MidoriUI)
							for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MidoriUI.MidoriBullets.MidoriRearBullets:getChildren()) do
								modelPart:setColor(0.5, 0.5, 0.5)
							end
							models.models.ex_skill_1.Gui.UI.MidoriUI:addChild(models.models.main.Avatar.UpperBody.Body.Gun:copy("GunIcon"))
							models.models.ex_skill_1.Gui.UI.MidoriUI.GunIcon:setPos(52, 15, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.GunIcon:setRot(0, 90, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.GunIcon:setScale(2.5, 2.5, 2.5)
							models.models.ex_skill_1.Gui.UI.MidoriUI.GunIcon:setVisible(true)
							for i = 1, 3 do
								models.models.ex_skill_1.Gui.UI.MidoriUI["LifeIcon"..i]:setPos(22 - (i - 1) * 15, 0, 0)
							end
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI:addChild(models.models.ex_skill_1.Gui.UI.MomoiHeadUI.Frame:copy("FrameShadow"))
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.FrameShadow:setPos(-1, -1, 1)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.FrameShadow:setColor(0, 0, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.Background:setColor(1, 0.643, 0.71)
							models.models.ex_skill_1.Momoi.MomoiHead.EffectPanel:setVisible(false)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Momoi.MomoiHead, "MomoiPaperDollHead"))
							models.models.ex_skill_1.Momoi.MomoiHead.EffectPanel:setVisible(true)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll:setScale(4.1, 4.1, 4.1)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll:setPrimaryRenderType("CUTOUT")
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll:getTruePivot():add(-64, -24, 0))
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiHeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts:addChild(ModelAlias.alias.avatar.mouth:copy("Mouth"))
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(16, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setVisible(true)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI:newText("ex_skill_1_gameover_text"):setText("§c§lGAME\nOVER"):setPos(32, -5, 0):setWidth(64):setAlignment("CENTER"):setScale(2, 2, 2):setShadow(true):setVisible(false)
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
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll:setPrimaryRenderType("CUTOUT")
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll:addChild(ModelUtils:copyModel(models.script_head_block.Skull, "MidoriPaperDollHead"))
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts:addChild(ModelAlias.alias.avatar.mouth:copy("Mouth"))
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setVisible(true)
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll:getTruePivot():add(0, -24, 0))
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.Halo:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollBody, "MidoriPaperDollBody"))
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.ClearEffect.Background, models.models.ex_skill_1.Gui.UI.ClearEffect.ClearBar}) do
								modelPart:setVisible(false)
							end
							models.models.ex_skill_1.Gui.UI.ClearEffect:newText("ex_skill_1_clear_effect_text_1"):setText("§e§lCLEAR"):setPos(0, 17.5, 0):setScale(5, 5, 5):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.25, 0.25, 0.08):setVisible(false)
							models.models.ex_skill_1.Gui.UI.ClearEffect:newText("ex_skill_1_clear_effect_text_2"):setText("§e§lCLEAR"):setPos(0, 17.5, 0):setScale(5, 5, 5):setAlignment("CENTER"):setVisible(false)
							models.models.ex_skill_1.Gui.MVP.LowerMVP:newText("ex_skill_1_mvp_text"):setText("§e§lMVP"):setPos(0, 17.5, -1):setScale(5, 5, 5):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.25, 0.25, 0.08)
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
						models.models.ex_skill_1.Gui.UI.DamageEffect:setPos(windowsSize.x * -0.5, 0, 0)
						models.models.ex_skill_1.Gui.UI.DamageEffect.CrackEffect:setPrimaryTexture("RESOURCE", "minecraft:textures/block/destroy_stage_9.png")
						models.models.ex_skill_1.Gui.UI.DamageEffect.RedEffect:setScale(windowsSize.x / 12, windowsSize.y, 1)
						models.models.ex_skill_1.Gui.UI.DamageEffect.CrackEffect:setScale(vectors.vec3(1, 1, 1):scale(windowsSize.y / 16))
						events.RENDER:register(function ()
							local windowHalfX = windowsSize.x / 2
							models.models.ex_skill_1.Gui.UI.DamageEffect.RedEffect:setPos(models.models.ex_skill_1.Gui.UI.DamageEffect.RedEffectAnchor:getAnimPos().x * windowHalfX + windowHalfX, 0, 0)
							models.models.ex_skill_1.Gui.UI.DamageEffect.CrackEffect:setOpacity(models.models.ex_skill_1.Gui.UI.DamageEffect.CrackEffectAnchor:getAnimPos().x * -1)
						end, "ex_skill_1_damage_effect_render")
						models.models.ex_skill_1.Gui.UI.ClearEffect:setPos(windowsSize.x / -2, windowsSize.y / -2, 0)
						models.models.ex_skill_1.Gui.UI.ClearEffect.Background:setScale(windowsSize.x, windowsSize.y, 1)
						models.models.ex_skill_1.Gui.UI:setVisible(true)
					end

					Gun:setGunPosition("NONE")
					ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
					ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
					models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye:setUVPixels(24, 0)
					models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye:setUVPixels(12, 0)
					for i = 1, 3 do
						models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."CoinAnchor"]:newItem("ex_skill_1_coin_"..i.."_item"):setItem("minecraft:emerald"):setVisible(false)
						self.exSkill.primary.shouldReplaceEmerald[i] = math.random() >= 0.9
						if self.exSkill.primary.shouldReplaceEmerald[i] then
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."CoinAnchor"]["Pillager"..i.."Coin"]:setVisible(false)
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."CoinAnchor"]:getTask("ex_skill_1_coin_"..i.."_item"):setVisible(true)
						end
					end
					FaceParts:setEmotion("NORMAL", "CENTER", "CLOSED", 16, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 1 then
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setVisible(true)
					elseif tick == 13 then
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye:setUVPixels(12, 0)
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye:setUVPixels(24, 0)
					elseif tick == 16 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "CLOSED", 14, true)
					elseif tick == 22 then
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye:setUVPixels(12, 0)
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye:setUVPixels(12, 0)
					elseif tick == 27 and host:isHost() then
						local windowSize = client:getScaledWindowSize()
						local centerX = windowSize.x / 2 * -1
						local centerY = windowSize.y / 2 * -1
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.Reticules.MomoiReticuleAnchor, models.models.ex_skill_1.Gui.Reticules.MidoriReticuleAnchor}) do
							modelPart:setPos(centerX, centerY, 0)
						end
						models.models.ex_skill_1.Gui.Reticules:setVisible(true)
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.Reticules.MomoiReticule:setPos(vectors.vec3(centerX, centerY, 0):add(models.models.ex_skill_1.Gui.Reticules.MomoiReticuleAnchor:getAnimPos():scale(windowSize.y / 270)))
							models.models.ex_skill_1.Gui.Reticules.MidoriReticule:setPos(vectors.vec3(centerX, centerY, 0):add(models.models.ex_skill_1.Gui.Reticules.MidoriReticuleAnchor:getAnimPos():scale(windowSize.y / 270)))
						end, "ex_skill_1_reticule_render")
					elseif tick == 30 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 95, true)
					elseif tick == 37 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack1.ExSkillParticleAnchor1, 0, 90, "MOMOI")
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet24:setColor()
						end
					elseif tick == 39 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack1.ExSkillParticleAnchor9, 0, 90, "MOMOI")
						self.exSkill.primary.playShotSound()
					elseif tick == 41 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack1.ExSkillParticleAnchor2, 0, 90, "MOMOI")
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet23:setColor()
						end
					elseif tick == 48 then
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye:setUVPixels(36, 0)
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye:setUVPixels(30, 0)
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(32, 0)
						models.models.ex_skill_1.Momoi:setColor(1, 0.75, 0.75)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.RightEye:setUVPixels(36, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.LeftEye:setUVPixels(30, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(32, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI:setColor(1, 0.75, 0.75)
							models.models.ex_skill_1.Gui.UI.MomoiUI.LifeIcon1:setVisible(false)
							sounds:playSound("minecraft:entity.player.hurt", ModelUtils.getModelWorldPos(models.models.main.CameraAnchor), 1, 0.5)
						else
							sounds:playSound("minecraft:entity.player.hurt", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Momoi), 1, 1)
						end
					elseif tick == 49 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Head.ExSkillParticleAnchor5, 0, 0, "MIDORI")
						self.exSkill.primary.playShotSound() --ミドリの射撃音
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MidoriUI.MidoriBullets.MidoriRearBullets.BulletM20:setColor()
						end
					elseif tick == 51 then
						sounds:playSound("minecraft:entity.pillager.death", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1), 1, 1)
					elseif tick == 54 and host:isHost() then
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.RightEye, models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.LeftEye}) do
							modelPart:setUVPixels()
						end
						models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(16, 0)
						models.models.ex_skill_1.Gui.UI.MomoiHeadUI:setColor()
					elseif tick == 55 then
						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1.Pillager1CoinAnchor), 1, 2)
					elseif tick == 56 then
						models.models.ex_skill_1.Momoi:setColor()
					elseif tick == 61 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.ExSkillParticleAnchor3, -90, 0, "MOMOI")
						self.exSkill.primary.playShotSound()
					elseif tick == 63 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.ExSkillParticleAnchor10, -90, 0, "MOMOI")
						self.exSkill.primary.playShotSound()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet22:setColor()
						end
					elseif tick == 65 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.ExSkillParticleAnchor11, -90, 0, "MOMOI")
						self.exSkill.primary.playShotSound()
					elseif tick == 70 then
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye:setUVPixels(12, 0)
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye:setUVPixels(48, 0)
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(64, 0)
						models.models.ex_skill_1.Momoi:setColor(1, 0.75, 0.75)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.RightEye:setUVPixels(36, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.LeftEye:setUVPixels(30, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(32, 0)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI:setColor(1, 0.75, 0.75)
							models.models.ex_skill_1.Gui.UI.MomoiUI.LifeIcon2:setVisible(false)
							sounds:playSound("minecraft:entity.player.hurt", ModelUtils.getModelWorldPos(models.models.main.CameraAnchor), 1, 0.5)
						else
							sounds:playSound("minecraft:entity.player.hurt", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Momoi), 1, 1)
						end
					elseif tick == 73 and host:isHost() then
						models.models.ex_skill_1.Gui.UI.MomoiHeadUI:setColor()
					elseif tick == 74 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack2.ExSkillParticleAnchor12, 0, -90, "MOMOI")
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack3.ExSkillParticleAnchor6, 0, 0, "MIDORI")
						self.exSkill.primary.playShotSound() --ミドリの射撃音
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet21:setColor()
						end
					elseif tick == 76 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack2.ExSkillParticleAnchor4, 0, 0, "MOMOI")
						self.exSkill.primary.playShotSound()
					elseif tick == 78 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Covers.CoverBack2.ExSkillParticleAnchor13, 0, -90, "MOMOI")
						self.exSkill.primary.playShotSound()
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye:setUVPixels(36, 0)
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye:setUVPixels(30, 0)
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(32, 0)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet20:setColor()
							sounds:playSound("minecraft:entity.player.hurt", ModelUtils.getModelWorldPos(models.models.main.CameraAnchor), 1, 0.5)
						else
							sounds:playSound("minecraft:entity.player.hurt", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Momoi), 1, 1)
						end
					elseif tick == 81 and host:isHost() then
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.Reticules.MomoiReticule, models.models.ex_skill_1.Gui.UI.MomoiUI.LifeIcon3, models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes}) do
								modelPart:setVisible(false)
							end
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollBody.DeadEye:setVisible(true)
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(48, 0)
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI, models.models.ex_skill_1.Gui.UI.MomoiHeadUI}) do
								modelPart:setColor(0.25, 0.25, 0.25)
							end
							local task = models.models.ex_skill_1.Gui.UI.MomoiHeadUI:getTask("ex_skill_1_gameover_text")
							task:setText("§c§lGAME\nOVER")
							task:setVisible(true)
					elseif tick == 82 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Covers.CoverBack3.ExSkillParticleAnchor15)
						for _ = 1, 10 do
							local xOffset = math.random() * 2 - 1
							local zOffset = math.random() * 2 - 1
							particles:newParticle("minecraft:campfire_cosy_smoke", anchorPos:copy():add(xOffset, 0, zOffset)):setScale(5):setVelocity(xOffset * 0.03, 0.025, zOffset * 0.03)
						end
					elseif tick == 83 and host:isHost() then
						models.models.ex_skill_1.Gui.UI.MomoiHeadUI:getTask("ex_skill_1_gameover_text"):setText("§4§lGAME\nOVER")
					elseif tick == 85 and host:isHost() then
						models.models.ex_skill_1.Gui.UI.MomoiHeadUI:getTask("ex_skill_1_gameover_text"):setText("§c§lGAME\nOVER")
					elseif tick == 87 and host:isHost() then
						models.models.ex_skill_1.Gui.UI.MomoiHeadUI:getTask("ex_skill_1_gameover_text"):setText("§4§lGAME\nOVER")
					elseif tick == 89 then
						models.models.ex_skill_1.Momoi:setColor()
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiHeadUI:getTask("ex_skill_1_gameover_text"):setText("§c§lGAME\nOVER")
						end
					elseif tick == 92 then
						sounds:playSound("minecraft:block.note_block.bit", host:isHost() and ModelUtils.getModelWorldPos(models.models.main.CameraAnchor) or player:getPos(), 1, 0.749154)
					elseif tick == 93 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Pillagers.Pillager2.Pillager2Body.ExSkillParticleAnchor7, 0, 0, "MIDORI")
						self.exSkill.primary.playShotSound() --ミドリの射撃音
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MidoriUI.MidoriBullets.MidoriRearBullets.BulletM19:setColor()
						end
					elseif tick == 94 then
						sounds:playSound("minecraft:block.note_block.bit", host:isHost() and ModelUtils.getModelWorldPos(models.models.main.CameraAnchor) or player:getPos(), 1, 0.667420)
						sounds:playSound("minecraft:entity.pillager.death", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager2), 1, 1)
					elseif tick == 96 then
						sounds:playSound("minecraft:block.note_block.bit", host:isHost() and ModelUtils.getModelWorldPos(models.models.main.CameraAnchor) or player:getPos(), 1, 0.594604)
					elseif tick == 98 then
						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager2.Pillager2CoinAnchor), 1, 2)
					elseif tick == 111 then
						self.exSkill.primary.spawnBulletParticle(models.models.ex_skill_1.Pillagers.Pillager3.Pillager3Body.ExSkillParticleAnchor8, 0, 0, "MIDORI")
						self.exSkill.primary.playShotSound() --ミドリの射撃音
					elseif tick == 112 then
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye:setUVPixels(42, 0)
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye:setUVPixels(42, 0)
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(144, 0)
						sounds:playSound("minecraft:entity.pillager.death", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager3), 1, 1)
					elseif tick == 116 then
						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager3.Pillager3CoinAnchor), 1, 2)
					elseif tick == 125 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED_SMALL", 30, true)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Eyes.RightEye:setUVPixels(18, 0)
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Eyes.LeftEye:setUVPixels(12, 0)
							models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(144, 8)
						end
					elseif tick == 130 then
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.ClearEffect.ClearBar:setVisible(true)
							local task = models.models.ex_skill_1.Gui.UI.ClearEffect:getTask("ex_skill_1_clear_effect_text_2")
							task:setVisible(true)
							events.RENDER:register(function (delta)
								local count = ExSkill.animationCount - 130 + delta
								local scale = count <= 2 and (count * -7.5 + 20) or (count <= 4 and (count * 7.5 - 10) or 20)
								task:setPos(0, scale * 3.5, 0)
								task:setScale(vectors.vec3(1, 1, 1):scale(scale))
								task:setOpacity((15 - (scale - 5)) / 15)
								if count >= 1 then
									local windowSize = client:getScaledWindowSize()
									models.models.ex_skill_1.Gui.UI.ClearEffect.ClearBar:setScale(windowSize.x, math.max(count * -40 + 120, 0), 1)
								end
							end, "ex_skill_1_clear_effect_render")
							sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(models.models.main.CameraAnchor), 1, 1)
						else
							sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1)
						end
					elseif tick == 131 and host:isHost() then
						for _ = 1, 16 do
							Character05b_ExSkill1ParticleManager:spawn()
						end
					elseif tick == 132 and host:isHost() then
						models.models.ex_skill_1.Gui.UI.ClearEffect.Background:setVisible(true)
						models.models.ex_skill_1.Gui.UI.ClearEffect:getTask("ex_skill_1_clear_effect_text_1"):setVisible(true)
					elseif tick == 148 and host:isHost() then
						Character05b_ExSkill1TransitionManager:play()
					elseif tick == 154 then
						ModelUtils.moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom)
					elseif tick == 155 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "CLOSED", 2, true)
						if host:isHost() then
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.Reticules, models.models.ex_skill_1.Gui.UI}) do
								modelPart:setVisible(false)
							end
							for _, eventName in ipairs({"ex_skill_1_reticule_render", "ex_skill_1_damage_effect_render", "ex_skill_1_clear_effect_render"}) do
								events.RENDER:remove(eventName)
							end
						end
					elseif tick == 156 and host:isHost() then
						local windowSize = client:getScaledWindowSize()
						models.models.ex_skill_1.Gui.MVP:setPos(windowSize.x / 2 * -1, 0, 0)
						models.models.ex_skill_1.Gui.MVP.LowerMVP:setPos(0, (windowSize.y - 35) * -1, 0)
						models.models.ex_skill_1.Gui.MVP.UpperMVP.UpperMVPBar:setScale(windowSize.x, 1, 1)
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.MVP.LowerMVP.LowerRightMVPBar, models.models.ex_skill_1.Gui.MVP.LowerMVP.LowerLeftMVPBar}) do
							modelPart:setScale(windowSize.x / 2, 1, 1)
						end
						models.models.ex_skill_1.Gui.MVP:setVisible(true)
					elseif tick == 157 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 3, true)
					elseif tick == 160 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 7, true)
					elseif tick == 167 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 2, true)
					elseif tick == 169 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 9, true)
					elseif tick == 178 then
						models.models.main.Avatar.UpperBody.Body.GlowEffects:setVisible(true)
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE_SMALL", 25, true)
						Bubble:play("V", 24, false)
						local playerPos = player:getPos()
						sounds:playSound("minecraft:entity.player.levelup", playerPos, 1, 1.5)
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 1, 1)
					end

					if tick >= 84 and tick < 100 then
						particles:newParticle("minecraft:splash", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Momoi.MomoiHead.ExSkillParticleAnchor14)):setPower(2)
					end
					if tick >= 55 and tick < 82 then
						self.exSkill.primary.spawnCoinParticles(self, 1)
					end
					if tick >= 98 and tick < 125 then
						self.exSkill.primary.spawnCoinParticles(self, 2)
					end
					if tick >= 116 and tick < 143 then
						self.exSkill.primary.spawnCoinParticles(self, 3)
					end
					if tick >= 156 and tick < 177 then
						local avatarPos = ModelUtils.getModelWorldPos(models.models.main.Avatar)
						for _ = 1, 5 do
							particles:newParticle("minecraft:end_rod", vectors.vec3(math.random() * 3 - 1.5, math.random() * 3, math.random() * 3 - 1.5):add(avatarPos)):setVelocity(0, 0.1, 0):setColor(1, 0.984, 0.4):setLifetime(16)
						end
					end

					if tick < 51 and math.random() >= 0.99 then
						sounds:playSound("minecraft:entity.pillager.ambient", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1), 0.5, 1)
					end
					if tick < 94 and math.random() >= 0.99 then
						sounds:playSound("minecraft:entity.pillager.ambient", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager2), 0.5, 1)
					end
					if tick < 112 and math.random() >= 0.99 then
						sounds:playSound("minecraft:entity.pillager.ambient", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager3), 0.5, 1)
					end
					if tick >= 35 and tick < 51 and math.random() >= 0.95 then
						sounds:playSound("minecraft:item.crossbow.shoot", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1), 0.5, 1)
					end
					if tick >= 80 and tick < 94 and math.random() >= 0.95 then
						sounds:playSound("minecraft:item.crossbow.shoot", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager2), 0.5, 1)
					end
					if tick >= 63 and tick < 112 and math.random() >= 0.95 then
						sounds:playSound("minecraft:item.crossbow.shoot", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager3), 0.5, 1)
					end
				end;

				onPostAnimation = function (self,forcedStop)
					if ModelAlias.alias.avatar.rightArmBottom.Gun ~= nil then
						ModelAlias.alias.avatar.gun:setVisible(false)
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					elseif ModelAlias.alias.avatar.leftArmBottom.Gun ~= nil then
						ModelAlias.alias.avatar.gun:setVisible(false)
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.leftArmBottom)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					end
					for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth}) do
						modelPart:setUVPixels()
					end
					models.models.main.Avatar.UpperBody.Body.GlowEffects:setVisible(false)
					for i = 1, 3 do
						if self.exSkill.primary.shouldReplaceEmerald[i] then
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."CoinAnchor"]["Pillager"..i.."Coin"]:setVisible(true)
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."CoinAnchor"]:getTask("ex_skill_1_coin_"..i.."_item"):setVisible(false)
						end
					end
					if forcedStop then
						models.models.ex_skill_1.Momoi:setColor()
						Bubble:stop()
					end
					if host:isHost() then
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.Reticules.MomoiReticule, models.models.ex_skill_1.Gui.UI.MomoiUI.LifeIcon1, models.models.ex_skill_1.Gui.UI.MomoiUI.LifeIcon2, models.models.ex_skill_1.Gui.UI.MomoiUI.LifeIcon3, models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes}) do
							modelPart:setVisible(true)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollBody.DeadEye, models.models.ex_skill_1.Gui.UI.ClearEffect.Background, models.models.ex_skill_1.Gui.UI.ClearEffect.ClearBar, models.models.ex_skill_1.Gui.MVP}) do
							modelPart:setVisible(false)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.RightEye, models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.LeftEye, models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Eyes.RightEye, models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Eyes.LeftEye, models.models.ex_skill_1.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Mouth}) do
							modelPart:setUVPixels()
						end
						models.models.ex_skill_1.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(16, 0)
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI, models.models.ex_skill_1.Gui.UI.MomoiHeadUI, }) do
							modelPart:setColor()
						end
						for i = 20, 24 do
							models.models.ex_skill_1.Gui.UI.MomoiUI.Bullets.RearBullets["Bullet"..i]:setColor(0.5, 0.5, 0.5)
						end
						for i = 19, 20 do
							models.models.ex_skill_1.Gui.UI.MidoriUI.MidoriBullets.MidoriRearBullets["BulletM"..i]:setColor(0.5, 0.5, 0.5)
						end
						for i = 1, 2 do
							models.models.ex_skill_1.Gui.UI.ClearEffect:getTask("ex_skill_1_clear_effect_text_"..i):setVisible(false)
						end
						models.models.ex_skill_1.Gui.UI.MomoiHeadUI:getTask("ex_skill_1_gameover_text"):setVisible(false)
						if forcedStop then
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.Reticules, models.models.ex_skill_1.Gui.UI}) do
								modelPart:setVisible(false)
							end
							for _, eventName in ipairs({"ex_skill_1_reticule_render", "ex_skill_1_damage_effect_render", "ex_skill_1_clear_effect_render"}) do
								events.RENDER:remove(eventName)
							end
							Character05b_ExSkill1TransitionManager:stop()
						end
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---コインをエメラルドに置き換えるかどうか
			---@type boolean[]
			shouldReplaceEmerald = {false, false, false};

			---銃弾のパーティクルを出す。
			---@param anchor ModelPart パーティクルを出す場所を示すアンカーポイント
			---@param offsetRotX number パーティクルの射出方向のX軸オフセット値
			---@param offsetRotY number パーティクルの射出方向のY軸オフセット値
			---@param whoShot Character05b.ExSkill2ShotByType 射撃した人を指定する。
			spawnBulletParticle = function (anchor, offsetRotX, offsetRotY, whoShot)
				local anchorPos = ModelUtils.getModelWorldPos(anchor)
				local bodyYaw = player:getBodyYaw()
				for _ = 1, 5 do
					particles:newParticle("minecraft:electric_spark", anchorPos):setScale(1):setVelocity( vectors.rotateAroundAxis(bodyYaw * -1 + offsetRotY, vectors.rotateAroundAxis(offsetRotX, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, 0.1, 1, 0, 0), 0, 1, 0)):setColor(0.98, 0.843, 0.341):setLifetime(2)
				end
				local muzzleAnchorPos =  ModelUtils.getModelWorldPos(whoShot == "MIDORI" and ModelAlias.alias.avatar.muzzleAnchor or models.models.ex_skill_1.Momoi.MomoiUpperBody.MomoiArms.MomoiRightArm.MomoiRightArmBottom.Gun.MuzzleAnchor)

				for _ = 1, 5 do
					particles:newParticle("minecraft:smoke", muzzleAnchorPos)
				end
			end;

			---射撃音を再生する。
			playShotSound = function ()
				sounds:playSound("minecraft:entity.firework_rocket.blast", ModelUtils.getModelWorldPos(host:isHost() and models.models.main.CameraAnchor or models.models.main.Avatar), 1, math.random() * 0.25 + 0.5)
			end;

			---コインのパーティクルを発生させる。
			---@param self Character05b
			---@param index integer 出現先のコインを指定するインデックス番号
			spawnCoinParticles = function (self, index)
				local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers["Pillager"..index]["Pillager"..index.."CoinAnchor"])
				for _ = 1, 3 do
					particles:newParticle("minecraft:end_rod", vectors.vec3(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5):add(anchorPos)):setVelocity(0, 0.1, 0):setColor(self.exSkill.primary.shouldReplaceEmerald[index] and vectors.vec3(0.686, 0.992, 0.804) or vectors.vec3(1, 0.984, 0.4)):setLifetime(8)
				end
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
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE_SMALL", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED_SMALL", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "CLOSED", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SHOCK", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("ANGRY", "TIRED", "FRUST", duration, true)
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
			end
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {models.models.main.Avatar.UpperBody.Body.TailXPivot};

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
				models = {models.models.main.Avatar.UpperBody.Body.TailXPivot.TailYPivot};

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
				models = {ModelAlias.alias.avatar.head.HairTail};

				x = {
					vertical = {
						min = -140;
						neutral = 0;
						max = 0;

						headRotMultiplayer = -1;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -140;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTail.HairTailZPivot};

				z = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						bodyZ = {
							multiplayer = -80;
							min = -90;
							max = 90;
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
			onPhysicPerformed = function (self, model)
				local playerPose = player:getPose()
				local isHorizontal = playerPose == "SWIMMING" or playerPose == "FALL_FLYING"
				if (model == ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomRight or model == ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomLeft) and isHorizontal then
					model:setRot(model:getRot():scale(1 - math.clamp(Physics.velocityAverage[5][2], 0, 1.6) / 1.6))
				end
			end;
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---Exスキルで使用するパーティクルインスタンスのクラス
		---@type Character05b.ExSkill1Particle
		Character05b_ExSkill1Particle = require("scripts.ex_skill_1_particle")

		---Exスキルで使用するパーティクルマネージャーのクラス
		---@type Character05b.ExSkill1ParticleManager
		Character05b_ExSkill1ParticleManager = require("scripts.ex_skill_1_particle_manager")
		Character05b_ExSkill1ParticleManager = Character05b_ExSkill1ParticleManager.new()

		---Exスキルで使用するトランジションインスタンスのクラス
		---@type Character05b.ExSkill1TransitionSprite
		Character05b_ExSkill1TransitionSprite = require("scripts.ex_skill_1_transition")

		---Exスキルで使用するトランジションマネージャーのクラス
		---@type Character05b.ExSkill1TransitionManager
		Character05b_ExSkill1TransitionManager = require("scripts.ex_skill_1_transition_manager")
		Character05b_ExSkill1TransitionManager = Character05b_ExSkill1TransitionManager.new()

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
					models.models.main.Avatar.LowerBody.Legs:setVisible(false)
					ModelAlias.alias.avatar.body.Skirt1:setRot()
					ModelAlias.alias.avatar.body.Skirt1:setScale(1.5, 0.35, 1.5)
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt1.Skirt2, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3.Skirt4}) do
						modelPart:setScale()
					end
				elseif not shouldHideLegs and shouldHideLegsPrev then
					models.models.main.Avatar.LowerBody.Legs:setVisible(true)
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
