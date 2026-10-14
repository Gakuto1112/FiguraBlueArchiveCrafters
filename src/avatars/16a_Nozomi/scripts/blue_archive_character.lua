---右目のテクスチャの列挙型
---@alias Character16a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "CENTER" # 少し反対側を見る目
---| "UNEQUAL" # 不等号目

---左目のテクスチャの列挙型
---@alias Character16a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "CENTER" # 少し反対側を見る目
---| "UNEQUAL" # 不等号目

---口のテクスチャの列挙型
---@alias Character16a.MouthTextures
---| "NORMAL" # 通常
---| "SMALL" # 小さく開いた口
---| "SMILE" # にっこり + 八重歯
---| "YUMMY" # 舌を出した口
---| "BIG" # 大きく開いた口
---| "OPENED" # 開いた口
---| "CIRCLE" # 丸い口
---| "ANXIOUS" # への口

---@class (exact) Character16a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character16a.RightEyeTextures 右目の表情名
---@field public leftEye Character16a.LeftEyeTextures 左目の表情名
---@field public mouth Character16a.MouthTextures 口の表情名

---@class (exact) Character16a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character16a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character16a.EmotionSet ベッドで寝ているとき

---@class (exact) Character16a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character16a, right: Character16a.RightEyeTextures, left: Character16a.LeftEyeTextures, mouth: Character16a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character16a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character16a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character16a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character16a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character16a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character16a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character16a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character16a.FacePartsStruct 目や口による表情

