---右目のテクスチャの列挙型
---@alias Character06c.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "HALF" # 半分目
---| "ANGRY" # 怒った目
---| "CENTER" # 少し反対側を見る目
---| "NARROW_CENTER" # 少し閉じつつ少し反対側を見る目
---| "NARROW_ANGRY_CENTER" # 少し閉じつつ怒りつつ少し反対側を見る目
---| "NARROW_ANGRY" # 少し閉じつつ怒った目

---左目のテクスチャの列挙型
---@alias Character06c.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "HALF" # 半分目
---| "ANGRY" # 怒った目
---| "NARROW" # 少し閉じた目
---| "NARROW_ANGRY" # 少し閉じつつ怒った目
---| "CENTER" # 少し反対側を見る目
---| "NARROW_ANGRY_INVERTED" # 少し閉じつつ怒りつつ反対側を見る目
---| "INVERTED" # 反対側を見る目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目

---口のテクスチャの列挙型
---@alias Character06c.MouthTextures
---| "NORMAL" # 通常
---| "TRIANGLE" # 三角口
---| "ANGRY" # への口
---| "CLOSED" # 閉じた口
---| "CLOSED2" # 閉じた口2

---キャラクター固有の腕の状態
---@alias Character06c.AdditionalArmState
---| "DRONE_HOLD" # ドローンに捕まっている時の腕
---| "DRONE" # ドローン飛行中の腕
---| "BICYCLE" # 自転車に乗っている時の腕
---| "BICYCLE_GUN" # 自転車に乗りながら銃を構える腕
---| "BICYCLE_AWAIT" # 自転車で待機中の腕

---@class (exact) Character06c.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character06c.RightEyeTextures 右目の表情名
---@field public leftEye Character06c.LeftEyeTextures 左目の表情名
---@field public mouth Character06c.MouthTextures 口の表情名

---@class (exact) Character06c.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character06c.EmotionSet ダメージを受けたとき
---@field public onSleep? Character06c.EmotionSet ベッドで寝ているとき

---@class (exact) Character06c.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character06c, right: Character06c.RightEyeTextures, left: Character06c.LeftEyeTextures, mouth: Character06c.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character06c.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character06c.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character06c.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character06c.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character06c.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character06c.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character06c.ArmsCallbacksSet : BlueArchiveCharacter.ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(self: Character06c, right: Arms.BaseArmState|Character06c.AdditionalArmState, left: Arms.BaseArmState|Character06c.AdditionalArmState): {right?: Arms.BaseArmState|Character06c.AdditionalArmState, left?: Arms.BaseArmState|Character06c.AdditionalArmState}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(self: Character06c, state: Arms.BaseArmState|Character06c.AdditionalArmState): boolean? 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: Character06c, state: Arms.BaseArmState|Character06c.AdditionalArmState): boolean? 左腕の追加処理

---@class (exact) Character06c.ArmsStruct : BlueArchiveCharacter.ArmsStruct 腕のデータ構造体
---@field public callbacks? Character06c.ArmsCallbacksSet 腕の制御のコールバック関数群

---@class (exact) Character06c : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character06c.FacePartsStruct 目や口による表情
---@field public arms Character06c.ArmsStruct 腕

