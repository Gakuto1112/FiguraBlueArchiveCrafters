---右目のテクスチャの列挙型
---@alias Character03a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "NARROW1" # 狭めの目1
---| "NARROW2" # 狭めの目2
---| "CLOSED2" # 横線目
---| "INVERTED" # 反対側を見る目
---| "TEAR" # 横線目+涙
---| "UNEQUAL" # ><

---左目のテクスチャの列挙型
---@alias Character03a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "NARROW1" # 狭めの目1
---| "NARROW2" # 狭めの目2
---| "CLOSED2" # 横線目
---| "INVERTED" # 反対側を見る目
---| "TEAR" # 横線目+涙
---| "UNEQUAL" # ><

---口のテクスチャの列挙型
---@alias Character03a.MouthTextures
---| "NORMAL" # 通常
---| "CLOSED" # 閉じた口
---| "SMILE" # にっこり
---| "OPENED" # 開いた口1
---| "ANXIOUS" # への口
---| "TRIANGLE" # 三角口1
---| "TRIANGLE2" # 三角口2
---| "TIRED" # げっそり口
---| "OPENED2" # 開いた口2
---| "SMALL" # 小さく開いた口
---| "TRIANGLE3" # 三角口3

---@class (exact) Character03a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character03a.RightEyeTextures 右目の表情名
---@field public leftEye Character03a.LeftEyeTextures 左目の表情名
---@field public mouth Character03a.MouthTextures 口の表情名

---@class (exact) Character03a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character03a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character03a.EmotionSet ベッドで寝ているとき

---@class (exact) Character03a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character03a, right: Character03a.RightEyeTextures, left: Character03a.LeftEyeTextures, mouth: Character03a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character03a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character03a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character03a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character03a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character03a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character03a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character03a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character03a.FacePartsStruct 目や口による表情

