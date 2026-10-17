---右目のテクスチャの列挙型
---@alias Character18b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "LOWER" # 下を見る目
---| "CLOSED2" # 閉じた目2
---| "SCHEME" # 何かを企んでいる目
---| "TEAR_ANGRY" # 怒りつつ涙ぐんでいる目
---| "ANGRY" # 起った目
---| "UNEQUAL" # 不等号目
---| "TEAR" # 涙ぐんでいる目

---左目のテクスチャの列挙型
---@alias Character18b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "LOWER" # 下を見る目
---| "CLOSED2" # 閉じた目2
---| "SCHEME" # 何かを企んでいる目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "ANGRY" # 起った目
---| "CENTER" # 少し反対側を見る目
---| "UNEQUAL" # 不等号目
---| "TEAR" # 涙ぐんでいる目

---口のテクスチャの列挙型
---@alias Character18b.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "FRUST_OPENED" # ぐじゅぐじゅの開き口
---| "FRUST" # ぐじゅぐじゅ口
---| "SMALL" # 小さく開いた口
---| "OVER_SMILE" # 悪意を感じるにっこり
---| "UNCOMFORT" # 不満な口
---| "SHOCK" # あんぐり口
---| "OPENED2" # 開いた口2
---| "UNCOMFORT2" # への口
---| "SMILE" # にっこり口
---| "TEAR" # 涙ぐんでいる目

---@class (exact) Character18b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character18b.RightEyeTextures 右目の表情名
---@field public leftEye Character18b.LeftEyeTextures 左目の表情名
---@field public mouth Character18b.MouthTextures 口の表情名

---@class (exact) Character18b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character18b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character18b.EmotionSet ベッドで寝ているとき

---@class (exact) Character18b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character18b, right: Character18b.RightEyeTextures, left: Character18b.LeftEyeTextures, mouth: Character18b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character18b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character18b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character18b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character18b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character18b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character18b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character18b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character18b.FacePartsStruct 目や口による表情

