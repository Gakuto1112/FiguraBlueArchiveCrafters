---右目のテクスチャの列挙型
---@alias Character07a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANGRY" # 怒った目
---| "CLOSED2" # 閉じた目2
---| "INVERTED" # 反対側を見る目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "NARROW" # 半閉じ目

---左目のテクスチャの列挙型
---@alias Character07a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "INVERTED" # 反対側を見る目
---| "ANGRY" # 怒った目
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "NARROW" # 半閉じ目

---口のテクスチャの列挙型
---@alias Character07a.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "CLOSED" # 閉じた口
---| "W" # ω
---| "YAWN" あくび
---| "OUT_OF_BREATH" # 息切れ口
---| "TEETH" 食いしばる口
---| "SAD" # への口

---キャラクター固有の腕の状態
---@alias Character07a.AdditionalArmState
---| "SHIELD_HAND" # 盾を持つ腕の状態

---@class (exact) Character07a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character07a.RightEyeTextures 右目の表情名
---@field public leftEye Character07a.LeftEyeTextures 左目の表情名
---@field public mouth Character07a.MouthTextures 口の表情名

---@class (exact) Character07a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character07a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character07a.EmotionSet ベッドで寝ているとき

---@class (exact) Character07a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character07a, right: Character07a.RightEyeTextures, left: Character07a.LeftEyeTextures, mouth: Character07a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character07a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character07a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character07a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character07a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character07a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character07a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character07a.ArmsCallbacksSet : BlueArchiveCharacter.ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(self: Character07a, right: Arms.BaseArmState|Character07a.AdditionalArmState, left: Arms.BaseArmState|Character07a.AdditionalArmState): {right?: Arms.BaseArmState|Character07a.AdditionalArmState, left?: Arms.BaseArmState|Character07a.AdditionalArmState}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(self: Character07a, state: Arms.BaseArmState|Character07a.AdditionalArmState): boolean? 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: Character07a, state: Arms.BaseArmState|Character07a.AdditionalArmState): boolean? 左腕の追加処理

---@class (exact) Character07a.ArmsStruct : BlueArchiveCharacter.ArmsStruct 腕のデータ構造体
---@field public callbacks? Character07a.ArmsCallbacksSet 腕の制御のコールバック関数群

---@class (exact) Character07a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character07a.FacePartsStruct 目や口による表情
---@field public arms Character07a.ArmsStruct 腕

