---右目のテクスチャの列挙型
---@alias Character07b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "INVERTED" # 反対側を見る目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "NARROW" # 半閉じ目

---左目のテクスチャの列挙型
---@alias Character07b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "INVERTED" # 反対側を見る目
---| "CENTER" # 少し反対側を見る目
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "NARROW" # 半閉じ目

---口のテクスチャの列挙型
---@alias Character07b.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "CLOSED" # 閉じた口
---| "W" # ω
---| "YAWN" あくび
---| "OUT_OF_BREATH" # 息切れ口
---| "TEETH" 食いしばる口
---| "SAD" # への口

---キャラクター固有の腕の状態
---@alias Character07b.AdditionalArmState
---| "SHIELD_HAND" # 盾を持つ腕の状態
---| "WHALE_FLOAT" # クジラフロートに乗っているときの腕の状態

---@class (exact) Character07b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character07b.RightEyeTextures 右目の表情名
---@field public leftEye Character07b.LeftEyeTextures 左目の表情名
---@field public mouth Character07b.MouthTextures 口の表情名

---@class (exact) Character07b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character07b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character07b.EmotionSet ベッドで寝ているとき

---@class (exact) Character07b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character07b, right: Character07b.RightEyeTextures, left: Character07b.LeftEyeTextures, mouth: Character07b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character07b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character07b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character07b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character07b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character07b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character07b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character07b.ArmsCallbacksSet : BlueArchiveCharacter.ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(self: Character07b, right: Arms.BaseArmState|Character07b.AdditionalArmState, left: Arms.BaseArmState|Character07b.AdditionalArmState): {right?: Arms.BaseArmState|Character07b.AdditionalArmState, left?: Arms.BaseArmState|Character07b.AdditionalArmState}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(self: Character07b, state: Arms.BaseArmState|Character07b.AdditionalArmState): boolean? 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: Character07b, state: Arms.BaseArmState|Character07b.AdditionalArmState): boolean? 左腕の追加処理

---@class (exact) Character07b.ArmsStruct : BlueArchiveCharacter.ArmsStruct 腕のデータ構造体
---@field public callbacks? Character07b.ArmsCallbacksSet 腕の制御のコールバック関数群

---@class (exact) Character07b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character07b.FacePartsStruct 目や口による表情
---@field public arms Character07b.ArmsStruct 腕

