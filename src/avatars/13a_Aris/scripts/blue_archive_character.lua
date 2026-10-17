---右目のテクスチャの列挙型
---@alias Character13a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "NARROW" # 少し閉じた目
---| "CLOSED2" # 閉じた目2
---| "STARE" # 凝視目（Exスキル1の最後の目）
---| "ANGRY" # 怒った目
---| "TEAR" # 涙目
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目
---| "ANGRY_NARROW" # 怒りつつ少し閉じた目

---左目のテクスチャの列挙型
---@alias Character13a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "NARROW" # 少し閉じた目
---| "CLOSED2" # 閉じた目2
---| "STARE" # 凝視目（Exスキル1の最後の目）
---| "CENTER" # 少し反対側を見る目
---| "ANGRY" # 怒った目
---| "TEAR" # 涙目
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目
---| "ANGRY_NARROW" # 怒りつつ少し閉じた目

---口のテクスチャの列挙型
---@alias Character13a.MouthTextures
---| "NORMAL" # 通常
---| "CLOSED" # 閉じた口
---| "SMILE" # にっこり
---| "SMALL" # 小さく開いた口
---| "OPENED" # 開いた口
---| "ANGRY" # への口
---| "SHOCK" # あんぐり口
---| "BRAVE" # 勇ましい口
---| "TEETH" # 食いしばる口

---キャラクター固有の腕の状態
---@alias Character13a.AdditionalArmState
---| "RAIL_GUN_MAIN_HAND" # レールガンを構えている際の、武器を構えている方の腕
---| "RAIL_GUN_OFF_HAND" # レールガンを構えている際の、武器を構えていない方の腕

---@class (exact) Character13a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character13a.RightEyeTextures 右目の表情名
---@field public leftEye Character13a.LeftEyeTextures 左目の表情名
---@field public mouth Character13a.MouthTextures 口の表情名

---@class (exact) Character13a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character13a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character13a.EmotionSet ベッドで寝ているとき

---@class (exact) Character13a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character13a, right: Character13a.RightEyeTextures, left: Character13a.LeftEyeTextures, mouth: Character13a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character13a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character13a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character13a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character13a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character13a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character13a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character13a.ArmsCallbacksSet : BlueArchiveCharacter.ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(self: Character13a, right: Arms.BaseArmState|Character13a.AdditionalArmState, left: Arms.BaseArmState|Character13a.AdditionalArmState): {right?: Arms.BaseArmState|Character13a.AdditionalArmState, left?: Arms.BaseArmState|Character13a.AdditionalArmState}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(self: Character13a, state: Arms.BaseArmState|Character13a.AdditionalArmState): boolean? 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: Character13a, state: Arms.BaseArmState|Character13a.AdditionalArmState): boolean? 左腕の追加処理

---@class (exact) Character13a.ArmsStruct : BlueArchiveCharacter.ArmsStruct 腕のデータ構造体
---@field public callbacks? Character13a.ArmsCallbacksSet 腕の制御のコールバック関数群

---@class (exact) Character13a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character13a.FacePartsStruct 目や口による表情
---@field public arms Character13a.ArmsStruct 腕