---@type Character07a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "07a_Hoshino";

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
			ANGRY = vectors.vec2(7, 0);
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
			ANGRY = vectors.vec2(7, 0);
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
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
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
	};

	placementObjects = {

	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.gun.Barrel.ShineEffect};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, -160, 0);
					pos = vectors.vec3(-4.5, 7.75, -44.5);
				};

				fin = {
					rot = vectors.vec3(-15, 215, 0);
					pos = vectors.vec3(-13.5, 13.5, -25);
				};
			};

			callbacks = {
				onPreAnimation = function (_)
					ModelAlias.alias.avatar.gun.Barrel.ShineEffect:setColor(client:hasShaderPack() and vectors.vec3(1, 0.5, 0.5) or vectors.vec3(1, 1, 1))
					FaceParts:setEmotion("ANGRY", "ANGRY", "CLOSED", 53, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.body.Shield.Section2.ShoulderBelt:setVisible(false)
					elseif tick == 8 or tick == 15 then
						sounds:playSound("minecraft:block.chest.locked", player:getPos(), 1, 2)
					elseif tick == 12 then
						local bodyYaw = player:getBodyYaw()
						local particlePos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.Shield.Section2):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 3.66, -1, 0, 1, 0):scale(0.0625))
						for _ = 1, 10 do
							particles:newParticle("S1", particlePos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.6 - 0.3, math.random() * 0.2 - 0.1, 0, 0, 1, 0)):setColor(1, 0.64, 0.59):setLifetime(4)
						end
					elseif tick == 19 then
						local bodyYaw = player:getBodyYaw()
						local particlePos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.Shield.Section2.Section1):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 3.66, -1, 0, 1, 0):scale(0.0625))
						for _ = 1, 10 do
							particles:newParticle("S1", particlePos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.6 - 0.3, math.random() * 0.2 - 0.1, 0, 0, 1, 0)):setColor(1, 0.64, 0.59):setLifetime(4)
						end
					elseif tick == 36 or tick == 45 then
						sounds:playSound("minecraft:block.anvil.place", player:getPos(), 1, 2)
					elseif tick == 38 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Shield.Section2.Section1.GasCylinder1.GasPiston1, ModelAlias.alias.avatar.body.Shield.Section2.Section1.GasCylinder2.GasPiston2}) do
							local bodyYaw = player:getBodyYaw()
							local particlePos = ModelUtils.getModelWorldPos(modelPart):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -0.5, 0, 1, 0):scale(0.0625))
							for _ = 1, 5 do
								particles:newParticle("S1", particlePos):setScale(0.25):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.06 - 0.03, -0.05, 0, 0, 1, 0)):setColor(1, 0.64, 0.59):setLifetime(4)
							end
						end
					elseif tick == 47 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Shield.Section2.GasCylinder3.GasPiston3, ModelAlias.alias.avatar.body.Shield.Section2.GasCylinder4.GasPiston4}) do
							local bodyYaw = player:getBodyYaw()
							local particlePos = ModelUtils.getModelWorldPos(modelPart):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -0.5, 0, 1, 0):scale(0.0625))
							for _ = 1, 5 do
								particles:newParticle("S1", particlePos):setScale(0.25):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.06 - 0.03, -0.025, 0, 0, 1, 0)):setColor(1, 0.64, 0.59):setLifetime(4)
							end
						end
					elseif tick == 53 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.body.Shield, ModelAlias.alias.avatar.leftArmBottom, ModelAlias.alias.avatar.body)
						FaceParts:setEmotion("ANGRY", "ANGRY_CENTER", "CLOSED", 19, true)
					elseif tick == 55 then
						local bodyYaw = player:getBodyYaw()
						local particlePos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.Shield.Section2):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 10, 4, 0, 1, 0):scale(0.0625))
						for _ = 1, 5 do
							particles:newParticle("S1", particlePos):setScale(0.5):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, 0, 0, 1, 0)):setColor(0.973, 0.714, 0.29):setLifetime(2)
						end
						sounds:playSound("minecraft:block.anvil.place", player:getPos(), 0.25, 4)
					elseif tick == 70 then
						local bodyYaw = player:getBodyYaw()
						local particlePos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.Shield.Section2):add(vectors.rotateAroundAxis(bodyYaw * -1, -2, 3, 4, 0, 1, 0):scale(0.0625))
						for _ = 1, 5 do
							particles:newParticle("S1", particlePos):setScale(0.5):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, 0, 0, 1, 0)):setColor(0.973, 0.714, 0.29):setLifetime(2)
						end
						sounds:playSound("minecraft:block.anvil.place", player:getPos(), 0.25, 4)
					elseif tick == 72 then
						FaceParts:setEmotion("ANGRY", "CLOSED2", "CLOSED", 32, true)
						sounds:playSound("minecraft:item.flintandsteel.use", player:getPos(), 1, 2)
					elseif tick == 79 then
						local particlePos = player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 1, 0, -3, 0, 1, 0))
						particles:newParticle("S1", particlePos)
						for _ = 1, 100 do
							local particleOffset = vectors.vec3(math.random() - 0.5, math.random() * 0.5, math.random() - 0.5)
							particles:newParticle("S1", particlePos:copy():add(particleOffset)):setScale(5):setVelocity(particleOffset)
						end
						local particleBlock = world.getBlockState(particlePos:copy():add(0, -1, 0)).id
						if particleBlock ~= "minecraft:air" and particleBlock ~= "minecraft:void_air" and particleBlock ~= "minecraft:cave_air" then
							for _ = 1, 50 do
								particles:newParticle("minecraft:block " .. particleBlock, particlePos):setScale(0.75):setVelocity(math.random() * 0.8 - 0.4, math.random() * 1, math.random() * 0.8 - 0.4):setLifetime(40)
							end
						end
						local playerPos = player:getPos()
						sounds:playSound("minecraft:block.iron_door.open", playerPos, 1, 2)
						sounds:playSound("minecraft:entity.player.levelup", playerPos, 0.5, 1.5)
						sounds:playSound("minecraft:entity.generic.explode", playerPos, 0.5, 0.5)
					end

					if tick % 2 == 0 then
						local particlePos = math.random()
						if particlePos < 0.4 then
							self.exSkill.primary.showAmmoParticle(self, player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, -1, particlePos * 7.5, 4, 0, 1, 0)))
						elseif particlePos < 0.6 then
							self.exSkill.primary.showAmmoParticle(self, player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, (particlePos - 0.4) * 10 - 1, 3, 4, 0, 1, 0)))
						else
							self.exSkill.primary.showAmmoParticle(self, player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 1, (particlePos - 0.6) * 7.5, 4, 0, 1, 0)))
						end
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if ModelAlias.alias.avatar.rightArmBottom.Gun ~= nil then
						ModelUtils.moveTo(ModelAlias.alias.avatar.rightArmBottom.Gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
					end
					if player:isLeftHanded() then
						ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.left))
						ModelAlias.alias.avatar.gun:setRot(self.gun.gunPosition.put.rot.left)
					else
						ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.right))
						ModelAlias.alias.avatar.gun:setRot(self.gun.gunPosition.put.rot.right)
					end
					if ModelAlias.alias.avatar.leftArmBottom.Shield ~= nil then
						ModelUtils.moveTo(ModelAlias.alias.avatar.leftArmBottom.Shield, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.leftArmBottom)
					end
					if ExSkill.animationCount >= 0 then
						ModelAlias.alias.avatar.body.Shield.Section2.ShoulderBelt:setVisible(true)
					end
				end;
			};

			---銃弾を表現するパーティクル
			---@param self Character07a
			---@param pos Vector3 パーティクルをスポーンさせる場所
			showAmmoParticle = function (self, pos)
				local bodyYaw = player:getBodyYaw()
				particles:newParticle("S1", pos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -1, 0, 1, 0)):setLifetime(20)
				local smokePos = pos:copy()
				for _ = 1, 5 do
					particles:newParticle("S1", smokePos:add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, 0.5, 0, 1, 0))):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -0.5, 0, 1, 0)):setGravity(0):setLifetime(20)
				end
			end;
		};
	};

	costume = {
		isAltCostumeEnabled = true;

		callbacks = {
			onAltChange = function (_, isAlt)
				ModelAlias.alias.avatar.head.CMaskedH:setVisible(isAlt)
				for _, modelPart in ipairs({ModelAlias.alias.avatar.head.HairEnds, ModelAlias.alias.avatar.body.Hairs}) do
					modelPart:setVisible(not isAlt)
				end
			end;

			onArmorChange = function (_, parts, isVisible)
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, isVisible and 1 or 0)
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
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
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(25, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Shield:setPos(4.5, -2.5, 0)
				ModelAlias.alias.dummy_avatar.body.Shield:setRot(70, 90, 0)
				ModelAlias.alias.dummy_avatar.body.Shield.Section2.ShoulderBelt:setRot(-55, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-35, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Shield:setPos()
				ModelAlias.alias.dummy_avatar.body.Shield:setRot(0, 90, 0)
				ModelAlias.alias.dummy_avatar.body.Shield.Section2.ShoulderBelt:setRot()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-9.6599, -3.2113, -12.0868)
			end;

			onBeforeModelCopy = function (self)
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
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair};

				x = {
					vertical = {
						min = -150;
						neutral = -5;
						max = -5;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = -5;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = -5;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -5;
						};
					};

					horizontal = {
						min = -90;
						neutral = -5;
						max = -5;
					};
				};
			};

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
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---盾を制御するクラス
		---@type Character07a.HoshinoShield
		HoshinoShield = require("scripts.hoshino_shield")

		HoshinoShield:init()
	end;
}

return BlueArchiveCharacter
