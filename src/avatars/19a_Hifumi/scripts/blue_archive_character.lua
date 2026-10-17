---右目のテクスチャの列挙型
---@alias Character19a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "INVERTED" # 反対側を見る目
---| "WORRY" # 困った目
---| "WORRY_CENTER" # 困りつつ少し反対側を見る目
---| "UNEQUAL" # 不等号目
---| "SURPRISED_INVERTED" # 驚きつつ反対側を見る目
---| "NORMAL_CENTER" # 少し反対側を見る目

---左目のテクスチャの列挙型
---@alias Character19a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "WORRY" # 困った目
---| "WORRY_CENTER" # 困りつつ少し反対側を見る目
---| "UNEQUAL" # 不等号目
---| "WORRY_INVERTED" # 困りつつ反対側を見る目

---口のテクスチャの列挙型
---@alias Character19a.MouthTextures
---| "NORMAL" # 通常
---| "ANXIOUS" # への口
---| "O" # オーの形の口
---| "SURPRISED" # あんぐり口
---| "SMILE" # にっこり口
---| "OPENED" # 開いた口
---| "OPENED_SMALL" # 小さく開いた口
---| "ANXIOUS_SMALL" # 小さいへの口
---| "CLOSED" # 閉じた口

---@class (exact) Character19a.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character19a.RightEyeTextures 右目の表情名
---@field public leftEye Character19a.LeftEyeTextures 左目の表情名
---@field public mouth Character19a.MouthTextures 口の表情名

---@class (exact) Character19a.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character19a.EmotionSet ダメージを受けたとき
---@field public onSleep? Character19a.EmotionSet ベッドで寝ているとき

---@class (exact) Character19a.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character19a, right: Character19a.RightEyeTextures, left: Character19a.LeftEyeTextures, mouth: Character19a.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character19a.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character19a.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character19a.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character19a.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character19a.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character19a.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character19a : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character19a.FacePartsStruct 目や口による表情