---@type Character06c
local BlueArchiveCharacter = {
	basic = {
		avatarName = "06c_Shiroko_Riding";

		birth = {
			month = 5;
			day = 16;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(6, 0); --必須
			CLOSED2 = vectors.vec2(7, 0);
			HALF = vectors.vec2(8, 0);
			ANGRY = vectors.vec2(10, 0);
			CENTER = vectors.vec2(12, 0);
			NARROW_CENTER = vectors.vec2(13, 0);
			NARROW_ANGRY_CENTER = vectors.vec2(15, 0);
			NARROW_ANGRY = vectors.vec2(18, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(5, 0); --必須
			CLOSED2 = vectors.vec2(6, 0);
			HALF = vectors.vec2(8, 0);
			ANGRY = vectors.vec2(10, 0);
			NARROW = vectors.vec2(13, 0);
			NARROW_ANGRY = vectors.vec2(15, 0);
			CENTER = vectors.vec2(16, 0);
			NARROW_ANGRY_INVERTED = vectors.vec2(18, 0);
			INVERTED = vectors.vec2(19, 0);
			ANGRY_INVERTED = vectors.vec2(20, 0);
		};

		mouth = {
			TRIANGLE = vectors.vec2(0, 0);
			ANGRY = vectors.vec2(1, 0);
			CLOSED = vectors.vec2(2, 0);
			CLOSED2 = vectors.vec2(3, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				if left == "GUN_OFF_HAND" and right == "GUN_MAIN_HAND" then
					if Character06c_Drone.dronePosition ~= "NONE" then
						return {right = "GUN_MAIN_HAND", left = "DRONE_HOLD"}
					elseif Character06c_Bicycle.bicycleEnabled then
						return {right = "BICYCLE_GUN", left = "BICYCLE"}
					end
				elseif left == "GUN_MAIN_HAND" and right == "GUN_OFF_HAND" then
					if Character06c_Drone.dronePosition ~= "NONE" then
						return {right = "DRONE_HOLD", left = "GUN_MAIN_HAND"}
					elseif Character06c_Bicycle.bicycleEnabled then
						return {right = "BICYCLE", left = "BICYCLE_GUN"}
					end
				elseif left == "DEFAULT" and right == "DEFAULT" then
					if Character06c_Drone ~= nil and Character06c_Bicycle ~= nil then
						if Character06c_Drone.dronePosition == "RIGHT" then
							return {right = "DRONE", left = "DRONE_HOLD"}
						elseif Character06c_Drone.dronePosition == "LEFT" then
							return {right = "DRONE_HOLD", left = "DRONE"}
						elseif Character06c_Bicycle.bicycleEnabled then
							return {right = "BICYCLE", left = "BICYCLE"}
						end
					end
				end
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "GUN_MAIN_HAND" then
					events.RENDER:register(function (_, context)
						local isLeftHanded = player:isLeftHanded()
						if Character06c_Drone.dronePosition == "RIGHT" and isLeftHanded then
							local isSwingingArm = player:isSwingingArm() and isLeftHanded
							ModelAlias.alias.avatar.rightArm:setParentType(context == "FIRST_PERSON" and "RightArm" or (isSwingingArm and "LeftArm" or "Body"))
							if isSwingingArm then
								ModelAlias.alias.avatar.rightArm:setRot()
							end
						end
					end, "right_arm_render")
				elseif state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						if Character06c_Bicycle.bicycleEnabled and animations["models.main"]["bicycle_idle"]:getTime() * 4 > 0 then
							Arms:setArmState("BICYCLE", nil)
						end
					end, "right_arm_tick")
					Arms:registerRightArmRenderEvent("GUN_OFF_HAND")
					return true
				elseif state == "DRONE_HOLD" then
					--ドローンに掴まる腕
					events.RENDER:register(function (_, context)
						ModelAlias.alias.avatar.rightArm:setParentType(context == "FIRST_PERSON" and "RightArm" or "Body")
					end, "right_arm_render")
				elseif state == "DRONE" then
					--ドローンぶら下がり
					local isHoldingItem = false
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						isHoldingItem = (player:isLeftHanded() and player:getHeldItem(true).id or player:getHeldItem(false).id) ~= "minecraft:air"
					end, "right_arm_tick")
					events.RENDER:remove("right_arm_render")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						local isUsingSpyglass = player:getActiveItem().id == "minecraft:spyglass" and ((activeHand == "MAIN_HAND" and not isLeftHanded) or (activeHand == "OFF_HAND" and isLeftHanded))
						local isSwingingArm = (player:isSwingingArm() and not isLeftHanded) or isUsingSpyglass
						ModelAlias.alias.avatar.rightArm:setParentType((context == "FIRST_PERSON" or isSwingingArm) and "RightArm" or "Body")
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3((isHoldingItem and not isUsingSpyglass) and 20 or 0, 0, 0) or vectors.vec3(isHoldingItem and 20 or 0, 0, 10 + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5))
					end, "right_arm_render")
				elseif state == "BICYCLE" then
					--自転車
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if animations["models.main"]["bicycle_idle"]:getTime() * 4 == 0 then
							Arms:setArmState(Gun.currentGunPosition == "LEFT" and "GUN_OFF_HAND" or "BICYCLE_AWAIT", nil)
						end
					end, "right_arm_tick")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						local isUsingSpyglass = player:getActiveItem().id == "minecraft:spyglass" and ((activeHand == "MAIN_HAND" and not isLeftHanded) or (activeHand == "OFF_HAND" and isLeftHanded))
						local isSwingingArm = (player:isSwingingArm() and not isLeftHanded) or isUsingSpyglass
						ModelAlias.alias.avatar.rightArm:setParentType((context == "FIRST_PERSON" or isSwingingArm) and "RightArm" or "Body")
						local bicycleIdleFactor = 1 - animations["models.main"]["bicycle_idle"]:getTime() * 4
						local currentHandleRot = (Character06c_Bicycle.handleRot - Character06c_Bicycle.handleRotPrev) * delta + Character06c_Bicycle.handleRot
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3(isUsingSpyglass and 40 or 20, 0, 0) or vectors.vec3(50 * (1 - bicycleIdleFactor) + 20, 8 * (1 - bicycleIdleFactor) + 8 * (currentHandleRot / 15), 0))
					end, "right_arm_render")
				elseif state == "BICYCLE_GUN" then
					--自転車で銃を持っているとき
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
						local bicycleIdleFactor = 1 - animations["models.main"]["bicycle_idle"]:getTime() * 4
						ModelAlias.alias.avatar.rightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3(60, 0, 0) or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + (1 - bicycleIdleFactor) * 35 + 105, headRot.y, 0))
					end, "right_arm_render")
				elseif state == "BICYCLE_AWAIT" then
					--自転車で待機中
					events.TICK:register(function ()
						if animations["models.main"]["bicycle_idle"]:getTime() * 4 > 0 then
							Arms:setArmState("BICYCLE", nil)
						end
					end, "right_arm_tick")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "GUN_MAIN_HAND" then
					events.RENDER:register(function (_, context)
						local isLeftHanded = player:isLeftHanded()
						if Character06c_Drone.dronePosition == "LEFT" and not isLeftHanded then
							local isSwingingArm = player:isSwingingArm() and not isLeftHanded
							ModelAlias.alias.avatar.leftArm:setParentType(context == "FIRST_PERSON" and "LeftArm" or (isSwingingArm and "RightArm" or "Body"))
							if isSwingingArm then
								ModelAlias.alias.avatar.leftArm:setRot()
							end
						end
					end, "left_arm_render")
				elseif state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						if Character06c_Bicycle.bicycleEnabled and animations["models.main"]["bicycle_idle"]:getTime() * 4 > 0 then
							Arms:setArmState(nil, "BICYCLE")
						end
					end, "left_arm_tick")
					Arms:registerLeftArmRenderEvent("GUN_OFF_HAND")
					return true
				elseif state == "DRONE_HOLD" then
					--ドローンに掴まる腕
					events.RENDER:register(function (_, context)
						ModelAlias.alias.avatar.leftArm:setParentType(context == "FIRST_PERSON" and "LeftArm" or "Body")
					end, "left_arm_render")
				elseif state == "DRONE" then
					--ドローンぶら下がり
					local isHoldingItem = false
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						isHoldingItem = (player:isLeftHanded() and player:getHeldItem(false).id or player:getHeldItem(true).id) ~= "minecraft:air"
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						local isUsingSpyglass = player:getActiveItem().id == "minecraft:spyglass" and ((activeHand == "MAIN_HAND" and isLeftHanded) or (activeHand == "OFF_HAND" and not isLeftHanded))
						local isSwingingArm = (player:isSwingingArm() and isLeftHanded) or isUsingSpyglass
						ModelAlias.alias.avatar.leftArm:setParentType((context == "FIRST_PERSON" or isSwingingArm) and "LeftArm" or "Body")
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3((isHoldingItem and not isUsingSpyglass) and 20 or 0, 0, 0) or vectors.vec3(isHoldingItem and 20 or 0, 0, -10 + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5))
					end, "left_arm_render")
				elseif state == "BICYCLE" then
					--自転車
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if animations["models.main"]["bicycle_idle"]:getTime() * 4 == 0 then
							Arms:setArmState(nil, Gun.CurrentGunPosition == "RIGHT" and "GUN_OFF_HAND" or "BICYCLE_AWAIT")
						end
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						local isUsingSpyglass = player:getActiveItem().id == "minecraft:spyglass" and ((activeHand == "MAIN_HAND" and isLeftHanded) or (activeHand == "OFF_HAND" and not isLeftHanded))
						local isSwingingArm = (player:isSwingingArm() and isLeftHanded) or isUsingSpyglass
						ModelAlias.alias.avatar.leftArm:setParentType((context == "FIRST_PERSON" or isSwingingArm) and "LeftArm" or "Body")
						local bicycleIdleFactor = 1 - animations["models.main"]["bicycle_idle"]:getTime() * 4
						local currentHandleRot = (Character06c_Bicycle.handleRot - Character06c_Bicycle.handleRotPrev) * delta + Character06c_Bicycle.handleRot
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3(isUsingSpyglass and 40 or 20, 0, 0) or vectors.vec3(50 * (1 - bicycleIdleFactor) + 20, -8 * (1 - bicycleIdleFactor) + 8 * (currentHandleRot / 15), 0))
					end, "left_arm_render")
				elseif state == "BICYCLE_GUN" then
					--自転車で銃を持っているとき
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
						local bicycleIdleFactor = 1 - animations["models.main"]["bicycle_idle"]:getTime() * 4
						ModelAlias.alias.avatar.leftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3(60, 0, 0) or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5 + (1 - bicycleIdleFactor) * 35 + 105, headRot.y, 0))
					end, "left_arm_render")
				elseif state == "BICYCLE_AWAIT" then
					--自転車で待機中
					events.TICK:register(function ()
						if animations["models.main"]["bicycle_idle"]:getTime() * 4 > 0 then
							Arms:setArmState(nil, "BICYCLE")
						end
					end, "left_arm_tick")
				end
			end;
		};
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 1.4;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-1.5, 0, -4);
					left = vectors.vec3(1.5, 0, -4);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.5, -0.5, -3);
					left = vectors.vec3(1.5, -0.5, -3);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, 2, 2.75);
					left = vectors.vec3(0, 2, 2.75);
				};

				rot = {
					right = vectors.vec3(-135, -90, 0);
					left = vectors.vec3(-135, 90, 0);
				};
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

			models = {ModelAlias.alias.avatar.lowerBody.Bicycle};

			animations = {"main", "bicycle"};

			camera = {
				start = {
					rot = vectors.vec3(60, 0, 0);
					pos = vectors.vec3(-71, 28, 0);
				};

				fin = {
					rot = vectors.vec3(0, 40, -25);
					pos = vectors.vec3(-119, 27, -938.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED2", 40, true)
					self.exSkill.primary.windSound = sounds:playSound("minecraft:item.elytra.flying", player:getPos(), 0.05, 2)
				end;

				onAnimationTick = function (self, tick)
					if tick == 40 then
						FaceParts:setEmotion("NORMAL", "INVERTED", "CLOSED2", 7, true)
					elseif tick == 27 and host:isHost() then
						sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.1, 0.75)
					elseif tick == 47 then
						FaceParts:setEmotion("NARROW_ANGRY", "NARROW_ANGRY_INVERTED", "TRIANGLE", 35, true)
					elseif tick >= 58 and tick < 80 then
						if tick == 58 then
							self.exSkill.primary.windSound:stop()
							self.exSkill.primary.windSound = nil
						end
						local bicycleYaw = ModelAlias.alias.avatar.root:getAnimRot().y + player:getBodyYaw() * -1
						local bicyclePos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Bicycle)
						local frontWheelPos = vectors.rotateAroundAxis(bicycleYaw, 0, 0, 0.5625, 0, 1, 0):add(bicyclePos)
						local backWheelPos = vectors.rotateAroundAxis(bicycleYaw, 0, 0, -0.5625, 0, 1, 0):add(bicyclePos)
						for _ = 1, 5 do
							particles:newParticle("minecraft:electric_spark", frontWheelPos):setColor(0.973, 0.714, 0.29):setScale(0.5):setVelocity(math.random() * 0.5 - 0.25, math.random() * 0.25, math.random() * 0.5 - 0.25)
							particles:newParticle("minecraft:electric_spark", backWheelPos):setColor(0.973, 0.714, 0.29):setScale(0.5):setVelocity(math.random() * 0.5 - 0.25, math.random() * 0.25, math.random() * 0.5 - 0.25)
							particles:newParticle("minecraft:campfire_cosy_smoke", frontWheelPos):setVelocity(math.random() * 0.2 - 0.1, 0.015, math.random() * 0.2 - 0.1)
							particles:newParticle("minecraft:campfire_cosy_smoke", backWheelPos):setVelocity(math.random() * 0.2 - 0.1, 0.015, math.random() * 0.2 - 0.1)
						end
						local particleBlock = world.getBlockState(bicyclePos:copy():sub(0, 0.5, 0)).id
						if particleBlock ~= "minecraft:air" and particleBlock ~= "minecraft:void_air" and particleBlock ~= "minecraft:cave_air" then
							for _ = 1, 5 do
								particles:newParticle("minecraft:block" .. particleBlock, frontWheelPos)
								particles:newParticle("minecraft:block" .. particleBlock, backWheelPos)
							end
						end
						sounds:playSound("minecraft:block.gravel.hit", bicyclePos, 0.1, 0.5)
						sounds:playSound("minecraft:block.grindstone.use", bicyclePos, 0.1, 3)
					elseif tick == 82 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 15, true)
						ModelAlias.alias.avatar.lowerBody.Bicycle.Shaft.Shaft8.WaterBottle:moveTo(ModelAlias.alias.avatar.rightArmBottom)
					elseif tick == 97 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TRIANGLE", 4, true)
					elseif tick == 101 then
						FaceParts:setEmotion("NARROW_ANGRY", "NARROW_ANGRY_INVERTED", "CLOSED2", 26, true)
					elseif tick == 109 then
						sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.25, 0.5)
						if host:isHost() then
							local windowSize = client:getWindowSize()
							models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(38))
							local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw() + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.5)), 0, 1, 0):scale(16 / 0.9375)
							models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
							models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
							if StringUtils.isNewerOrEqualVersion(client:getVersion(), "1.21") then
								models.models.ex_skill_1.CameraBackground.Background:setRot(0, 0, renderer:getCameraRot().z)
							end
							models.models.ex_skill_1.CameraBackground:setVisible(true)
						end
					end
					if tick < 58 then
						ModelAlias.alias.avatar.lowerBody.Bicycle.Wheels.Chain:setUVPixels(tick % 2, 0)
						self.exSkill.primary.windSound:setVolume(math.clamp(16 - client:getCameraPos():sub(ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)):length(), 0, 8) / 160)
					end
					if tick < 69 then
						local bodyYaw = player:getBodyYaw()
						local avatarPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						particles:newParticle("minecraft:cloud", vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 8 - 4, math.random() * 4, 10, 0, 1, 0):add(avatarPos)):setColor(1, 1, 1, 0.25):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -0.5, 0, 1, 0))
					end
				end;

				onPostAnimation = function ()
					if ModelAlias.alias.avatar.rightArmBottom.WaterBottle ~= nil then
						ModelAlias.alias.avatar.rightArmBottom.WaterBottle:moveTo(ModelAlias.alias.avatar.lowerBody.Bicycle.Shaft.Shaft8)
					end
					if host:isHost() then
						models.models.ex_skill_1.CameraBackground:setVisible(false)
					end
				end;
			};

			---風切り音
			---@type Sound|nil
			windSound = nil;
		};
	};

	costume = {
		isAltCostumeEnabled = false;
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "CLOSED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL","NORMAL", "ANGRY", duration, true)
					elseif type == "SWEAT" then
						if not Character06c_Bicycle.isTyreBurst then
							FaceParts:setEmotion("NARROW_ANGRY", "NARROW_ANGRY", "ANGRY", duration, true)
						else
							FaceParts:setEmotion("SURPRISED", "SURPRISED", "ANGRY", 60, true)
						end
					end
				end
			end;

			onStop = function(_, _, forcedStop)
				if not forcedStop then
					FaceParts:resetEmotion();
				end
			end;
		};
	};

	headModel = {
		callbacks = {
			onBeforeModelCopy = function ()
				ModelAlias.alias.avatar.head:setRot()
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
				if ModelAlias.alias.avatar.root.Drone ~= nil then
					ModelAlias.alias.avatar.root.Drone:setVisible(false)
				end
			end;

			onAfterModelCopy = function ()
				if ModelAlias.alias.avatar.root.Drone ~= nil then
					ModelAlias.alias.avatar.root.Drone:setVisible(true)
				end
			end;

			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.Ears.RightEarPivot:setRot(-49.02, -11.44, -9.77)
				ModelAlias.alias.dummy_avatar.head.Ears.LeftEarPivot:setRot(-49.02, 11.44, 9.77)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = true;
	};

	physics = {
		physicData = {};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---視覚的なミサイルオブジェクトのインスタンスクラス
		---@type Character06c.DroneMissile
		Character06c_DroneMissile = require("scripts.drone_missile")

		---視覚的なミサイルオブジェクトのマネージャークラス
		---@type Character06c.DroneMissileManager
		Character06c_DroneMissileManager = require("scripts.drone_missile_manager")
		Character06c_DroneMissileManager = Character06c_DroneMissileManager.new()

		---ドローンを制御するクラス
		Character06c_Drone = require("scripts.drone")

		---自転車を制御するクラス
		Character06c_Bicycle = require("scripts.bicycle")

		Character06c_DroneMissileManager:init()
		Character06c_Drone:init()
		Character06c_Bicycle:init()
	end;
}

return BlueArchiveCharacter