---@type Character03a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "03a_Mari";

		birth = {
			month = 9;
			day = 12;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			NARROW1 = vectors.vec2(5, 0);
			NARROW2 = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(8, 0);
			INVERTED = vectors.vec2(9, 0);
			TEAR = vectors.vec2(11, 0);
			UNEQUAL = vectors.vec2(12, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			NARROW1 = vectors.vec2(5, 0);
			NARROW2 = vectors.vec2(6, 0);
			CLOSED2 = vectors.vec2(7, 0);
			INVERTED = vectors.vec2(9, 0);
			TEAR = vectors.vec2(10, 0);
			UNEQUAL = vectors.vec2(11, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(1, 0);
			SMILE = vectors.vec2(2, 0);
			OPENED = vectors.vec2(3, 0);
			ANXIOUS = vectors.vec2(4, 0);
			TRIANGLE = vectors.vec2(5, 0);
			TRIANGLE2 = vectors.vec2(6, 0);
			TIRED = vectors.vec2(7, 0);
			OPENED2 = vectors.vec2(8, 0);
			SMALL = vectors.vec2(9, 0);
			TRIANGLE3 = vectors.vec2(0, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Robe};
	};

	gun = {
		scale = 0.75;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-0.5, 0, -5);
					left = vectors.vec3(1, 0, -5);
				};

				thirdPersonPos = {
					right = vectors.vec3(0, -0.5, -5);
					left = vectors.vec3(0, -0.5, -5);
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
			formationType = "SPECIAL";

			models = {};

			animations = {"main"};

			camera = {
				start = {
					rot = vectors.vec3(0, 150, -3);
					pos = vectors.vec3(25, 25, -21);
				};

				fin = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(0, 23, -36);
				};
			};

			callbacks = {
				onAnimationTick = function (_, tick)
					if tick == 0 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 14, true)
					elseif tick == 5 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root.ExSkillParticleAnchor1)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 30 do
							particles:newParticle("minecraft:cherry_leaves", anchorPos:copy():add(math.random() - 0.5, math.random() * 2 - 1, math.random() - 0.5)):setColor(0.2, 1, 0.2):setVelocity(vectors.rotateAroundAxis(-bodyYaw, 0.1, 0, 0, 0, 1, 0))
						end
					elseif tick == 14 then
						FaceParts:setEmotion("NARROW1", "NARROW1", "CLOSED", 2, true)
					elseif tick == 16 then
						FaceParts:setEmotion("NARROW2", "NARROW2", "CLOSED", 2, true)
					elseif tick == 18 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 66, true)
					elseif tick == 59 then
						local playerPos = player:getPos()
						for _ = 1, 100 do
							particles:newParticle("minecraft:dust 1 1 1 1", playerPos:copy():add(math.random() * 4 - 2, 0, math.random() * 4 - 2)):setColor(1, 1, 1):setLifetime(100)
						end
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root.ExSkillParticleAnchor3)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 50 do
							particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy():add(vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(math.random() * 360, 0, 1.25, 0, 0, 0, 1), 0, 1, 0))):setColor(1, 1, 1):setVelocity(vectors.rotateAroundAxis(-bodyYaw, 0, 0, math.random() * 0.1 + 0.05, 0, 1, 0)):setLifetime(40)
						end
						sounds:playSound("minecraft:block.beacon.activate", playerPos, 1, 1.5)
					end
					if tick >= 24 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightArmBottom.ExSkillParticleAnchor2)
						for _ = 1, 2 do
							particles:newParticle("minecraft:wax_off", anchorPos:copy():add(math.random() * 0.4 - 0.2, 0, math.random() * 0.4 - 0.2)):setScale(0.15):setVelocity(0, math.random() * 0.025, 0):setColor(1, 1, 0.875)
						end
					end
					if tick % 3 == 0 and tick <= 50 then
						sounds:playSound("minecraft:entity.parrot.ambient", player:getPos(), (50 - tick) / 50, 1.5)
					end
				end
			};
		};
	};

	costume = {
		isAltCostumeEnabled = true;

		callbacks = {
			onAltChange = function (_, isAlt)
				for _, modelPart in ipairs({ModelAlias.alias.avatar.head.Veil, ModelAlias.alias.avatar.body.VeilBody}) do
					modelPart:setVisible(not isAlt)
				end
				ModelAlias.alias.avatar.head.Ears:setVisible(isAlt)
			end;

			onArmorChange = function (_, parts, isVisible)
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.FrontHair:setPos(0, 0, isVisible and -1 or 0)
					ModelAlias.alias.avatar.body.VeilBody:setPos(0, 0, isVisible and 1 or 0)
				elseif parts == "LEGGINGS" then
					for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Robe, models.models.main.Avatar.UpperBody.Body.BackRibbon}) do
						modelPart:setVisible(not isVisible)
					end
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("TEAR", "TEAR", "TIRED", duration, true)
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
		includeModels = {models.models.main.Avatar.UpperBody.Body.FrontHair, models.models.main.Avatar.UpperBody.Body.VeilBody};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function (_, isAltCostume)
				if isAltCostume then
					for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.head.Ears.RightEarPivot, ModelAlias.alias.dummy_avatar.head.Ears.LeftEarPivot}) do
						modelPart:setRot(-30, 0, 0)
					end
				else
					for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.head.Veil.VeilEar.RightVeilEarPivot, ModelAlias.alias.dummy_avatar.head.Veil.VeilEar.LeftVeilEarPivot}) do
						modelPart:setRot(-30, 0, 0)
					end
				end
				ModelAlias.alias.dummy_avatar.lowerBody:setVisible(false)
				ModelAlias.alias.dummy_avatar.body.Robe:setRot()
				ModelAlias.alias.dummy_avatar.body.Robe:setScale(1.85, 0.35, 2)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.lowerBody:setVisible(true)
				ModelAlias.alias.dummy_avatar.body.Robe:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Robe:setScale(1.2, 1, 1)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.VeilBody};

				x = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -160;
							min = -80;
							max = 0;
						};

						bodyY = {
							multiplayer = 160;
							min = -80;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.1;
							min = -80;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.FrontHair};

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
				models = {ModelAlias.alias.avatar.body.BackRibbon.BackRibbonBottom};

				x = {
					vertical = {
						min = -150;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = -65;
							max = 0;
						};

						bodyY = {
							multiplayer = 160;
							min = -150;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.1;
							min = -65;
							max = 0;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		ModelAlias.alias.avatar.head.Ears:setVisible(false)

		---前ティックに脚とスカートの調整をしたかどうか
		---@type boolean
		local shouldAdjustLegsPrev = false;

		---前ティックは脚を隠すべきだったかどうか
		---@type boolean
		local shouldHideLegsPrev = false;

		events.TICK:register(function ()
			if not client:isPaused() then
				local robeVisible = ModelAlias.alias.avatar.body.Robe:getVisible()
				local shouldHideLegs = robeVisible and player:getVehicle() ~= nil
				if shouldHideLegs and not shouldHideLegsPrev then
					ModelAlias.alias.avatar.legs:setVisible(false)
					ModelAlias.alias.avatar.body.Robe:setScale(1.85, 0.35, 2)
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Robe, ModelAlias.alias.avatar.body.Robe.Robe2, ModelAlias.alias.avatar.body.Robe.Robe2.Robe3}) do
						modelPart:setScale()
					end
				elseif not shouldHideLegs and shouldHideLegsPrev then
					ModelAlias.alias.avatar.legs:setVisible(true)
					ModelAlias.alias.avatar.body.Robe:setScale()
				end

				local shouldAdjustLegs = robeVisible and not shouldHideLegs
				if shouldAdjustLegs and not shouldAdjustLegsPrev then
					events.RENDER:register(function ()
						local rightLegRotX = vanilla_model.RIGHT_LEG:getOriginRot().x
						ModelAlias.alias.avatar.legs.RightLeg:setRot(rightLegRotX * -0.55, 0, 0)
						ModelAlias.alias.avatar.legs.LeftLeg:setRot(vanilla_model.LEFT_LEG:getOriginRot().x * -0.55, 0, 0)
						local rightLegRotAbs = math.abs(rightLegRotX)
						ModelAlias.alias.avatar.body.Robe:setScale(1, 1, rightLegRotAbs * 0.0025 + 1)
						local robeScale2 = vectors.vec3(rightLegRotAbs * -0.000625 + 1, 1, rightLegRotAbs * 0.00125 + 1)
						ModelAlias.alias.avatar.body.Robe.Robe2:setScale(robeScale2)
						ModelAlias.alias.avatar.body.Robe.Robe2.Robe3:setScale(robeScale2)
					end, "costume_default_render")
				elseif not shouldAdjustLegs and shouldAdjustLegsPrev then
					events.RENDER:remove("costume_default_render")
					for _, modelPart in ipairs({ModelAlias.alias.avatar.rightLeg, ModelAlias.alias.avatar.leftLeg}) do
						modelPart:setRot()
					end
					if not shouldHideLegs then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Robe, ModelAlias.alias.avatar.body.Robe.Robe2, ModelAlias.alias.avatar.body.Robe.Robe2.Robe3}) do
							modelPart:setScale()
						end
					end
				end

				shouldHideLegsPrev = shouldHideLegs
				shouldAdjustLegsPrev = shouldAdjustLegs
			end
		end)
	end;
}

return BlueArchiveCharacter
