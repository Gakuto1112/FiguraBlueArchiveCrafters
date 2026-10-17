---右目のテクスチャの列挙型
---@alias Character14a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "UNEQUAL" # 不等号目（><）
---| "INVERTED" # 反対側を見る目
---| "ANGRY" # 怒った目
---| "CLOSED2" # 閉じた目2
---| "FEAR" # 恐怖を感じているときの目
---| "FEAR_CENTER" # 恐怖を感じてつつ少し反対側を見る目
---| "CLOSED2_WITH_TEAR" # 涙ぐみつつ閉じた目2

---左目のテクスチャの列挙型
---@alias Character14a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "UNEQUAL" # 不等号目（><）
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "FEAR" # 恐怖を感じているときの目
---| "FEAR_CENTER" # 恐怖を感じてつつ少し反対側を見る目
---| "CLOSED2_WITH_TEAR" # 涙ぐみつつ閉じた目2
---| "ANGRY" # 怒った目
---| "INVERTED" # 反対側を見る目

---口のテクスチャの列挙型
---@alias Character14a.MouthTextures
---| "NORMAL" # 通常
---| "SHOCK" # あんぐり口
---| "FRUST" # ぐにゅぐにゅ口
---| "SMALL" # 小さく開けた口
---| "CLOSED" # 閉じた口
---| "ANGRY" # 怒った口
---| "FEAR" # 恐怖を感じているときの口
---| "SMILE" # にっこり
---| "OPENED" # 開いた口

---@class (exact) Character14a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character14a.RightEyeTextures 右目の表情名
---@field public leftEye Character14a.LeftEyeTextures 左目の表情名
---@field public mouth Character14a.MouthTextures 口の表情名

---@class (exact) Character14a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character14a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character14a.EmotionSet ベッドで寝ているとき

---@class (exact) Character14a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character14a, right: Character14a.RightEyeTextures, left: Character14a.LeftEyeTextures, mouth: Character14a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character14a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character14a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character14a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character14a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character14a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character14a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character14a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character14a.FacePartsStruct 目や口による表情

