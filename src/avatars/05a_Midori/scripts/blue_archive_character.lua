---右目のテクスチャの列挙型
---@alias Character05a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANXIOUS" # 不満な目
---| "CLOSED2" # 閉じた目2
---| "ANGRY" # 怒った目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "INVERTED" # 反対側を見る目

---左目のテクスチャの列挙型
---@alias Character05a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANXIOUS" # 不満な目
---| "CLOSED2" # 閉じた目2
---| "ANGRY" # 怒った目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "CENTER" # 少し反対側を見る目

---口のテクスチャの列挙型
---@alias Character05a.MouthTextures
---| "NORMAL" # 通常
---| "FRUST" # ぐじゅぐじゅ口
---| "ANXIOUS" # 口を膨らませる
---| "CLOSED" # 閉じた口
---| "CLOSED2" # 閉じた口2
---| "SMILE" # ニッコリ
---| "SHOCK" # (つд⊂)ｴｰﾝ な口
---| "TRIANGLE" # 三角口
---| "SMILE_SMALL" # 小さくニッコリ
---| "OPENED_SMALL" # 小さく開いた口

---@class (exact) Character05a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character05a.RightEyeTextures 右目の表情名
---@field public leftEye Character05a.LeftEyeTextures 左目の表情名
---@field public mouth Character05a.MouthTextures 口の表情名

---@class (exact) Character05a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character05a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character05a.EmotionSet ベッドで寝ているとき

---@class (exact) Character05a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character05a, right: Character05a.RightEyeTextures, left: Character05a.LeftEyeTextures, mouth: Character05a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character05a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character05a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character05a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character05a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character05a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character05a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character05a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character05a.FacePartsStruct 目や口による表情

