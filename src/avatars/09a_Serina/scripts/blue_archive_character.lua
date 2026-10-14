---右目のテクスチャの列挙型
---@alias Character09a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "INVERTED" # 反対側を見る目
---| "NARROW" # 少し閉じた目

---左目のテクスチャの列挙型
---@alias Character09a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "INVERTED" # 反対側を見る目
---| "NARROW" # 少し閉じた目
---| "CENTER" # 少し反対側を見る目

---口のテクスチャの列挙型
---@alias Character09a.MouthTextures
---| "NORMAL" # 通常
---| "SMILE" # にっこり
---| "OPENED_SMALL" # 小さく開いた口
---| "OPENED" # 開いた口
---| "SAD" # への口
---| "TIRED" # 疲れた口

---キャラクター固有の腕の状態
---@alias Character09a.AdditionalArmState
---| "MEDICAL_BOX_HELD" # 救急箱を持つ手

---@class (exact) Character09a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character09a.RightEyeTextures 右目の表情名
---@field public leftEye Character09a.LeftEyeTextures 左目の表情名
---@field public mouth Character09a.MouthTextures 口の表情名

---@class (exact) Character09a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character09a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character09a.EmotionSet ベッドで寝ているとき

---@class (exact) Character09a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character09a, right: Character09a.RightEyeTextures, left: Character09a.LeftEyeTextures, mouth: Character09a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character09a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character09a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character09a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character09a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character09a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character09a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character09a.ArmsCallbacksSet : BlueArchiveCharacter.ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(self: Character09a, right: Arms.BaseArmState|Character09a.AdditionalArmState, left: Arms.BaseArmState|Character09a.AdditionalArmState): {right?: Arms.BaseArmState|Character09a.AdditionalArmState, left?: Arms.BaseArmState|Character09a.AdditionalArmState}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(self: Character09a, state: Arms.BaseArmState|Character09a.AdditionalArmState): boolean? 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: Character09a, state: Arms.BaseArmState|Character09a.AdditionalArmState): boolean? 左腕の追加処理

---@class (exact) Character09a.ArmsStruct : BlueArchiveCharacter.ArmsStruct 腕のデータ構造体
---@field public callbacks? Character09a.ArmsCallbacksSet 腕の制御のコールバック関数群

---@class (exact) Character09a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character09a.FacePartsStruct 目や口による表情
---@field public arms Character09a.ArmsStruct 腕

