---右目のテクスチャの列挙型
---@alias Character06a.RightEyeTextures
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
---@alias Character06a.LeftEyeTextures
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
---@alias Character06a.MouthTextures
---| "NORMAL" # 通常
---| "TRIANGLE" # 三角口
---| "ANGRY" # への口
---| "CLOSED" # 閉じた口
---| "CLOSED2" # 閉じた口2

---キャラクター固有の腕の状態
---@alias Character06a.AdditionalArmState
---| "DRONE_HOLD" # ドローンに捕まっている時の腕
---| "DRONE" # ドローン飛行中の腕
---| "BICYCLE" # 自転車に乗っている時の腕
---| "BICYCLE_GUN" # 自転車に乗りながら銃を構える腕
---| "BICYCLE_AWAIT" # 自転車で待機中の腕

---@class (exact) Character06a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character06a.RightEyeTextures 右目の表情名
---@field public leftEye Character06a.LeftEyeTextures 左目の表情名
---@field public mouth Character06a.MouthTextures 口の表情名

---@class (exact) Character06a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character06a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character06a.EmotionSet ベッドで寝ているとき

---@class (exact) Character06a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character06a, right: Character06a.RightEyeTextures, left: Character06a.LeftEyeTextures, mouth: Character06a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character06a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character06a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character06a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character06a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character06a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character06a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character06a.ArmsCallbacksSet : BlueArchiveCharacter.ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(self: Character06a, right: Arms.BaseArmState|Character06a.AdditionalArmState, left: Arms.BaseArmState|Character06a.AdditionalArmState): {right?: Arms.BaseArmState|Character06a.AdditionalArmState, left?: Arms.BaseArmState|Character06a.AdditionalArmState}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(self: Character06a, state: Arms.BaseArmState|Character06a.AdditionalArmState): boolean? 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: Character06a, state: Arms.BaseArmState|Character06a.AdditionalArmState): boolean? 左腕の追加処理

---@class (exact) Character06a.ArmsStruct : BlueArchiveCharacter.ArmsStruct 腕のデータ構造体
---@field public callbacks? Character06a.ArmsCallbacksSet 腕の制御のコールバック関数群

---@class (exact) Character06a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character06a.FacePartsStruct 目や口による表情
---@field public arms Character06a.ArmsStruct 腕

