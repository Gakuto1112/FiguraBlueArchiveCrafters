---右目のテクスチャの列挙型
---@alias Character20b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "SURPRISED_CENTER" # 驚きつつ少し反対側を見る目
---| "DRESS_INVERTED" # 反対側を見る目（ドレス衣装用）
---| "WORRY" # 戸惑いの目
---| "DARK_ANGRY" # 完全に怒っているときの目

---左目のテクスチャの列挙型
---@alias Character20b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "SWIMSUIT_CENTER" # 少し反対側を見る目（水着衣装用）
---| "WORRY" # 戸惑いの目
---| "DARK_ANGRY" # 完全に怒っているときの目

---口のテクスチャの列挙型
---@alias Character20b.MouthTextures
---| "NORMAL" # 通常
---| "TEETH" # 歯が見える口
---| "CLOSED" # ハイフンみたいな口
---| "EMBARRASSING" # 恥ずかしい口
---| "ANXIOUS" # への口
---| "SMILE" # にっこり口
---| "OPENED" # 開いた口
---| "TEETH_SMILE" # 歯を見せてにっこり

---キャラクター固有の腕の状態
---@alias Character20b.AdditionalArmState
---| "SWIM_RING" # 浮き輪を持つ手

---@class (exact) Character20b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character20b.RightEyeTextures 右目の表情名
---@field public leftEye Character20b.LeftEyeTextures 左目の表情名
---@field public mouth Character20b.MouthTextures 口の表情名

---@class (exact) Character20b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character20b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character20b.EmotionSet ベッドで寝ているとき

---@class (exact) Character20b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character20b, right: Character20b.RightEyeTextures, left: Character20b.LeftEyeTextures, mouth: Character20b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character20b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character20b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character20b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character20b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character20b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character20b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character20b.ArmsCallbacksSet : BlueArchiveCharacter.ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(self: Character20b, right: Arms.BaseArmState|Character20b.AdditionalArmState, left: Arms.BaseArmState|Character20b.AdditionalArmState): {right?: Arms.BaseArmState|Character20b.AdditionalArmState, left?: Arms.BaseArmState|Character20b.AdditionalArmState}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(self: Character20b, state: Arms.BaseArmState|Character20b.AdditionalArmState): boolean? 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: Character20b, state: Arms.BaseArmState|Character20b.AdditionalArmState): boolean? 左腕の追加処理

---@class (exact) Character20b.ArmsStruct : BlueArchiveCharacter.ArmsStruct 腕のデータ構造体
---@field public callbacks? Character20b.ArmsCallbacksSet 腕の制御のコールバック関数群

---@class (exact) Character20b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character20b.FacePartsStruct 目や口による表情
---@field public arms Character20b.ArmsStruct 腕

