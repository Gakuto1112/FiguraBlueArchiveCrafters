---右目のテクスチャの列挙型
---@alias Character04a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "SURPRISED2" # 驚いて下を見る目
---| "ANGRY" # 怒っている目
---| "ANXIOUS" # 不満な目
---| "UNEQUAL" # ><
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目

---左目のテクスチャの列挙型
---@alias Character04a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "SURPRISED2" # 驚いて下を見る目
---| "ANGRY" # 怒っている目
---| "ANGRY2" # 怒っている目
---| "ANXIOUS" # 不満な目
---| "UNEQUAL" # ><
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "CENTER" # 少し反対側を見る目

---口のテクスチャの列挙型
---@alias Character04a.MouthTextures
---| "NORMAL" # 通常
---| "FUN" # 「美味しそう」な口
---| "ANXIOUS" # 口を膨らませる
---| "SHOCK" # あんぐり
---| "OPENED" # 開いた口
---| "SMILE" # こっちを舐め腐っているにっこり
---| "TRIANGLE" # 三角口
---| "ANGRY" # 怒った口

---@class (exact) Character04a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character04a.RightEyeTextures 右目の表情名
---@field public leftEye Character04a.LeftEyeTextures 左目の表情名
---@field public mouth Character04a.MouthTextures 口の表情名

---@class (exact) Character04a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character04a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character04a.EmotionSet ベッドで寝ているとき

---@class (exact) Character04a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character04a, right: Character04a.RightEyeTextures, left: Character04a.LeftEyeTextures, mouth: Character04a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character04a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character04a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character04a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character04a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character04a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character04a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character04a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character04a.FacePartsStruct 目や口による表情

