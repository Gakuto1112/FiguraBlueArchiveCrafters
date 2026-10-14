---右目のテクスチャの列挙型
---@alias Character02a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANGRY" # 上釣り目
---| "CLOSED2" # 横棒

---左目のテクスチャの列挙型
---@alias Character02a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANGRY" # 怒った目
---| "CLOSED2" # 横棒

---口のテクスチャの列挙型
---@alias Character02a.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "CIRCLE" # 丸口
---| "SMILE" # にっこり
---| "SAD" # への口

---@class (exact) Character02a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character02a.RightEyeTextures 右目の表情名
---@field public leftEye Character02a.LeftEyeTextures 左目の表情名
---@field public mouth Character02a.MouthTextures 口の表情名

---@class (exact) Character02a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character02a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character02a.EmotionSet ベッドで寝ているとき

---@class (exact) Character02a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character02a, right: Character02a.RightEyeTextures, left: Character02a.LeftEyeTextures, mouth: Character02a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character02a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character02a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character02a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character02a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character02a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character02a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character02a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character02a.FacePartsStruct 目や口による表情

---@type Character02a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "02a_Izuna";

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
		skirtModels = {models.models.main.Avatar.UpperBody.Body.Skirt};
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
			model = models.models.ex_skill_1.PlacementObject;

			boundingBox = {
				size = vectors.vec3(12, 19, 12)
			};

			placementMode = "MOVE";

			callbacks = {
				onInit = function (self)
					animations["models.ex_skill_1"]["swing"]:play()
					self.placementObjects.swingCoolDown = 60
				end;

				onTick = function (self, placementObject)
					if raycast:entity(placementObject.currentPos, placementObject.currentPos:copy():add(0, 1.2, 0), function (entity)
						return entity:isLiving() and entity:isMoving()
					end) and self.placementObjects.swingCoolDown == 0 then
						animations["models.ex_skill_1"]["swing"]:play()
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

			models = {};

			animations = {"main"};

			camera = {
				start = {
					rot = vectors.vec3(10, -160, 10);
					pos = vectors.vec3(-36.3, 26, -27);
				};

				fin = {
					rot = vectors.vec3(-50, -160, 0);
					pos = vectors.vec3(-3, 16, -104);
				};

				legacyMode = true;
			};

			callbacks = {
				onPreTransition = function ()
					PlacementObjectManager:removeAll()
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "NORMAL", 19, true)
					elseif tick == 19 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "NORMAL", 3, true)
					elseif tick == 22 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "CIRCLE", 5, true)
					elseif tick == 27 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", 24, true)
					elseif tick == 29 then
						sounds:playSound("minecraft:entity.player.attack.weak", player:getPos(), 0.5, 1.5)
					elseif tick == 31 then
						ExSkillTextObjectManager:spawn(vectors.vec2(2, 5.5), "神")
					elseif tick == 34 then
						ExSkillTextObjectManager:spawn(vectors.vec2(2, 0.5), "出")
					elseif tick == 35 or tick == 40 or tick == 43 or tick == 48 then
						sounds:playSound("minecraft:entity.player.attack.weak", player:getPos(), 0.25, 1.5)
					elseif tick == 38 then
						ExSkillTextObjectManager:spawn(vectors.vec2(-5.5, 5.5), "鬼")
					elseif tick == 41 then
						ExSkillTextObjectManager:spawn(vectors.vec2(-5.5, 0.5), "没")
					elseif tick == 49 then
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.5, 1.5)
					elseif tick == 50 and host:isHost() then
						models.models.ex_skill_1.CameraBackground:setVisible(true)
						local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw() + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.75)), 0, 1, 0):scale(16 / 0.9375)
						models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
						models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
						local windowSize = client:getWindowSize()
						models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(40))
						ModelAlias.alias.avatar.root:setColor(0, 0, 0)
						ExSkillTextObjectManager:setBlack(true)
						renderer:setPostEffect("invert")
					elseif tick == 51 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "CIRCLE", 10, true)
					elseif tick == 53 and host:isHost() then
						models.models.ex_skill_1.CameraBackground:setVisible(false)
						ModelAlias.alias.avatar.root:setColor(1, 1, 1)
						ExSkillTextObjectManager:setBlack(false)
						renderer:setPostEffect()
					elseif tick == 58 then
						local playerPos = player:getPos()
						for _ = 1, 70 do
							particles:newParticle("minecraft:poof", playerPos:copy():add(math.random() * 2 - 1, math.random() * 3 - 0.5, math.random() * 2 - 1))
						end
					elseif tick == 61 then
						ExSkillTextObjectManager:removeAll()
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 12, true)
					elseif tick == 73 then
						FaceParts:setEmotion("NORMAL", "CLOSED", "OPENED", 27, true)
						local avatarPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						for _ = 1, 100 do
							local offset = vectors.vec3(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1)
							particles:newParticle("minecraft:cherry_leaves", avatarPos:copy():add(offset)):setVelocity(offset:scale(0.1))
						end
						sounds:playSound("minecraft:item.armor.equip_leather", avatarPos)
					elseif tick == 98 then
						if math.random() >= 0.95 then
							self.placementObjects[1].model:setPrimaryTexture("RESOURCE", "textures/entity/fox/snow_fox.png")
						else
							self.placementObjects[1].model:setPrimaryTexture("PRIMARY")
						end
						PlacementObjectManager:spawn(1, ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), player:getBodyYaw() * -1 + 180)
					end
					if tick <= 10 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.ExSkillAnchor1)
						local velocityRot = vectors.rotateAroundAxis(-player:getBodyYaw(), -0.1, 0, 0, 0, 1, 0)
						for _ = 1, 2 do
							particles:newParticle("minecraft:cherry_leaves", anchorPos:copy():add(math.random() * 3 -  1.5, math.random() * 3, math.random() * 3 - 1.5)):setVelocity(velocityRot)
						end
					end
				end;

				onPostAnimation = function (_, forcedStop)
					if forcedStop then
						ExSkillTextObjectManager:removeAll()
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							ModelAlias.alias.avatar.root:setColor(1, 1, 1)
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
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.BackRibbon:setVisible(not isVisible)
					ModelAlias.alias.avatar.body.Scarfs:setPos(0, 0, isVisible and 1 or 0)
				elseif parts == "LEGGINGS" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt, ModelAlias.alias.avatar.body.BackRibbon}) do
						modelPart:setVisible(false)
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
				ModelAlias.alias.dummy_avatar.body.Scarfs.Scarf1:setRot(40, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Scarfs.Scarf2:setRot(40, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(25, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairAccessories.HairAccessoryRight.HairTail:setRot(-15, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairAccessories.HairAccessoryRight.Braid:setRot(-15, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Scarfs.Scarf1:setRot(75, 20, 0)
				ModelAlias.alias.dummy_avatar.body.Scarfs.Scarf1.Scarf1YPivot:setRot(0, 0, -20)
				ModelAlias.alias.dummy_avatar.body.Scarfs.Scarf2:setRot(75, 20, 0)
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
				models = {ModelAlias.alias.avatar.body.Scarfs.Scarf1, ModelAlias.alias.avatar.body.Scarfs.Scarf2};

				x = {
					vertical = {
						min = -30;
						neutral = 75;
						max = 75;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 75;
						};

						bodyY = {
							multiplayer = 80;
							min = -30;
							max = 75;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -30;
							max = 75;
						};
					};

					horizontal = {
						min = -30;
						neutral = 75;
						max = 75;
					};
				};
			};

			{
				models = {models.models.main.Avatar.UpperBody.Body.Scarfs.Scarf1.Scarf1YPivot};

				y = {
					vertical = {
						min = -70;
						neutral = 15;
						max = 80;

						bodyX = {
							multiplayer = -20;
							min = 0;
							max = 15;
						};

						bodyZ = {
							multiplayer = -80;
							min = -70;
							max = 80;
						};

						bodyRot = {
							multiplayer = 0.01;
							min = 0;
							max = 15;
						};
					};

					horizontal = {
						min = -70;
						neutral = 15;
						max = 80;

						bodyX = {
							multiplayer = -20;
							min = 0;
							max = 15;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Scarfs.Scarf2.Scarf2YPivot};

				y = {
					vertical = {
						min = -80;
						neutral = -15;
						max = 70;

						bodyX = {
							multiplayer = 20;
							min = -15;
							max = 0;
						};

						bodyZ = {
							multiplayer = -80;
							min = -80;
							max = 70;
						};

						bodyRot = {
							multiplayer = -0.01;
							min = -15;
							max = 0;
						};
					};

					horizontal = {
						min = -80;
						neutral = -15;
						max = 70;

						bodyX = {
							multiplayer = 20;
							min = 0;
							max = -15;
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
		};
	};

	---初期化関数
	init = function ()
		---Exスキルで使用するテキストオブジェクトのマネージャークラス
		---@type Character02a.ExSkillTextObject
		ExSkillTextObject = require("scripts.ex_skill_1_text_object")

		---Exスキルで使用するテキストオブジェクトのマネージャークラス
		---@type Character02a.ExSkillTextObjectManager
		ExSkillTextObjectManager = require("scripts.ex_skill_1_text_object_manager")
		ExSkillTextObjectManager = ExSkillTextObjectManager:new()

		---忍術ワープの表現
		---@type Character02a.Teleport
		Teleport = require("scripts.teleport")

		Teleport:init()
	end
}

return BlueArchiveCharacter
