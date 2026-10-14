---右目のテクスチャの列挙型
---@alias Character17b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANGRY" # 怒った目
---| "UNEQUAL" # 不等号目
---| "SHOCKED" # 丸い目
---| "CLOSED2" # 閉じた目2
---| "ANGRY_INVERTED" # 反対側を見る目
---| "CENTER" # 少し反対側を見る目

---左目のテクスチャの列挙型
---@alias Character17b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANGRY" # 怒った目
---| "UNEQUAL" # 不等号目
---| "SHOCKED" # 丸い目
---| "CLOSED2" # 閉じた目2
---| "CENTER" # 少し反対側を見る目
---| "INVERTED" # 怒りつつ反対側を見る目

---口のテクスチャの列挙型
---@alias Character17b.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "NARROW" # 細長い口
---| "FRUST" # ぐじゅぐじゅ口
---| "O" # 細く丸い口
---| "W" # W口
---| "TONGUE" # 舌を出した口

---@class (exact) Character17b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character17b.RightEyeTextures 右目の表情名
---@field public leftEye Character17b.LeftEyeTextures 左目の表情名
---@field public mouth Character17b.MouthTextures 口の表情名

---@class (exact) Character17b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character17b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character17b.EmotionSet ベッドで寝ているとき

---@class (exact) Character17b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character17b, right: Character17b.RightEyeTextures, left: Character17b.LeftEyeTextures, mouth: Character17b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character17b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character17b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character17b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character17b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character17b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character17b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character17b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character17b.FacePartsStruct 目や口による表情