---@type Character13a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "13a_Aris";

		birth = {
			month = 3;
			day = 25;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			NARROW = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(7, 0);
			STARE = vectors.vec2(8, 0);
			ANGRY = vectors.vec2(10, 0);
			TEAR = vectors.vec2(12, 0);
			ANGRY_CENTER = vectors.vec2(14, 0);
			ANGRY_NARROW = vectors.vec2(15, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			NARROW = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(6, 0);
			STARE = vectors.vec2(7, 0);
			CENTER = vectors.vec2(8, 0);
			ANGRY = vectors.vec2(10, 0);
			TEAR = vectors.vec2(11, 0);
			ANGRY_CENTER = vectors.vec2(12, 0);
			ANGRY_NARROW = vectors.vec2(15, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(0, 0);
			SMILE = vectors.vec2(1, 0);
			SMALL =  vectors.vec2(2, 0);
			OPENED = vectors.vec2(3, 0);
			ANGRY = vectors.vec2(4, 0);
			SHOCK = vectors.vec2(5, 0);
			BRAVE = vectors.vec2(6, 0);
			TEETH = vectors.vec2(7, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				local result = {right = right, left = left}
				if right == "GUN_MAIN_HAND" then
					result.right = "RAIL_GUN_MAIN_HAND"
				elseif right == "GUN_OFF_HAND" then
					result.right = "RAIL_GUN_OFF_HAND"
				elseif right == "CROSSBOW" and Gun.currentGunPosition == "RIGHT" then
					result.right = "RAIL_GUN_MAIN_HAND"
				end

				if left == "GUN_MAIN_HAND" then
					result.left = "RAIL_GUN_MAIN_HAND"
				elseif left == "GUN_OFF_HAND" then
					result.left = "RAIL_GUN_OFF_HAND"
				elseif left == "CROSSBOW" and Gun.currentGunPosition == "LEFT" then
					result.left = "RAIL_GUN_MAIN_HAND"
				end

				return result
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "RAIL_GUN_MAIN_HAND" then
					events.TICK:register(function ()
						if Arms.armState.right == "RAIL_GUN_MAIN_HAND" then
							Arms:processArmSwingCount()
							if player:isSwingingArm() and not player:isLeftHanded() then
								ModelAlias.alias.avatar.rightArm:setParentType("RightArm")
							else
								ModelAlias.alias.avatar.rightArm:setParentType("Body")
							end
							if player:getActiveItem().id == "minecraft:crossbow" then
								Arms:setArmState("CROSSBOW", "CROSSBOW")
							end
						end
					end, "right_arm_tick")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local rotY = headRot.y % 360
						rotY = rotY > 180 and 0 or rotY
						ModelAlias.alias.avatar.rightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3() or vectors.vec3(math.max(headRot.x - 40 + (player:isCrouching() and 30 or 0), -40) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5, rotY, 0))
					end, "right_arm_render")
					return true
				elseif state == "RAIL_GUN_OFF_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
					end, "right_arm_tick")
					events.RENDER:register(function (delta, context)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
						ModelAlias.alias.avatar.rightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.max(headRot.x + 50 + (player:isCrouching() and 30 or 0), 40), math.min(math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78) + 30, 65) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5, 0))
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "RAIL_GUN_MAIN_HAND" then
					events.TICK:register(function ()
						if Arms.armState.left == "RAIL_GUN_MAIN_HAND" then
							Arms:processArmSwingCount()
							if player:isSwingingArm() and player:isLeftHanded() then
								ModelAlias.alias.avatar.leftArm:setParentType("LeftArm")
							else
								ModelAlias.alias.avatar.leftArm:setParentType("Body")
							end
							if player:getActiveItem().id == "minecraft:crossbow" then
								Arms:setArmState("CROSSBOW", "CROSSBOW")
							end
						end
					end, "left_arm_tick")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local rotY = headRot.y % 360
						rotY = rotY < 180 and 0 or rotY
						ModelAlias.alias.avatar.leftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3() or vectors.vec3(math.max(headRot.x - 40 + (player:isCrouching() and 30 or 0), -40) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5, rotY, 0))
					end, "left_arm_render")
				elseif state == "RAIL_GUN_OFF_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
						ModelAlias.alias.avatar.leftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.max(headRot.x + 50 + (player:isCrouching() and 30 or 0), 40), math.max(math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21) - 30, -65) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5, 0))
					end, "left_arm_render")
				end
			end;
		};
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 2.2;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(6, -3, -15);
					left = vectors.vec3(-6, -3, -15);
				};

				thirdPersonPos = {
					right = vectors.vec3(0, 10, 0);
					left = vectors.vec3(0, 10, 0);
				};

				thirdPersonRot = {
					right = vectors.vec3(130, 0, 0);
					left = vectors.vec3(130, 0, 0);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, 1.5, 6);
					left = vectors.vec3(0, 1.5, 6);
				};

				rot = {
					right = vectors.vec3(0, -90, -32.5);
					left = vectors.vec3(0, 90, 32.5);
				};
			};
		};

		sound = {
			name = "minecraft:entity.blaze.hurt";
			pitch = 2;
		};
	};

	placementObjects = {
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.gun.LightEffect, models.models.ex_skill_1.BodySignages, models.models.ex_skill_1.Gui};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 198, 0);
					pos = vectors.vec3(-14.8, 10.25, -12.5);
				};

				fin = {
					rot = vectors.vec3(10, 180, 0);
					pos = vectors.vec3(0, 25.8, -28.4);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.SideHUDs.SideHUDBackground:setOpacity(0.5)
						models.models.ex_skill_1.SideHUDs.SideHUDContents:newText("ex_skill_1_text_1"):setText("§bARIS"):setPos(0.05, 1.75, 0):setRot(0, -90, 0):setScale(0.075, 0.075, 1):setAlignment("CENTER"):setShadow(true):setLight(15)
						models.models.ex_skill_1.SideHUDs.SideHUDContents:newText("ex_skill_1_text_2"):setText("Model complexity:"):setPos(0.05, 1.1, 2.5):setRot(0, -90, 0):setScale(0.05, 0.05, 1):setAlignment("LEFT"):setShadow(true):setLight(15)
						models.models.ex_skill_1.SideHUDs.SideHUDContents:newText("ex_skill_1_text_3"):setText("§e> §cnil"):setPos(0.05, 0.65, 2.3):setRot(0, -90, 0):setScale(0.05, 0.05, 1):setAlignment("LEFT"):setShadow(true):setLight(15)
						models.models.ex_skill_1.SideHUDs.SideHUDContents:newText("ex_skill_1_text_4"):setText("Tick instructions:"):setPos(0.05, 0.1, 2.5):setRot(0, -90, 0):setScale(0.05, 0.05, 1):setAlignment("LEFT"):setShadow(true):setLight(15)
						models.models.ex_skill_1.SideHUDs.SideHUDContents:newText("ex_skill_1_text_5"):setText("§e> §cnil"):setPos(0.05, -0.35, 2.3):setRot(0, -90, 0):setScale(0.05, 0.05, 1):setAlignment("LEFT"):setShadow(true):setLight(15)
						models.models.ex_skill_1.SideHUDs.SideHUDContents:newText("ex_skill_1_text_6"):setText("Render instructions:"):setPos(0.05, -0.9, 2.5):setRot(0, -90, 0):setScale(0.05, 0.05, 1):setAlignment("LEFT"):setShadow(true):setLight(15)
						models.models.ex_skill_1.SideHUDs.SideHUDContents:newText("ex_skill_1_text_7"):setText("§e> §cnil"):setPos(0.05, -1.35, 2.3):setRot(0, -90, 0):setScale(0.05, 0.05, 1):setAlignment("LEFT"):setShadow(true):setLight(15)
						---@diagnostic disable-next-line: discard-returns
						models:newPart("script_ex_skill_1")
						models.script_ex_skill_1:addChild(ModelAlias.alias.avatar.root:copy("exSkill1Outline"))
						models.script_ex_skill_1.exSkill1Outline:setVisible(false)
						models.script_ex_skill_1.exSkill1Outline:setOffsetPivot(0, 16, 0)
						models.script_ex_skill_1.exSkill1Outline:setScale(1.35, 1.3, 1.35)
						models.script_ex_skill_1.exSkill1Outline:setPrimaryTexture("CUSTOM", textures["textures.ex_skill_1_white"])
						models.script_ex_skill_1.exSkill1Outline:setPrimaryRenderType("EMISSIVE_SOLID")
						models.script_ex_skill_1.exSkill1Outline:setColor(0.988, 0.522, 1)
						self.exSkill.primary.isInitialized = true
					end
					events.RENDER:register(function (delta)
						if host:isHost() then
							models.models.ex_skill_1.Gui.ScreenFilter:setOpacity(models.models.ex_skill_1.Gui.ScreenFilterOpacity:getAnimScale().x)
							if models.models.ex_skill_1.CameraBackground:getVisible() then
								local opacity = models.models.ex_skill_1.CameraBackground.BackgroundOpacity:getAnimScale().x
								models.models.ex_skill_1.CameraBackground:setOpacity(opacity)
								models.models.ex_skill_1.CameraBackground:setColor(vectors.vec3(1, 1, 1):scale(opacity))
								local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.65)), 0, 1, 0):scale(16 / 0.9375)
								models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
								models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
								local windowSize = client:getWindowSize()
								models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(40))
							end
						end
						if models.script_ex_skill_1.exSkill1Outline:getVisible() then
							local animRot = ModelAlias.alias.avatar.root:getAnimRot()
							models.script_ex_skill_1.exSkill1Outline:setPos(vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, player:getPos(delta):add(0, 1, 0):sub(client:getCameraPos()):normalize(), 0, 1, 0):scale(10))
							models.script_ex_skill_1.exSkill1Outline:setRot(animRot)
						end
					end, "ex_skill_1_render")
					Character13a_RailGun.chargePercent = 0
					Character13a_RailGun.chargeState = "STRONG"
					Character13a_RailGun.animationLength = 35
					ModelAlias.alias.avatar.gun.DisplayContents:setVisible(true)
					FaceParts:setEmotion("NARROW", "NARROW", "CLOSED", 65, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 0 then
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
					elseif tick == 13 then
						ModelAlias.alias.avatar.gun.LightEffect:setOffsetPivot(0, 0, -1)
					elseif tick == 16 then
						local gunPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun)
						local axisZ = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.GunZ):sub(gunPos):normalize()
						for _ = 1, 50 do
							local anchorPos = gunPos:copy():add(axisZ:copy():scale(math.random() * 0.6 - 0.1))
							particles:newParticle("minecraft:electric_spark", anchorPos):setVelocity(vectors.rotateAroundAxis(math.random() * 360, 0, 0.1, 0, axisZ)):setColor(0.996, 0.859, 0.365)
						end
						sounds:playSound("minecraft:block.chest.locked", player:getPos(), 0.25, 2)
					elseif tick == 26 or tick == 30 then
						sounds:playSound("minecraft:block.chest.locked", player:getPos(), 0.25, 2)
					elseif tick == 51 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.head.EyeHUDs, models.models.ex_skill_1.SideHUDs}) do
							modelPart:setVisible(true)
						end
						sounds:playSound("minecraft:block.beacon.activate", player:getPos(), 0.25, 5)
					elseif tick == 57 then
						models.models.ex_skill_1.SideHUDs.SideHUDContents:setVisible(true)
					elseif tick == 65 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 7, true)
					elseif tick == 68 and host:isHost() then
						models.models.ex_skill_1.Gui.ScreenFilter:setScale(client:getScaledWindowSize():augmented(1))
						models.models.ex_skill_1.CameraBackground:setVisible(true)
					elseif tick == 70 then
						ModelAlias.alias.avatar.head.EyeHUDs.LeftEyeHUDs:setVisible(false)
					elseif tick == 72 then
						FaceParts:setEmotion("STARE", "STARE", "CLOSED", 28, true)
						ModelAlias.alias.avatar.head.EyeLights:setColor(vectors.vec3(1, 1, 1):scale(client:hasShaderPack() and 0.75 or 1))
						ModelAlias.alias.avatar.head.EyeLights:setVisible(true)
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
						models.script_ex_skill_1.exSkill1Outline:setVisible(true)
					elseif tick == 76 and host:isHost() then
						models.models.ex_skill_1.CameraBackground:setVisible(false)
					end

					if tick >= 57 and tick < 70 then
						local modelComplexity = avatar:getComplexity()
						local modelComplexityPercent = modelComplexity / avatar:getMaxComplexity()
						models.models.ex_skill_1.SideHUDs.SideHUDContents:getTask("ex_skill_1_text_3"):setText("§e> §"..(modelComplexityPercent > 0.9 and "c" or (modelComplexityPercent > 0.75 and "e" or "a"))..modelComplexity)
						local tickCount = avatar:getTickCount()
						local tickCountPercent = tickCount / avatar:getMaxTickCount()
						models.models.ex_skill_1.SideHUDs.SideHUDContents:getTask("ex_skill_1_text_5"):setText("§e> §"..(tickCountPercent > 0.9 and "c" or (tickCountPercent > 0.75 and "e" or "a"))..tickCount)
						local renderCount = avatar:getRenderCount()
						local renderCountPercent = renderCount / avatar:getMaxRenderCount()
						models.models.ex_skill_1.SideHUDs.SideHUDContents:getTask("ex_skill_1_text_7"):setText("§e> §"..(renderCountPercent > 0.9 and "c" or (renderCountPercent > 0.75 and "e" or "a"))..renderCount)
					elseif tick >= 70 then
						local anchorPos = ModelUtils.getModelWorldPos(models.script_ex_skill_1.exSkill1Outline)
						local particleVec = player:getPos():add(0, 1, 0):sub(anchorPos):normalize()
						local particleRot = math.deg(math.atan2(particleVec.z, particleVec.x))
						for _ = 1, 2 do
							particles:newParticle("minecraft:end_rod", anchorPos:copy():add(vectors.rotateAroundAxis(particleRot * -1 + 90, math.random() * 2.4 - 1.2, math.random() * 2, 0, 0, 1, 0))):setScale(0.25):setVelocity(0, 0.1, 0):setColor(0.988, 0.522, 1)
						end
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						if forcedStop then
							models.models.ex_skill_1.CameraBackground:setVisible(false)
						end
					end
					if Gun.currentGunPosition == "NONE" then
						local isLeftHanded = player:isLeftHanded()
						ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos[isLeftHanded and "left" or "right"]))
						ModelAlias.alias.avatar.gun:setRot(self.gun.gunPosition.put.rot[isLeftHanded and "left" or "right"])
						ModelAlias.alias.avatar.gun.DisplayContents:setVisible(false)
					end
					for _, modelPart in ipairs({ModelAlias.alias.avatar.head.EyeHUDs, models.models.ex_skill_1.SideHUDs, models.models.ex_skill_1.SideHUDs.SideHUDContents, ModelAlias.alias.avatar.head.EyeLights, models.script_ex_skill_1.exSkill1Outline}) do
						modelPart:setVisible(false)
					end
					ModelAlias.alias.avatar.head.EyeHUDs.LeftEyeHUDs:setVisible(true)
					ModelAlias.alias.avatar.gun.LightEffect:setOffsetPivot()
					if not forcedStop then
						Character13a_RailGun.isSpecialCharge = true
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, isVisible and -1 or 0)
					ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, isVisible and 1 or 0)
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
					FaceParts:setEmotion("ANGRY", "ANGRY", "ANGRY", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMALL", duration, true)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("TEAR", "TEAR", "SHOCK", duration, true)
				end
			end;

			onStop = function (_, _, forcedStop)
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
				ModelAlias.alias.dummy_avatar.head.SideTail:setRot(30, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-10, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair.BackHairBottom:setRot(-80, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair.BackHairBottom:setOffsetPivot(0, 0, -1)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.SideTail:setRot(-25, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-12.5, 0, -15)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair.BackHairBottom:setRot()
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.SideTail};

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
							multiplayer = -40;
							min = -45;
							max = 45;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.SideTail.SideTail};

				z = {
					vertical = {
						min = -170;
						neutral = 0;
						max = 0;

						headZ = {
							multiplayer = -40;
							min = -60;
							max = 0;
						};

						headRot = {
							multiplayer = 0.025;
							min = -60;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -170;
							max = 0;
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
						max = 80;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 80;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 80;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 80;
						};
					};

					horizontal = {
						min = 0;
						neutral = 80;
						max = 80;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 80;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair};

				x = {
					vertical = {
						min = -170;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -40;
							min = -80;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -170;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.025;
							min = -80;
							max = 0;
						};
					};
				};
			};
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model == ModelAlias.alias.avatar.body.Hairs.BackHair then
					if player:isCrouching() then
						local rot = model:getRot().x
						model:setRot(math.min(rot + 30, 0))
						model.BackHairBottom:setRot(math.max(rot + 30, 0))
					else
						model.BackHairBottom:setRot()
					end
				end
			end;
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---レールガンを制御するクラス
		---@type Character13a.RailGun
		Character13a_RailGun = require("scripts.rail_gun")

		Character13a_RailGun.init()
		Character13a_RailGun:enable()
	end;
}

return BlueArchiveCharacter
