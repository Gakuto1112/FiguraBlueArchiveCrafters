---右目のテクスチャの列挙型
---@alias Character11b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "ANGRY" # 怒った目
---| "UNEQUAL" # 不等号目
---| "CLOSED2" # 閉じた目2

---左目のテクスチャの列挙型
---@alias Character11b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目
---| "UNEQUAL" # 不等号目
---| "ANGRY" # 怒った目
---| "INVERTED" # 反対側を見る目
---| "CLOSED2" # 閉じた目2

---口のテクスチャの列挙型
---@alias Character11b.MouthTextures
---| "NORMAL" # 通常
---| "ANXIOUS" # への口
---| "OPENED" # 全力の開け口
---| "OPENED_SMALL" # 小さく開いている口
---| "YUMMY" # 舌をペロッとしている口
---| "SMILE" # にっこり
---| "W" # W
---| "SHOCK" # あんぐり口
---| "O" # 丸い口

---@class (exact) Character11b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character11b.RightEyeTextures 右目の表情名
---@field public leftEye Character11b.LeftEyeTextures 左目の表情名
---@field public mouth Character11b.MouthTextures 口の表情名

---@class (exact) Character11b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character11b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character11b.EmotionSet ベッドで寝ているとき

---@class (exact) Character11b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character11b, right: Character11b.RightEyeTextures, left: Character11b.LeftEyeTextures, mouth: Character11b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character11b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character11b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character11b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character11b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character11b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character11b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character11b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character11b.FacePartsStruct 目や口による表情

