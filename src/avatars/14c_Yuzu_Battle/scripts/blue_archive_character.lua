---右目のテクスチャの列挙型
---@alias Character14c.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANGRY" # 怒った目
---| "FEAR" # 恐怖を感じているときの目
---| "CIRCLE" # 丸目
---| "UNEQUAL" # 不等号目
---| "NARROW" # 半目
---| "CLOSED2" # 閉じた目2
---| "NARROW_CENTER" # 中央を見る半目

---左目のテクスチャの列挙型
---@alias Character14c.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANGRY" # 怒った目
---| "FEAR" # 恐怖を感じているときの目
---| "CIRCLE_TEAR" # 涙を流しながらの丸目
---| "UNEQUAL" # 不等号目
---| "NARROW_CENTER" # 中央を見る半目
---| "CLOSED2" # 閉じた目2

---口のテクスチャの列挙型
---@alias Character14c.MouthTextures
---| "NORMAL" # 通常
---| "SHOCK" # あんぐり口
---| "FRUST" # ぐにゅぐにゅ口
---| "CLOSED" # 閉じた口
---| "FEAR" # 恐怖を感じているときの口
---| "SMILE" # にっこり
---| "OPENED" # 開いた口
---| "OPENED2" # 開いた口2
---| "SMALL" # 小さく開いた口
---| "ANGRY" # ムッとする口
---| "CLOSED2" # 閉じた口2

---@class (exact) Character14c.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character14c.RightEyeTextures 右目の表情名
---@field public leftEye Character14c.LeftEyeTextures 左目の表情名
---@field public mouth Character14c.MouthTextures 口の表情名

---@class (exact) Character14c.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character14c.EmotionSet ダメージを受けたとき
---@field public onSleep? Character14c.EmotionSet ベッドで寝ているとき

---@class (exact) Character14c.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character14c, right: Character14c.RightEyeTextures, left: Character14c.LeftEyeTextures, mouth: Character14c.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character14c.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character14c.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character14c.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character14c.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character14c.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character14c.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character14c : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character14c.FacePartsStruct 目や口による表情

