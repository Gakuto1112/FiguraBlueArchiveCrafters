---右目のテクスチャの列挙型
---@alias Character12b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "NARROW" # 少し閉じた目
---| "CLOSED2" # 閉じた目2
---| "ANGRY" # 怒った目

---左目のテクスチャの列挙型
---@alias Character12b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "NARROW_CENTER" # 少し閉じつつ反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "NARROW" # 少し閉じた目
---| "ANGRY" # 怒った目

---口のテクスチャの列挙型
---@alias Character12b.MouthTextures
---| "NORMAL" # 通常
---| "CLOSED" # 閉じた口
---| "SMALL" # 小さく開いた口
---| "OPENED" # 開いた口
---| "SMILE" # にっこり
---| "ANXIOUS" # への口

---キャラクター固有の腕の状態
---@alias Character12b.AdditionalArmState
---| "CAR" # 車を運転中の腕
---| "CAR_GUN_MAIN_HAND" # 車に乗りながら銃を持つ腕

---@class (exact) Character12b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character12b.RightEyeTextures 右目の表情名
---@field public leftEye Character12b.LeftEyeTextures 左目の表情名
---@field public mouth Character12b.MouthTextures 口の表情名

---@class (exact) Character12b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character12b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character12b.EmotionSet ベッドで寝ているとき

---@class (exact) Character12b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character12b, right: Character12b.RightEyeTextures, left: Character12b.LeftEyeTextures, mouth: Character12b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character12b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character12b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character12b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character12b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character12b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character12b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character12b.ArmsCallbacksSet : BlueArchiveCharacter.ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(self: Character12b, right: Arms.BaseArmState|Character12b.AdditionalArmState, left: Arms.BaseArmState|Character12b.AdditionalArmState): {right?: Arms.BaseArmState|Character12b.AdditionalArmState, left?: Arms.BaseArmState|Character12b.AdditionalArmState}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(self: Character12b, state: Arms.BaseArmState|Character12b.AdditionalArmState): boolean? 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: Character12b, state: Arms.BaseArmState|Character12b.AdditionalArmState): boolean? 左腕の追加処理

---@class (exact) Character12b.ArmsStruct : BlueArchiveCharacter.ArmsStruct 腕のデータ構造体
---@field public callbacks? Character12b.ArmsCallbacksSet 腕の制御のコールバック関数群

---@class (exact) Character12b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character12b.FacePartsStruct 目や口による表情
---@field public arms Character12b.ArmsStruct 腕

