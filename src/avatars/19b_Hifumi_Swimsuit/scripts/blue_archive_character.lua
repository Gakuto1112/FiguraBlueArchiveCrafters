---右目のテクスチャの列挙型
---@alias Character19b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "INVERTED" # 反対側を見る目
---| "WORRY" # 困った目
---| "WORRY_CENTER" # 困りつつ少し反対側を見る目
---| "UNEQUAL" # 不等号目
---| "SURPRISED_INVERTED" # 驚きつつ反対側を見る目
---| "NORMAL_CENTER" # 少し反対側を見る目

---左目のテクスチャの列挙型
---@alias Character19b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "WORRY" # 困った目
---| "WORRY_CENTER" # 困りつつ少し反対側を見る目
---| "UNEQUAL" # 不等号目
---| "WORRY_INVERTED" # 困りつつ反対側を見る目

---口のテクスチャの列挙型
---@alias Character19b.MouthTextures
---| "NORMAL" # 通常
---| "ANXIOUS" # への口
---| "O" # オーの形の口
---| "SURPRISED" # あんぐり口
---| "SMILE" # にっこり口
---| "OPENED" # 開いた口
---| "OPENED_SMALL" # 小さく開いた口
---| "ANXIOUS_SMALL" # 小さいへの口
---| "CLOSED" # 閉じた口

---@class (exact) Character19b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character19b.RightEyeTextures 右目の表情名
---@field public leftEye Character19b.LeftEyeTextures 左目の表情名
---@field public mouth Character19b.MouthTextures 口の表情名

---@class (exact) Character19b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character19b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character19b.EmotionSet ベッドで寝ているとき

---@class (exact) Character19b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character19b, right: Character19b.RightEyeTextures, left: Character19b.LeftEyeTextures, mouth: Character19b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character19b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character19b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character19b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character19b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character19b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character19b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character19b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character19b.FacePartsStruct 目や口による表情

