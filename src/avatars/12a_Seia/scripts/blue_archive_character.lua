---右目のテクスチャの列挙型
---@alias Character12a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "NARROW" # 少し閉じた目
---| "CLOSED2" # 閉じた目2
---| "ANGRY" # 怒った目

---左目のテクスチャの列挙型
---@alias Character12a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "NARROW_CENTER" # 少し閉じつつ反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "NARROW" # 少し閉じた目
---| "ANGRY" # 怒った目

---口のテクスチャの列挙型
---@alias Character12a.MouthTextures
---| "NORMAL" # 通常
---| "CLOSED" # 閉じた口
---| "SMALL" # 小さく開いた口
---| "OPENED" # 開いた口
---| "SMILE" # にっこり
---| "ANXIOUS" # への口

---@class (exact) Character12a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character12a.RightEyeTextures 右目の表情名
---@field public leftEye Character12a.LeftEyeTextures 左目の表情名
---@field public mouth Character12a.MouthTextures 口の表情名

---@class (exact) Character12a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character12a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character12a.EmotionSet ベッドで寝ているとき

---@class (exact) Character12a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character12a, right: Character12a.RightEyeTextures, left: Character12a.LeftEyeTextures, mouth: Character12a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character12a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character12a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character12a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character12a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character12a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character12a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character12a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character12a.FacePartsStruct 目や口による表情

