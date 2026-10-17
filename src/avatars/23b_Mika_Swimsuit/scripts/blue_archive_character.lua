---右目のテクスチャの列挙型
---@alias Character23b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "NARROW2" # 細目2
---| "NARROW" # 細目
---| "NARROW_CENTER" # 少し反対側を見る細目
---| "UNEQUAL" # 不等号目
---| "FRUST" # 不満そうな目

---左目のテクスチャの列挙型
---@alias Character23b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "NARROW2" # 細目2
---| "NARROW" # 細目
---| "NARROW_CENTER" # 少し反対側を見る細目
---| "UNEQUAL" # 不等号目
---| "FRUST" # 不満そうな目

---口のテクスチャの列挙型
---@alias Character23b.MouthTextures
---| "NORMAL" # 通常
---| "OPENED_SMALL" # 小さく開いた口
---| "SMILE" # にっこり
---| "TEETH" # 歯を見せてにっこり
---| "OPENED" # 開いた口
---| "OPENED2" # 開いた口2
---| "OPENED3" # 開いた口3
---| "FRUST" # への口

---@class (exact) Character23b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character23b.RightEyeTextures 右目の表情名
---@field public leftEye Character23b.LeftEyeTextures 左目の表情名
---@field public mouth Character23b.MouthTextures 口の表情名

---@class (exact) Character23b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character23b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character23b.EmotionSet ベッドで寝ているとき

---@class (exact) Character23b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character23b, right: Character23b.RightEyeTextures, left: Character23b.LeftEyeTextures, mouth: Character23b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character23b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character23b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character23b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character23b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character23b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character23b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character23b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character23b.FacePartsStruct 目や口による表情