---@type Character07b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "07b_Hoshino_Swimsuit";

		birth = {
			month = 1;
			day = 2;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(6, 0); --必須
			CENTER = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(10, 0);
			INVERTED = vectors.vec2(11, 0);
			ANGRY_INVERTED = vectors.vec2(12, 0);
			NARROW = vectors.vec2(14, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(5, 0); --必須
			CENTER = vectors.vec2(7, 0);
			ANGRY_CENTER = vectors.vec2(8, 0);
			ANGRY_INVERTED = vectors.vec2(12, 0);
			CLOSED2 = vectors.vec2(9, 0);
			NARROW = vectors.vec2(14, 0);
			INVERTED = vectors.vec2(15, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(1, 0);
			W = vectors.vec2(2, 0);
			YAWN = vectors.vec2(3, 0);
			OPENED = vectors.vec2(0, 0);
			OUT_OF_BREATH = vectors.vec2(4, 0);
			TEETH = vectors.vec2(5, 0);
			SAD = vectors.vec2(6, 0);
		};

		emotionSet = {
			onSleep = {
				rightEye = "CLOSED";
				leftEye = "CLOSED";
				mouth = "YAWN";
			};
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				if events.TICK:getRegisteredCount("ex_skill_1_waving_tick") > 0 then
					return {right = "DEFAULT", left = "DEFAULT"}
				elseif WhaleFloat ~= nil and right == "DEFAULT" and left == "DEFAULT" then
					return {right = "WHALE_FLOAT", left = "WHALE_FLOAT"}
				elseif right == "GUN_MAIN_HAND" and left == "GUN_OFF_HAND" then
					local isLeftHanded = player:isLeftHanded()
					if (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem().id == "minecraft:shield" and isLeftHanded) then
						return {right = "GUN_MAIN_HAND", left = "SHIELD_HAND"}
					elseif WhaleFloat.isAFK then
						return {right = "DEFAULT", left = "DEFAULT"}
					end
				elseif right == "GUN_OFF_HAND" and left == "GUN_MAIN_HAND" then
					local isLeftHanded = player:isLeftHanded()
					if (player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded) then
						return {right = "SHIELD_HAND", left = "GUN_MAIN_HAND"}
					elseif WhaleFloat.isAFK then
						return {right = "DEFAULT", left = "DEFAULT"}
					end
				end
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "GUN_MAIN_HAND" then
					Arms:registerRightArmTickEvent("GUN_MAIN_HAND")
					Arms:registerRightArmRenderEvent("GUN_MAIN_HAND")
					events.RENDER:register(function ()
						if WhaleFloat.whaleFloatEnabled then
							ModelAlias.alias.avatar.rightArm:setRot(ModelAlias.alias.avatar.rightArm:getRot():add(10, 0, 0))
						end
					end, "right_arm_render")
					return true
				elseif state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded)) and Arms.armState.right == "GUN_OFF_HAND" then
							Arms:setArmState("SHIELD_HAND", nil)
						end
					end, "right_arm_tick")
					Arms:registerRightArmRenderEvent("GUN_OFF_HAND")
					events.RENDER:register(function ()
						if WhaleFloat.whaleFloatEnabled then
							ModelAlias.alias.avatar.rightArm:setRot(ModelAlias.alias.avatar.rightArm:getRot():add(10, 0, 0))
						end
					end, "right_arm_render")
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
				if state == "GUN_MAIN_HAND" then
					Arms:registerLeftArmTickEvent("GUN_MAIN_HAND")
					Arms:registerLeftArmRenderEvent("GUN_MAIN_HAND")
					events.RENDER:register(function ()
						if WhaleFloat.whaleFloatEnabled then
							ModelAlias.alias.avatar.leftArm:setRot(ModelAlias.alias.avatar.leftArm:getRot():add(10, 0, 0))
						end
					end, "left_arm_render")
					return true
				elseif state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id == "minecraft:shield" and isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded)) and Arms.armState.left == "GUN_OFF_HAND" then
							Arms:setArmState(nil, "SHIELD_HAND")
						end
					end, "left_arm_tick")
					Arms:registerLeftArmRenderEvent("GUN_OFF_HAND")
					events.RENDER:register(function ()
						if WhaleFloat.whaleFloatEnabled then
							ModelAlias.alias.avatar.leftArm:setRot(ModelAlias.alias.avatar.leftArm:getRot():add(10, 0, 0))
						end
					end, "left_arm_render")
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
		scale = 1.3;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-1, 0, -8);
					left = vectors.vec3(1, 0, -8);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.75, 0, -8);
					left = vectors.vec3(1.75, 0, -8);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(-3, 3.5, 3);
					left = vectors.vec3(3, 3.5, 3);
				};

				rot = {
					right = vectors.vec3(-45, -90, 0);
					left = vectors.vec3(-45, 90, 0);
				};
			};
		};

		sound = {
			name = "minecraft:entity.generic.explode";
			pitch = 2;
		};

		callbacks = {
			onMainHandChange = function (_, direction)
				if direction == "RIGHT" then
					ModelAlias.alias.avatar.body.GunBag:setPos()
					ModelAlias.alias.avatar.body.GunBag:setRot(0, 0, 45)
					ModelAlias.alias.avatar.body.GunBag.ShoulderRope:setRot(0, 0, -2.5)
					ModelAlias.alias.avatar.body.GunBag.ShoulderRope.ShoulderRopeKnob:setRot()
					ModelAlias.alias.avatar.body.GunBag.BagTop.WhaleStrap:setPos()
					ModelAlias.alias.avatar.body.GunBag.BagTop.WhaleStrap:setRot(0, 0, -45)
				else
					ModelAlias.alias.avatar.body.GunBag:setPos(6, 0, 0)
					ModelAlias.alias.avatar.body.GunBag:setRot(0, 180, -45)
					ModelAlias.alias.avatar.body.GunBag.ShoulderRope:setRot(0, 180, 1)
					ModelAlias.alias.avatar.body.GunBag.ShoulderRope.ShoulderRopeKnob:setRot(0, 180, 0)
					ModelAlias.alias.avatar.body.GunBag.BagTop.WhaleStrap:setPos(0, 0, 2.3)
					ModelAlias.alias.avatar.body.GunBag.BagTop.WhaleStrap:setRot(0, 180, -45)
				end
			end;
		};
	};

	placementObjects = {

	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.lowerBody.WhaleFloat, models.models.ex_skill_1.Waves};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-15, -150, 0);
					pos = vectors.vec3(-54, 100.6, -147.4);
				};

				---Exスキルアニメーション終了時
				fin = {
					rot = vectors.vec3(-15, -180, 30);
					pos = vectors.vec3(-248, 17.6, -340.6);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						for _, modelPart in ipairs({models.models.ex_skill_1.Waves.Surface, models.models.ex_skill_1.Waves.Wave1}) do
							modelPart:setPrimaryTexture("RESOURCE", "textures/block/water_still.png")
						end
						models.models.ex_skill_1.Waves.Wave2:setPrimaryTexture("RESOURCE", "textures/block/water_flow.png")
						self.exSkill.primary.isInitialized = true
					end
					self.exSkill.primary.resetExSkill2Feature()
					self.exSkill.primary.stopExSkillWavingAnimation()
					models.models.ex_skill_1.Waves:setColor(world.getBiome(player:getPos()):getWaterColor())
					FaceParts:setEmotion("NORMAL", "NORMAL", "W", 13, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 3 then
						local modelPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Waves.Wave1):add(0, 7, 0)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 500 do
							local offset = vectors.vec3(math.random() * 32 - 16, 0, math.random() * 5)
							local particleOffset = offset:copy()
							particleOffset.x = particleOffset.x * (math.random() * 0.025 + 0.025)
							particleOffset.y = 0.25
							particleOffset.z = (particleOffset.z - 2.5) * (math.random() * 0.025 + 0.025)
							particles:newParticle("minecraft:dust 1 1 1 1", modelPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, offset, 0, 1, 0))):setScale(3):setColor(1, 1, 1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, particleOffset, 0, 1, 0)):setGravity(1):setLifetime(40)
						end
						sounds:playSound("minecraft:item.bucket.empty", modelPos, 1, 0.5)
					elseif tick == 13 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 29, true)
					elseif tick == 39 then
						sounds:playSound("minecraft:entity.generic.splash", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
					elseif tick == 42 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "W", 13, true)
					elseif tick == 52 then
						sounds:playSound("minecraft:entity.generic.swim", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
					elseif tick == 55 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "W", 13, true)
					elseif tick == 68 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 2, true)
					elseif tick == 70 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 12, true)
						sounds:playSound("minecraft:entity.generic.swim", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
					elseif tick == 82 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 4, true)
					elseif tick == 85 then
						FaceParts:setEmotion("INVERTED", "CLOSED", "OPENED", 28, true)
					elseif tick == 86 then
						sounds:playSound("minecraft:item.bucket.empty", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
					end

					if tick >= 8 and tick < 28 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Waves.Wave2.Wave2ParticleAnchor)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 20 do
							particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 32 - 16, 0, 0, 0, 1, 0))):setScale(3):setColor(1, 1, 1):setVelocity(math.random() * 0.2 - 0.1, 0.5, math.random() * 0.2 - 0.1):setGravity(1):setLifetime(20)
						end
						sounds:playSound("minecraft:item.bucket.empty", anchorPos, 1, 0.5)
					elseif tick >= 41 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor1)
						local dirVector = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor2):sub(anchorPos):normalize()
						local YVector = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor3):sub(anchorPos):normalize()
						for _ = 1, 20 do
							local particleDirection = math.random() * 60 - 30
							particleDirection = particleDirection > 0 and particleDirection + 30 or particleDirection - 30
							particles:newParticle("minecraft:dust 1 1 1 1", anchorPos):setScale(2):setColor(1, 1, 1):setVelocity(vectors.rotateAroundAxis(particleDirection, dirVector, YVector):add(YVector:copy():scale(math.random())):normalize():scale(0.5)):setGravity(0.5):setLifetime(10)
						end
						if tick % 2 == 0 then
							sounds:playSound("minecraft:item.bucket.empty", anchorPos, 0.1, 0.5)
						end
					end

					if tick % 2 == 0 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Waves.Surface, models.models.ex_skill_1.Waves.Wave1}) do
							modelPart:setUVPixels(0, modelPart:getUVPixels().y + 16)
						end
					end
					models.models.ex_skill_1.Waves.Wave2:setUVPixels(0, models.models.ex_skill_1.Waves.Wave2.Wave2:getUVPixels().y + 16)
				end;

				onPostTransition = function (self, forcedStop)
					if not forcedStop then
						local playerPos = player:getPos()
						for i = 1, 6 do
							for j = 0, 35 do
								particles:newParticle("minecraft:dust 1 1 1 1", playerPos):setScale(2):setColor(1, 1, 1):setVelocity(vectors.rotateAroundAxis(j * 12, 0, -0.25, i * 0.05, 0, 1, 0)):setPower(0.25):setColor((i - 1) * 0.2, 1, 1)
							end
						end

						animations["models.main"]["waving"]:play()
						FaceParts:setEmotion("CENTER", "NORMAL", "OPENED", 31, true)
						Arms:setArmState("DEFAULT", "DEFAULT")

						local wavingCount = 0
						events.TICK:register(function ()
							if not client:isPaused() then
								if wavingCount == 31 then
									FaceParts:setEmotion("NORMAL", "CENTER", "W", 9, true)
								elseif wavingCount == 40 then
									self.exSkill.primary.stopExSkillWavingAnimation()
									ModelAlias.alias.avatar.head.Glasses:setPos(0, -4, 0)
									FaceParts:setEmotion("NORMAL", "NORMAL", "W", 40, true)
								end

								if not ExSkill:getCanPlayAnimation() then
									self.exSkill.primary.stopExSkillWavingAnimation()
									ModelAlias.alias.avatar.head.Glasses:setPos(0, -4, 0)
								end

								wavingCount = wavingCount + 1
							end
						end, "ex_skill_1_waving_tick")

						ExSkill1WaveParticleManager:play()
						sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.5)
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.RashGuardB, ModelAlias.alias.avatar.rightArm.RashGuardRA, ModelAlias.alias.avatar.rightArmBottom.RashGuardRAB, ModelAlias.alias.avatar.leftArm.RashGuardLA, ModelAlias.alias.avatar.leftArmBottom.RashGuardLAB, ModelAlias.alias.avatar.rightLeg.RashGuardRL, ModelAlias.alias.avatar.leftLeg.RashGuardLL}) do
							modelPart:setVisible(false)
						end
						self.exSkill.primary.costumeChangeTimer = 1000
						events.TICK:register(function ()
							if not client:isPaused() then
								if self.exSkill.primary.costumeChangeTimer == 0 then
									self.exSkill.primary.resetExSkill2Feature()
								end
								self.exSkill.primary.costumeChangeTimer = self.exSkill.primary.costumeChangeTimer - 1
							end
						end, "ex_skill_1_post_tick")
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			init = false;

			---Exスキル2で衣装を変化させる時間を測るタイマー
			---@type integer
			costumeChangeTimer = 1000;

			---Exスキル2の衣装変化機能をリセットする
			resetExSkill2Feature = function ()
				for _, modelPart in ipairs({ModelAlias.alias.avatar.body.RashGuardB, ModelAlias.alias.avatar.rightArm.RashGuardRA, ModelAlias.alias.avatar.rightArmBottom.RashGuardRAB, ModelAlias.alias.avatar.leftArm.RashGuardLA, ModelAlias.alias.avatar.leftArmBottom.RashGuardLAB, ModelAlias.alias.avatar.rightLeg.RashGuardRL, ModelAlias.alias.avatar.leftLeg.RashGuardLL}) do
					modelPart:setVisible(true)
				end
				ModelAlias.alias.avatar.head.Glasses:setPos()
				events.TICK:remove("ex_skill_1_post_tick")
			end;

			---Exスキル1再生後の波演出のアニメーションを停止する。
			stopExSkillWavingAnimation = function ()
				events.TICK:remove("ex_skill_1_waving_tick")
				animations["models.main"]["waving"]:stop()
				FaceParts:resetEmotion()
				if Gun.currentGunPosition == "RIGHT" then
					Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
				elseif Gun.currentGunPosition == "LEFT" then
					Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
				end
			end;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onAltChange = function (_, isAlt)
				ModelAlias.alias.avatar.head.CMaskedH:setVisible(isAlt)
				for _, modelPart in ipairs({ModelAlias.alias.avatar.head.HairEnds, ModelAlias.alias.avatar.body.Hairs}) do
					modelPart:setVisible(not isAlt)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "W", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "YAWN", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "W", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "YAWN", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SAD", duration, true)
					end
				end
			end;

			onStop = function(_, _, forcedStop)
				if forcedStop then
					FaceParts:resetEmotion()
				end
			end
		};
	};

	headModel = {

	};

	headBlock = {
		includeModels = {ModelAlias.alias.avatar.body.Hairs};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function ()
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.head.HairTails.HairTailLeft.HairLeftBottom, ModelAlias.alias.dummy_avatar.head.HairTails.HairTailRight.HairRightBottom}) do
					modelPart:setRot(25, 0, 0)
				end
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.HairTailLeft.HairLeftBottom:setRot(-15, 0, 30)
				ModelAlias.alias.dummy_avatar.head.HairTails.HairTailRight.HairRightBottom:setRot(-15, 0, -10)
			end;

			onBeforeModelCopy = function (self)
				ModelAlias.alias.avatar.lowerBody.WhaleFloat:setVisible(false)
				self.deathAnimation.hasShield = HoshinoShield.hasShield
				if self.deathAnimation.hasShield then
					HoshinoShield:setShield(false, false)
				end
			end;

			onAfterModelCopy = function (self)
				if self.deathAnimation.hasShield then
					HoshinoShield:setShield(true, false)
				end
			end;
		};

		---盾を持っているかどうか
		---@type boolean
		hasShield = false;
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = true;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.Cowlick};

				x = {
					vertical = {
						min = -30;
						neutral = -20;
						max = 0;

						bodyY = {
							multiplayer = -40;
							min = -30;
							max = 0;
						};
					};

					horizontal = {
						min = -30;
						neutral = -20;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};
					};
				};

				y = {
					vertical = {
						min = 40;
						neutral = 40;
						max = 40;
					};

					horizontal = {
						min = 40;
						neutral = 40;
						max = 40;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailLeft.HairLeftBottom};

				x = {
					vertical = {
						min = -165;
						neutral = 0;
						max = 10;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -82.5;
							max = 10;
						};

						headRot = {
							multiplayer = 0.05;
							min = -82.5;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -165;
							max = 7.5;
						};
					};

					horizontal = {
						min = -155;
						neutral = -45;
						max = -45;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailLeft.HairLeftBottom.HairLeftBottomZ};

				z = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 100;

						headZ = {
							multiplayer = -80;
							min = -80;
							max = 100;
						};
					};

					horizontal = {
						min = -80;
						neutral = 0;
						max = 100;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailRight.HairRightBottom};

				x = {
					vertical = {
						min = -165;
						neutral = 0;
						max = 10;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -82.5;
							max = 10;
						};

						headRot = {
							multiplayer = 0.05;
							min = -82.5;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -165;
							max = 7.5;
						};
					};

					horizontal = {
						min = -155;
						neutral = -45;
						max = -45;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailRight.HairRightBottom.HairRightBottomZ};

				z = {
					vertical = {
						min = -100;
						neutral = 0;
						max = 80;

						headZ = {
							multiplayer = -80;
							min = -100;
							max = 80;
						};
					};

					horizontal = {
						min = -100;
						neutral = -20;
						max = 80;
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---盾を制御するクラス
		---@type Character07b.HoshinoShield
		HoshinoShield = require("scripts.hoshino_shield")

		---クジラフロートを制御するクラス
		---@type Character07b.WhaleFloat
		WhaleFloat = require("scripts.whale_float")

		---Exスキル1のパーティクルインスタンスのクラス
		---@type ExSkill1Particle
		ExSkill1WaveParticle = require("scripts.ex_skill_1_wave_particle")

		---Exスキル1のパーティクルマネージャーのクラス
		---@type ExSkill1ParticleManager
		ExSkill1WaveParticleManager = require("scripts.ex_skill_1_wave_particle_manager")
		ExSkill1WaveParticleManager = ExSkill1WaveParticleManager.new()

		---頭パーツに親の回転パーツを追加
		---@diagnostic disable-next-line: discard-returns
		ModelAlias.alias.avatar.root:newPart("HeadPivot", "None")
		ModelAlias.alias.avatar.root.HeadPivot:setPivot(ModelAlias.alias.avatar.head:getPivot())
		ModelUtils.moveTo(ModelAlias.alias.avatar.head, ModelAlias.alias.avatar.root.HeadPivot, ModelAlias.alias.avatar.root)
		ModelAlias:modifyAvatarAlias("head", ModelAlias.alias.avatar.root.HeadPivot.Head)

		HoshinoShield:init()
		WhaleFloat:enable()
	end;
}

return BlueArchiveCharacter
