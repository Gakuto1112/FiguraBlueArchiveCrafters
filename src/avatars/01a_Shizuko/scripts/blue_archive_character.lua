---右目のテクスチャの列挙型
---@alias Character01a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "INVERTED" # 困りつつ、反対側を見る目
---| "UNEQUAL" # ><

---左目のテクスチャの列挙型
---@alias Character01a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "UNEQUAL" # ><
---| "CENTER" # 少し反対側を見る目

---口のテクスチャの列挙型
---@alias Character01a.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "TRIANGLE" # 三角形の口
---| "FRUST" # ぐじゅぐじゅ口
---| "SMILE" # にっこり
---| "WORRY" # 困った口

---@class (exact) Character01a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character01a.RightEyeTextures 右目の表情名
---@field public leftEye Character01a.LeftEyeTextures 左目の表情名
---@field public mouth Character01a.MouthTextures 口の表情名

---@class (exact) Character01a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character01a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character01a.EmotionSet ベッドで寝ているとき

---@class (exact) Character01a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character01a, right: Character01a.RightEyeTextures, left: Character01a.LeftEyeTextures, mouth: Character01a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character01a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character01a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character01a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character01a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character01a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character01a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character01a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character01a.FacePartsStruct 目や口による表情

---@type Character01a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "01a_Shizuko";

		birth = {
			month = 7;
			day = 7;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			INVERTED = vectors.vec2(7, 0);
			UNEQUAL = vectors.vec2(6, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			UNEQUAL = vectors.vec2(5, 0);
			CENTER = vectors.vec2(4, 0);
		};

		mouth = {
			OPENED = vectors.vec2(1, 0);
			TRIANGLE = vectors.vec2(2, 0);
			FRUST = vectors.vec2(3, 0);
			SMILE = vectors.vec2(4, 0);
			WORRY = vectors.vec2(0, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.skirt};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 1, -7);
					left = vectors.vec3(0, 1, -7);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.5, -0.25, -8);
					left = vectors.vec3(1.5, -0.25, -8);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(-1.5, 4, 3.5);
					left = vectors.vec3(1.5, 4, 3.5);
				};

				rot = {
					right = vectors.vec3(0, 90, -45);
					left = vectors.vec3(45, -90, 0);
				};
			};
		};

		sound = {
			name = "minecraft:entity.generic.explode";
			pitch = 2;
		};
	};

	placementObjects = {
            {
                model = models.models.ex_skill_1.Stall;

                boundingBox = {
                    size = vectors.vec3(20, 38, 20);
                };

                placementMode = "COPY";
            };
	};

	exSkill = {
		primary = {
			formationType = "SPECIAL";

			models = {models.models.ex_skill_1.Stall, ModelAlias.alias.avatar.rightArmBottom.TeaSet};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(-5, 23, -16);
				};

				fin = {
					rot = vectors.vec3(10, -105, 0);
					pos = vectors.vec3(-229.46, 22.31, -1.77);
				};

				legacyMode = true;
			};

			callbacks = {
				onPreTransition = function ()
					PlacementObjectManager:removeAll()
				end;

				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						ModelAlias.alias.avatar.rightArmBottom.TeaSet.WaterSpill:setPrimaryTexture("RESOURCE", "textures/block/water_still.png")
						ModelAlias.alias.avatar.rightArmBottom.TeaSet.WaterSpill:setColor(0.25, 0.39, 0.67)
						self.exSkill.primary.isInitialized = true
					end
					FaceParts:setEmotion("NORMAL", "CENTER", "OPENED", 22, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 22 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 2, true)
					elseif tick == 24 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "WORRY", 1, true)
					elseif tick == 25 then
						self.exSkill.primary.textTask:setVisible(true)
						FaceParts:setEmotion("INVERTED", "NORMAL", "TRIANGLE", 8, true)
					elseif tick == 33 then
						self.exSkill.primary.textTask:setVisible(false)
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 1, true)
					elseif tick == 34 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "FRUST", 1, true)
					elseif tick == 35 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "FRUST", 1, true)
					elseif tick == 36 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 10, true)
					elseif tick == 46 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "TRIANGLE", 1, true)
					elseif tick == 47 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "FRUST", 6, true)
					elseif tick == 53 then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "TRIANGLE", 14, true)
						local shouldAdjustBackgroundRot = StringUtils.isNewerOrEqualVersion(client:getVersion(), "1.21")
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground:setVisible(true)
							local windowSize = client:getWindowSize()
							models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(45))
							events.RENDER:register(function (delta, context)
								models.models.ex_skill_1.CameraBackground:setVisible(context == "RENDER")
								local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.75)), 0, 1, 0):scale(16 / 0.9375)
								models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
								models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
								if shouldAdjustBackgroundRot then
									models.models.ex_skill_1.CameraBackground.Background:setRot(0, 0, renderer:getCameraRot().z)
								end
							end, "ex_skill_1_background_render")
						end
						local particleAnchor = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root):add(0, 5, 0)
						local fireworkColor = vectors.hsvToRGB(math.random(), 0.8, 1)
						particles:newParticle("minecraft:flash{color:[" .. fireworkColor[1] .. ", " .. fireworkColor[2] .. ", " .. fireworkColor[3] .. ", 1]}", particleAnchor):setColor(fireworkColor)
						for _ = 1, 400 do
							local particleAngleX = math.random() * math.pi * 2
								local particleAngleY = math.random() * math.pi * 2
								particles:newParticle("minecraft:firework", particleAnchor):setVelocity(math.cos(particleAngleX) * math.cos(particleAngleY) * 0.2, math.sin(particleAngleY) * 0.2, math.sin(particleAngleX) * math.cos(particleAngleY) * 0.2):setColor(fireworkColor)
						end
						sounds:playSound("minecraft:entity.firework_rocket.large_blast", player:getPos())
					elseif tick == 56 then
						ModelAlias.alias.avatar.rightArmBottom.TeaSet:moveTo(models.models.main)
					elseif tick == 67 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "WORRY", 8, true)
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							events.RENDER:remove("ex_skill_1_background_render")
						end
						elseif tick == 69 then
							sounds:playSound("minecraft:block.glass.break", ModelUtils.getModelWorldPos(models.models.main.TeaSet.ExSkillSoundAnchor2), 1, 0.5)
						local particleAnchor1Pos = ModelUtils.getModelWorldPos(models.models.main.TeaSet.WaterSpill)
						for _ = 1, 20 do
							particles:newParticle("minecraft:splash", particleAnchor1Pos:copy():add(math.random() - 0.5, 0, math.random() - 0.5)):setLifetime(10)
						end
					elseif tick == 74 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "FRUST", 21, true)
						sounds:playSound("minecraft:entity.generic.small_fall", player:getPos(), 1)
						local particleAnchor1Pos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.ExSkillParticleAnchor1)
						for i = 0, 5 do
							local particleRot = math.rad(i * 60)
							particles:newParticle("minecraft:wax_off", particleAnchor1Pos):setColor(1, 1, 0):setLifetime(12):setVelocity(math.cos(particleRot) * 0.05, 0.1, math.sin(particleRot) * 0.05):setGravity(0.5)
						end
					end

					if tick >= 25 and tick < 33 then
						self.exSkill.primary.textTask:setPos(vectors.vec3(-9, 8, -8):add(math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25))
						if (tick - 25) % 2 == 0 then
							sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 1, 2)
						end
					end
					if tick < 56 and tick % 4 == 0 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.rightArmBottom.TeaSet.Yunomi1.ExSkill1ParticleAnchor2, ModelAlias.alias.avatar.rightArmBottom.TeaSet.Yunomi2.ExSkill1ParticleAnchor3}) do
							local particleAnchorPos = ModelUtils.getModelWorldPos(modelPart)
							particles:newParticle("minecraft:poof", particleAnchorPos):setScale(0.2):setVelocity():setLifetime(15)
						end
					end
					if tick % 2 == 0 and tick >= 70 then
						local particleAnchor5Pos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stall.ExSkillParticleAnchor5)
						for i = 0, 11 do
							local particleRot = i * (math.pi / 6)
							particles:newParticle("minecraft:block " .. "minecraft:dirt", particleAnchor5Pos:copy():add(math.cos(particleRot) * 0.6, 0, math.sin(particleRot) * 0.6))
						end
					end
					if tick % math.ceil((animations["models.main"]["ex_skill_1"]:getLength() * 20 - tick) / 20) == 0 then
						sounds:playSound("minecraft:entity.boat.paddle_land", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stall.Wheels.ExSkillSoundAnchor1))
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if models.models.main.TeaSet ~= nil then
						models.models.main.TeaSet:moveTo(ModelAlias.alias.avatar.rightArmBottom)
					end
					if forcedStop then
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							events.RENDER:remove("ex_skill_1_background_render")
						end
						self.exSkill.primary.textTask:setVisible(false)
					else
						local bodyYaw = player:getBodyYaw() % 360
						PlacementObjectManager:spawn(1, vectors.rotateAroundAxis(bodyYaw * -1, -12.75, 1, -0.8875, 0, 1, 0):add(player:getPos()), 180 + bodyYaw * -1)
					end
				end;
			};

			---初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---アニメーションに表示する「!!!」のテキストレンダータスク
			---@type TextTask
			textTask = models.models.main.CameraAnchor:newText("ex_skill_text_1"):setVisible(false):setText("§c! !"):setRot(0, 180, 5):setScale(0.8, 0.8, 0.8):setOutline(true):setOutlineColor(1, 1, 1);
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "HELMET" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.head.Brim, ModelAlias.alias.avatar.head.HairTails}) do
						modelPart:setVisible(not isVisible)
					end
				elseif parts == "CHEST_PLATE" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.BackRibbon, ModelAlias.alias.avatar.body.Skirt}) do
						modelPart:setVisible(not isVisible)
					end
					if isVisible then
						ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, -1)
						ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, 1)
						self.physics.physicData[1].x.vertical.neutral = 0
						self.physics.physicData[1].x.vertical.max = 0
						self.physics.physicData[1].x.vertical.bodyX.max = 0
						self.physics.physicData[1].x.vertical.bodyY.max = 0
						self.physics.physicData[1].x.vertical.bodyRot.max = 0
						self.physics.physicData[1].x.horizontal.neutral = 0
						self.physics.physicData[1].x.horizontal.max = 0
					else
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Hairs.FrontHair, ModelAlias.alias.avatar.body.Hairs.BackHair}) do
							modelPart:setPos()
						end
						self.physics.physicData[1].x.vertical.neutral = -10
						self.physics.physicData[1].x.vertical.max = -10
						self.physics.physicData[1].x.vertical.bodyX.max = -10
						self.physics.physicData[1].x.vertical.bodyY.max = -10
						self.physics.physicData[1].x.vertical.bodyRot.max = -10
						self.physics.physicData[1].x.horizontal.neutral = -10
						self.physics.physicData[1].x.horizontal.max = -10
					end
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "WORRY", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "TRIANGLE", duration, true)
						ModelAlias.alias.avatar.head.FaceLayer:setVisible(true)
					end
				end
			end;

			onStop = function (_, _, forcedStop)
				if not forcedStop then
					FaceParts:resetEmotion()
				end
				ModelAlias.alias.avatar.head.FaceLayer:setVisible(false)
			end;
		}
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
				ModelAlias.alias.avatar.body.Skirt:setRot(35, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.avatar.body.Skirt:setRot(15, 0, 0)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair},

				x = {
					vertical = {
						min = -150;
						neutral = -10;
						max = -10;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = -10;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = -10;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -10;
						};
					};

					horizontal = {
						min = -90;
						neutral = -10;
						max = -10;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Hairs.FrontHair};

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
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailLeft};

				z = {
					vertical = {
						min = 20;
						neutral = 30;
						max = 140;

						bodyY = {
							multiplayer = -80;
							min = 20;
							max = 140;
						};
					};

					horizontal = {
						min = 20;
						neutral = 30;
						max = 140;

						bodyX = {
							multiplayer = -80;
							min = 20;
							max = 140;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailRight};

				z = {
					vertical = {
						min = -140;
						neutral = -30;
						max = -20;

						bodyY = {
							multiplayer = 80;
							min = -140;
							max = -20;
						};
					};

					horizontal = {
						min = -140;
						neutral = -30;
						max = -20;

						bodyX = {
							multiplayer = 80;
							min = -140;
							max = -20;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Brim.BrimRibbon.BrimLines.BrimLineLeft, ModelAlias.alias.avatar.head.Brim.BrimRibbon.BrimLines.BrimLineRight};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 150;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};

						headRot = {
							multiplayer = -0.1;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -160;
							min = 0;
							max = 150;
						};
					};

					horizontal = {
						min = 0;
						neutral = 45;
						max = 150;

						headX = {
							multiplayer = -16;
							min = 0;
							max = 150;
						};
					};
				};

				z = {
					vertical = {
						min = -60;
						neutral = 0;
						max = 0;

						headZ = {
							multiplayer = -160;
							min = -60;
							max = 0;
						};
					};

					horizontal = {
						min = -60;
						neutral = 0;
						max = 0;
					};
				};
			};
		};
	};
}

return BlueArchiveCharacter