---@type Character14c
local BlueArchiveCharacter = {
	basic = {
		avatarName = "14c_Yuzu_Battle";

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
			ANGRY = vectors.vec2(5, 0);
			FEAR = vectors.vec2(7, 0);
			CIRCLE = vectors.vec2(8, 0);
			UNEQUAL = vectors.vec2(10, 0);
			NARROW = vectors.vec2(11, 0);
			CLOSED2 = vectors.vec2(13, 0);
			NARROW_CENTER = vectors.vec2(15, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			ANGRY = vectors.vec2(5, 0);
			FEAR = vectors.vec2(6, 0);
			CIRCLE_TEAR = vectors.vec2(8, 0);
			UNEQUAL = vectors.vec2(9, 0);
			NARROW_CENTER = vectors.vec2(11, 0);
			CLOSED2 = vectors.vec2(12, 0);
			NARROW = vectors.vec2(13, 0);
		};

		mouth = {
			SHOCK = vectors.vec2(0, 0);
			FRUST = vectors.vec2(1, 0);
			CLOSED = vectors.vec2(2, 0);
			FEAR = vectors.vec2(3, 0);
			SMILE = vectors.vec2(4, 0);
			OPENED = vectors.vec2(5, 0);
			OPENED2 = vectors.vec2(6, 0);
			SMALL = vectors.vec2(7, 0);
			ANGRY = vectors.vec2(8, 0);
			CLOSED2 = vectors.vec2(9, 0);
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
			formationType = "SPECIAL";

			models = {models.models.ex_skill_1.Cockpit, models.models.ex_skill_1.CockpitFront, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(0, 20, -29);
				};

				fin = {
					rot = vectors.vec3(10, 170, 0);
					pos = vectors.vec3(4, 20, -26.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.CockpitFront.CockpitScreen1.TextAnchor:setPrimaryRenderType("CUTOUT")
						models.models.ex_skill_1.CockpitFront.CockpitScreen1.TextAnchor:newText("ex_skill_1_screen_1_text"):setText("§b§kScanning...\n\nScan complete\nThe enemy is very strong.\n\nBut, don't worry.\nYou can defeat it."):setPos(-2.75, 3.5, 0):setRot(0, 0, 0):setScale(0.03, 0.03, 0.03):setAlignment("RIGHT"):setWidth(100)
						self.exSkill.primary.isInitialized = true
					end
					FaceParts:setEmotion("CIRCLE", "CIRCLE_TEAR", "SHOCK", 26, true)
					ModelAlias.alias.avatar.leftEye:setPos(0, -0.5, 0)
					ModelAlias.alias.avatar.head.FearEffect:setVisible(true)
					if host:isHost() then
						--高解像度の写真が入手可能であればそれに置換
						if textures["ex_skill_1_image_high_resolution"] == nil and #Locale:getLocalizedText("ex_skill.photo_data") >= 32 then
							textures:read("ex_skill_1_image_high_resolution", Locale:getLocalizedText("ex_skill.photo_data"))
							models.models.ex_skill_1.CockpitFront.CockpitScreen2.CockpitScreen2Base:setPrimaryTexture("CUSTOM", textures["ex_skill_1_image_high_resolution"])
						end
						models.models.ex_skill_1.CockpitFront.CockpitScreen2.CockpitScreen2Base:setColor(vectors.vec3(1, 1, 1):scale(client:hasShaderPack() and 0.5 or 1))

						models.models.ex_skill_1.Gui.ScreenFilter:setScale(client:getScaledWindowSize():copy():augmented(1))
						self.exSkill.primary.baseFOV = renderer:getFOV()

						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.ScreenFilter:setOpacity(models.models.ex_skill_1.Gui.FilterOpacity:getAnimScale().x)
							renderer:setFOV(self.exSkill.primary.baseFOV * models.models.ex_skill_1.FOVScale:getAnimScale().x)
						end, "ex_skill_1_render")
					end
				end;

				onAnimationTick = function (_, tick)
					if tick == 26 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "FRUST", 8, true)
						ModelAlias.alias.avatar.leftEye:setPos()
						ModelAlias.alias.avatar.head.FearEffect:setVisible(false)
					elseif tick == 22 then
						sounds:playSound("minecraft:block.beacon.activate", player:getPos(), 0.5, 5)
					elseif (tick == 24 or tick == 60) and host:isHost() then
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.25, 1.2)
					elseif tick == 34 then
						FaceParts:setEmotion("NARROW", "NARROW_CENTER", "FEAR", 28, true)
					elseif tick == 62 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "FEAR", 2, true)
					elseif tick == 64 then
						FaceParts:setEmotion("NARROW_CENTER", "NARROW", "FRUST", 27, true)
					elseif tick == 91 then
						FaceParts:setEmotion("NARROW", "NARROW", "FRUST", 1, true)
					elseif tick == 92 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED2", 4, true)
					elseif tick == 96 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED2", 3, true)
					elseif tick == 99 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SMALL", 22, true)
						particles:newParticle("minecraft:snowflake", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.mouth)):setScale(0.5):setVelocity(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, -0.05, 0.05, 0, 1, 0)):setGravity(0):setLifetime(11)
					elseif tick == 101 then
						sounds:playSound("minecraft:block.beacon.deactivate", player:getPos(), 0.5, 5)
					elseif tick == 121 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "ANGRY", 23, true)
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					elseif tick == 144 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "CLOSED2", 41, true)
						sounds:playSound("minecraft:entity.lightning_bolt.thunder", player:getPos(), 1, 2)
						sounds:playSound("minecraft:entity.blaze.death", player:getPos(), 1, 0.5)
						if host:isHost() then
							models.models.ex_skill_1.Background:setVisible(true)
							models.models.ex_skill_1.CockpitFront:setVisible(false)
						end
					end

					if tick < 26 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head)
						particles:newParticle("minecraft:splash", anchorPos):setPower(2)
						if tick % 2 == 0 then
							sounds:playSound("minecraft:entity.item.pickup", anchorPos, 0.25, 2)
						end
					end

					if tick == 22 or tick == 101 then
						local bodyYaw = player:getBodyYaw()
						for i = 1, 2 do
							local screenModel = models.models.ex_skill_1.CockpitFront["CockpitScreen" .. i]
							local screenRot = screenModel:getRot().y
							local anchorPos = ModelUtils.getModelWorldPos(screenModel)
							for _ = 1, 20 do
								particles:newParticle("minecraft:end_rod", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1 + screenRot, math.random() * 0.5 - 0.25, math.random() * 0.28125, 0.05, 0, 1, 0))):setScale(0.05):setColor(0, 1, 1):setGravity(0):setLifetime(math.random(4, 8))
							end
						end
					end
				end;

				onPostAnimation = function (_, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						models.models.ex_skill_1.Background:setVisible(false)
					end
					if forcedStop then
						ModelAlias.alias.avatar.leftEye:setPos()
						ModelAlias.alias.avatar.head.FearEffect:setVisible(false)
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか。
			---@type boolean
			isInitialized = false;

			---Exスキルのために調整したFOV基準値
			---@type number
			baseFOV = 0;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.HairTip:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.FrontHair:setPos(0, 0, isVisible and -1 or 0)
				elseif parts == "LEGGINGS" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.rightLeg.RightPorch, ModelAlias.alias.avatar.leftLeg.LeftPorch}) do
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
		includeModels = {ModelAlias.alias.avatar.body.FrontHair};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onBeforeModelCopy = function ()
				ModelAlias.alias.avatar.head.FearEffect:setVisible(false)
			end;

			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(22.5, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(-17.5, 0, -5)
				ModelAlias.alias.dummy_avatar.body.FrontHair:setRot(0, 0, -15)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.HairTip};

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
						min = 40;
						neutral = 40;
						max = 40;
					};

					horizontal = {
						min = 40;
						neutral = 40;
						max = 40;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTail};

				x = {
					vertical = {
						min = -170;
						neutral = 0;
						max = 30;
						sneakOffset = -20;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 10;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -170;
							max = 0;
						};
					};

					horizontal = {
						min = -135;
						neutral = -30;
						max = -30;

						headX = {
							multiplayer = -80;
							min = -45;
							max = -30;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTail.HairTailZPivot};

				z = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 80;

						headZ = {
							multiplayer = -80;
							min = -80;
							max = 80;
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
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model == ModelAlias.alias.avatar.head.HairTail then
					local modelRot = model:getRot()
					local headRotY = math.deg(math.asin(player:getLookDir().y))
					if headRotY < 0 then
						modelRot.x = math.min(modelRot.x, 30)
					end
					model:setRot(modelRot)
				end
			end;
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	---@param self Character14c
	init = function (self)
		---Exスキル1で使用するアイテムオブジェクトインスタンスのクラス
		---@type Character14c.ExSkill1ItemObject
		ExSkill1ItemObject = require("scripts.ex_skill_1_item_object")

		---Exスキル1で使用するアイテムオブジェクトマネージャーのクラス
		---@type Character14c.ExSkill1ItemObjectManager
		ExSkill1ItemObjectManager = require("scripts.ex_skill_1_item_object_manager")
		ExSkill1ItemObjectManager = ExSkill1ItemObjectManager.new()

		ExSkill1ItemObjectManager.init()

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