---@type Character05a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "05a_Midori";

		birth = {
			month = 12;
			day = 18;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			ANXIOUS = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(7, 0);
			ANGRY = vectors.vec2(9, 0);
			ANGRY_INVERTED = vectors.vec2(9, 0);
			INVERTED = vectors.vec2(12, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(2, 0); --必須
			ANXIOUS = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(6, 0);
			ANGRY = vectors.vec2(9, 0);
			ANGRY_INVERTED = vectors.vec2(7, 0);
			CENTER = vectors.vec2(10, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(3, 0);
			CLOSED2 = vectors.vec2(4, 0);
			FRUST = vectors.vec2(2, 0);
			ANXIOUS = vectors.vec2(1, 0);
			SMILE = vectors.vec2(0, 0);
			SHOCK = vectors.vec2(5, 0);
			TRIANGLE = vectors.vec2(7, 0);
			SMILE_SMALL = vectors.vec2(8, 0);
			OPENED_SMALL = vectors.vec2(9, 0);
		};

		emotionSet = {
			onDamage = {
				rightEye = "SURPRISED";
				leftEye = "SURPRISED";
				mouth = "SHOCK";
			};
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {models.models.main.Avatar.UpperBody.Body.Skirt};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-0.5, 3, -8);
					left = vectors.vec3(0.5, 3, -8);
				};

				thirdPersonPos = {
					right = vectors.vec3(-2, 3, -6);
					left = vectors.vec3(2, 3, -6);
				};
			};

			put = {
				type = "HIDDEN";
			};
		};

		sound = {
			name = "minecraft:entity.firework_rocket.blast";
			pitch = 0.5;
		};
	};

	placementObjects = {
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.head.Sweat, ModelAlias.alias.avatar.leftArmBottom.GameConsole1, models.models.ex_skill_1.Momoi, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1", "gun"};

			camera = {
				start = {
					rot = vectors.vec3(-10, 190, -25);
					pos = vectors.vec3(-8, 10, -30);
				};

				fin = {
					rot = vectors.vec3(20, 100, -30);
					pos = vectors.vec3(29, 29, -8);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.Momoi.MomoiUpperBody.MomoiArms.MomoiLeftArm.MomoiLeftArmBottom.GameConsole2:addChild(ModelAlias.alias.avatar.leftArmBottom.GameConsole1:copy("GameConsole2"))
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI:newText("ex_skill_1_ko"):setText("§cK.O."):setScale(vectors.vec3(1, 1, 1):scale(1.5)):setAlignment("CENTER"):setOutline(true):setVisible(false)
							models.models.ex_skill_1.Gui.TextAnchor:newText("ex_skill_1:text"):setText("§a§lMIDORI"):setScale(4, 4, 4):setAlignment("RIGHT"):setOutline(true):setOutlineColor(1, 1, 1)
							models.models.ex_skill_1.Gui.UI.MidoriUI.Background:setColor(0.098, 0.2, 0.686)
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar, models.models.ex_skill_1.Gui.UI.MidoriUI.RedBar}) do
								modelPart:setPrimaryRenderType("EMISSIVE_SOLID")
							end
							models.models.ex_skill_1.Gui.UI.MidoriUI:newText("ex_skill_1_midori_name"):setText("§a§lMIDORI"):setPos(48, 13, 0):setScale(1.5, 1.5, 1.5):setOutline(true):setOutlineColor(1, 1, 1):setAlignment("RIGHT")
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setScale(2.3, 2.3, 2.3)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:addChild(ModelUtils:copyModel(models.script_head_block.Skull, "MidoriPaperDollHead"))
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:getTruePivot():add(0, -24, 0))
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.Halo:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts:addChild(ModelAlias.alias.avatar.mouth:copy("Mouth"))
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(64, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setVisible(true)
							models.models.ex_skill_1.Gui.UI.DeadEye:moveTo(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts)
							for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:getChildren()) do
								modelPart:setVisible(false)
							end
							models.models.ex_skill_1.Gui.UI:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Gui.UI.MidoriUI, "MomoiUI"))
							for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:getChildren()) do
								modelPart:setVisible(true)
							end
							models.models.ex_skill_1.Gui.UI.MomoiUI.Frame:setRot(0, 180, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.Background:setPos(139.5, 0, 62)
							models.models.ex_skill_1.Gui.UI.MomoiUI.Background:setColor(0.71, 0.082, 0.067)
							models.models.ex_skill_1.Gui.UI.MomoiUI.YellowBar:setPos(-36, 0, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.YellowBar:setScale(0.6, 1, 1)
							models.models.ex_skill_1.Gui.UI.MomoiUI.YellowBar:setPrimaryRenderType("EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MomoiUI.RedBar:remove()
							models.models.ex_skill_1.Gui.UI.MomoiPaperDollBody:moveTo(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setPos(0, 0, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setRot(0, 15, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setOffsetPivot(139, -0.25, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Momoi.MomoiHead, "MomoiPaperDollHead"))
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:getTruePivot():add(0, -24, 0))
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.MomoiHeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(64, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI:newText("ex_skill_1_momoi_name"):setText("§d§lMOMOI"):setPos(130, 13, 0):setScale(1.5, 1.5, 1.5):setOutline(true):setOutlineColor(1, 1, 1)
						end
						self.exSkill.primary.isInitialized = true
					end
					if host:isHost() then
						models.models.ex_skill_1.Gui.UI.MidoriUI:setPos(client:getScaledWindowSize().x * -1 + 220, 0, 0)
					end
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.5)
					elseif tick == 1 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.75)
					elseif tick == 2 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 2)
					elseif tick == 12 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye}) do
							modelPart:setUVPixels(12, 0)
						end
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(16, 0)
					elseif tick == 15 then
						FaceParts:setEmotion("ANXIOUS", "ANXIOUS", "CLOSED", 22, true)
					elseif tick == 22 then
						ExSkill1TextObjectManager:spawn("2")
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setColor(1, 0.75, 0.75)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes.LeftEye:setUVPixels(6, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes.RightEye:setUVPixels(12, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(80, 0)
						end
					elseif tick == 24 then
						ExSkill1TextObjectManager:spawn("1")
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
					elseif tick == 26 then
						ExSkill1TextObjectManager:spawn("2")
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
					elseif tick == 28 then
						ExSkill1TextObjectManager:spawn("1")
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
					elseif tick == 30 then
						ExSkill1TextObjectManager:spawn("2")
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
					elseif tick == 32 then
						ExSkill1TextObjectManager:spawn("1")
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
					elseif tick == 34 then
						ExSkill1TextObjectManager:spawn("2")
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
					elseif tick == 36 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye}) do
							modelPart:setUVPixels()
						end
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(32, 0)
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 11, true)
						ExSkill1TextObjectManager:spawn("1")
						local playerPos = player:getPos()
						sounds:playSound("minecraft:entity.player.levelup", playerPos, 1, 1.5)
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.DeadEye:setVisible(true)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes:setVisible(false)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(96, 0)
							local task = models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko")
							task:setPos(client:getScaledWindowSize().x / 2 * -1, -12, -30)
							task:setVisible(true)
							events.RENDER:register(function (delta)
								local count = ExSkill.animationCount - 37 + delta
								task:setScale(vectors.vec3(1, 1, 1):scale(count <= 1.5 and (-1.667 * count + 5) or (count + 1)))
							end, "ex_skill_1_ko_render")
						end
					elseif tick == 37 then
						models.models.ex_skill_1.Momoi.MomoiUpperBody.MomoiArms.MomoiLeftArm.MomoiLeftArmBottom.GameConsole2:setVisible(false)
					elseif tick == 38 and host:isHost() then
						events.RENDER:remove("ex_skill_1_ko_render")
						models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko"):setScale(3, 3, 3)
					elseif tick == 47 then
						FaceParts:setEmotion("ANGRY_INVERTED", "TIRED", "FRUST", 17, true)
					elseif tick == 49 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye}) do
							modelPart:setUVPixels(24, 0)
						end
						models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(48, 0)
					elseif tick == 64 then
						ModelAlias.alias.avatar.leftArmBottom.GameConsole1:setVisible(false)
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArm, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArm.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setVisible(true)
						FaceParts:setEmotion("ANXIOUS", "ANXIOUS", "ANXIOUS", 8, true)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI:setVisible(false)
						end
					elseif tick == 72 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", 8, true)
					elseif tick == 75 then
						if host:isHost() then
							models.models.ex_skill_1.Gui.TextAnchor:setVisible(true)
							events.RENDER:register(function ()
								local windowSize = client:getScaledWindowSize()
								models.models.ex_skill_1.Gui.TextAnchor:setPos(models.models.ex_skill_1.Gui.TextAnchor:getAnimPos():scale(windowSize.y / 2 / 100):add(0, windowSize.y * -1 + 30, 0))
							end, "ex_skill_1_text_render")
						end
					elseif tick == 80 then
						FaceParts:setEmotion("ANGRY_INVERTED", "ANGRY", "CLOSED2", 25, true)
					elseif tick == 81 then
						sounds:playSound("minecraft:entity.generic.explode", player:getPos(), 0.25, 0.5)
					end
					if tick <= 36 and math.random() >= 0.75 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 0.1, 2)
					end
					if tick <= 36 and tick % 3 == 0 and host:isHost() then
						sounds:playSound("minecraft:entity.player.attack.nodamage", player:getPos(), 0.25, 1)
					end
				end;

				onPostAnimation = function (_)
					models.models.ex_skill_1.Momoi.MomoiUpperBody.MomoiArms.MomoiLeftArm.MomoiLeftArmBottom.GameConsole2:setVisible(true)
					for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.RightEye, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.LeftEye, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth}) do
						modelPart:setUVPixels()
					end
					if ModelAlias.alias.avatar.rightArm.Gun ~= nil then
						ModelAlias.alias.avatar.gun:setVisible(false)
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArm)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					end
					if host:isHost() then
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI, models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes}) do
							modelPart:setVisible(true)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.DeadEye, models.models.ex_skill_1.Gui.TextAnchor}) do
							modelPart:setVisible(false)
						end
						models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setColor()
						models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko"):setVisible(false)
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes.LeftEye, models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes.RightEye}) do
							modelPart:setUVPixels()
						end
						models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(64, 0)
						for _, eventName in ipairs ({"ex_skill_1_text_render", "ex_skill_1_ko_render"}) do
							events.RENDER:remove(eventName)
						end
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = true;

		callbacks = {
			onAltChange = function (_, isAlt)
				ModelAlias.alias.avatar.head.Phone:setVisible(not isAlt)
			end;

			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.Sweat:setPos(0, 0, isVisible and -1 or 0)
				elseif parts == "LEGGINGS" then
					models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(not isVisible)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE_SMALL", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED_SMALL", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "CLOSED", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SHOCK", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("ANGRY", "TIRED", "FRUST", duration, true)
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
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(70, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(22.5, 0, 0)
			end
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {models.models.main.Avatar.UpperBody.Body.TailXPivot};

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
				models = {models.models.main.Avatar.UpperBody.Body.TailXPivot.TailYPivot};

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
		---Exスキルで使用するテキストオブジェクトのマネージャークラス
		---@type Character05a.ExSkill1TextObject
		ExSkill1TextObject = require("scripts.ex_skill_1_text_object")

		---Exスキルで使用するテキストオブジェクトのマネージャークラス
		---@type Character05a.ExSkill1TextObjectManager
		ExSkill1TextObjectManager = require("scripts.ex_skill_1_text_object_manager")
		ExSkill1TextObjectManager = ExSkill1TextObjectManager.new()

		ExSkill1TextObjectManager.init()
	end;
}

return BlueArchiveCharacter
