---右目のテクスチャの列挙型
---@alias Character24b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "ANGRY" # 怒った目
---| "CENTER" # 少し反対側を見る目

---左目のテクスチャの列挙型
---@alias Character24b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "INVERTED" # 反対側を見る目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "ANGRY" # 怒った目
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目

---口のテクスチャの列挙型
---@alias Character24b.MouthTextures
---| "NORMAL" # 通常
---| "TRIANGLE" # 三角口
---| "HAT" # への口
---| "HAPPY" # 幸せのぐじゅぐじゅ口
---| "SMALL" # 小さく開いた口
---| "OPENED" # 開いた口

---@class (exact) Character24b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character24b.RightEyeTextures 右目の表情名
---@field public leftEye Character24b.LeftEyeTextures 左目の表情名
---@field public mouth Character24b.MouthTextures 口の表情名

---@class (exact) Character24b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character24b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character24b.EmotionSet ベッドで寝ているとき

---@class (exact) Character24b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character24b, right: Character24b.RightEyeTextures, left: Character24b.LeftEyeTextures, mouth: Character24b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character24b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character24b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character24b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character24b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character24b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character24b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character24b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character24b.FacePartsStruct 目や口による表情

---@type Character24b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "24b_Natsu_Band";

		birth = {
			month = 12;
			day = 4;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(6, 0);
			ANGRY = vectors.vec2(8, 0);
			CENTER = vectors.vec2(12, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CENTER = vectors.vec2(4, 0);
			CLOSED2 = vectors.vec2(5, 0);
			INVERTED = vectors.vec2(6, 0);
			ANGRY_INVERTED = vectors.vec2(8, 0);
			ANGRY = vectors.vec2(9, 0);
			ANGRY_CENTER = vectors.vec2(10, 0);
		};

		mouth = {
			TRIANGLE = vectors.vec2(0, 0);
			HAT = vectors.vec2(1, 0);
			HAPPY = vectors.vec2(2, 0);
			SMALL = vectors.vec2(3, 0);
			OPENED = vectors.vec2(4, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				if right == "GUN_MAIN_HAND" and left == "GUN_OFF_HAND" then
					local isLeftHanded = player:isLeftHanded()
					if (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem().id == "minecraft:shield" and isLeftHanded) then
						return {right = "GUN_MAIN_HAND", left = "SHIELD_HAND"}
					end
				elseif right == "GUN_OFF_HAND" and left == "GUN_MAIN_HAND" then
					local isLeftHanded = player:isLeftHanded()
					if (player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded) then
						return {right = "SHIELD_HAND", left = "GUN_MAIN_HAND"}
					end
				end
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded)) and Arms.armState.right == "GUN_OFF_HAND" then
							Arms:setArmState("SHIELD_HAND", nil)
						end
					end, "right_arm_tick")
					Arms:registerRightArmRenderEvent("GUN_OFF_HAND")
					return true
				elseif state == "SHIELD_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id ~= "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id ~= "minecraft:shield" and isLeftHanded)) and Arms.armState.right == "SHIELD_HAND" then
							Arms:setArmState("GUN_OFF_HAND", nil)
						end
					end, "right_arm_tick")
					events.RENDER:register(function (delta, context)
						local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
						ModelAlias.alias.avatar.rightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 40, 30, 0))
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id == "minecraft:shield" and isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded)) and Arms.armState.left == "GUN_OFF_HAND" then
							Arms:setArmState(nil, "SHIELD_HAND")
						end
					end, "left_arm_tick")
					Arms:registerLeftArmRenderEvent("GUN_OFF_HAND")
					return true
				elseif state == "SHIELD_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id ~= "minecraft:shield" and isLeftHanded) or (player:getHeldItem(true).id ~= "minecraft:shield" and not isLeftHanded)) and Arms.armState.left == "SHIELD_HAND" then
							Arms:setArmState(nil, "GUN_OFF_HAND")
						end
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
						ModelAlias.alias.avatar.leftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5 + 40, -30, 0))
					end, "left_arm_render")
				end;
			end;
		};
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 0.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, -6, -2.5);
					left = vectors.vec3(0, -6, -2.5);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.5, -7, -2.5);
					left = vectors.vec3(1.3, -7, -2.5);
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

			models = {models.models.ex_skill_1.Drum, models.models.ex_skill_1.KeyBoard, models.models.ex_skill_1.Airi, models.models.ex_skill_1.Yoshimi, models.models.ex_skill_1.Kazusa, models.models.ex_skill_1.Mic, models.models.ex_skill_1.Stage, models.models.ex_skill_1.PenLights, models.models.ex_skill_1.Gui, ModelAlias.alias.avatar.head.Sweats, ModelAlias.alias.avatar.rightArmBottom.RightStickPivot, ModelAlias.alias.avatar.leftArmBottom.LeftStickPivot};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(30, 180, 0);
					pos = vectors.vec3(0, 113.2, -129);
				};

				fin = {
					rot = vectors.vec3(-10, 180, 0);
					pos = vectors.vec3(0, 83.7, -8);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.Drum.DrumChair.ChairTop:setPrimaryTexture("RESOURCE", "textures/block/black_wool.png")
						for _, modelPart in ipairs({models.models.ex_skill_1.Stage.StageTop, models.models.ex_skill_1.Stage.StageBottom}) do
							modelPart:setPrimaryTexture("RESOURCE", "textures/block/gray_concrete.png")
						end

						for i, modelPart in ipairs({ModelAlias.alias.avatar.rightArmBottom.RightStickPivot, ModelAlias.alias.avatar.leftArmBottom.LeftStickPivot}) do
							modelPart:newItem("ex_skill_item_" .. i)
								:setItem("minecraft:stick")
						end
						models.models.ex_skill_1.KeyBoard:newBlock("ex_skill_block_1")
							:setBlock("minecraft:note_block")
							:setPos(-28, 0, -8)
							:setRot(0, 0, 0)
							:setScale(0.75, 0.75, 0.75)

						local penLightColors = {vectors.vec3(1, 0.855, 0.584), vectors.vec3(0.698, 1, 0.97), vectors.vec3(0.81, 1, 0.698)}
						for i = 1, 100 do
							local model = models.models.ex_skill_1.PenLights["PenLight"..i]
							if model == nil then
								model = ModelUtils:copyModel(models.models.ex_skill_1.PenLights.PenLight1, "PenLight" .. i, true)
								models.models.ex_skill_1.PenLights:addChild(model)
							end
							model.PenLightEmissive:setColor(penLightColors[math.floor(math.random() * 3) + 1])
						end

						self.exSkill.primary.copyDrumHitCircle(models.models.ex_skill_1.Drum.BaseDrum.Tam.SmallTam.SmallTamCore.SmallTamEffects.SmallTamEffect1, models.models.ex_skill_1.Drum.BaseDrum.Tam.SmallTam.SmallTamCore.SmallTamEffects.SmallTamEffect2)
						self.exSkill.primary.copyDrumHitCircle(models.models.ex_skill_1.Drum.BaseDrum.Tam.BigTam.BigTamCore.BigTamEffects.BigTamEffect1, models.models.ex_skill_1.Drum.BaseDrum.Tam.BigTam.BigTamCore.BigTamEffects.BigTamEffect2)

						if host:isHost() then
							local baseModel = models.models.ex_skill_1.Gui.ScreenCircleBase
							for _, corner in ipairs({"TL", "TR", "BL", "BR"}) do
								for i = 1, 2 do
									models.models.ex_skill_1.Gui.ScreenCircle["ScreenCircle" .. corner]:addChild(baseModel:copy("ScreenCircle" .. corner .. i))
								end
							end
							models.models.ex_skill_1.Gui:removeChild(baseModel)
							baseModel:remove()
						end

						self.exSkill.primary.isInitialized = true
					end

					for i = 1, 100 do
						models.models.ex_skill_1.PenLights["PenLight"..i]:setPos(math.map(math.random(), 0, 1, -320, 320), 32, math.map(math.random(), 0, 1, -400, -125))
						self.exSkill.primary.penLightSwingOffsets[i] = math.random()
					end

					if host:isHost() then
						local windowSize = client:getScaledWindowSize()
						models.models.ex_skill_1.Gui.ScreenFilter:setScale(windowSize:copy():augmented(1))
						models.models.ex_skill_1.Gui.ScreenCircle.ScreenCircleTL:setPos(-20, -20, 0)
						models.models.ex_skill_1.Gui.ScreenCircle.ScreenCircleTR:setPos(windowSize.x * -1 + 20, -20, 0)
						models.models.ex_skill_1.Gui.ScreenCircle.ScreenCircleBL:setPos(-20, windowSize.y * -1 + 20, 0)
						models.models.ex_skill_1.Gui.ScreenCircle.ScreenCircleBR:setPos(windowSize.x * -1 + 20, windowSize.y * -1 + 20, 0)

						for _, corner in ipairs({"TL", "TR", "BL", "BR"}) do
							for i = 1, 2 do
								models.models.ex_skill_1.Gui.ScreenCircle["ScreenCircle" .. corner]["ScreenCircle" .. corner .. i]:setColor(self.exSkill.primary.EFFECT_COLOR_PALETTE[math.floor(math.random(1, #self.exSkill.primary.EFFECT_COLOR_PALETTE))])
							end
						end
					end

					for _, modelPart in ipairs(models.models.ex_skill_1.Stage.StageEmissives:getChildren()) do
						modelPart:setColor(self.exSkill.primary.EFFECT_COLOR_PALETTE[math.floor(math.random(1, #self.exSkill.primary.EFFECT_COLOR_PALETTE))])
					end

					self.exSkill.primary.KazusaMouthChangeCount = math.random(2, 6)
					FaceParts:setEmotion("CENTER", "NORMAL", "SMALL", 11, true)

					events.RENDER:register(function (delta)
						for i = 1, 100 do
							models.models.ex_skill_1.PenLights["PenLight"..i]:setRot(0, 0, math.sin((self.exSkill.primary.penLightSwingOffsets[i] + delta * 0.1) * 2 * math.pi) * 40)
						end

						if host:isHost() then
							models.models.ex_skill_1.Gui.ScreenFilter:setOpacity(models.models.ex_skill_1.Gui.FilterOpacity:getAnimScale().x)

							local windowSize = client:getScaledWindowSize()
							local circleScale = math.sqrt(math.pow(windowSize.x, 2) + math.pow(windowSize.y, 2)) * 2
							for _, corner in ipairs({"TL", "TR", "BL", "BR"}) do
								for i = 1, 2 do
									models.models.ex_skill_1.Gui.ScreenCircle["ScreenCircle" .. corner]["ScreenCircle" .. corner .. i]:setScale(vectors.vec3(1, 1, 1):scale(models.models.ex_skill_1.Gui.ScreenCircle["ScreenCircle" .. corner]["ScreenCircle" .. corner .. i .. "Scale"]:getAnimScale().x * circleScale))
								end
							end
						end
					end, "ex_skill_1_render")
				end;

				onAnimationTick = function (self, tick)
					if tick == 4 then
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.RightEye:setUVPixels(12, 0)
					elseif tick == 9 then
						models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.LeftEye:setUVPixels(6, 0)
					elseif tick == 11 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMALL", 8, true)
					elseif tick == 12 then
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.RightEye:setUVPixels()
					elseif tick == 19 then
						FaceParts:setEmotion("NORMAL", "CENTER", "SMALL", 11, true)
					elseif tick == 22 then
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.LeftEye:setUVPixels(12, 0)
					elseif tick == 24 then
						models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.RightEye:setUVPixels(18, 0)
						models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.LeftEye:setUVPixels()
					elseif tick == 30 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAT", 5, true)
					elseif tick == 35 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMALL", 8, true)
					elseif tick == 42 then
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.LeftEye:setUVPixels()
					elseif tick == 43 then
						FaceParts:setEmotion("CENTER", "NORMAL", "SMALL", 10, true)
					elseif tick == 44 then
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.RightEye:setUVPixels(12, 0)
					elseif tick == 51 then
						models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.RightEye:setUVPixels()
					elseif tick == 52 then
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.RightEye:setUVPixels()
						self.exSkill.primary.emitDrumHitParticles(ModelUtils.getModelWorldPos(models.models.ex_skill_1.Drum.Cymbal2.Cymbal2Shaft2.Cymbal2Axis.Cymbal2Core))
					elseif tick == 53 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMALL", 22, true)
					elseif tick == 72 then
						models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.RightEye:setUVPixels(18, 0)
					elseif tick == 75 then
						FaceParts:setEmotion("NORMAL", "CENTER", "SMALL", 6, true)
					elseif tick == 77 then
						self.exSkill.primary.emitDrumHitParticles(ModelUtils.getModelWorldPos(models.models.ex_skill_1.Drum.Cymbal1.Cymbal1Shaft2.Cymbal1Axis.Cymbal1Core))
					elseif tick == 81 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMALL", 2, true)
					elseif tick == 83 then
						FaceParts:setEmotion("CENTER", "NORMAL", "SMALL", 2, true)
					elseif tick == 85 then
						FaceParts:setEmotion("CENTER", "NORMAL", "TRIANGLE", 7, true)
					elseif tick == 89 then
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.RightEye:setUVPixels(24, 0)
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.LeftEye:setUVPixels(18, 0)
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.Mouth:setUVPixels(16, 0)
					elseif tick == 91 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.RightEye, models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.LeftEye}) do
							modelPart:setUVPixels()
						end
					elseif tick == 92 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "TRIANGLE", 8, true)
					elseif tick == 93 then
						models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.RightEye:setUVPixels()
						models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.LeftEye:setUVPixels(6, 0)
					elseif tick == 100 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TRIANGLE", 7, true)
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.RightEye:setUVPixels(24, 0)
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.LeftEye:setUVPixels(18, 0)
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.Mouth:setUVPixels()
						models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.KazusaEyes.RightEye:setUVPixels(12, 0)
						models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.KazusaEyes.LeftEye:setUVPixels(6, 0)
						models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.Mouth:setUVPixels(16, 0)
					elseif tick == 105 then
						models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.RightEye:setUVPixels(24, 0)
						models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.LeftEye:setUVPixels(18, 0)
					elseif tick == 107 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 11, true)
					elseif tick == 118 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAT", 47, true)
					elseif tick == 120 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.RightEye, models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.LeftEye}) do
							modelPart:setUVPixels()
						end
					elseif tick == 134 then
						models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.KazusaEyes.LeftEye:setUVPixels(12, 0)
						for _, modelPart in ipairs({models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.KazusaEyes.RightEye, models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.Mouth}) do
							modelPart:setUVPixels()
						end
					elseif tick == 152 then
						models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.KazusaEyes.LeftEye:setUVPixels()
					elseif tick == 165 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "TRIANGLE", 46, true)
					elseif tick == 166 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.RightEye, models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.LeftEye}) do
							modelPart:setUVPixels()
						end
						models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.Mouth:setUVPixels(16, 0)
						models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.Mouth:setUVPixels(32, 0)
					elseif tick == 168 then
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.RightEye:setUVPixels(24, 0)
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.LeftEye:setUVPixels(18, 0)
						models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.Mouth:setUVPixels(32, 0)
					elseif tick == 169 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head):copy():add(0, 0.25, 0)
						local bodyYaw = player:getBodyYaw()
						for i = 0, 11 do
							particles:newParticle("minecraft:end_rod", anchorPos)
								:setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 30, 0, 0.075, 0, 0, 0, 1), 0, 1, 0))
								:setColor(0.988, 1.000, 0.667)
						end
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 1)
					end

					if tick < 100 then
						if self.exSkill.primary.KazusaMouthChangeCount == 0 then
							self.exSkill.primary.KazusaMouthSate = (self.exSkill.primary.KazusaMouthSate + 1) % 2
							models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.Mouth:setUVPixels(16 * self.exSkill.primary.KazusaMouthSate, 0)

							self.exSkill.primary.KazusaMouthChangeCount = math.random(2, 6)
						else
							self.exSkill.primary.KazusaMouthChangeCount = self.exSkill.primary.KazusaMouthChangeCount - 1
						end
					end

					if (tick >= 13 and tick <= 19 and (tick - 13) % 3 == 0) or (tick >= 27 and tick <= 48 and (tick - 27) % 3 == 0) or tick == 65 or tick == 68 or tick == 70 or tick == 71 or tick == 76 or tick == 103 then
						models.models.ex_skill_1.Drum.BaseDrum.Tam.SmallTam.SmallTamCore.SmallTamEffects["SmallTamEffect" .. ((tick == 13 or tick == 19 or (tick >= 30 and tick <= 48 and (tick - 30) % 3 == 0) or tick == 68 or tick == 71 or tick == 103) and 1 or 2)]:setColor(self.exSkill.primary.EFFECT_COLOR_PALETTE[math.random(1, #self.exSkill.primary.EFFECT_COLOR_PALETTE)])
						self.exSkill.primary.emitDrumHitParticles(ModelUtils.getModelWorldPos(models.models.ex_skill_1.Drum.BaseDrum.Tam.SmallTam.SmallTamCore.SmallTamEffects))
					end
					if (tick <= 10 and tick % 3 <= 1) or (tick >= 14 and tick <= 23 and (tick - 14) % 3 == 0) or (tick >= 37 and tick <= 46 and (tick - 37) % 3 == 0) or tick == 52 or tick == 55 or tick == 58 or tick == 60 or tick == 61 or tick == 63 or tick == 66 or tick == 103 then
						models.models.ex_skill_1.Drum.BaseDrum.Tam.BigTam.BigTamCore.BigTamEffects["BigTamEffect" .. (((tick <= 9 and tick % 3 == 0) or tick == 14 or tick == 20 or tick == 37 or tick == 43 or tick == 52 or tick == 58 or tick == 61 or tick == 66) and 1 or 2)]:setColor(self.exSkill.primary.EFFECT_COLOR_PALETTE[math.random(1, #self.exSkill.primary.EFFECT_COLOR_PALETTE)])
						self.exSkill.primary.emitDrumHitParticles(ModelUtils.getModelWorldPos(models.models.ex_skill_1.Drum.BaseDrum.Tam.BigTam.BigTamCore.BigTamEffects))
					end
					if tick == 26 or tick == 29 or tick == 32 then
						models.models.ex_skill_1.Drum.SnareDrum.SnareDrumCore.SnareDrumEffect:setColor(self.exSkill.primary.EFFECT_COLOR_PALETTE[math.random(1, #self.exSkill.primary.EFFECT_COLOR_PALETTE)])
						self.exSkill.primary.emitDrumHitParticles(ModelUtils.getModelWorldPos(models.models.ex_skill_1.Drum.SnareDrum.SnareDrumCore.SnareDrumEffect))
					end

					for i = 1, 100 do
						self.exSkill.primary.penLightSwingOffsets[i] = self.exSkill.primary.penLightSwingOffsets[i] + 0.1
						self.exSkill.primary.penLightSwingOffsets[i] = self.exSkill.primary.penLightSwingOffsets[i] > 1 and self.exSkill.primary.penLightSwingOffsets[i] - 1 or self.exSkill.primary.penLightSwingOffsets[i]
					end

					if tick % 8 == 0 then
						sounds:playSound("minecraft:weather.rain", player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 1, 8, 0, 1, 0)), 0.5, 1.5)
					end

					for _, modelPart in ipairs(models.models.ex_skill_1.Stage.StageEmissives:getChildren()) do
						particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(modelPart))
							:setScale(1.2)
							:setVelocity(math.random() * 0.5 - 0.25, 1, math.random() * 0.5 - 0.25)
							:setColor(self.exSkill.primary.EFFECT_COLOR_PALETTE[math.random(1, #self.exSkill.primary.EFFECT_COLOR_PALETTE)])
							:setGravity(0.25)
							:setLifetime(80 + math.random() * 40)
					end
				end;

				onPostAnimation = function (self)
					events.RENDER:remove("ex_skill_1_render")
					for _, modelPart in ipairs({models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.RightEye, models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.AiriEyes.LeftEye, models.models.ex_skill_1.Airi.AiriHead.AiriFaceParts.Mouth, models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.RightEye, models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.YoshimiEyes.LeftEye, models.models.ex_skill_1.Yoshimi.YoshimiHead.YoshimiFaceParts.Mouth, models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.KazusaEyes.RightEye, models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.KazusaEyes.LeftEye, models.models.ex_skill_1.Kazusa.KazusaHead.KazusaFaceParts.Mouth}) do
						modelPart:setUVPixels()
					end

					self.exSkill.primary.KazusaMouthChangeCount = 0
					self.exSkill.primary.KazusaMouthSate = 0
					self.exSkill.primary.penLightSwingOffsets = {}
				end;
			};

			---Exスキル内のエフェクトで使用するカラーパレット
			---@type Vector3[]
			EFFECT_COLOR_PALETTE = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)};

			---このExスキルが初期化されたかどうか。
			---@type boolean
			isInitialized = false;

			---カズサの口を変化させるまでのカウンター
			---@type integer
			KazusaMouthChangeCount = 0;

			---カズサの口の状態
			---@type integer
			KazusaMouthSate = 0;

			---ペンライトの振り時間のオフセット値
			---@type number[]
			penLightSwingOffsets = {};

			---ドラムをスティックでヒットさせたときのサークルエフェクトをコピーする。
			---@param srcGroup ModelPart コピー元のモデルグループ
			---@param destGroup ModelPart コピー先のモデルグループ
			copyDrumHitCircle = function (srcGroup, destGroup)
				for _, modelPart in ipairs(srcGroup:getChildren()) do
					destGroup:addChild(modelPart:copy(modelPart:getName()))
				end
			end;

			---ドラムをスティックでヒットさせたときのパーティクルを再生する。
			emitDrumHitParticles = function (pos)
				for _ = 1, 5 do
					particles:newParticle("minecraft:electric_spark", pos:copy():add(math.random() * 0.4 - 0.2, 0, math.random() * 0.4 - 0.2))
						:setScale(0.25)
						:setVelocity(math.random() * 0.2 - 0.1, 0.1 + math.random() * 0.1, math.random() * 0.2 - 0.1)
						:setColor(0.984, 0.840, 0.435)
						:setLifetime(2)
				end
			end;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.FrontHair:setPos(0, 0, isVisible and -1 or 0)
					ModelAlias.alias.avatar.leftArm.Clothespin:setVisible(not isVisible)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", duration, true)
					ModelAlias.alias.avatar.faceParts.Eyes.EyeShines:setVisible(true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAPPY", duration, true)
					ModelAlias.alias.avatar.rightEye:setRot(0, 0, -5)
					ModelAlias.alias.avatar.leftEye:setRot(0, 0, 5)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAT", duration, true)
				end
			end;

			onStop = function(_, _, forcedStop)
				ModelAlias.alias.avatar.faceParts.Eyes.EyeShines:setVisible(false)
				for _, modelPart in ipairs({ModelAlias.alias.avatar.rightEye, ModelAlias.alias.avatar.leftEye}) do
					modelPart:setRot()
				end
				if forcedStop then
					FaceParts:resetEmotion()
				end
			end;
		};
	};

	headModel = {

	};

	headBlock = {
		includeModels = {ModelAlias.alias.avatar.body.FrontHair};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.HairBun.HairBunBottom:setRot(30, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairBun.HairBunBottom:setRot(-20, 0, -5)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.Cowlick};

				x = {
					vertical = {
						min = -82.5;
						neutral = -57.5;
						max = -27.5;

						bodyY = {
							multiplayer = -40;
							min = -82.5;
							max = -27.5;
						};
					};

					horizontal = {
						min = -82.5;
						neutral = -67.5;
						max = -27.5;

						bodyX = {
							multiplayer = -80;
							min = -82.5;
							max = -27.5;
						};
					};
				};

				y = {
					vertical = {
						min = -30;
						neutral = -30;
						max = -30;
					};

					horizontal = {
						min = -30;
						neutral = -30;
						max = -30;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairBun.HairBunBottom};

				x = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 90;
						};
					};

					horizontal = {
						min = -45;
						neutral = 45;
						max = 90;

						headX = {
							multiplayer = -80;
							min = -45;
							max = 90;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairBun.HairBunBottom.HairBunBottomZPivot};

				z = {
					vertical = {
						min = -170;
						neutral = 0;
						max = 12.5;

						headZ = {
							multiplayer = -80;
							min = -170;
							max = 12.5;
						};

						headRot = {
							multiplayer = 0.05;
							min = -170;
							max = 0;
						};

						bodyY = {
							multiplayer = 40;
							min = -170;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.FrontHair};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 80;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 80;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 80;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 80;
						};
					};

					horizontal = {
						min = 0;
						neutral = 80;
						max = 80;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 80;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		ModelAlias.alias.avatar.gun.Cake:newItem("gun_cake_strap")
			:setItem("minecraft:cake")
			:setScale(0.19)

		events.ITEM_RENDER:register(function (item, mode)
			if item.id == "minecraft:shield" then
                if mode == "FIRST_PERSON_LEFT_HAND" then
                    local leftHanded = player:isLeftHanded()
                    if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "OFF_HAND" and not leftHanded) or (player:getActiveHand() == "MAIN_HAND" and leftHanded)) then
                        models.models.shield_item.Item:setPos(5, -14, -1)
                        models.models.shield_item.Item:setRot(0, 0, -5)
                    else
                        models.models.shield_item.Item:setPos(4, -16, 1)
                        models.models.shield_item.Item:setRot(0, 0, 5)
                    end
                elseif mode == "FIRST_PERSON_RIGHT_HAND" then
                    local leftHanded = player:isLeftHanded()
                    if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "MAIN_HAND" and not leftHanded) or (player:getActiveHand() == "OFF_HAND" and leftHanded)) then
                        models.models.shield_item.Item:setPos(-5, -12.5, -1)
                        models.models.shield_item.Item:setRot(0, 0, 5)
                    else
                        models.models.shield_item.Item:setPos(-4, -16, 1)
                        models.models.shield_item.Item:setRot(0, 0, -5)
                    end
				elseif mode == "THIRD_PERSON_LEFT_HAND" then
                    if Arms.armState.left == "SHIELD_HAND" then
                        if player:isCrouching() then
                            models.models.shield_item.Item:setPos(0, -11, 0)
                            models.models.shield_item.Item:setRot(80, 5, 30)
                        else
                            models.models.shield_item.Item:setPos(0, -12, -2)
                            models.models.shield_item.Item:setRot(55, 20, 25)
                        end
                    else
						local leftHanded = player:isLeftHanded()
						if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "OFF_HAND" and not leftHanded) or (player:getActiveHand() == "MAIN_HAND" and leftHanded)) then
							models.models.shield_item.Item:setPos(0, -13, -1)
							models.models.shield_item.Item:setRot(40, 20, 15)
						else
							models.models.shield_item.Item:setPos(-1, -13, 2)
							models.models.shield_item.Item:setRot(0, 80, 0)
						end
					end
				elseif mode == "THIRD_PERSON_RIGHT_HAND" then
                    if Arms.armState.right == "SHIELD_HAND" then
                        if player:isCrouching() then
                            models.models.shield_item.Item:setPos(0, -11, 0)
                            models.models.shield_item.Item:setRot(80, -5, -30)
                        else
                            models.models.shield_item.Item:setPos(0, -12, -2)
                            models.models.shield_item.Item:setRot(55, -20, -25)
                        end
                    else
						local leftHanded = player:isLeftHanded()
						if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "MAIN_HAND" and not leftHanded) or (player:getActiveHand() == "OFF_HAND" and leftHanded)) then
							models.models.shield_item.Item:setPos(0, -13, -1)
							models.models.shield_item.Item:setRot(40, -20, -15)
						else
							models.models.shield_item.Item:setPos(1, -13, 2)
							models.models.shield_item.Item:setRot(0, -80, 0)
						end
                    end
				end

				return models.models.shield_item.Item
			end
		end)
	end;
}

return BlueArchiveCharacter