---@type Character11b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "11b_Ibuki_Swimsuit";

		birth = {
			month = 4;
			day = 14;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CENTER = vectors.vec2(5, 0);
			ANGRY = vectors.vec2(7, 0);
			UNEQUAL = vectors.vec2(9, 0);
			CLOSED2 = vectors.vec2(12, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CENTER = vectors.vec2(5, 0);
			ANGRY_CENTER = vectors.vec2(7, 0);
			UNEQUAL = vectors.vec2(8, 0);
			ANGRY = vectors.vec2(9, 0);
			INVERTED = vectors.vec2(10, 0);
			CLOSED2 = vectors.vec2(11, 0);
		};

		mouth = {
			ANXIOUS = vectors.vec2(0, 0);
			OPENED = vectors.vec2(1, 0);
			OPENED_SMALL = vectors.vec2(2, 0);
			YUMMY = vectors.vec2(3, 0);
			SMILE = vectors.vec2(4, 0);
			W = vectors.vec2(5, 0);
			SHOCK = vectors.vec2(6, 0);
			O = vectors.vec2(7, 0);
		};

		emotionSet = {
			onDamage = {
				rightEye = "UNEQUAL";
				leftEye = "UNEQUAL";
				mouth = "SHOCK";
			};
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (self, right, left)
				if self.costume.isRidingTank then
					if self.costume.tankTick < 21 then
						return {right = "DEFAULT", left = "DEFAULT"}
					else
						return {right = right == "GUN_MAIN_HAND" and "TANK_GUN_MAIN_HAND" or (right == "GUN_OFF_HAND" and "TANK_GUN_OFF_HAND" or (right == "DEFAULT" and "TANK" or right)), left = left == "GUN_MAIN_HAND" and "TANK_GUN_MAIN_HAND" or (left == "GUN_OFF_HAND" and "TANK_GUN_OFF_HAND" or (left == "DEFAULT" and "TANK" or left))}
					end
				end
			end;

			onAdditionalRightArmProcess = function (self, state)
				if state == "TANK" then
					--虎丸搭乗中
					events.TICK:register(function ()
						if self.costume.isRidingTank then
							local isLeftHanded = player:isLeftHanded()
							local activeHand = player:getActiveHand()
							ModelAlias.alias.avatar.rightArm:setRot(player:getActiveItem().id ~= "minecraft:air" and ((activeHand == "MAIN_HAND" and not isLeftHanded) or (activeHand == "OFF_HAND" and isLeftHanded)) and 0 or 52.5, 0, 0)
						end
					end, "right_arm_tick")
				elseif state == "TANK_GUN_MAIN_HAND" then
					--虎丸搭乗中の武器の構え
					events.TICK:remove("right_arm_tick")
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if player:isSwingingArm() and not player:isLeftHanded() and self.costume.shootTick == -1 then
							ModelAlias.alias.avatar.rightArm:setParentType("RightArm")
						else
							ModelAlias.alias.avatar.rightArm:setParentType("Body")
						end
						if player:getActiveItem().id == "minecraft:crossbow" then
							Arms:setArmState("CROSSBOW", "CROSSBOW")
						end
					end, "right_arm_tick")
					events.RENDER:remove("right_arm_render")
					events.RENDER:register(function (delta)
						local lookDir = player:getLookDir()
						local dir = ((math.deg(math.atan2(lookDir.z, lookDir.x)) - 90) % 360 - player:getBodyYaw() % 360) % 360
						dir = dir > 180 and dir - 360 or dir
						local headRot = vanilla_model.HEAD:getOriginRot()
						ModelAlias.alias.avatar.rightArm:setRot((player:isSwingingArm() and not player:isLeftHanded()) and vectors.vec3() or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 90 + (player:isCrouching() and 30 or 0), math.clamp(dir * -1 + 90, -70, 78), 0))
					end, "right_arm_render")
				elseif state == "TANK_GUN_OFF_HAND" then
					--虎丸搭乗中の武器を持っていない手
					events.TICK:remove("right_arm_tick")
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if player:isSwingingArm() and not player:isLeftHanded() and self.costume.shootTick == -1 then
							ModelAlias.alias.avatar.rightArm:setParentType("RightArm")
						else
							ModelAlias.alias.avatar.rightArm:setParentType("Body")
						end
					end, "right_arm_tick")
					events.RENDER:remove("right_arm_render")
					events.RENDER:register(function (delta)
						local lookDir = player:getLookDir()
						local dir = ((math.deg(math.atan2(lookDir.z, lookDir.x)) - 120) % 360 - player:getBodyYaw() % 360) % 360
						dir = dir > 180 and dir - 360 or dir
						local headRot = vanilla_model.HEAD:getOriginRot()
						ModelAlias.alias.avatar.rightArm:setRot((player:isSwingingArm() and player:isLeftHanded()) and vectors.vec3() or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 90 + (player:isCrouching() and 30 or 0), math.clamp(dir * -1 + 90, -70, 78), 0))
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (self, state)
				if state == "TANK" then
					--虎丸搭乗中
					events.TICK:remove("left_arm_tick")
					events.TICK:register(function ()
						if self.costume.isRidingTank then
							local isLeftHanded = player:isLeftHanded()
							local activeHand = player:getActiveHand()
							ModelAlias.alias.avatar.leftArm:setRot(player:getActiveItem().id ~= "minecraft:air" and ((activeHand == "MAIN_HAND" and isLeftHanded) or (activeHand == "OFF_HAND" and not isLeftHanded)) and 0 or 52.5, 0, 0)
						end
					end, "left_arm_tick")
				elseif state == "TANK_GUN_MAIN_HAND" then
					--虎丸搭乗中の武器の構え
					events.TICK:remove("left_arm_tick")
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if player:isSwingingArm() and player:isLeftHanded() and self.costume.shootTick == -1 then
							ModelAlias.alias.avatar.leftArm:setParentType("LeftArm")
						else
							ModelAlias.alias.avatar.leftArm:setParentType("Body")
						end
						if player:getActiveItem().id == "minecraft:crossbow" then
							Arms:setArmState("CROSSBOW", "CROSSBOW")
						end
					end, "left_arm_tick")
					events.RENDER:remove("left_arm_render")
					events.RENDER:register(function (delta)
						local lookDir = player:getLookDir()
						local dir = ((math.deg(math.atan2(lookDir.z, lookDir.x)) - 90) % 360 - player:getBodyYaw() % 360) % 360
						dir = dir > 180 and dir - 360 or dir
						local headRot = vanilla_model.HEAD:getOriginRot()
						ModelAlias.alias.avatar.leftArm:setRot(((player:isSwingingArm() and player:isLeftHanded()) or self.costume.shootTick >= 0) and vectors.vec3() or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 90, math.clamp(dir * -1 + 90, -70, 90), 0))
					end, "left_arm_render")
				elseif state == "TANK_GUN_OFF_HAND" then
					--虎丸搭乗中の武器を持っていない手
					events.TICK:remove("left_arm_tick")
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if player:isSwingingArm() and player:isLeftHanded() and self.costume.shootTick == -1 then
							ModelAlias.alias.avatar.leftArm:setParentType("LeftArm")
						else
							ModelAlias.alias.avatar.leftArm:setParentType("Body")
						end
					end, "left_arm_tick")
					events.RENDER:remove("left_arm_render")
					events.RENDER:register(function (delta)
						local lookDir = player:getLookDir()
						local dir = ((math.deg(math.atan2(lookDir.z, lookDir.x)) - 60) % 360 - player:getBodyYaw() % 360) % 360
						dir = dir > 180 and dir - 360 or dir
						local headRot = vanilla_model.HEAD:getOriginRot()
						ModelAlias.alias.avatar.leftArm:setRot((player:isSwingingArm() and player:isLeftHanded()) and vectors.vec3() or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 90 + (player:isCrouching() and 30 or 0), math.clamp(dir * -1 + 90, -70, 90), 0))
					end, "left_arm_render")
				end
			end;
		};
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-0.5, 1.5, -2);
					left = vectors.vec3(0.5, 1.5, -2);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.75, 0, -4);
					left = vectors.vec3(1.75, 0, -4);
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

			models = {ModelAlias.alias.avatar.leftArmBottom.LeftShellItemAnchor, models.models.ex_skill_1.ShellItemsArea, models.models.ex_skill_1.ShineEffect, ModelAlias.alias.avatar.head.ExSkill1ParticleAnchor1, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-5, -95, 0);
					pos = vectors.vec3(-68, 7, 8);
				};

				fin = {
					rot = vectors.vec3(40, -90, 0);
					pos = vectors.vec3(-45.25, 24.75, 6.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						ModelAlias.alias.avatar.rightArmBottom.RightShellItemAnchor:newItem("ex_skill_1_right_shell")
						ModelAlias.alias.avatar.leftArmBottom.LeftShellItemAnchor:newItem("ex_skill_1_left_shell")

						local shellItems = {}
						for i = 1, 13 do
							local task = models.models.ex_skill_1.ShellItemsArea:newItem("ex_skill_1_shell_" .. i)
							task:setPos(-8, 0, -8)
							task:setScale(0.25, 0.25, 0.25)
							shellItems[i] = task
						end

						shellItems[1]:setPos(52, 0, 16)
						shellItems[1]:setRot(90, 90, 0)
						shellItems[2]:setPos(40, 0, -8)
						shellItems[3]:setPos(36, 0, -18)
						shellItems[4]:setPos(40, 0, -32)
						shellItems[4]:setScale(0.4, 0.4, 0.4)
						shellItems[5]:setPos(32, 0, -50)
						shellItems[5]:setScale(0.4, 0.4, 0.4)
						shellItems[6]:setPos(38, 0, -58)
						shellItems[6]:setScale(0.4, 0.4, 0.4)
						shellItems[7]:setPos(32, 0, -38)
						shellItems[8]:setPos(30, 0, -43)
						shellItems[9]:setPos(34, 0, -45)
						shellItems[10]:setPos(46, 0, -46)
						shellItems[11]:setPos(44, 0, -54)
						shellItems[12]:setPos(40, 0, -39)
						shellItems[13]:setPos(40, 0, -48)

						if host:isHost() then
							self.exSkill.initializeDrawingTransition(self, models.models.ex_skill_1.Gui.Transition)
						end

						self.exSkill.primary.isInitialized = true;
					end

					ModelAlias.alias.avatar.leftArmBottom.LeftShellItemAnchor:getTask("ex_skill_1_left_shell"):setItem("minecraft:nautilus_shell")

					local isHost = host:isHost()
					for i = 1, 13 do
						local shellItem = self.exSkill.getShellItem()

						if i == 1 then
							self.exSkill.primary.shell1Item = shellItem
						end

						local task = models.models.ex_skill_1.ShellItemsArea:getTask("ex_skill_1_shell_" .. i)
						---@cast task ItemTask
						task:setItem(shellItem)
						if i == 1 then
							task:setVisible(true)
						elseif isHost then
							task:setVisible(false)
						end
						task:setRot(90, math.random() * 360, 0)
					end

					FaceParts:setEmotion("NORMAL", "CENTER", "YUMMY", 10, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 10 then
						FaceParts:setEmotion("CENTER", "NORMAL", "YUMMY", 13, true)
					elseif tick == 12 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos():copy():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1 - 100, 3.25, 0, 1, 0, 1, 0)), 1, 3)
					elseif tick == 23 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head)
						local bodyYaw = player:getBodyYaw()
						for _, offset in ipairs({vectors.vec3(-0.6, 0.5, 0), vectors.vec3(-0.5, 0.6, 0)}) do
							particles:newParticle("minecraft:electric_spark", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1 - 100, offset, 0, 1, 0))):setScale(0.5):setVelocity(offset:copy():scale(0.25)):setColor(0.991, 0.952, 0.797):setLifetime(1)
						end

						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 1, 2)

						FaceParts:setEmotion("CLOSED", "CLOSED", "YUMMY", 2, true)
					elseif tick == 25 then
						FaceParts:setEmotion("CENTER", "NORMAL", "OPENED", 8, true)
					elseif tick == 31 then
						local playerPos = player:getPos()
						sounds:playSound("minecraft:entity.egg.throw", playerPos, 1, 2)
						sounds:playSound("minecraft:block.sand.step", playerPos, 1, 0.75)
					elseif tick == 32 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = player:getPos():copy():add(vectors.rotateAroundAxis(bodyYaw * -1 - 100, 0, 0, 2, 0, 1, 0))
						local velocity = vectors.rotateAroundAxis(bodyYaw * -1 - 100, 0, 0, 0.5, 0, 1, 0)
						for _ = 1, 20 do
							particles:newParticle("minecraft:cloud", anchorPos:copy():add(math.random() * 2 - 1, math.random() * 3, math.random() * 2 - 1)):setScale(1.2):setVelocity(velocity):setLifetime(4)
						end
					elseif tick == 33 then
						ModelAlias.alias.avatar.leftArmBottom.LeftShellItemAnchor:setVisible(false)

						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root):copy():add(vectors.rotateAroundAxis(bodyYaw * -1 - 100, 0, 0, 0.75, 0, 1, 0))
						local particleBlock = world.getBlockState(anchorPos:copy():add(0, -1, 0))
						if not particleBlock:isAir() then
							local velocity = vectors.rotateAroundAxis(bodyYaw * -1 - 100, 0, 0, 0.15, 0, 1, 0)
							for i = 0, 35 do
								local offset = vectors.rotateAroundAxis(i * 10, 0, 0, 0.3 + math.random() * 0.2, 0, 1, 0)
								particles:newParticle("minecraft:block " .. particleBlock.id, anchorPos:copy():add(offset)):setVelocity(velocity:copy():add(offset:copy():scale(0.1)))
							end
						end

						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED_SMALL", 17, true)
					elseif tick == 49 then
						ModelAlias.alias.avatar.rightArmBottom.RightShellItemAnchor:setVisible(true)
						ModelAlias.alias.avatar.rightArmBottom.RightShellItemAnchor:getTask("ex_skill_1_right_shell"):setItem(self.exSkill.primary.shell1Item)
					elseif tick == 50 then
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head), 1, 1)

						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 17, true)
					elseif tick == 61 then
						FaceParts:setEmotion("CENTER", "NORMAL", "OPENED", 15, true)
					elseif tick == 62 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos():copy():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, vectors.vec3(-50, 0, 0):scale(0.0625), 0, 1, 0)), 1, 3)
					elseif tick == 76 then
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head), 0.5, 2)

						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 2, true)
					elseif tick == 78 then
						FaceParts:setEmotion("NORMAL", "CENTER", "O", 4, true)
					elseif tick == 82 then
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head), 0.5, 2)

						FaceParts:setEmotion("CLOSED", "CLOSED", "O", 2, true)
					elseif tick == 84 then
						FaceParts:setEmotion("NORMAL", "CENTER", "O", 18, true)
					elseif tick == 101 and host:isHost() then
						for i = 2, 13 do
							models.models.ex_skill_1.ShellItemsArea:getTask("ex_skill_1_shell_" .. i):setVisible(true)
						end
					elseif tick == 102 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "O", 2, true)
					elseif tick == 104 then
						FaceParts:setEmotion("NORMAL", "CENTER", "OPENED", 64, true)
					elseif tick == 118 then
						self.exSkill.primary.emitShellShineParticles(models.models.ex_skill_1.ShellItemsArea:getTask("ex_skill_1_shell_4"))
					elseif tick == 137 then
						self.exSkill.primary.emitShellShineParticles(models.models.ex_skill_1.ShellItemsArea:getTask("ex_skill_1_shell_5"))
					elseif tick == 151 then
						self.exSkill.primary.emitShellShineParticles(models.models.ex_skill_1.ShellItemsArea:getTask("ex_skill_1_shell_6"))
					elseif tick == 167 then
						ModelAlias.alias.avatar.leftArmBottom.LeftShellItemAnchor:setVisible(true)
						for _, shellItemData in ipairs({{ModelAlias.alias.avatar.rightArmBottom.RightShellItemAnchor, "ex_skill_1_right_shell"}, {ModelAlias.alias.avatar.leftArmBottom.LeftShellItemAnchor, "ex_skill_1_left_shell"}}) do
							shellItemData[1]:getTask(shellItemData[2]):setItem(self.exSkill.getShellItem())
						end

						if host:isHost() then
							for i = 1, 13 do
								models.models.ex_skill_1.ShellItemsArea:getTask("ex_skill_1_shell_" .. i):setVisible(false)
							end
						end
					elseif tick == 168 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "W", 11, true)
					elseif tick == 179 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.ExSkill1ParticleAnchor1)
						local bodyYaw = player:getBodyYaw()
						for i = 0, 11 do
							local dirVec = vectors.rotateAroundAxis(bodyYaw * -1 + 90, vectors.rotateAroundAxis(32.5, vectors.rotateAroundAxis(i * 30, 0, 0.15, 0, 0, 0, 1), 1, 0, 0), 0, 1, 0)
							particles:newParticle("minecraft:end_rod", anchorPos):setVelocity(dirVec)
						end
						for i = 0, 5 do
							---@diagnostic disable-next-line: missing-parameter
							ExSkillSpriteManager:spawn(ModelAlias.alias.avatar.head.ExSkill1ParticleAnchor1, vectors.vec3(0, 0, 0), vectors.rotateAroundAxis(i * 60, 0, 50, 0, 0, 0, 1), math.random() * 60 + 60, 8, nil, 32, true, 0.85)
						end

						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 1)

						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 32, true)
					elseif tick == 183 and host:isHost() then
						self.exSkill.resetDrawingTransition()
					end

					if tick >= 62 and tick < 92 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = player:getPos():copy():add(vectors.rotateAroundAxis(bodyYaw * -1, -2, 0, 0.5, 0, 1, 0))
						for _ = 1, 8 do
							local offset = vectors.vec3(math.random() - 0.5, math.random(), math.random() - 0.5)
							particles:newParticle("minecraft:firework", anchorPos:copy():add(offset:copy():scale(0.5))):setScale(0.5):setVelocity(offset:copy():scale(0.1)):setGravity(0):setColor(0.841, 0.986, 0.999):setLifetime(10)
						end
					elseif tick >= 101 and tick < 167 then
						local anchorPos = player:getPos()
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 5 do
							particles:newParticle("minecraft:firework", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, vectors.vec3(math.random() * 25 - 50, 0.5, math.random() * 75):scale(0.0625 * 0.9375), 0, 1, 0))):setScale(0.1):setGravity(0)
						end
					end

					if tick >= 62 and tick < 167 then
						if self.exSkill.primary.nextShineSound == 0 then
							sounds:playSound("minecraft:block.amethyst_block.resonate", ModelUtils.getModelWorldPos(models.models.main.CameraAnchor), 1, 2)
							self.exSkill.primary.nextShineSound = math.random(4, 8)
						else
							self.exSkill.primary.nextShineSound = self.exSkill.primary.nextShineSound - 1
						end
					end

					if host:isHost() then
						if tick >= 148 and tick < 164 then
							local brushPos = models.models.ex_skill_1.Gui.Transition.TransitionBrush:getAnimPos():copy():scale(-1, -1, 0):add(0.5, 0.5, 0):scale(32):floor()
							local brushColor = vectors.vec3(0.993, 0.989, 0.671):add(vectors.vec3(0.007, 0.011, 0.329):scale(math.clamp((tick - 148) / 16, 0, 1)))
							self.exSkill.fillCircle(textures["ex_skill_drawing_transition"], brushPos.x, brushPos.y, 7, vectors.vec4(brushColor.x, brushColor.y, brushColor.z, 1))
							textures["ex_skill_drawing_transition"]:update()
						elseif tick >= 167 and tick < 183 then
							local brushPos = models.models.ex_skill_1.Gui.Transition.TransitionBrush:getAnimPos():copy():scale(-1, -1, 0):add(0.5, 0.5, 0):scale(32):floor()
							self.exSkill.fillCircle(textures["ex_skill_drawing_transition"], brushPos.x, brushPos.y, 7, vectors.vec4(0, 0, 0, 0))
							textures["ex_skill_drawing_transition"]:update()
						end
					end

					if tick >= 148 and tick < 164 and (tick - 148) % 2 == 0 and host:isHost() then
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(models.models.main.CameraAnchor), 1, 0.0625 * tick - 8.25)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					ModelAlias.alias.avatar.rightArmBottom.RightShellItemAnchor:setVisible(false)

					if forcedStop and host:isHost() then
						self.exSkill.resetDrawingTransition()
					end
				end;
			};

			---貝殻のキラリパーティクルとサウンドを再生する。
			---@param task ItemTask 貝殻アイテムのタスク
			emitShellShineParticles = function (task)
				local taskPos = task:getPos()
				local anchorPos = player:getPos():copy():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, taskPos:copy():scale(-0.0625 * 0.9375), 0, 1, 0))

				for i = 0, 17 do
					particles:newParticle("minecraft:end_rod", anchorPos):setScale(0.5):setVelocity(vectors.rotateAroundAxis(i * 20, 0, 0, 0.05, 0, 1, 0)):setGravity(0):setColor(0.990, 0.946, 0.571):setLifetime(8)
				end

				for i = 0, 7 do
					---@diagnostic disable-next-line: missing-parameter
					ExSkillSpriteManager:spawn(models.models.ex_skill_1.ShellItemsArea, taskPos:copy():add(0, 0.25, 0), vectors.rotateAroundAxis(i * 45, 30, 0, 0, 0, 1, 0), 0, 2, nil, 40, true, 0.7)
				end

				sounds:playSound("minecraft:entity.experience_orb.pickup", anchorPos, 1, math.random() + 2)
			end;

			---このExスキルの初期化処理が行われたかどうか。
			---@type boolean
			isInitialized = false;

			---Exスキルアニメーション中にイブキが拾うアイテムのID
			---@type Minecraft.itemID
			shell1Item = "minecraft:nautilus_shell";

			---Exスキル中に再生するキラキラサウンドの次の再生タイミング（ティック）
			---@type integer
			nextShineSound = 0;
		};

		secondary = {
			formationType = "SPECIAL";

			models = {ModelAlias.alias.avatar.body.HeldShells, models.models.ex_skill_2.ShellFlower, models.models.ex_skill_2.WavePanel, models.models.ex_skill_2.CarpetArea, models.models.ex_skill_2.Gui};

			animations = {"main", "ex_skill_2"};

			camera = {
				start = {
					rot = vectors.vec3(0, 90, 0);
					pos = vectors.vec3(-19, 32, -20);
				};

				fin = {
					rot = vectors.vec3(90, -160, 0);
					pos = vectors.vec3(-13, 25.5, 7.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.isInitialized then
						for _, modelPart in ipairs(ModelAlias.alias.avatar.body.HeldShells:getChildren()) do
							modelPart:newItem(modelPart:getName() .. "_item")
						end

						for _, modelPart in ipairs(models.models.ex_skill_2.ShellFlower:getChildren()) do
							local modelName = modelPart:getName()

							if modelName == "HornCoral" then
								modelPart.HornCoralInner:newItem("HornCoral_item"):setItem("minecraft:horn_coral")
							elseif modelName ~= "FlowerDrawing" then
								local item = modelPart:newItem(modelName .. "_item"):setItem("minecraft:" .. modelName:match("[%u%l]+"):gsub("(%l)(%u)", "%1_%2"):lower())
								if modelName:match("HornCoral%d") ~= nil then
									item:setPos(0, 20, 0)
								elseif modelName:match("NautilusShell") ~= nil then
									item:setPos(0, 8, 0)
								end
							end
						end

						for y = 0, 3 do
							for x = 0, 2 do
								models.models.ex_skill_2.CarpetArea:newBlock("ex_skill_2_carpet_" .. (y * 3 + x + 1)):setBlock("minecraft:white_carpet"):setPos(x * 16, 0, y * 16)
							end
						end

						local shellItems = {}
						for i = 1, 5 do
							local task = models.models.ex_skill_2.ShellFlower:newItem("ex_skill_2_shell_" .. i)
							task:setPos(-8, 0, -8)
							task:setScale(0.4, 0.4, 0.4)
							shellItems[i] = task
						end

						shellItems[1]:setPos(-8, 1, 12)
						shellItems[2]:setPos(-8, 1, -16)
						shellItems[3]:setPos(4, 0, 16)
						shellItems[4]:setPos(14, 0, 0)
						shellItems[5]:setPos(13, 0, -6)

						if host:isHost() then
							self.exSkill.initializeDrawingTransition(self, models.models.ex_skill_2.Gui.Transition)
						end

						self.isInitialized = true
					end;

					if host:isHost() then
						events.RENDER:register(function ()
							models.models.ex_skill_2.Gui.Transition.TransitionBackground:setOpacity(models.models.ex_skill_2.Gui.Transition.TransitionOpacity:getAnimScale().x)
						end, "ex_skill_2_render")

						local windowSize = client:getScaledWindowSize()
						models.models.ex_skill_2.Gui.SunshineBeams:setScale(math.max(windowSize.x, windowSize.y) * 1.33)
					end

					for _, modelPart in ipairs({ModelAlias.alias.avatar.rightLegBottom, ModelAlias.alias.avatar.leftLegBottom}) do
						modelPart:setOffsetPivot(0, 0, -2)
					end;

					for _, modelPart in ipairs(ModelAlias.alias.avatar.body.HeldShells:getChildren()) do
						modelPart:getTask(modelPart:getName() .. "_item"):setItem(self.exSkill.getShellItem())
					end

					for i = 1, 5 do
						local task = models.models.ex_skill_2.ShellFlower:getTask("ex_skill_2_shell_" .. i)
						---@cast task ItemTask
						task:setItem(self.exSkill.getShellItem())
						task:setRot(90, math.random() * 360, 0)
					end

					FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 55, true)

					sounds:playSound("minecraft:entity.egg.throw", player:getPos(), 1, 2)
				end;

				onAnimationTick = function (self, tick)
					if tick == 1 or tick == 31 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.WavePanel)
						sounds:playSound("minecraft:item.bucket.empty", anchorPos, 1, 0.25)
						sounds:playSound("minecraft:item.bucket.empty", anchorPos, 1, 0.5)
					elseif tick == 28 then
						sounds:playSound("minecraft:entity.egg.throw", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 2)
					elseif tick == 55 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", 12, true)
					elseif tick == 67 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", 2, true)

						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.5, 2)
					elseif tick == 69 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", 2, true)
					elseif tick == 71 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", 2, true)

						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.5, 2)
					elseif tick == 63 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", 12, true)
					elseif tick == 68 and host:isHost() then
						self.exSkill.resetDrawingTransition()
					elseif tick == 75 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SMILE", 4, true)
					elseif tick == 76 then
						ModelAlias.alias.avatar.body.HeldShells:moveTo(models.models.main)

						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 1)
					elseif tick == 79 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED", 16, true)
					elseif tick == 93 then
						sounds:playSound("minecraft:entity.player.splash.high_speed", ModelUtils.getModelWorldPos(models.models.ex_skill_2.ShellFlower.HornCoral), 0.5, 0.5)
					elseif tick == 95 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "W", 4, true)
					elseif tick == 99 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "W", 10, true)
					elseif tick == 109 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED_SMALL", 110, true)
					elseif tick == 178 then
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(models.models.ex_skill_2.ShellFlower.HornCoral), 0.5, 1.5)
					elseif tick == 190 and host:isHost() then
						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 3)
					elseif tick == 219 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "W", 30, true)
					end

					if tick >= 37 and tick < 51 and (tick - 37) % 2 == 0 and host:isHost() then
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(models.models.main.CameraAnchor), 1, 0.071 * tick - 1.6429)
					end

					if tick >= 111 and tick < 180 then
						particles:newParticle("minecraft:end_rod", ModelUtils.getModelWorldPos(models.models.ex_skill_2.ShellFlower.HornCoral):add(math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125)):setScale(0.25):setColor(0.994, 0.967, 0.753):setGravity(0)
					end

					if host:isHost() then
						if tick >= 37 and tick < 51 then
							local brushPos = models.models.ex_skill_2.Gui.Transition.TransitionBrush:getAnimPos():copy():mul(-1, -1, 1):add(0.5, 0.5, 0):scale(32):floor()
							local brushColor = vectors.vec3(0.75, 1, 1):add(vectors.vec3(0.25, 0, 0):scale(math.clamp((tick - 37) / 14, 0, 1)))
							self.exSkill.fillCircle(textures["ex_skill_drawing_transition"], brushPos.x, brushPos.y, 9, vectors.vec4(brushColor.x, brushColor.y, brushColor.z, 1))
							textures["ex_skill_drawing_transition"]:update()
						elseif tick >= 54 and tick < 68 then
							local brushPos = models.models.ex_skill_2.Gui.Transition.TransitionBrush:getAnimPos():copy():mul(-1, -1, 1):add(0.5, 0.5, 0):scale(32):floor()
							self.exSkill.fillCircle(textures["ex_skill_drawing_transition"], brushPos.x, brushPos.y, 9, vectors.vec4(0, 0, 0, 0))
							textures["ex_skill_drawing_transition"]:update()
						end
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_2_render")
						if forcedStop then
							self.exSkill.resetDrawingTransition()
						end
					end

					for _, modelPart in ipairs({ModelAlias.alias.avatar.rightLegBottom, ModelAlias.alias.avatar.leftLegBottom}) do
						modelPart:setOffsetPivot()
					end;

					if models.models.main.HeldShells ~= nil then
						models.models.main.HeldShells:moveTo(ModelAlias.alias.avatar.body)
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか。
			---@type boolean
			isInitialized = false;
		};

		---貝殻としてのアイテムのIDをランダムで返す。
		---@return Minecraft.itemID 貝殻としてのアイテムのID
		getShellItem = function ()
			local itemTable = {"minecraft:tube_coral", "minecraft:brain_coral", "minecraft:bubble_coral", "minecraft:fire_coral", "minecraft:horn_coral", "minecraft:prismarine_shard", "minecraft:prismarine_crystals", "minecraft:heart_of_the_sea"}
			local weightTable = {10, 10, 10, 10, 10, 5, 5, 1}

			local totalWeight = 0
			for _, weight in ipairs(weightTable) do
				totalWeight = totalWeight + weight
			end

			local randomWeight = math.random() * totalWeight
			local cumulativeWeight = 0
			for i, weight in ipairs(weightTable) do
				cumulativeWeight = cumulativeWeight + weight
				if randomWeight <= cumulativeWeight then
					return itemTable[i]
				end
			end

			return itemTable[#itemTable]
		end;

		---Exスキルの落書きトランジションを初期化する。
		---@param self Character11b
		---@param target ModelPart 初期化対象の落書きトランジションのモデル
		initializeDrawingTransition = function (self, target)
			local windowSize = client:getScaledWindowSize()
			target:setPos(windowSize.x / 2 * -1, windowSize.y / 2 * -1, 0)
			target:setScale(vectors.vec2(1, 1):scale(math.max(windowSize.x, windowSize.y)):augmented(1))
			local texture = textures["ex_skill_drawing_transition"]
			if texture == nil then
				texture = textures:newTexture("ex_skill_drawing_transition", 32, 32)
				self.exSkill.resetDrawingTransition()
			end
			target.Transition:setPrimaryTexture("CUSTOM", texture)
		end;

		---Exスキルの落書きトランジションをリセットする。
		resetDrawingTransition = function ()
			local dimensions = textures["ex_skill_drawing_transition"]:getDimensions()
			textures["ex_skill_drawing_transition"]:fill(0, 0, dimensions.x, dimensions.y, 0, 0, 0, 0)
			textures["ex_skill_drawing_transition"]:update()
		end;

		---テクスチャに塗り潰し円を描画する。
		---@param texture Texture 描画対象のテクスチャ
		---@param centerX number 円の中心X座標
		---@param centerY number 円の中心Y座標
		---@param radius number 円の半径
		---@param color Vector4 塗り潰す色（RGBA）
		fillCircle = function (texture, centerX, centerY, radius, color)
			local dimensions = texture:getDimensions()
			for y = math.max(centerY - radius, 0), math.min(centerY + radius, dimensions.y - 1) do
				for x = math.max(centerX - radius, 0), math.min(centerX + radius, dimensions.x - 1) do
					local dx = x - centerX
					local dy = y - centerY
					if dx * dx + dy * dy <= radius * radius then
						texture:setPixel(x, y, color.x, color.y, color.z, color.w)
					end
				end
			end
		end;
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "HELMET" then
					if isVisible or not self.costume.isRidingTank then
						ModelAlias.alias.avatar.head.StrawHat:setVisible(false)
						for _, modelPart in ipairs({ModelAlias.alias.avatar.head.Cowlick, ModelAlias.alias.avatar.head.Horns}) do
							modelPart:setVisible(true)
						end
					else
						ModelAlias.alias.avatar.head.StrawHat:setVisible(true)
						for _, modelPart in ipairs({ModelAlias.alias.avatar.head.Cowlick, ModelAlias.alias.avatar.head.Horns}) do
							modelPart:setVisible(false)
						end
					end
				elseif parts == "CHEST_PLATE" then
					if isVisible then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FrontHair, ModelAlias.alias.avatar.body.Pendant.PendantRotatable}) do
							modelPart:setPos(0, 0, -1)
						end
					else
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FrontHair, ModelAlias.alias.avatar.body.Pendant.PendantRotatable}) do
							modelPart:setPos()
						end
					end
				end
			end;
		};

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

		---砲弾を撃つ際のティックカウンター
		---@type integer
		shootTick = -1;

		---前ティックに虎丸が爆散したかどうか
		---@type boolean
		isTankDiedPrev = false;
	};

	bubble = {
		callbacks = {
			onPlay = function (self, type, duration, showInGui)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", self.costume.isRidingTank and "INVERTED" or "NORMAL", "OPENED", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("CLOSED", "CLOSED", "W", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", self.costume.isRidingTank and "INVERTED" or "NORMAL", "ANXIOUS", duration, true)
				elseif type == "SWEAT" then
					if showInGui then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SHOCK", duration, true)
					else
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SHOCK", 60, true)
					end
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
				ModelAlias.alias.avatar.root:setVisible(true)
				ModelAlias.alias.avatar.root:setPos()
				for _, modelPart in ipairs({ModelAlias.alias.avatar.root, ModelAlias.alias.avatar.head, ModelAlias.alias.avatar.rightArmBottom.RightSleeve, ModelAlias.alias.avatar.leftArmBottom.LeftSleeve}) do
					modelPart:setRot()
				end
				ModelAlias.alias.avatar.lowerBody:setVisible(true)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.rightLegBottom:setOffsetPivot(0, 0, -2)
			end
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
						min = 10;
						neutral = 50;
						max = 90;

						headX = {
							multiplayer = 40;
							min = 10;
							max = 90;
						};

						bodyY = {
							multiplayer = -40;
							min = 10;
							max = 90;
						};
					};

					horizontal = {
						min = 10;
						neutral = 50;
						max = 90;

						bodyX = {
							multiplayer = -80;
							min = 10;
							max = 90;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.FrontHair};

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
				models = {ModelAlias.alias.avatar.body.Pendant.PendantRotatable};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 110;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -40;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -40;
							min = 0;
							max = 110;
						};

						bodyRot = {
							multiplayer = -0.025;
							min = 0;
							max = 110;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
						max = 110;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 110;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Pendant.PendantRotatable.PendantLine3};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 90;
						sneakOffset = 0;

						bodyX = {
							multiplayer = -20;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -20;
							min = 0;
							max = 90;
						};

						bodyRot = {
							multiplayer = -0.0125;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = -90;
						neutral = 0;
						max = 90;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = 90;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.TailXPivot};
				x = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;
						sneakOffset = 15;

						bodyY = {
							multiplayer = 40;
							min = -40;
							max = 40;
						};
					};

					horizontal = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyX = {
							multiplayer = 40;
							min = -40;
							max = 40;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.TailXPivot.TailYPivot};

				y = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyZ = {
							multiplayer = -80;
							min = -40;
							max = 40;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function (self)
		---Exスキルで使用するスプライトオブジェクトのインスタンスクラス
		---@type Character11b.ExSkillSprite
		ExSkillSprite = require("scripts.ex_skill_sprite")

		---Exスキルで使用するスプライトオブジェクトのマネージャークラス
		---@type Character11b.ExSkillSpriteManager
		ExSkillSpriteManager = require("scripts.ex_skill_sprite_manager")
		ExSkillSpriteManager = ExSkillSpriteManager.new()

        events.TICK:register(function ()
            if not client:isPaused() then
                local vehicle = player:getVehicle()
                self.costume.isRidingTank = false
                if vehicle ~= nil then
                    local passengers = vehicle:getPassengers()
                    local irohaUUID = passengers[1]:getUUID()
                    local avatarVars = world.avatarVars()
                    self.costume.isRidingTank = vehicle:getType() == "minecraft:camel" and passengers[1]:hasAvatar() and avatarVars[irohaUUID].FBAC_Iroha ~= nil and avatarVars[irohaUUID].shouldReplaceVehicleModels
                end
                if self.costume.isRidingTank ~= self.costume.isRidingTankPrev then
                    if self.costume.isRidingTank then
						if not Armor.isArmorVisible.helmet then
							ModelAlias.alias.avatar.head.StrawHat:setVisible(true)
							for _, modelPart in ipairs({ModelAlias.alias.avatar.head.Cowlick, ModelAlias.alias.avatar.head.Horns}) do
								modelPart:setVisible(false)
							end
						end
                        Arms:setArmState("DEFAULT", "DEFAULT")
                        FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED", 21, true)
                        animations["models.main"].tank_start:play()

                        events.TICK:register(function ()
                            if not client:isPaused() and self.costume.isRidingTank then
                                if FaceParts.blinkCount == 0 and FaceParts.emotionCount == 0 and self.costume.shootTick == -1 and not self.costume.isTankDied then
                                    FaceParts:setEmotion("CLOSED", "CLOSED", "W", 2, true)
                                else
                                    FaceParts:setEmotion("NORMAL", "INVERTED", "W", 1)
                                end
                                local irohaUUID = vehicle:getPassengers()[1]:getUUID()
                                local avatarVars = world.avatarVars()
                                local isEngineActive = avatarVars[irohaUUID].isEngineActive and self.costume.tankTick >= 1
                                if isEngineActive ~= self.costume.isEngineActivePrev then
                                    if isEngineActive then
                                        animations["models.main"].tank_idle_powered:play()
                                        animations["models.main"].tank_idle_powered:setTime(avatarVars[irohaUUID].engineAnimTime)
                                    else
                                        animations["models.main"].tank_idle_powered:stop()
                                    end
                                end
                                if self.costume.tankTick == 1 then
                                    for i = 0, 6 do
										---@diagnostic disable-next-line: missing-parameter
                                        ExSkillSpriteManager:spawn(ModelAlias.alias.avatar.head.SpriteArea, vectors.vec3(), vectors.rotateAroundAxis(i * -30, -100, 0, 0, 0, 0, 1), 0, 6, nil, 14, false, 0.7)
                                    end
                                    sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 0.5, 1.5)
                                elseif self.costume.tankTick == 21 then
                                    ModelAlias.alias.avatar.head:setRot(0, 65, 0)
                                    if Gun.currentGunPosition == "RIGHT" then
                                        Arms:setArmState("TANK_GUN_MAIN_HAND", "TANK_GUN_OFF_HAND")
                                    elseif Gun.currentGunPosition == "LEFT" then
                                        Arms:setArmState("TANK_GUN_OFF_HAND", "TANK_GUN_MAIN_HAND")
                                    else
                                        Arms:setArmState("TANK", "TANK")
                                    end
                                end
                                if avatarVars[irohaUUID].shootingStart then
                                    animations["models.main"].tank_shoot:play()
                                    Arms:setArmState("DEFAULT", "DEFAULT")
                                    FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED", 36, true)
                                    self.costume.shootTick = 0
                                elseif self.costume.shootTick == 36 then
                                    if Gun.currentGunPosition == "RIGHT" then
                                        Arms:setArmState("TANK_GUN_MAIN_HAND", "TANK_GUN_OFF_HAND")
                                    elseif Gun.currentGunPosition == "LEFT" then
                                        Arms:setArmState("TANK_GUN_OFF_HAND", "TANK_GUN_MAIN_HAND")
                                    else
                                        Arms:setArmState("TANK", "TANK")
                                    end
                                    self.costume.shootTick = -1
                                end
                                local isTankDied = avatarVars[irohaUUID].isTankDied
                                if isTankDied and not self.costume.isTankDiedPrev then
                                    Bubble:play("SWEAT", 40, false)
                                end
                                self.costume.tankTick = self.costume.tankTick + 1
                                self.costume.isEngineActivePrev = isEngineActive
                                self.costume.shootTick = self.costume.shootTick >= 0 and self.costume.shootTick + 1 or -1
                                self.costume.isTankDiedPrev = isTankDied
                            end
                        end, "tank_tick")

                        events.RENDER:register(function (delta, context)
                            if not client:isPaused() and self.costume.isRidingTank then
                                local bodyYaw = player:getBodyYaw(delta)
                                local heightOffset = (player:getPos(delta):sub(vehicle:getPos(delta)):length() - 1.51017) * -1.35 - 0.1
                                if context == "MINECRAFT_GUI" or context == "FIGURA_GUI" or context == "PAPERDOLL" or context == "FIRST_PERSON" then
                                    ModelAlias.alias.avatar.root:setParentType("None")
                                    ModelAlias.alias.avatar.root:setPos()
                                    ModelAlias.alias.avatar.root:setRot()
                                    ModelAlias.alias.avatar.lowerBody:setVisible(true)
                                else
                                    ModelAlias.alias.avatar.root:setParentType("WORLD")
                                    ModelAlias.alias.avatar.root:setPos(vectors.rotateAroundAxis(bodyYaw * -1, -0.85, 0.7 + heightOffset, 1.1, 0, 1, 0):add(player:getPos(delta)):scale(16))
                                    ModelAlias.alias.avatar.root:setRot(0, bodyYaw * -1 + 90, 0)
                                    ModelAlias.alias.avatar.lowerBody:setVisible(false)
                                end
                                local animOffset = vectors.rotateAroundAxis(bodyYaw * -1, 0, models.models.main.TankIdleAnimAnchor:getAnimPos().y, models.models.main.TankShootAnimAnchor:getAnimPos().z * -1, 0, 1, 0):scale(0.0625)
                                if renderer:isFirstPerson() then
                                    CameraManager.setCameraPivot(vectors.rotateAroundAxis(bodyYaw * -1, -0.85, heightOffset + 0.8, 1.1, 0, 1, 0):add(animOffset))
                                    renderer:setEyeOffset(vectors.rotateAroundAxis(bodyYaw * -1, -0.85, heightOffset + 0.8, 1.1, 0, 1, 0):add(animOffset))
                                else
                                    CameraManager.setCameraPivot(vectors.rotateAroundAxis(bodyYaw * -1, -0.85, heightOffset + 0.75, 1.1, 0, 1, 0):add(animOffset))
                                    renderer:setEyeOffset(vectors.rotateAroundAxis(bodyYaw * -1, -0.85, 1, 1.1 + heightOffset, 0, 1, 0):add(animOffset))
                                end
                                if self.costume.shootTick >= 0 then
                                    ModelAlias.alias.avatar.root:setPos(vectors.rotateAroundAxis(bodyYaw * -1 + 180, models.models.main.TankShootAnimAnchor:getAnimPos(), 0, 1, 0):add(ModelAlias.alias.avatar.root:getPos()))
                                end
                            end
                        end, "tank_render")
                    else
                        events.TICK:remove("tank_tick")
                        events.RENDER:remove("tank_render")
						for _, modelPart in ipairs({ModelAlias.alias.avatar.root, ModelAlias.alias.avatar.lowerBody}) do
							modelPart:setVisible(true)
						end
                        ModelAlias.alias.avatar.root:setParentType("None")
                        ModelAlias.alias.avatar.root:setPos()
                        for _, modelPart in ipairs({ModelAlias.alias.avatar.root, ModelAlias.alias.avatar.head}) do
                            modelPart:setRot()
                        end
						ModelAlias.alias.avatar.head.Horns:setVisible(false)
                        for _, animName in ipairs({"tank_start", "tank_idle_powered"}) do
                            animations["models.main"][animName]:stop()
                        end
                        CameraManager.setCameraPivot()
                        renderer:setEyeOffset()
                        if Gun.currentGunPosition == "RIGHT" then
                            Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
                        elseif Gun.currentGunPosition == "LEFT" then
                            Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
                        else
                            Arms:setArmState("DEFAULT", "DEFAULT")
                        end
                        self.costume.tankTick = 0
                        self.costume.shootTick = -1
                        self.costume.isTankDiedPrev = false
                    end
                end
                self.costume.isRidingTankPrev = self.costume.isRidingTank
            end
        end)

        events.RENDER:register(function ()
            local wingRotOffset = math.map(vanilla_model.RIGHT_LEG:getOriginRot().x, -90, 90, 20, 0)
            ModelAlias.alias.avatar.body.Wings.RightWing:setRot(0, -20 - wingRotOffset, 0)
            ModelAlias.alias.avatar.body.Wings.LeftWing:setRot(0, 20 + wingRotOffset, 0)
        end)

        avatar:store("FBAC_Ibuki", true)
	end;
}

return BlueArchiveCharacter