---@type Character18b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "18b_Michiru_Dress";

		birth = {
			month = 2;
			day = 22;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			LOWER = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(7, 0);
			SCHEME = vectors.vec2(8, 0);
			TEAR_ANGRY = vectors.vec2(9, 0);
			ANGRY = vectors.vec2(11, 0);
			UNEQUAL = vectors.vec2(14, 0);
			TEAR = vectors.vec2(15, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			LOWER = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(6, 0);
			SCHEME = vectors.vec2(7, 0);
			ANGRY_INVERTED = vectors.vec2(9, 0);
			ANGRY = vectors.vec2(11, 0);
			CENTER = vectors.vec2(12, 0);
			UNEQUAL = vectors.vec2(13, 0);
			TEAR = vectors.vec2(15, 0);
		};

		mouth = {
			OPENED = vectors.vec2(0, 0);
			FRUST_OPENED = vectors.vec2(1, 0);
			FRUST = vectors.vec2(2, 0);
			SMALL = vectors.vec2(3, 0);
			OVER_SMILE = vectors.vec2(4, 0);
			UNCOMFORT = vectors.vec2(5, 0);
			SHOCK = vectors.vec2(6, 0);
			OPENED2 = vectors.vec2(7, 0);
			UNCOMFORT2 = vectors.vec2(8, 0);
			SMILE = vectors.vec2(9, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 1.75;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(1, 2, -8);
					left = vectors.vec3(-1, 2, -8);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.5, 1.5, -6);
					left = vectors.vec3(1.5, 1.5, -6);
				};
			};

			put = {
				type = "HIDDEN";
			};
		};

		sound = {
			name = "minecraft:entity.generic.explode";
			pitch = 2;
		};
	};

	placementObjects = {

	};

	exSkill = {
		primary = {
			formationType = "SPECIAL";

			models = {models.models.ex_skill_1.Smokes, models.models.ex_skill_1.StandCamera, ModelAlias.alias.avatar.head.HeadShine, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 160, 0);
					pos = vectors.vec3(3.5, 23, -11.75);
				};

				fin = {
					rot = vectors.vec3(0, 190, 0);
					pos = vectors.vec3(-0.75, 21, -50.75);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						for i = 1, 4 do
							models.models.ex_skill_1.Smokes["Smoke" .. i]["Smoke" .. i .. "Top"]:newText("smoke_" .. i .. "_text"):setText("§5忍"):setPos(0, -0.09, 0.5):setRot(90, 0, 0):setScale(0.15):setAlignment("CENTER")
						end
						if host:isHost() then
							models.models.ex_skill_1.Gui.CameraGui:setScale(4, 4, 1)
							local windowSize = client:getScaledWindowSize()
							models.models.ex_skill_1.Gui.CameraGui:newText("ex_skill_1_camera_gui_rec"):setBackground(true):setBackgroundColor(0, 0, 0, 1)
							models.models.ex_skill_1.Gui.CameraGui:newText("ex_skill_1_camera_gui_resolution"):setScale(0.25):setAlignment("LEFT")
							models.models.ex_skill_1.Gui.CameraGui:newText("ex_skill_1_camera_gui_fps"):setScale(0.25):setAlignment("RIGHT")
						end
						self.exSkill.primary.isInitialized = true
					end
					if host:isHost() then
						local windowSize = client:getScaledWindowSize()
						local outerYOffset = 4
						local outerXOffset = outerYOffset * (windowSize.x / windowSize.y)
						models.models.ex_skill_1.Gui.CameraGui.OuterTL:setPos(-outerXOffset, -outerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.OuterTR:setPos(windowSize.x / 4 * -1 + outerXOffset, -outerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.OuterBL:setPos(-outerXOffset, windowSize.y / 4 * -1 + outerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.OuterBR:setPos(windowSize.x / 4 * -1 + outerXOffset, windowSize.y / 4 * -1 + outerYOffset, 0)
						local innerYOffset = 8
						local innerXOffset = innerYOffset * (windowSize.x / windowSize.y)
						local cameraCenter = windowSize:copy():scale(-0.125)
						models.models.ex_skill_1.Gui.CameraGui.InnerTL:setPos(cameraCenter.x + innerXOffset, cameraCenter.y + innerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.InnerTR:setPos(cameraCenter.x - innerXOffset, cameraCenter.y + innerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.InnerBL:setPos(cameraCenter.x + innerXOffset, cameraCenter.y - innerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.InnerBR:setPos(cameraCenter.x - innerXOffset, cameraCenter.y - innerYOffset, 0)
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.CameraGui.SplitHT, models.models.ex_skill_1.Gui.CameraGui.SplitHB, models.models.ex_skill_1.Gui.CameraGui.SplitVL, models.models.ex_skill_1.Gui.CameraGui.SplitVR}) do
							modelPart:setOpacity(0.5)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.CameraGui.SplitHT, models.models.ex_skill_1.Gui.CameraGui.SplitHB}) do
							modelPart:setScale(windowSize.x, 1, 1)
						end
						models.models.ex_skill_1.Gui.CameraGui.SplitHT:setPos(0, windowSize.y / 4 * -0.25, 1)
						models.models.ex_skill_1.Gui.CameraGui.SplitHB:setPos(0, windowSize.y / 4 * -0.75, 1)
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.CameraGui.SplitVL, models.models.ex_skill_1.Gui.CameraGui.SplitVR}) do
							modelPart:setScale(1, windowSize.y, 1)
						end
						models.models.ex_skill_1.Gui.CameraGui.SplitVL:setPos(windowSize.x / 4 * -0.25, 0, 1)
						models.models.ex_skill_1.Gui.CameraGui.SplitVR:setPos(windowSize.x / 4 * -0.75, 0, 1)
						local trueWindowSize = client:getWindowSize()
						models.models.ex_skill_1.Gui.CameraGui:getTask("ex_skill_1_camera_gui_rec"):setPos(cameraCenter.x, -4, 0):setScale(0.5):setAlignment("CENTER")
						models.models.ex_skill_1.Gui.CameraGui:getTask("ex_skill_1_camera_gui_resolution"):setText(trueWindowSize.x .. "x" .. trueWindowSize.y):setPos(-4 * (windowSize.x / windowSize.y) - 3, -4 - 3, 0)
						models.models.ex_skill_1.Gui.CameraGui:getTask("ex_skill_1_camera_gui_fps"):setPos(windowSize.x / 4 * -1 - (-4 * (windowSize.x / windowSize.y) - 3), -4 - 3, 0)
						models.models.ex_skill_1.Gui.CameraGui.Battery:setPos(-4 * (windowSize.x / windowSize.y) - 3, windowSize.y / 4 * -1 + 2 + 4, 0)
						models.models.ex_skill_1.Gui.CameraGui.Flash:setPos(windowSize.x / 4 * -1 - (-4 * (windowSize.x / windowSize.y) - 3), windowSize.y / 4 * -1 + 2 + 5, 0)
						models.models.ex_skill_1.Gui.CameraGui.Flash:setUVPixels(math.random() >= 0.95 and 16 or 0, 0)

						models.models.ex_skill_1.Gui.Transition.Transition:setScale(windowSize.x * 2, windowSize.y * 2, 1)
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.Transition:setPos(models.models.ex_skill_1.Gui.TransitionAnchor:getAnimPos():copy():mul(windowSize.y / math.cos(math.rad(30)), windowSize.y, 1):add(windowSize:copy():scale(-0.5):augmented(0)))
						end, "ex_skill_1_render")
					end
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "UNCOMFORT2", 27, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 27 then
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.5, 1)
					elseif tick == 29 then
						FaceParts:setEmotion("NORMAL", "CENTER", "OPENED", 42, true)
					elseif tick == 50 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					elseif tick == 71 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 1, true)
						local playerPos = player:getPos()
						local anchorPos = playerPos:copy():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0.5, 0, 0, 0, 1, 0))
						for i = 0, 17 do
							particles:newParticle("minecraft:poof", anchorPos):setScale(2):setVelocity(vectors.rotateAroundAxis(i * 20, 0, 0, 0.2, 0, 1, 0)):setColor(vectors.vec3(0.846, 0.736, 0.941):sub(vectors.vec3(0.151, 0.198, 0.058):scale(math.random())))
						end
						sounds:playSound("minecraft:entity.player.attack.sweep", playerPos, 1, 1.5)
					elseif tick == 72 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 34, true)
					elseif tick == 83 then
						self.exSkill.primary.spawnSmokeParticles(vectors.vec3(-16.5, 0, -16.25):scale(1 / 16))
					elseif tick == 89 then
						self.exSkill.primary.spawnSmokeParticles(vectors.vec3(27.5, 0, 24.75):scale(1 / 16))
					elseif tick == 100 then
						self.exSkill.primary.spawnSmokeParticles(vectors.vec3(4, 0, 28.75):scale(1 / 16))
					elseif tick == 106 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SMILE", 11, true)
						if host:isHost() then
							models.models.ex_skill_1.Gui.CameraGui:setVisible(false)
						end
					elseif tick == 117 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", 16, true)
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 3)
					elseif tick == 129 then
						for _ = 1, 10 do
							particles:newParticle("minecraft:electric_spark", ModelUtils.getModelWorldPos(models.models.ex_skill_1.StandCamera.HitEffect)):setScale(0.5):setVelocity(math.random() * 0.2 - 0.1, math.random() * 0.15, math.random() * 0.2 - 0.1):setColor(0.954, 0.392, 0.403):setGravity(0.5):setLifetime(8)
						end
						sounds:playSound("minecraft:block.anvil.place", player:getPos(), 0.5, 0.5)
					elseif tick == 133 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SMALL", 3, true)
					elseif tick == 136 then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SMALL", 15, true)
					elseif tick == 151 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "UNCOMFORT2", 4, true)
					elseif tick == 152 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.head.Hat, models.models.main, ModelAlias.alias.avatar.head)
					elseif tick == 155 then
						FaceParts:setEmotion("TEAR", "TEAR", "UNCOMFORT2", 1, true)
					elseif tick == 156 then
						FaceParts:setEmotion("TEAR", "TEAR", "SHOCK", 40, true)
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.5, 0.75)
					end
					if (tick >= 39 and tick < 45) or (tick >= 63 and tick < 69) then
						local anchorPos = models.models.ex_skill_1.Gui.Transition:getPos()
						local windowSize = client:getScaledWindowSize()
						for _ = 1, 5 do
							local offset = math.random() * 2 - 1
							Character18b_ExSkillSpriteManager:spawn(models.models.ex_skill_1.Gui, vectors.vec3(0.804, 0.684, 0.997):add(vectors.vec3(0.196, 0.316, 0.003):scale(math.random())), anchorPos:copy():add(offset * windowSize.x * math.cos(math.rad(30)), offset * windowSize.y / math.cos(math.rad(30))), vectors.rotateAroundAxis(30, 0, 1500 * (tick < 45 and 1 or -1), 0, 0, 0, 1), math.random() * 720 - 360, 30, nil, 20, false, 1)
						end
					end
					if tick >= 156 and (tick - 156) % 2 == 0 then
						local bodyYaw = player:getBodyYaw()
						for index, modelPart in ipairs({ModelAlias.alias.avatar.rightEye, ModelAlias.alias.avatar.leftEye}) do
							local anchorPos = ModelUtils.getModelWorldPos(modelPart):copy():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0.2, 0.2, 0, 1, 0))
							particles:newParticle("minecraft:splash", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.1 + 0.1 * (index == 1 and -1 or 1), math.random() * 0.1 + 0.1, 0, 0, 1, 0))
						end
						if tick % 4 == 0 then
							sounds:playSound("minecraft:block.bubble_column.bubble_pop", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head), 0.15, 2 - math.random() * 0.5)
						end
					end
					if tick < 106 and host:isHost() then
						if tick % 10 == 0 then
							models.models.ex_skill_1.Gui.CameraGui:getTask("ex_skill_1_camera_gui_rec"):setText("§f" .. (tick % 20 == 0 and ":red:" or "  ") .. " REC")
						end
						models.models.ex_skill_1.Gui.CameraGui:getTask("ex_skill_1_camera_gui_fps"):setText("§f" .. client:getFPS() .. "fps")
					end
				end;

				onPostAnimation = function ()
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						models.models.ex_skill_1.Gui.CameraGui:setVisible(true)
					end
					if models.models.main.Hat ~= nil then
						ModelUtils.moveTo(models.models.main.Hat, ModelAlias.alias.avatar.head, models.models.main)
					end
				end;
			};

			---煙幕のパーティクルを表示する。
			---@param offset Vector3 パーティクルの表示位置のオフセット
			spawnSmokeParticles = function (offset)
				local anchorPos = player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, offset, 0, 1, 0))
				for _ = 1, 20 do
					particles:newParticle("minecraft:poof", anchorPos):setScale(5):setVelocity(math.random() * 0.6 - 0.3, math.random() * 0.3, math.random() * 0.6 - 0.3):setColor(vectors.vec3(0.846, 0.736, 0.941):sub(vectors.vec3(0.151, 0.198, 0.058):scale(math.random()))):setLifetime(20)
				end
				sounds:playSound("minecraft:entity.generic.explode", anchorPos, 0.5, 2)
			end;

			---このExスキルを初期化したかどうか
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.Hat:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Dress:setVisible(not isVisible)
					ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, isVisible and -1 or 0)
					ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, isVisible and 1 or 0)
					self.physics.physicData[8].x.vertical.neutral = isVisible and 0 or -15
					self.physics.physicData[8].x.vertical.max = isVisible and 0 or -15
					self.physics.physicData[8].x.vertical.bodyX.max = isVisible and 0 or -15
					self.physics.physicData[8].x.vertical.bodyY.max = isVisible and 0 or -15
					self.physics.physicData[8].x.vertical.bodyRot.max = isVisible and 0 or -15
					self.physics.physicData[8].x.horizontal.neutral = isVisible and 0 or -15
					self.physics.physicData[8].x.horizontal.max = isVisible and 0 or -15
				end
			end;
		};

		---前ティックで剣を持っていたかどうか。
		---@type boolean
		hadSwordPrev = false;

		---前ティックで花火のモデルを置き換えたかどうか。
		---@type boolean
		shouldReplaceFireworkModelPrev = false;
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("ANGRY", "ANGRY", "OPENED2", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("NORMAL", "CLOSED", "OPENED", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SMALL", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "FRUST", duration, true)
					end
				end
			end;

			onStop = function(_, _, forcedStop)
				if not forcedStop then
					FaceParts:resetEmotion()
				end
			end;
		};
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
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-2, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Dress:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(15, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.FrontHair:setPos(0.5, 0.5, 0)
				ModelAlias.alias.dummy_avatar.body.Hairs.FrontHair:setRot(0, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-15, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Dress:setRot(15, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(75, 0, -15)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.Cowlick};

				x = {
					vertical = {
						min = -85;
						neutral = -67.5;
						max = -47.5;

						bodyY = {
							multiplayer = -40;
							min = -85;
							max = -47.5;
						};
					};

					horizontal = {
						min = -85;
						neutral = -67.5;
						max = -47.5;

						bodyX = {
							multiplayer = -80;
							min = -85;
							max = -47.5;
						};
					};
				};

				y = {
					vertical = {
						min = 50;
						neutral = 50;
						max = 50;
					};

					horizontal = {
						min = 50;
						neutral = 50;
						max = 50;
					};
				};
			};

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
				models = {ModelAlias.alias.avatar.head.Hat.HatRibbon.HatRibbon1};

				z = {
					vertical = {
						min = -150;
						neutral = -5;
						max = -5;

						headZ = {
							multiplayer = -120;
							min = -90;
							max = -5;
						};

						headRot = {
							multiplayer = 0.075;
							min = -90;
							max = -5;
						};
					};

					horizontal = {
						min = -150;
						neutral = -10;
						max = -5;

						bodyX = {
							multiplayer = 120;
							min = -150;
							max = -5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Hat.HatRibbon.HatRibbon1.HatRibbon1};

				x = {
					vertical = {
						min = -170;
						neutral = -12.5;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -120;
							min = -90;
							max = 90;
						};

						bodyY = {
							multiplayer = 120;
							min = -170;
							max = 12.5;
						};

					};

					horizontal = {
						min = -170;
						neutral = 32.5;
						max = 90;

						bodyX = {
							multiplayer = -120;
							min = -90;
							max = 90;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Hat.HatRibbon.HatRibbon2};

				z = {
					vertical = {
						min = -150;
						neutral = -7.5;
						max = -7.5;

						headZ = {
							multiplayer = -120;
							min = -90;
							max = -7.5;
						};

						headRot = {
							multiplayer = 0.075;
							min = -90;
							max = -7.5;
						};
					};

					horizontal = {
						min = -150;
						neutral = -10;
						max = -7.5;

						bodyX = {
							multiplayer = 120;
							min = -150;
							max = -7.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Hat.HatRibbon.HatRibbon2.HatRibbon2};

				x = {
					vertical = {
						min = -170;
						neutral = 0;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -120;
							min = -90;
							max = 90;
						};

						bodyY = {
							multiplayer = 120;
							min = -170;
							max = 0;
						};

					};

					horizontal = {
						min = -170;
						neutral = 45;
						max = 90;

						bodyX = {
							multiplayer = -120;
							min = -90;
							max = 90;
						};
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
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair};

				x = {
					vertical = {
						min = -150;
						neutral = -15;
						max = -15;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = -15;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = -15;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -15;
						};
					};

					horizontal = {
						min = -90;
						neutral = -15;
						max = -15;
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function (self)
		---忍術ワープの表現
		---@type Character18b.Teleport
		Character18b_Teleport = require("scripts.teleport")

		---Exスキルで使用するスプライトオブジェクトのインスタンスクラス
		---@type Character18b.ExSkillSprite
		Character18b_ExSkillSprite = require("scripts.ex_skill_sprite")

		---Exスキルで使用するスプライトオブジェクトのマネージャークラス
		---@type Character18b.ExSkillSpriteManager
		Character18b_ExSkillSpriteManager = require("scripts.ex_skill_sprite_manager")
		Character18b_ExSkillSpriteManager = Character18b_ExSkillSpriteManager.new()

		Character18b_Teleport:init()

        events.TICK:register(function ()
			ModelAlias.alias.avatar.body.Dress:setRot(player:isCrouching() and 17.5 or 0, 0, 0)

            local hasSword = (player:getHeldItem().id:match("^minecraft:(%a+)_sword$") ~= nil or player:getHeldItem(true).id:match("^minecraft:(%a+)_sword$") ~= nil) and ExSkill.animationCount == -1
            if hasSword ~= self.costume.hadSwordPrev then
                if hasSword then
                    sounds:playSound("minecraft:block.anvil.place", player:getPos(), 0.5, 5)
                    events.ITEM_RENDER:register(function (item, mode)
                        if item.id:match("^minecraft:(%a+)_sword$") ~= nil and mode ~= "HEAD" then
                            if mode == "FIRST_PERSON_LEFT_HAND" or mode == "FIRST_PERSON_RIGHT_HAND" then
                                models.models.sword.Sword:setPos(0, -7.5, -1)
                                models.models.sword.Sword:setRot(10, 0, 0)
                            elseif mode == "THIRD_PERSON_LEFT_HAND" or mode == "THIRD_PERSON_RIGHT_HAND" then
                                models.models.sword.Sword:setPos(0.5, -9.75, -1)
                                models.models.sword.Sword:setRot()
                            end
                            local material = item.id:match("^minecraft:(%a+)_sword$")
                            models.models.sword.Sword.SwordBlade:setUVPixels(material == "wooden" and -6 or (material == "stone" and -4 or (material == "copper" and -2 or (material == "golden" and 2 or (material == "diamond" and 4 or (material == "netherite" and 6 or 0))))), 0)
                            models.models.sword.Sword:setSecondaryRenderType(item:hasGlint() and "GLINT" or "NONE")
                            return models.models.sword.Sword
                        end
                    end, "sword_item_render")
                else
                    events.ITEM_RENDER:remove("sword_item_render")
                    sounds:playSound("minecraft:block.iron_trapdoor.close", player:getPos(), 0.5, 2)
                end
                self.costume.hadSwordPrev = hasSword
            end
        end)
	end;
}

return BlueArchiveCharacter
