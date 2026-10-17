---右目のテクスチャの列挙型
---@alias Character23a.RightEyeTextures
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
---@alias Character23a.LeftEyeTextures
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
---@alias Character23a.MouthTextures
---| "NORMAL" # 通常
---| "OPENED_SMALL" # 小さく開いた口
---| "SMILE" # にっこり
---| "TEETH" # 歯を見せてにっこり
---| "OPENED" # 開いた口
---| "OPENED2" # 開いた口2
---| "OPENED3" # 開いた口3
---| "FRUST" # への口

---@class (exact) Character23a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character23a.RightEyeTextures 右目の表情名
---@field public leftEye Character23a.LeftEyeTextures 左目の表情名
---@field public mouth Character23a.MouthTextures 口の表情名

---@class (exact) Character23a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character23a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character23a.EmotionSet ベッドで寝ているとき

---@class (exact) Character23a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character23a, right: Character23a.RightEyeTextures, left: Character23a.LeftEyeTextures, mouth: Character23a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character23a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character23a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character23a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character23a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character23a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character23a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character23a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character23a.FacePartsStruct 目や口による表情

---@type Character23a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "23a_Mika";

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
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
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

			models = {};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(0, 18, -10);
				};

				fin = {
					rot = vectors.vec3(0, 20, 5);
					pos = vectors.vec3(19, 21, 25);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						local DISTANCE = 160
						local entityTaskCount = 1

						---モンスターの向きをミカの方向を向くように設定する。
						---@param entity EntityTask 向き変更を行うエンティティレンダータスク
						local function setMonsterYaw(entity)
							local pos = entity:getPos()
							entity:setRot(0, math.deg(math.atan2(pos.x, pos.z * -1 + DISTANCE)) * -1, 0)
						end

						---エンティティタスクのIDの連番を返す。
						---@return integer entityTaskCount エンティティタスクのIDの連番。エンティティタスクの名前に使用します。
						local function getEntityTaskCount()
							local result = entityTaskCount
							entityTaskCount = entityTaskCount + 1
							return result
						end

						---@diagnostic disable-next-line: discard-returns
						local monsterParent = models.models.ex_skill_1:newPart("ExSkill1Monsters")
						monsterParent:setPos(0, 0, DISTANCE * -1)
						setMonsterYaw(models.models.ex_skill_1.ExSkill1Monsters:newEntity("ex_skill_1_entity_" .. getEntityTaskCount()):setNbt("minecraft:warden", "{}"))
						for i = 0, 1 do
							setMonsterYaw(models.models.ex_skill_1.ExSkill1Monsters:newEntity("ex_skill_1_entity_" .. getEntityTaskCount()):setNbt("minecraft:creaking", "{}"):setPos(36 - i * 72, 0, 0))
							setMonsterYaw(models.models.ex_skill_1.ExSkill1Monsters:newEntity("ex_skill_1_entity_" .. getEntityTaskCount()):setNbt("minecraft:enderman", "{}"):setPos(24 - i * 48, 0, -16))
							setMonsterYaw(models.models.ex_skill_1.ExSkill1Monsters:newEntity("ex_skill_1_entity_" .. getEntityTaskCount()):setNbt("minecraft:ravager", "{}"):setPos(80 - i * 160, 0, -24))
						end
						local monsterTable = {"minecraft:zombie", "minecraft:skeleton", "minecraft:creeper"}
						for i = 0, 1 do
							for j = 0, 8 do
								local randomIndex = math.random(#monsterTable)
								local monsterPos = vectors.vec3(96 - j * 24 + (i == 1 and -12 or 0), 0, 16 * (i + 1))
								if monsterTable[randomIndex] == "minecraft:skeleton" then
									setMonsterYaw(models.models.ex_skill_1.ExSkill1Monsters:newEntity("ex_skill_1_entity_" .. getEntityTaskCount()):setNbt("minecraft:skeleton", "{HandItems:[{id:\"minecraft:bow\",count:1},{}]}"):setPos(monsterPos))
								else
									setMonsterYaw(models.models.ex_skill_1.ExSkill1Monsters:newEntity("ex_skill_1_entity_" .. getEntityTaskCount()):setNbt(monsterTable[randomIndex], "{}"):setPos(monsterPos))
								end
								if i == 1 and j == 7 then
									break
								end
							end
						end
						for i = 0, 4 do
							setMonsterYaw(models.models.ex_skill_1.ExSkill1Monsters:newEntity("ex_skill_1_entity_" .. getEntityTaskCount()):setNbt("minecraft:spider", "{}"):setPos(72 - i * 36, 0, 56))
						end
					end

					models.models.ex_skill_1.ExSkill1Monsters:setVisible(true)

					FaceParts:setEmotion("CLOSED2", "CLOSED2", "OPENED_SMALL", 35, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setVisible(true)
					elseif tick == 35 then
						FaceParts:setEmotion("NARROW2", "NARROW2", "OPENED_SMALL", 6, true)
						local playerPos = player:getPos()
						local bodyYaw = player:getBodyYaw()
						local anchorPos = playerPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 1, -0.5, 0, 1, 0))

						for j = 0, 4 do
							local offsetValue = 1 / 4 * j
							local color = vectors.vec3(1, 1, 1):sub(vectors.vec3(1, 1, 1):sub(0.997, 0.923, 0.998):scale(offsetValue))
							for i = 0, 35 do
								particles:newParticle("minecraft:end_rod", anchorPos):setScale(1.5):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 10 + (j % 2 + 5), 0, 0.08 + offsetValue * 0.12, 0, 0, 0, 1), 0, 1, 0)):setColor(color):setLifetime(32 + math.random(0, 4))
							end
						end

						sounds:playSound("minecraft:entity.wind_charge.wind_burst", playerPos, 0.75, 0.5)
					elseif tick == 37 and host:isHost() then
						local windowSize = client:getWindowSize()
						models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(40))
						models.models.ex_skill_1.CameraBackground.Background:setColor(vectors.vec3(1, 1, 1):scale(client:hasShaderPack() and 0.6 or 1))
						events.RENDER:register(function (delta, context)
							models.models.ex_skill_1.CameraBackground:setVisible(context ~= "OTHER")
							local opacity = models.models.ex_skill_1.CameraBackground.BackgroundOpacity:getAnimScale().x
							models.models.ex_skill_1.CameraBackground:setOpacity(opacity)
							local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.7)), 0, 1, 0):scale(16 / 0.9375)
							models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
							models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
						end, "ex_skill_1_render")
					elseif tick == 41 then
						FaceParts:setEmotion("NARROW", "NARROW", "SMILE", 84, true)
					elseif tick == 63 and host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						models.models.ex_skill_1.CameraBackground:setVisible(false)
					elseif tick == 88 then
						sounds:playSound("minecraft:item.trident.thunder", player:getPos(), 1, 0.8)
					end
				end;

				onPostAnimation = function (_, forcedStop)
					if Gun.currentGunPosition == "NONE" then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
						ModelAlias.alias.avatar.gun:setVisible(false)
					end
					if not forcedStop then
						Character23a_MeteorManager:spawn(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 0, 10, 0, 1, 0):add(player:getPos()))
					elseif host:isHost() and forcedStop then
						events.RENDER:remove("ex_skill_1_render")
						models.models.ex_skill_1.CameraBackground:setVisible(false)
					end
					models.models.ex_skill_1.ExSkill1Monsters:setVisible(false)
				end;
			};

			---このExスキルの初期化処理がされたかどうか
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Chest:setVisible(not isVisible)
					ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, isVisible and -1 or 0)
					self.physics.physicData[2].x.vertical.min = isVisible and 0 or 5
					self.physics.physicData[2].x.vertical.neutral = isVisible and 0 or 5
					self.physics.physicData[2].x.vertical.bodyX.min = isVisible and 0 or 5
					self.physics.physicData[2].x.vertical.bodyY.min = isVisible and 0 or 5
					self.physics.physicData[2].x.vertical.bodyRot.min = isVisible and 0 or 5
					self.physics.physicData[2].x.vertical.bodyX.min = isVisible and 0 or 5
					self.physics.physicData[2].x.horizontal.min = isVisible and 0 or 5
					self.physics.physicData[2].x.horizontal.bodyX.min = isVisible and 0 or 5
				end
				if parts == "CHEST_PLATE" or parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not (Armor.isArmorVisible.chestplate or Armor.isArmorVisible.leggings))
				end
			end;
		};

		---ヘイローのキラキラエフェクトのクラスを格納する配列
		---@type Character23a.HaloShine[]
		haloShines = {};

		---現ティックで脚とスカートの調整をするかどうか
		---@type boolean
		shouldAdjustLegs = false;

		---前ティックに脚とスカートの調整をしたかどうか
		---@type boolean
		shouldAdjustLegsPrev = false;

		---前ティックは脚を隠すべきだったかどうか
		---@type boolean
		shouldHideLegsPrev = false;
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

					Character23a_HaloShine = require("scripts.halo_shine")

					for i = 1, 4 do
						models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable["HaloShine" .. i]["HaloShine" .. i .. "Inner"]:setParentType("Camera")
					end
					table.insert(self.headBlock.headBlockHaloShines, Character23a_HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine1, vectors.vec2(2, 0)))
					table.insert(self.headBlock.headBlockHaloShines, Character23a_HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine2, vectors.vec2(1, 0)))
					table.insert(self.headBlock.headBlockHaloShines, Character23a_HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine3, vectors.vec2(2, 0)))
					table.insert(self.headBlock.headBlockHaloShines, Character23a_HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine4, vectors.vec2(3, 0)))

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
		---@type Character23a.HaloShine[]
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
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(60, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-15, 0, -15)
				ModelAlias.alias.dummy_avatar.body.Wings.RightWing:setRot(0, 0, -50)
				ModelAlias.alias.dummy_avatar.body.Wings.LeftWing:setRot(0, 0, 35)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(20, 0, 0)
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
						neutral = -7.5;
						max = -7.5;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = -7.5;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = -7.5;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -7.5;
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
				models = {ModelAlias.alias.avatar.head.Bun.BunRibbon};

				z = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 125;

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 125;
						};

						headZ = {
							multiplayer = -80;
							min = 0;
							max = 65;
						};

						headRot = {
							multiplayer = -0.05;
							min = 0;
							max = 65;
						};
					};

					horizontal = {
						min = 0;
						neutral = 0;
						max = 0;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Wings.RightWing},

				z = {
					vertical = {
						min = -5;
						neutral = 0;
						max = 10;

						bodyY = {
							multiplayer = -20;
							min = -5;
							max = 10;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Wings.LeftWing},

				z = {
					vertical = {
						min = -5;
						neutral = 0;
						max = 10;

						bodyY = {
							multiplayer = 20;
							min = -5;
							max = 10;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	---@param self Character23a
	init = function (self)
		---ヘイローのキラキラエフェクトオブジェクトのクラス
		---@type Character23a.HaloShine
		Character23a_HaloShine = require("scripts.halo_shine")

		---隕石のインスタンスクラス
		---@type Character23a.Meteor
		Character23a_Meteor = require("scripts.meteor")

		---隕石のマネージャークラス
		---@type Character23a.MeteorManager
		Character23a_MeteorManager = require("scripts.meteor_manager")
		Character23a_MeteorManager = Character23a_MeteorManager.new()
		Character23a_MeteorManager.init()

		table.insert(self.costume.haloShines, Character23a_HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine1, vectors.vec2(2, 0)))
		table.insert(self.costume.haloShines, Character23a_HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine2, vectors.vec2(1, 0)))
		table.insert(self.costume.haloShines, Character23a_HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine3, vectors.vec2(2, 0)))
		table.insert(self.costume.haloShines, Character23a_HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine4, vectors.vec2(3, 0)))

		for _, shine in ipairs(self.costume.haloShines) do
			shine.callbacks.onInit(shine)
		end

		events.TICK:register(function ()
			if not client:isPaused() then
				for _, shine in ipairs(self.costume.haloShines) do
					shine.callbacks.onTick(shine)
				end

				local shouldHideLegs = player:getVehicle() ~= nil
				if shouldHideLegs and not self.costume.shouldHideLegsPrev then
					ModelAlias.alias.avatar.legs:setVisible(false)
					ModelAlias.alias.avatar.body.Skirt:setScale(1.5, 0.6, 1.5)
				elseif not shouldHideLegs and self.costume.shouldHideLegsPrev then
					ModelAlias.alias.avatar.legs:setVisible(true)
					ModelAlias.alias.avatar.body.Skirt:setScale()
				end

				self.costume.shouldAdjustLegs = not shouldHideLegs
				if not self.costume.shouldAdjustLegs and self.costume.shouldAdjustLegsPrev then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.rightLeg, ModelAlias.alias.avatar.leftLeg}) do
						modelPart:setRot()
					end
				end

				self.costume.shouldHideLegsPrev = shouldHideLegs
				self.costume.shouldAdjustLegsPrev = self.costume.shouldAdjustLegs
			end
		end)

		events.RENDER:register(function (delta, context)
			if not client:isPaused() then
				for _, shine in ipairs(self.costume.haloShines) do
					shine.callbacks.onRender(shine, delta, context)
				end

				local wingRotOffset = math.map(vanilla_model.RIGHT_LEG:getOriginRot().x, -90, 90, 20, 0)
				ModelAlias.alias.avatar.body.Wings.RightWing.RightWingYPivot:setRot(0, wingRotOffset * -1, 0)
				ModelAlias.alias.avatar.body.Wings.LeftWing.LeftWingYPivot:setRot(0, wingRotOffset, 0)

				if self.costume.shouldAdjustLegs then
					local rightLegRotX = vanilla_model.RIGHT_LEG:getOriginRot().x
					ModelAlias.alias.avatar.rightLeg:setRot(rightLegRotX * -0.45, 0, 0)
					ModelAlias.alias.avatar.leftLeg:setRot(vanilla_model.LEFT_LEG:getOriginRot().x * -0.45, 0, 0)
				end

				local playerPose = player:getPose()
				local skirtFlipVal = math.min(math.abs(Physics.getValueBetweenTicks(Physics.velocityAverage[7], delta)) * 0.00025 + ((playerPose == "SWIMMING" or playerPose == "FALL_FLYING") and 0 or math.max(Physics.getValueBetweenTicks(Physics.velocityAverage[2], delta) * -0.25, 0)), 0.5)
				ModelAlias.alias.avatar.body.Skirt.Skirt1_1:setScale(1 + skirtFlipVal / 4, 1 - skirtFlipVal / 4, 1 + skirtFlipVal / 4)
				ModelAlias.alias.avatar.body.Skirt.Skirt2_1:setScale(1 + skirtFlipVal / 2, 1 - skirtFlipVal / 2, 1 + skirtFlipVal / 2)


				local blockLightLevel = 15
				local skyLightLevel = 15
				if context ~= "FIGURA_GUI" and context ~= "MINECRAFT_GUI" and context ~= "PAPERDOLL" then
					local playerPos = player:getPos()
					blockLightLevel = world.getBlockLightLevel(playerPos)
					skyLightLevel = world.getSkyLightLevel(playerPos)
				end

				for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt.Skirt2_1.Skirt5StarLayer, ModelAlias.alias.avatar.body.Skirt.Skirt2_1.Skirt2_2.Skirt6StarLayer, ModelAlias.alias.avatar.body.Skirt.Skirt2_1.Skirt2_2.Skirt2_3.Skirt7StarLayer, ModelAlias.alias.avatar.body.Skirt.Skirt2_1.Skirt2_2.Skirt2_3.Skirt2_4.Skirt8StarLayer}) do
					modelPart:setLight(math.min(blockLightLevel + 5, 15), math.min(skyLightLevel + 5, 15))
				end
			end
		end)
	end;
}

return BlueArchiveCharacter
