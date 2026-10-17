---右目のテクスチャの列挙型
---@alias Character15a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "CENTER" # 少し反対側を見る目

---左目のテクスチャの列挙型
---@alias Character15a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "CENTER" # 少し反対側を見る目

---口のテクスチャの列挙型
---@alias Character15a.MouthTextures
---| "NORMAL" # 通常
---| "ANXIOUS" # への口
---| "TRIANGLE" # 三角口
---| "SMILE" # にっこり

---@class (exact) Character15a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character15a.RightEyeTextures 右目の表情名
---@field public leftEye Character15a.LeftEyeTextures 左目の表情名
---@field public mouth Character15a.MouthTextures 口の表情名

---@class (exact) Character15a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character15a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character15a.EmotionSet ベッドで寝ているとき

---@class (exact) Character15a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character15a, right: Character15a.RightEyeTextures, left: Character15a.LeftEyeTextures, mouth: Character15a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character15a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character15a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character15a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character15a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character15a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character15a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character15a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character15a.FacePartsStruct 目や口による表情

---@type Character15a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "15a_Hikari";

		birth = {
			month = 6;
			day = 14;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(5, 0);
			CENTER = vectors.vec2(7, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CLOSED2 = vectors.vec2(4, 0);
			CENTER = vectors.vec2(5, 0);
		};

		mouth = {
			ANXIOUS = vectors.vec2(0, 0);
			TRIANGLE = vectors.vec2(1, 0);
			SMILE = vectors.vec2(2, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				local armState = {right = right, left = left}
				if Character15a_SyupogakiDance ~= nil and Character15a_SyupogakiDance.danceState ~= "NOT_STANDBY" then
					armState.right = "DEFAULT"
					armState.left = "DEFAULT"
				else
					armState.right = armState.right == "GUN_OFF_HAND" and "DEFAULT" or armState.right
					armState.left = armState.left == "GUN_OFF_HAND" and "DEFAULT" or armState.left
				end
				return armState
			end;
		};
	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 0.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-1, -3.5, -2);
					left = vectors.vec3(1, -3.5, -2);
				};

				thirdPersonPos = {
					right = vectors.vec3(0, -3.5, -3);
					left = vectors.vec3(0, -3.5, -3);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(-4.5, -9, 0);
					left = vectors.vec3(-4.5, -9, 0);
				};

				rot = {
					right = vectors.vec3(-90, 0, 0);
					left = vectors.vec3(-90, 0, 0);
				};
			};
		};

		sound = {
			name = "minecraft:entity.iron_golem.hurt";
			pitch = 2;
		};
	};

	placementObjects = {

	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.rightArmBottom.Puncher, ModelAlias.alias.avatar.leftArmBottom.Ticket, models.models.ex_skill_1.Gui.TransitionArea, models.models.ex_skill_1.PopEffectCenter, models.models.ex_skill_1.ShineEffect};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(-61, 32, -77);
				};

				fin = {
					rot = vectors.vec3(-10, 135, 5);
					pos = vectors.vec3(16, 25, -8.25);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.didInit then
						if host:isHost() then
							for i = 1, 8 do
								models.models.ex_skill_1.Gui.TransitionArea:addChild(models.models.ex_skill_1.TransitionPart.TransitionPartLtoR:copy("TransitionPartLtoR"..i))
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setRot(0, 0, -15)
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setVisible(true)
								models.models.ex_skill_1.Gui.TransitionArea:addChild(models.models.ex_skill_1.TransitionPart.TransitionPartRtoL:copy("TransitionPartRtoL"..i))
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setRot(0, 0, -15)
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setVisible(true)
							end
						end
						---@diagnostic disable-next-line: discard-returns
						models.models.ex_skill_1:newPart("VillagerArea")
						for i = 1, 8 do
							models.models.ex_skill_1.VillagerArea:newEntity("ex_skill_1_villager_"..i):setNbt("minecraft:villager", "{}")
						end
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_1"):setPos(12, 0, -18):setRot(0, -30, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_2"):setPos(-12, 0, -18):setRot(0, 30, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_3"):setPos(64, 0, -64):setRot(0, -45, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_4"):setPos(28, 0, -64):setRot(0, -25, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_5"):setPos(48, 0, -40):setRot(0, -50, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_6"):setPos(24, 0, -40):setRot(0, -35, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_7"):setPos(0, 0, -64):setRot(0, 0, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_8"):setPos(-24, 0, -40):setRot(0, 35, 0)
						for i = 1, 2 do
							models.models.ex_skill_1.VillagerArea:addChild(models.models.ex_skill_1.ShockEffect:copy("ShockEffect"..i))
							models.models.ex_skill_1.VillagerArea["ShockEffect"..i]:setVisible(true)
						end
						models.models.ex_skill_1.VillagerArea.ShockEffect1:setPos(-9, 29, -22)
						models.models.ex_skill_1.VillagerArea.ShockEffect1:setRot(0, -60, 0)
						models.models.ex_skill_1.VillagerArea.ShockEffect2:setPos(62, 29, -64)
						models.models.ex_skill_1.VillagerArea.ShockEffect2:setRot(0, 45, 0)
						for i = 1, 2 do
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp1["Stamp1ShineEffect"..i]:setColor(0.996, 1, 0.663)
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp2["Stamp2ShineEffect"..i]:setColor(1, 0.698, 0.624)
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp3["Stamp3ShineEffect"..i]:setColor(0.714, 0.996, 0.812)
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp4["Stamp4ShineEffect"..i]:setColor(0.714, 0.996, 0.812)
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp6["Stamp6ShineEffect"..i]:setColor(1, 0.769, 0.988)
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp7["Stamp7ShineEffect"..i]:setColor(1, 0.635, 0.996)
						end
						self.exSkill.primary.didInit = true
					else
						models.models.ex_skill_1.VillagerArea:setVisible(true)
					end
					if host:isHost() then
						local windowSize = client:getScaledWindowSize()
						models.models.ex_skill_1.Gui.TransitionArea:setPos(windowSize:copy():scale(-0.5):augmented(0))
						local height = math.sqrt(windowSize.y ^ 2 + (math.tan(math.rad(15)) * windowSize.y) ^ 2) + math.tan(math.rad(15)) * 64
						local halfWidth = windowSize.x / 2 + math.tan(math.rad(15)) * windowSize.y + 1
						for i = 1, 8 do
							models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setPos(halfWidth, 0, 0)
							models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setScale(16, height, 1)
							models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setPos(halfWidth * -1, 0, 0)
							models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setScale(16, height, 1)
						end
					end
					local villagerTypes = client.getRegistry("minecraft:villager_type")
					local villagerProfessions = client.getRegistry("minecraft:villager_profession")
					for i = 1, 8 do
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_"..i):setNbt("minecraft:villager", "{\"VillagerData\": {\"level\": "..math.random(1, 5)..", \"profession\": \""..villagerProfessions[math.random(1, #villagerProfessions)].."\", \"type\": \""..villagerTypes[math.random(1, #villagerTypes)].."\"}}")
					end
					for i = 15, 54 do
						ModelAlias.alias.avatar.leftArmBottom.Ticket["Hole"..i]:setVisible(false)
					end
					ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp1.Stamp1:setUVPixels(0, math.random() >= 0.95 and 32 or 0)
					FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", 47, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 9 then
						self.exSkill.primary.playAngryVillagerEffect(player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, -1.5, 0, 2.5, 0, 1, 0)))
					elseif tick == 22 then
						self.exSkill.primary.playAngryVillagerEffect(player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, -1.75, 0, 4, 0, 1, 0)))
					elseif tick == 39 then
						self.exSkill.primary.playAngryVillagerEffect(player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 0, 4, 0, 1, 0)))
					elseif tick == 47 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 15, true)
					elseif tick == 62 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TRIANGLE", 2, true)
					elseif tick == 64 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 48, true)
					elseif tick == 80 and host:isHost() then
						local windowSize = client:getScaledWindowSize()
						local moveWidth = windowSize.x + math.tan(math.rad(15)) * windowSize.y * 2 + 2
						events.RENDER:register(function ()
							for i = 1, 8 do
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setPos(models.models.ex_skill_1.Gui.TransitionArea["TransitionAnchorRtoL"..i]:getAnimPos().x * moveWidth, 0, 0)
							end
						end, "ex_skill_1_render")
					elseif tick == 86 then
						if host:isHost() then
							ModelAlias.alias.avatar.head:setVisible(false)
						end
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole15:setVisible(true)
						for i = 23, 54 do
							ModelAlias.alias.avatar.leftArmBottom.Ticket["Hole"..i]:setVisible(true)
						end
					elseif tick == 88 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole22:setVisible(true)
					elseif tick == 91 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole21:setVisible(true)
					elseif tick == 93 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole20:setVisible(true)
					elseif tick == 94 then
						if host:isHost() then
							events.RENDER:remove("ex_skill_1_render")
						end
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole19:setVisible(true)
					elseif tick == 96 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole18:setVisible(true)
					elseif tick == 99 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole17:setVisible(true)
					elseif tick == 100 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole16:setVisible(true)
					elseif tick >= 111 and tick <= 121 and (tick - 111) % 2 == 0 then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.5, 1.85)
					elseif tick == 112 then
						if host:isHost() then
							ModelAlias.alias.avatar.head:setVisible(true)
						end
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 22, true)
					elseif tick == 130 and host:isHost() then
						local windowSize = client:getScaledWindowSize()
						local moveWidth = windowSize.x + math.tan(math.rad(15)) * windowSize.y * 2 + 2
						local height = math.sqrt(windowSize.y ^ 2 + (math.tan(math.rad(15)) * windowSize.y) ^ 2) + math.tan(math.rad(15)) * 64
						events.RENDER:register(function ()
							for i = 1, 8 do
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setPos(models.models.ex_skill_1.Gui.TransitionArea["TransitionAnchorLtoR"..i]:getAnimPos().x * moveWidth, 0, 0)
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setScale(models.models.ex_skill_1.Gui.TransitionArea["TransitionAnchorLtoR"..i]:getAnimScale():mul(16, height, 1))
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setPos(models.models.ex_skill_1.Gui.TransitionArea["TransitionAnchorRtoL"..i]:getAnimPos().x * moveWidth, 0, 0)
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setScale(models.models.ex_skill_1.Gui.TransitionArea["TransitionAnchorRtoL"..i]:getAnimScale():mul(16, height, 1))
							end
						end, "ex_skill_1_render")
					elseif tick == 134 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", 16, true)
					elseif tick == 141 and host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
					elseif tick == 143 then
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.25, 1)
					elseif tick == 147 and host:isHost() then
						models.models.ex_skill_1.Gui.ScreenFilter:setScale(client:getScaledWindowSize():augmented(1))
						models.models.ex_skill_1.Gui.ScreenFilter:setVisible(true)
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.ScreenFilter:setOpacity(models.models.ex_skill_1.Gui.ScreenFilterOpacity:getAnimScale().x)
						end, "ex_skill_1_render")
					elseif tick == 150 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TRIANGLE", 2, true)
					elseif tick == 152 then
						FaceParts:setEmotion("NORMAL", "CENTER", "TRIANGLE", 40, true)
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					elseif tick == 154 and host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						models.models.ex_skill_1.Gui.ScreenFilter:setVisible(false)
					elseif tick == 160 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.TicketShineEffect:setOffsetPivot(-0.5, 0, 0)
					end

					for _, villagerId in ipairs({1, 5}) do
						local anchorPos = player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_"..villagerId):getPos():scale(-0.0575):add(0, 1.5, 0), 0, 1, 0))
						particles:newParticle("minecraft:splash", anchorPos):setPower(1.2)
					end
					if tick < 47 and tick % 4 == 0 then
						sounds:playSound("minecraft:block.bubble_column.bubble_pop", player:getPos(), 0.25, 2 - math.random() * 0.5)
					elseif ((tick >= 47 and tick < 61) or (tick >= 69 and tick < 108)) and (tick - 47) % 6 == 0 then
						sounds:playSound("minecraft:entity.sheep.shear", player:getPos(), 0.25, 2)
					end
					if tick < 86 and tick % 2 == 0 then
						particles:newParticle("minecraft:angry_villager", player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, math.random() * 2 - 1, math.random() * 2, 0, 0, 1, 0)))
					end
					if math.random() > 0.95 then
						sounds:playSound("minecraft:entity.villager.ambient", player:getPos(), 0.25, 1)
					end
				end;

				onPostAnimation = function (_, forcedStop)
					models.models.ex_skill_1.VillagerArea:setVisible(false)
					for i = 15, 54 do
						ModelAlias.alias.avatar.leftArmBottom.Ticket["Hole"..i]:setVisible(false)
					end
					ModelAlias.alias.avatar.leftArmBottom.Ticket.TicketShineEffect:setOffsetPivot()
					if forcedStop and host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						ModelAlias.alias.avatar.head:setVisible(true)
						models.models.ex_skill_1.Gui.ScreenFilter:setVisible(false)
					end
				end;
			};

			---このExスキルの初期化処理がされたかどうか
			---@type boolean
			didInit = false;

			---村人が怒っている演出を再生する。
			playAngryVillagerEffect = function (anchorPos)
				for _ = 1, 5 do
					particles:newParticle("minecraft:angry_villager", anchorPos:copy():add(math.random() * 1 - 0.5, math.random() * 1 + 0.5, math.random() * 1 - 0.5))
				end
				sounds:playSound("minecraft:entity.villager.no", anchorPos, 1, 1)
			end;
		};

		callbacks = {
			additionalCheckFunc = function ()
				return Character15a_SyupogakiDance.danceState == "NOT_STANDBY"
			end;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.Hat:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					if isVisible then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.ShoulderBag, ModelAlias.alias.avatar.body.BeltAccessories}) do
							modelPart:setVisible(false)
						end
						ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, -1)
						ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, 1)
						self.physics.physicData[1].x.vertical.neutral = 0
						self.physics.physicData[1].x.vertical.max = 0
						self.physics.physicData[1].x.vertical.bodyX.max = 0
						self.physics.physicData[1].x.vertical.bodyY.max = 0
						self.physics.physicData[1].x.vertical.bodyRot.max = 0
						self.physics.physicData[1].x.horizontal.neutral = 0
						self.physics.physicData[1].x.horizontal.max = 0
					else
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.ShoulderBag, ModelAlias.alias.avatar.body.BeltAccessories}) do
							modelPart:setVisible(true)
						end
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Hairs.FrontHair, ModelAlias.alias.avatar.body.Hairs.BackHair}) do
							modelPart:setPos()
						end
						self.physics.physicData[1].x.vertical.neutral = -17.5
						self.physics.physicData[1].x.vertical.max = -17.5
						self.physics.physicData[1].x.vertical.bodyX.max = -17.5
						self.physics.physicData[1].x.vertical.bodyY.max = -17.5
						self.physics.physicData[1].x.vertical.bodyRot.max = -17.5
						self.physics.physicData[1].x.horizontal.neutral = -17.5
						self.physics.physicData[1].x.horizontal.max = -17.5
					end
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			additionalCheckFunc = function ()
				return Character15a_SyupogakiDance.danceState == "NOT_STANDBY"
			end;

			onPlay = function (_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", duration, true)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", duration, true)
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
				ModelAlias.alias.dummy_avatar.body.TailXPivot:setRot(10, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(60, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-20, 0, -15)
				ModelAlias.alias.dummy_avatar.body.TailXPivot:setRot(60, 0, -15)
				ModelAlias.alias.dummy_avatar.body.TailXPivot.TailYPivot.Tail.Tail2:setRot(0, 0, 0)
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
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair},

				x = {
					vertical = {
						min = -150;
						neutral = -17.5;
						max = -17.5;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = -17.5;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = -17.5;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -17.5;
						};
					};

					horizontal = {
						min = -90;
						neutral = -17.5;
						max = -17.5;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Hairs.FrontHair};

				x = {
					vertical = {
						min = 2.5;
						neutral = 2.5;
						max = 150;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 2.5;
							max = 90;
						};

						bodyY = {
							multiplayer = -80;
							min = 2.5;
							max = 150;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 2.5;
							max = 90;
						};
					};

					horizontal = {
						min = 2.5;
						neutral = 90;
						max = 150;

						bodyX = {
							multiplayer = -80;
							min = 2.5;
							max = 150;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BeltAccessories};

				x = {
					vertical = {
						min = 22.5;
						neutral = 22.5;
						max = 155;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -160;
							min = 22.5;
							max = 90;
						};

						bodyY = {
							multiplayer = -160;
							min = 22.5;
							max = 155;
						};
					};

					horizontal = {
						min = 22.5;
						neutral = 90;
						max = 155;

						bodyX = {
							multiplayer = 22.5;
							min = -40;
							max = 155;
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
	init = function ()
		---シュポガキダンスを制御するクラス
		---@type Character15a.SyupogakiDance
		Character15a_SyupogakiDance = require("scripts.syupogaki_dance")

		Character15a_SyupogakiDance:init()
	end;
}

return BlueArchiveCharacter