---@type Character12a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "12a_Seia";

		birth = {
			month = 9;
			day = 29;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CENTER = vectors.vec2(5, 0);
			NARROW = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(9, 0);
			ANGRY = vectors.vec2(10, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CENTER = vectors.vec2(5, 0);
			NARROW_CENTER = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(8, 0);
			NARROW = vectors.vec2(9, 0);
			ANGRY = vectors.vec2(10, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(0, 0);
			SMALL = vectors.vec2(1, 0);
			OPENED = vectors.vec2(2, 0);
			SMILE = vectors.vec2(3, 0);
			ANXIOUS = vectors.vec2(4, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 0.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-0.5, -1, -3);
					left = vectors.vec3(0.5, -1, -3);
				};

				thirdPersonPos = {
					right = vectors.vec3(0, -1, -5);
					left = vectors.vec3(0, -1, -5);
				};
			};

			put = {
				type = "HIDDEN";
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

			models = {models.models.ex_skill_1.Bench, ModelAlias.alias.avatar.head.NoticeEffects, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(25, -25, 0);
					pos = vectors.vec3(-39.3, 53.3, 79);
				};

				fin = {
					rot = vectors.vec3(-2.5, 65, 0);
					pos = vectors.vec3(-29.7, 23.3, -59);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						if ModelAlias.alias.avatar.head.Allay ~= nil then
							ModelUtils.moveTo(ModelAlias.alias.avatar.head.Allay, models.models.ex_skill_1, ModelAlias.alias.avatar.head)
						end
						for i = 2, 7 do
							models.models.ex_skill_1.AnimAllays["Allay"..i]["Allay"..i.."Head"]:addChild(models.models.ex_skill_1.Allay.AllayHead.AllayHead:copy("Allay"..i.."Head"))
							for j = 1, 2 do
								models.models.ex_skill_1.AnimAllays["Allay"..i]["Allay"..i.."Body"]:addChild(models.models.ex_skill_1.Allay.AllayBody["AllayBody"..j]:copy("Allay"..i.."Body"..j))
							end
							models.models.ex_skill_1.AnimAllays["Allay"..i]["Allay"..i.."Body"]["Allay"..i.."RA"]:addChild(models.models.ex_skill_1.Allay.AllayBody.AllayRA.AllayRA:copy("Allay"..i.."RA"))
							models.models.ex_skill_1.AnimAllays["Allay"..i]["Allay"..i.."Body"]["Allay"..i.."LA"]:addChild(models.models.ex_skill_1.Allay.AllayBody.AllayLA.AllayLA:copy("Allay"..i.."LA"))
							models.models.ex_skill_1.AnimAllays["Allay"..i]["Allay"..i.."Body"]["Allay"..i.."RightWing"]:addChild(models.models.ex_skill_1.Allay.AllayBody.AllayRightWing.AllayRightWing:copy("Allay"..i.."RightWing"))
							models.models.ex_skill_1.AnimAllays["Allay"..i]["Allay"..i.."Body"]["Allay"..i.."LeftWing"]:addChild(models.models.ex_skill_1.Allay.AllayBody.AllayLeftWing.AllayLeftWing:copy("Allay"..i.."LeftWing"))
						end
						models.models.ex_skill_1.AnimAllays:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/allay/allay.png")
						if host:isHost() then
							for i = 1, 4 do
								models.models.ex_skill_1.WindowAnchor:newBlock("ex_skill_1_block_"..i):setBlock("minecraft:smooth_quartz_stairs[facing=south]"):setPos((i - 1) * 16 - 32, -40, -32)
							end
							for i = 1, 2 do
								for j = 1, 4 do
									models.models.ex_skill_1.WindowAnchor:newBlock("ex_skill_1_block_"..((i - 1) * 4 + (j - 1) + 5)):setBlock("minecraft:smooth_quartz"):setPos((i - 1) * 80 + -48, (j - 1) * 16 - 40, -24)
								end
							end
							for i = 1, 6 do
								models.models.ex_skill_1.WindowAnchor:newBlock("ex_skill_1_block_"..(i + 12)):setBlock("minecraft:smooth_quartz"):setPos((i - 1) * 16 + -48, 24, -24)
							end
							for i = 1, 2 do
								for j = 1, 5 do
									for k = 1, 5 do
										models.models.ex_skill_1.WindowAnchor:newBlock("ex_skill_1_block_"..((i - 1) * 25 + (j - 1) * 5 + (k - 1) + 19)):setBlock("minecraft:polished_andesite"):setPos((i - 1) * 112 - 64, (k - 1) * 16 - 40, (j - 1) * 16 - 24)
									end
								end
							end
							for i = 1, 6 do
								for j = 1, 5 do
									models.models.ex_skill_1.WindowAnchor:newBlock("ex_skill_1_block_"..((i - 1) * 5 + (j - 1) + 69)):setBlock("minecraft:polished_andesite"):setPos((i - 1) * 16 - 48, (j - 1) * 16 - 40, 40)
								end
							end
							for i = 1, 8 do
								for j = 1, 5 do
									models.models.ex_skill_1.WindowAnchor:newBlock("ex_skill_1_block_"..((i - 1) * 5 + (j - 1) + 99)):setBlock("minecraft:spruce_planks"):setPos((i - 1) * 16 - 64, -56, (j - 1) * 16 - 24)
								end
							end
							for i = 1, 8 do
								for j = 1, 5 do
									models.models.ex_skill_1.WindowAnchor:newBlock("ex_skill_1_block_"..((i - 1) * 5 + (j - 1) + 139)):setBlock("minecraft:polished_andesite"):setPos((i - 1) * 16 - 64, 40, (j - 1) * 16 - 24)
								end
							end
							for i = 1, 2 do
								for j = 1, 3 do
									models.models.ex_skill_1.WindowAnchor.WindowFrameAnchor1:newBlock("ex_skill_1_block_"..((i - 1) * 3 + (j - 1) + 179)):setBlock("minecraft:glass_pane[east=true,west=true]"):setPos((i - 1) * 16, (j - 1) * 16, -8)
								end
							end
							for i = 1, 2 do
								for j = 1, 3 do
									models.models.ex_skill_1.WindowAnchor.WindowFrameAnchor2:newBlock("ex_skill_1_block_"..((i - 1) * 3 + (j - 1) + 186)):setBlock("minecraft:glass_pane[east=true,west=true]"):setPos((i - 1) * 16 - 32, (j - 1) * 16, -8)
								end
							end
							models.models.ex_skill_1.WindowAnchor:newBlock("ex_skill_1_block_192"):setBlock("minecraft:potted_azure_bluet"):setPos(-24, -24, -28)
						end
						self.exSkill.primary.isInitialized = true
					end
					if host:isHost() then
						models.models.ex_skill_1.WindowAnchor:setVisible(true)
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.Frame:setOpacity(models.models.ex_skill_1.Gui.FrameOpacity:getAnimScale().x)
						end, "ex_skill_1_render")
					end
					FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 13, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 1 and host:isHost() then
						models.models.ex_skill_1.Allay:setVisible(true)
					elseif tick == 13 then
						FaceParts:setEmotion("CENTER", "NORMAL", "CLOSED", 14, true)
					elseif tick == 20 then
						sounds:playSound("minecraft:entity.allay.ambient_with_item", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Allay), 0.15, 1)
					elseif tick == 27 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 9, true)
					elseif tick == 38 then
						if host:isHost() then
							models.models.ex_skill_1.WindowAnchor:setVisible(false)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Allay, models.models.ex_skill_1.AnimAllays, ModelAlias.alias.avatar.rightArmBottom.Book, ModelAlias.alias.avatar.rightArmBottom.Cushion}) do
							modelPart:setVisible(true)
						end
						FaceParts:setEmotion("CENTER", "NORMAL", "CLOSED", 65, true)
					elseif tick == 64 and host:isHost() then
						models.models.ex_skill_1.Gui.Frame:setScale(client:getScaledWindowSize():augmented(1))
					elseif tick == 101 then
						sounds:playSound("minecraft:entity.bat.takeoff", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Bench), 0.15, 1.5)
					elseif tick == 103 then
						FaceParts:setEmotion("NORMAL", "CENTER", "CLOSED", 3, true)
					elseif tick == 106 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "CLOSED", 2, true)
					elseif tick == 108 then
						FaceParts:setEmotion("NORMAL", "CENTER", "SMALL", 6, true)
					elseif tick == 114 then
						models.models.ex_skill_1.Allay:setVisible(false)
						for i = 2, 7 do
							models.models.ex_skill_1.AnimAllays["Allay"..i]:setVisible(false)
						end
						FaceParts:setEmotion("CENTER", "NORMAL", "SMALL", 19, true)
					elseif tick == 133 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMALL", 2, true)
					elseif tick == 134 then
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 1.5)
					elseif tick == 135 then
						for i = 1, 3 do
							ModelAlias.alias.avatar.head.NoticeEffects["NoticeEffect"..i]["NoticeEffect"..i.."Pivot"]:setOffsetPivot(-4, 0, 0)
						end
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMALL", 16, true)
					elseif tick == 146 then
						if host:isHost() then
							models.models.ex_skill_1.Gui.Frame:setUVPixels(16, 0)
						end
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 20 do
							particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head):add(0, 0.25, 0)):setVelocity(vectors.rotateAroundAxis(math.random() * 120 - 60, vectors.rotateAroundAxis(bodyYaw * -1 + 30 - math.random() * 240, 0, 0, math.random() * 0.05 + 0.05, 0, 1, 0), 1, 0, 0)):setGravity(0):setLifetime(70)
						end
					elseif tick == 151 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMALL", 2, true)
						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.5, 1.5)
					elseif tick == 153 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Allay, models.models.ex_skill_1.AnimAllays.Allay2}) do
							modelPart:setVisible(true)
						end
						FaceParts:setEmotion("NARROW", "NARROW_CENTER", "OPENED", 63, true)
					elseif tick == 160 then
						models.models.ex_skill_1.AnimAllays.Allay3:setVisible(true)
					elseif tick == 163 then
						sounds:playSound("minecraft:entity.allay.ambient_with_item", ModelUtils.getModelWorldPos(models.models.ex_skill_1.AnimAllays.Allay3), 0.15, 1)
					end

					if tick >= 101 and tick < 114 then
						particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Allay)):setScale(0.25):setColor(0.25, 1, 1):setGravity(0)
						for i = 2, 7 do
							particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(models.models.ex_skill_1.AnimAllays["Allay"..i])):setScale(0.25):setColor(0.25, 1, 1):setGravity(0)
						end
					end

					if tick >= 38 and tick < 101 and math.random() >= 0.95 then
						sounds:playSound("minecraft:entity.allay.ambient_with_item", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Bench), 0.15, 1)
					end

					particles:newParticle("minecraft:cherry_leaves", player:getPos():add(vectors.rotateAroundAxis( player:getBodyYaw() * -1, -3, 5, 4, 0, 1, 0)):add(math.random() * 5 - 2.5, 0, math.random() * 5 - 2.5))
				end;

				onPostAnimation = function (_, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						models.models.ex_skill_1.Gui.Frame:setUVPixels()
					end
					for i = 4, 7 do
						models.models.ex_skill_1.AnimAllays["Allay"..i]:setVisible(true)
					end
					for _, modelPart in ipairs({models.models.ex_skill_1.AnimAllays, ModelAlias.alias.avatar.rightArmBottom.Book, ModelAlias.alias.avatar.rightArmBottom.Cushion}) do
						modelPart:setVisible(false)
					end
					for i = 1, 3 do
						ModelAlias.alias.avatar.head.NoticeEffects["NoticeEffect"..i]["NoticeEffect"..i.."Pivot"]:setOffsetPivot()
					end
					if forcedStop then
						if host:isHost() then
							models.models.ex_skill_1.WindowAnchor:setVisible(false)
						end
						for i = 2, 3 do
							models.models.ex_skill_1.AnimAllays["Allay"..i]:setVisible(true)
						end
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか。
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "HELMET" then
					if Character12a_Allay.perchCount <= 0 and Character12a_Allay ~= nil then
						ModelAlias.alias.avatar.head.Allay:setPos(0, isVisible and 33 or 32, 3)
					end
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, isVisible and -1 or 0)
					ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, isVisible and 1 or 0)
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
					self.physics.physicData[1].x.vertical.neutral = isVisible and 0 or -10
					self.physics.physicData[1].x.vertical.max = isVisible and 0 or -10
					self.physics.physicData[1].x.vertical.bodyX.max = isVisible and 0 or -10
					self.physics.physicData[1].x.vertical.bodyY.max = isVisible and 0 or -10
					self.physics.physicData[1].x.vertical.bodyRot.max = isVisible and 0 or -10
					self.physics.physicData[1].x.horizontal.neutral = isVisible and 0 or -10
					self.physics.physicData[1].x.horizontal.max = isVisible and 0 or -10
				end

				if Armor.isArmorVisible.chestplate or Armor.isArmorVisible.leggings then
					self.physics.physicData[2].x.vertical.min = 0
					self.physics.physicData[2].x.vertical.neutral = 0
					self.physics.physicData[2].x.vertical.bodyX.min = 0
					self.physics.physicData[2].x.vertical.bodyY.min = 0
					self.physics.physicData[2].x.vertical.bodyRot.min = 0
					self.physics.physicData[2].x.horizontal.min = 0
					self.physics.physicData[2].x.horizontal.neutral = 0
					self.physics.physicData[2].x.horizontal.bodyX.min = 0
				else
					self.physics.physicData[2].x.vertical.min = 5
					self.physics.physicData[2].x.vertical.neutral = 5
					self.physics.physicData[2].x.vertical.bodyX.min = 5
					self.physics.physicData[2].x.vertical.bodyY.min = 5
					self.physics.physicData[2].x.vertical.bodyRot.min = 5
					self.physics.physicData[2].x.horizontal.min = 5
					self.physics.physicData[2].x.horizontal.neutral = 5
					self.physics.physicData[2].x.horizontal.bodyX.min = 5
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", duration, true)
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
		callbacks = {
			onBeforeModelCopy = function ()
				if ModelAlias.alias.avatar.head.Allay ~= nil then
					ModelAlias.alias.avatar.head.Allay:setVisible(false)
				end
			end;

			onAfterModelCopy = function ()
				if ModelAlias.alias.avatar.head.Allay ~= nil then
					ModelAlias.alias.avatar.head.Allay:setVisible(true)
				end
			end;
		};
	};

	headBlock = {
		includeModels = {ModelAlias.alias.avatar.body.Hairs};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onBeforeModelCopy = function ()
				if ModelAlias.alias.avatar.head.Allay ~= nil then
					ModelAlias.alias.avatar.head.Allay:setVisible(false)
				end
			end;

			onAfterModelCopy = function ()
				if ModelAlias.alias.avatar.head.Allay ~= nil then
					ModelAlias.alias.avatar.head.Allay:setVisible(true)
				end
			end;

			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.Ears.RightEar:setRot(-60, -20, 0)
				ModelAlias.alias.dummy_avatar.head.Ears.LeftEar:setRot(-60, 20, 0)
				ModelAlias.alias.dummy_avatar.body.Hairs.FrontHair:setRot(35, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(10, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot()
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(45, 0, 0)
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.rightArmBottom.RightSleeve, ModelAlias.alias.dummy_avatar.leftArmBottom.LeftSleeve}) do
					modelPart:setRot()
					modelPart:setOffsetPivot()
				end
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(80, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Hairs.FrontHair:setRot(15, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-20, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(25, 0, 0)
				ModelAlias.alias.dummy_avatar.rightArmBottom.RightSleeve:setRot(-40, 0, 0)
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
						neutral = -10;
						max = -10;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = -10;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = -10;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -10;
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
				models = {ModelAlias.alias.avatar.body.Tail};

				x = {
					vertical = {
						min = -70;
						neutral = 60;
						max = 60;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};

						bodyY = {
							multiplayer = 80;
							min = -70;
							max = 60;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = 0;
							max = 60;
						};
					};

					horizontal = {
						min = -70;
						neutral = 0;
						max = 60;
						sneakOffset = 30;

						bodyX = {
							multiplayer = 160;
							min = -70;
							max = 60;
						};
					};
				};

				y = {
					vertical = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyZ = {
							multiplayer = -160;
							min = -50;
							max = 50;
						};
					};

					horizontal = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyRot = {
							multiplayer = 0.05;
							min = -50;
							max = 50;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---お供のアレイを制御するクラス
		---@type Character12a.Allay
		Character12a_Allay = require("scripts.allay")

		Character12a_Allay:init()

        events.RENDER:register(function (_, context)
            if context == "FIRST_PERSON" then
                ModelAlias.alias.avatar.rightArmBottom.RightSleeve:setRot(0, 0, -60)
                ModelAlias.alias.avatar.rightArmBottom.RightSleeve:setOffsetPivot(1.5, 0, 0)
                ModelAlias.alias.avatar.leftArmBottom.LeftSleeve:setRot(0, 0, 60)
                ModelAlias.alias.avatar.leftArmBottom.LeftSleeve:setOffsetPivot(-1.5, 0, 0)
            elseif ExSkill.animationCount == -1 then
                local rightArmRot = math.clamp(((ModelAlias.alias.avatar.rightArm:getParentType() == "RightArm" and not (context == "PAPERDOLL" and Gun.currentGunPosition ~= "NONE")) and vanilla_model.RIGHT_ARM:getOriginRot().x or 0) + ModelAlias.alias.avatar.rightArm:getTrueRot().x, -60, 60)
                ModelAlias.alias.avatar.rightArmBottom.RightSleeve:setRot(rightArmRot * -1, 0, 0)
                ModelAlias.alias.avatar.rightArmBottom.RightSleeve:setOffsetPivot(0, 0, rightArmRot < 0 and 4 or 0)
                local leftArmRot = math.clamp(((ModelAlias.alias.avatar.leftArm:getParentType() == "LeftArm" and not (context == "PAPERDOLL" and Gun.currentGunPosition ~= "NONE")) and vanilla_model.LEFT_ARM:getOriginRot().x or 0) + ModelAlias.alias.avatar.leftArm:getTrueRot().x, -60, 60)
                ModelAlias.alias.avatar.leftArmBottom.LeftSleeve:setRot(leftArmRot * -1, 0, 0)
                ModelAlias.alias.avatar.leftArmBottom.LeftSleeve:setOffsetPivot(0, 0, leftArmRot < 0 and 4 or 0)
            else
                ModelAlias.alias.avatar.rightArmBottom.RightSleeve:setRot()
                ModelAlias.alias.avatar.rightArmBottom.RightSleeve:setOffsetPivot(ModelAlias.alias.avatar.rightArmBottom.RightSleeve:getAnimRot().x >= 0 and 4 or 0)
                ModelAlias.alias.avatar.leftArmBottom.LeftSleeve:setRot()
                ModelAlias.alias.avatar.leftArmBottom.LeftSleeve:setOffsetPivot(ModelAlias.alias.avatar.leftArmBottom.LeftSleeve:getAnimRot().x >= 0 and 4 or 0)
            end
        end)
	end;
}

return BlueArchiveCharacter