---@type Character20b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "20b_Hina_Swimsuit";

		birth = {
			month = 2;
			day = 19;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(6, 0);
			SURPRISED_CENTER = vectors.vec2(7, 0);
			DRESS_INVERTED = vectors.vec2(11, 0);
			WORRY = vectors.vec2(12, 0);
			DARK_ANGRY = vectors.vec2(14, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CENTER = vectors.vec2(4, 0);
			CLOSED2 = vectors.vec2(5, 0);
			SWIMSUIT_CENTER = vectors.vec2(7, 0);
			WORRY = vectors.vec2(12, 0);
			DARK_ANGRY = vectors.vec2(14, 0);
		};

		mouth = {
			TEETH = vectors.vec2(0, 0);
			CLOSED = vectors.vec2(1, 0);
			EMBARRASSING = vectors.vec2(2, 0);
			ANXIOUS = vectors.vec2(3, 0);
			SMILE = vectors.vec2(4, 0);
			OPENED = vectors.vec2(5, 0);
			TEETH_SMILE = vectors.vec2(6, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (self, right, left)
				local result = {right = right, left = left}

				if right == "DEFAULT" and self.costume.hasRing then
					result.right = "SWIM_RING"
				elseif right == "CROSSBOW" and Gun.currentGunPosition == "RIGHT" then
					result.right = "GUN_MAIN_HAND"
				end

				if left == "DEFAULT" and self.costume.hasRing then
					result.left = "SWIM_RING"
				elseif left == "CROSSBOW" and Gun.currentGunPosition == "LEFT" then
					result.left = "GUN_MAIN_HAND"
				end

				return result;
			end;

			onAdditionalRightArmProcess = function (_, state)
				ModelAlias.alias.avatar.rightArmBottom:setRot(state == "GUN_MAIN_HAND" and 40 or 0, 0, 0)
				if state == "GUN_MAIN_HAND" then
					Arms:registerRightArmTickEvent("GUN_MAIN_HAND")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local rotY = headRot.y % 360
						rotY = rotY > 180 and 0 or rotY
						ModelAlias.alias.avatar.rightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3() or vectors.vec3(math.max(headRot.x - 15 + (player:isCrouching() and 30 or 0), -15) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5, rotY, 10))
					end, "right_arm_render")
					return true
				elseif state == "GUN_OFF_HAND" then
					Arms:registerRightArmTickEvent("GUN_OFF_HAND")
					events.RENDER:register(function (delta, context)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
						ModelAlias.alias.avatar.rightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.max(headRot.x + 55 + (player:isCrouching() and 30 or 0), 55), math.min(math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78) + 30, 65) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5, 0))
					end, "right_arm_render")
					return true
				elseif state == "SWIM_RING" then
					local shouldArmModified = false
					events.TICK:register(function ()
						if Arms.armState.right == "SWIM_RING" then
							local activeHand = player:getActiveHand()
							local isLeftHanded = player:isLeftHanded()
							shouldArmModified = (player:getActiveItem().id == "minecraft:air" or ((activeHand == "OFF_HAND" and not isLeftHanded) or (activeHand == "MAIN_HAND" and isLeftHanded))) and (not player:isSwingingArm() or isLeftHanded)
							ModelAlias.alias.avatar.rightArm:setRot(shouldArmModified and vectors.vec3(0, 0, 35) or vectors.vec3())
						end
					end, "right_arm_tick")
					events.RENDER:register(function (_, context)
						if Arms.armState.right == "SWIM_RING" then
							ModelAlias.alias.avatar.rightArm:setParentType((shouldArmModified and context ~= "FIRST_PERSON") and "Body" or "RightArm")
						end
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				ModelAlias.alias.avatar.leftArmBottom:setRot(state == "GUN_MAIN_HAND" and 40 or 0, 0, 0)
				if state == "GUN_MAIN_HAND" then
					Arms:registerLeftArmTickEvent("GUN_MAIN_HAND")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local rotY = headRot.y % 360
						rotY = rotY < 180 and 0 or rotY
						ModelAlias.alias.avatar.leftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3() or vectors.vec3(math.max(headRot.x - 15 + (player:isCrouching() and 30 or 0), -15) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5, rotY, -10))
					end, "left_arm_render")
					return true
				elseif state == "GUN_OFF_HAND" then
					Arms:registerLeftArmTickEvent("GUN_OFF_HAND")
					events.RENDER:register(function (delta, context)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
						ModelAlias.alias.avatar.leftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.max(headRot.x + 55 + (player:isCrouching() and 30 or 0), 55), math.max(math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21) - 30, -65) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5, 0))
					end, "left_arm_render")
					return true
				elseif state == "SWIM_RING" then
					local shouldArmModified = false
					events.TICK:register(function ()
						if Arms.armState.left == "SWIM_RING" then
							local activeHand = player:getActiveHand()
							local isLeftHanded = player:isLeftHanded()
							shouldArmModified = (player:getActiveItem().id == "minecraft:air" or ((activeHand == "MAIN_HAND" and not isLeftHanded) or (activeHand == "OFF_HAND" and isLeftHanded))) and (not player:isSwingingArm() or not isLeftHanded)
							ModelAlias.alias.avatar.leftArm:setParentType(shouldArmModified and "Body" or "LeftArm")
							ModelAlias.alias.avatar.leftArm:setRot(shouldArmModified and vectors.vec3(0, 0, -35) or vectors.vec3())
						end
					end, "left_arm_tick")
					events.RENDER:register(function (_, context)
						if Arms.armState.left == "SWIM_RING" then
							ModelAlias.alias.avatar.leftArm:setParentType((shouldArmModified and context ~= "FIRST_PERSON") and "Body" or "LeftArm")
						end
					end, "left_arm_render")
				end
			end;
		}
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 2.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 2, -15);
					left = vectors.vec3(0, 2, -15);
				};
				thirdPersonPos = {
					right = vectors.vec3(-2, 10, -5);
					left = vectors.vec3(2, 10, -5);
				};
				thirdPersonRot = {
					right = vectors.vec3(70, 10, 0);
					left = vectors.vec3(70, -10, 0);
				}
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, 4, 2);
					left = vectors.vec3(0, 4, 2);
				};

				rot = {
					right = vectors.vec3(0, 90, 45);
					left = vectors.vec3(0, -90, -45);
				};
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

			models = {ModelAlias.alias.avatar.head.Cheek, ModelAlias.alias.avatar.body.RightWing, ModelAlias.alias.avatar.body.SwimRing.SRArmbandEmissive};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(15, 210, 0);
					pos = vectors.vec3(-12.75, 15, -4);
				};

				fin = {
					rot = vectors.vec3(0, 180, -25);
					pos = vectors.vec3(1.74, 20.33, -32.55);
				};
			};

			callbacks = {
				onPreAnimation = function ()
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.SwimRing, ModelAlias.alias.avatar.body.Wings}) do
						modelPart:setVisible(true)
					end
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "EMBARRASSING", 30, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 15 and host:isHost() then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.5, 0.75)
					elseif tick == 18 and host:isHost() then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.5, 1)
					elseif tick == 21 and host:isHost() then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.5, 1.25)
					elseif tick == 30 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "EMBARRASSING", 4, true)
					elseif tick == 34 then
						FaceParts:setEmotion("SURPRISED_CENTER", "SURPRISED", "ANXIOUS", 10, true)
						sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 1, 2)
					elseif tick == 44 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", 6, true)
					elseif tick == 45 then
						sounds:playSound("minecraft:entity.bat.takeoff", player:getPos(), 0.5, 1.25)
					elseif tick == 50 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", 3, true)
					elseif tick == 52 then
						Character20b_MachineGun.exSkillIsHolding = true
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
					elseif tick == 53 then
						FaceParts:setEmotion("NORMAL", "SWIMSUIT_CENTER", "CLOSED", 46, true)
						sounds:playSound("minecraft:item.bucket.empty", player:getPos(), 1, 1.5)
					elseif tick == 55 then
						sounds:playSound("minecraft:entity.lightning_bolt.thunder", player:getPos(), 0.5, 2)
					end

					if tick <= 14 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.SwimRing.SRArmband)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 4 do
							particles:newParticle("minecraft:end_rod", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(20, math.random() * 0.6 - 0.3, math.random() * 0.4 - 0.2, math.random() * 0.6 - 0.3, 0, 0, 1), 0, 1, 0))):setScale(0.25):setColor(0.98, 0.62, 0.84):setGravity(0):setLifetime(10)
						end
					elseif tick >= 53 and tick <= 57 then
						local anchorPos = player:getPos():add(0, 1, 0)
						local bodyYaw = player:getBodyYaw()
						for i = 0, 5 do
							local offsetPos = vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(20, vectors.rotateAroundAxis(180 + ((tick - 52) * 6 + i) * 10 , 0, 0, 1, 0, 1, 0), 0, 0, 1), 0, 1, 0)
							particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy():add(offsetPos)):setScale(0.5):setVelocity(offsetPos:copy():scale(0.1)):setColor(vectors.vec3(0.96, 0.6, 1):add(vectors.vec3(1, 1, 1):sub(0.96, 0.6, 1):scale(math.random()))):setLifetime(4 + math.random() * 4)
						end
						if tick >= 54 and tick <= 55 then
							for _, particleData in ipairs({{1, -0.01}, {2.5, 0.00001}, {4, 0.02}}) do
								particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(20, vectors.rotateAroundAxis(180 + ((tick - 52) * 6 + particleData[1]) * 10 , 0, 0, 1, 0, 1, 0), 0, 0, 1), 0, 1, 0))):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, particleData[2], 0.03, 0, 1, 0)):setColor(vectors.vec3(0.96, 0.6, 1):add(vectors.vec3(1, 1, 1):sub(0.96, 0.6, 1):scale(math.random()))):setLifetime(45)
							end
						end
					end
					if tick >= 12 and tick < 48 then
						local anchorPos = player:getPos()
						for _ = 1, 4 do
							particles:newParticle("minecraft:end_rod", anchorPos:copy():add(vectors.rotateAroundAxis(math.random() * 360, 0, math.random() * 2, math.random() * 1.5, 0, 1, 0))):setColor(0.98, 0.62, 0.84):setScale(0.5):setLifetime(10)
						end
					end
					if tick >= 34 and tick < 44 then
						local anchorPos = player:getPos()
						for _ = 1, 4 do
							particles:newParticle("minecraft:firework", anchorPos:copy():add(vectors.rotateAroundAxis(math.random() * 360, 0, math.random() * 2, math.random() * 1.5, 0, 1, 0))):setScale(0.5):setGravity(0):setLifetime(20)
						end
					end
				end;

				onPostAnimation = function (self)
					ModelAlias.alias.avatar.body.Wings:setVisible(false)
					ModelAlias.alias.avatar.body.SwimRing:setVisible(self.costume.hasRing)
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.LeftWing, ModelAlias.alias.avatar.body.RightWing.RightWingZPivot.RightWingBone1.RightWingBone2.RightWingBone3.RightWingBone4.RightWingBone5.RightWingBone6.RightWingBone7.RightWingBone8.RightWingClaw}) do
						modelPart:setVisible(true)
					end
					if ModelAlias.alias.avatar.rightArmBottom.Gun ~= nil then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
						if Gun.currentGunPosition == "NONE" then
							if player:isLeftHanded() then
								ModelAlias.alias.avatar.body.Gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.left))
								ModelAlias.alias.avatar.body.Gun:setRot(self.gun.gunPosition.put.rot.left)
							else
								ModelAlias.alias.avatar.body.Gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.right))
								ModelAlias.alias.avatar.body.Gun:setRot(self.gun.gunPosition.put.rot.right)
							end
						end
					end
					Character20b_MachineGun.exSkillIsHolding = false
				end;
			};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.FrontHair:setPos(0, 0, isVisible and -1 or 0)
				end
			end;
		};

		---浮き輪を装備しているかどうか。
		---@type boolean
		hasRing = false;

		---前ティックに浮き輪を装備していたかどうか。
		---@type boolean
		hasRingPrev = false;

		---浮き輪装備を解除する。
		---@param self Character20b
		removeSwimRing = function (self)
			self.costume.hasRing = false
			self.costume.hasRingPrev = false
			ModelAlias.alias.avatar.body.SwimRing:setVisible(ExSkill.animationCount >= 0)
			ModelAlias.alias.avatar.body.SwimRing:setPos()
			ModelAlias.alias.avatar.body.SwimRing:setRot()
			if Gun.currentGunPosition == "NONE" then
				Arms:setArmState("DEFAULT", "DEFAULT")
			end
		end;
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("CLOSED", "CLOSED", "TEETH_SMILE", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "TEETH_SMILE", duration, true)
				elseif type == "QUESTION" then
					ModelAlias.alias.avatar.head.Sweat:setVisible(true)
					FaceParts:setEmotion("NORMAL", "NORMAL", "EMBARRASSING", duration, true)
				elseif type == "SWEAT" then
					ModelAlias.alias.avatar.head.Cheek:setVisible(true)
					FaceParts:setEmotion("SURPRISED", "SURPRISED", "ANXIOUS", duration, true)
				end
			end;

			onStop = function(_, _, forcedStop)
				for _, modelPart in ipairs({ModelAlias.alias.avatar.head.Sweat, ModelAlias.alias.avatar.head.Cheek}) do
					modelPart:setVisible(false)
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
				ModelAlias.alias.dummy_avatar.head.BackHairs.BottomBackHair:setRot(22.5, 0, 0)
				ModelAlias.alias.dummy_avatar.head.SideHairTail:setRot(30, 0, -10)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.SideHairTail:setRot(-20, 0, -7.5)
				ModelAlias.alias.dummy_avatar.head.BackHairs.BottomBackHair:setRot(-20, 0, 0)
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.body.FrontHair.RightFrontHair, ModelAlias.alias.dummy_avatar.body.FrontHair.LeftFrontHair}) do
					modelPart:setRot(0, 0, -15)
				end
			end
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
						min = -70;
						neutral = -30;
						max = -5;

						headX = {
							multiplayer = 40;
							min = -70;
							max = -5;
						};

						bodyY = {
							multiplayer = 40;
							min = -50;
							max = -5;
						};
					};

					horizontal = {
						min = -70;
						neutral = -30;
						max = -30;

						bodyX = {
							multiplayer = 80;
							min = -70;
							max = -30;
						};
					};
				};

				y = {
					vertical = {
						min = -25;
						neutral = -25;
						max = -25;
					};

					horizontal = {
						min = -25;
						neutral = -25;
						max = -25;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.BackHairs.BottomBackHair};

				x = {
					vertical = {
						min = -130;
						neutral = -5;
						max = -15;
						sneakOffset = -30;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -40;
							min = -90;
							max = -5;
						};

						headRot = {
							multiplayer = 0.025;
							min = -90;
							max = -5;
						};

						bodyY = {
							multiplayer = 40;
							min = -130;
							max = -5;
						};
					};

					horizontal = {
						min = -130;
						neutral = -30;
						max = -5;

						headX = {
							multiplayer = -80;
							min = -45;
							max = -5;
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
						max = 150;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -60;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -60;
							min = 0;
							max = 150;
						};

						bodyRot = {
							multiplayer = -0.03;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
						max = 150;

						bodyX = {
							multiplayer = -60;
							min = 0;
							max = 150;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.SideHairTail};

				x = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -60;
							min = -90;
							max = 90;
						};
					};

					horizontal = {
						min = -45;
						neutral = 45;
						max = 45;

						headX = {
							multiplayer = -120;
							min = -45;
							max = 45;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.SideHairTail.SideHairTailZPivot};

				z = {
					vertical = {
						min = -170;
						neutral = -7.5;
						max = -7.5;

						headZ = {
							multiplayer = -40;
							min = -60;
							max = -7.5;
						};

						headRot = {
							multiplayer = 0.025;
							min = -60;
							max = -7.5;
						};

						bodyY = {
							multiplayer = 60;
							min = -170;
							max = -7.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Whistle.WhistleFront};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 75;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -120;
							min = 0;
							max = 75;
						};

						bodyY = {
							multiplayer = -120;
							min = 0;
							max = 75;
						};

						bodyRot = {
							multiplayer = -0.1;
							min = 0;
							max = 75;
						};
					};

					horizontal = {
						min = 0;
						neutral = 75;
						max = 75;

						bodyX = {
							multiplayer = -120;
							min = 0;
							max = 75;
						};
					};
				};
			};
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model == ModelAlias.alias.avatar.head.BackHairs.BottomBackHair then
					local rot = math.deg(math.asin(player:getLookDir().y)) - model:getRot().x
					if rot < 0 then
						ModelAlias.alias.avatar.head.BackHairs.BottomBackHair:setOffsetPivot(0, 0, 2)
					else
						ModelAlias.alias.avatar.head.BackHairs.BottomBackHair:setOffsetPivot()
					end
				elseif model == ModelAlias.alias.avatar.head.BackHairs.TopBackHair then
					model:setRot(math.min(model:getRot().x, 20), 0, 0)
				elseif model == ModelAlias.alias.avatar.head.Horns.HornBL.LeftHornRibbon or model == ModelAlias.alias.avatar.head.Horns.HornBR.RightHornRibbon then
					model:setRot(math.min(model:getRot().x, 0), 0, 0)
				end
			end
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function (self)
		---ヒナのマシンガンを制御するクラス
		---@type Character20b.MachineGun
		Character20b_MachineGun = require("scripts.machine_gun")

		Character20b_MachineGun:init()

		ModelAlias.alias.avatar.body:newText("costume_swimsuit_text_1"):setText("§05-A"):setPos(0, -3, -2):setScale(0.05):setAlignment("CENTER")
		ModelAlias.alias.avatar.body:newText("costume_swimsuit_text_2"):setText("§0ひな"):setPos(0, -3.35, -2):setScale(0.2):setAlignment("CENTER")
		ModelAlias.alias.avatar.body.SwimRing.SRArmband:newText("costume_swimsuit_text_3"):setText("§l風紀"):setPos(0, 0.75, -3.3):setScale(0.33):setAlignment("CENTER")

		events.TICK:register(function ()
			self.costume.hasRing = player:getItem(6).id == "minecraft:turtle_helmet" and not Armor.shouldShowArmor and not player:isUnderwater() and ExSkill.animationCount == -1
			if self.costume.hasRing ~= self.costume.hasRingPrev then
				if self.costume.hasRing then
					ModelAlias.alias.avatar.body.SwimRing:setVisible(true)
					ModelAlias.alias.avatar.body.SwimRing:setPos(0, 2, 0)
					ModelAlias.alias.avatar.body.SwimRing:setRot(90, 0, 0)
					if Gun.currentGunPosition == "NONE" then
						Arms:setArmState("SWIM_RING", "SWIM_RING")
					end
				else
					self.costume.removeSwimRing(self)
				end
			end
			self.costume.hasRingPrev = self.costume.hasRing
		end)

        events.RENDER:register(function ()
			if not client:isPaused() then
				local wingRotOffset = math.map(vanilla_model.RIGHT_LEG:getOriginRot().x, -90, 90, 20, 0)
				ModelAlias.alias.avatar.body.Wings.RightWing:setRot(0, wingRotOffset * -1, 0)
				ModelAlias.alias.avatar.body.Wings.LeftWing:setRot(0, wingRotOffset, 0)
			end
        end)
	end;
}

return BlueArchiveCharacter
