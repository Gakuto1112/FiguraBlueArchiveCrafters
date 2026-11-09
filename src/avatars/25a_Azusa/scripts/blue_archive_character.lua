---右目のテクスチャの列挙型
---@alias Character25a.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "NARROW" # 細目
---| "CLOSED2" # 閉じた目2

---左目のテクスチャの列挙型
---@alias Character25a.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "NARROW" # 細目
---| "CLOSED2" # 閉じた目2

---口のテクスチャの列挙型
---@alias Character25a.MouthTextures
---| "NORMAL" # 通常
---| "CLOSED" # 閉じた口
---| "CLOSED2" # 閉じた口2

---@class (exact) Character25a : BlueArchiveCharacter キャラクターシート
---@type Character25a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "25a_Azusa";

		birth = {
			month = 12;
			day = 26;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			NARROW = vectors.vec2(6, 0);
			CLOSED2 = vectors.vec2(8, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CENTER = vectors.vec2(4, 0);
			NARROW = vectors.vec2(6, 0);
			CLOSED2 = vectors.vec2(7, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(0, 0);
			CLOSED2 = vectors.vec2(1, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 1.4;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 1.5, -7);
					left = vectors.vec3(0, 1.5, -7);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.75 , -0.5, -7);
					left = vectors.vec3(1.75, -0.5, -7);
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

			models = {models.models.ex_skill_1.Bullet, models.models.ex_skill_1.Halo};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(-1.5, 57, -14);
				};

				fin = {
					rot = vectors.vec3(-20, -177.5, -10);
					pos = vectors.vec3(1.5, 16.3, -26);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						local haloModel = ModelAlias.alias.avatar.halo:copy("Halo")
						haloModel:setPos()
						haloModel:setRot()
						haloModel:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
						models.models.ex_skill_1.Halo:addChild(haloModel)

						self.exSkill.primary.isInitialized = true
					end

					local playerPos = player:getPos()
					local bodyYaw = player:getBodyYaw()
					for _ = 1, 100 do
						table.insert(self.exSkill.primary.smokeParticles, particles:newParticle("minecraft:campfire_cosy_smoke", playerPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 8 - 4, math.random() * 5, math.random() * -2.5 - 0.5, 0, 1, 0))):setScale(10):setColor(0.3, 0.3, 0.3):setGravity(0):setLifetime(200))
					end

					FaceParts:setEmotion("NORMAL", "CENTER", "CLOSED2", 31, true)
				end;

				onAnimationTick =function (self, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setVisible(true)
					elseif tick == 29 then
						local playerPos = player:getPos()
						sounds:playSound("minecraft:entity.player.attack.nodamage", playerPos, 1, 2)
						sounds:playSound("minecraft:entity.lightning_bolt.thunder", playerPos, 0.25, 2)
					elseif tick == 31 then
						FaceParts:setEmotion("NARROW", "NARROW", "CLOSED2", 23, true)
					elseif tick == 33 then
						for _, particle in ipairs(self.exSkill.primary.smokeParticles) do
							---@cast particle Particle
							particle:setColor(vectors.vec3(1, 1, 1))
						end
					elseif tick == 35 or tick == 39 then
						for _, particle in ipairs(self.exSkill.primary.smokeParticles) do
							---@cast particle Particle
							particle:setColor(vectors.vec3(0.3, 0.3, 0.3))
						end
					elseif tick == 37 then
						local playerPos = player:getPos()
						for _, particle in ipairs(self.exSkill.primary.smokeParticles) do
							---@cast particle Particle
							if particle:getPos():copy():sub(playerPos):mul(1, 0, 1):length() >= 1.5 then
								particle:setColor(vectors.vec3(1, 1, 1))
							end
						end
					elseif tick == 54 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED2", 2, true)
					elseif tick == 56 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED2", 37, true)
					elseif tick == 57 then
						local playerPos = player:getPos()
						for _, particle in ipairs(self.exSkill.primary.smokeParticles) do
							---@cast particle Particle
							particle:setLifetime(93)
							particle:setVelocity(particle:getPos():copy():sub(playerPos):mul(1, 0, 1):scale(0.2))
						end
						for i = 0, 59 do
							particles:newParticle("minecraft:snowflake", playerPos):setScale(2):setVelocity(vectors.rotateAroundAxis(i * 6, 0, 0.1 + math.random() * 0.2, 0.3, 0, 1, 0)):setGravity(0):setLifetime(50 + math.random() * 20)
						end
						for _ = 1, 30 do
							particles:newParticle("minecraft:end_rod", playerPos):setScale(1):setVelocity(math.random() * 0.4 - 0.2, math.random() * 0.5, math.random() * 0.4 - 0.2):setColor(0.999, 0.996, 0.877):setLifetime(50 + math.random() * 20)
						end

						sounds:playSound("minecraft:entity.wind_charge.wind_burst", playerPos, 0.75, 0.5)
						sounds:playSound("minecraft:entity.player.levelup", playerPos, 1, 1.5)
						sounds:playSound("minecraft:block.beacon.ambient", playerPos, 0.25, 2)
					end

					if tick <= 35 then
						local anchorPos = vectors.vec3()
						if tick < 32 then
							anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Bullet.BulletInner.BulletParticleAnchor)
						else
							anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftItemPivot)
						end
						particles:newParticle("minecraft:end_rod", anchorPos:copy():add(math.random() * 0.05 - 0.025, math.random() * 0.05 - 0.025 - 0.1, math.random() * 0.05 - 0.025)):setScale(0.1):setGravity(0):setColor(0.939, 0.819, 0.973):setLifetime(16)
					end
				end;

				onPostAnimation = function (self)
					ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
					ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					if Gun.currentGunPosition == "NONE" then
						ModelAlias.alias.avatar.gun:setVisible(false)
					end
					while #self.exSkill.primary.smokeParticles > 0 do
						self.exSkill.primary.smokeParticles[1]:remove()
						table.remove(self.exSkill.primary.smokeParticles, 1)
					end
				end;
			};

			---このExスキルが初期化されたかどうか。
			---@type boolean
			isInitialized = false;

			---煙パーティクルのインスタンス格納配列
			---@type Particle[]
			smokeParticles = {};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
					ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, isVisible and -1 or 0)
					ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, isVisible and 1 or 0)
					self.physics.physicData[3].x.vertical.neutral = isVisible and 0 or -15
					self.physics.physicData[3].x.vertical.max = isVisible and 0 or -15
					self.physics.physicData[3].x.vertical.bodyX.max = isVisible and 0 or -15
					self.physics.physicData[3].x.vertical.bodyY.max = isVisible and 0 or -15
					self.physics.physicData[3].x.vertical.bodyRot.max = isVisible and 0 or -15
					self.physics.physicData[3].x.horizontal.neutral = isVisible and 0 or -15
					self.physics.physicData[3].x.horizontal.max = isVisible and 0 or -15
				end
			end;
		};
	};

	bubble = {

	};

	headModel = {

	};

	headBlock = {
		emotion = {
			rightEye = "NORMAL";
			leftEye = "NORMAL";
			mouth = "CLOSED";
		};

		callbacks = {
			onAfterModelCopy = function ()
				ModelAlias.alias.head_block_avatar.body.Hairs.BackHair:setRot(-10, 0, 0)
				ModelAlias.alias.head_block_avatar.body.Skirt:setRot(40, 0, 0)
			end;
		};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-10, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Wings.RightWing:setRot(0, 0, -20)
				ModelAlias.alias.dummy_avatar.body.Wings.LeftWing:setRot(0, 0, 20)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(40, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-10, 0, -15)
				ModelAlias.alias.dummy_avatar.body.Wings.RightWing:setRot(0, -90, 0)
				ModelAlias.alias.dummy_avatar.body.Wings.LeftWing:setRot(0, 50, 0)
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
				models = {ModelAlias.alias.avatar.head.HairAccessory.HairRibbonRight, ModelAlias.alias.avatar.head.HairAccessory.HairRibbonLeft};

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
							multiplayer = -80;
							min = -45;
							max = 45;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessory.HairRibbonRight.HairRibbonRightZPivot, ModelAlias.alias.avatar.head.HairAccessory.HairRibbonLeft.HairRibbonLeftZPivot};

				z = {
					vertical = {
						min = -165;
						neutral = 0;
						max = 0;

						headZ = {
							multiplayer = -80;
							min = -165;
							max = 90;
						};

						headRot = {
							multiplayer = 0.05;
							min = -165;
							max = 90;
						};

						bodyY = {
							multiplayer = 80;
							min = -165;
							max = 0;
						};
					};

					horizontal = {
						min = -165;
						neutral = 0;
						max = 0;

						headZ = {
							multiplayer = -80;
							min = -45;
							max = 45;
						};

						bodyY = {
							multiplayer = 80;
							min = -165;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair},

				x = {
					vertical = {
						min = -150;
						neutral = -15;
						max = -15;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = -15;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = -15;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -15;
						};
					};

					horizontal = {
						min = -90;
						neutral = -15;
						max = -15;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Hairs.FrontHair};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 150;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
						max = 150;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1RightRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2RightRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3LeftRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4LeftRibbon};

				z = {
					vertical = {
						min = -65;
						neutral = 0;
						max = 10;

						bodyY = {
							multiplayer = 80;
							min = -65;
							max = 10;
						};
					};

					horizontal = {
						min = -65;
						neutral = 0;
						max = 10;

						bodyY = {
							multiplayer = 80;
							min = -65;
							max = 10;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1LeftRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2LeftRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3RightRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4RightRibbon};

				z = {
					vertical = {
						min = -10;
						neutral = 0;
						max = 65;

						bodyY = {
							multiplayer = -80;
							min = -10;
							max = 65;
						};
					};

					horizontal = {
						min = -10;
						neutral = 0;
						max = 65;

						bodyY = {
							multiplayer = -80;
							min = -10;
							max = 65;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1RightBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1LeftBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2RightBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2LeftBottomRibbon};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 152.5;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 65;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 152.5;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 65;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
						max = 152.5;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 65;
						};

						bodyY = {
							multiplayer = 80;
							min = 0;
							max = 152.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1RightBottomRibbon.SkirtFlower1RightBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1LeftBottomRibbon.SkirtFlower1LeftBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2RightBottomRibbon.SkirtFlower2RightBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2LeftBottomRibbon.SkirtFlower2LeftBottomRibbonZPivot};

				z = {
					vertical = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyZ = {
							multiplayer = -80;
							min = -50;
							max = 50;
						};
					};

					horizontal = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyZ = {
							multiplayer = -80;
							min = -50;
							max = 50;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3RightBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3LeftBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4RightBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4LeftBottomRibbon};

				x = {
					vertical = {
						min = -152.5;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = -65;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -152.5;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -65;
							max = 0;
						};
					};

					horizontal = {
						min = -152.5;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = 160;
							min = -65;
							max = 0;
						};

						bodyY = {
							multiplayer = -80;
							min = -152.5;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3RightBottomRibbon.SkirtFlower3RightBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3LeftBottomRibbon.SkirtFlower3LeftBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4RightBottomRibbon.SkirtFlower4RightBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4LeftBottomRibbon.SkirtFlower4LeftBottomRibbonZPivot};

				z = {
					vertical = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyZ = {
							multiplayer = 80;
							min = -50;
							max = 50;
						};
					};

					horizontal = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyZ = {
							multiplayer = 80;
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
		events.RENDER:register(function ()
			if not client:isPaused() then
				local wingRotOffset = math.map(vanilla_model.RIGHT_LEG:getOriginRot().x, -90, 90, 20, 0)
				ModelAlias.alias.avatar.body.Wings.RightWing:setRot(0, wingRotOffset * -1, 0)
				ModelAlias.alias.avatar.body.Wings.LeftWing:setRot(0, wingRotOffset, 0)
			end
		end)
	end;
}

return BlueArchiveCharacter