---@type Character06a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "06a_Shiroko";

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
					if Drone.dronePosition ~= "NONE" then
						return {right = "GUN_MAIN_HAND", left = "DRONE_HOLD"}
					elseif Bicycle.bicycleEnabled then
						return {right = "BICYCLE_GUN", left = "BICYCLE"}
					end
				elseif left == "GUN_MAIN_HAND" and right == "GUN_OFF_HAND" then
					if Drone.dronePosition ~= "NONE" then
						return {right = "DRONE_HOLD", left = "GUN_MAIN_HAND"}
					elseif Bicycle.bicycleEnabled then
						return {right = "BICYCLE", left = "BICYCLE_GUN"}
					end
				elseif left == "DEFAULT" and right == "DEFAULT" then
					if Drone ~= nil and Bicycle ~= nil then
						if Drone.dronePosition == "RIGHT" then
							return {right = "DRONE", left = "DRONE_HOLD"}
						elseif Drone.dronePosition == "LEFT" then
							return {right = "DRONE_HOLD", left = "DRONE"}
						elseif Bicycle.bicycleEnabled then
							return {right = "BICYCLE", left = "BICYCLE"}
						end
					end
				end
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "GUN_MAIN_HAND" then
					events.RENDER:register(function (_, context)
						local isLeftHanded = player:isLeftHanded()
						if Drone.dronePosition == "RIGHT" and isLeftHanded then
							local isSwingingArm = player:isSwingingArm() and isLeftHanded
							ModelAlias.alias.avatar.rightArm:setParentType(context == "FIRST_PERSON" and "RightArm" or (isSwingingArm and "LeftArm" or "Body"))
							if isSwingingArm then
								ModelAlias.alias.avatar.rightArm:setRot()
							end
						end
					end, "right_arm_render")
				elseif state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						if Bicycle.bicycleEnabled and animations["models.main"]["bicycle_idle"]:getTime() * 4 > 0 then
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
						local currentHandleRot = (Bicycle.handleRot - Bicycle.handleRotPrev) * delta + Bicycle.handleRot
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
						if Drone.dronePosition == "LEFT" and not isLeftHanded then
							local isSwingingArm = player:isSwingingArm() and not isLeftHanded
							ModelAlias.alias.avatar.leftArm:setParentType(context == "FIRST_PERSON" and "LeftArm" or (isSwingingArm and "RightArm" or "Body"))
							if isSwingingArm then
								ModelAlias.alias.avatar.leftArm:setRot()
							end
						end
					end, "left_arm_render")
				elseif state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						if Bicycle.bicycleEnabled and animations["models.main"]["bicycle_idle"]:getTime() * 4 > 0 then
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
						local currentHandleRot = (Bicycle.handleRot - Bicycle.handleRotPrev) * delta + Bicycle.handleRot
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
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
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

			models = {models.models.ex_skill_1.Drone};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(7, 27, -10);
				};

				fin = {
					rot = vectors.vec3(-15, 210, 5);
					pos = vectors.vec3(-14, 7, -30);
				};
			};

			callbacks = {
				onPreAnimation = function ()
					models.models.ex_skill_1.Drone.LauncherRight.ShineEffects:setColor(client:hasShaderPack() and vectors.vec3(0.5, 1, 1) or vectors.vec3(1, 1, 1))
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "TRIANGLE", 20, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 20 then
						FaceParts:setEmotion("HALF", "HALF", "TRIANGLE", 5, true)
					elseif tick == 25 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 10, true)
					elseif tick == 35 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANGRY", 10, true)
					elseif tick == 40 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "ANGRY", 30, true)
					elseif tick == 41 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 0.5, 1.5)
					end
				end;
			};
		};
	};

	costume = {
		isAltCostumeEnabled = true;

		callbacks = {
			onAltChange = function (_, isAlt)
				ModelAlias.alias.avatar.head.CMaskedH:setVisible(isAlt)
				for _, modelPart in ipairs({ModelAlias.alias.avatar.head.HairPin, ModelAlias.alias.avatar.head.HairEnds, ModelAlias.alias.avatar.body.Hairs}) do
					modelPart:setVisible(not isAlt)
				end
			end;

			onArmorChange = function (_, parts, isVisible)
				if parts == "CHEST_PLATE" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Scarf.Scarf2, ModelAlias.alias.avatar.body.Scarf.Scarf3, ModelAlias.alias.avatar.body.Scarf.Scarf4}) do
						modelPart:setVisible(not isVisible)
					end
					ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, isVisible and -0.75 or 0)
					ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, isVisible and 0.75 or 0)
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
				end
			end
		};
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
						if not Bicycle.isTyreBurst then
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
		includeModels = {ModelAlias.alias.avatar.body.Hairs};
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
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(27.5, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(12.5, 0, 0)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = true;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.Hairs.FrontHair};

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

			{
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair};

				x = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = -80;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -80;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -80;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Scarf.Scarf2};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 140;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -160;
							min = 0;
							max = 140;
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
						max = 90;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Scarf.Scarf3};

				x = {
					vertical = {
						min = 2;
						neutral = 2;
						max = 140;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -160;
							min = 2;
							max = 90;
						};

						bodyY = {
							multiplayer = -160;
							min = 2;
							max = 140;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 2;
							max = 90;
						};
					};

					horizontal = {
						min = 2;
						neutral = 90;
						max = 90;

						bodyX = {
							multiplayer = -160;
							min = 2;
							max = 90;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Scarf.Scarf2.Scarf2, ModelAlias.alias.avatar.body.Scarf.Scarf3.Scarf3, ModelAlias.alias.avatar.body.Scarf.Scarf4.Scarf4};

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
				models = {ModelAlias.alias.avatar.body.Scarf.Scarf4};

				x = {
					vertical = {
						min = -140;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -160;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 160;
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
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---視覚的なミサイルオブジェクトのインスタンスクラス
		---@type Character06a.DroneMissile
		DroneMissile = require("scripts.drone_missile")

		---視覚的なミサイルオブジェクトのマネージャークラス
		---@type Character06a.DroneMissileManager
		DroneMissileManager = require("scripts.drone_missile_manager")
		DroneMissileManager = DroneMissileManager.new()

		---ドローンを制御するクラス
		Drone = require("scripts.drone")

		---自転車を制御するクラス
		Bicycle = require("scripts.bicycle")

		DroneMissileManager:init()
		Drone:init()
		Bicycle:init()
	end;
}

return BlueArchiveCharacter