---@type Character12b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "12b_Seia_Swimsuit";

		birth = {
			month = 9;
			day = 29;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CENTER = vectors.vec2(5, 0);
			NARROW = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(9, 0);
			ANGRY = vectors.vec2(11, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CENTER = vectors.vec2(5, 0);
			NARROW_CENTER = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(8, 0);
			NARROW = vectors.vec2(9, 0);
			ANGRY = vectors.vec2(11, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(0, 0);
			SMALL = vectors.vec2(1, 0);
			OPENED = vectors.vec2(2, 0);
			SMILE = vectors.vec2(3, 0);
			ANXIOUS = vectors.vec2(4, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				if left == "GUN_OFF_HAND" and right == "GUN_MAIN_HAND" then
					if Car.isRidingCar then
						return {right = "CAR_GUN_MAIN_HAND", left = "CAR"}
					end
				elseif left == "GUN_MAIN_HAND" and right == "GUN_OFF_HAND" then
					if Car.isRidingCar then
						return {right = "CAR", left = "CAR_GUN_MAIN_HAND"}
					end
				elseif left == "DEFAULT" and right == "DEFAULT" then
					if Car ~= nil and Car.isRidingCar then
						return {right = "CAR", left = "CAR"}
					end
				end
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "CAR" then
					--乗車中
					events.TICK:register(function ()
						Arms:processArmSwingCount()
					end, "right_arm_tick")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						local isUsingSpyglass = player:getActiveItem().id == "minecraft:spyglass" and ((activeHand == "MAIN_HAND" and not isLeftHanded) or (activeHand == "OFF_HAND" and isLeftHanded))
						local isSwingingArm = (player:isSwingingArm() and not isLeftHanded) or isUsingSpyglass
						ModelAlias.alias.avatar.rightArm:setParentType((context == "FIRST_PERSON" or isSwingingArm) and "RightArm" or "Body")
						local handleRot = (Car.handleRot - Car.handleRotPrev) * delta + Car.handleRot
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3(isUsingSpyglass and -10 or 0, 0, 0) or vectors.vec3(55 + handleRot * 0.25, 0, -15))
					end, "right_arm_render")
				elseif state == "CAR_GUN_MAIN_HAND" then
					--乗車中に銃を持っているとき
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if player:isSwingingArm() and not player:isLeftHanded() then
							ModelAlias.alias.avatar.rightArm:setParentType("RightArm")
						else
							ModelAlias.alias.avatar.rightArm:setParentType("Body")
						end
						if player:getActiveItem().id == "minecraft:crossbow" then
							Arms:setArmState("CROSSBOW", "CROSSBOW")
						end
					end, "right_arm_tick")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						ModelAlias.alias.avatar.rightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3(60, 0, 0) or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 80, headRot.y, 0))
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "CAR" then
					--乗車中
					events.TICK:register(function ()
						Arms:processArmSwingCount()
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						local isUsingSpyglass = player:getActiveItem().id == "minecraft:spyglass" and ((activeHand == "MAIN_HAND" and isLeftHanded) or (activeHand == "OFF_HAND" and not isLeftHanded))
						local isSwingingArm = (player:isSwingingArm() and isLeftHanded) or isUsingSpyglass
						ModelAlias.alias.avatar.leftArm:setParentType((context == "FIRST_PERSON" or isSwingingArm) and "LeftArm" or "Body")
						local handleRot = (Car.handleRot - Car.handleRotPrev) * delta + Car.handleRot
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3(isUsingSpyglass and -10 or 0, 0, 0) or vectors.vec3(55 + handleRot * -0.25, 0, 15))
					end, "left_arm_render")
				elseif state == "CAR_GUN_MAIN_HAND" then
					--乗車中に銃を持っているとき
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if player:isSwingingArm() and player:isLeftHanded() then
							ModelAlias.alias.avatar.leftArm:setParentType("LeftArm")
						else
							ModelAlias.alias.avatar.leftArm:setParentType("Body")
						end
						if player:getActiveItem().id == "minecraft:crossbow" then
							Arms:setArmState("CROSSBOW", "CROSSBOW")
						end
					end, "left_arm_tick")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						ModelAlias.alias.avatar.leftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3(60, 0, 0) or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5 + 80, headRot.y, 0))
					end, "left_arm_render")
				end
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
					right = vectors.vec3(-0.5, -1, -3);
					left = vectors.vec3(0.5, -1, -3);
				};

				thirdPersonPos = {
					right = vectors.vec3(0, -1, -5);
					left = vectors.vec3(0, -1, -5);
				};
			};

			put = {
				type = "HIDDEN";
			};
		};

		sound = {
			name = "minecraft:entity.iron_golem.hurt";
			pitch = 2;
		};
	};

	placementObjects = {

	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_1.Car, ModelAlias.alias.avatar.head.Background};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 0, 0);
					pos = vectors.vec3(0, 10, 50);
				};

				fin = {
					rot = vectors.vec3(-10, 245, 0);
					pos = vectors.vec3(-368.3, 24.2, -1240.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					events.RENDER:register(function ()
						local wheelEffectOpacity = models.models.ex_skill_1.Car.CarWheelEffectOpacity:getAnimScale().x
						for _, modelPart in ipairs({models.models.ex_skill_1.Car.CarWheelFR.WheelFREffect, models.models.ex_skill_1.Car.CarWheelFL.WheelFLEffect, models.models.ex_skill_1.Car.CarWheelRR.WheelRREffect, models.models.ex_skill_1.Car.CarWheelRL.WheelRLEffect}) do
							modelPart:setOpacity(wheelEffectOpacity)
						end
					end, "ex_skill_1_render")
					for _, modelPart in ipairs(ModelAlias.alias.avatar.head.Ears:getChildren()) do
						modelPart:setOffsetPivot(0, 0, -2)
					end
					local shouldLitLight = world.getLightLevel(player:getPos()) <= 7
					for _, modelPart in ipairs({models.models.ex_skill_1.Car.CarBody.RightCarLight.RightCarLightBase2.RightCarLight, models.models.ex_skill_1.Car.CarBody.LeftCarLight.LeftCarLightBase2.LeftCarLight, models.models.ex_skill_1.Car.CarBody.CarRearLight}) do
						modelPart:setPrimaryRenderType(shouldLitLight and "EMISSIVE_SOLID" or "CUTOUT")
					end
					self.exSkill.primary.engineSound = sounds:playSound("minecraft:entity.bee.loop_aggressive", player:getPos(), 0.5, 1, true)
					FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 107, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 50 and host:isHost() then
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.TransitionFilter:setOpacity(models.models.ex_skill_1.Gui.TransitionFilterOpacity:getAnimScale().x)
						end, "ex_skill_1_transition_render")
						models.models.ex_skill_1.Gui.TransitionFilter:setScale(client:getScaledWindowSize():augmented(1))
						models.models.ex_skill_1.Gui:setVisible(true)
					elseif tick == 62 and host:isHost() then
						events.RENDER:remove("ex_skill_1_transition_render")
						models.models.ex_skill_1.Gui:setVisible(false)
					elseif tick == 70 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Car.CarWheelFR.WheelFREffect, models.models.ex_skill_1.Car.CarWheelFL.WheelFLEffect, models.models.ex_skill_1.Car.CarWheelRR.WheelRREffect, models.models.ex_skill_1.Car.CarWheelRL.WheelRLEffect}) do
							modelPart:setVisible(true)
						end
					elseif tick == 73 then
						for _, modelPart in ipairs(ModelAlias.alias.avatar.head.Ears:getChildren()) do
							modelPart:setOffsetPivot()
						end
					elseif tick == 107 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 12, true)
					elseif tick == 110 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Car.CarWheelFR.WheelFREffect, models.models.ex_skill_1.Car.CarWheelFL.WheelFLEffect, models.models.ex_skill_1.Car.CarWheelRR.WheelRREffect, models.models.ex_skill_1.Car.CarWheelRL.WheelRLEffect}) do
							modelPart:setVisible(false)
						end
						sounds:playSound("minecraft:block.gravel.hit", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Car), 0.3, 0.5)
					elseif tick == 119 then
						FaceParts:setEmotion("NARROW", "NARROW", "CLOSED", 25, true)
					elseif tick == 125 then
						sounds:playSound("minecraft:item.spyglass.use", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head), 0.5, 1.5)
					elseif tick == 142 then
						self.exSkill.primary.engineSound:stop()
						self.exSkill.primary.engineSound = nil
						sounds:playSound("minecraft:block.iron_door.open", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Car), 0.5, 0.75)
					elseif tick == 144 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 12, true)
					elseif tick == 156 then
						FaceParts:setEmotion("CENTER", "NORMAL", "CLOSED", 19, true)
					elseif tick == 170 then
						sounds:playSound("minecraft:block.iron_door.close", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Car), 1, 1)
					elseif tick == 175 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", 10, true)
					elseif tick == 179 then
						ModelAlias.alias.avatar.rightArmBottom.Mic:setVisible(true)
					elseif tick == 184 then
						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 1.5)
					elseif tick == 185 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "ANXIOUS", 40, true)
					end

					if tick <= 54 then
						local bodyYaw = player:getBodyYaw()
						local avatarPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						local velocity = vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -0.5, 0, 1, 0)
						particles:newParticle("minecraft:cloud", vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 8 - 4, math.random() * 4, 10, 0, 1, 0):add(avatarPos)):setColor(1, 1, 1, 0.25):setVelocity(velocity)
						particles:newParticle("minecraft:end_rod", vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 1 - 0.5, math.random() * 1 + 1, math.random() * 1 + 1, 0, 1, 0):add(avatarPos)):setScale(0.25):setVelocity(velocity:copy():scale(-1.5)):setColor(0.988, 1, 0.824)
					end
					if tick <= 116 then
						local bodyYaw = player:getBodyYaw()
						local carPos = models.models.ex_skill_1.Car:getAnimPos()
						if tick <= 95 then
							local particleScale = tick >= 68 and 5 or 2
							for _, modelPart in ipairs({models.models.ex_skill_1.Car.WheelFRAnchor, models.models.ex_skill_1.Car.WheelFLAnchor, models.models.ex_skill_1.Car.WheelRRAnchor, models.models.ex_skill_1.Car.WheelRLAnchor}) do
								particles:newParticle("minecraft:campfire_cosy_smoke", ModelUtils.getModelWorldPos(modelPart)):setScale(particleScale):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + 180, self.exSkill.primary.carPosPrev:copy():sub(carPos):normalized():scale(0.5), 0, 1, 0)):setGravity(math.random() * -0.03):setLifetime(math.random(8, 16))
							end
						end
						self.exSkill.primary.engineSound:setPos(ModelUtils.getModelWorldPos(models.models.ex_skill_1.Car))
						self.exSkill.primary.engineSound:setPitch(0.2 + carPos:copy():sub(self.exSkill.primary.carPosPrev):length() * 0.01)
						self.exSkill.primary.carPosPrev = carPos
					end
					if tick >= 72 and tick <= 95 then
						local particleDir = player:getBodyYaw() * -1 - 60
						for _, modelPart in ipairs({models.models.ex_skill_1.Car.WheelFRAnchor, models.models.ex_skill_1.Car.WheelFLAnchor, models.models.ex_skill_1.Car.WheelRRAnchor, models.models.ex_skill_1.Car.WheelRLAnchor}) do
							local partName = modelPart:getName()
							local isRightWheel = partName:find("Wheel%wRAnchor$") ~= nil
							if tick < 78 or isRightWheel then
								local pos = ModelUtils.getModelWorldPos(modelPart):add(vectors.rotateAroundAxis(particleDir, 0, 0, 0.8, 0, 1, 0))
								particles:newParticle("minecraft:electric_spark", pos):setColor(1, 0.953, 0.408):setScale(1.2):setVelocity(vectors.rotateAroundAxis(particleDir, 0, math.random() * 0.15, 0.5, 0, 1, 0))
								particles:newParticle("minecraft:campfire_cosy_smoke", pos):setScale(isRightWheel and 4 or 2):setVelocity(vectors.rotateAroundAxis(particleDir, 0, 0, 1, 0, 1, 0)):setGravity(math.random() * -0.15):setLifetime(math.random(2, 4))
							end
						end
						sounds:playSound("minecraft:block.gravel.hit", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Car), 0.3, 0.5)
					elseif tick >= 122 and tick < 142 then
						self.exSkill.primary.engineSound:setVolume(tick * -0.025 + 3.55)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					events.RENDER:remove("ex_skill_1_render")
					ModelAlias.alias.avatar.rightArmBottom.Mic:setVisible(false)
					self.exSkill.primary.carPosPrev = vectors.vec3()
					if forcedStop then
						if host:isHost() then
							events.RENDER:remove("ex_skill_1_transition_render")
							models.models.ex_skill_1.Gui:setVisible(false)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Car.CarWheelFR.WheelFREffect, models.models.ex_skill_1.Car.CarWheelFL.WheelFLEffect, models.models.ex_skill_1.Car.CarWheelRR.WheelRREffect, models.models.ex_skill_1.Car.CarWheelRL.WheelRLEffect}) do
							modelPart:setVisible(false)
						end
						for _, modelPart in ipairs(ModelAlias.alias.avatar.head.Ears:getChildren()) do
							modelPart:setOffsetPivot()
						end
						if self.exSkill.primary.engineSound ~= nil then
							self.exSkill.primary.engineSound:stop()
							self.exSkill.primary.engineSound = nil
						end
					end
				end;
			};

			---前ティックの車の位置
			carPosPrev = vectors.vec3();

			---車のエンジン音のインスタンス
			---@type Sound|nil
			engineSound = nil;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					if Allay.perchCount <= 0 and ModelAlias.alias.avatar.head.Allay ~= nil then
						ModelAlias.alias.avatar.head.Allay:setPos(0, isVisible and 33 or 32, 3)
					end
					ModelAlias.alias.avatar.head.SunVisor:setVisible(not isVisible)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration, isShownInGui)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", duration, true)
					elseif type == "SWEAT" then
						if isShownInGui then
							FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", duration, true)
						else
							FaceParts:setEmotion("SURPRISED", "SURPRISED", "SMALL", 60, true)
						end
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
		callbacks = {
			onBeforeModelCopy = function ()
				if ModelAlias.alias.avatar.head.Allay ~= nil then
					ModelAlias.alias.avatar.head.Allay:setVisible(false)
				end
			end;

			onAfterModelCopy = function ()
				if ModelAlias.alias.avatar.head.Allay ~= nil then
					ModelAlias.alias.avatar.head.Allay:setVisible(true)
				end
				if models.script_head_block ~= nil and models.script_head_block.Skull ~= nil then
					models.script_head_block.Skull:setRot()
					models.script_head_block.Skull:setPrimaryRenderType("CUTOUT")
				end
				if models.portrait_head_block ~= nil and models.portrait_head_block.Skull ~= nil then
					models.portrait_head_block.Skull:setRot()
					models.portrait_head_block.Skull:setPrimaryRenderType("CUTOUT")
				end
			end;
		};
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
				if ModelAlias.alias.avatar.head.Allay ~= nil then
					ModelAlias.alias.avatar.head.Allay:setVisible(false)
				end
			end;

			onAfterModelCopy = function ()
				if ModelAlias.alias.avatar.head.Allay ~= nil then
					ModelAlias.alias.avatar.head.Allay:setVisible(true)
				end
			end;

			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.Ears.RightEar:setRot(-60, -20, 0)
				ModelAlias.alias.dummy_avatar.head.Ears.LeftEar:setRot(-60, 20, 0)
				ModelAlias.alias.dummy_avatar.body.Hairs.FrontHair:setRot(35, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(10, 0, 0)
				ModelAlias.alias.dummy_avatar.head:setPrimaryRenderType("CUTOUT")
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(30, 0, -10)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(80, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Hairs.FrontHair:setRot(0, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(-20, 0, -5)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = true;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.Hairs};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 150;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
						max = 150;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Tail};

				x = {
					vertical = {
						min = -70;
						neutral = 60;
						max = 60;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};

						bodyY = {
							multiplayer = 80;
							min = -70;
							max = 60;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = 0;
							max = 60;
						};
					};

					horizontal = {
						min = -70;
						neutral = 0;
						max = 60;
						sneakOffset = 30;

						bodyX = {
							multiplayer = 160;
							min = -70;
							max = 60;
						};
					};
				};

				y = {
					vertical = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyZ = {
							multiplayer = -160;
							min = -50;
							max = 50;
						};
					};

					horizontal = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyRot = {
							multiplayer = 0.05;
							min = -50;
							max = 50;
						};
					};
				};
			};

		{
			models = {ModelAlias.alias.avatar.head.HairTail};

			x = {
				vertical = {
					min = -90;
					neutral = 0;
					max = 90;

					headRotMultiplayer = -1;

					headX = {
						multiplayer = -40;
						min = -90;
						max = 90;
					};
				};

				horizontal = {
					min = -45;
					neutral = 45;
					max = 45;

					headX = {
						multiplayer = -40;
						min = -45;
						max = 45;
					};
				};
			};
		};
		{
			models = {ModelAlias.alias.avatar.head.HairTail.HairTailZPivot};

			z = {
				vertical = {
					min = -60;
					neutral = 0;
					max = 0;

					headZ = {
						multiplayer = -40;
						min = -60;
						max = 0;
					};

					headRot = {
						multiplayer = 0.05;
						min = -60;
						max = 0;
					};

					bodyY = {
						multiplayer = 40;
						min = -60;
						max = 0;
					};
				};
			};
		};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---お供のアレイを制御するクラス
		---@type Character12b.Allay
		Allay = require("scripts.allay")

		---セイアのオープンカーを制御するクラス
		Car = require("scripts.car")

		Allay:init()
		Car:init()

		ModelAlias.alias.avatar.head.SunVisor.AllayPin:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/allay/allay.png")
	end;
}

return BlueArchiveCharacter
