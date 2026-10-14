---右目のテクスチャの列挙型
---@alias Character03c.RightEyeTextures
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
---@alias Character03c.LeftEyeTextures
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
---@alias Character03c.MouthTextures
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

---@class (exact) Character03c.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character03c.RightEyeTextures 右目の表情名
---@field public leftEye Character03c.LeftEyeTextures 左目の表情名
---@field public mouth Character03c.MouthTextures 口の表情名

---@class (exact) Character03c.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character03c.EmotionSet ダメージを受けたとき
---@field public onSleep? Character03c.EmotionSet ベッドで寝ているとき

---@class (exact) Character03c.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character03c, right: Character03c.RightEyeTextures, left: Character03c.LeftEyeTextures, mouth: Character03c.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character03c.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character03c.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character03c.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character03c.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character03c.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character03c.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character03c : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character03c.FacePartsStruct 目や口による表情

---@type Character03c
local BlueArchiveCharacter = {
	basic = {
		avatarName = "03c_Mari_Idol";

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
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
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
			name = {
				en_us = "Overflowing heart";
				ja_jp = "溢れるハート";
			};

			formationType = "STRIKER";

			models = {models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(0, 25, -22);
				};

				fin = {
					rot = vectors.vec3(-20, 200, -10);
					pos = vectors.vec3(-6, 50, -18);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					self.costume.callbacks.onAltChange(self, true)
					ModelAlias.alias.avatar.head.Ears.RightEarPivot:setRot()

					if not self.exSkill.primary.isInitialized then
						for _, modelPart in ipairs({models.models.ex_skill_1.Stage.StageFloor, models.models.ex_skill_1.Stage.StageStair1, models.models.ex_skill_1.Stage.StageStair2, models.models.ex_skill_1.Stage.StageStair3, models.models.ex_skill_1.Stage.StageStair4}) do
							modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/block/gray_concrete.png")
						end
						--ペンライトの作成
						local penLightColors = {vectors.vec3(1, 0.855, 0.584), vectors.vec3(0.698, 1, 0.97), vectors.vec3(0.81, 1, 0.698)}
						for i = 1, 100 do
							local model = models.models.ex_skill_1.Stage.PenLights["PenLight"..i]
							if model == nil then
								model = ModelUtils:copyModel(models.models.ex_skill_1.Stage.PenLights.PenLight1, "PenLight"..i, true)
								models.models.ex_skill_1.Stage.PenLights:addChild(model)
							end
							model.PenLightEmissive:setColor(penLightColors[math.floor(math.random() * 3) + 1])
						end
						if host:isHost() then
							--モデルのコピー
							for _, modelPart in ipairs({ModelAlias.alias.avatar.head, ModelAlias.alias.avatar.halo, ModelAlias.alias.avatar.mouth}) do
								modelPart:setVisible(true)
							end
							ModelAlias.alias.avatar.head:setPrimaryRenderType()
							ModelAlias.alias.avatar.head:setOpacity(1)
							ModelAlias.alias.avatar.gun:setVisible(false)
							local armorVisible = {
								helmet = Armor.isArmorVisible.helmet;
								chestplate = Armor.isArmorVisible.chestplate;
								leggings = Armor.isArmorVisible.leggings;
								boots = Armor.isArmorVisible.boots;
							}
							if armorVisible.helmet then
								Armor:setHelmet(world.newItem("minecraft:air"))
								ModelAlias.alias.avatar.head.Hat:setVisible(false)
							end
							if armorVisible.chestplate then
								Armor:setChestplate(world.newItem("minecraft:air"))
							end
							if armorVisible.leggings then
								Armor:setLeggings(world.newItem("minecraft:air"))
								ModelAlias.alias.avatar.body.Skirt:setVisible(false)
							end
							if armorVisible.boots then
								Armor:setBoots(world.newItem("minecraft:air"))
							end
							for i = 1, 4 do
								models.models.ex_skill_1.Gui.Scrollable.Characters["Pose"..i]:addChild(ModelUtils:copyModel(ModelAlias.alias.avatar.root))
							end
							ModelAlias.alias.avatar.mouth:setVisible(false)

							--ポーズの作成
							local pose1 = ModelAlias:getAliasTable(models.models.ex_skill_1.Gui.Scrollable.Characters.Pose1.Avatar)
							pose1.root:setRot(-2.7199, 19.8217, -7.9753)
							pose1.head:setRot(2.664, -14.7669, -10.3453)
							pose1.head.Ears.RightEarPivot:setRot(0, 0, -15)
							pose1.head.Ears.LeftEarPivot:setRot(0, 0, -15)
							pose1.head.TraineeHairTail:setRot(-22.5, 0, 20)
							pose1.body.TraineeFrontHair:setRot(15, 0, 0)
							pose1.rightArm:setRot(0, 0, 22.5)
							pose1.leftArm:setRot(0, 90, -110)
							pose1.rightLeg:setRot(52.0721, 46.6851, 28.5204)
							pose1.rightLegBottom:setRot(-60, 0, 0)
							pose1.leftLeg:setRot(0, 0, 15)
							pose1.rightEye:setUVPixels(self.faceParts.rightEye.CLOSED:copy():scale(6))
							pose1.mouth:setUVPixels(self.faceParts.mouth.OPENED2:copy():mul(16, 8))

							local pose2 = ModelAlias:getAliasTable(models.models.ex_skill_1.Gui.Scrollable.Characters.Pose2.Avatar)
							pose2.root:setRot(-0.9096, -19.9801, 2.6602)
							pose2.head:setRot(-2.7199, 19.8217, -7.9753)
							pose2.head.Ears.RightEarPivot:setRot(0, 0, 5)
							pose2.body.TraineeFrontHair:setRot(22.5, 0, 0)
							pose2.rightArm:setRot(32.5, 67.5, 0)
							pose2.rightArmBottom:setRot(70, 0, 0)
							pose2.leftArm:setRot(103.7833, -8.4773, 119.2288)
							pose2.leftArmBottom:setRot(10, 0, 0)
							pose2.rightLeg:setRot(0, 12.5, 0)
							pose2.leftLeg:setRot(0, 0, -10)
							pose2.mouth:setUVPixels(self.faceParts.mouth.SMILE:copy():mul(16, 8))

							local pose3 = ModelAlias:getAliasTable(models.models.ex_skill_1.Gui.Scrollable.Characters.Pose3.Avatar)
							pose3.root:setRot(-98.9287, -27.6048, -13.6459)
							pose3.head:setRot(85, 0, 0)
							pose3.head.Ears.RightEarPivot:setRot(-30, 0, -10)
							pose3.head.Ears.LeftEarPivot:setRot(-30, 0, 10)
							pose3.head.TraineeHairTail:setRot(-87.5, -22.5, 0)
							pose3.body.TraineeFrontHair:setPos(0, 3, 2)
							pose3.body.TraineeFrontHair:setRot(90, 0, 0)
							pose3.rightArm:setRot(-180, 0, -7.5)
							pose3.leftArm:setRot(-180, 0, 7.5)
							pose3.rightLeg:setRot(-39.8593, 2.2494, 7.1566)
							pose3.rightLegBottom:setRot(-40, 0, 0)
							pose3.leftLeg:setRot(-4.7697, -1.5018, -17.4374)
							pose3.leftLegBottom:setRot(-25, 0, 0)
							pose3.rightEye:setUVPixels(self.faceParts.rightEye.UNEQUAL:copy():scale(6))
							pose3.leftEye:setUVPixels(self.faceParts.leftEye.UNEQUAL:copy():scale(6))
							pose3.mouth:setUVPixels(self.faceParts.mouth.TRIANGLE:copy():mul(16, 8))

							local pose4 = ModelAlias:getAliasTable(models.models.ex_skill_1.Gui.Scrollable.Characters.Pose4.Avatar)
							pose4.root:setRot(-30, 30, 0)
							pose4.head:setRot(9.8511, 1.7279, -9.8511)
							pose4.head.Ears.RightEarPivot:setRot(-40, 0, -10)
							pose4.head.Ears.LeftEarPivot:setRot(-40, 0, 10)
							pose4.body.TraineeFrontHair:setRot(-5, 0, 15)
							pose4.body.TraineeFrontHair:setRot(25, 0, 0)
							pose4.rightArm:setRot(62.5, 65, 0)
							pose4.rightArmBottom:setRot(47.5, 0, 0)
							pose4.leftArm:setRot(28.8384, -8.6474, 15.2727)
							pose4.rightLeg:setRot(60, 0, 0)
							pose4.rightLegBottom:setRot(-37.5, 0, 0)
							pose4.leftLeg:setRot(60, 0, 0)
							pose4.leftLegBottom:setRot(-37.5, 0, 0)
							pose4.mouth:setUVPixels(self.faceParts.mouth.SMALL:copy():mul(16, 8))
							if armorVisible.helmet then
								Armor:setHelmet(Armor.armorSlotItems[1])
							end
							if armorVisible.chestplate then
								Armor:setChestplate(Armor.armorSlotItems[2])
							end
							if armorVisible.leggings then
								Armor:setLeggings(Armor.armorSlotItems[3])
							end
							if armorVisible.boots then
								Armor:setBoots(Armor.armorSlotItems[4])
							end

							--白い縁取りと影の作成
							local outlineTexture = textures:newTexture("ex_skill_1_character_outline", 1, 1)
							outlineTexture:fill(0, 0, 1, 1, 1, 1, 1)
							for i = 1, 4 do
								local outlineAvatar = ModelUtils:copyModel(models.models.ex_skill_1.Gui.Scrollable.Characters["Pose"..i].Avatar, "OutlineAvatar")
								local outlineAlias = ModelAlias:getAliasTable(outlineAvatar)
								for _, modelPart in ipairs({outlineAlias.head.Head, outlineAlias.head.HatLayer, outlineAlias.body.Body, outlineAlias.body.BodyLayer, outlineAlias.rightArm.RightArm, outlineAlias.rightArm.RightArmLayer, outlineAlias.rightArmBottom.RightArmBottom, outlineAlias.rightArmBottom.RightArmBottomLayer, outlineAlias.leftArm.LeftArm, outlineAlias.leftArm.LeftArmLayer, outlineAlias.leftArmBottom.LeftArmBottom, outlineAlias.leftArmBottom.LeftArmBottomLayer, outlineAlias.rightLeg.RightLeg, outlineAlias.rightLeg.RightLegLayer, outlineAlias.rightLegBottom.RightLegBottom, outlineAlias.rightLegBottom.RightLegBottomLayer, outlineAlias.leftLeg.LeftLeg, outlineAlias.leftLeg.LeftLegLayer, outlineAlias.leftLegBottom.LeftLegBottom, outlineAlias.leftLegBottom.LeftLegBottomLayer}) do
									modelPart:setPrimaryTexture("CUSTOM", outlineTexture)
								end
								outlineAvatar:setPrimaryRenderType("EMISSIVE_SOLID")
								outlineAvatar:setPrimaryTexture("CUSTOM", outlineTexture)
								---@diagnostic disable-next-line: discard-returns
								models.models.ex_skill_1.Gui.Scrollable.Characters["Pose"..i]:newPart("Outline")
								models.models.ex_skill_1.Gui.Scrollable.Characters["Pose"..i].Outline:setPos(0, 0, 50)
								models.models.ex_skill_1.Gui.Scrollable.Characters["Pose"..i].Outline:setScale(1.2, 1.2, 0)
								models.models.ex_skill_1.Gui.Scrollable.Characters["Pose"..i].Outline:addChild(outlineAvatar)

								local shaderAvatar = models.models.ex_skill_1.Gui.Scrollable.Characters["Pose"..i].Outline.OutlineAvatar:copy("ShaderAvatar")
								shaderAvatar:setPos(-1, -1, 0)
								shaderAvatar:setColor(0.478, 0.631, 0.98)
								---@diagnostic disable-next-line: discard-returns
								models.models.ex_skill_1.Gui.Scrollable.Characters["Pose"..i]:newPart("Shader")
								models.models.ex_skill_1.Gui.Scrollable.Characters["Pose"..i].Shader:setPos(i <= 2 and 2 or -0.25, -0.25, 51)
								models.models.ex_skill_1.Gui.Scrollable.Characters["Pose"..i].Shader:setScale(1.2, 1.2, 0)
								models.models.ex_skill_1.Gui.Scrollable.Characters["Pose"..i].Shader:addChild(shaderAvatar)
							end
							--波型背景の作成
							models.models.ex_skill_1.Gui.Scrollable.WaveBackground.UpperWave:setPos(0, 0, 600)
							models.models.ex_skill_1.Gui.Background.UpperLine:setPos(0, 0, 601)
							---背景の円とキラキラを作成
							models.models.ex_skill_1.Gui.Scrollable2:setPos(0, 0, 602)
							for i = 2, 10 do
								models.models.ex_skill_1.Gui.Scrollable2:addChild(models.models.ex_skill_1.Gui.Scrollable2.Circle1:copy("Circle"..i))
							end
							for i = 2, 20 do
								models.models.ex_skill_1.Gui.Scrollable2:addChild(models.models.ex_skill_1.Gui.Scrollable2.Shine1:copy("Shine"..i))
							end
							---グラデーション背景の作成
							models.models.ex_skill_1.Gui.Background.GradientBackground:setPos(0, 0, 603)
							models.models.ex_skill_1.Gui.Background.GradientBackground:setColor(0.463, 0.875, 0.996)
							models.models.ex_skill_1.Gui.Background.GradientBackground.GradientBackground1:setPos(-150, 182, 0)
							--縞背景の作成
							models.models.ex_skill_1.Gui.Background.StripeBackground:setPos(0, 0, 604)
							models.models.ex_skill_1.Gui.Background.StripeBackground.StripeBackground1:setPos(0, 6, 0)
							--トランジションの円棒の作成
							for i = 2, 20 do
								models.models.ex_skill_1.Gui.Transition.CirclePillars:addChild(models.models.ex_skill_1.Gui.Transition.CirclePillars.Pillar1:copy("Pillar"..i))
							end
							models.models.ex_skill_1.Gui.Frame:setColor(1, 0.875, 1)
							models.models.ex_skill_1.Gui.Frame:setOpacity(0.75)
						end
						for i = 2, 3 do
							models.models.ex_skill_1.Stage.SpotLights["SpotLight"..i]["SpotLight"..i.."Core"].SpotLightEmissive:setColor(0.729, 1, 0.996)
						end
						self.exSkill.primary.isInitialized = true
					end

					if host:isHost() then
						local windowSize = client:getScaledWindowSize()
						--キャラクターの位置調整
						local characterScale = windowSize.y / 270
						models.models.ex_skill_1.Gui.Scrollable.Characters:setPos((windowSize.x - windowSize.y / 0.5625) / 2 * -1)
						models.models.ex_skill_1.Gui.Scrollable.Characters:setScale(vectors.vec3(1, 1, 0):scale(characterScale):add(0, 0, 1))
						--波型背景の配置
						models.models.ex_skill_1.Gui.Scrollable.WaveBackground.LowerWave:setPos(0, windowSize.y * -1 + 30, 600)
						for i = 1, (windowSize.x + 160 * characterScale) / 92 + 1 do
							if models.models.ex_skill_1.Gui.Scrollable.WaveBackground.UpperWave["UpperWave"..i] == nil then
								local upperWave = models.models.ex_skill_1.Gui.Scrollable.WaveBackground.UpperWave.UpperWave1:copy("UpperWave"..i)
								upperWave:setPos((i - 1) * -92, 0, 0)
								models.models.ex_skill_1.Gui.Scrollable.WaveBackground.UpperWave:addChild(upperWave)
							end
							if models.models.ex_skill_1.Gui.Scrollable.WaveBackground.LowerWave.LowerWave1["LowerWave"..i] == nil then
								local lowerWave = models.models.ex_skill_1.Gui.Scrollable.WaveBackground.LowerWave.LowerWave1:copy("LowerWave"..i)
								lowerWave:setPos((i - 1) * -92, 0, 0)
								models.models.ex_skill_1.Gui.Scrollable.WaveBackground.LowerWave:addChild(lowerWave)
							end
						end
						models.models.ex_skill_1.Gui.Background.UpperLine:setScale(windowSize.x, 1, 1)
						models.models.ex_skill_1.Gui.Background.LowerLine:setPos(0, windowSize.y * -1 + 48, 601)
						models.models.ex_skill_1.Gui.Background.LowerLine:setScale(windowSize.x, 1, 1)
						--グラデーション背景の配置
						local gradientPanelSize = windowSize.y / math.sqrt(2) * 2
						models.models.ex_skill_1.Gui.Background.GradientBackground.GradientBackground1:setScale(1, gradientPanelSize, 1)
						for i = 1, (windowSize.x + windowSize.y) / math.sqrt(2) / 150 + 1 do
							local model = models.models.ex_skill_1.Gui.Background.GradientBackground["GradientBackground"..i]
							if model == nil then
								model = models.models.ex_skill_1.Gui.Background.GradientBackground.GradientBackground1:copy("GradientBackground"..i)
								models.models.ex_skill_1.Gui.Background.GradientBackground:addChild(model)
							end
							model:setPos((i - 1) * -150, (i - 1) * 150 + 32, 0)
							model:setScale(1, gradientPanelSize, 1)
						end
						--背景の円とキラキラの配置
						for i = 1, 10 do
							models.models.ex_skill_1.Gui.Scrollable2["Circle"..i]:setPos((math.random() * (windowSize.x + 100 * math.sqrt(2)) - 100 * math.sqrt(2)) * -1, math.random() * (windowSize.y + 100 * math.sqrt(2)) * -1, 0)
							models.models.ex_skill_1.Gui.Scrollable2["Circle"..i]:setScale(vectors.vec3(1, 1, 1):scale(math.random() * 0.1 + 0.95))
						end
						for i = 1, 20 do
							models.models.ex_skill_1.Gui.Scrollable2["Shine"..i]:setPos((math.random() * (windowSize.x + 100 * math.sqrt(2)) - 100 * math.sqrt(2)) * -1, math.random() * (windowSize.y + 100 * math.sqrt(2)) * -1, 0)
						end
						--縞背景の配置
						local stripePanelSize = windowSize.y / math.sqrt(2) + 3
						models.models.ex_skill_1.Gui.Background.StripeBackground.StripeBackground1:setScale(1, stripePanelSize, 1)
						for i = 2, (windowSize.x + windowSize.y) / (6 * math.sqrt(2)) + 2 do
							local model = models.models.ex_skill_1.Gui.Background.StripeBackground["StripeBackground"..i]
							if model == nil then
								model = models.models.ex_skill_1.Gui.Background.StripeBackground.StripeBackground1:copy("StripeBackground"..i)
								models.models.ex_skill_1.Gui.Background.StripeBackground:addChild(model)
							end
							model:setPos((i - 1) * -6, 6 * (i - 1), 0)
							model:setScale(1, stripePanelSize, 1)
						end
						--トランジションの配置
						local transitionCenter = vectors.vec3(windowSize.x / 2 * -1, windowSize.y / 2 * -1, -200 * characterScale)
						local rearTransitionSize = (windowSize.x + windowSize.y) / math.sqrt(2)
						models.models.ex_skill_1.Gui.Transition.Background:setScale(rearTransitionSize, rearTransitionSize, 1)
						--トランジションの円棒の配置
						local colorPalette = {vectors.vec3(0.482, 0.91, 1), vectors.vec3(0.749, 1, 0.996), vectors.vec3(1, 1, 0.663)}
						for i = 1, 20 do
							models.models.ex_skill_1.Gui.Transition.CirclePillars["Pillar"..i]:setPos((math.random() * 2 - 1) * (rearTransitionSize / 2), (math.random() * 2 - 1) * (rearTransitionSize / 2 * 1.2), 0)
							local pillarScaleFactor = math.random() * 0.75 + 0.25
							models.models.ex_skill_1.Gui.Transition.CirclePillars["Pillar"..i]:setScale(vectors.vec3(4, 4, 4):scale(pillarScaleFactor))
							local pillarHeight = -160 * pillarScaleFactor + 220
							models.models.ex_skill_1.Gui.Transition.CirclePillars["Pillar"..i].CenterCircle:setScale(1, pillarHeight, 1)
							models.models.ex_skill_1.Gui.Transition.CirclePillars["Pillar"..i].UpperCircle:setPos(0, pillarHeight / 2 - 1, 0)
							models.models.ex_skill_1.Gui.Transition.CirclePillars["Pillar"..i].LowerCircle:setPos(0, pillarHeight / 2 * -1 + 1, 0)
							models.models.ex_skill_1.Gui.Transition.CirclePillars["Pillar"..i]:setColor(colorPalette[math.floor(math.random() * 3) + 1])
						end
						--レンダーイベント
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.Scrollable:setPos(models.models.ex_skill_1.ScrollableAnchor:getAnimPos():scale(characterScale))
							models.models.ex_skill_1.Gui.Transition:setPos(transitionCenter:copy():add(models.models.ex_skill_1.TransitionAnchor:getAnimPos():scale(rearTransitionSize)))
							models.models.ex_skill_1.Gui.WhiteScreen:setOpacity(models.models.ex_skill_1.Gui.WhiteScreen.GOpacity:getAnimScale().x)
						end, "ex_skill_1_render")
					end

					events.RENDER:register(function ()
						local strength = models.models.ex_skill_1.Stage.StageEmissiveStrength:getAnimScale().x
						models.models.ex_skill_1.Stage.StageEmissives:setColor(vectors.vec3(1, 1, 1):scale(strength))
						models.models.ex_skill_1.Stage.SpotLights.SpotLight1.SpotLight1Core.SpotLightEmissive:setColor(vectors.vec3(1, 0.875, 1):scale(strength))
					end, "ex_skill_1_render_global")

					for i = 1, 100 do
						models.models.ex_skill_1.Stage.PenLights["PenLight"..i]:setPos(math.map(math.random(), 0, 1, -160, 160), 32, math.map(math.random(), 0, 1, -400, -80))
						self.exSkill.primary.penLightSwingOffsets[i] = math.random()
					end
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMALL", 56, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 9 and host:isHost() then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.5, 1.5)
					elseif tick == 23 and host:isHost() then
						sounds:playSound("minecraft:entity.player.hurt", player:getPos(), 0.5, 1.2)
					elseif tick == 39 and host:isHost() then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.5, 1.5)
					elseif tick == 50 and host:isHost() then
						models.models.ex_skill_1.Gui.Transition:setVisible(true)
					elseif tick == 53 and host:isHost() then
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.Scrollable, models.models.ex_skill_1.Gui.Scrollable2, models.models.ex_skill_1.Gui.Background}) do
							modelPart:setVisible(false)
						end
					elseif tick == 56 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMALL", 5, true)
						if host:isHost() then
							models.models.ex_skill_1.Gui.Transition:setVisible(false)
						end
					elseif tick == 61 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 36, true)
					elseif tick == 66 and host:isHost() then
						local windowSize = client:getWindowSize()
						models.models.ex_skill_1.Gui.WhiteScreen:setVisible(true)
						models.models.ex_skill_1.Gui.WhiteScreen:setScale(windowSize.x, windowSize.y, 1)
						models.models.ex_skill_1.Camera.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(40))
						events.RENDER:register(function (delta, context)
							models.models.ex_skill_1.Camera:setVisible(context == "RENDER")
							local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.75)), 0, 1, 0):scale(16 / 0.9375)
							models.models.ex_skill_1.Camera:setOffsetPivot(backgroundPos)
							models.models.ex_skill_1.Camera.Background:setPos(backgroundPos)
							local opacity = models.models.ex_skill_1.Camera.COpacity:getAnimScale().x
							models.models.ex_skill_1.Camera.Background:setOpacity(opacity)
							models.models.main.Avatar:setColor(vectors.vec3(1, 1, 1):scale(1 - opacity))
						end, "ex_skill_1_background_render")
					elseif tick == 69 then
						self.costume.callbacks.onAltChange(self, false)

						if not Armor.isArmorVisible.helmet then
							ModelAlias.alias.avatar.head.Hat:setVisible(true)
							ModelAlias.alias.avatar.head.Ears.RightEarPivot:setRot(-45, -10, 0)
						end
						if not Armor.isArmorVisible.leggings then
							ModelAlias.alias.avatar.body.Skirt:setVisible(true)
						end
						models.models.ex_skill_1.Stage:setVisible(true)
						events.RENDER:register(function (delta)
							for i = 1, 100 do
								models.models.ex_skill_1.Stage.PenLights["PenLight"..i]:setRot(0, 0, math.sin((self.exSkill.primary.penLightSwingOffsets[i] + delta * 0.1) * 2 * math.pi) * 40)
							end
						end, "ex_skill_1_pen_light_render")
					elseif tick == 81 and host:isHost() then
						events.RENDER:remove("ex_skill_1_background_render")
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.WhiteScreen, models.models.ex_skill_1.Camera}) do
							modelPart:setVisible(false)
						end
						models.models.main.Avatar:setColor(1, 1, 1)
					elseif tick == 97 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", 3, true)
					elseif tick == 100 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TRIANGLE3", 12, true)
					elseif tick == 112 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMALL", 16, true)
					elseif tick == 128 then
						FaceParts:setEmotion("NARROW1", "NARROW1", "SMILE", 2, true)
					elseif tick == 130 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 17, true)
					elseif tick == 136 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos():add(0, 2, 0), 0.1, 2)
					elseif tick == 147 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED2", 2, true)
					elseif tick == 148 then
						for _ = 1, 4 do
							table.insert(self.exSkill.primary.particleAnchors, {vectors.rotateAroundAxis(math.random() * 360, 0, math.random() * 1.5 + 0.5, 1.5, 0, 1, 0), vectors.hsvToRGB(math.random() * 0.28 + 0.9, 0.5, 1), math.random()})
						end
					elseif tick == 149 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "OPENED2", 22, true)
					elseif tick == 171 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 4, true)
					elseif tick == 172 and host:isHost() then
						models.models.ex_skill_1.Gui.WhiteScreen:setVisible(true)
					elseif tick == 175 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED2", 38, true)
					elseif tick == 176 and host:isHost() then
						local windowSize = client:getScaledWindowSize()
						models.models.ex_skill_1.Gui.Frame:setScale(windowSize.x, windowSize.y, 1)
						models.models.ex_skill_1.Gui.Frame:setVisible(true)
					elseif tick == 178 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos():add(0, 2, 0), 1, 1.5)
						if host:isHost() then
							models.models.ex_skill_1.Gui.WhiteScreen:setVisible(false)
						end
					end

					for _ = 1, 12 do
						models.models.ex_skill_1.Stage.StageEmissives:setUVPixels(tick * -1, 0)
					end
					if tick >= 69 and tick < 81 then
						models.models.ex_skill_1.Camera.Background:setUVPixels((tick - 69) * -10, 0)
					end
					if tick >= 69 then
						for i = 1, 100 do
							self.exSkill.primary.penLightSwingOffsets[i] = self.exSkill.primary.penLightSwingOffsets[i] + 0.1
							self.exSkill.primary.penLightSwingOffsets[i] = self.exSkill.primary.penLightSwingOffsets[i] > 1 and self.exSkill.primary.penLightSwingOffsets[i] - 1 or self.exSkill.primary.penLightSwingOffsets[i]
						end
						if (tick - 69) % 8 == 0 then
							sounds:playSound("minecraft:weather.rain", player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 1, 8, 0, 1, 0)), 0.5, 1.5)
						end
					end
					if tick >= 136 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = player:getPos():add(vectors.rotateAroundAxis(bodyYaw * -1, -6, 3, -4, 0, 1, 0))
						for _ = 1, 2 do
							particles:newParticle("minecraft:firework", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 12, math.random() * 6, math.random() * 6, 0, 1, 0))):setColor(1, 1, 0.6)
						end
					end
					if tick >= 148 and tick < 166 then
						local playerPos = player:getPos():add(0, 2, 0)
						local bodyYaw = player:getBodyYaw() * -1 + models.models.main.Avatar:getAnimRot().y * 0.5
						for i = 1, 4 do
							local anchorPos = playerPos:copy():add(vectors.rotateAroundAxis(bodyYaw, self.exSkill.primary.particleAnchors[i][1]:copy():add(0, math.sin(((tick - 148) / 18 + self.exSkill.primary.particleAnchors[i][3]) * 8 * math.pi) * 0.25, 0), 0, 1, 0))
							particles:newParticle("minecraft:firework", anchorPos):setScale(1):setVelocity(anchorPos:copy():sub(playerPos):normalize():mul(0.05, 0, 0.05)):setColor(self.exSkill.primary.particleAnchors[i][2]):setGravity(0):setLifetime(213 - tick)
						end
					end
					if tick >= 148 and tick < 176 then
						sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos():add(0, 2, 0), 0.5, 1 + ((tick - 148) / 28))
					end
				end;

				onPostAnimation = function (self, forcedStop)
					for _, eventName in ipairs({"ex_skill_1_render_global", "ex_skill_1_pen_light_render"}) do
						events.RENDER:remove(eventName)
					end
					models.models.ex_skill_1.Stage:setVisible(false)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.Scrollable, models.models.ex_skill_1.Gui.Scrollable2, models.models.ex_skill_1.Gui.Background}) do
							modelPart:setVisible(true)
						end
						models.models.ex_skill_1.Gui.Frame:setVisible(false)
					end
					self.costume.callbacks.onAltChange(self, Costume.isAltCostume)
					if forcedStop then
						self.exSkill.primary.penLightSwingOffsets = {}
						self.exSkill.primary.particleAnchors = {}
						if host:isHost() then
							events.RENDER:remove("ex_skill_1_background_render")
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.Transition, models.models.ex_skill_1.Gui.WhiteScreen, models.models.ex_skill_1.Camera}) do
								modelPart:setVisible(false)
							end
							ModelAlias.alias.avatar.root:setColor(1, 1, 1)
						end
					end
				end;
			};

			---Exスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---ペンライトの振り時間のオフセット値
			---@type number[]
			penLightSwingOffsets = {};

			---くるりんぱする時のパーティクルのアンカー位置
			---@type table[]
			particleAnchors = {};
		};
	};

	costume = {
		isAltCostumeEnabled = true;

		callbacks = {
			onAltChange = function (_, isAlt)
				for _, modelPart in ipairs({ModelAlias.alias.avatar.head.Head, ModelAlias.alias.avatar.head.HatLayer, ModelAlias.alias.avatar.body.Body, ModelAlias.alias.avatar.body.BodyLayer, ModelAlias.alias.avatar.rightArm.RightArm, ModelAlias.alias.avatar.rightArm.RightArmLayer, ModelAlias.alias.avatar.rightArmBottom.RightArmBottom, ModelAlias.alias.avatar.rightArmBottom.RightArmBottomLayer, ModelAlias.alias.avatar.leftArm.LeftArm, ModelAlias.alias.avatar.leftArm.LeftArmLayer, ModelAlias.alias.avatar.leftArmBottom.LeftArmBottom, ModelAlias.alias.avatar.leftArmBottom.LeftArmBottomLayer, ModelAlias.alias.avatar.rightLeg.RightLeg, ModelAlias.alias.avatar.rightLeg.RightLegLayer, ModelAlias.alias.avatar.rightLegBottom.RightLegBottom, ModelAlias.alias.avatar.rightLegBottom.RightLegBottomLayer, ModelAlias.alias.avatar.leftLeg.LeftLeg, ModelAlias.alias.avatar.leftLeg.LeftLegLayer, ModelAlias.alias.avatar.leftLegBottom.LeftLegBottom, ModelAlias.alias.avatar.leftLegBottom.LeftLegBottomLayer}) do
					if isAlt then
						modelPart:setPrimaryTexture("CUSTOM", textures["textures.ex_skill_1_skin"])
					else
						modelPart:setPrimaryTexture("PRIMARY")
					end
				end

				ModelAlias.alias.avatar.head.Hat:setVisible(not isAlt and not Armor.isArmorVisible.helmet)
				ModelAlias.alias.avatar.body.Skirt:setVisible(not isAlt and not Armor.isArmorVisible.leggings)
				for _, modelPart in ipairs({ModelAlias.alias.avatar.head.HairTails, ModelAlias.alias.avatar.body.NeckRibbon, ModelAlias.alias.avatar.rightLegBottom.RLBRibbon, ModelAlias.alias.avatar.leftLegBottom.LLBRibbon}) do
					modelPart:setVisible(not isAlt)
				end
				for _, modelPart in ipairs({ModelAlias.alias.avatar.head.TraineeHairTail, ModelAlias.alias.avatar.body.TraineeFrontHair, ModelAlias.alias.avatar.body.BTrinityLogo}) do
					modelPart:setVisible(isAlt)
				end
				ModelAlias.alias.avatar.head.Ears.RightEarPivot:setRot(isAlt and vectors.vec3() or vectors.vec3(-45, -10, 0))
			end;

			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
						ModelAlias.alias.avatar.head.Hat:setVisible(not isVisible and not Costume.isAltCostume)
						ModelAlias.alias.avatar.head.Ears.RightEarPivot:setRot((not isVisible and not Costume.isAltCostume) and vectors.vec3(-45, -10, 0) or vectors.vec3())
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible and not Costume.isAltCostume)
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
		includeModels = {};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function (_, isAlt)
				ModelAlias.alias.dummy_avatar.head.Ears.LeftEarPivot:setRot(-30, 0, 0)
				if isAlt then
					ModelAlias.alias.dummy_avatar.head.Ears.RightEarPivot:setRot(-30, 0, 0)
					ModelAlias.alias.dummy_avatar.head.TraineeHairTail:setRot(17.5, 0, 0)
				else
					ModelAlias.alias.dummy_avatar.body.Skirt:setRot(50, 0, 0)
					for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.head.HairTails.HairTailRight.HairRightBottom, ModelAlias.alias.dummy_avatar.head.HairTails.HairTailLeft.HairLeftBottom}) do
						modelPart:setRot(30, 0, 0)
					end
				end
			end;

			onPhase2 = function (_, isAlt)
				if isAlt then
					ModelAlias.alias.dummy_avatar.head.TraineeHairTail:setRot(-15, 0, 0)
				else
					ModelAlias.alias.dummy_avatar.body.Skirt:setRot(30, 0, 0)
					for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.head.HairTails.HairTailRight.HairRightBottom, ModelAlias.alias.dummy_avatar.head.HairTails.HairTailLeft.HairLeftBottom}) do
						modelPart:setRot(-20, 0, 0)
					end
				end
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
		{
				models = {ModelAlias.alias.avatar.body.NeckRibbon.NeckRibbonBottom},

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
				models =  {ModelAlias.alias.avatar.body.NeckRibbon.NeckRibbonBottom.NeckRibbonBottomZPivot},

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

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailLeft.HairLeftBottom};

				x = {
					vertical = {
						min = -165;
						neutral = 0;
						max = 10;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -82.5;
							max = 10;
						};

						headRot = {
							multiplayer = 0.05;
							min = -82.5;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -165;
							max = 7.5;
						};
					};

					horizontal = {
						min = -155;
						neutral = -45;
						max = -45;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailLeft.HairLeftBottom.HairLeftBottomZ};

				z = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 100;

						headZ = {
							multiplayer = -80;
							min = -80;
							max = 100;
						};
					};

					horizontal = {
						min = -80;
						neutral = 0;
						max = 100;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailRight.HairRightBottom};

				x = {
					vertical = {
						min = -165;
						neutral = 0;
						max = 10;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -82.5;
							max = 10;
						};

						headRot = {
							multiplayer = 0.05;
							min = -82.5;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -165;
							max = 7.5;
						};
					};

					horizontal = {
						min = -155;
						neutral = -45;
						max = -45;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailRight.HairRightBottom.HairRightBottomZ};

				z = {
					vertical = {
						min = -100;
						neutral = 0;
						max = 80;

						headZ = {
							multiplayer = -80;
							min = -100;
							max = 80;
						};
					};

					horizontal = {
						min = -100;
						neutral = -20;
						max = 80;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Hat.HatVeil};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 0;
						headRotMultiplayer = -1;
					};
				};

				z = {
					vertical = {
						min = -35;
						neutral = 0;
						max = 150;

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};

						headZ = {
							multiplayer = -80;
							min = -35;
							max = 90;
						};

						headRot = {
							multiplayer = -0.05;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = -35;
						neutral = 10;
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
				models = {ModelAlias.alias.avatar.body.TraineeFrontHair};

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
				models = {ModelAlias.alias.avatar.head.TraineeHairTail};

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
				models = {ModelAlias.alias.avatar.head.TraineeHairTail.TraineeHairTailZPivot};

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
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model == ModelAlias.alias.avatar.head.TraineeHairTail then
					model:setRot(math.min(model:getRot().x, 20), 0, 0)
				end
			end
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		for i = 1, 2 do
			ModelAlias.alias.avatar.head.Hat["Feather"..i]:setPrimaryTexture("RESOURCE", "minecraft:textures/item/feather.png")
			ModelAlias.alias.avatar.head.Hat["Feather"..i]:setColor(0.65, 0.65, 0.65)
		end
	end;
}

return BlueArchiveCharacter