---@type Character17b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "17b_Reisa_Magical";

		birth = {
			month = 5;
			day = 31;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			ANGRY = vectors.vec2(5, 0);
			UNEQUAL = vectors.vec2(7, 0);
			SHOCKED = vectors.vec2(8, 0);
			CLOSED2 = vectors.vec2(9, 0);
			ANGRY_INVERTED = vectors.vec2(12, 0);
			CENTER = vectors.vec2(13, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			ANGRY = vectors.vec2(5, 0);
			UNEQUAL = vectors.vec2(6, 0);
			SHOCKED = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(8, 0);
			CENTER = vectors.vec2(9, 0);
			INVERTED = vectors.vec2(10, 0);
		};

		mouth = {
			OPENED = vectors.vec2(0, 0);
			NARROW = vectors.vec2(1, 0);
			FRUST = vectors.vec2(2, 0);
			O = vectors.vec2(3, 0);
			W = vectors.vec2(4, 0);
			TONGUE = vectors.vec2(5, 0);
		};

		callbacks = {
			onPlay = function (_, right, left)
				if right ~= "CLOSED2" then
					ModelAlias.alias.avatar.rightEye:setRot()
				end
				if left ~= "CLOSED2" then
					ModelAlias.alias.avatar.leftEye:setRot()
				end
			end;
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 1;

		gunPosition = {
			hold = {
				thirdPersonPos = {
					right = vectors.vec3(-1.5, 0, -4.5);
					left = vectors.vec3(1.5, 0, -4.5);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, -2, 3);
					left = vectors.vec3(0, -2, 3);
				};

				rot = {
					right = vectors.vec3(0, 90, -10);
					left = vectors.vec3(0, -90, 10);
				};
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

			models = {ModelAlias.alias.avatar.rightArmBottom.RocketLauncher, ModelAlias.alias.avatar.body.ChestRibbonBadge, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(0, 21.5, -10);
				};

				fin = {
					rot = vectors.vec3(0, -180, 0);
					pos = vectors.vec3(-3.5, 20, -33.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						if host:isHost() then
							for _, modelPart in ipairs(models.models.ex_skill_1.Gui.StarTransitions.Star1:getChildren()) do
								models.models.ex_skill_1.Gui.StarTransitions.Star2:addChild(modelPart:copy(modelPart:getName():gsub("1", "2")))
							end
						end
						for _, modelPart in ipairs(ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect2:getChildren()) do
							for i = 3, 4 do
								ModelAlias.alias.avatar.body.ChestRibbonBadge["ChestBadgeShineEffect" .. i]:addChild(modelPart:copy(client.intUUIDToString(client.generateUUID())))
							end
						end
						for _, modelPart in ipairs(ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect5:getChildren()) do
							for i = 6, 8 do
								ModelAlias.alias.avatar.body.ChestRibbonBadge["ChestBadgeShineEffect" .. i]:addChild(modelPart:copy(client.intUUIDToString(client.generateUUID())))
							end
						end
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect2:setColor(0.94, 1, 1)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect3:setColor(1, 0.54, 1)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect4:setColor(1, 1, 0.51)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect5:setColor(0.94, 1, 1)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect6:setColor(1, 1, 0.51)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect7:setColor(0.94, 1, 1)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect8:setColor(1, 1, 0.51)
						self.exSkill.primary.isInitialized = true
					end
					events.TICK:remove("costume_magical_badge_shine")
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadgeEmissive, ModelAlias.alias.avatar.head.HairPin.HairPinBase.HairPinBaseEmissive}) do
						modelPart:setPrimaryRenderType("CUTOUT")
					end
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "O", 43, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 23 then
						ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadgeEmissive:setPrimaryRenderType("EMISSIVE_SOLID")
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadge)
						local bodyYaw = player:getBodyYaw()
						local colorTable = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)}
						for _ = 1, 24 do
							particles:newParticle("minecraft:firework", anchorPos):setScale(0.1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(math.random() * 360, 0, math.random() * 0.02 + 0.01, 0.02, 0, 0, 1), 0, 1, 0)):setColor(colorTable[math.random(#colorTable)]):setGravity(0):setLifetime(15)
						end
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 3)
					elseif tick == 35 and host:isHost() then
						models.models.ex_skill_1.Gui.StarTransitions:setVisible(true)
						local windowSize = client:getScaledWindowSize():copy():augmented(0)
						local baseStarScale = math.max(windowSize.x, windowSize.y) / 16
						models.models.ex_skill_1.Gui.StarTransitions.Star1:setScale(vectors.vec3(1, 1, 1):scale(baseStarScale))
						models.models.ex_skill_1.Gui.StarTransitions.Star2:setScale(vectors.vec3(1, 1, 1):scale(baseStarScale * 0.75))
						models.models.ex_skill_1.Gui.StarTransitions.Star1.Star1Outer:setColor(1, 0.76, 1)
						models.models.ex_skill_1.Gui.StarTransitions.Star2.Star2Outer:setColor(0.85, 0.8, 1)
						events.RENDER:register(function ()
							for i = 1, 2 do
								models.models.ex_skill_1.Gui.StarTransitions["Star" .. i]:setPos(models.models.ex_skill_1.Gui.StarTransitions["Star" .. i .. "PosAnchor"]:getAnimPos():copy():mul(windowSize))
							end
						end, "ex_skill_1_transition_1")
					elseif tick == 43 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "W", 5, true)
					elseif tick == 48 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "NARROW", 16, true)
					elseif tick == 50 and host:isHost() then
						models.models.ex_skill_1.Gui.StarTransitions:setVisible(false)
						events.RENDER:remove("ex_skill_1_transition_1")
					elseif tick == 64 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "W", 12, true)
					elseif tick == 72 then
						for _ = 1, 8 do
							table.insert(self.exSkill.primary.particleCircleTable, {math.random() * 2 + 0.5, math.random() * 360, math.random(3)}) --1. パーティクルの輪の高さ, 2. パーティクルの輪の開始角, 3. パーティクルの輪の色のインデックス番号
						end
					elseif tick == 76 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 2, true)
					elseif tick == 78 then
						FaceParts:setEmotion("NORMAL", "CENTER", "OPENED", 2, true)
					elseif tick == 80 then
						FaceParts:setEmotion("NORMAL", "INVERTED", "OPENED", 8, true)
					elseif tick == 88 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 17, true)
					elseif tick == 105 then
						FaceParts:setEmotion("CENTER", "NORMAL", "OPENED", 4, true)
					elseif tick == 106 then
						ModelAlias.alias.avatar.head.HairPin.HairPinBase.HairPinBaseEmissive:setPrimaryRenderType("EMISSIVE_SOLID")
					elseif tick == 109 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 13, true)
					elseif tick == 113 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.HairPin)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 24 do
							particles:newParticle("minecraft:firework", anchorPos):setScale(0.025):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(math.random() * 360, 0, math.random() * 0.01 + 0.005, 0.005, 0, 0, 1), 0, 1, 0)):setColor(1, 0.87, 1):setGravity(0):setLifetime(15)
						end
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 1)
					elseif tick == 119 and host:isHost() then
						models.models.ex_skill_1.Gui.TransitionBackground:setVisible(true)
						models.models.ex_skill_1.Gui.TransitionBackground.Background:setScale(client:getScaledWindowSize():copy():augmented(1))
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.TransitionBackground.Background:setOpacity(models.models.ex_skill_1.Gui.TransitionBackground.BackgroundOpacity:getAnimScale().x)
						end, "ex_skill_1_transition_2")
					elseif tick == 122 then
						FaceParts:setEmotion("ANGRY_INVERTED", "ANGRY", "TONGUE", 38, true)
					elseif tick == 123 then
						ModelAlias.alias.avatar.rightArmBottom.RocketLauncher:setPrimaryRenderType("EMISSIVE_SOLID")
					elseif tick == 134 and host:isHost() then
						events.RENDER:remove("ex_skill_1_transition_2")
					elseif tick == 138 then
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.5, 2)
					elseif tick == 139 then
						ModelAlias.alias.avatar.rightArmBottom.RocketLauncher:setPrimaryRenderType("CUTOUT")
					elseif tick == 155 and host:isHost() then
						models.models.main.Avatar:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
						models.models.ex_skill_1.CameraBackground:setVisible(true)
						local windowSize = client:getWindowSize()
						models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(40))
						events.RENDER:register(function (delta, ctx, matrix)
							local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.65)), 0, 1, 0):scale(16 / 0.9375)
							models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
							models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
						end, "ex_skill_1_transition_3")
					elseif tick == 159 then
						if host:isHost() then
							models.models.main.Avatar:setPrimaryRenderType("CUTOUT")
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							events.RENDER:remove("ex_skill_1_transition_3")
						end
						ModelAlias.alias.avatar.halo:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
						models.models.ex_skill_1.CameraStarEffect:setVisible(true)
						local windowSize = client:getScaledWindowSize()
						for i = 0, 5 do
							local starType = math.random(5)
							local rot = i * 60 + 10
							ExSkillSpriteManager:spawn(models.models.ex_skill_1.CameraStarEffect, vectors.vec2(0, starType <= 3 and 0 or 1), starType >= 4 and vectors.vec3(0.42, 1, 1) or (starType >= 2 and vectors.vec3(1, 0.47, 1) or vectors.vec3(1, 1, 0.6)), vectors.vec3(0, 0, 0), vectors.rotateAroundAxis(rot, 0, (math.random() * 60 + 40) * math.sqrt(math.pow(math.sin(math.rad(rot)) * (windowSize.x / windowSize.y), 2) + math.pow(math.cos(math.rad(rot)), 2)), -5, 0, 0, 1), math.random() * 50 + 10, math.random() * 20 + 10, nil, 53, false, 0.8)
						end
					elseif tick == 160 then
						FaceParts:setEmotion("CENTER", "NORMAL", "OPENED", 52, true)
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					end

					if tick >= 45 then
						local colorTable = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)}
						particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadge)):setScale(0.1):setVelocity(math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03):setColor(colorTable[math.random(#colorTable)]):setGravity(0):setLifetime(15)
					end
					if tick >= 127 then
						particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.HairPin)):setScale(0.1):setVelocity(math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03):setColor(1, 0.87, 1):setGravity(0):setLifetime(15)
						particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightArmBottom.RocketLauncher.Camera)):setScale(0.25):setVelocity(math.random() * 0.12 - 0.06, math.random() * 0.12 - 0.06, math.random() * 0.12 - 0.06):setColor(1, 0.65, 0.96):setGravity(0):setLifetime(15)
					end
					if tick >= 36 and tick <= 42 and host:isHost() then
						local windowSize = client:getScaledWindowSize():augmented(0)
						local starScale = math.max(windowSize.x, windowSize.y)
						for _ = 1, 4 do
							ExSkillSpriteManager:spawn(models.models.ex_skill_1.Gui.StarTransitions, vectors.vec2(0, 1), vectors.vec3(1, 0.88, 1), models.models.ex_skill_1.Gui.StarTransitions.Star1:getPos():copy():add(vectors.vec3(1, 1, 0):mul(math.random() * starScale - starScale / 2, math.random() * starScale - starScale / 2, 1)), windowSize:copy():normalize():scale(-1500), math.random() * 180 + 180, 20, nil, 8, false, 1)
						end
					end
					if tick >= 45 and tick <= 47 and host:isHost() then
						local windowSize = client:getScaledWindowSize():augmented(0)
						local starScale = math.max(windowSize.x, windowSize.y) * 0.75
						for _ = 1, 4 do
							ExSkillSpriteManager:spawn(models.models.ex_skill_1.Gui.StarTransitions, vectors.vec2(0, 1), vectors.vec3(0.93, 0.9, 1), models.models.ex_skill_1.Gui.StarTransitions.Star2:getPos():copy():add(vectors.vec3(1, 1, 0):mul(math.random() * starScale - starScale / 2, math.random() * starScale - starScale / 2, 1)), windowSize:copy():normalize():scale(-1500), math.random() * 180 + 180, 20, nil, 8, false, 1)
						end
					end
					if tick >= 72 and tick <= 108 then
						local playerPos = player:getPos()
						local colorTable = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)}
						for _, particleData in ipairs(self.exSkill.primary.particleCircleTable) do
							particles:newParticle("minecraft:firework", playerPos:copy():add(vectors.rotateAroundAxis(tick * 10 + particleData[2], 0, 0, 2, 0, 1, 0):add(0, particleData[1], 0))):setScale(math.random() * 0.25 + 0.25):setColor(colorTable[particleData[3]]):setGravity(0.25):setLifetime(25)
						end
						sounds:playSound("minecraft:entity.experience_orb.pickup", playerPos:copy():add(0, 2, 0), 0.25, 1 + ((tick - 72) / 36))
					end
				end;

				onPostAnimation = function (self, forcedStop)
					ModelAlias.alias.avatar.halo:setPrimaryRenderType("CUTOUT")
					self.exSkill.primary.particleCircleTable = {}
					if forcedStop then
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.StarTransitions, models.models.ex_skill_1.Gui.TransitionBackground}) do
							modelPart:setVisible(false)
						end
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadgeEmissive, ModelAlias.alias.avatar.head.HairPin.HairPinBase.HairPinBaseEmissive, ModelAlias.alias.avatar.rightArmBottom.RocketLauncher, models.models.main.Avatar}) do
							modelPart:setPrimaryRenderType("CUTOUT")
						end
						ExSkillSpriteManager:removeAll()
						if host:isHost() then
							for i = 1, 3 do
								events.RENDER:remove("ex_skill_1_transition_" .. i)
							end
						end
					else
						events.TICK:register(function ()
						if not renderer:isFirstPerson() then
							local colorTable = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)}
							particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadge)):setScale(0.1):setVelocity(math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03):setColor(colorTable[math.random(#colorTable)]):setGravity(0):setLifetime(15)
							particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.HairPin)):setScale(0.1):setVelocity(math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03):setColor(0.73, 0.47, 1):setGravity(0):setLifetime(15)
						end
						end, "costume_magical_badge_shine")
					end
				end;
			};

			---このExスキルが初期化されたかどうか。
			---@type boolean
			isInitialized = false;

			---パーティクルの輪の情報を保持するテーブル
			---@type number[][]
			particleCircleTable = {};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("ANGRY", "ANGRY", "OPENED", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("ANGRY", "ANGRY", "NARROW", duration, true)
						ModelAlias.alias.avatar.head.EyeShines:setVisible(true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "NARROW", duration, true)
						ModelAlias.alias.avatar.rightEye:setRot(0, 0, -5)
						ModelAlias.alias.avatar.leftEye:setRot(0, 0, 5)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("SHOCKED", "SHOCKED", "FRUST", duration, true)
						ModelAlias.alias.avatar.rightEye:setRot(0, 0, -5)
						ModelAlias.alias.avatar.leftEye:setRot(0, 0, 5)
					end
				end
			end;

			onStop = function(_, _, forcedStop)
				ModelAlias.alias.avatar.head.EyeShines:setVisible(false)
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
			onBeforeModelCopy = function ()
				events.TICK:remove("costume_magical_badge_shine")
				for _, modelPart in ipairs({ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadgeEmissive, ModelAlias.alias.avatar.head.HairPin.HairPinBase.HairPinBaseEmissive}) do
					modelPart:setPrimaryRenderType("CUTOUT")
				end
			end;

			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(30, 0, 20)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(30, 0, -20)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(60, 0, 0)
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomRight, ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomLeft}) do
					modelPart:setPos(0, 2, 0)
					modelPart:setRot(-120, 0, 0)
				end
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(-20, 0, 20)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(-20, 0, -20)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomRight:setPos()
				ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomRight:setRot(-15, 0, 5)
				ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomLeft:setPos()
				ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomLeft:setRot(-15, 0, -25)
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
						min = -50;
						neutral = -20;
						max = 20;

						headX = {
							multiplayer = 40;
							min = -50;
							max = 20;
						};

						bodyY = {
							multiplayer = 40;
							min = -50;
							max = 20;
						};
					};

					horizontal = {
						min = -50;
						neutral = -20;
						max = 20;

						bodyX = {
							multiplayer = 80;
							min = 0;
							max = 20;
						};
					};
				};

				y = {
					vertical = {
						min = -20;
						neutral = -20;
						max = -20;
					};

					horizontal = {
						min = -20;
						neutral = -20;
						max = -20;
					};
				};
			};

		{
				models = {ModelAlias.alias.avatar.head.HairTails.LeftHairTail};
				x = {
					vertical = {
						min = -170;
						neutral = -10;
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
							multiplayer = -80;
							min = -45;
							max = 70;
						};
					};
				};

				z = {
					vertical = {
						min = -70;
						neutral = -10;
						max = 70;

						headZ = {
							multiplayer = -80;
							min = -70;
							max = 70;
						};
					};

					horizontal = {
						min = -70;
						neutral = -10;
						max = 70;

						headX = {
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
						min = -170;
						neutral = -10;
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
							multiplayer = -80;
							min = -45;
							max = 70;
						};
					};
				};

				z = {
					vertical = {
						min = -70;
						neutral = 10;
						max = 70;

						headZ = {
							multiplayer = -80;
							min = -70;
							max = 70;
						};
					};

					horizontal = {
						min = -70;
						neutral = 10;
						max = 70;

						headX = {
							multiplayer = 80;
							min = 10;
							max = 2.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairPin.HairPinWing, ModelAlias.alias.avatar.leftLegBottom.LeftBootsWing};

				z = {
					vertical = {
						min = -15;
						neutral = 0;
						max = 35;

						bodyY = {
							multiplayer = 40;
							min = -15;
							max = 35;
						};
					};

					horizontal = {
						min = -15;
						neutral = 0;
						max = 35;

						bodyY = {
							multiplayer = -40;
							min = -15;
							max = 35;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonRight};

				y = {
					vertical = {
						min = -70;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -40;
							min = -70;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.025;
							min = -70;
							max = 0;
						};
					};

					horizontal = {
						min = -70;
						neutral = 0;
						max = 0;

						bodyY = {
							multiplayer = 40;
							min = -70;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonRight.RibbonRightZPivot};

				z = {
					vertical = {
						min = -20;
						neutral = 0;
						max = 20;

						bodyY = {
							multiplayer = -20;
							min = -20;
							max = 20;
						};
					};

					horizontal = {
						min = -20;
						neutral = 0;
						max = 20;

						bodyX = {
							multiplayer = -20;
							min = -20;
							max = 20;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonLeft};

				y = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 70;

						bodyX = {
							multiplayer = 40;
							min = 0;
							max = 70;
						};

						bodyRot = {
							multiplayer = -0.025;
							min = 0;
							max = 70;
						};
					};

					horizontal = {
						min = 0;
						neutral = 0;
						max = 70;

						bodyY = {
							multiplayer = -40;
							min = 0;
							max = 70;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonLeft.RibbonLeftZPivot, ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonLeft.ChestRibbonLeftZPivot};

				z = {
					vertical = {
						min = -20;
						neutral = 0;
						max = 20;

						bodyY = {
							multiplayer = 20;
							min = -20;
							max = 20;
						};
					};

					horizontal = {
						min = -20;
						neutral = 0;
						max = 20;

						bodyX = {
							multiplayer = 20;
							min = -20;
							max = 20;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonBottomRight, ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonBottomLeft};

				x = {
					vertical = {
						min = -140;
						neutral = 0;
						max = 15;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = -60;
							max = 15;
						};

						bodyY = {
							multiplayer = 80;
							min = -140;
							max = 15;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -60;
							max = 0;
						};
					};

					horizontal = {
						min = -140;
						neutral = 0;
						max = 15;

						bodyY = {
							multiplayer = 80;
							min = -60;
							max = 15;
						};
					};
				};
			};


		{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonBottomRight.RibbonBottomRightZPivot, ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonBottomRight.ChestRibbonBottomRightZPivot};

				z = {
					vertical = {
						min = -22.5;
						neutral = 0;
						max = 15;

						bodyX = {
							multiplayer = 10;
							min = -22.5;
							max = 15;
						};

						bodyY = {
							multiplayer = 20;
							min = 0;
							max = 15;
						};

						bodyRot = {
							multiplayer = -0.025;
							min = -22.5;
							max = 15;
						};
					};

					horizontal = {
						min = -22.5;
						neutral = 0;
						max = 10;

						bodyX = {
							multiplayer = 10;
							min = -22.5;
							max = 15;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonBottomLeft.RibbonBottomLeftZPivot, ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonBottomLeft.ChestRibbonBottomLeftZPivot};

				z = {
					vertical = {
						min = -15;
						neutral = 0;
						max = 22.5;

						bodyX = {
							multiplayer = -10;
							min = -15;
							max = 22.5;
						};

						bodyY = {
							multiplayer = -20;
							min = -15;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.025;
							min = -15;
							max = 22.5;
						};
					};

					horizontal = {
						min = -22.5;
						neutral = 0;
						max = 10;

						bodyX = {
							multiplayer = 10;
							min = -22.5;
							max = 15;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonRight};

				y = {
					vertical = {
						min = -70;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -40;
							min = -70;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.025;
							min = -70;
							max = 0;
						};
					};

					horizontal = {
						min = -70;
						neutral = 0;
						max = 0;

						bodyY = {
							multiplayer = 40;
							min = -70;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonLeft};

				y = {
					vertical = {
						min = -70;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = 40;
							min = -70;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.025;
							min = -70;
							max = 0;
						};
					};

					horizontal = {
						min = -70;
						neutral = 0;
						max = 0;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonRight};

				y = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 70;

						bodyX = {
							multiplayer = -40;
							min = 0;
							max = 70;
						};

						bodyRot = {
							multiplayer = -0.025;
							min = 0;
							max = 70;
						};
					};

					horizontal = {
						min = 0;
						neutral = 0;
						max = 70;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonRight.RibbonRightZPivot, ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonRight.ChestRibbonRightZPivot};

				z = {
					vertical = {
						min = -20;
						neutral = 0;
						max = 20;

						bodyY = {
							multiplayer = -20;
							min = -20;
							max = 20;
						};
					};

					horizontal = {
						min = -20;
						neutral = 0;
						max = 20;

						bodyX = {
							multiplayer = -20;
							min = -20;
							max = 20;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonBottomRight, ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonBottomLeft};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 140;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 140;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 60;
						};
					};

					horizontal = {
						min = 0;
						neutral = 0;
						max = 140;

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.rightLegBottom.RightBootsWing};

				z = {
					vertical = {
						min = -35;
						neutral = 0;
						max = 15;

						bodyY = {
							multiplayer = -40;
							min = -35;
							max = 15;
						};
					};

					horizontal = {
						min = -35;
						neutral = 0;
						max = 15;

						bodyY = {
							multiplayer = 40;
							min = -35;
							max = 15;
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
		---@type Character17b.ExSkillSprite
		ExSkillSprite = require("scripts.ex_skill_sprite")

		---Exスキルで使用するスプライトオブジェクトのマネージャークラス
		---@type Character17b.ExSkillSpriteManager
		ExSkillSpriteManager = require("scripts.ex_skill_sprite_manager")
		ExSkillSpriteManager = ExSkillSpriteManager.new()
	end;
}

return BlueArchiveCharacter