---@type Character23b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "23b_Mika_Swimsuit";

		birth = {
			month = 5;
			day = 8;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(5, 0);
			NARROW2 = vectors.vec2(6, 0);
			NARROW = vectors.vec2(8, 0);
			NARROW_CENTER = vectors.vec2(11, 0);
			UNEQUAL = vectors.vec2(12, 0);
			FRUST = vectors.vec2(13, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CLOSED2 = vectors.vec2(4, 0);
			NARROW2 = vectors.vec2(6, 0);
			NARROW = vectors.vec2(8, 0);
			NARROW_CENTER = vectors.vec2(9, 0);
			UNEQUAL = vectors.vec2(11, 0);
			FRUST = vectors.vec2(13, 0);
		};

		mouth = {
			OPENED_SMALL = vectors.vec2(0, 0);
			SMILE = vectors.vec2(1, 0);
			TEETH = vectors.vec2(2, 0);
			OPENED = vectors.vec2(3, 0);
			OPENED2 = vectors.vec2(4, 0);
			OPENED3 = vectors.vec2(5, 0);
			FRUST = vectors.vec2(6, 0);
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
					right = vectors.vec3(0, 2, -6);
					left = vectors.vec3(0, 2, -6);
				};

				thirdPersonPos = {
					right = vectors.vec3(-2, 0.5, -8);
					left = vectors.vec3(2, 0.5, -8);
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

			models = {models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-10, 90, 0);
					pos = vectors.vec3(16, 20.9, -8);
				};

				fin = {
					rot = vectors.vec3(-5, 90, 0);
					pos = vectors.vec3(-175, 23.4, -20);
				};
			};

			callbacks = {
				onPreAnimation = function ()
					events.TICK:remove("shooting_star_tick")

					if host:isHost() then
						models.models.ex_skill_1.Gui.ScreenFilter:setScale(client:getScaledWindowSize():copy():augmented(1))
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.ScreenFilter:setOpacity(models.models.ex_skill_1.Gui.FilterOpacity:getAnimScale().x)
						end, "ex_skill_1_render")
					end

					FaceParts:setEmotion("NARROW", "NARROW_CENTER", "TEETH", 31, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 31 then
						FaceParts:setEmotion("NARROW", "NARROW_CENTER", "OPENED", 14, true)
					elseif tick == 42 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.ExSkill1ParticleAnchor1)
						local bodyYaw = player:getBodyYaw()
						for i = 0, 35 do
							particles:newParticle("minecraft:end_rod", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + 80, vectors.rotateAroundAxis(i * 10, 0, 0.2, 0, 0, 0, 1), 0, 1, 0)):setColor(0.991, 0.783, 0.999):setLifetime(5)
						end
						for _ = 1, 20 do
							particles:newParticle("minecraft:firework", anchorPos):setScale(0.1):setVelocity(math.random() * 0.1 - 0.05, math.random() * 0.1 - 0.05, math.random() * 0.1 - 0.05):setColor(0.991, 0.783, 0.999):setGravity(0)
						end
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 3)
					elseif tick == 45 then
						FaceParts:setEmotion("NARROW", "NARROW_CENTER", "SMILE", 16, true)
					elseif tick == 61 then
						FaceParts:setEmotion("NARROW_CENTER", "NARROW", "SMILE", 6, true)
					elseif tick == 67 then
						FaceParts:setEmotion("NARROW", "NARROW", "SMILE", 16, true)
					elseif tick == 83 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED2", 67, true)
					elseif tick == 150 then
						FaceParts:setEmotion("NARROW", "NARROW_CENTER", "OPENED3", 21, true)
					elseif tick == 171 then
						FaceParts:setEmotion("CLOSED", "NARROW_CENTER", "TEETH", 62, true)

						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
							:copy()
							:add(vectors.rotateAroundAxis(bodyYaw * -1 + 90, 0, 0, -1, 0, 1, 0))
							:add(0, 1, 0)
						for i = 0, 35 do
							particles:newParticle("minecraft:firework", anchorPos)
								:setScale(0.5)
								:setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + 90, vectors.rotateAroundAxis(i * 10, 0, 0.1 + math.random() * 0.15, 0, 0, 0, 1), 0, 1, 0))
								:setColor(0.991, 0.783, 0.999)
								:setGravity(0)
								:setLifetime(57 + math.random(0, 5))
						end

						sounds:playSound("minecraft:entity.experience_orb.pickup", anchorPos, 1, 2)
					end

					if tick >= 42 and tick < 55 then
						local anchorPos = player:getPos()
						local bodyYaw = player:getBodyYaw()
						for i = 0, 1 do
							for j = 0, 1 do
								local tickCount = tick - 42
								particles:newParticle("minecraft:end_rod", vectors.rotateAroundAxis(bodyYaw * -1 + 50 - ((tickCount * 2 + j) * 10) , 0, 1.2 + (i == 0 and (tickCount * 0.04) or (tickCount * 0.15)), 0.8, 0, 1, 0):add(anchorPos)):setScale(0.5):setColor(0.991, 0.783, 0.999):setLifetime(8)
							end
						end
					end

					if tick % 4 == 0 then
						local bodyYaw = player:getBodyYaw()
						Character23b_ExSkillShootingStarManager:spawn(vectors.rotateAroundAxis(bodyYaw * -1 - 90, vectors.rotateAroundAxis(-45, math.random() * 1024 - 512, 256, 256, 1, 0, 0), 0, 1, 0):add(player:getPos()), vectors.rotateAroundAxis(bodyYaw * -1 - 90, vectors.rotateAroundAxis(-45, -0.5, -1, 0, 1, 0, 0), 0, 1, 0))
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
					end

					if not forcedStop then
						self.costume.showerShootingStars(self, -90)
					end
				end;
			};
		};

		secondary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 150, 0);
					pos = vectors.vec3(10.4, 22.5, -36);
				};

				fin = {
					rot = vectors.vec3(-40, -20, 0);
					pos = vectors.vec3(11.4, 26.5, -17);
				};
			};

			callbacks = {
				onPreAnimation = function ()
					events.TICK:remove("shooting_star_tick")

					if host:isHost() then
						models.models.ex_skill_1.Gui.ScreenFilter:setScale(client:getScaledWindowSize():copy():augmented(1))
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.ScreenFilter:setOpacity(models.models.ex_skill_1.Gui.FilterOpacity:getAnimScale().x)
						end, "ex_skill_2_render")
					end

					FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 50, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 50 then
						FaceParts:setEmotion("NARROW", "NARROW", "SMILE", 33, true)

						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
							:copy()
							:add(vectors.rotateAroundAxis(bodyYaw * -1 + 30, 0, 0, -1, 0, 1, 0))
							:add(0, 1, 0)
						for i = 0, 35 do
							particles:newParticle("minecraft:firework", anchorPos)
								:setScale(0.5)
								:setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + 30, vectors.rotateAroundAxis(i * 10, 0, 0.1 + math.random() * 0.15, 0, 0, 0, 1), 0, 1, 0))
								:setColor(0.991, 0.783, 0.999)
								:setGravity(0)
								:setLifetime(40 + math.random(-3, 3))
						end

						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 3)
					elseif tick == 83 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 9, true)
					elseif tick == 92 then
						FaceParts:setEmotion("NARROW_CENTER", "NARROW", "OPENED_SMALL", 11, true)
					elseif tick == 103 then
						FaceParts:setEmotion("NARROW_CENTER", "NARROW", "SMILE", 4, true)
					elseif tick == 107 then
						FaceParts:setEmotion("NARROW_CENTER", "NARROW", "OPENED", 79, true)
					end

					if tick % 4 == 0 then
						local bodyYaw = player:getBodyYaw()
						Character23b_ExSkillShootingStarManager:spawn(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(-45, math.random() * 1024 - 512, 256, 256, 1, 0, 0), 0, 1, 0):add(player:getPos()), vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(-45, -0.5, -1, 0, 1, 0, 0), 0, 1, 0))
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_2_render")
					end

					if not forcedStop then
						self.costume.showerShootingStars(self, 0)
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
					ModelAlias.alias.avatar.body.Chest:setVisible(not isVisible)
					ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, isVisible and -1 or 0)
				end
			end;
		};

		---ヘイローのキラキラエフェクトのクラスを格納する配列
		---@type Character23b.HaloShine[]
		haloShines = {};

		---流れ星の基準ワールド座標
		---@type Vector3
		shootingStarBasePos = vectors.vec3();

		---流れ星の発生させる基準の向き
		---@type number
		shootingStarBaseDir = 0;

		---流れ星の残り時間
		---@type integer
		shootingStarLifetimeCount = 0;

		---流れ星を30秒間降らせる。
		---@param self Character23b
		---@param yaw number 流れ星を降らせる方向（ヨー）
		showerShootingStars = function (self, yaw)
			self.costume.shootingStarBasePos = player:getPos()
			self.costume.shootingStarBaseDir = player:getBodyYaw() % 360
			self.costume.shootingStarLifetimeCount = 600

			events.TICK:register(function ()
				if not client:isPaused() then
					if self.costume.shootingStarLifetimeCount % 4 == 0 then
						Character23b_ExSkillShootingStarManager:spawn(vectors.rotateAroundAxis(self.costume.shootingStarBaseDir * -1 + yaw, vectors.rotateAroundAxis(-45, math.random() * 1024 - 512, 256, 256, 1, 0, 0), 0, 1, 0):add(player:getPos()), vectors.rotateAroundAxis(self.costume.shootingStarBaseDir * -1 + yaw, vectors.rotateAroundAxis(-45, -0.5, -1, 0, 1, 0, 0), 0, 1, 0))
					end

					if self.costume.shootingStarLifetimeCount == 0 then
						events.TICK:remove("shooting_star_tick")
					end
					self.costume.shootingStarLifetimeCount = self.costume.shootingStarLifetimeCount - 1
				end
			end, "shooting_star_tick")
		end;
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("NARROW", "NARROW", "OPENED3", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED2", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED_SMALL", duration, true)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("FRUST", "FRUST", "FRUST", duration, true)
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
		callbacks = {
			onBeforeModelCopy = function ()
				ModelAlias.alias.avatar.body.Hairs.BackHair:setRot()
			end;

			onAfterModelCopy = function (self)
				if models.script_head_block and not self.headBlock.isHeadBlockInitialized then

					Character23b_HaloShine = require("scripts.halo_shine")

					for i = 1, 4 do
						models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable["HaloShine" .. i]["HaloShine" .. i .. "Inner"]:setParentType("Camera")
					end
					table.insert(self.headBlock.headBlockHaloShines, Character23b_HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine1, vectors.vec2(2, 0)))
					table.insert(self.headBlock.headBlockHaloShines, Character23b_HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine2, vectors.vec2(1, 0)))
					table.insert(self.headBlock.headBlockHaloShines, Character23b_HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine3, vectors.vec2(2, 0)))
					table.insert(self.headBlock.headBlockHaloShines, Character23b_HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine4, vectors.vec2(3, 0)))

					for _, shine in ipairs(self.headBlock.headBlockHaloShines) do
						shine.callbacks.onInit(shine)
					end

					events.WORLD_TICK:register(function ()
						if not client:isPaused() then
							self.headBlock.headBlockHaloRot = self.headBlock.headBlockHaloRot + 0.15

							for _, shine in ipairs(self.headBlock.headBlockHaloShines) do
								shine.callbacks.onTick(shine)
							end
						end
					end)

					events.WORLD_RENDER:register(function (delta)
						if not client:isPaused() then
							models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable:setRot(0, self.headBlock.headBlockHaloRot + 0.15 * delta, 0)

							for _, shine in ipairs(self.headBlock.headBlockHaloShines) do
								shine.callbacks.onRender(shine, delta)
							end
						end
					end)

					self.headBlock.isHeadBlockInitialized = true
				end
			end;
		};
	};

	headBlock = {
		includeModels = {ModelAlias.alias.avatar.body.Hairs};

		---頭ブロックが初期化されたかどうか
		---@type boolean
		isHeadBlockInitialized = false;

		---頭ブロックのヘイローのキラキラエフェクトのクラスを格納する配列
		---@type Character23b.HaloShine[]
		headBlockHaloShines = {};

		---頭ブロックのヘイローの回転角度
		---@type number
		headBlockHaloRot = 0;
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(5, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Wings.RightWing:setRot(0, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Wings.LeftWing:setRot(0, 0, 10)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-15, 0, -15)
				ModelAlias.alias.dummy_avatar.body.Wings.RightWing:setRot(0, 0, -50)
				ModelAlias.alias.dummy_avatar.body.Wings.LeftWing:setRot(0, 0, 35)
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
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
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
						min = 5;
						neutral = 5;
						max = 150;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 5;
							max = 90;
						};

						bodyY = {
							multiplayer = -80;
							min = 5;
							max = 150;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 5;
							max = 90;
						};
					};

					horizontal = {
						min = 5;
						neutral = 90;
						max = 150;

						bodyX = {
							multiplayer = -80;
							min = 5;
							max = 150;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Wings.RightWing.RightWing2},

				z = {
					vertical = {
						min = -70;
						neutral = -65;
						max = -55;

						bodyY = {
							multiplayer = -20;
							min = -70;
							max = -55;
						};
					};

					horizontal = {
						min = -65;
						neutral = -65;
						max = -65;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Wings.LeftWing.LeftWing2},

				z = {
					vertical = {
						min = 55;
						neutral = 65;
						max = 70;

						bodyY = {
							multiplayer = 20;
							min = 55;
							max = 70;
						};
					};

					horizontal = {
						min = 65;
						neutral = 65;
						max = 65;
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	---@param self Character23b
	init = function (self)
		---ヘイローのキラキラエフェクトオブジェクトのクラス
		---@type Character23b.HaloShine
		Character23b_HaloShine = require("scripts.halo_shine")

		---水濡れを制御するクラス
		---@type Character23b.Wet
		Character23b_Wet = require("scripts.wet")
		Character23b_Wet:init()

		---Exスキルで使用する流れ星パーティクルのインスタンスクラス
		---@type Character23b.ExSkillShootingStar
		Character23b_ExSkillShootingStar = require("scripts.ex_skill_shooting_star")

		---Exスキルで使用する流れ星パーティクルのマネージャークラス
		---@type Character23b.ExSkillShootingStarManager
		Character23b_ExSkillShootingStarManager = require("scripts.ex_skill_shooting_star_manager")
		Character23b_ExSkillShootingStarManager = Character23b_ExSkillShootingStarManager.new()

		table.insert(self.costume.haloShines, Character23b_HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine1, vectors.vec2(2, 0)))
		table.insert(self.costume.haloShines, Character23b_HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine2, vectors.vec2(1, 0)))
		table.insert(self.costume.haloShines, Character23b_HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine3, vectors.vec2(2, 0)))
		table.insert(self.costume.haloShines, Character23b_HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine4, vectors.vec2(3, 0)))

		for _, shine in ipairs(self.costume.haloShines) do
			shine.callbacks.onInit(shine)
		end

		events.TICK:register(function ()
			if not client:isPaused() then
				for _, shine in ipairs(self.costume.haloShines) do
					shine.callbacks.onTick(shine)
				end
			end
		end)

		events.RENDER:register(function (delta, context)
			if not client:isPaused() then
				for _, shine in ipairs(self.costume.haloShines) do
					shine.callbacks.onRender(shine, delta, context)
				end

				local wingRotOffset = math.map(vanilla_model.RIGHT_LEG:getOriginRot().x, -90, 90, 20, 0)
				ModelAlias.alias.avatar.body.Wings.RightWing:setRot(0, wingRotOffset * -1, 0)
				ModelAlias.alias.avatar.body.Wings.LeftWing:setRot(0, wingRotOffset, 0)
			end
		end)
	end;
}

return BlueArchiveCharacter