---@type Character19b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "19b_Hifumi_Swimsuit";

		birth = {
			month = 11;
			day = 27;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			INVERTED = vectors.vec2(5, 0);
			WORRY = vectors.vec2(6, 0);
			WORRY_CENTER = vectors.vec2(8, 0);
			UNEQUAL = vectors.vec2(10, 0);
			SURPRISED_INVERTED = vectors.vec2(12, 0);
			NORMAL_CENTER = vectors.vec2(13, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			WORRY = vectors.vec2(6, 0);
			WORRY_CENTER = vectors.vec2(8, 0);
			UNEQUAL = vectors.vec2(9, 0);
			WORRY_INVERTED = vectors.vec2(10, 0);
		};

		mouth = {
			ANXIOUS = vectors.vec2(0, 0);
			O = vectors.vec2(1, 0);
			SURPRISED = vectors.vec2(2, 0);
			SMILE = vectors.vec2(3, 0);
			OPENED = vectors.vec2(4, 0);
			OPENED_SMALL = vectors.vec2(5, 0);
			ANXIOUS_SMALL = vectors.vec2(6, 0);
			CLOSED = vectors.vec2(7, 0);
		};
	};

	arms = {
		onArmStateChanged = function (self)
			if self.costume.isRidingTank and self.costume.tankTick < 40 then
				return {right = "DEFAULT", left = "DEFAULT"}
			end
		end;
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0.5, 1, -5);
					left = vectors.vec3(0.5, 1, -5);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.75, 0, -6);
					left = vectors.vec3(1.75, 0, -6);
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

			models = {models.models.ex_skill_1.Tank, ModelAlias.alias.avatar.body.SwimRing, ModelAlias.alias.avatar.head.NoticeEffect};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(20, 80, -15);
					pos = vectors.vec3(55, 27.8, 19);
				};

				fin = {
					rot = vectors.vec3(0, 25, 0);
					pos = vectors.vec3(56.9, 56, -1075.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 20, true)
				end;

				onAnimationTick = function (self, tick)
					if tick <= 15 and tick % 2 == 0 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Tank.TankBody.ExSkill2ParticleAnchor1)
						local bodyYaw = player:getBodyYaw()
						local colorTable = {vectors.vec3(0.96, 0.92, 0.98), vectors.vec3(0.75, 1, 1), vectors.vec3(0.93, 1, 0.64)}
						for _ = 1, 2 do
							particles:newParticle("minecraft:end_rod", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, 0.05, math.random() * 0.8 - 0.4, math.random() * 1.8 - 0.9, 0, 1, 0))):setScale(math.random() * 0.25 + 0.25):setColor(colorTable[math.random(#colorTable)]):setLifetime(4)
						end
					elseif tick == 20 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 4, true)
					elseif tick == 25 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, 0.1, 0, 1, 0))
						for i = 0, 11 do
							particles:newParticle("minecraft:end_rod", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 30, 0, 0, math.random() * 0.05 + 0.1, 1, 0, 0), 0, 1, 0)):setColor(1, 1, 0.22):setLifetime(12)
						end
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 3)
					elseif tick == 24 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 11, true)
					elseif tick == 35 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 1, true)
					elseif tick == 36 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED_SMALL", 8, true)
					elseif tick == 42 then
						self.exSkill.engineSound = sounds:playSound("minecraft:entity.minecart.riding", player:getPos(), 0.25, 0.5)
					elseif tick == 44 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED_SMALL", 2, true)
					elseif tick == 45 or tick == 48 then
						sounds:playSound("minecraft:entity.experience_orb.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.5, 1.5)
					elseif tick == 46 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS_SMALL", 6, true)
					elseif tick == 52 then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SURPRISED", 9, true)
						sounds:playSound("minecraft:entity.firework_rocket.launch", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 2)
					elseif tick == 61 then
						FaceParts:setEmotion("WORRY", "WORRY_INVERTED", "SURPRISED", 14, true)
					elseif tick == 75 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SURPRISED", 29, true)
					end

					if tick >= 56 and (tick - 56) % 3 == 0 then
						---@type Minecraft.itemID
						local itemTable = {"melon", "potion", "melon_slice", "apple", "milk_bucket", "tube_coral_block", "brain_coral_block", "bubble_coral_block", "fire_coral_block", "horn_coral_block", "tube_coral", "brain_coral", "fire_coral", "horn_coral", "bubble_coral", "tube_coral_fan", "brain_coral_fan", "bubble_coral_fan", "fire_coral_fan", "horn_coral_fan", "cod", "cod_bucket", "salmon", "salmon_bucket", "tropical_fish", "tropical_fish_bucket", "seagrass", "sea_pickle", "kelp", "ink_sac", "turtle_scute", "sand", "heart_of_the_sea"}
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Tank.TankBody.CoolerBox.ExSkill2LauncherAnchor)
						ItemLauncher:launch(CompatibilityUtils:checkItem("minecraft:" .. itemTable[math.random(#itemTable)]), anchorPos, math.random() * 360, 0.75, vectors.rotateAroundAxis(player:getBodyYaw() * -1, math.random() * 4 - 2, math.random() * 2 + 1, math.random() * 10 + 5, 0, 1, 0), 30)
						sounds:playSound("minecraft:entity.item.pickup", anchorPos, 1, math.random() * 0.4 + 0.8)
					end

					if tick >= 42 then
						self.exSkill.engineSound:setPos(ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root))
					end
					if tick >= 52 then
						if tick % 2 == 0 then
							sounds:playSound("minecraft:block.piston.extend", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Tank), 0.5, 0.2 + (tick - 52) / 520)
							sounds:playSound("minecraft:block.piston.contract", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Tank), 0.5, 0.2 + (tick - 52) / 520)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Tank.RightCrawler.RightCrawlerBelt, models.models.ex_skill_1.Tank.LeftCrawler.LeftCrawlerBelt}) do
							modelPart:setUVPixels(0, (tick % 2))
						end
						local bodyYaw = player:getBodyYaw()
						for _, anchor in ipairs({models.models.ex_skill_1.Tank.LeftCrawler.ExSkill2ParticleAnchor2, models.models.ex_skill_1.Tank.RightCrawler.ExSkill2ParticleAnchor3}) do
							local anchorPos = ModelUtils.getModelWorldPos(anchor)
							local particleBlock = world.getBlockState(anchorPos:copy():add(0, -1, 0)).id
							if particleBlock ~= "minecraft:air" and particleBlock ~= "minecraft:cave_air" and particleBlock ~= "minecraft:void_air" then
								for _ = 1, 10 do
									particles:newParticle("minecraft:block " .. particleBlock, anchorPos):setScale(1.5):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 2 - 1, math.random() * 0.6, math.random() * 0.5 + 0.5, 0, 1, 0))
								end
							end
						end
					end
				end;

				onPostAnimation = function (self)
					if self.exSkill.engineSound ~= nil then
						self.exSkill.engineSound:stop()
						self.exSkill.engineSound = nil
					end
				end;
			};

			---戦車のエンジン音のインスタンス
			---@type Sound|nil
			engineSound = nil;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		---この衣装が初期化されているかどうか。
		---@type boolean
		isInitialized = false;

		---戦車に乗っているかどうか
		---@type boolean
		isRidingTank = false;

		---前ティックに戦車に乗っていたかどうか
		---@type boolean
		isRidingTankPrev = false;

		---前ティックに戦車のエンジンが起動していたかどうか
		---@type boolean
		isEngineActivePrev = false;

		---戦車に乗っているときのティックカウンター
		---@type integer
		tankTick = 0;

		---ラクダが座っているかどうか
		---@type boolean
		isCamelSitting = true;

		---ラクダのY軸の向き
		---@type number
		camelRot = 0;

		---前ティックの体の向き
		---@type number
		bodyYawPrev = 0;

		---戦車の車体の向きを更新すべきかどうか
		---@type boolean
		shouldUpdateBaseRot = true;

		---砲弾を撃つ際のティックカウンター
		---@type integer
		shootTick = -1;

		---次の砲弾を撃つまでのクールダウン
		---@type integer
		shootCoolDown = 0;

		---ヒント表示をしたかどうか。
		---@type boolean
		isTipShowed = false;

		---クルセイダーちゃんから降りる。クルセイダーちゃん登場判定処理は継続される。
		---@param self Character19b
		dismountTank = function (self)
			events.TICK:remove("tank_tick")
			events.RENDER:remove("tank_render")
			events.ON_PLAY_SOUND:remove("tank_on_play_sound")
			renderer:setRenderVehicle(true)
			for _, modelPart in ipairs({models.models.ex_skill_1.Tank, ModelAlias.alias.avatar.body.SwimRing, ModelAlias.alias.avatar.head.NoticeEffect}) do
				modelPart:setVisible(false)
			end
			for _, modelPart in ipairs({models.models.ex_skill_1.Tank, models.models.ex_skill_1.Tank.TankBody.Turret, models.models.ex_skill_1.Tank.TankBody.Turret.CannonBase}) do
				modelPart:setPos()
				modelPart:setRot()
			end
			models.models.ex_skill_1.Tank:setColor(1, 1, 1)
			ModelAlias.alias.avatar.lowerBody:setVisible(true)
			ModelAlias.alias.avatar.root:setPos()
			CameraManager:setThirdPersonCameraDistance(4)
			CameraManager.setCameraPivot()
			renderer:setEyeOffset()
			for _, animationName in ipairs({"tank_start", "tank_idle_powered", "tank_shoot"}) do
				animations["models.main"][animationName]:stop()
			end
			for _, animationName in ipairs({"tank_start", "tank_idle", "tank_move", "tank_shoot"}) do
				animations["models.ex_skill_1"][animationName]:stop()
			end
			if Gun.currentGunPosition == "RIGHT" then
				Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
			elseif Gun.currentGunPosition == "LEFT" then
				Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
			end
			self.costume.tankTick = 0
			self.costume.shootTick = -1
			self.costume.isEngineActivePrev = false
		end;
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration, isShownInGui)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", duration, true)
				elseif type == "SWEAT" then
					if isShownInGui then
						FaceParts:setEmotion("WORRY", "WORRY", "ANXIOUS", duration, true)
					else
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SURPRISED", 60, true)
					end
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
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(30, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(-20, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail.RightHairTailZPivot:setRot(0, 0, 10)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(-30, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail.LeftHairTailZPivot:setRot(0, 0, -20)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = true;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail, ModelAlias.alias.avatar.head.HairTails.LeftHairTail};

				x = {
					vertical = {
						min = -180;
						neutral = -5;
						max = 0;
						headRotMultiplayer = -1;
						sneakOffset = -30;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 0;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -180;
							max = 0;
						};
					};

					horizontal = {
						min = -45;
						neutral = 45;
						max = 45;

						bodyX = {
							multiplayer = -80;
							min = -45;
							max = 45;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail.RightHairTailZPivot};

				z = {
					vertical = {
						min = -32.5;
						neutral = 5;
						max = 90;

						headX = {
							multiplayer = -20;
							min = 0;
							max = 5;
						};

						headZ = {
							multiplayer = -80;
							min = -32.5;
							max = 90;
						};
					};

					horizontal = {
						min = -32.5;
						neutral = 10;
						max = 90;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.LeftHairTail.LeftHairTailZPivot};

				z = {
					vertical = {
						min = -90;
						neutral = -5;
						max = 32.5;

						headX = {
							multiplayer = 20;
							min = -5;
							max = 0;
						};

						headZ = {
							multiplayer = -80;
							min = -90;
							max = 32.5;
						};
					};

					horizontal = {
						min = -90;
						neutral = -20;
						max = 32.5;
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function (self)
		---アイテムを発射する演出のクラス
		---@type Character19b.ItemLauncher
		ItemLauncher = require("scripts.item_launcher")

		---戦車の砲弾オブジェクトのインスタンスクラス
		---@type Character19b.TankShell
		TankShell = require("scripts.tank_shell")

		---戦車の砲弾オブジェクトのマネージャークラス
		---@type Character19b.TankShellManager
		TankShellManager = require("scripts.tank_shell_manager")
		TankShellManager = TankShellManager.new()

		ItemLauncher.init()
		TankShellManager.init()

		models.models.ex_skill_1.Tank.TankBody.BaseLeftSide4:newText("ex_skill_1_tank_text_1"):setText("§02年3組 備品"):setPos(0, 7, 14):setRot(0, 90, 0):setScale(0.55):setAlignment("CENTER")
		models.models.ex_skill_1.Tank.TankBody.BaseLeftSide4:newText("ex_skill_1_tank_text_2"):setText("§0使用後、元の位置に！"):setPos(0, 2.25, 20):setRot(0, 90, 0):setScale(0.15):setAlignment("CENTER")
		models.models.ex_skill_1.Tank.TankBody.CoolerBox:newItem("ex_skill_1_tank_item_1"):setItem("minecraft:melon"):setPos(7, 5.6, 0):setScale(0.7)
		models.models.ex_skill_1.Tank.TankBody.CoolerBox:newItem("ex_skill_1_tank_item_2"):setItem("minecraft:potion"):setPos(-11, 5.6, -2):setRot(0, -150, 0):setScale(0.7)
		models.models.ex_skill_1.Tank.TankBody.CoolerBox:newItem("ex_skill_1_tank_item_3"):setItem("minecraft:potion"):setPos(-7, 5.6, 0):setRot(0, 180, 0):setScale(0.7)
		models.models.ex_skill_1.Tank.TankBody.CoolerBox:newItem("ex_skill_1_tank_item_4"):setItem("minecraft:potion"):setPos(-4, 5.6, -2):setRot(0, 140, 0):setScale(0.7)
		models.models.ex_skill_1.Tank.TankBody.CoolerBox:newItem("ex_skill_1_tank_item_5"):setItem("minecraft:apple"):setPos(-7, 5.6, 3):setRot(0, 180, 0):setScale(0.7)
		models.models.ex_skill_1.Tank.TankBody.Turret.TurretTank:newItem("ex_skill_1_tank_item_6"):setItem("minecraft:iron_shovel"):setPos(0, 0, 0.5):setRot(0, 0, 45)

		KeyManager:register("tank_shoot", "2-Pounder High-Explosive Loaded!", "key.keyboard.v"):setOnPress(function ()
			if self.costume.isRidingTank and self.costume.tankTick >= 36 and models.models.ex_skill_1.Tank:getColor() == vectors.vec3(1, 1, 1) then
				if self.costume.shootCoolDown == 0 then
					pings.tankShoot()
				else
					MiscUtils.playErrorSound()
					print(Locale:getLocalizedText("message.tank_shot.in_cool_down"):format(self.costume.shootCoolDown / 20))
				end
			end
		end)

		events.TICK:register(function ()
			if not client:isPaused() then
				local vehicle = player:getVehicle()
				self.costume.isRidingTank = false
				if vehicle ~= nil then
					local passengers = vehicle:getPassengers()
					local controlledPassenger = vehicle:getControllingPassenger()
					self.costume.isRidingTank = vehicle:getType() == "minecraft:camel" and controlledPassenger ~= nil and controlledPassenger:getName() == player:getName() and #passengers == 1 and ActionWheelConfig.shouldReplaceVehicleModel and player:getHealth() > 0
				end
				if self.costume.isRidingTank ~= self.costume.isRidingTankPrev then
					if self.costume.isRidingTank then
						renderer:setRenderVehicle(false)
						for _, modelPart in ipairs({models.models.ex_skill_1.Tank, ModelAlias.alias.avatar.body.SwimRing}) do
							modelPart:setVisible(true)
						end
						ModelAlias.alias.avatar.lowerBody:setVisible(false)
						models.models.ex_skill_1.Tank:setOffsetPivot(0, 0, 8)
						CameraManager:setThirdPersonCameraDistance(8)
						animations["models.main"]["tank_start"]:play()
						animations["models.ex_skill_1"]["tank_start"]:play()
						animations["models.ex_skill_1"]["tank_move"]:play()

						events.TICK:register(function ()
							local camelRot = vehicle:getRot().y
							self.costume.isCamelSitting = (player:getPos():sub(vehicle:getPos()):length() - 1.51017) * -1.35 >= 0.04
							if vehicle:isMoving(true) then
								self.costume.camelRot = camelRot
							end
							local bodyYaw = player:getBodyYaw()
							self.costume.shouldUpdateBaseRot = math.abs(bodyYaw - self.costume.bodyYawPrev) < 330
							local isEngineActive = self.costume.isRidingTank and not self.costume.isCamelSitting and models.models.ex_skill_1.Tank:getColor() == vectors.vec3(1, 1, 1)
							if isEngineActive and not self.costume.isEngineActivePrev then
								animations["models.main"]["tank_idle_powered"]:play()
								animations["models.ex_skill_1"]["tank_idle"]:play()
							elseif not isEngineActive and self.costume.isEngineActivePrev then
								animations["models.main"]["tank_idle_powered"]:stop()
								animations["models.ex_skill_1"]["tank_idle"]:stop()
							end
							animations["models.ex_skill_1"]["tank_move"]:setSpeed(Physics.velocityAverage[5][2] * 2.5)
							local beltOffset = math.floor(models.models.ex_skill_1.Tank.RightCrawler.RightCrawlerWheel1:getTrueRot().x / 20) % 2
							for _, modelPart in ipairs({models.models.ex_skill_1.Tank.RightCrawler.RightCrawlerBelt, models.models.ex_skill_1.Tank.LeftCrawler.LeftCrawlerBelt}) do
								modelPart:setUVPixels(0, beltOffset)
							end
							if FaceParts.blinkCount == 0 and FaceParts.emotionCount == 0 then
								FaceParts:setEmotion("CLOSED", "CLOSED", "ANXIOUS", 2, true)
							else
								FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", 1)
							end
							if self.costume.isRidingTank and self.costume.tankTick == 0 then
								Arms:setArmState("DEFAULT", "DEFAULT")
								FaceParts:setEmotion("WORRY", "WORRY", "ANXIOUS_SMALL", 15, true)
								ModelAlias.alias.avatar.head.NoticeEffect:setVisible(true)
							elseif self.costume.tankTick == 15 then
								FaceParts:setEmotion("CLOSED", "CLOSED", "ANXIOUS", 2, true)
							elseif self.costume.tankTick == 17 then
								FaceParts:setEmotion("SURPRISED_INVERTED", "SURPRISED", "SURPRISED", 12, true)
							elseif self.costume.tankTick == 21 then
								sounds:playSound("minecraft:entity.experience_orb.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 2)
							elseif self.costume.tankTick == 29 then
								FaceParts:setEmotion("NORMAL_CENTER", "NORMAL", "ANXIOUS", 7, true)
								ModelAlias.alias.avatar.head.NoticeEffect:setVisible(false)
							elseif self.costume.tankTick == 40 then
								if Gun.currentGunPosition == "RIGHT" then
									Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
								elseif Gun.currentGunPosition == "LEFT" then
									Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
								end
								if host:isHost() and not self.costume.isTipShowed then
									print(Locale:getLocalizedText("message.tank_shot.tip_1"):format(KeyManager.keyMappings["tank_shoot"].keybind:getKeyName()))
									self.costume.isTipShowed = true
								end
							end
							if self.costume.tankTick % 2 == 0 and isEngineActive then
								local anchorPos = vehicle:getPos()
								sounds:playSound(self.costume.tankTick % 4 == 0 and "minecraft:block.piston.extend" or "minecraft:block.piston.contract", vehicle:getPos(), 0.02, 0.5)
								local velocity = vehicle:getVelocity():mul(1, 0, 1):length()
								if velocity >= 0.1 then
									local volume = math.min(0.67 * velocity - 0.06, 0.2)
									local pitch = 0.25 * velocity + 0.175 + math.random() * 0.02 - 0.01
									sounds:playSound("minecraft:block.piston.extend", anchorPos, volume, pitch)
									sounds:playSound("minecraft:block.piston.contract", anchorPos, volume, pitch)
								end
							end
							local health = vehicle:getNbt().Health
							if health < 16 then
								local playerPos = player:getPos()
								if health < 8 then
									particles:newParticle("minecraft:flame", playerPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1 , math.random() * 5 - 2.5, math.random() * 3 - 1.5, math.random() * 7 - 3.5, 0, 1, 0)))
								end
								particles:newParticle("minecraft:large_smoke", playerPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1 , math.random() * 5 - 2.5, math.random() * 3 - 1.5, math.random() * 7 - 3.5, 0, 1, 0)))
							end

							if self.costume.shootTick >= 0 then
								self.costume.shootTick = self.costume.shootTick + 1
								if self.costume.shootTick == 19 then
									local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Tank.TankBody.Turret.CannonBase.Cannon.MuzzleAnchor)
									TankShellManager:spawn(anchorPos, vectors.vec3(models.models.ex_skill_1.Tank.TankBody.Turret.CannonBase:getRot().x * -1, player:getBodyYaw() * -1, 0))
									for _ = 1, 10 do
										particles:newParticle("minecraft:large_smoke", anchorPos:copy():add(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)):setScale(2)
									end
									sounds:playSound("minecraft:entity.firework_rocket.large_blast", player:getPos(), 1, 1)
								elseif self.costume.shootTick == 54 then
									if Gun.currentGunPosition == "RIGHT" then
										Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
									elseif Gun.currentGunPosition == "LEFT" then
										Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
									end
									self.costume.shootTick = -1
								end
							end
							self.costume.tankTick = self.costume.isRidingTank and self.costume.tankTick + 1 or 0
							self.costume.isEngineActivePrev = isEngineActive
							self.costume.bodyYawPrev = bodyYaw
						end, "tank_tick")

						events.RENDER:register(function (delta)
							if not client:isPaused() then
								local bodyYaw = player:getBodyYaw(delta)
								local baseRot = bodyYaw - self.costume.camelRot
								local lookDir = player:getLookDir()
								local turretRot = math.clamp(math.deg(math.asin(lookDir.y)), -15, 25)
								local heightOffset = (player:getPos(delta):sub(vehicle:getPos(delta)):length() - 1.51017) * -1.35
								ModelAlias.alias.avatar.root:setPos(0, 14 + heightOffset * 16, 22)
								models.models.ex_skill_1.Tank:setPos(0, -24.5 + heightOffset * 16, models.models.ex_skill_1.ShootAnimAnchor:getAnimPos().z)
								models.models.ex_skill_1.Tank.TankBody.Turret.CannonBase:setRot(turretRot, 0, 0)
								if vehicle:isMoving(true) then
									for _, modelPart in ipairs({models.models.ex_skill_1.Tank, models.models.ex_skill_1.Tank.TankBody.Turret}) do
										modelPart:setRot()
									end
								elseif self.costume.isCamelSitting then
									models.models.ex_skill_1.Tank:setRot()
									models.models.ex_skill_1.Tank.TankBody.Turret:setRot()
								elseif self.costume.shouldUpdateBaseRot then
									models.models.ex_skill_1.Tank:setRot(0, baseRot, 0)
									models.models.ex_skill_1.Tank.TankBody.Turret:setRot(0, baseRot * -1, 0)
								end

								if renderer:isFirstPerson() then
									renderer:setCameraPos(0.75, 0, 0)
									local animOffset = vectors.rotateAroundAxis(bodyYaw * -1, 0, models.models.ex_skill_1.IdleAnimAnchor:getAnimPos().y, models.models.ex_skill_1.ShootAnimAnchor:getAnimPos().z * -1, 0, 1, 0):scale(0.0625)
									CameraManager.setCameraPivot(vectors.rotateAroundAxis(bodyYaw * -1, -0.75, heightOffset + 0.81, -1.29, 0, 1, 0):add(animOffset))
									renderer:setEyeOffset(vectors.rotateAroundAxis(bodyYaw * -1, 0, heightOffset + 0.81, -1.29, 0, 1, 0):add(animOffset))
								else
									CameraManager.setCameraPivot(vectors.vec3(0, heightOffset + 0.78, 0))
									renderer:setEyeOffset(0, heightOffset + 0.78, 0)
								end
							end
						end, "tank_render")

						events.ON_PLAY_SOUND:register(function (id, pos, _, _, _, _, path)
							if pos:copy():sub(vehicle:getPos()):length() < 2 and path ~= nil then
								if id:match("^minecraft:entity.camel") ~= nil or id == "minecraft:entity.horse.land" then
									if id == "minecraft:entity.camel.step" then
										sounds:playSound("minecraft:block.wool.step", pos, 0.25, 1)
									elseif id == "minecraft:entity.horse.land" then
										sounds:playSound("minecraft:block.wool.step", pos, 1, 1)
									elseif id == "minecraft:entity.camel.dash" then
										sounds:playSound("minecraft:entity.blaze.hurt", pos, 1, 1.5)
									elseif id == "minecraft:entity.camel.dash_ready" then
										sounds:playSound("minecraft:block.dispenser.fail", pos, 1, 2)
									elseif id == "minecraft:entity.camel.hurt" then
										sounds:playSound("minecraft:block.anvil.place", pos, 1, 2)
									elseif id == "minecraft:entity.camel.death" then
										models.models.ex_skill_1.Tank:setColor(0.2, 0.2, 0.2)
										local playerPos = player:getPos()
										local bodyYaw = player:getBodyYaw()
										particles:newParticle("minecraft:explosion_emitter", playerPos)
										for _ = 0, 50 do
											local offsetPos = vectors.rotateAroundAxis(bodyYaw * -1 , math.random() * 5 - 2.5, math.random() * 3 - 1.5, math.random() * 7 - 3.5, 0, 1, 0)
											particles:newParticle("minecraft:poof", playerPos:copy():add(offsetPos)):setColor(vectors.vec3(1, 1, 1):scale(math.random() * 0.1 + 0.2)):setScale(5):setVelocity(offsetPos:copy():scale(0.05))
										end
										sounds:playSound("minecraft:entity.generic.explode", pos, 1, 1)
										Bubble:play("SWEAT", 40, false)
									end
									return true
								end
							end
						end, "tank_on_play_sound")
					else
						self.costume.dismountTank(self)
					end
					self.costume.isRidingTankPrev = self.costume.isRidingTank
				end
				self.costume.shootCoolDown = math.max(self.costume.shootCoolDown - 1, 0)
			end
		end)
	end;
}

---クルセイダーちゃんの弾を発射する。
function pings.tankShoot()
    animations["models.main"]["tank_shoot"]:play()
    animations["models.ex_skill_1"]["tank_shoot"]:play()
    Arms:setArmState("DEFAULT", "DEFAULT")
    FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "ANXIOUS", 44, true)
    BlueArchiveCharacter.costume.shootTick = 0
    BlueArchiveCharacter.costume.shootCoolDown = 100
end

return BlueArchiveCharacter