---@type Character19a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "19a_Hifumi";

		birth = {
			month = 11;
			day = 27;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			INVERTED = vectors.vec2(5, 0);
			WORRY = vectors.vec2(6, 0);
			WORRY_CENTER = vectors.vec2(8, 0);
			UNEQUAL = vectors.vec2(10, 0);
			SURPRISED_INVERTED = vectors.vec2(12, 0);
			NORMAL_CENTER = vectors.vec2(13, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			WORRY = vectors.vec2(6, 0);
			WORRY_CENTER = vectors.vec2(8, 0);
			UNEQUAL = vectors.vec2(9, 0);
			WORRY_INVERTED = vectors.vec2(10, 0);
		};

		mouth = {
			ANXIOUS = vectors.vec2(0, 0);
			O = vectors.vec2(1, 0);
			SURPRISED = vectors.vec2(2, 0);
			SMILE = vectors.vec2(3, 0);
			OPENED = vectors.vec2(4, 0);
			OPENED_SMALL = vectors.vec2(5, 0);
			ANXIOUS_SMALL = vectors.vec2(6, 0);
			CLOSED = vectors.vec2(7, 0);
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
					right = vectors.vec3(0.5, 1, -5);
					left = vectors.vec3(0.5, 1, -5);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.75, 0, -6);
					left = vectors.vec3(1.75, 0, -6);
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
		{
			model = models.models.ex_skill_1.PeroroDisc;

			boundingBox = {
				size = vectors.vec3(8, 42, 8);
			};

			placementMode = "MOVE";

			---デコイペロロのアニメーションカウンター。-1はアニメーション停止を示す。
			---@type integer
			animationTick = -1;

			callbacks = {
				onDeinit = function (self, placementObject)
					placementObject.object.Peroro:setVisible(false)
					for _, animName in ipairs({"peroro_start", "peroro_loop"}) do
						animations["models.ex_skill_1"][animName]:stop()
					end
					self.placementObjects[1].animationTick = -1
				end;

				onTick = function (self, placementObject)
					if self.placementObjects[1].animationTick >= 0 then
						if self.placementObjects[1].animationTick == 8 then
							animations["models.ex_skill_1"]["peroro_loop"]:play()
						end
						if self.placementObjects[1].animationTick > 0 and self.placementObjects[1].animationTick % 12 == 0 then
							local colors = {vectors.vec3(1, 1, 0), vectors.vec3(0.52, 1, 1), vectors.vec3(0.96, 0.38, 1)}
							for _ = 1, 4 do
								particles:newParticle("minecraft:note", placementObject.currentPos:copy():add(math.random() * 3 - 1.5, math.random() * 2, math.random() * 3 - 1.5)):setColor(colors[math.random(#colors)])
							end
							sounds:playSound("minecraft:entity.experience_orb.pickup", placementObject.currentPos, 0.25, math.random() * 0.5 + 1.5)
						end
						if self.placementObjects[1].animationTick >= 21 and (self.placementObjects[1].animationTick - 8) % 19 == 0 then
							local colors = {vectors.vec3(1, 1, 0), vectors.vec3(0.52, 1, 1), vectors.vec3(0.96, 0.38, 1)}
							local color = colors[math.random(#colors)]
							for i = 0, 12 do
								particles:newParticle("minecraft:electric_spark", placementObject.currentPos):setScale(1):setVelocity(vectors.rotateAroundAxis(i * 30, 0, 0, math.random() * 0.05 + 0.05, 0, 1, 0)):setColor(color):setLifetime(math.random(12, 16))
							end
						end
						self.placementObjects[1].animationTick = self.placementObjects[1].animationTick + 1
					end
				end;

				onGround = function (self, placementObject)
					if self.placementObjects[1].animationTick == -1 then
						placementObject.object.Peroro:setVisible(true)
						animations["models.ex_skill_1"]["peroro_start"]:play()
						local colors = {vectors.vec3(1, 1, 0), vectors.vec3(0.52, 1, 1), vectors.vec3(0.96, 0.38, 1)}
						for _ = 1, 20 do
							local offset = vectors.vec3(math.random() * 3 - 1.5, math.random() * 2, math.random() * 3 - 1.5)
							local velocityOffset = offset:copy():scale(0.025)
							velocityOffset.y = 0.2
							particles:newParticle("minecraft:electric_spark", placementObject.currentPos:copy():add(offset)):setScale(1.5):setVelocity(velocityOffset):setColor(colors[math.random(#colors)]):setLifetime(math.random(8, 12))
						end
						sounds:playSound("minecraft:entity.item.pickup", placementObject.currentPos, 1, 1)
						self.placementObjects[1].animationTick = 0
					end
				end;
			};
		};
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_1.GlowEffect};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(0, 15, -29);
				};

				fin = {
					rot = vectors.vec3(0, 215, 0);
					pos = vectors.vec3(-4.5, 2, -74);
				};
			};

			callbacks = {
				onPreAnimation = function ()
					PlacementObjectManager:removeAll()
					models.script_placement_object.PeroroDisc:moveTo(models.models.ex_skill_1)
					models.models.ex_skill_1.PeroroDisc:setPos()
					models.models.ex_skill_1.PeroroDisc:setRot()
					models.models.ex_skill_1.PeroroDisc:setVisible(true)
					FaceParts:setEmotion("INVERTED", "NORMAL", "ANXIOUS", 8, true)
					sounds:playSound("minecraft:item.armor.equip_leather", player:getPos(), 1, 1)
				end;

				onAnimationTick = function (_, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, models.models.main, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = models.models.main.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setVisible(true)
					elseif tick == 8 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", 19, true)
					elseif tick == 18 then
						for i = 0, 11 do
							local offset = vectors.rotateAroundAxis(i * 30, 0, 0, 0.25, 0, 1, 0)
							particles:newParticle("minecraft:campfire_cosy_smoke", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.Backpack.ExSkill1ParticleAnchor1):copy():add(offset)):setScale(1):setVelocity(offset:copy():scale(0.05):add(0, 0.025, 0)):setLifetime(12)
						end
						sounds:playSound("minecraft:block.chiseled_bookshelf.insert", player:getPos(), 1, 1)
					elseif tick == 27 then
						FaceParts:setEmotion("WORRY_CENTER", "WORRY", "ANXIOUS", 3, true)
					elseif tick == 30 then
						FaceParts:setEmotion("WORRY", "WORRY", "ANXIOUS", 3, true)
					elseif tick == 33 then
						FaceParts:setEmotion("WORRY", "WORRY_CENTER", "ANXIOUS", 3, true)
					elseif tick == 36 then
						FaceParts:setEmotion("WORRY_CENTER", "WORRY", "O", 3, true)
					elseif tick == 39 then
						FaceParts:setEmotion("WORRY", "WORRY", "O", 6, true)
					elseif tick == 44 then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 1, 1.5)
					elseif tick == 45 then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SURPRISED", 13, true)
					elseif tick == 54 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					elseif tick == 58 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "ANXIOUS", 10, true)
					elseif tick == 62 then
						local colors = {vectors.vec3(1, 1, 0), vectors.vec3(0.52, 1, 1), vectors.vec3(0.96, 0.38, 1)}
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.PeroroDisc)
						for i = 0, 11 do
							particles:newParticle("minecraft:electric_spark", anchorPos):setVelocity(vectors.rotateAroundAxis(i * 30, 0, math.random() * 0.05 - 0.025 + 0.05, 0.1, 0, 1, 0)):setColor(colors[math.random(#colors)]):setGravity(0.1):setLifetime(16)
						end
						sounds:playSound("minecraft:entity.generic.small_fall", anchorPos, 0.5, 1.2)
						sounds:playSound("minecraft:block.dispenser.dispense", anchorPos, 1, 1.5)
					elseif tick == 68 then
						FaceParts:setEmotion("WORRY", "WORRY", "O", 54, true)
					end

					if tick >= 26 and tick <= 43 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.Backpack.ExSkill1ItemAnchor)
						for _ = 1, 4 do
							particles:newParticle("minecraft:campfire_cosy_smoke", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.6 - 0.3, math.random() * 0.2 - 0.1, math.random() * 0.2 - 0.1, 0, 1, 0))):setScale(1):setLifetime(8)
						end
						local colors = {vectors.vec3(1, 1, 0), vectors.vec3(0.52, 1, 1), vectors.vec3(0.96, 0.38, 1)}
						if (tick - 26) % 2 == 0 then
							local offsetX = math.random() * 0.6 - 0.3
							particles:newParticle("minecraft:electric_spark", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, offsetX, 0, math.random() * 0.2 - 0.1, 0, 1, 0))):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, offsetX * 0.1, 0.1, 0.05, 0, 1, 0)):setColor(colors[math.random(#colors)]):setLifetime(12)
						end
						if (tick - 26) % 3 == 0 then
							---@diagnostic disable-next-line: invisible
							Character19a_ItemLauncher:launch(CompatibilityUtils.registries.item[math.random(#CompatibilityUtils.registries.item)], anchorPos, bodyYaw * -1, 0.25, vectors.rotateAroundAxis(bodyYaw * -1, (((tick - 26) % 6 == 0) and 1 or -1) * (math.random() + 2), 4, 0, 0, 1, 0), 30)
							sounds:playSound("minecraft:entity.item.pickup", anchorPos, 0.75, math.random() * 0.4 + 0.8)
						end
					end
				end;

				onPostAnimation = function (_, forcedStop)
					models.models.ex_skill_1.PeroroDisc:setVisible(false)
					models.models.ex_skill_1.PeroroDisc:moveTo(models.script_placement_object)
					ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, models.models.main)
					ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					ModelAlias.alias.avatar.gun:setVisible(false)
					if not forcedStop then
						local bodyYaw = player:getBodyYaw()
						PlacementObjectManager:spawn(1, player:getPos():copy():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 1, 4.3594, 0, 1, 0)), bodyYaw * -1 + 180)
					else
						Character19a_ItemLauncher:removeAll()
					end
				end;
			};
		};
	};

	costume = {
		isAltCostumeEnabled = true;

		callbacks = {
			onAltChange = function (_, isAlt)
				ModelAlias.alias.avatar.head.CMaskedH:setVisible(isAlt)
			end;

			onArmorChange = function (_, parts, isVisible)
				if parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", duration, true)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("WORRY", "WORRY", "ANXIOUS", duration, true)
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
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail.RightHairTailZPivot:setRot(0, 0, 10)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail.LeftHairTailZPivot:setRot(0, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(55, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(30, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Backpack.OpenableBackpackBase.PeroroTip1:setRot(120, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Backpack.OpenableBackpackBase.PeroroTip2:setRot(120, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Backpack.OpenableBackpackBase.PeroroRightWing:setRot(0, 40, 0)
				ModelAlias.alias.dummy_avatar.body.Backpack.OpenableBackpackBase.PeroroLeftWing:setRot(0, -60, 0)
				ModelAlias.alias.dummy_avatar.body.Backpack.PeroroRightFoot:setRot(-10, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Backpack.PeroroLeftFoot:setRot(-10, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Backpack.BackpackBackPocket.BackpackKeyRing:setRot(-30, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(12, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(-20, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail.RightHairTailZPivot:setRot(0, 0, 10)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(-30, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail.LeftHairTailZPivot:setRot(0, 0, -20)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail, ModelAlias.alias.avatar.head.HairTails.LeftHairTail};

				x = {
					vertical = {
						min = -180;
						neutral = -5;
						max = 90;
						headRotMultiplayer = -1;
						sneakOffset = -30;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 90;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -180;
							max = 0;
						};
					};

					horizontal = {
						min = -45;
						neutral = 45;
						max = 45;

						bodyX = {
							multiplayer = -80;
							min = -45;
							max = 45;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail.RightHairTailZPivot};

				z = {
					vertical = {
						min = -32.5;
						neutral = 20;
						max = 90;

						headX = {
							multiplayer = -20;
							min = 0;
							max = 20;
						};

						headZ = {
							multiplayer = -80;
							min = -32.5;
							max = 90;
						};
					};

					horizontal = {
						min = -32.5;
						neutral = 10;
						max = 90;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.LeftHairTail.LeftHairTailZPivot};

				z = {
					vertical = {
						min = -90;
						neutral = -20;
						max = 32.5;

						headX = {
							multiplayer = 20;
							min = -20;
							max = 0;
						};

						headZ = {
							multiplayer = -80;
							min = -90;
							max = 32.5;
						};
					};

					horizontal = {
						min = -90;
						neutral = -20;
						max = 32.5;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.OpenableBackpackBase.PeroroTip1, ModelAlias.alias.avatar.body.Backpack.OpenableBackpackBase.PeroroTip2};

				x = {
					vertical = {
						min = -85;
						neutral = 0;
						max = 157.5;

						bodyX = {
							multiplayer = 40;
							min = -85;
							max = 85;
						};

						bodyY = {
							multiplayer = 80;
							min = 0;
							max = 157.5;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 90;
						};

					};

					horizontal = {
						min = 0;
						neutral = 0;
						max = 157.5;

						bodyX = {
							multiplayer = 80;
							min = 0;
							max = 157.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.OpenableBackpackBase.PeroroFace.PeroroTongue};

				x = {
					vertical = {
						min = 12.5;
						neutral = 30;
						max = 30;

						bodyX = {
							multiplayer = -40;
							min = 12.5;
							max = 30;
						};

						bodyY = {
							multiplayer = 40;
							min = 12.5;
							max = 30;
						};

						bodyRot = {
							multiplayer = 0.025;
							min = 12.5;
							max = 30;
						};
					};

					horizontal = {
						min = 12.5;
						neutral = 30;
						max = 30;
					};
				};

				y = {
					vertical = {
						min = -30;
						neutral = -30;
						max = -30;
					};

					horizontal = {
						min = -30;
						neutral = -30;
						max = -30;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.OpenableBackpackBase.PeroroRightWing};

				y = {
					vertical = {
						min = -15;
						neutral = 0;
						max = 52.5;

						bodyX = {
							multiplayer = 80;
							min = -15;
							max = 52.5;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 52.5;
						};
					};

					horizontal = {
						min = -15;
						neutral = 0;
						max = 52.5;

						bodyY = {
							multiplayer = -80;
							min = -15;
							max = 52.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.OpenableBackpackBase.PeroroLeftWing};

				y = {
					vertical = {
						min = -52.5;
						neutral = 0;
						max = 15;

						bodyX = {
							multiplayer = -80;
							min = -52.5;
							max = 15;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -52.5;
							max = 0;
						};
					};

					horizontal = {
						min = -52.5;
						neutral = 0;
						max = 15;

						bodyY = {
							multiplayer = 80;
							min = -52.5;
							max = 15;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.PeroroRightFoot, ModelAlias.alias.avatar.body.Backpack.PeroroLeftFoot};

				x = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 47.5;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = 47.5;
						};

						bodyY = {
							multiplayer = 80;
							min = -90;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};

					};

					horizontal = {
						min = -90;
						neutral = 0;
						max = 47.5;

						bodyY = {
							multiplayer = 80;
							min = -90;
							max = 47.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Backpack.BackpackBackPocket.BackpackKeyRing};

				x = {
					vertical = {
						min = -147.5;
						neutral = -25;
						max = -25;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = -25;
						};

						bodyY = {
							multiplayer = 80;
							min = -147.5;
							max = -25;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -25;
						};

					};

					horizontal = {
						min = -147.5;
						neutral = -25;
						max = -25;

						bodyY = {
							multiplayer = 80;
							min = -90;
							max = -25;
						};
					};
				};

				z = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						bodyZ = {
							multiplayer = -160;
							min = -90;
							max = 90;
						};
					};

					horizontal = {
						min = -90;
						neutral = 0;
						max = 90;
					};
				}
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---アイテムを発射する演出のクラス
		---@type Character19a.ItemLauncher
		Character19a_ItemLauncher = require("scripts.item_launcher")

		Character19a_ItemLauncher.init()
	end;
}

return BlueArchiveCharacter