---@type Character16a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "16a_Nozomi";

		birth = {
			month = 6;
			day = 14;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(5, 0);
			CENTER = vectors.vec2(6, 0);
			UNEQUAL = vectors.vec2(8, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CLOSED2 = vectors.vec2(4, 0);
			CENTER = vectors.vec2(6, 0);
			UNEQUAL = vectors.vec2(7, 0);
		};

		mouth = {
			SMALL = vectors.vec2(0, 0);
			SMILE = vectors.vec2(1, 0);
			YUMMY = vectors.vec2(2, 0);
			BIG = vectors.vec2(3, 0);
			OPENED = vectors.vec2(4, 0);
			CIRCLE = vectors.vec2(5, 0);
			ANXIOUS = vectors.vec2(6, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				local armState = {right = right, left = left}
				if SyupogakiDance ~= nil and SyupogakiDance.danceState ~= "NOT_STANDBY" then
					armState.right = "DEFAULT"
					armState.left = "DEFAULT"
				else
					armState.right = armState.right == "GUN_OFF_HAND" and "DEFAULT" or armState.right
					armState.left = armState.left == "GUN_OFF_HAND" and "DEFAULT" or armState.left
				end
				return armState
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
					right = vectors.vec3(-1, -3.5, -2);
					left = vectors.vec3(1, -3.5, -2);
				};

				thirdPersonPos = {
					right = vectors.vec3(0, -3.5, -3);
					left = vectors.vec3(0, -3.5, -3);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(4.5, -9, 0);
					left = vectors.vec3(4.5, -9, 0);
				};

				rot = {
					right = vectors.vec3(-90, 0, 0);
					left = vectors.vec3(-90, 0, 0);
				};
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

			models = {ModelAlias.alias.avatar.lowerBody.Train, ModelAlias.alias.avatar.rightArmBottom.Key, ModelAlias.alias.avatar.head.HeadShineEffects};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 195, 0);
					pos = vectors.vec3(-15, 63, -101);
				};

				fin = {
					rot = vectors.vec3(0, 210, 15);
					pos = vectors.vec3(-12.1, 42.75, -4079.85);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1RightFirework.TrainCar1RightFireworkItem, ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1LeftFirework.TrainCar1LeftFireworkItem}) do
							modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/item/firework_rocket.png")
						end
						ModelAlias.alias.avatar.rightArmBottom.Key:newItem("ex_skill_1_key_item"):setPos(0, -1, 0):setScale(0.25, 0.25, 0.25):setVisible(false)
						self.exSkill.primary.isInitialized = true
					end
					if math.random() >= 0.95 and StringUtils.isNewerOrEqualVersion(client:getVersion(), "1.21") then
						ModelAlias.alias.avatar.rightArmBottom.Key.KeyModel:setVisible(false)
						local task = ModelAlias.alias.avatar.rightArmBottom.Key:getTask("ex_skill_1_key_item")
						---@cast task ItemTask
						task:setItem(math.random() >= 0.8 and "minecraft:ominous_trial_key" or "minecraft:trial_key")
						task:setVisible(true)
					else
						ModelAlias.alias.avatar.rightArmBottom.Key.KeyModel:setVisible(true)
						ModelAlias.alias.avatar.rightArmBottom.Key:getTask("ex_skill_1_key_item"):setVisible(false)
					end
					TrainManager:stopTrainAnimation()
					TrainManager:spawnExSkillRail()
					ModelAlias.alias.avatar.lowerBody.Train:setVisible(true)
					FaceParts:setEmotion("CLOSED", "CLOSED", "SMALL", 20, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 15 then
						sounds:playSound("minecraft:entity.zombie.attack_wooden_door", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train), 0.25, 1.5)
					elseif tick == 20 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 2, true)
					elseif tick == 22 then
						FaceParts:setEmotion("CENTER", "NORMAL", "SMILE", 25, true)
					elseif tick == 23 then
						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train), 1, 1.5)
					elseif tick == 47 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 2, true)
					elseif tick == 49 then
						FaceParts:setEmotion("NORMAL", "CENTER", "YUMMY", 21, true)
					elseif tick == 53 then
						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train), 1, 3)
					elseif tick == 60 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "YUMMY", 32, true)
					elseif tick == 65 then
						sounds:playSound("minecraft:block.vault.insert_item", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1ChimneyParticleAnchor), 1, 1)
					elseif tick == 76 then
						sounds:playSound("minecraft:block.iron_trapdoor.open", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1RightHatch), 1, 1)
					elseif tick == 82 then
						sounds:playSound("minecraft:block.piston.extend", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1RightFirework), 1, 1.5)
					elseif tick == 92 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SMALL", 54, true)
					elseif tick == 104 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1RightFirework)
						sounds:playSound("minecraft:item.flintandsteel.use", anchorPos, 1, 1)
						sounds:playSound("minecraft:block.fire.extinguish", anchorPos, 1, 0.5)
					elseif tick == 114 and host:isHost() then
						models.models.main.Avatar:setColor(0, 0, 0)
						local windowSize = client:getWindowSize()
						models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(60))
						events.RENDER:register(function (delta, context)
							models.models.ex_skill_1.CameraBackground:setVisible(context == "RENDER")
							local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(2.6)), 0, 1, 0):scale(16 / 0.9375)
							models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
							models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
						end, "ex_skill_1_background_render")
					elseif tick == 117 and host:isHost() then
						events.RENDER:remove("ex_skill_1_background_render")
						models.models.main.Avatar:setColor(1, 1, 1)
						models.models.ex_skill_1.CameraBackground:setVisible(false)
					elseif tick == 118 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1RightFirework)
						sounds:playSound("minecraft:entity.firework_rocket.large_blast", anchorPos, 1, 1)
						self.exSkill.primary.engineFireworkSound = sounds:playSound("minecraft:entity.firework_rocket.launch", anchorPos, 0.5, 0.5)
					elseif tick == 146 then
						FaceParts:setEmotion("NORMAL", "CLOSED", "BIG", 77, true)
						self.exSkill.primary.whistleSound = sounds:playSound("minecraft:item.goat_horn.sound.1", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train), 1, 0.5)
					end

					local bodyYaw = player:getBodyYaw()
					particles:newParticle("minecraft:campfire_cosy_smoke", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1ChimneyParticleAnchor):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, tick < 146 and 1 or 0, 0, 1, 0))):setScale(5):setVelocity(0, 0.2, 0)
					if tick % (tick < 114 and 4 or (tick < 140 and 3 or 2)) == 0 then
						sounds:playSound(self.exSkill.primary.trainSoundCounter % 2 == 0 and "minecraft:block.piston.extend" or "minecraft:block.piston.contract", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train), 0.5, (tick < 114 and 0.25 or (tick < 140 and 0.3 or 0.35)) * (math.random() * 0.1 + 0.9))
						self.exSkill.primary.trainSoundCounter = self.exSkill.primary.trainSoundCounter + 1
					end
					if tick >= 15 then
						for i = 1, 3 do
							particles:newParticle("minecraft:electric_spark", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train["TrainCar"..i]["TrainCar"..i.."Platform"]["TrainCar"..i.."PlatformRightParticleAnchor"])):setScale(2):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * -0.5, math.random() * 1, 1, 0, 1, 0)):setColor(1, 0.953, 0.408)
							particles:newParticle("minecraft:electric_spark", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train["TrainCar"..i]["TrainCar"..i.."Platform"]["TrainCar"..i.."PlatformLeftParticleAnchor"])):setScale(2):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.5, math.random() * 1, 1, 0, 1, 0)):setColor(1, 0.953, 0.408)
						end
						local dustColors = {vectors.vec3(1, 0.878, 0.592), vectors.vec3(0.824, 0.718, 0.49)}
						local randomNum = math.random() * 0.5 - 0.25
						randomNum = randomNum >= 0 and randomNum + 0.25 or randomNum - 0.25
						randomNum = (tick >= 126 and tick < 146) and randomNum / 2 or randomNum
						particles:newParticle("minecraft:poof", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1DustParticleAnchor)):setScale((tick >= 126 and tick < 146) and 20 or ((tick < 73 or tick >= 126) and 10 or 2)):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, randomNum, math.random() * 0.5, tick < 118 and 1 or (tick < 108 and 1.5 or 2), 0, 1, 0)):setColor(dustColors[1]:copy():add(dustColors[2]:copy():sub(dustColors[1]):scale(math.random())))
						if tick < 58 then
							sounds:playSound("minecraft:block.grindstone.use", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train), 0.5 * math.min(tick * -0.05 + 2.9, 1), 3)
						end
					end
					if tick >= 104 and tick < 118 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1RightFirework.TrainCar1RightFireworkParticleAnchor, ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1LeftFirework.TrainCar1LeftFireworkParticleAnchor}) do
							particles:newParticle("minecraft:large_smoke", ModelUtils.getModelWorldPos(modelPart):add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, 1, 0, 1, 0))):setScale(1.5):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, 0.8, 0, 1, 0))
						end
					elseif tick >= 104 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1RightFirework.TrainCar1RightFireworkParticleAnchor, ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1LeftFirework.TrainCar1LeftFireworkParticleAnchor}) do
							local anchorPos = ModelUtils.getModelWorldPos(modelPart)
							particles:newParticle("minecraft:large_smoke", ModelUtils.getModelWorldPos(modelPart):add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, 2, 0, 1, 0))):setScale(2):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, 0.8, 0, 1, 0))
							particles:newParticle("minecraft:soul_fire_flame", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, 2, 0, 1, 0))):setScale(2):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, 0.8, 0, 1, 0))
							particles:newParticle("minecraft:firework", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, 2, 0, 1, 0))):setScale(1.5):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, 0.8, 0, 1, 0))
						end
					end
					if tick >= 118 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1RightFirework)
						self.exSkill.primary.engineFireworkSound:setPos(anchorPos)
						if (tick - 118) % 4 == 0 then
							sounds:playSound("minecraft:item.firecharge.use", anchorPos, 0.25, 0.5)
						end
						if tick >= 146 then
							self.exSkill.primary.whistleSound:setPos(anchorPos)
						end
					end
				end;

				onPostAnimation = function (self, forcedStop)
					TrainManager:stopExSkillRail()
					self.exSkill.primary.trainSoundCounter = 0
					if forcedStop then
						if host:isHost() then
							events.RENDER:remove("ex_skill_1_background_render")
							models.models.main.Avatar:setColor(1, 1, 1)
							models.models.ex_skill_1.CameraBackground:setVisible(false)
						end
						TrainManager:removeAll()
					else
						TrainManager:playTrainAnimation()
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---汽車のシュポシュポ音の回数をカウントする変数
			---@type integer
			trainSoundCounter = 0;

			---エンジンのロケット花火の音のインスタンス
			---@type Sound|nil
			engineFireworkSound = nil;

			---汽笛の音のインスタンス
			---@type Sound|nil
			whistleSound = nil;
		};

		callbacks = {
			additionalCheckFunc = function (self)
				return SyupogakiDance.danceState == "NOT_STANDBY"
			end;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.Hat:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.ShoulderBag:setVisible(not isVisible)
				end
				ModelAlias.alias.avatar.body.BeltAccessories:setVisible(not Armor.isArmorVisible.chestplate and not Armor.isArmorVisible.leggings)
			end;
		};
	};

	bubble = {
		callbacks = {
			additionalCheckFunc = function ()
				return SyupogakiDance.danceState == "NOT_STANDBY"
			end;

			onPlay = function (_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("NORMAL", "CLOSED", "OPENED", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "CIRCLE", duration, true)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", duration, true)
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
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.body.TailXPivot:setRot(10, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(-20, 0, -2.5)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(-20, 0, -2.5)
				ModelAlias.alias.dummy_avatar.body.TailXPivot:setRot(60, 0, -15)
				ModelAlias.alias.dummy_avatar.body.TailXPivot.TailYPivot.Tail.Tail2:setRot(0, 0, 0)
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
						neutral = 0;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 90;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = 90;
						};

						bodyY = {
							multiplayer = 80;
							min = -180;
							max = 0;
						};
					};

					horizontal = {
						min = -180;
						neutral = -45;
						max = 95;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.LeftHairTail.LeftHairTailZPivot};

				z = {
					vertical = {
						min = -70;
						neutral = 0;
						max = 90;

						headZ = {
							multiplayer = -80;
							min = -70;
							max = 90;
						};
					};

					horizontal = {
						min = -70;
						neutral = 0;
						max = 90;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail};

				x = {
					vertical = {
						min = -180;
						neutral = 0;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 90;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = 90;
						};

						bodyY = {
							multiplayer = 80;
							min = -180;
							max = 0;
						};
					};

					horizontal = {
						min = -180;
						neutral = -45;
						max = 95;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail.RightHairTailZPivot};

				z = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 70;

						headZ = {
							multiplayer = -80;
							min = -90;
							max = 70;
						};
					};

					horizontal = {
						min = -90;
						neutral = 0;
						max = 70;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BeltAccessories};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 155;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -160;
							min = 0;
							max = 155;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
						max = 155;

						bodyX = {
							multiplayer = 0;
							min = -40;
							max = 155;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.TailXPivot};

				x = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;
						sneakOffset = 15;

						bodyY = {
							multiplayer = 40;
							min = -40;
							max = 40;
						};
					};

					horizontal = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyX = {
							multiplayer = 40;
							min = -40;
							max = 40;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.TailXPivot.TailYPivot};

				y = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyZ = {
							multiplayer = -80;
							min = -40;
							max = 40;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---ノゾミが乗る列車のレールオブジェクトのインスタンスクラス
		RailObject = require("scripts.rail_object")

		---ノゾミが乗る列車を制御するクラス
		---@type Character16a.TrainManager
		TrainManager = require("scripts.train_manager")
		TrainManager = TrainManager.new()

		---シュポガキダンスを制御するクラス
		---@type Character16a.SyupogakiDance
		SyupogakiDance = require("scripts.syupogaki_dance")

		SyupogakiDance:init()
		TrainManager.init()
	end;
}

return BlueArchiveCharacter
