---口のテクスチャの列挙型
---@alias Character01b.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "TRIANGLE" # 三角形の口
---| "SMILE" # にっこり
---| "WORRY" # 困った口

---@class (exact) Character01b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye BlueArchiveCharacter.RightEyeTextures 右目の表情名
---@field public leftEye BlueArchiveCharacter.LeftEyeTextures 左目の表情名
---@field public mouth Character01b.MouthTextures 口の表情名

---@class (exact) Character01b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character01b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character01b.EmotionSet ベッドで寝ているとき

---@class (exact) Character01b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character01b, right: BlueArchiveCharacter.RightEyeTextures, left: BlueArchiveCharacter.LeftEyeTextures, mouth: Character01b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character01b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[BlueArchiveCharacter.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[BlueArchiveCharacter.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character01b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character01b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character01b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character01b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character01b.FacePartsStruct 目や口による表情

---@type Character01b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "01b_Shizuko_Swimsuit";

		birth = {
			month = 7;
			day = 7;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
		};

		mouth = {
			OPENED = vectors.vec2(1, 0);
			TRIANGLE = vectors.vec2(2, 0);
			SMILE = vectors.vec2(3, 0);
			WORRY = vectors.vec2(0, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 1, -7);
					left = vectors.vec3(0, 1, -7);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.5, -0.25, -8);
					left = vectors.vec3(1.5, -0.25, -8);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(-1.5, 4, 3.5);
					left = vectors.vec3(1.5, 4, 3.5);
				};

				rot = {
					right = vectors.vec3(0, 90, -45);
					left = vectors.vec3(45, -90, 0);
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

			models = {models.models.ex_skill_1.Plate, models.models.ex_skill_1.Gui, ModelAlias.alias.avatar.head.WinkEffect};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					pos = vectors.vec3(35.5, 25, 10),
					rot = vectors.vec3(-10, 210, 0)
				};

				fin = {
					pos = vectors.vec3(8.9, 29, -13.25),
					rot = vectors.vec3(10, 170, -5)
				};
			};

			callbacks = {
				onPreTransition = function ()
					for _, modelPart in ipairs({models.models.ex_skill_1.Stall, models.models.ex_skill_1.SoftCream}) do
						modelPart:setVisible(true)
					end
				end;

				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.Plate.ShavedIceGroup.Wave:setPrimaryTexture("RESOURCE", "minecraft:textures/block/water_flow.png")
						models.models.ex_skill_1.Plate.ShavedIceGroup.Wave:setColor(0.4, 0.961, 1)
						self.exSkill.primary.isInitialized = true
					end
					for _, modelPart in ipairs({models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce1, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce2, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce3, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce4, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce5, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
						modelPart:setUVPixels(1, 0)
					end
					if host:isHost() then
						local windowSize = client:getScaledWindowSize()
						models.models.ex_skill_1.Gui.Frame:setScale(windowSize.x, windowSize.y)
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.Frame:setOpacity(models.models.ex_skill_1.Gui.FrameOpacity:getAnimScale().x)
						end, "ex_skill_1_render")
					end
					FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 71, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 9 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce1, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce2, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce3, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce4, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce5, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
							modelPart:setUVPixels(2, 0)
						end
					elseif tick == 12 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce1, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce2, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce3, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce4, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce5, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
							modelPart:setUVPixels(3, 0)
						end
					elseif tick == 16 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce1, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce2, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce3, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce4, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce5, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
							modelPart:setUVPixels(4, 0)
						end
					elseif tick == 19 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce1, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce2, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce3, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce4, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce5, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
							modelPart:setUVPixels(5, 0)
						end
					elseif tick == 23 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce1, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce2, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce3, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce4, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIce5, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
							modelPart:setUVPixels()
						end
					elseif tick == 27 then
						models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceFace:setVisible(true)
						models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceFace:setUVPixels(8, 0)
					elseif tick == 28 then
						models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceFace:setVisible(false)
					elseif tick == 29 then
						models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceFace:setVisible(true)
						models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceFace:setUVPixels(math.random() > 0.95 and 16 or 0, 0)
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce), 1, 0.75)
					elseif tick == 33 or tick == 50 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Plate.ShavedIceGroup)
						sounds:playSound("minecraft:item.bucket.empty", anchorPos, tick == 33 and 1 or 0.25, 0.75)
						sounds:playSound("minecraft:item.bucket.empty", anchorPos, tick == 33 and 1 or 0.25, 0.5)
					elseif tick == 52 then
						models.models.ex_skill_1.Plate:moveTo(ModelAlias.alias.avatar.leftArmBottom)
						ModelAlias.alias.avatar.leftArmBottom.Plate.ShavedIceGroup.Wave.WaveScaler:setOffsetPivot(48, 0)
					elseif tick == 71 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 3, true)
					elseif tick == 74 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "WORRY", 9, true)
					elseif tick == 85 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "WORRY", 3, true)
					elseif tick == 87 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 5, true)
					elseif tick == 92 then
						FaceParts:setEmotion("NORMAL", "CLOSED", "OPENED", 25, true)
						sounds:playSound("minecraft:entity.experience_orb.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.faceParts.Eyes.ExSkillParticleAnchor3), 1, 2)
						if host:isHost() then
							local windowSize = client:getScaledWindowSize()
							local center = vectors.vec2(windowSize.x * -0.5, windowSize.y * -0.5)
							for _ = 1, 100 do
								local rot = 2 * math.pi * math.random()
								local pos = vectors.vec2(math.cos(rot) * (windowSize.x / 2 * (math.random() * 0.5 + 0.5)) + center.x, math.sin(rot) * (windowSize.y / 2 * (math.random() * 0.5 + 0.5)) + center.y)
								Character01b_ExSkillSplashParticleManager:spawn(pos, pos:copy():sub(center):scale(0.1))
							end
						end
					end

					if tick <= 5 then
						local particleAnchor1Pos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce):add(0, 1.5, 0)
						for _ = 1, 2 do
							particles:newParticle("minecraft:block minecraft:snow", particleAnchor1Pos):setPower(0.25):setLifetime(10)
						end
					elseif tick <= 26 then
						local particleAnchor1Pos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce):add(0, 1.5, 0)
						for _ = 1, 4 do
							particles:newParticle("minecraft:block minecraft:light_blue_concrete", particleAnchor1Pos):setPower(0):setLifetime(10)
						end
					end
					if (tick >= 33 and tick <= 41) or (tick >= 50 and tick <= 61) then
						local root = tick < 52 and models.models.ex_skill_1.Plate.ShavedIceGroup.Wave.WaveScaler or ModelAlias.alias.avatar.leftArmBottom.Plate.ShavedIceGroup.Wave.WaveScaler
						local anchorPos = ModelUtils.getModelWorldPos(tick < 50 and root.WaveParticleAnchor1 or root.WaveParticleAnchor3)
						local particleRot = ModelUtils.getModelWorldPos(tick < 50 and root.WaveParticleAnchor2 or root.WaveParticleAnchor4):sub(anchorPos)
						for _ = 0, 15 do
							particles:newParticle("minecraft:dust 1 1 1 1", anchorPos):setScale(0.5):setColor(math.random() * 0.5 + 0.5, 1, 1):setVelocity(math.random() * 0.1 - 0.05, math.random() * 0.1 + 0.05, math.random() * 0.1 - 0.05):setGravity(0.5):setLifetime(20)
							anchorPos:add(particleRot)
						end
					end

					if tick % 4 then
						local modelPart = tick < 52 and models.models.ex_skill_1.Plate.ShavedIceGroup.Wave or ModelAlias.alias.avatar.leftArmBottom.Plate.ShavedIceGroup.Wave
						modelPart:setUVPixels(0, tick * 4 * 16)
					end
				end;

				onPostAnimation = function (self)
					if ModelAlias.alias.avatar.leftArmBottom.Plate ~= nil then
						ModelAlias.alias.avatar.leftArmBottom.Plate:moveTo( models.models.ex_skill_1)
					end
					models.models.ex_skill_1.Plate.ShavedIceGroup.ShavedIce.ShavedIce2.ShavedIceFace:setVisible(false)
					models.models.ex_skill_1.Plate.ShavedIceGroup.Wave.WaveScaler:setOffsetPivot()
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						Character01b_ExSkillSplashParticleManager:removeAll()
					end
				end;

				onPostTransition = function ()
					for _, modelPart in ipairs({models.models.ex_skill_1.Stall, models.models.ex_skill_1.SoftCream}) do
						modelPart:setVisible(false)
					end
				end;

				---初期化処理が行われたかどうか
				---@type boolean
				isInitialized = false;
			};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.head.HairTails, ModelAlias.alias.avatar.head.Brim, ModelAlias.alias.avatar.head.EarAccessories}) do
						modelPart:setVisible(not isVisible)
					end
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "WORRY", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "TRIANGLE", duration, true)
						ModelAlias.alias.avatar.head.FaceLayer:setVisible(true)
					end
				end
			end;

			onStop = function (_, _, forcedStop)
				if not forcedStop then
					FaceParts:resetEmotion()
				end
				ModelAlias.alias.avatar.head.FaceLayer:setVisible(false)
			end;
		}
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
				ModelAlias.alias.dummy_avatar.head.HairTailsBottom.HairTailBottomRight:setRot(29.3063, 5.6842, -13.9042)
				ModelAlias.alias.dummy_avatar.head.HairTailsBottom.HairTailBottomLeft:setRot(29.3063, -5.6842, 13.9042)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTailsBottom.HairTailBottomRight:setRot(1.5523, -7.3011, -23.9759)
				ModelAlias.alias.dummy_avatar.head.HairTailsBottom.HairTailBottomLeft:setRot(-10.0014, -13.1248, -21.4687)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.Brim.BrimRibbonRight.BrimLines.BrimLineLeft, ModelAlias.alias.avatar.head.Brim.BrimRibbonRight.BrimLines.BrimLineRight};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 150;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};

						headRot = {
							multiplayer = -0.1;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -160;
							min = 0;
							max = 150;
						};
					};

					horizontal = {
						min = 0;
						neutral = 45;
						max = 150;

						headX = {
							multiplayer = -16;
							min = 0;
							max = 150;
						};
					};
				};

				z = {
					vertical = {
						min = -60;
						neutral = 0;
						max = 0;

						headZ = {
							multiplayer = -160;
							min = -60;
							max = 0;
						};
					};

					horizontal = {
						min = -60;
						neutral = 0;
						max = 0;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTailsBottom.HairTailBottomLeft};
				x = {
					vertical = {
						min = -150;
						neutral = -7.5;
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
							min = -150;
							max = -7.5;
						};
					};

					horizontal = {
						min = -150;
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
						neutral = 5;
						max = 70;

						headZ = {
							multiplayer = -80;
							min = -70;
							max = 70;
						};
					};

					horizontal = {
						min = -150;
						neutral = 20;
						max = 70;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTailsBottom.HairTailBottomRight};

				x = {
					vertical = {
						min = -150;
						neutral = -7.5;
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
							min = -150;
							max = -7.5;
						};
					};

					horizontal = {
						min = -150;
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
						neutral = -5;
						max = 70;

						headZ = {
							multiplayer = -80;
							min = -70;
							max = 70;
						};
					};

					horizontal = {
						min = -150;
						neutral = -20;
						max = 70;
					};
				};
			};
		};
	};

	---初期化関数
	init = function ()
		---Exスキルのスプラッシュで使用するパーティクルの単一を管理するクラス
		---@see Character01b.ExSkillSplashParticle
		Character01b_ExSkillSplashParticle = require("scripts.ex_skill_splash_particle")

		---Exスキルでで使用するスプラッシュパーティクルを管理するクラス
		---@see Character01b.ExSkillSplashParticleManager
		Character01b_ExSkillSplashParticleManager = require("scripts.ex_skill_splash_particle_manager")
		Character01b_ExSkillSplashParticleManager = Character01b_ExSkillSplashParticleManager:new()

		Character01b_ExSkillSplashParticleManager.init()
	end;
}

return BlueArchiveCharacter
