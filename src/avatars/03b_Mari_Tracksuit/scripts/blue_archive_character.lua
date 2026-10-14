---右目のテクスチャの列挙型
---@alias Character03b.RightEyeTextures
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
---@alias Character03b.LeftEyeTextures
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
---@alias Character03b.MouthTextures
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

---@class (exact) Character03b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character03b.RightEyeTextures 右目の表情名
---@field public leftEye Character03b.LeftEyeTextures 左目の表情名
---@field public mouth Character03b.MouthTextures 口の表情名

---@class (exact) Character03b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character03b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character03b.EmotionSet ベッドで寝ているとき

---@class (exact) Character03b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character03b, right: Character03b.RightEyeTextures, left: Character03b.LeftEyeTextures, mouth: Character03b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character03b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character03b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character03b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character03b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character03b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character03b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character03b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character03b.FacePartsStruct 目や口による表情

---@type Character03b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "03b_Mari_Tracksuit";

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
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.rightArmBottom.DrinkBottle1, ModelAlias.alias.avatar.body.DrinkBottle2, ModelAlias.alias.avatar.body.DrinkBottle3, models.models.ex_skill_1.Mobs};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-5, 180, 0);
					pos = vectors.vec3(-1, 27, -12);
				};

				fin = {
					rot = vectors.vec3(0, 150, 0);
					pos = vectors.vec3(21, 20, -30);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob1.Mob1Head.Mob1HeadColor, models.models.ex_skill_1.Mobs.Mob1.Mob1Head.Mob1HeadLayerColor}) do
							modelPart:setColor(0.318, 0.235, 0.282)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob1.Mob1UpperBody.Mob1Body.Mob1BodyColor, models.models.ex_skill_1.Mobs.Mob1.Mob1UpperBody.Mob1Body.Mob1BodyLayerColor, models.models.ex_skill_1.Mobs.Mob1.Mob1UpperBody.Mob1Arms.Mob1RightArm.Mob1RightArmColor, models.models.ex_skill_1.Mobs.Mob1.Mob1UpperBody.Mob1Arms.Mob1RightArm.Mob1RightArmLayerColor, models.models.ex_skill_1.Mobs.Mob1.Mob1UpperBody.Mob1Arms.Mob1LeftArm.Mob1LeftArmColor, models.models.ex_skill_1.Mobs.Mob1.Mob1UpperBody.Mob1Arms.Mob1LeftArm.Mob1LeftArmLayerColor, models.models.ex_skill_1.Mobs.Mob1.Mob1LowerBody.Mob1Legs.Mob1RightLeg.Mob1RightLegColor, models.models.ex_skill_1.Mobs.Mob1.Mob1LowerBody.Mob1Legs.Mob1RightLeg.Mob1RightLegLayerColor, models.models.ex_skill_1.Mobs.Mob1.Mob1LowerBody.Mob1Legs.Mob1LeftLeg.Mob1LeftLegColor, models.models.ex_skill_1.Mobs.Mob1.Mob1LowerBody.Mob1Legs.Mob1LeftLeg.Mob1LeftLegLayerColor}) do
							modelPart:setColor(0.788, 0.263, 0.275)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob1.Mob1Head.Mob1HeadRing, models.models.ex_skill_1.Mobs.Mob2.Mob2Head.Mob2HeadRing, models.models.ex_skill_1.Mobs.Mob3.Mob3Head.Mob3HeadRing}) do
							modelPart:setColor(0.996, 0.824, 0.843)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob2.Mob2Head.Mob2HeadColor, models.models.ex_skill_1.Mobs.Mob2.Mob2Head.Mob2HeadLayerColor, models.models.ex_skill_1.Mobs.Mob2.Mob2Head.Mob2HairTail}) do
							modelPart:setColor(0.502, 0.369, 0.408)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob2.Mob2UpperBody.Mob2Body.Mob2BodyColor, models.models.ex_skill_1.Mobs.Mob2.Mob2UpperBody.Mob2Body.Mob2BodyLayerColor, models.models.ex_skill_1.Mobs.Mob2.Mob2UpperBody.Mob2Arms.Mob2RightArm.Mob2RightArmColor, models.models.ex_skill_1.Mobs.Mob2.Mob2UpperBody.Mob2Arms.Mob2RightArm.Mob2RightArmLayerColor, models.models.ex_skill_1.Mobs.Mob2.Mob2UpperBody.Mob2Arms.Mob2LeftArm.Mob2LeftArmColor, models.models.ex_skill_1.Mobs.Mob2.Mob2UpperBody.Mob2Arms.Mob2LeftArm.Mob2LeftArmLayerColor, models.models.ex_skill_1.Mobs.Mob2.Mob2LowerBody.Mob2Legs.Mob2RightLeg.Mob2RightLegColor, models.models.ex_skill_1.Mobs.Mob2.Mob2LowerBody.Mob2Legs.Mob2RightLeg.Mob2RightLegLayerColor, models.models.ex_skill_1.Mobs.Mob2.Mob2LowerBody.Mob2Legs.Mob2LeftLeg.Mob2LeftLegColor, models.models.ex_skill_1.Mobs.Mob2.Mob2LowerBody.Mob2Legs.Mob2LeftLeg.Mob2LeftLegLayerColor}) do
							modelPart:setColor(0.596, 0.6, 0.757)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob3.Mob3Head.Mob3HeadColor, models.models.ex_skill_1.Mobs.Mob3.Mob3Head.Mob3HeadLayerColor, models.models.ex_skill_1.Mobs.Mob3.Mob3Head.Mob3Bun}) do
							modelPart:setColor(0.275, 0.212, 0.227)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob3.Mob3UpperBody.Mob3Body.Mob3BodyColor, models.models.ex_skill_1.Mobs.Mob3.Mob3UpperBody.Mob3Body.Mob3BodyLayerColor, models.models.ex_skill_1.Mobs.Mob3.Mob3UpperBody.Mob3Arms.Mob3RightArm.Mob3RightArmColor, models.models.ex_skill_1.Mobs.Mob3.Mob3UpperBody.Mob3Arms.Mob3RightArm.Mob3RightArmLayerColor, models.models.ex_skill_1.Mobs.Mob3.Mob3UpperBody.Mob3Arms.Mob3LeftArm.Mob3LeftArmColor, models.models.ex_skill_1.Mobs.Mob3.Mob3UpperBody.Mob3Arms.Mob3LeftArm.Mob3LeftArmLayerColor, models.models.ex_skill_1.Mobs.Mob3.Mob3LowerBody.Mob3Legs.Mob3RightLeg.Mob3RightLegColor, models.models.ex_skill_1.Mobs.Mob3.Mob3LowerBody.Mob3Legs.Mob3RightLeg.Mob3RightLegLayerColor, models.models.ex_skill_1.Mobs.Mob3.Mob3LowerBody.Mob3Legs.Mob3LeftLeg.Mob3LeftLegColor, models.models.ex_skill_1.Mobs.Mob3.Mob3LowerBody.Mob3Legs.Mob3LeftLeg.Mob3LeftLegLayerColor}) do
							modelPart:setColor(0.231, 0.298, 0.22)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob4.Mob4Head.Mob4HeadColor, models.models.ex_skill_1.Mobs.Mob4.Mob4Head.Mob4HeadLayerColor, models.models.ex_skill_1.Mobs.Mob4.Mob4Head.Mob4Bun}) do
							modelPart:setColor(0.345, 0.251, 0.251)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob4.Mob4UpperBody.Mob4Body.Mob4BodyColor, models.models.ex_skill_1.Mobs.Mob4.Mob4UpperBody.Mob4Body.Mob4BodyLayerColor, models.models.ex_skill_1.Mobs.Mob4.Mob4UpperBody.Mob4Arms.Mob4RightArm.Mob4RightArmColor, models.models.ex_skill_1.Mobs.Mob4.Mob4UpperBody.Mob4Arms.Mob4RightArm.Mob4RightArmLayerColor, models.models.ex_skill_1.Mobs.Mob4.Mob4UpperBody.Mob4Arms.Mob4LeftArm.Mob4LeftArmColor, models.models.ex_skill_1.Mobs.Mob4.Mob4UpperBody.Mob4Arms.Mob4LeftArm.Mob4LeftArmLayerColor, models.models.ex_skill_1.Mobs.Mob4.Mob4LowerBody.Mob4Legs.Mob4RightLeg.Mob4RightLegColor, models.models.ex_skill_1.Mobs.Mob4.Mob4LowerBody.Mob4Legs.Mob4RightLeg.Mob4RightLegLayerColor, models.models.ex_skill_1.Mobs.Mob4.Mob4LowerBody.Mob4Legs.Mob4LeftLeg.Mob4LeftLegColor, models.models.ex_skill_1.Mobs.Mob4.Mob4LowerBody.Mob4Legs.Mob4LeftLeg.Mob4LeftLegLayerColor}) do
							modelPart:setColor(0.49, 0.42, 0.522)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob4.Mob4Head.Mob4HeadRing, models.models.ex_skill_1.Mobs.Mob5.Mob5Head.Mob5HeadRing, models.models.ex_skill_1.Mobs.Mob6.Mob6Head.Mob6HeadRing}) do
							modelPart:setColor(1, 0.98, 0.804)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob5.Mob5Head.Mob5HeadColor, models.models.ex_skill_1.Mobs.Mob5.Mob5Head.Mob5HeadLayerColor}) do
							modelPart:setColor(0.349, 0.286, 0.365)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob5.Mob5UpperBody.Mob5Body.Mob5BodyColor, models.models.ex_skill_1.Mobs.Mob5.Mob5UpperBody.Mob5Body.Mob5BodyLayerColor, models.models.ex_skill_1.Mobs.Mob5.Mob5UpperBody.Mob5Arms.Mob5RightArm.Mob5RightArmColor, models.models.ex_skill_1.Mobs.Mob5.Mob5UpperBody.Mob5Arms.Mob5RightArm.Mob5RightArmLayerColor, models.models.ex_skill_1.Mobs.Mob5.Mob5UpperBody.Mob5Arms.Mob5LeftArm.Mob5LeftArmColor, models.models.ex_skill_1.Mobs.Mob5.Mob5UpperBody.Mob5Arms.Mob5LeftArm.Mob5LeftArmLayerColor, models.models.ex_skill_1.Mobs.Mob5.Mob5LowerBody.Mob5Legs.Mob5RightLeg.Mob5RightLegColor, models.models.ex_skill_1.Mobs.Mob5.Mob5LowerBody.Mob5Legs.Mob5RightLeg.Mob5RightLegLayerColor, models.models.ex_skill_1.Mobs.Mob5.Mob5LowerBody.Mob5Legs.Mob5LeftLeg.Mob5LeftLegColor, models.models.ex_skill_1.Mobs.Mob5.Mob5LowerBody.Mob5Legs.Mob5LeftLeg.Mob5LeftLegLayerColor}) do
							modelPart:setColor(0.294, 0.337, 0.49)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob6.Mob6Head.Mob6HeadColor, models.models.ex_skill_1.Mobs.Mob6.Mob6Head.Mob6HeadLayerColor, models.models.ex_skill_1.Mobs.Mob6.Mob6Head.Mob6HairTail}) do
							modelPart:setColor(0.506, 0.369, 0.322)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob6.Mob6UpperBody.Mob6Body.Mob6BodyColor, models.models.ex_skill_1.Mobs.Mob6.Mob6UpperBody.Mob6Body.Mob6BodyLayerColor, models.models.ex_skill_1.Mobs.Mob6.Mob6UpperBody.Mob6Arms.Mob6RightArm.Mob6RightArmColor, models.models.ex_skill_1.Mobs.Mob6.Mob6UpperBody.Mob6Arms.Mob6RightArm.Mob6RightArmLayerColor, models.models.ex_skill_1.Mobs.Mob6.Mob6UpperBody.Mob6Arms.Mob6LeftArm.Mob6LeftArmColor, models.models.ex_skill_1.Mobs.Mob6.Mob6UpperBody.Mob6Arms.Mob6LeftArm.Mob6LeftArmLayerColor, models.models.ex_skill_1.Mobs.Mob6.Mob6LowerBody.Mob6Legs.Mob6RightLeg.Mob6RightLegColor, models.models.ex_skill_1.Mobs.Mob6.Mob6LowerBody.Mob6Legs.Mob6RightLeg.Mob6RightLegLayerColor, models.models.ex_skill_1.Mobs.Mob6.Mob6LowerBody.Mob6Legs.Mob6LeftLeg.Mob6LeftLegColor, models.models.ex_skill_1.Mobs.Mob6.Mob6LowerBody.Mob6Legs.Mob6LeftLeg.Mob6LeftLegLayerColor}) do
							modelPart:setColor(0.58, 0.231, 0.29)
						end

						ModelAlias.alias.avatar.head.FaceShadow:setOpacity(0.5)

						self.exSkill.primary.stairs:setPos(6, 0, 6)
						self.exSkill.primary.stairs:setRot(0, 180, 0)
						self.exSkill.primary.stairs:setBlock("minecraft:oak_stairs")
						self.exSkill.primary.stairs:setVisible(false)
						if host:isHost() then
							models.models.ex_skill_1.Gui.AnxiousFrame:setColor(0.282, 0.29, 0.725)
						end
						self.exSkill.primary.isInitialized = true
					end
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 7, true)
					elseif tick == 7 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 11, true)
					elseif tick == 18 then
						FaceParts:setEmotion("NORMAL", "INVERTED", "OPENED", 6, true)
					elseif tick == 24 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 8, true)
					elseif tick == 32 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 10, true)
					elseif tick == 38 and host:isHost() then
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob1, models.models.ex_skill_1.Mobs.Mob4}) do
							modelPart:setVisible(false)
						end
					elseif tick == 42 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "OPENED", 5, true)
					elseif tick == 45 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 3, true)
						sounds:playSound("minecraft:entity.wither.spawn", player:getPos(), 0.15, 2)
						if host:isHost() then
							local windowSize = client:getScaledWindowSize()
							models.models.ex_skill_1.Gui.AnxiousFrame:setScale(windowSize.x, windowSize.y, 1)
							models.models.ex_skill_1.Gui.AnxiousFrame:setVisible(true)
						end
					elseif tick == 50 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "ANXIOUS", 6, true)
					elseif tick == 56 then
						FaceParts:setEmotion("NORMAL", "INVERTED", "ANXIOUS", 10, true)
					elseif tick == 66 then
						FaceParts:setEmotion("NORMAL", "INVERTED", "TRIANGLE", 5, true)
					elseif tick == 71 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "TRIANGLE", 10, true)
					elseif tick == 80 then
						ModelAlias.alias.avatar.root:setColor()
						models.models.ex_skill_1.Gui.AnxiousFrame:setVisible(false)
					elseif tick == 81 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 4, true)
					elseif tick == 85 then
						FaceParts:setEmotion("TEAR", "TEAR", "TRIANGLE2", 15, true)
					elseif tick == 100 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.DrinkBottle2, ModelAlias.alias.avatar.body.DrinkBottle3, models.models.ex_skill_1.Mobs}) do
							modelPart:setVisible(false)
						end
						self.exSkill.primary.stairs:setVisible(true)
						ModelAlias.alias.avatar.body.Bag:moveTo(models.models.main)
						ModelAlias.alias.avatar.head.FaceShadow:setVisible(true)
						FaceParts:setEmotion("TIRED", "TIRED", "TIRED", 43, true)
						local bodyYaw = player:getBodyYaw()
						particles:newParticle("minecraft:soul", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.mouth):add(vectors.rotateAroundAxis(-bodyYaw, 0.1, 0.17, 0.35, 0, 1, 0))):setScale(0.75):setVelocity(vectors.rotateAroundAxis(-bodyYaw, -0.01, 0, 0, 0, 1, 0)):setLifetime(40)
						local playerPos = player:getPos()
						for _ = 1, 50 do
							particles:newParticle("minecraft:effect", playerPos:copy():add(math.random() * 1.5 - 0.75, math.random() * 1.5 + 0.5, math.random() * 1.5 - 0.75)):setColor(0.1, 0.1, 0.1):setGravity(0.1):setLifetime(40)
						end
						sounds:playSound("minecraft:block.beacon.deactivate", playerPos, 1, 2)
					end
					if tick >= 45 and tick <= 56 then
						ModelAlias.alias.avatar.root:setColor(vectors.vec3(1, 1, 1):scale(1 - math.map(tick, 45, 56, 0, 0.25)))
						if host:isHost() then
							models.models.ex_skill_1.Gui.AnxiousFrame:setOpacity(math.map(tick, 45, 56, 0, 1))
						end
					end
					if tick >= 8 and tick < 80 then
						particles:newParticle("minecraft:splash", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head)):setPower(2)
						if tick % 4 == 0 then
							sounds:playSound("minecraft:block.bubble_column.bubble_pop", player:getPos(), 0.15, 2 - math.random() * 0.5)
						end
					elseif tick >= 85 and tick < 100 and tick % 2 == 0 then
						sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 0.5, 2)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if models.models.main.Bag ~= nil then
						models.models.main.Bag:moveTo(ModelAlias.alias.avatar.body)
					end
					self.exSkill.primary.stairs:setVisible(false)
					ModelAlias.alias.avatar.head.FaceShadow:setVisible(false)
					if host:isHost() then
						for _, modelPart in ipairs({models.models.ex_skill_1.Mobs.Mob1, models.models.ex_skill_1.Mobs.Mob4}) do
							modelPart:setVisible(true)
						end
					end
					if forcedStop then
						ModelAlias.alias.avatar.root:setColor()
						if host:isHost() then
							models.models.ex_skill_1.Gui.AnxiousFrame:setVisible(false)
						end
					end
				end;
			};

			---Exスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---Exスキル2で使用する階段ブロック
			---@type BlockTask
			stairs = models.models.main:newBlock("ex_skill_stairs")
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.head.HairBandRibbon, ModelAlias.alias.avatar.head.HairTail}) do
						modelPart:setPos(0, 0, isVisible and 1 or 0)
					end
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.FrontHair:setVisible(not isVisible)
					ModelAlias.alias.avatar.body.FrontHair:setPos(0, 0, isVisible and 1 or 0)
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
		includeModels = {models.models.main.Avatar.UpperBody.Body.FrontHair};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function ()
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.head.Ears.RightEarPivot, ModelAlias.alias.dummy_avatar.head.Ears.LeftEarPivot}) do
					modelPart:setRot(-30, 0, 0)
				end
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(17.5, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Bag:setPos(3, 2, 0)
				ModelAlias.alias.dummy_avatar.body.Bag:setRot(0, 0, -25)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(-15, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Bag:setPos()
				ModelAlias.alias.dummy_avatar.body.Bag:setRot()
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
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
				models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopLeftYPivot};

				y = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 80;
						headRotMultiplayer = 0.5;

						headX = {
							multiplayer = 160;
							min = 0;
							max = 80;
						};

						headRot = {
							multiplayer = -0.1;
							min = 0;
							max = 80;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopLeftYPivot.HairBandRibbonTopLeftZPivot};

				z = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyY = {
							multiplayer = 20;
							min = -40;
							max = 40;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopRightYPivot};

				y = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 0;
						headRotMultiplayer = -0.5;

						headX = {
							multiplayer = -160;
							min = -80;
							max = 0;
						};

						headRot = {
							multiplayer = 0.1;
							min = -80;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopRightYPivot.HairBandRibbonTopRightZPivot};

				z = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyY = {
							multiplayer = -20;
							min = -40;
							max = 40;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomLeftXPivot, ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomRightXPivot};

				x = {
					vertical = {
						min = -170;
						neutral = 0;
						max = 0;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -160;
							min = -80;
							max = 0;
						};

						headRot = {
							multiplayer = 0.1;
							min = -80;
							max = 0;
						};

						bodyY = {
							multiplayer = 160;
							min = -170;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomLeftXPivot.HairBandRibbonBottomLeftZPivot};

				z = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 30;

						headX = {
							multiplayer = 20;
							min = 0;
							max = 30;
						};

						headRot = {
							multiplayer = -0.1;
							min = 0;
							max = 30;
						};

						bodyY = {
							multiplayer = 20;
							min = 0;
							max = 30;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomRightXPivot.HairBandRibbonBottomRightZPivot};

				z = {
					vertical = {
						min = -30;
						neutral = 0;
						max = 0;

						headX = {
							multiplayer = -20;
							min = -30;
							max = 0;
						};

						headRot = {
							multiplayer = 0.1;
							min = -30;
							max = 0;
						};

						bodyY = {
							multiplayer = -20;
							min = -30;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Bag.BagHooks.BagHookNorth.IDCard.IDCardXPivot, ModelAlias.alias.avatar.body.Bag.BagBaseFastener1XPivot, ModelAlias.alias.avatar.body.Bag.BagBaseFastener2XPivot, ModelAlias.alias.avatar.body.Bag.BackPocket.BackPocketFastenerXPivot},

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 80;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 80;
						};

						bodyY = {
							multiplayer = -160;
							min = 0;
							max = 80
						};

						bodyRot = {
							multiplayer = -0.1;
							min = 0;
							max = 80;
						};
					};
				};
			};

			{
				models =  {ModelAlias.alias.avatar.body.Bag.BagHooks.BagHookNorth.IDCard.IDCardXPivot.IDCardZPivot, ModelAlias.alias.avatar.body.Bag.BagBaseFastener1XPivot.BagBaseFastener1ZPivot, ModelAlias.alias.avatar.body.Bag.BagBaseFastener2XPivot.BagBaseFastener2ZPivot, ModelAlias.alias.avatar.body.Bag.BackPocket.BackPocketFastenerXPivot.BackPocketFastenerZPivot},

				z = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 80;

						headZ = {
							multiplayer = -160;
							min = -80;
							max = 80;
						};
					};
				};
			};
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model == ModelAlias.alias.avatar.head.HairTail then
					model:setRot(math.min(model:getRot().x, 20), 0, 0)
				elseif model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopRightYPivot then
					model:setRot(0, math.min(model:getRot().y, 0), 0)
				elseif model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopLeftYPivot then
					model:setRot(0, math.max(model:getRot().y, 0), 0)
				elseif model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomRightXPivot or model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomLeftXPivot then
					model:setRot(math.min(model:getRot().x, 0), 0, 0)
				end
			end
		};
	};
}

return BlueArchiveCharacter