---@type Character14a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "14a_Yuzu";

		birth = {
			month = 8;
			day = 12;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			UNEQUAL = vectors.vec2(5, 0);
			INVERTED = vectors.vec2(6, 0);
			ANGRY = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(9, 0);
			FEAR = vectors.vec2(10, 0);
			FEAR_CENTER = vectors.vec2(11, 0);
			CLOSED2_WITH_TEAR = vectors.vec2(12, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			UNEQUAL = vectors.vec2(4, 0);
			ANGRY_INVERTED = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(8, 0);
			FEAR = vectors.vec2(9, 0);
			FEAR_CENTER = vectors.vec2(10, 0);
			CLOSED2_WITH_TEAR = vectors.vec2(11, 0);
			ANGRY = vectors.vec2(12, 0);
			INVERTED = vectors.vec2(13, 0);
		};

		mouth = {
			SHOCK = vectors.vec2(0, 0);
			FRUST = vectors.vec2(1, 0);
			SMALL = vectors.vec2(2, 0);
			CLOSED = vectors.vec2(3, 0);
			ANGRY = vectors.vec2(4, 0);
			FEAR = vectors.vec2(5, 0);
			SMILE = vectors.vec2(6, 0);
			OPENED = vectors.vec2(7, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 0.8;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 3, -4);
					left = vectors.vec3(0, 3, -4);
				};

				thirdPersonPos = {
					right = vectors.vec3(-2.25, 3, -4.5);
					left = vectors.vec3(2.25, 3, -4.5);
				};
			};

			put = {
				type = "HIDDEN";
			};
		};

		sound = {
			name = "minecraft:entity.arrow.shoot";
			pitch = 0.5;
		};

		---武器のアニメーション用のティック変数
		---@type integer
		animationTick = 0;

		---前ティックの銃の位置
		---@type Gun.GunPosition
		gunPositionPrev = "NONE";
	};

	placementObjects = {
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.head.ShineRing};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-10, 130, 0);
					pos = vectors.vec3(9, 22, -12.7);
				};

				fin = {
					rot = vectors.vec3(0, 180, -15);
					pos = vectors.vec3(0, 24, -16.7);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						if host:isHost() then
							models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:newText("ex_skill_1_action_text"):setAlignment("CENTER"):setOutlineColor(0.33, 1, 1)
							models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:newText("ex_skill_1_cancel_text"):setText("CANCEL"):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.33, 1, 1)
							models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionBackground:setColor(0.055, 0.341, 0.702)
							models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelBackground:setColor(0.698, 0.016, 0.184)
							models.models.ex_skill_1.Gui.NameArea:setScale(4, 4, 4)
							models.models.ex_skill_1.Gui.NameArea.NameAreaRight:newText("ex_skill_1_name_text_1"):setText("§lYUZU"):setPos(30, 5.5, -1):setScale(1.2, 1.2, 1):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.33, 1, 1)
							models.models.ex_skill_1.Gui.NameArea.NameAreaRight:newText("ex_skill_1_name_text_2"):setText("§lYUZU"):setPos(30, 4.5, -0.5):setScale(1.2, 1.2, 1):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.33, 0.5, 0.5)
						end
						self.exSkill.primary.isInitialized = true
					end
					if host:isHost() then
						local randomNum = math.random()
						self.exSkill.primary.actionTextIndex = randomNum < 0.95 and 1 or (randomNum < 0.975 and 2 or 3)
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setText("§7"..(self.exSkill.primary.actionTextIndex == 1 and "ACTION" or (self.exSkill.primary.actionTextIndex == 2 and "MINE" or "CRAFT")))
						models.models.ex_skill_1.Gui.NameArea:setPos(client:getScaledWindowSize():scale(-1):augmented(0))
					end
					FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SHOCK", 9, true)
					sounds:playSound("minecraft:ui.toast.in", player:getPos(), 1, 1)
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun.Grenade:setVisible(true)
						ModelAlias.alias.avatar.gun.GameDisplay.Display:setColor(0, 0, 0)
						ModelAlias.alias.avatar.gun.GameDisplay.DisplayFlash:setVisible(true)
						ModelAlias.alias.avatar.gun:setVisible(true)
					end

					if tick == 8 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.GameDisplay.ExSkill1ParticleAnchor)
						for i = -2, 5 do
							particles:newParticle("minecraft:electric_spark", anchorPos):setScale(0.25):setVelocity(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0.01, i * 0.01, -0.025, 0, 1, 0)):setColor(0.996, 1, 0.039)
						end
						sounds:playSound("minecraft:block.chiseled_bookshelf.insert", anchorPos, 0.5, 5)
					elseif tick == 9 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "FRUST", 9, true)
					elseif tick == 18 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "FRUST", 8, true)
					elseif tick == 21 then
						ModelAlias.alias.avatar.gun.GameDisplay.Display:setColor()
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.GameDisplay), 0.25, 2)
						if host:isHost() then
							models.models.ex_skill_1.Background:setVisible(true)
							local barWidthScale = 0.135 * client:getScaledWindowSize().x
							for _, modelPart in ipairs({models.models.ex_skill_1.Background.Background2.Action.ActionBackground, models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground}) do
								modelPart:setScale(barWidthScale, 1, 1)
							end
							for _, modelPart in ipairs({models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor, models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor}) do
								modelPart:setPos(1 / barWidthScale * -15, 0, 0)
							end
							models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setPos(0, 1.4, 0)
							models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:getTask("ex_skill_1_cancel_text"):setPos(0, 1.4, 0)
							events.RENDER:register(function ()
								local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw() + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.3)), 0, 1, 0):scale(16 / 0.9375)
								models.models.ex_skill_1.Background:setOffsetPivot(backgroundPos)
								models.models.ex_skill_1.Background.Background2:setPos(backgroundPos)
								models.models.ex_skill_1.Background.Background2:setRot(0, 0, renderer:getCameraRot().z)
								local actionTextScale = models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getScale().x
								models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setScale(vectors.vec3(1 / barWidthScale, 1, 1):scale(0.4 * actionTextScale))
								local cancelTextScale = models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:getScale().x
								models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:getTask("ex_skill_1_cancel_text"):setScale(vectors.vec3(1 / barWidthScale, 1, 1):scale(0.4 * cancelTextScale))
							end, "ex_skill_1_background_render")
						end
					elseif tick == 26 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "FRUST", 3, true)
					elseif tick == 29 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "SMALL", 4, true)
					elseif tick == 33 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "SMALL", 2, true)
					elseif tick == 31 and host:isHost() then
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setText(self.exSkill.primary.actionTextIndex == 1 and "ACTION" or (self.exSkill.primary.actionTextIndex == 2 and "MINE" or "CRAFT")):setOutline(true)
						models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:getTask("ex_skill_1_cancel_text"):setText("§7CANCEL"):setOutline(false)
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionBackground:setVisible(true)
						models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelBackground:setVisible(false)
						sounds:playSound("minecraft:ui.button.click", player:getPos(), 0.25, 1.5)
					elseif tick == 35 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "SMALL", 2, true)
					elseif tick == 36 and host:isHost() then
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setOutlineColor(1, 1, 1)
						sounds:playSound("minecraft:ui.button.click", player:getPos(), 0.5, 1)
					elseif tick == 38 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "CLOSED", 16, true)
					elseif tick == 40 and host:isHost() then
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setOutlineColor(0.33, 1, 1)
					elseif tick == 44 and host:isHost() then
						events.RENDER:remove("ex_skill_1_background_render")
						models.models.ex_skill_1.Background:setVisible(false)
					elseif tick == 47 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					elseif tick == 54 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 2, true)
					elseif tick == 56 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "CLOSED", 2, true)
					elseif tick == 58 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "ANGRY", 28, true)
						if host:isHost() then
							models.models.ex_skill_1.Gui:setVisible(true)
							events.RENDER:register(function ()
								local windowSize = client:getScaledWindowSize()
								models.models.ex_skill_1.Gui.NameArea.NameAreaLeft:setPos(models.models.ex_skill_1.Gui.NameArea.NameAreaLeftAnchor:getAnimPos().x * (windowSize.x / 427), 24.5, 0)
								models.models.ex_skill_1.Gui.NameArea.NameAreaRight:setPos(models.models.ex_skill_1.Gui.NameArea.NameAreaRightAnchor:getAnimPos().x * (windowSize.x / 427), 17, 0)
							end, "ex_skill_1_name_render")
						end
					elseif tick == 61 then
						for i = 0, 5 do
							Character14a_ExSkill1ItemObjectManager:spawn("ITEM", i * 60 + math.random() * 60 - 30)
						end
						for _ = 1, 5 do
							Character14a_ExSkill1ItemObjectManager:spawn("CROSS")
						end
						for _ = 1, 10 do
							Character14a_ExSkill1ItemObjectManager:spawn("DOT")
						end
					elseif tick == 70 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.5)
					elseif tick == 72 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.75)
					elseif tick == 74 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 2)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
					ModelAlias.alias.avatar.gun.Grenade:setVisible(false)
					ModelAlias.alias.avatar.gun.GameDisplay.Display:setColor()
					ModelAlias.alias.avatar.gun.GameDisplay.DisplayFlash:setVisible(false)
					ModelAlias.alias.avatar.gun:setVisible(Gun.currentGunPosition ~= "NONE")

					if host:isHost() then
						events.RENDER:remove("ex_skill_1_name_render")
						models.models.ex_skill_1.Gui:setVisible(false)
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setOutline(false)
						models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:getTask("ex_skill_1_cancel_text"):setText("CANCEL"):setOutline(true)
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionBackground:setVisible(false)
						models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelBackground:setVisible(true)
					end
					if forcedStop then
						Character14a_ExSkill1ItemObjectManager:removeAll()
						if host:isHost() then
							events.RENDER:remove("ex_skill_1_background_render")
							models.models.ex_skill_1.Background:setVisible(false)
							models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setOutlineColor(0.33, 1, 1)
						end
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---「Action」の項目に出すテキスト
			---1.ACTION, 2.MINE, 3.CRAFT
			---@type integer
			actionTextIndex = 1;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.HairTip2:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, isVisible and -1 or 0)
					ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, isVisible and 1 or 0)
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
						FaceParts:setEmotion("ANGRY", "ANGRY", "CLOSED", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "FRUST", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("FEAR", "FEAR", "FEAR", duration, true)
						ModelAlias.alias.avatar.head.FearEffect:setVisible(true)
					end
				end
			end;

			onStop = function(_, _, forcedStop)
				ModelAlias.alias.avatar.head.FearEffect:setVisible(false)
				if forcedStop then
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
			onBeforeModelCopy = function ()
				ModelAlias.alias.avatar.head.FearEffect:setVisible(false)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setPos(0, 0.5, 0.5)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-15, 0, -15)
				ModelAlias.alias.dummy_avatar.rightLegBottom:setOffsetPivot(0, 0, -2)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
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
						min = -80;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = -80;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -80;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -80;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTip1.HairTipCore},

				z = {
					vertical = {
						min = -20;
						neutral = 32.5;
						max = 60;
					};

					horizontal = {
						min = -20;
						neutral = 32.5;
						max = 60;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTip1.HairTipCore.HairTipCoreZPivot},

				y = {
					vertical = {
						min = -10;
						neutral = 0;
						max = 10;
					};

					horizontal = {
						min = -10;
						neutral = 0;
						max = 10;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTip2};

				x = {
					vertical = {
						min = -15;
						neutral = 52.5;
						max = 82.5;

						bodyY = {
							multiplayer = -40;
							min = -15;
							max = 82.5;
						};
					};

					horizontal = {
						min = -15;
						neutral = 52.5;
						max = 82.5;

						bodyX = {
							multiplayer = -80;
							min = -15;
							max = 82.5;
						};
					};
				};

				y = {
					vertical = {
						min = -40;
						neutral = -40;
						max = -40;
					};

					horizontal = {
						min = -40;
						neutral = -40;
						max = -40;
					};
				};
			};
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model:getName():match("^HairTipCore") then
					local playerPose = player:getPose()
					local isHorizontal = playerPose == "SWIMMING" or playerPose == "FALL_FLYING"
					local velocityY = math.clamp(Physics.velocityAverage[1][2] * -40, -20, 20)
					local velocityZ = math.clamp(Physics.velocityAverage[2][2] * (isHorizontal and 160 or -40), -20, 60)
					local lookRotY = math.deg(math.asin(player:getLookDir().y)) / 90
					local rotY = velocityZ * (1 - math.abs(lookRotY)) * -1 + velocityY * lookRotY
					local rotZ = velocityY * (1 - math.abs(lookRotY)) * -1 + velocityZ * lookRotY
					if model == ModelAlias.alias.avatar.head.HairTip1.HairTipCore then
						ModelAlias.alias.avatar.head.HairTip1.HairTipCore:setRot(0, 0, (isHorizontal and rotZ or rotY) + 32.5)
					elseif model == ModelAlias.alias.avatar.head.HairTip1.HairTipCore.HairTipCoreZPivot then
						ModelAlias.alias.avatar.head.HairTip1.HairTipCore.HairTipCoreZPivot:setRot(0, isHorizontal and rotY or rotZ, 0)
					end
				end
			end
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	---@param self Character14a
	init = function (self)
		---Exスキル1で使用するアイテムオブジェクトインスタンスのクラス
		---@type Character14a.ExSkill1ItemObject
		Character14a_ExSkill1ItemObject = require("scripts.ex_skill_1_item_object")

		---Exスキル1で使用するアイテムオブジェクトマネージャーのクラス
		---@type Character14a.ExSkill1ItemObjectManager
		Character14a_ExSkill1ItemObjectManager = require("scripts.ex_skill_1_item_object_manager")
		Character14a_ExSkill1ItemObjectManager = Character14a_ExSkill1ItemObjectManager.new()

		Character14a_ExSkill1ItemObjectManager.init()

        events.TICK:register(function ()
            if not client:isPaused() then
                if Gun.currentGunPosition ~= "NONE" or ExSkill.animationCount >= 0 then
                    if self.gun.animationTick % 4 == 0 then
                        local frame = self.gun.animationTick / 4
						ModelAlias.alias.avatar.gun.GameDisplay.Display:setUVPixels(37 * (frame % 2), 15 * (math.floor(frame / 2)))
                    end
                    self.gun.animationTick = self.gun.animationTick == 15 and 0 or self.gun.animationTick + 1
                elseif Gun.currentGunPosition == "NONE" and self.gun.gunPositionPrev ~= "NONE" then
                    ModelAlias.alias.avatar.gun.GameDisplay.Display:setUVPixels()
                    self.gun.animationTick = 0
                end
                self.gun.gunPositionPrev = Gun.currentGunPosition
            end
        end)
	end;
}

return BlueArchiveCharacter
