---右目のテクスチャの列挙型
---@alias Character21a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ABOVE" # 上を見る目
---| "CENTER" # 少し反対側を見る目

---左目のテクスチャの列挙型
---@alias Character21a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "ABOVE" # 上を見る目

---口のテクスチャの列挙型
---@alias Character21a.MouthTextures
---| "NORMAL" # 通常
---| "SMILE" # にっこり口
---| "O" # 丸めた口
---| "SURPRISED" # あんぐり口
---| "OPENED" # 開いた口

---@class (exact) Character21a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character21a.RightEyeTextures 右目の表情名
---@field public leftEye Character21a.LeftEyeTextures 左目の表情名
---@field public mouth Character21a.MouthTextures 口の表情名

---@class (exact) Character21a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character21a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character21a.EmotionSet ベッドで寝ているとき

---@class (exact) Character21a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character21a, right: Character21a.RightEyeTextures, left: Character21a.LeftEyeTextures, mouth: Character21a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character21a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character21a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character21a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character21a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character21a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character21a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character21a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character21a.FacePartsStruct 目や口による表情

---@type Character21a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "21a_Hanae";

		birth = {
			month = 5;
			day = 12;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			ABOVE = vectors.vec2(6, 0);
			CENTER = vectors.vec2(8, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CENTER = vectors.vec2(4, 0);
			ABOVE = vectors.vec2(6, 0);
		};

		mouth = {
			SMILE = vectors.vec2(0, 0);
			O = vectors.vec2(1, 0);
			SURPRISED = vectors.vec2(2, 0);
			OPENED = vectors.vec2(3, 0);
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
					right = vectors.vec3(0, 0, -8);
					left = vectors.vec3(0, 0, -8);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.5, -0.5, -6);
					left = vectors.vec3(1.5, -0.5, -6);
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
			formationType = "SPECIAL";

			models = {ModelAlias.alias.avatar.body.Rabbit};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 140, 0);
					pos = vectors.vec3(9, 25, -11);
				};

				fin = {
					rot = vectors.vec3(5, 190, 5);
					pos = vectors.vec3(-4, 22.5, -118.64);
				};
			};

			callbacks = {
				onPreAnimation = function ()
					local rabbitVariants = {"black", "brown", "gold", "salt", "white", "white_splotched"}
					local variantValue = math.random(#rabbitVariants)
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Rabbit.RHead.RabbitHead, ModelAlias.alias.avatar.body.Rabbit.RHead.RRightEar.RabbitRightEar, ModelAlias.alias.avatar.body.Rabbit.RHead.RLeftEar.RabbitLeftEar, ModelAlias.alias.avatar.body.Rabbit.RHead.RNose.RabbitNose, ModelAlias.alias.avatar.body.Rabbit.RBody.RabbitBody, ModelAlias.alias.avatar.body.Rabbit.RBody.RFrontRightLeg.RabbitFrontRightLeg, ModelAlias.alias.avatar.body.Rabbit.RBody.RFrontLeftLeg.RabbitFrontLeftLeg, ModelAlias.alias.avatar.body.Rabbit.RBody.RRearLeftLeg.RabbitLeftHaunch, ModelAlias.alias.avatar.body.Rabbit.RBody.RRearLeftLeg.RRearLeftLegBottom.RabbitRearLeftLeg, ModelAlias.alias.avatar.body.Rabbit.RBody.RRearRightLeg.RabbitRightHaunch, ModelAlias.alias.avatar.body.Rabbit.RBody.RRearRightLeg.RRearRightLegBottom.RabbitRearRightLeg, ModelAlias.alias.avatar.body.Rabbit.RBody.RTail.RabbitTail}) do
						modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/rabbit/" .. rabbitVariants[variantValue] .. ".png")
					end
					FaceParts:setEmotion("NORMAL", "CENTER", "SMILE", 14, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 13 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.Rabbit)
						local bodyYaw = player:getBodyYaw()
						local colorTable = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)}
						for _ = 1, 6 do
							particles:newParticle("minecraft:electric_spark", anchorPos):setScale(1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.2 - 0.1, math.random() * 0.2, 0, 0, 1, 0)):setColor(colorTable[math.random(#colorTable)]):setLifetime(9 + math.random() * 4)
						end
					elseif tick == 14 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 2, true)
						sounds:playSound("minecraft:entity.egg.throw", player:getPos(), 1, 2)
					elseif tick == 15 then
						ModelAlias.alias.avatar.body.Rabbit:moveTo(models.models.main)
					elseif tick == 16 then
						FaceParts:setEmotion("ABOVE", "ABOVE", "O", 13, true)
					elseif tick == 27 then
						sounds:playSound("minecraft:entity.rabbit.hurt", ModelUtils.getModelWorldPos(models.models.main.Rabbit), 1, 1)
					elseif tick == 29 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "O", 2, true)
					elseif tick == 31 then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SURPRISED", 16, true)
					elseif tick == 47 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 29, true)
					elseif tick == 50 then
						models.models.main.Rabbit:moveTo(ModelAlias.alias.avatar.body)
					elseif tick == 51 then
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground:setVisible(true)
							local windowSize = client:getWindowSize()
							local shouldAdjustBackgroundRot = StringUtils.isNewerOrEqualVersion(client:getVersion(), "1.21")
							events.RENDER:register(function (delta, ctx, matrix)
								local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(2.15)), 0, 1, 0):scale(16 / 0.9375)
								models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
								models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
								models.models.ex_skill_1.CameraBackground.Background:setScale(48 * math.max(windowSize.x / windowSize.y, 1) * models.models.ex_skill_1.CameraBackground.BackgroundScale:getAnimScale().x)
								if shouldAdjustBackgroundRot then
									models.models.ex_skill_1.CameraBackground.Background:setRot(0, 0, renderer:getCameraRot().z)
								end
							end, "ex_skill_1_background")
						end
						local anchorPos = ModelUtils.getModelWorldPos(models.models.main.Avatar)
						sounds:playSound("minecraft:entity.item.pickup", anchorPos, 1, 1.75)
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 1.5)
					elseif tick == 52 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = player:getPos():copy():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 1.5, 4, 0, 1, 0))
						for i = 1, 18 do
							particles:newParticle("minecraft:firework", anchorPos):setScale(1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 20, 0, 0.15 + math.random() * 0.1, 0, 0, 0, 1), 0, 1, 0))
						end
					end
				end;

				onPostAnimation = function (_, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_background")
						models.models.ex_skill_1.CameraBackground:setVisible(false)
					end
					if forcedStop and models.models.main.Rabbit ~= nil then
						models.models.main.Rabbit:moveTo(ModelAlias.alias.avatar.body)
					end
				end
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
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Chest, ModelAlias.alias.avatar.body.RabbitPouch}) do
						modelPart:setVisible(not isVisible)
					end
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.leftLeg.LegSyringe:setVisible(not isVisible)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("CLOSED", "NORMAL", "OPENED", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "O", duration, true)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("SURPRISED", "SURPRISED", "SURPRISED", duration, true)
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
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(20, 0, 20)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(20, 0, -20)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(40, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(-20, 0, 10)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(-20, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot()
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.HairTails.LeftHairTail};
				x = {
					vertical = {
						min = -180;
						neutral = -5;
						max = 70;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 70;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = -7.5;
						};

						bodyY = {
							multiplayer = 80;
							min = -170;
							max = -7.5;
						};
					};

					horizontal = {
						min = -170;
						neutral = 45;
						max = 70;

						headX = {
							multiplayer = -160;
							min = -45;
							max = 70;
						};
					};
				};

				z = {
					vertical = {
						min = -70;
						neutral = -5;
						max = 70;

						headZ = {
							multiplayer = -80;
							min = -70;
							max = 70;
						};
					};

					horizontal = {
						min = -70;
						neutral = -5;
						max = 70;

						headZ = {
							multiplayer = 80;
							min = -10;
							max = -2.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail};

				x = {
					vertical = {
						min = -180;
						neutral = -5;
						max = 70;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 70;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = -7.5;
						};

						bodyY = {
							multiplayer = 80;
							min = -170;
							max = -7.5;
						};
					};

					horizontal = {
						min = -170;
						neutral = 45;
						max = 70;

						headX = {
							multiplayer = -160;
							min = -45;
							max = 70;
						};
					};
				};

				z = {
					vertical = {
						min = -70;
						neutral = 5;
						max = 70;

						headZ = {
							multiplayer = -80;
							min = -70;
							max = 70;
						};
					};

					horizontal = {
						min = -70;
						neutral = 5;
						max = 70;

						headZ = {
							multiplayer = 80;
							min = 10;
							max = 2.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Chest};

				x = {
					vertical = {
						min = 40;
						neutral = 45;
						max = 50;

						bodyY = {
							multiplayer = -10;
							min = 40;
							max = 50;
						};
					};

					horizontal = {
						min = 40;
						neutral = 45;
						max = 50;

						bodyX = {
							multiplayer = -10;
							min = 40;
							max = 50;
						};
					}
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
					if (heldItem.id == "minecraft:potion" or heldItem.id == "minecraft:splash_potion" or heldItem.id == "minecraft:lingering_potion") and ((isNewerNbt and heldItem.tag["minecraft:potion_contents"].potion ~= nil and heldItem.tag["minecraft:potion_contents"].potion:match("minecraft:.*regeneration") ~= nil) or (not isNewerNbt and heldItem.tag.Potion ~= nil and heldItem.tag.Potion:match("minecraft:.*regeneration") ~= nil)) then
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
					models.models.medical_box.MedicalBox:setPos(-5.5, -4, 0)
					models.models.medical_box.MedicalBox:setRot(45, 0, 0)
					models.models.medical_box.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.medical_box.MedicalBox
				elseif mode == "FIRST_PERSON_RIGHT_HAND" then
					models.models.medical_box.MedicalBox:setPos(-9, -3, 0)
					models.models.medical_box.MedicalBox:setRot(0, 0, 0)
					models.models.medical_box.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.medical_box.MedicalBox
				end
			elseif (isLeftHanded and self.costume.medicalBoxPos == 1) or (not isLeftHanded and self.costume.medicalBoxPos == 2) then
				--左手に救急箱を持つ
				if mode == "THIRD_PERSON_LEFT_HAND" then
					models.models.medical_box.MedicalBox:setPos(5.5, -4, 0)
					models.models.medical_box.MedicalBox:setRot(45, 0, 0)
					models.models.medical_box.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.medical_box.MedicalBox
				elseif mode == "FIRST_PERSON_LEFT_HAND" then
					models.models.medical_box.MedicalBox:setPos(9, -3, 0)
					models.models.medical_box.MedicalBox:setRot(0, 0, 0)
					models.models.medical_box.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.medical_box.MedicalBox
				end
			end
		end)
	end;
}

return BlueArchiveCharacter
