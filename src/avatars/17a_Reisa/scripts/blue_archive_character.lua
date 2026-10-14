---右目のテクスチャの列挙型
---@alias Character17a.RightEyeTextures
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
---@alias Character17a.LeftEyeTextures
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
---@alias Character17a.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "NARROW" # 細長い口
---| "FRUST" # ぐじゅぐじゅ口
---| "O" # 細く丸い口
---| "W" # W口
---| "TONGUE" # 舌を出した口

---@class (exact) Character17a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character17a.RightEyeTextures 右目の表情名
---@field public leftEye Character17a.LeftEyeTextures 左目の表情名
---@field public mouth Character17a.MouthTextures 口の表情名

---@class (exact) Character17a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character17a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character17a.EmotionSet ベッドで寝ているとき

---@class (exact) Character17a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character17a, right: Character17a.RightEyeTextures, left: Character17a.LeftEyeTextures, mouth: Character17a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character17a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character17a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character17a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character17a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character17a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character17a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character17a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character17a.FacePartsStruct 目や口による表情

---@type Character17a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "17a_Reisa";

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
		{
			model = models.models.ex_skill_1.Letter;

			boundingBox = {
				size = vectors.vec3(6, 1, 6)
			};

			placementMode = "COPY";

			callbacks = {
				onInit = function (_, placementObject)
					placementObject.textUuid = client.intUUIDToString(client.generateUUID())
					---@diagnostic disable-next-line: discard-returns, invisible
					placementObject.object:newPart("TextArea")
					---@diagnostic disable-next-line: invisible
					placementObject.object.TextArea:setPos(0, 7, 0)
					---@diagnostic disable-next-line: discard-returns, invisible
					placementObject.object.TextArea:newPart("TextAreaInner", "Camera")
					---@diagnostic disable-next-line: invisible
					placementObject.textTask = placementObject.object.TextArea.TextAreaInner:newText(placementObject.textUuid)

					placementObject.textTask:setScale(0.5, 0.5, 0.5)
					placementObject.textTask:setAlignment("CENTER")
					placementObject.textTask:setBackground(true)
					local wordIndex = math.random(1, 6)
					placementObject.textTask:setText(Locale:getLocalizedText("placement_object.message_" .. wordIndex) .. Locale:getLocalizedText("placement_object.message_suffix"))

					EventManager.events["ON_LOCALE_READY"]:register(function (...)
						placementObject.textTask:setText(Locale:getLocalizedText("placement_object.message_" .. wordIndex) .. Locale:getLocalizedText("placement_object.message_suffix"))
					end, placementObject.uuid)
				end;

				onDeinit = function (_, placementObject)
					EventManager.events["ON_LOCALE_READY"]:remove(placementObject.uuid)
					---@diagnostic disable-next-line: invisible
					placementObject.object.TextArea:removeTask()
				end;

				onTick = function (_, placementObject)
					placementObject.textTask:setVisible(placementObject.currentPos:copy():sub(client:getViewer():getPos()):length() <= 2)
				end;
			};
		};
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.root.Background, ModelAlias.alias.avatar.gun.MuzzleEffect, models.models.ex_skill_1.Illagers, models.models.ex_skill_1.Letter};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(50, 150, 0);
					pos = vectors.vec3(3, 6, -2.75);
				};

				fin = {
					rot = vectors.vec3(0, 180, 15);
					pos = vectors.vec3(-4, 31.5, -24);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						if host:isHost() then
							---@diagnostic disable-next-line: discard-returns
							models:newPart("script_ex_skill_1")
							models.script_ex_skill_1:setVisible(false)
							models.script_ex_skill_1:addChild(ModelAlias.alias.avatar.root:copy("exSkill1Outline1"))
							models.script_ex_skill_1.exSkill1Outline1:removeChild(models.script_ex_skill_1.exSkill1Outline1.Background)
							models.script_ex_skill_1.exSkill1Outline1:setOffsetPivot(0, 16, 0)
							models.script_ex_skill_1.exSkill1Outline1:setScale(1.7, 1.5, 1.6)
							models.script_ex_skill_1.exSkill1Outline1:setPrimaryTexture("CUSTOM", textures["textures.ex_skill_1_white"])
							models.script_ex_skill_1.exSkill1Outline1:setPrimaryRenderType("EMISSIVE_SOLID")
							models.script_ex_skill_1:addChild(models.script_ex_skill_1.exSkill1Outline1:copy("exSkill1Outline2"))
							models.script_ex_skill_1.exSkill1Outline2:setPos(-2, -2, 2)
							models.script_ex_skill_1.exSkill1Outline2:setColor(0.608, 0.741, 1)
						end

						for _, part in ipairs({"Head", "Body", "RightArm", "LeftArm", "RightLeg", "LeftLeg"}) do
							for i = 1, 2 do
								models.models.ex_skill_1.Illagers["Vindicator"..i]["Vindicator"..i..part]:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Illagers.Pillager1["Pillager1"..part]))
							end
						end
						models.models.ex_skill_1.Illagers.Pillager1:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/illager/pillager.png")
						models.models.ex_skill_1.Letter:setPrimaryTexture("PRIMARY")
						for i = 1, 2 do
								models.models.ex_skill_1.Illagers["Vindicator"..i]:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/illager/vindicator.png")
							end
						for i, modelPart in ipairs({models.models.ex_skill_1.Illagers.Pillager1.Pillager1Question.Pillager1Question2, models.models.ex_skill_1.Illagers.Vindicator1.Vindicator1Question.Vindicator1Question2, models.models.ex_skill_1.Illagers.Vindicator2.Vindicator2Question.Vindicator2Question2}) do
							modelPart:newText("ex_skill_1_question_"..i):setText("§e?"):setPos(0, 7, 0):setScale(0.8, 0.8, 1):setAlignment("CENTER")
						end

						---@diagnostic disable-next-line: discard-returns
						models.models.ex_skill_1:newPart("script_walls")
						for i = 0, 1 do
							for j = 0, 3 do
								models.models.ex_skill_1.script_walls:newBlock("ex_skill_1_block_"..(i * 4 + (j + 1))):setBlock("minecraft:dark_oak_planks"):setPos(i * 96 - 56, j * 16, 8)
							end
							for j = 0, 1 do
								models.models.ex_skill_1.script_walls:newBlock("ex_skill_1_block_"..(i * 2 + (j + 1) + 8)):setBlock("minecraft:dark_oak_planks"):setPos(i * 64 - 40, j * 48, 8)
							end
						end
						---@diagnostic disable-next-line: discard-returns
						models.models.ex_skill_1:newPart("script_walls_breakable")
						for i = 0, 1 do
							for j = 0, 1 do
								models.models.ex_skill_1.script_walls_breakable:newBlock("ex_skill_1_block_"..(i * 2 + (j + 1) + 12)):setBlock("minecraft:dark_oak_planks"):setPos(i * 64 - 40, j * 16 + 16, 8)
							end
							for j = 0, 3 do
								models.models.ex_skill_1.script_walls_breakable:newBlock("ex_skill_1_block_"..(i * 4 + (j + 1) + 16)):setBlock("minecraft:dark_oak_planks"):setPos(i * 32 - 24, j * 16, 8)
							end
						end
						for i = 0, 1 do
							models.models.ex_skill_1.script_walls_breakable:newBlock("ex_skill_1_block_"..((i + 1) + 24)):setBlock("minecraft:dark_oak_planks"):setPos(-8, i * 16 + 32, 8)
						end
						models.models.ex_skill_1.script_walls_breakable:newBlock("ex_skill_1_block_27"):setBlock("minecraft:oak_door[facing=south,half=lower]"):setPos(-8, 0.5, 8.01)
						models.models.ex_skill_1.script_walls_breakable:newBlock("ex_skill_1_block_28"):setBlock("minecraft:oak_door[facing=south,half=upper]"):setPos(-8, 16.5, 8.01)

						self.exSkill.primary.isInitialized = true
					else
						for _, modelPart in ipairs({models.models.ex_skill_1.script_walls, models.models.ex_skill_1.script_walls_breakable}) do
							modelPart:setVisible(true)
						end
					end
					PlacementObjectManager:removeAll()
					renderer:shadowRadius(0)
					ModelAlias.alias.avatar.head.EyeShines:setVisible(true)
					FaceParts:setEmotion("ANGRY", "ANGRY", "OPENED", 93, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						ModelAlias.alias.avatar.body.Gun:setPos()
						ModelAlias.alias.avatar.body.Gun:setRot()
						sounds:playSound("minecraft:item.book.page_turn", player:getPos(), 1, 1.5)
					elseif tick >= 26 and tick <= 38 and (tick - 26) % 6 == 0 then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.25, 1)
					elseif tick == 27 then
						models.models.ex_skill_1.Letter:moveTo(models.models.ex_skill_1.Illagers.Pillager1.Pillager1RightArm)
					elseif tick == 43 then
						sounds:playSound("minecraft:entity.pillager.ambient", player:getPos(), 0.5, 1)
					elseif tick == 54 then
						sounds:playSound("minecraft:entity.vindicator.ambient", player:getPos(), 0.5, 1)
					elseif tick == 68 then
						models.models.ex_skill_1.script_walls_breakable:setVisible(false)
						local bodyYaw = player:getBodyYaw()
						local playerPos = player:getPos()
						local anchorPos = playerPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 2, -1, 0, 1, 0))
						particles:newParticle("minecraft:explosion_emitter", anchorPos)
						for _ = 1, 50 do
							local offset = vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 5 - 2.5, math.random() * 4 - 2, math.random() - 0.5, 0, 1, 0)
							particles:newParticle("minecraft:block minecraft:dark_oak_planks", anchorPos:copy():add(offset))
						end
						for _, pos in ipairs({vectors.vec3(-5, 3, 0), vectors.vec3(4, 0, 0), vectors.vec3(8, 8, 0)}) do
							ExSkillSpriteManager:spawn(models.models.ex_skill_1.ExSkill1ParticleAnchor1, vectors.vec2(1, 1), vectors.vec3(0.294, 1, 1), pos, vectors.vec3(0, 0, 0), math.random() * -30 - 15, 3, models.models.ex_skill_1.StarScale, 33, true, 1)
						end
						sounds:playSound("minecraft:entity.generic.explode", anchorPos, 0.5, 1)
						for _, soundName in ipairs({"minecraft:entity.pillager.hurt", "minecraft:entity.vindicator.hurt"}) do
							sounds:playSound(soundName, playerPos, 0.5, 1)
						end
					elseif tick == 83 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					elseif tick == 93 then
						ModelAlias.alias.avatar.head.EyeShines:setVisible(false)
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED", 45, true)
					elseif tick == 97 then
						ModelAlias.alias.avatar.body.Gun.MuzzleEffect.MuzzleEffect1:setColor(1, 0.659, 0.698)
						for _ = 1, 8 do
							ExSkillSpriteManager:spawn(models.models.ex_skill_1.ExSkill1ParticleAnchor2, vectors.vec2(1, math.random(2, 5)), vectors.vec3(0.294, 1, 1), vectors.vec3(0, 0, 0), vectors.rotateAroundAxis(math.random() * 360, 50, 0, 0, 0, 0, 1), 0, 2, nil, 8, true, 0.80)
						end
						sounds:playSound("minecraft:entity.arrow.shoot", player:getPos(), 1, 2)
					elseif tick == 105 then
						if host:isHost() then
							events.RENDER:register(function (delta)
								models.models.ex_skill_1.Gui.ScreenFilter:setOpacity((ExSkill.animationCount + delta - 1) * -0.333 + 36)
							end, "ex_skill_1_filter_render")
							models.models.ex_skill_1.Gui.ScreenFilter:setScale(client:getScaledWindowSize():augmented(1))
							models.models.ex_skill_1.Gui.ScreenFilter:setVisible(true)
							models.models.ex_skill_1.script_walls:setVisible(false)
							models.models.ex_skill_1.CameraBackground.Background:setVisible(true)
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
							end, "ex_skill_1_background_render")
							if not Armor.isArmorVisible.helmet and not Armor.isArmorVisible.chestplate and not Armor.isArmorVisible.leggings and not Armor.isArmorVisible.boots then
								models.script_ex_skill_1:setVisible(true)
								events.RENDER:register(function (delta)
									local animPos = ModelAlias.alias.avatar.root:getAnimPos()
									local bodyYaw = player:getBodyYaw(delta)
									models.script_ex_skill_1:setPos(animPos:copy():add(vectors.rotateAroundAxis(bodyYaw + 180, player:getPos(delta):add(vectors.rotateAroundAxis(bodyYaw * -1, animPos:copy():scale(0.0625):add(-0.15, 0.8, 0), 0, 1, 0)):sub(client:getCameraPos()):scale(8), 0, 1, 0)))
									models.script_ex_skill_1:setRot(ModelAlias.alias.avatar.root:getAnimRot())
								end, "ex_skill_1_outline_render")
							end
						end
						for _ = 1, 8 do
							ExSkillSpriteManager:spawn(models.models.ex_skill_1.ExSkill1ParticleAnchor2, vectors.vec2(1, math.random(2, 5)), vectors.vec3(1, 1, 0.443), vectors.vec3(0, 0, 0), vectors.rotateAroundAxis(math.random() * 360, 40, 0, 0, 0, 0, 1), 0, 2, nil, 33, true, 0.80)
						end
					elseif tick == 106 then
						ModelAlias.alias.avatar.body.Gun.MuzzleEffect.MuzzleEffect1:setColor(0.557, 0.655, 0.976)
						sounds:playSound("minecraft:entity.generic.explode", player:getPos(), 0.5, 2.5)
					elseif tick == 108 and host:isHost() then
						events.RENDER:remove("ex_skill_1_filter_render")
						models.models.ex_skill_1.Gui.ScreenFilter:setVisible(false)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if host:isHost() then
						for _, eventName in ipairs({"ex_skill_1_outline_render", "ex_skill_1_background_render"}) do
							events.RENDER:remove(eventName)
						end
						for _, modelPart in ipairs({models.script_ex_skill_1, models.models.ex_skill_1.CameraBackground.Background}) do
							modelPart:setVisible(false)
						end
					end
					models.models.ex_skill_1.script_walls:setVisible(false)
					if models.models.ex_skill_1.Illagers.Pillager1.Pillager1RightArm.Letter ~= nil then
						models.models.ex_skill_1.Illagers.Pillager1.Pillager1RightArm.Letter:moveTo(models.models.ex_skill_1)
					end
					renderer:shadowRadius()
					if Gun.currentGunPosition == "NONE" then
						if player:isLeftHanded() then
							ModelAlias.alias.avatar.body.Gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.left))
							ModelAlias.alias.avatar.body.Gun:setRot(self.gun.gunPosition.put.rot.left)
						else
							ModelAlias.alias.avatar.body.Gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.right))
							ModelAlias.alias.avatar.body.Gun:setRot(self.gun.gunPosition.put.rot.right)
						end
					end
					if forcedStop then
						if host:isHost() then
							events.RENDER:remove("ex_skill_1_filter_render")
						end
						for _, modelPart in ipairs({ModelAlias.alias.avatar.head.EyeShines, models.models.ex_skill_1.script_walls_breakable}) do
							modelPart:setVisible(false)
						end
						ExSkillSpriteManager:removeAll()
					else
						local lookDir = player:getLookDir()
						local lookYaw = math.deg(math.atan2(lookDir.z, lookDir.x))
						PlacementObjectManager:spawn(1, player:getPos():add(vectors.rotateAroundAxis(lookYaw * -1 + 90, 0, 1, 3, 0, 1, 0)), lookYaw * -1 + 90)
					end
				end;
			};

			---このExスキルが初期化されたかどうか。
			---@type boolean
			isInitialized = false;
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
				onBeforeModelCopy = function (_)
					ModelAlias.alias.avatar.head.EyeShines:setVisible(false)
				end;

				onPhase1 = function ()
					for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.head.HairTails.HairRight, ModelAlias.alias.dummy_avatar.head.HairTails.HairLeft}) do
						modelPart:setRot(15, 0, 0)
					end
					ModelAlias.alias.dummy_avatar.body.Skirt:setRot(32.5, 0, 0)
				end;

				onPhase2 = function ()
					ModelAlias.alias.dummy_avatar.head.HairTails.HairRight:setRot(-22.5, 0, 0)
					ModelAlias.alias.dummy_avatar.head.HairTails.HairLeft:setRot(-60, 0, 0)
					for i = 1, 2 do
						ModelAlias.alias.dummy_avatar.body.Backpack["BackPackMascot" .. i]:setRot(-17.5, 0, 0)
					end
					ModelAlias.alias.dummy_avatar.body.Backpack.BackPackMascot3:setRot(-17.5, 0, 20)
					ModelAlias.alias.dummy_avatar.body.Skirt:setRot(15, 0, 0)
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
				models = {ModelAlias.alias.avatar.head.HairTails.HairLeft};

				x = {
					vertical = {
						min = -160;
						neutral = -15;
						max = -15;
						headRotMultiplayer = -1;
						sneakOffset = -30;

						headX = {
							multiplayer = -80;
							min = -160;
							max = -15;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -160;
							max = -15;
						};
					};

					horizontal = {
						min = -67.5;
						neutral = -67.5;
						max = -67.5;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairLeft.HairLeftZ};

				z = {
					vertical = {
						min = -92.5;
						neutral = -10;
						max = 87.5;

						headZ = {
							multiplayer = -80;
							min = -92.5;
							max = 87.5;
						};
					};

					horizontal = {
						min = -92.5;
						neutral = -10;
						max = 87.5;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairRight};

				x = {
					vertical = {
						min = -160;
						neutral = -15;
						max = -15;
						headRotMultiplayer = -1;
						sneakOffset = -30;

						headX = {
							multiplayer = -80;
							min = -160;
							max = -15;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -160;
							max = -15;
						};
					};

					horizontal = {
						min = -67.5;
						neutral = -67.5;
						max = -67.5;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairRight.HairRightZ};

				z = {
					vertical = {
						min = -87.5;
						neutral = 10;
						max = 92.5;

						headZ = {
							multiplayer = -80;
							min = -87.5;
							max = 92.5;
						};
					};

					horizontal = {
						min = -87.5;
						neutral = 10;
						max = 92.5;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.BackpackFastener};

				x = {
					vertical = {
						min = -167.5;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -160;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 160;
							min = -167.5;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.1;
							min = -167.5;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.BackpackFastener.BackpackFastenerZ};

				z = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 80;

						headZ = {
							multiplayer = -160;
							min = -80;
							max = 80;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.BackpackFastener.BackpackFastenerZ};

				z = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 80;

						headZ = {
							multiplayer = -160;
							min = -80;
							max = 80;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.BackPackMascot2};

				x = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 80;

						bodyX = {
							multiplayer = -80;
							min = -80;
							max = 80;
						};

						bodyY = {
							multiplayer = 80;
							min = -80;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -80;
							max = 80;
						};
					};

					horizontal = {
						min = -80;
						neutral = 80;
						max = 80;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 80;
						};

						bodyY = {
							multiplayer = 160;
							min = -80;
							max = 80;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.BackPackMascot1};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 0;
					};

					horizontal = {
						min = -80;
						neutral = 80;
						max = 80;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 80;
						};

						bodyY = {
							multiplayer = 80;
							min = -80;
							max = 80;
						};
					};
				};

				z = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 80;

						bodyZ = {
							multiplayer = -80;
							min = -80;
							max = 80;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 80;
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
				models = {ModelAlias.alias.avatar.body.Backpack.BackPackMascot3};

				x = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						bodyX = {
							multiplayer = -40;
							min = -90;
							max = 90;
						};

						bodyRot = {
							multiplayer = 0.025;
							min = -90;
							max = 0;
						};
					};

					horizontal = {
						min = -90;
						neutral = 0;
						max = 90;

						bodyY = {
							multiplayer = 40;
							min = -90;
							max = 90;
						};
					};
				};

				z = {
					vertical = {
						min = 20;
						neutral = 20;
						max = 20;
					};

					horizontal = {
						min = 0;
						neutral = 0;
						max = 0;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.BackPackMascot3.BackPackMascot3Z};

				z = {
					vertical = {
						min = -155;
						neutral = 0;
						max = 60;

						bodyY = {
							multiplayer = 80;
							min = -155;
							max = 0;
						};

						bodyZ = {
							multiplayer = -80;
							min = -110;
							max = 60;
						};
					};

					horizontal = {
						min = -110;
						neutral = 0;
						max = 60;

						bodyZ = {
							multiplayer = -160;
							min = -110;
							max = 60;
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
		---@type Character17a.ExSkillSprite
		ExSkillSprite = require("scripts.ex_skill_sprite")

		---Exスキルで使用するスプライトオブジェクトのマネージャークラス
		---@type Character17a.ExSkillSpriteManager
		ExSkillSpriteManager = require("scripts.ex_skill_sprite_manager")
		ExSkillSpriteManager = ExSkillSpriteManager.new()
	end;
}

return BlueArchiveCharacter
