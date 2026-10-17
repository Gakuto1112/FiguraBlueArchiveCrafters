---右目のテクスチャの列挙型
---@alias Character21b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ABOVE" # 上を見る目
---| "CENTER" # 少し反対側を見る目

---左目のテクスチャの列挙型
---@alias Character21b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "ABOVE" # 上を見る目

---口のテクスチャの列挙型
---@alias Character21b.MouthTextures
---| "NORMAL" # 通常
---| "SMILE" # にっこり口
---| "O" # 丸めた口
---| "SURPRISED" # あんぐり口
---| "OPENED" # 開いた口

---@class (exact) Character21b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character21b.RightEyeTextures 右目の表情名
---@field public leftEye Character21b.LeftEyeTextures 左目の表情名
---@field public mouth Character21b.MouthTextures 口の表情名

---@class (exact) Character21b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character21b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character21b.EmotionSet ベッドで寝ているとき

---@class (exact) Character21b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character21b, right: Character21b.RightEyeTextures, left: Character21b.LeftEyeTextures, mouth: Character21b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character21b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character21b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character21b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character21b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character21b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character21b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character21b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character21b.FacePartsStruct 目や口による表情

---@type Character21b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "21b_Hanae_Christmas";

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

			models = {ModelAlias.alias.avatar.body.ChristmasBag, ModelAlias.alias.avatar.body.Camera, models.models.ex_skill_1.Scaffolding, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 170, -5);
					pos = vectors.vec3(16, 4, -48);
				};

				fin = {
					rot = vectors.vec3(-10, 210, 0);
					pos = vectors.vec3(-36, 26, -102);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.Scaffolding:setPrimaryTexture("RESOURCE", "minecraft:textures/block/bricks.png")
						self.exSkill.primary.isInitialized = true
					end
					if host:isHost() then
						local windowSize = client:getScaledWindowSize()
						models.models.ex_skill_1.Gui.ShineGui:setPos(windowSize:copy():scale(-0.5):augmented(1))
						models.models.ex_skill_1.Gui.ScreenFilter:setScale(windowSize:copy():augmented(1))
						events.RENDER:register(function (delta)
							local scale = math.max(windowSize.x, windowSize.y) / 15 * models.models.ex_skill_1.Gui.ShineScale:getAnimScale().x
							models.models.ex_skill_1.Gui.ShineGui:setScale(scale, scale, 1)
							models.models.ex_skill_1.Gui.ScreenFilter:setOpacity(models.models.ex_skill_1.Gui.FilterOpacity:getAnimScale().x)
						end, "ex_skill_1_render")
					end
					FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 27, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 27 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 5, true)
					elseif tick == 32 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 4, true)
					elseif tick == 34 then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 1, 2)
					elseif tick == 35 then
						ModelAlias.alias.avatar.root:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
					elseif tick == 36 then
						FaceParts:setEmotion("CLOSED", "NORMAL", "OPENED", 8, true)
						ModelAlias.alias.avatar.root:setPrimaryRenderType("CUTOUT")
					elseif tick == 37 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightItemPivot)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 6 do
							ExSkillSpriteManager:spawn(models.models.ex_skill_1["Gift" .. math.random(1, 5)], models.script_ex_skill_sprites, 1, nil, anchorPos, vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 10 - 5, 3, 0, 0, 1, 0), vectors.vec3(math.random() * 360, math.random() * 360, math.random() * 360), vectors.vec3(math.random() * 360 - 180, math.random() * 360 - 180, math.random() * 360 - 180), 1, nil, 24, false)
						end
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 3)
					elseif tick == 44 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 6, true)
					elseif tick == 50 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 6, true)
					elseif tick == 56 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 7, true)
					elseif tick == 63 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 4, true)
					elseif tick == 67 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 3, true)
					elseif tick == 70 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 3, true)
					elseif tick == 72 then
						if host:isHost() then
							ModelAlias.alias.avatar.root:setColor(0.5, 0.5, 0.5)
						end
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.Chest)
						local bodyYaw = player:getBodyYaw()
						for i = 0, 17 do
							particles:newParticle("minecraft:firework", anchorPos):setScale(0.75):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 - 30, vectors.rotateAroundAxis(i * 20, 0, 0.1 + math.random() * 0.15, 0, 0, 0, 1):add(0.02, 0.1, 0.05), 0, 1, 0)):setColor(1, 0.902, 0.576):setGravity(0)
						end
					elseif tick == 73 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 6, true)
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.ChristmasBag)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 8 do
							ExSkillSpriteManager:spawn(models.models.ex_skill_1["Gift" .. math.random(1, 5)], models.script_ex_skill_sprites, 1, nil, anchorPos, vectors.rotateAroundAxis(bodyYaw * -1 - 30, math.random() * 10 - 5, math.random() * 2 + 5, 0, 0, 1, 0), vectors.vec3(math.random() * 360, math.random() * 360, math.random() * 360), vectors.vec3(math.random() * 360 - 180, math.random() * 360 - 180, math.random() * 360 - 180), 1, nil, 33, false)
						end
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 1.5)
					elseif tick == 76 and host:isHost() then
						ModelAlias.alias.avatar.root:setColor()
					elseif tick == 79 then
						FaceParts:setEmotion("CENTER", "NORMAL", "OPENED", 25, true)
					end

					if tick < 81 and(tick - 1) % 18 == 0 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.mouth)
						particles:newParticle("minecraft:cloud", anchorPos):setScale(0.75):setVelocity(ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.FaceParts.ExSkill1ParticleAnchor2):copy():sub(anchorPos):normalize():scale(0.22):add(0, math.random() * 0.1 - 0.05, 0))
					end
				end;

				onPostAnimation = function (_, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						if forcedStop then
							ModelAlias.alias.avatar.root:setColor()
						end
					end
					if forcedStop then
						ModelAlias.alias.avatar.root:setPrimaryRenderType("CUTOUT")
						ExSkillSpriteManager:removeAll()
					end
				end;
			};

			---このExスキルが初期化されたかどうか
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Chest:setVisible(not isVisible)
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
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
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(30, 0,30)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(30, 0, -30)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(60, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(-20, 0,10)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(-20, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(10, 0, 0)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
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

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail};

				x = {
					vertical = {
						min = -10;
						neutral = 2.5;
						max = 165;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -10;
							max = 90;
						};

						headRot = {
							multiplayer = -0.05;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 165;
						};
					};

					horizontal = {
						min = -45;
						neutral = 45;
						max = 165;

						headX = {
							multiplayer = -160;
							min = -45;
							max = 45;
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

						headX = {
							multiplayer = 20;
							min = 5;
							max = 20;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.LeftHairTail};

				x = {
					vertical = {
						min = -10;
						neutral = 2.5;
						max = 165;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -10;
							max = 90;
						};

						headRot = {
							multiplayer = -0.05;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 165;
						};
					};

					horizontal = {
						min = -45;
						neutral = 45;
						max = 165;

						headX = {
							multiplayer = -160;
							min = -45;
							max = 45;
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

						headX = {
							multiplayer = -20;
							min = -20;
							max = 5;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---Exスキルで使用するスプライトオブジェクトのインスタンスクラス
		---@type Character21b.ExSkillSprite
		ExSkillSprite = require("scripts.ex_skill_sprite")

		---Exスキルで使用するスプライトオブジェクトのマネージャークラス
		---@type Character21b.ExSkillSpriteManager
		ExSkillSpriteManager = require("scripts.ex_skill_sprite_manager")
		ExSkillSpriteManager = ExSkillSpriteManager.new()

		ExSkillSpriteManager.init()
	end;
}

return BlueArchiveCharacter
