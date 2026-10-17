---右目のテクスチャの列挙型
---@alias Character02b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANGRY" # 上釣り目
---| "CLOSED2" # 横棒

---左目のテクスチャの列挙型
---@alias Character02b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANGRY" # 怒った目
---| "CLOSED2" # 横棒

---口のテクスチャの列挙型
---@alias Character02b.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "CIRCLE" # 丸口
---| "SMILE" # にっこり
---| "SAD" # への口

---@class (exact) Character02b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character02b.RightEyeTextures 右目の表情名
---@field public leftEye Character02b.LeftEyeTextures 左目の表情名
---@field public mouth Character02b.MouthTextures 口の表情名

---@class (exact) Character02b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character02b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character02b.EmotionSet ベッドで寝ているとき

---@class (exact) Character02b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character02b, right: Character02b.RightEyeTextures, left: Character02b.LeftEyeTextures, mouth: Character02b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character02b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character02b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character02b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character02b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character02b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character02b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character02b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character02b.FacePartsStruct 目や口による表情

---@type Character02b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "02b_Izuna_Swimsuit";

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
			ANGRY = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(7, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			ANGRY = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(6, 0);
		};

		mouth = {
			OPENED = vectors.vec2(0, 0);
			CIRCLE = vectors.vec2(1, 0);
			SMILE = vectors.vec2(2, 0);
			SAD = vectors.vec2(3, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 1, -6);
					left = vectors.vec3(2.25, 1, -6);
				};

				thirdPersonPos = {
					right = vectors.vec3(-0.5, 0, -7);
					left = vectors.vec3(2.5, 0, -7);
				}
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, 1, 3);
					left = vectors.vec3(2, 1, 3);
				};

				rot = {
					right = vectors.vec3(-20, 90, 0);
					left = vectors.vec3(-20, -90, 0);
				};
			};
		};

		sound = {
			name = "minecraft:entity.firework_rocket.blast";
			pitch = 1;
		};
	};

	placementObjects = {
		{
			model = models.models.kitsune_puppet.PlacementObject;

			boundingBox = {
				size = vectors.vec3(12, 19, 12)
			};

			placementMode = "MOVE";

			callbacks = {
				onInit = function (self)
					animations["models.kitsune_puppet"]["swing"]:play()
					self.placementObjects.swingCoolDown = 60
				end;

				onTick = function (self, placementObject)
					if raycast:entity(placementObject.currentPos, placementObject.currentPos:copy():add(0, 1.2, 0), function (entity)
						return entity:isLiving() and entity:isMoving()
					end) and self.placementObjects.swingCoolDown == 0 then
						animations["models.kitsune_puppet"]["swing"]:play()
						self.placementObjects.swingCoolDown = 60
					end
					self.placementObjects.swingCoolDown = math.max(self.placementObjects.swingCoolDown - 1, 0)
				end;
			};

			---人形が揺れるアニメーション再生後に再び再生できるようになるまでの時間
			---@type integer
			swingCoolDown = 60
		};
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_1.BeachBall};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, -160, -10);
					pos = vectors.vec3(-6, 30, -60);
				};

				fin = {
					rot = vectors.vec3(-10, -150, -10);
					pos = vectors.vec3(-4, 154, -350);
				};

				legacyMode = true;
			};

			callbacks = {
				onAnimationTick = function (_, tick)
					if tick < 25 then
						if tick == 0 then
							FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", 19, true)
						elseif tick == 19 then
							FaceParts:setEmotion("ANGRY", "ANGRY", "CIRCLE", 2, true)
						elseif tick == 21 then
							FaceParts:setEmotion("CLOSED", "CLOSED", "CIRCLE", 22, true)
						end
						local anchor1Pos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						local particleBlock = world.getBlockState(anchor1Pos:copy() - 1).id
						if particleBlock ~= "minecraft:air" and particleBlock ~= "minecraft:void_air" then
							for _ = 1, 50 do
								particles:newParticle("minecraft:block " .. particleBlock, anchor1Pos:copy():add(math.random() - 0.5, 0, math.random() - 0.5)):setVelocity(math.random() * 0.5 - 0.25, math.random() * 0.5, math.random() * 0.5 - 0.25)
							end
						end
					elseif tick == 25 then
						ModelAlias.alias.avatar.root:setVisible(false)
						local anchor1Pos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						for _ = 1, 30 do
							particles:newParticle("minecraft:poof", anchor1Pos:copy():add(math.random() - 0.5, math.random() * 2, math.random() - 0.5))
						end
						sounds:playSound("minecraft:entity.bat.takeoff", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 2)
					elseif tick == 28 then
						renderer:setPostEffect("phosphor")
					elseif tick == 38 then
						renderer:setPostEffect()
					elseif tick == 43 then
						ModelAlias.alias.avatar.root:setVisible(true)
						FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", 42, true)
					elseif tick == 44 then
						local avatarPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root):add(0, -1.5, 0)
						for _ = 1, 30 do
							particles:newParticle("minecraft:poof", avatarPos:copy():add(math.random() - 0.5, math.random() * 2, math.random() - 0.5))
						end
					elseif tick >= 45 and tick <= 60 then
						local avatarPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body)
						if tick == 45 then
							local bodyYaw = player:getBodyYaw()
							local particleDirection = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(40, 0, 0, 1, 1, 0, 0), 0, 1, 0)
							for i = 1, 30 do
								for j = 0.7, 1.5, 0.1 do
									particles:newParticle("minecraft:dust 1 1 1 1", vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(40, math.cos(math.rad(i * 12)) * j, math.sin(math.rad(i * 12)) * j, 0, 1, 0, 0), 0, 1, 0):add(avatarPos)):setColor(math.random() * 0.25 + 0.5, 1, 1):setVelocity(particleDirection:copy():scale(math.random() * 0.1 + 0.2)):setLifetime(math.random() * 10 + 10)
								end
								local particlePos = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(40, math.cos(math.rad(i * 12)) * 1.5, math.sin(math.rad(i * 12)) * 1.5, 0, 1, 0, 0), 0, 1, 0):add(avatarPos)
								particles:newParticle("minecraft:dust 1 1 1 1", particlePos):setColor(1, 1, 1):setVelocity(particleDirection:copy():scale(math.random() * 0.1 + 0.2)):setLifetime(math.random() * 10 + 10)
							end
						end
						sounds:playSound("minecraft:item.bucket.empty", avatarPos, 1 - math.map(tick, 45, 60, 0, 0.5), 0.75)
					elseif tick == 79 and host:isHost() then
						models.models.ex_skill_1.CameraBackground:setVisible(true)
						local windowSize = client:getWindowSize()
						models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(45))
						local shouldAdjustBackgroundRot = StringUtils.isNewerOrEqualVersion(client:getVersion(), "1.21")
						events.RENDER:register(function (delta, context)
							models.models.ex_skill_1.CameraBackground:setVisible(context == "RENDER")
							local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(2)), 0, 1, 0):scale(16 / 0.9375)
							models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
							models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
							if shouldAdjustBackgroundRot then
								models.models.ex_skill_1.CameraBackground.Background:setRot(0, 0, renderer:getCameraRot().z)
							end
						end, "ex_skill_2_background_render")
						ModelAlias.alias.avatar.root:setColor(0, 0, 0)
						for _, modelPart in ipairs({ModelAlias.alias.avatar.root, models.models.ex_skill_1.BeachBall}) do
							modelPart:setColor(0, 0, 0)
						end
					elseif tick == 80 then
						renderer:setPostEffect("invert")
					elseif tick == 84 then
						renderer:setPostEffect()
					elseif tick == 85 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "OPENED", 16, true)
						models.models.ex_skill_1.BeachBall:setUVPixels(0, 7)
						models.models.ex_skill_1.BeachBall:setPrimaryRenderType("EMISSIVE_SOLID")
						sounds:playSound("minecraft:entity.blaze.death", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 2)
					elseif tick == 86 then
						local bodyYaw = player:getBodyYaw()
						local anchor2Pos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root):add(vectors.rotateAroundAxis(-bodyYaw, -0.1, 0, 0, 0, 1, 0)):add(0, 0.4, 0)
						local particleAxis = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(30, 0, 0, 1, 1, 0, 0), 0, 1, 0)
						local particleVelocityDirection = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(-50, 0, 0, 1, 1, 0, 0), 0, 1, 0)
						for i = 1, 60 do
							local currentParticleVelocityDirection = vectors.rotateAroundAxis(i * 6, particleVelocityDirection, particleAxis)
							for _, particleData in ipairs({{0.5, 0.4, 0.1}, {0.25, 0.6, 0.025}, {0.375, 2, 0.05}}) do --[1]. 輪っかの半径, [2]. 輪っかの位置のスケール, [3]. 輪っかの拡散速度のスケール
								particles:newParticle("minecraft:dust 1 0 0 1", vectors.rotateAroundAxis(i * 6, 0, particleData[1], 0, particleAxis):add(anchor2Pos):add(0, 0.7, 0):add(particleAxis:copy():scale(particleData[2]))):setVelocity(currentParticleVelocityDirection:copy():scale(particleData[3])):setLifetime(20)
								particles:newParticle("minecraft:dust 0 0 0 1", vectors.rotateAroundAxis(i * 6, 0, particleData[1] * 1.5, 0, particleAxis):add(anchor2Pos):add(0, 0.7, 0):add(particleAxis:copy():scale(particleData[2]))):setVelocity(currentParticleVelocityDirection:copy():scale(particleData[3])):setLifetime(20)
							end
						end
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							events.RENDER:remove("ex_skill_2_background_render")
							for _, modelPart in ipairs({ModelAlias.alias.avatar.root, models.models.ex_skill_1.BeachBall}) do
								modelPart:setColor()
							end
						end
					elseif tick >= 101 then
						local bodyYaw = player:getBodyYaw()
						local anchor2Pos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root):add(vectors.rotateAroundAxis(-bodyYaw, -0.1, 0, 0, 0, 1, 0)):add(0, 0.8, 0)
						local particleAxis = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(30, 0, 0, 1, 1, 0, 0), 0, 1, 0)
						local particleVelocityDirection = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(-50, 0, 0, 1, 1, 0, 0), 0, 1, 0)
						if tick == 101 then
							FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 42, true)
							models.models.ex_skill_1.BeachBall:setUVPixels(0, 14)
							for i = 1, 60 do
								local currentParticleVelocityDirection = vectors.rotateAroundAxis(i * 6, particleVelocityDirection, particleAxis)
								for _, particleData in ipairs({{0.3, 3.5, 0.01, 0.5}, {0.5, 3.5, 0.01, 0.5}, {0.25, 7.9, 0.003, 0.2}, {0.28, 7.89, 0.003, 0.2}, {0.45, 7.85, 0.003, 0.5}}) do --[1]. 輪っかの半径, [2]. 輪っかの位置のスケール, [3]. 輪っかの拡散速度のスケール, [4]. 輪っかのパーティクルの大きさ
								local colorOffset = math.random() * 0.5 + 0.5
									particles:newParticle("minecraft:dust 1 1 1 1", vectors.rotateAroundAxis(i * 6, 0, particleData[1], 0, particleAxis):add(anchor2Pos):add(particleAxis:copy():scale(particleData[2]))):setScale(particleData[4]):setColor(1, colorOffset, colorOffset):setVelocity(currentParticleVelocityDirection:copy():scale(particleData[3])):setLifetime(45)
								end
							end
							sounds:playSound("minecraft:entity.lightning_bolt.thunder", ModelUtils.getModelWorldPos(models.models.ex_skill_1.BeachBall), 1, 2)
						end
						for _ = 1, 10 do
							local colorOffset = math.random() * 0.5 + 0.5
							particles:newParticle("minecraft:dust 1 1 1 1", anchor2Pos:copy():add(particleAxis:copy():scale(7.5)):add(vectors.rotateAroundAxis(-bodyYaw, 0, 0, 0.8, 0, 1, 0)):add(math.random() * 0.2 - 0.1, math.random() * 0.2 - 0.1 - 0.4, math.random() * 0.2 - 0.1)):setColor(1, colorOffset, colorOffset):setVelocity(particleAxis:copy():scale(-1))
						end
					end
					if tick <= 28 and tick % 4 == 0 then
						sounds:playSound("minecraft:block.sand.step", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root))
					end
				end;

				onPostAnimation = function (_, forcedStop)
					ModelAlias.alias.avatar.root:setVisible(true)
					models.models.ex_skill_1.BeachBall:setUVPixels()
					models.models.ex_skill_1.BeachBall:setPrimaryRenderType("CUTOUT")
					if host:isHost() then
						models.models.ex_skill_1.CameraBackground.Background:setColor()
						models.models.ex_skill_1.CameraBackground.Background:setOpacity(1)
						if forcedStop then
							events.RENDER:remove("ex_skill_2_background_render")
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							for _, modelPart in ipairs({ModelAlias.alias.avatar.root, models.models.ex_skill_1.BeachBall}) do
								modelPart:setColor()
							end
							renderer:setPostEffect()
						end
					end
				end;
			};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.SunVisor:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Scarf:setPos(0, 0, isVisible and -1 or 0)
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.leftLeg.LegAccessory:setVisible(not isVisible)
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
						FaceParts:setEmotion("ANGRY", "ANGRY", "OPENED", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SAD", duration, true)
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
				ModelAlias.alias.dummy_avatar.head.Ears.RightEarPivot:setRot(-49.02, -11.44, -9.77)
				ModelAlias.alias.dummy_avatar.head.Ears.LeftEarPivot:setRot(-49.02, 11.44, 9.77)
				ModelAlias.alias.dummy_avatar.head.HairAccessories.HairAccessoryRight.HairTail:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairAccessories.HairAccessoryRight.Braid:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(25, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairAccessories.HairAccessoryRight.HairTail:setRot(-15, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairAccessories.HairAccessoryRight.Braid:setRot(-15, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(30, 0, 0)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.Tail};

				x = {
					vertical = {
						min = -60;
						neutral = 45;
						max = 60;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 60;
						};

						bodyY = {
							multiplayer = 80;
							min = -60;
							max = 60;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = 0;
							max = 60;
						};
					};

					horizontal = {
						min = -60;
						neutral = 0;
						max = 60;
						sneakOffset = 30;

						bodyX = {
							multiplayer = 160;
							min = -60;
							max = 60;
						};
					};
				};

				y = {
					vertical = {
						min = -30;
						neutral = 0;
						max = 30;

						bodyZ = {
							multiplayer = -160;
							min = -30;
							max = 30;
						};
					};

					horizontal = {
						min = -30;
						neutral = 0;
						max = 30;

						bodyRot = {
							multiplayer = 0.05;
							min = -30;
							max = 30;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessories.HairAccessoryRight.HairTail};

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
				models = {ModelAlias.alias.avatar.head.HairAccessories.HairAccessoryRight.HairTail.HairTailZPivot};

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
							multiplayer = -0.05;
							min = 0;
							max = 60;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessories.HairAccessoryRight.Braid};

				x = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -160;
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

				z = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 60;

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};

						headZ = {
							multiplayer = -160;
							min = 0;
							max = 60;
						};

						headRot = {
							multiplayer = -0.05;
							min = 0;
							max = 60;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.SunVisor.SunflowerAccessory.WhiteRibbon};

				z = {
					vertical = {
						min = -40;
						neutral = -20;
						max = 160;

						bodyY = {
							multiplayer = -160;
							min = -20;
							max = 160;
						};

						headZ = {
							multiplayer = -160;
							min = -40;
							max = 70;
						};

						headRot = {
							multiplayer = -0.1;
							min = -20;
							max = 70;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Scarf};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 90;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};

						bodyRot = {
							multiplayer = -0.1;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
						max = 90;

						headX = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};
					};
				};
			};
		};
	};

	---初期化関数
	init = function ()
		---忍術ワープの表現
		---@type Character02b.Teleport
		Character02b_Teleport = require("scripts.teleport")

		ModelAlias.alias.avatar.head.SunVisor.SunflowerAccessory.Sunflower:setPrimaryTexture("RESOURCE", "textures/block/sunflower_front.png")
		Character02b_Teleport:init()

		events.RENDER:register(function ()
			if ModelAlias.alias.avatar.leftLeg.LegAccessory:getVisible() then
				ModelAlias.alias.avatar.leftLeg.LegAccessory:setRot((vanilla_model.LEFT_LEG:getOriginRot().x + ModelAlias.alias.avatar.leftLeg:getTrueRot().x) * -1, 0, 0)
			end
		end)
	end;
}

return BlueArchiveCharacter