---@type Character09a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "09a_Serina";

		birth = {
			month = 1;
			day = 6;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(5, 0);
			INVERTED = vectors.vec2(6, 0);
			NARROW = vectors.vec2(8, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CLOSED2 = vectors.vec2(4, 0);
			INVERTED = vectors.vec2(6, 0);
			NARROW = vectors.vec2(8, 0);
			CENTER = vectors.vec2(9, 0);
		};

		mouth = {
			SMILE = vectors.vec2(0, 0);
			TIRED = vectors.vec2(1, 0);
			OPENED_SMALL = vectors.vec2(2, 0);
			OPENED = vectors.vec2(3, 0);
			SAD = vectors.vec2(4, 0);
		};
	};

	arms = {
		callbacks = {
			onAdditionalRightArmProcess = function (self, state)
				if state == "MEDICAL_BOX_HELD" then
					ModelAlias.alias.avatar.rightArm:setParentType("Body")
					events.TICK:remove("right_arm_tick")
					events.TICK:register(function ()
						if self.costume.medicalBoxPos == 0 then
							Arms:setArmState("DEFAULT", "DEFAULT")
						end
					end, "right_arm_tick")
					events.RENDER:remove("right_arm_render")
					events.RENDER:register(function (delta)
						local swingPos = (player:getSwingTime() + (player:isSwingingArm() and delta or 0)) / player:getSwingDuration()
						for _, modelPart in ipairs({ModelAlias.alias.avatar.rightArm, ModelAlias.alias.avatar.leftArm}) do
							modelPart:setRot(swingPos < 0.25 and (360 * swingPos + 40) or (-120 * swingPos + 160), 0, 0)
						end
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "MEDICAL_BOX_HELD" then
					ModelAlias.alias.avatar.leftArm:setParentType("Body")
				end
			end;
		};
	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 1, -4);
					left = vectors.vec3(0, 1, -4);
				};

				thirdPersonPos = {
					right = vectors.vec3(-2, 1, -5);
					left = vectors.vec3(2, 1, -5);
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
		{
			model = models.models.ex_skill_1.MedicalBox;

			boundingBox = {
				size = vectors.vec3(12, 8, 12)
			};

			placementMode = "COPY";

			callbacks = {
				onInit = function (_, placementObject)
					placementObject.tick = 0
				end;

				onTick = function (self, placementObject)
					local targetEntry = raycast:entity(placementObject.currentPos, placementObject.currentPos:copy():add(0, 0.5, 0))
					if  targetEntry ~= nil and  targetEntry:isPlayer() then
						for _ = 1, 50 do
							particles:newParticle("minecraft:effect", placementObject.currentPos):setScale(1.2):setVelocity(vectors.rotateAroundAxis(math.random() * 360, 0, 0, math.random() * 0.25, 0, 1, 0)):setColor(0.961, 0.141, 0.137)
						end
						sounds:playSound("minecraft:block.chest.open", placementObject.currentPos, 1, 2)
						--host:sendChatCommand("/effect give "..targetEntry:getName().." minecraft:instant_health 1 1 true")
						PlacementObjectManager:remove(placementObject.index)
					else
						if placementObject.tick % 2 == 0 then
							particles:newParticle("minecraft:end_rod", placementObject.currentPos:copy():add(math.random() - 0.5, math.random(), math.random() - 0.5)):setVelocity(0, 0.1, 0):setColor(1, 0.984, 0.4)
						end
						placementObject.tick = placementObject.tick + 1
					end
				end;
			};
		};
	};

	exSkill = {
		primary = {
			formationType = "SPECIAL";

			models = {ModelAlias.alias.avatar.head.Sweat};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-5, 190, -5);
					pos = vectors.vec3(-2.5, 13, -16);
				};

				fin = {
					rot = vectors.vec3(-20, 210, -30);
					pos = vectors.vec3(-7, 10, -11);
				};
			};

			callbacks = {
				onPreAnimation = function ()
					events.RENDER:register(function ()
						ModelAlias.alias.avatar.head.Sweat:setOpacity(ModelAlias.alias.avatar.head.Sweat.SweatOpacity:getAnimScale().x)
					end, "ex_skill_1_render")
					PlacementObjectManager:removeAll()
					models.models.ex_skill_1.MedicalBox:setPos()
					models.models.ex_skill_1.MedicalBox:setRot()
					models.models.ex_skill_1.MedicalBox:setScale()
					models.models.ex_skill_1.MedicalBox:setParentType("None")
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 10, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 10 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 3, true)
					elseif tick == 13 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TIRED", 11, true)
					elseif tick == 15 then
						particles:newParticle("minecraft:snowflake", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.mouth)):setScale(0.5):setVelocity(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, -0.01, 0.01, 0, 1, 0)):setGravity(0):setLifetime(11)
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.1, 0.7)
					elseif tick == 24 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TIRED", 8, true)
					elseif tick == 32 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TIRED", 1, true)
					elseif tick == 33 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 2, true)
					elseif tick == 35 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "SMILE", 32, true)
						local anchorPos = player:getPos():add(0, 0.8, 0)
						local bodyYaw = player:getBodyYaw()
						local isHost = host:isHost()
						local colorTable = {vectors.vec3(0.337, 1, 1), vectors.vec3(0.984, 1, 0.533)}
						for _ = 1, 10 do
							particles:newParticle("minecraft:end_rod", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, (math.random() < 0.5 and (isHost and -0.075 or -0.1) or 0.1) * (math.random() * 0.2 + 0.8), math.random() * 0.2 - 0.05, 0, 0, 1, 0)):setColor(colorTable[math.floor(math.random() * 2) + 1])
						end
						sounds:playSound("minecraft:entity.item.pickup", anchorPos, 1, 1.8)
					end
				end;

				onPostAnimation = function (_, forcedStop)
					events.RENDER:remove("ex_skill_1_render")
					if not forcedStop then
						PlacementObjectManager:spawn(1, player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 3, 5, 0, 1, 0)), 0)
					end
					models.models.ex_skill_1.MedicalBox:setParentType("Item")
				end;
			};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.NurseCap:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Bag:setVisible(not isVisible)
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
				end
			end;
		};

		---救急箱の位置：0. 持っていない, 1. メインハンドに持っている, 2. オフハンドに持っている
		---@type integer
		medicalBoxPos = 0;
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED_SMALL", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TIRED", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SAD", duration, true)
					end
				end
			end;

			onStop = function (_, _, forcedStop)
				if not forcedStop then
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
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.head.HairTail, ModelAlias.alias.dummy_avatar.head.HairTailRibbon.HairTailRibbonTip1, ModelAlias.alias.dummy_avatar.head.HairTailRibbon.HairTailRibbonTip2}) do
					modelPart:setRot(30, 0, 0)
				end
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.head.Feather:setRot(55, 0, 0)
			end;

			onPhase2 = function ()
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.head.HairTail, ModelAlias.alias.dummy_avatar.head.HairTailRibbon.HairTailRibbonTip1, ModelAlias.alias.dummy_avatar.head.HairTailRibbon.HairTailRibbonTip2}) do
					modelPart:setRot(-20, 0, 0)
				end
				ModelAlias.alias.dummy_avatar.rightArmBottom:setPivot(2, 6, -2)
				ModelAlias.alias.dummy_avatar.head.Feather:setRot(-20, 0, 0)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.HairTail, ModelAlias.alias.avatar.head.HairTailRibbon.HairTailRibbonTip1, ModelAlias.alias.avatar.head.HairTailRibbon.HairTailRibbonTip2};

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
				models = {ModelAlias.alias.avatar.head.HairTail.HairTailZPivot};

				z = {
					vertical = {
						min = -60;
						neutral = -5;
						max = 0;

						headZ = {
							multiplayer = -80;
							min = -60;
							max = 0;
						};

						headRot = {
							multiplayer = 0.05;
							min = -60;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -60;
							max = 0;
						};
					};
				};
			};
			{
				models = {ModelAlias.alias.avatar.head.HairTailRibbon.HairTailRibbonTip1.HairTailRibbonTip1ZPivot, ModelAlias.alias.avatar.head.HairTailRibbon.HairTailRibbonTip2.HairTailRibbonTip2ZPivot};

				z = {
					vertical = {
						min = -150;
						neutral = -5;
						max = 0;

						headZ = {
							multiplayer = -160;
							min = -80;
							max = 0;
						};

						headRot = {
							multiplayer = 0.1;
							min = -80;
							max = 0;
						};

						bodyY = {
							multiplayer = 160;
							min = -150;
							max = 0;
						};
					};
				};
			};
			{
				models = {ModelAlias.alias.avatar.head.Feather};

				x = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -120;
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
				models = {ModelAlias.alias.avatar.head.Feather.FeatherZPivot};

				z = {
					vertical = {
						min = -160;
						neutral = 0;
						max = 75;

						headZ = {
							multiplayer = -120;
							min = -80;
							max = 75;
						};

						headRot = {
							multiplayer = 0.075;
							min = -80;
							max = 75;
						};

						bodyY = {
							multiplayer = 120;
							min = -160;
							max = 0;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function (self)
		events.TICK:register(function ()
			if Gun.currentGunPosition == "NONE" and ExSkill.animationCount == -1 then
				local healingPotionPos = 0
				for i = 1, 2 do
					local heldItem = player:getHeldItem(i == 2)
					local isNewerNbt = StringUtils.isNewerOrEqualVersion(client:getVersion(), "1.20.5")
					if (heldItem.id == "minecraft:potion" or heldItem.id == "minecraft:splash_potion" or heldItem.id == "minecraft:lingering_potion") and ((isNewerNbt and heldItem.tag["minecraft:potion_contents"].potion ~= nil and heldItem.tag["minecraft:potion_contents"].potion:match("minecraft:.*healing") ~= nil) or (not isNewerNbt and heldItem.tag.Potion ~= nil and heldItem.tag.Potion:match("minecraft:.*healing") ~= nil)) then
						healingPotionPos = i
						break
					end
				end
				self.costume.medicalBoxPos = healingPotionPos
			else
				self.costume.medicalBoxPos = 0
			end
			if self.costume.medicalBoxPos > 0 and Arms.armState.right ~= "MEDICAL_BOX_HELD" then
				Arms:setArmState("MEDICAL_BOX_HELD", "MEDICAL_BOX_HELD")
			end
		end)

		events.ITEM_RENDER:register(function (_, mode)
			local isLeftHanded = player:isLeftHanded()
			if (isLeftHanded and self.costume.medicalBoxPos == 2) or (not isLeftHanded and self.costume.medicalBoxPos == 1) then
				--右手に救急箱を持つ
				if mode == "THIRD_PERSON_RIGHT_HAND" then
					models.models.ex_skill_1.MedicalBox:setPos(-5.5, -4, 0)
					models.models.ex_skill_1.MedicalBox:setRot(45, 0, 0)
					models.models.ex_skill_1.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.ex_skill_1.MedicalBox
				elseif mode == "FIRST_PERSON_RIGHT_HAND" then
					models.models.ex_skill_1.MedicalBox:setPos(-9, -3, 0)
					models.models.ex_skill_1.MedicalBox:setRot(0, 0, 0)
					models.models.ex_skill_1.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.ex_skill_1.MedicalBox
				end
			elseif (isLeftHanded and self.costume.medicalBoxPos == 1) or (not isLeftHanded and self.costume.medicalBoxPos == 2) then
				--左手に救急箱を持つ
				if mode == "THIRD_PERSON_LEFT_HAND" then
					models.models.ex_skill_1.MedicalBox:setPos(5.5, -4, 0)
					models.models.ex_skill_1.MedicalBox:setRot(45, 0, 0)
					models.models.ex_skill_1.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.ex_skill_1.MedicalBox
				elseif mode == "FIRST_PERSON_LEFT_HAND" then
					models.models.ex_skill_1.MedicalBox:setPos(9, -3, 0)
					models.models.ex_skill_1.MedicalBox:setRot(0, 0, 0)
					models.models.ex_skill_1.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.ex_skill_1.MedicalBox
				end
			end
		end)
	end;
}

return BlueArchiveCharacter
