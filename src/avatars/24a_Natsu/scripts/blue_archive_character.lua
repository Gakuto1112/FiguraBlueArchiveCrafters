---右目のテクスチャの列挙型
---@alias Character24a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "ANGRY" # 怒った目

---左目のテクスチャの列挙型
---@alias Character24a.LeftEyeTextures
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
---@alias Character24a.MouthTextures
---| "NORMAL" # 通常
---| "TRIANGLE" # 三角口
---| "HAT" # への口
---| "HAPPY" # 幸せのぐじゅぐじゅ口
---| "OPENED" # 開いた口

---@class (exact) Character24a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character24a.RightEyeTextures 右目の表情名
---@field public leftEye Character24a.LeftEyeTextures 左目の表情名
---@field public mouth Character24a.MouthTextures 口の表情名

---@class (exact) Character24a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character24a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character24a.EmotionSet ベッドで寝ているとき

---@class (exact) Character24a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character24a, right: Character24a.RightEyeTextures, left: Character24a.LeftEyeTextures, mouth: Character24a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character24a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character24a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character24a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character24a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character24a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character24a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character24a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character24a.FacePartsStruct 目や口による表情

---@type Character24a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "24a_Natsu";

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
			OPENED = vectors.vec2(3, 0);
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

			models = {models.models.ex_skill_1.Pillagers, models.models.ex_skill_1.AnimationArrow, ModelAlias.alias.avatar.rightArmBottom.ExSkillItemAnchor1};

			animations = {"main", "gun", "shield_item", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(15, -35, 0);
					pos = vectors.vec3(25, 26, -39);
				};

				fin = {
					rot = vectors.vec3(30, -25, 0);
					pos = vectors.vec3(4, 32, 8);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.Pillagers:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/illager/pillager.png")
						models.models.ex_skill_1.AnimationArrow:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/projectiles/arrow.png")
						ModelAlias.alias.avatar.rightArmBottom.ExSkillItemAnchor1:newItem("ex_skill_1_item_1")
							:setItem("minecraft:milk_bucket")

						for i = 1, 2 do
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."RightArm"]:newItem("ex_skill_1_pillager_"..i.."_crossbow")
								:setItem("minecraft:crossbow")
								:setPos(0, -12, -2)
								:setRot(0, 0, -135)
						end
						for _, part in ipairs({"Head", "Body", "RightArm", "LeftArm", "RightLeg", "LeftLeg"}) do
							models.models.ex_skill_1.Pillagers["Pillager2"]["Pillager2" .. part]:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Pillagers.Pillager1["Pillager1" .. part]))
						end

						self.exSkill.primary.isInitialized = true
					end

					models.models.shield_item.Item:setParentType("None")

					FaceParts:setEmotion("NORMAL", "CENTER", "HAT", 34, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setVisible(true)
						models.models.shield_item.Item:setPos()
						models.models.shield_item.Item:setRot()
					elseif tick == 34 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAT", 2, true)
					elseif tick == 36 then
						FaceParts:setEmotion("NORMAL", "CENTER", "TRIANGLE", 12, true)
						local playerPos = player:getPos()
						sounds:playSound("minecraft:item.shield.block", playerPos, 1, 1)
						sounds:playSound("minecraft:entity.arrow.hit", playerPos, 1, 1)
					elseif tick == 48 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAT", 2, true)
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.25, 2)
					elseif tick == 50 then
						FaceParts:setEmotion("NORMAL", "INVERTED", "HAT", 4, true)
					elseif tick == 54 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "HAT", 20, true)
					elseif tick == 74 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAT", 3, true)
					elseif tick == 77 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TRIANGLE", 5, true)
					elseif tick == 82 then
						local shouldLookCamera = math.random() < 0.1
						ModelAlias.alias.avatar.faceParts.Eyes.EyeShines:setVisible(true)
						if shouldLookCamera then
							FaceParts:setEmotion("ANGRY", "ANGRY_CENTER", "TRIANGLE", 31, true)
							ModelAlias.alias.avatar.faceParts.Eyes.EyeShines.LeftEyeShine:setPos(-0.5, 0, 0)
						else
							FaceParts:setEmotion("ANGRY", "ANGRY", "TRIANGLE", 31, true)
						end

						local playerPos = player:getPos()
						sounds:playSound("minecraft:entity.player.levelup", playerPos, 1, 1)
						sounds:playSound("minecraft:entity.item.pickup", playerPos, 1, 1.5)
					elseif tick == 86 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightArmBottom.ExSkillItemAnchor1)
						local bodyYaw = player:getBodyYaw()
						local hasShader = client:hasShaderPack()
						for i = 1, 17 do
							particles:newParticle("minecraft:end_rod", anchorPos)
								:setScale(0.1)
								:setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + 30, vectors.rotateAroundAxis(20, vectors.rotateAroundAxis(i * 20, 0, 0.01 + math.random() * 0.02, 0, 0, 0, 1), 1, 0, 0), 0, 1, 0))
								:setGravity(0)
								:setColor((math.random() < 0.5 and vectors.vec3(0.993, 0.819, 0.99) or vectors.vec3(0.994, 0.988, 0.721)):scale(hasShader and 0.5 or 1))
								:setLifetime(40)
						end
					end

					if tick <= 76 then
						local shotChances = {math.random() < 0.05, math.random() < 0.05}
						if shotChances[1] or shotChances[2] then
							local bodyYaw = player:getBodyYaw()
							local playerAnchorPos = player:getPos():copy():add(vectors.rotateAroundAxis(bodyYaw * -1, -0.25, 1, 0, 0, 1, 0))
							for i = 1, 2 do
								if shotChances[i] then
									local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."RightArm"]["Pillager"..i.."ArrowAnchor"])
									local offsetRot = math.random() * 360
									ExSkillArrowManager:spawn(anchorPos, playerAnchorPos:copy():sub(anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(offsetRot, 0, 1, 0, 0, 0, 1), 0, 1, 0))):normalize())

									sounds:playSound("minecraft:item.crossbow.shoot", anchorPos, 0.5, 1)
								end
							end
						end

						if math.random() < 0.04 then
							sounds:playSound("minecraft:entity.pillager.ambient", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1.Pillager1RightArm.Pillager1ArrowAnchor), 0.5, 1)
						end
					end
				end;

				onPostAnimation = function (_, forcedStop)
					ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
					ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					models.models.shield_item.Item:setParentType("Item")
					for _, modelPart in ipairs({ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.faceParts.Eyes.EyeShines}) do
						modelPart:setVisible(false)
					end
					ModelAlias.alias.avatar.faceParts.Eyes.EyeShines.LeftEyeShine:setPos()

					if forcedStop then
						ExSkillArrowManager:removeAll()
					end
				end;
			};

			---このExスキルが初期化されたかどうか。
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;
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
			onBeforeModelCopy = function ()
				ModelAlias.alias.avatar.faceParts.Eyes.EyeShines:setVisible(false)
			end;

			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.SideTail:setRot(30, 0, 20)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.SideTail:setRot(-17.5, 0, -2.5)
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
						min = 30;
						neutral = 30;
						max = 30;
					};

					horizontal = {
						min = 30;
						neutral = 30;
						max = 30;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.SideTail};

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
						max = 45;

						headX = {
							multiplayer = -80;
							min = -45;
							max = 45;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.SideTail.SideTailZPivot};

				z = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 60;

						headZ = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};

						headRot = {
							multiplayer = 0.05;
							min = 0;
							max = 60;
						};

						bodyY = {
							multiplayer = -40;
							min = 0;
							max = 60;
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
		---Exスキルで使用する矢のインスタンスクラス
		---@type Character24a.ExSkillArrow
		ExSkillArrow = require("scripts.ex_skill_arrow")

		---Exスキルで使用する矢のマネージャークラス
		---@type Character24a.ExSkillArrowManager
		ExSkillArrowManager = require("scripts.ex_skill_arrow_manager")
		ExSkillArrowManager = ExSkillArrowManager.new()
		ExSkillArrowManager.init()

		---パイ投げのアニメーションを制御するクラス
		---@type Character24a.PieThrowing
		PieThrowing = require("scripts.pie_throwing")

		---投げるパイオブジェクトのインスタンスクラス
		---@type Character24a.Pie
		Pie = require("scripts.pie")

		---投げるパイオブジェクトのマネージャークラス
		---@type Character24a.PieManager
		PieManager = require("scripts.pie_manager")
		PieManager = PieManager.new()
		PieManager.init()

		ModelAlias.alias.avatar.gun.Cake:newItem("gun_cake_strap")
			:setItem("minecraft:cake")
			:setScale(0.19)

		KeyManager:register("pie_throwing", "Eat this and cheer up", "key.keyboard.v"):onPress(function ()
			if ExSkill:getCanPlayAnimation() and not PieThrowing:getIsAnimationPlaying() then
				pings.throwPie()
			end
		end)

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

---パイ投げのpingメソッド
function pings.throwPie()
	PieThrowing:play()
end

return BlueArchiveCharacter