---@type Character04a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "04a_Momoi";

		birth = {
			month = 12;
			day = 8;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			SURPRISED2 = vectors.vec2(5, 0);
			ANGRY = vectors.vec2(6, 0);
			ANXIOUS = vectors.vec2(11, 0);
			UNEQUAL = vectors.vec2(13, 0);
			ANGRY_CENTER = vectors.vec2(7, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(2, 0); --必須
			SURPRISED2 = vectors.vec2(4, 0);
			ANGRY2 = vectors.vec2(9, 0);
			ANXIOUS = vectors.vec2(11, 0);
			UNEQUAL = vectors.vec2(12, 0);
			ANGRY = vectors.vec2(7, 0);
			ANGRY_INVERTED = vectors.vec2(8, 0);
			CENTER = vectors.vec2(13, 0);
		};

		mouth = {
			OPENED = vectors.vec2(0, 0);
			FUN = vectors.vec2(3, 0);
			ANXIOUS = vectors.vec2(2, 0);
			SHOCK = vectors.vec2(1, 0);
			ANGRY = vectors.vec2(4, 0);
			SMILE = vectors.vec2(6, 0);
			TRIANGLE = vectors.vec2(7, 0);
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
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
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
			pitch = 1;
		};
	};

	placementObjects = {
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.head.EffectPanel, ModelAlias.alias.avatar.leftArmBottom.GameConsole1, models.models.ex_skill_1.Midori, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-10, 200, -25);
					pos = vectors.vec3(-12, 7, -28);
				};

				fin = {
					rot = vectors.vec3(10, 40, 0);
					pos = vectors.vec3(4, 18, 15);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.Midori.MidoriUpperBody.MidoriArms.MidoriLeftArm.MidoriLeftArmBottom.GameConsole2:addChild(ModelAlias.alias.avatar.leftArmBottom.GameConsole1:copy("GameConsole2"))
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI:newText("ex_skill_1_ko"):setText("§cK.O."):setScale(1.5, 1.5, 1.5):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.33, 0, 0):setVisible(false)
							models.models.ex_skill_1.Gui.TextAnchor:newText("ex_skill_1:text"):setText("§d§lMOMOI"):setScale(4, 4, 4):setAlignment("RIGHT"):setOutline(true):setOutlineColor(1, 1, 1)
							models.models.ex_skill_1.Gui.UI.MomoiUI.Background:setColor(0.71, 0.082, 0.067)
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.YellowBar, models.models.ex_skill_1.Gui.UI.MomoiUI.RedBar}) do
								modelPart:setPrimaryRenderType("EMISSIVE_SOLID")
							end
							models.models.ex_skill_1.Gui.UI.MomoiUI:newText("ex_skill_1_momoi_name"):setText("§d§lMOMOI"):setPos(130, 13, 0):setScale(1.5, 1.5, 1.5):setOutline(true):setOutlineColor(1, 1, 1)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setScale(2.3, 2.3, 2.3)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:addChild(ModelUtils:copyModel(models.script_head_block.Skull, "MomoiPaperDollHead"))
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:getTruePivot():add(0, -24, 0))
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.Halo:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts:addChild(ModelAlias.alias.avatar.mouth:copy("Mouth"))
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(144, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setVisible(true)
							models.models.ex_skill_1.Gui.UI.DeadEye:moveTo(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts)
							for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:getChildren()) do
								modelPart:setVisible(false)
							end
							models.models.ex_skill_1.Gui.UI:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Gui.UI.MomoiUI, "MidoriUI"))
							for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:getChildren()) do
								modelPart:setVisible(true)
							end
							models.models.ex_skill_1.Gui.UI.MidoriUI.Frame:setRot(0, 180, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.Background:setPos(-139.5, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.Background:setColor(0.098, 0.2, 0.686)
							models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setPos(36, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setOffsetPivot(-135, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setScale(0.7, 1, 1)
							models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setPrimaryRenderType("EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MidoriUI.RedBar:remove()
							models.models.ex_skill_1.Gui.UI.MidoriPaperDollBody:moveTo(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollBody:setPos(-139, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setPos(0, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setRot(0, -15, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setOffsetPivot(-139, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Midori.MidoriHead, "MidoriPaperDollHead"))
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:getTruePivot():add(0, -24, 0))
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.MidoriHeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MidoriUI:newText("ex_skill_1_midori_name"):setText("§a§lMIDORI"):setPos(48, 13, 0):setScale(1.5, 1.5, 1.5):setOutline(true):setOutlineColor(1, 1, 1):setAlignment("RIGHT")
						end
						self.exSkill.primary.isInitialized = true
					end
					if host:isHost() then
						models.models.ex_skill_1.Gui.UI.MidoriUI:setPos(client:getScaledWindowSize().x * -1 + 220, 0, 0)
					end
				end;

				onAnimationTick = function (_, tick)
					if tick == 0 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "FUN", 16, true)
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.5)
					elseif tick == 1 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.75)
					elseif tick == 2 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 2)
					elseif tick == 14 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.RightEye, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye}) do
							modelPart:setUVPixels(12, 0)
						end
					elseif tick == 16 then
						FaceParts:setEmotion("ANXIOUS", "ANXIOUS", "ANXIOUS", 24, true)
					elseif tick == 24 then
						Character04a_ExSkill1TextObjectManager:spawn("4")
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor(1, 0.75, 0.75)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye:setUVPixels(6, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye:setUVPixels(12, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 0)
						end
					elseif tick == 27 and host:isHost() then
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor()
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye}) do
							modelPart:setUVPixels()
						end
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(144, 0)
					elseif tick == 31 then
						Character04a_ExSkill1TextObjectManager:spawn("3")
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor(1, 0.75, 0.75)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye:setUVPixels(6, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye:setUVPixels(12, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 0)
						end
					elseif tick == 34 and host:isHost() then
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor()
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye}) do
							modelPart:setUVPixels()
						end
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(144, 0)
					elseif tick == 36 then
						Character04a_ExSkill1TextObjectManager:spawn("5")
						local playerPos = player:getPos()
						sounds:playSound("minecraft:entity.generic.hurt", playerPos, 0.25, 1)
						sounds:playSound("minecraft:entity.player.levelup", playerPos, 1, 1.5)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor(1, 0.75, 0.75)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes:setVisible(false)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(80, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.DeadEye:setVisible(true)
							local task = models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko")
							task:setPos(client:getScaledWindowSize().x / 2 * -1, -12, -30)
							task:setVisible(true)
							events.RENDER:register(function (delta)
								local count = ExSkill.animationCount - 37 + delta
								task:setScale(vectors.vec3(1, 1, 1):scale(count <= 1.5 and (-1.667 * count + 5) or (count + 1)))
							end, "ex_skill_1_ko_render")
						end
					elseif tick == 38 then
						models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.RightEye:setUVPixels(24, 0)
						models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye:setUVPixels(18, 0)
						if host:isHost() then
							events.RENDER:remove("ex_skill_1_ko_render")
							models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko"):setScale(3, 3, 3)
						end
					elseif tick == 40 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "ANXIOUS", 3, true)
						models.models.ex_skill_1.Midori.MidoriUpperBody.MidoriArms.MidoriLeftArm.MidoriLeftArmBottom.GameConsole2:moveTo(models.models.ex_skill_1.Midori.MidoriLowerBody.MidoriLegs)
						for _, modelPart in ipairs({models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.RightEye, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye}) do
							modelPart:setUVPixels()
						end
					elseif tick == 43 then
						FaceParts:setEmotion("SURPRISED2", "SURPRISED2", "SHOCK", 24, true)
					elseif tick == 66 then
						models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.RightEye:setUVPixels(24, 0)
						models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye:setUVPixels(18, 0)
					elseif tick == 67 then
						models.models.ex_skill_1.Gui.UI:setVisible(false)
						FaceParts:setEmotion("ANGRY", "ANGRY2", "ANGRY", 41, true)
						ModelAlias.alias.avatar.head.EffectPanel:setUVPixels(9, 0)
						if host:isHost() then
							models.models.ex_skill_1.Gui.TextAnchor:setVisible(true)
							events.RENDER:register(function ()
								local windowSize = client:getScaledWindowSize()
								models.models.ex_skill_1.Gui.TextAnchor:setPos(models.models.ex_skill_1.Gui.TextAnchor:getAnimPos():scale(windowSize.y / 2 / 100):add(0, windowSize.y * -1 + 30, 0))
							end, "ex_skill_1_text_render")
						end
					elseif tick == 83 then
						sounds:playSound("minecraft:entity.generic.explode", player:getPos(), 0.25, 0.5)
					end
					if tick <= 38 and math.random() >= 0.75 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 0.1, 2)
					end
					if tick <= 38 and tick % 3 == 0 and host:isHost() then
						sounds:playSound("minecraft:entity.player.attack.nodamage", player:getPos(), 0.25, 1)
					end
				end;

				onPostAnimation = function (_, forcedStop)
					for _, modelPart in ipairs({ModelAlias.alias.avatar.head.EffectPanel, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.RightEye, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye}) do
						modelPart:setUVPixels()
					end
					if models.models.ex_skill_1.Midori.MidoriLowerBody.MidoriLegs.GameConsole2 ~= nil then
						models.models.ex_skill_1.Midori.MidoriLowerBody.MidoriLegs.GameConsole2:moveTo(models.models.ex_skill_1.Midori.MidoriUpperBody.MidoriArms.MidoriLeftArm.MidoriLeftArmBottom)
					end
					if host:isHost() then
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes}) do
							modelPart:setVisible(true)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.DeadEye, models.models.ex_skill_1.Gui.TextAnchor}) do
							modelPart:setVisible(false)
						end
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(144, 0)
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor()
						models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko"):setVisible(false)
						for _, eventName in ipairs ({"ex_skill_1_text_render", "ex_skill_1_ko_render"}) do
							events.RENDER:remove(eventName)
						end
						if forcedStop then
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye}) do
								modelPart:setUVPixels()
							end
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
					ModelAlias.alias.avatar.head.EffectPanel:setPos(0, 0, isVisible and -1 or 0)
				elseif parts == "LEGGINGS" then
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
						FaceParts:setEmotion("NORMAL", "NORMAL", "FUN", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SHOCK", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("ANGRY", "ANGRY2", "ANGRY", duration, true)
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
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
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
		---Exスキルで使用するテキストオブジェクトのマネージャークラス
		---@type Character04a.ExSkill1TextObject
		Character04a_ExSkill1TextObject = require("scripts.ex_skill_1_text_object")

		---Exスキルで使用するテキストオブジェクトのマネージャークラス
		---@type Character04a.ExSkill1TextObjectManager
		Character04a_ExSkill1TextObjectManager = require("scripts.ex_skill_1_text_object_manager")
		Character04a_ExSkill1TextObjectManager = Character04a_ExSkill1TextObjectManager.new()

		Character04a_ExSkill1TextObjectManager.init()
	end;
}

return BlueArchiveCharacter
