---右目のテクスチャの列挙型
---@alias Character09b.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "INVERTED" # 反対側を見る目
---| "NARROW" # 少し閉じた目

---左目のテクスチャの列挙型
---@alias Character09b.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "INVERTED" # 反対側を見る目
---| "NARROW" # 少し閉じた目
---| "CENTER" # 少し反対側を見る目

---口のテクスチャの列挙型
---@alias Character09b.MouthTextures
---| "NORMAL" # 通常
---| "SMILE" # にっこり
---| "OPENED_SMALL" # 小さく開いた口
---| "OPENED" # 開いた口
---| "SAD" # への口
---| "TIRED" # 疲れた口

---キャラクター固有の腕の状態
---@alias Character09b.AdditionalArmState
---| "MEDICAL_BOX_HELD" # 救急箱を持つ手

---@class (exact) Character09b.EmotionSet : BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye Character09b.RightEyeTextures 右目の表情名
---@field public leftEye Character09b.LeftEyeTextures 左目の表情名
---@field public mouth Character09b.MouthTextures 口の表情名

---@class (exact) Character09b.OverrideEmotionSet : BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? Character09b.EmotionSet ダメージを受けたとき
---@field public onSleep? Character09b.EmotionSet ベッドで寝ているとき

---@class (exact) Character09b.FacePartsCallbacksSet : BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: Character09b, right: Character09b.RightEyeTextures, left: Character09b.LeftEyeTextures, mouth: Character09b.MouthTextures) 表情が変化したときのコールバック

---@class (exact) Character09b.FacePartsStruct : BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体
---@field public rightEye {[Character09b.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[Character09b.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[Character09b.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? Character09b.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? Character09b.FacePartsCallbacksSet 表情のコールバック

---@class (exact) Character09b.ArmsCallbacksSet : BlueArchiveCharacter.ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(self: Character09b, right: Arms.BaseArmState|Character09b.AdditionalArmState, left: Arms.BaseArmState|Character09b.AdditionalArmState): {right?: Arms.BaseArmState|Character09b.AdditionalArmState, left?: Arms.BaseArmState|Character09b.AdditionalArmState}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(self: Character09b, state: Arms.BaseArmState|Character09b.AdditionalArmState): boolean? 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: Character09b, state: Arms.BaseArmState|Character09b.AdditionalArmState): boolean? 左腕の追加処理

---@class (exact) Character09b.ArmsStruct : BlueArchiveCharacter.ArmsStruct 腕のデータ構造体
---@field public callbacks? Character09b.ArmsCallbacksSet 腕の制御のコールバック関数群

---@class (exact) Character09b : BlueArchiveCharacter キャラクターシート
---@field public faceParts Character09b.FacePartsStruct 目や口による表情
---@field public arms Character09b.ArmsStruct 腕

---@type Character09b
local BlueArchiveCharacter = {
	basic = {
		avatarName = "09b_Serina_Christmas";

		birth = {
			month = 1;
			day = 6;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(5, 0);
			INVERTED = vectors.vec2(6, 0);
			NARROW = vectors.vec2(8, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CLOSED2 = vectors.vec2(4, 0);
			INVERTED = vectors.vec2(6, 0);
			NARROW = vectors.vec2(8, 0);
			CENTER = vectors.vec2(9, 0);
		};

		mouth = {
			SMILE = vectors.vec2(0, 0);
			TIRED = vectors.vec2(1, 0);
			OPENED_SMALL = vectors.vec2(2, 0);
			OPENED = vectors.vec2(3, 0);
			SAD = vectors.vec2(4, 0);
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
					right = vectors.vec3(0, 1, -4);
					left = vectors.vec3(0, 1, -4);
				};

				thirdPersonPos = {
					right = vectors.vec3(-2, 1, -5);
					left = vectors.vec3(2, 1, -5);
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

			models = {ModelAlias.alias.avatar.leftArmBottom.Handbell.Camera, models.models.ex_skill_1.MusicStand, models.models.ex_skill_1.Bag, models.models.ex_skill_1.Presents, models.models.ex_skill_1.StuffedWolf, models.models.ex_skill_1.GroundEffect, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(70, 60, 0);
					pos = vectors.vec3(12, 64.5, 5);
				};

				fin = {
					rot = vectors.vec3(-5, 270, 0);
					pos = vectors.vec3(-53.2, 17, -5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.MusicStand.MusicStandBookHolder:newText("music_stand_book_holder"):setText("§8Cherry Berry Merry"):setPos(3, 2.5, -1):setScale(0.03, 0.03, 0.03):setWrap(true):setWidth(120):setAlignment("CENTER")
						self.exSkill.primary.isInitialized = true
					end
					events.RENDER:register(function ()
						for _, modelPart in ipairs({models.models.ex_skill_1.GroundEffect, ModelAlias.alias.avatar.leftArmBottom.Handbell.Camera.HandbellEffect1, ModelAlias.alias.avatar.leftArmBottom.Handbell.Camera.HandbellEffect2}) do
							local opacity = modelPart[modelPart:getName().."Opacity"]:getAnimScale().x
							modelPart:setOpacity(opacity)
							modelPart:setColor(vectors.vec3(1, 1, 1):scale(opacity))
						end
						if host:isHost() then
							models.models.ex_skill_1.Gui.Frame:setOpacity(models.models.ex_skill_1.Gui.FrameOpacity:getAnimScale().x)
						end
					end, "ex_skill_1_render")
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setPos()
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setRot()
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setParentType("None")
					self.exSkill.primary.noteParticleSpawnCount = math.random(2, 3)
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 17, true)
					pings.selectChristmasSong(math.random(1, #self.costume.songs))
					self.costume.bellStage = 1
				end;

				onAnimationTick = function (self, tick)
					if tick == 3 then
						self.exSkill.primary.spawnHandbellParticles(self)
						sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 1, 1.887749)
					elseif tick == 6 then
						sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 0.25, 1.887749)
					elseif tick == 13 then
						self.exSkill.primary.spawnHandbellParticles(self)
					elseif tick == 17 then
						FaceParts:setEmotion("NORMAL", "INVERTED", "SMILE", 7, true)
					elseif tick == 24 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 12, true)
					elseif tick == 36 then
						FaceParts:setEmotion("NORMAL", "CENTER", "OPENED_SMALL", 5, true)
					elseif tick == 41 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 4, true)
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head):add(0, 0.25, 0)
						local bodyYaw = player:getBodyYaw()
						for i = 0, 7 do
							particles:newParticle("minecraft:end_rod", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.cos(i / 4 * math.pi) * 0.075, math.sin(i / 4 * math.pi) * 0.075, 0, 0, 1, 0)):setScale(2):setColor(1, 0.443, 0.631):setLifetime(20)
						end
						if host:isHost() then
							local windowSize = client:getScaledWindowSize()
							models.models.ex_skill_1.Gui.Frame:setScale(windowSize.x, windowSize.y, 1)
						end
						sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 1, 1.887749)
						sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 0.5, 0.943874)
					elseif tick == 44 then
						sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 0.75, 1.887749)
						sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 0.375, 0.943874)
					elseif tick == 45 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 14, true)
					elseif tick == 50 then
						models.models.ex_skill_1.GroundEffect:setVisible(false)
						sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 0.5, 1.887749)
					elseif tick == 59 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 6, true)
					elseif tick == 65 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 5, true)
					elseif tick == 70 then
						FaceParts:setEmotion("NARROW", "NARROW", "SMILE", 44, true)
					elseif tick == 71 then
						self.exSkill.primary.spawnHandbellParticles(self)
						sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 1, 1.887749)
					elseif tick == 74 then
						sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 0.25, 1.887749)
					end

					local melodyParticlePos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.ExSkill2ParticleAnchor1)
					local melodyParticleDir = ModelUtils.getModelWorldPos(models.models.ex_skill_1.ExSkill2ParticleAnchor1.ExSkill2ParticleAnchor2):sub(melodyParticlePos):normalize():scale(0.1)
					if tick >= 1 then
						for i = 1, 8 do
							local offsetPos = melodyParticlePos:copy():sub(self.exSkill.primary.melodyParticlePosPrev):scale(0.125 * i)
							local offsetDir = melodyParticleDir:copy():sub(self.exSkill.primary.melodyParticleDirPrev):scale(0.125 * i)
							for j = 1, 5 do
								particles:newParticle("minecraft:firework", self.exSkill.primary.melodyParticlePosPrev:copy():add(offsetPos):add(self.exSkill.primary.melodyParticleDirPrev:copy():add(offsetDir):normalize():scale(0.1 * j))):setScale(0.1):setColor(1, 0.902, 0.576):setGravity(0)
							end
						end
					end
					if self.exSkill.primary.noteParticleSpawnCount == 0 then
						local offsetPos = math.random(0, 10) * 0.5
						ExSkill1MelodyParticleManager:spawn(melodyParticlePos:copy():add(melodyParticleDir:copy():scale(offsetPos + (offsetPos >= 2.5 and 0 or 2))), models.models.ex_skill_1.ExSkill2ParticleAnchor1:getAnimRot():mul(-1, 1, -1), vectors.vec2(0.8, 0.8), vectors.vec3(), 60, false)
						if offsetPos >= 2.5 then
							ExSkill1MelodyParticleManager.objects[#ExSkill1MelodyParticleManager.objects].subObject:setScale(1, -1, 1)
						end
						self.exSkill.primary.noteParticleSpawnCount = math.random(2, 3)
					else
						self.exSkill.primary.noteParticleSpawnCount = self.exSkill.primary.noteParticleSpawnCount - 1
					end
					self.exSkill.primary.melodyParticlePosPrev = melodyParticlePos:copy()
					self.exSkill.primary.melodyParticleDirPrev = melodyParticleDir:copy()
				end;

				onPostAnimation = function ()
					events.RENDER:remove("ex_skill_1_render")
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setParentType("Item")
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---前ティックの楽譜のパーティクルのアンカー位置
			---@type Vector3
			melodyParticlePosPrev = vectors.vec3();

			---前ティックの楽譜のパーティクルのアンカー方向
			---@type Vector3
			melodyParticleDirPrev = vectors.vec3();

			---楽譜の音符パーティクルをスポーンさせるまでのカウンター
			---@type integer
			noteParticleSpawnCount = 0;

			---ハンドベルの音符パーティクルを表示する。
			spawnHandbellParticles = function ()
				local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.Handbell.Camera.HandbellEffect1)
				for _ = 1, 5 do
					ExSkill1MelodyParticleManager:spawn(anchorPos, vectors.vec3(), vectors.vec2(0.25, 0.25), vectors.vec3(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1):normalize():scale(0.02), 20, true)
				end
			end;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.head.Hat, ModelAlias.alias.avatar.head.Bun}) do
						modelPart:setVisible(not isVisible)
					end
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
				end
			end;
		};

		---ハンドベルで演奏する曲データ
		---音階をintegerで表す。
		---@type integer[][]
		songs = {
			-- 1. ジングルベル（Jingle Bells） - https://youtu.be/iyj1SJ5QhjE?si=WEVd-lbmTmJrSlFV
			{
				name = "Jingle Bells";
				song = {6, 6, 15, 13, 11, 6, 6, 6, 15, 13, 11, 8, 8, 8, 16, 15, 13, 10, 18, 20, 18, 16, 13, 15, 6, 6, 15, 13, 11, 6, 6, 6, 15, 13, 11, 8, 8, 8, 16, 15, 13, 18, 18, 18, 18, 20, 18, 16, 13, 11, 15, 15, 15, 15, 15, 15, 15, 15, 18, 11, 13, 15, 16, 16, 16, 16, 16, 15, 15, 15, 15, 13, 13, 11, 13, 18, 15, 15, 15, 15, 15, 15, 15, 18, 11, 13, 15, 16, 16, 16, 16, 16, 15, 15, 15, 18, 18, 16, 13, 11};
			};

			-- 2. We Wish You A Merry Christmas - https://youtu.be/qzLf6vkgCYA?si=FnAuabFiLweN5mgf
			{
				name = "We Wish You A Merry Christmas";
				song = {8, 13, 13, 15, 13, 12, 10, 10, 10, 15, 15, 17, 15, 13, 12, 8, 8, 17, 17, 18, 17, 15, 13, 10, 8, 8, 10, 15, 12, 13, 8, 13, 13, 13, 12, 12, 13, 12, 10, 8, 15, 17, 15, 13, 20, 8, 8, 8, 10, 15, 12, 13};
			};

			-- 3. サンタが街にやってくる（Santa Claus is coming to town）- https://youtu.be/fm-YVXMjZw4?si=GIh685jacZ1e8A5V
			{
				name = "Santa Claus is coming to town";
				song = {13, 10, 11, 13, 13, 13, 15, 17, 18, 18, 10, 11, 13, 13, 13, 15, 13, 11, 11, 10, 13, 6, 10, 8, 11, 5, 6, 13, 10, 11, 13, 13, 13, 15, 17, 18, 18, 10, 11, 13, 13, 13, 15, 13, 11, 11, 10, 13, 6, 10, 8, 11, 5, 6, 18, 20, 18, 17, 18, 15, 15, 18, 20, 18, 17, 18, 15, 20, 22, 20, 19, 20, 17, 17, 17, 17, 18, 20, 18, 17, 15, 13, 13, 13, 10, 11, 13, 13, 13, 15, 17, 18, 18, 10, 11, 13, 13, 13, 15, 13, 11, 11, 10, 13, 6, 10, 8, 11, 20, 18, 30};
			};

			-- 4. きよしこの夜（Silent Night） - https://youtu.be/IgTv3Osi_oU?si=XdnJgwDeH2jeXDl0
			{
				name = "Silent Night";
				song = {13, 15, 13, 10, 13, 15, 13, 10, 20, 20, 17, 18, 18, 13, 15, 15, 18, 17, 15, 13, 15, 13, 10, 15, 15, 18, 17, 15, 13, 15, 13, 10, 20, 20, 23, 20, 17, 18, 22, 18, 13, 10, 13, 11, 8, 6};
			};

			-- 5. もろびとこぞりて（Joy to the World!） - https://youtu.be/Zk9AB0RfubI?si=Q_O7tJA_-fpgZ73b
			{
				name = "Joy to the World!";
				song = {20, 19, 17, 15, 13, 12, 10, 8, 15, 17, 17, 19, 19, 20, 20, 20, 19, 17, 15, 15, 13, 12, 20, 20, 19, 17, 15, 15, 13, 12, 12, 12, 12, 12, 12, 13, 15, 13, 12, 10, 10, 10, 10, 12, 13, 12, 10, 8, 20, 17, 15, 13, 12, 13, 12, 10, 8};
			};

			-- 6. あわてんぼうのサンタクロース（Hasty Santa Claus） - https://youtu.be/QZ-HOovEBCE?si=HFyMtQa_NfQkOukg
			{
				name = "Hasty Santa Claus";
				song = {6, 11, 15, 13, 11, 11, 13, 11, 11, 11, 8, 6, 6, 6, 11, 11, 11, 15, 18, 15, 13, 13, 15, 11, 13, 6, 11, 15, 15, 15, 13, 11, 11, 11, 16, 16, 16, 18, 20, 20, 20, 18, 18, 15, 18, 16, 16, 15, 13, 11, 20, 20, 18, 15, 18, 16, 15, 13, 11};
			};

			-- 7. 赤鼻のトナカイ（Rudolph the red-nosed reindeer）- https://youtu.be/eSzpx4hdq_Q?si=j5CXe-Hs2zaP4WVY
			{
				name = "Rudolph the red-nosed reindeer";
				song = {13, 15, 13, 10, 18, 15, 13, 13, 15, 13, 15, 13, 18, 17, 11, 13, 11, 8, 17, 15, 13, 13, 15, 13, 15, 13, 15, 10, 13, 15, 13, 10, 18, 15, 13, 13, 15, 13, 15, 13, 18, 17, 11, 13, 11, 8, 17, 15, 13, 13, 15, 13, 15, 13, 20, 18, 15, 15, 18, 15, 13, 10, 13, 11, 15, 13, 11, 10, 8, 10, 13, 15, 17, 17, 17, 18, 18, 17, 15, 13, 11, 8, 13, 15, 13, 10, 18, 15, 13, 13, 15, 13, 15, 13, 18, 17, 11, 13, 11, 8, 17, 15, 13, 13, 15, 13, 15, 13, 20, 18};
			};
		};

		---ハンドベルで演奏する曲のインデックス番号
		---0では固定音を出す。
		---@type integer
		songIndex = 0;

		---曲の進行度合い
		---@type integer
		bellStage = 1;
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED_SMALL", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TIRED", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SAD", duration, true)
					end
				end
			end;

			onStop = function (_, _, forcedStop)
				if not forcedStop then
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
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.head.Feather:setRot(55, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.rightArmBottom:setPivot(2, 6, -2)
				ModelAlias.alias.dummy_avatar.head.Feather:setRot(-20, 0, 0)
			end;

			onBeforeModelCopy = function ()
				ModelAlias.alias.avatar.leftArmBottom.Handbell:setVisible(false)
			end;

			onAfterModelCopy = function ()
				ModelAlias.alias.avatar.leftArmBottom.Handbell:setVisible(true)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.Feather};

				x = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -120;
							min = -90;
							max = 90;
						};
					};

					horizontal = {
						min = -45;
						neutral = 45;
						max = 45;

						headX = {
							multiplayer = -120;
							min = -45;
							max = 45;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Feather.FeatherZPivot};

				z = {
					vertical = {
						min = -160;
						neutral = 0;
						max = 75;

						headZ = {
							multiplayer = -120;
							min = -80;
							max = 75;
						};

						headRot = {
							multiplayer = 0.075;
							min = -80;
							max = 75;
						};

						bodyY = {
							multiplayer = 120;
							min = -160;
							max = 0;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function (self)
		---Exスキル1で使用する音符パーティクルのインスタンスクラス
		---@type Character09b.ExSkill1MelodyParticle
		ExSkill1MelodyParticle = require("scripts.ex_skill_1_melody_particle")

		---Exスキル1で使用する音符パーティクルのマネージャークラス
		---@type Character09b.ExSkill1MelodyParticleManager
		ExSkill1MelodyParticleManager = require("scripts.ex_skill_1_melody_particle_manager")
		ExSkill1MelodyParticleManager = ExSkill1MelodyParticleManager.new()

		ExSkill1MelodyParticleManager.init()

		for _, modelPart in ipairs({ModelAlias.alias.avatar.leftArmBottom.Handbell.Handbell1_Top, ModelAlias.alias.avatar.leftArmBottom.Handbell.Handbell2_Top}) do
			modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/block/bell_top.png")
		end
		for _, modelPart in ipairs({ModelAlias.alias.avatar.leftArmBottom.Handbell.Handbell1_Side, ModelAlias.alias.avatar.leftArmBottom.Handbell.Handbell2_Side}) do
			modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/block/bell_side.png")
		end
		ModelAlias.alias.avatar.leftArmBottom.Handbell.Handbell2_Bottom:setPrimaryTexture("RESOURCE", "minecraft:textures/block/bell_bottom.png")

		events.TICK:register(function ()
			local isHoldingBell = player:getHeldItem().id == "minecraft:bell"
			local targetBlock = player:getTargetedBlock(true, 4.5)
			if player:isSwingingArm() and isHoldingBell and player:getSwingTime() == 0 and (targetBlock.id == "minecraft:air" or targetBlock.id == "minecraft:cave_air" or targetBlock.id == "minecraft:void_air") then
				local scale = self.costume.songIndex >= 1 and self.costume.songs[self.costume.songIndex].song[self.costume.bellStage] or 23
				sounds:playSound("minecraft:block.note_block.chime", player:getPos(), 1, 2 ^ ((scale - 12) / 12))
				if self.costume.songIndex >= 1 then
					if self.costume.bellStage == #self.costume.songs[self.costume.songIndex].song then
						self.costume.bellStage = 1
					else
						self.costume.bellStage = self.costume.bellStage + 1
					end
				else
					self.costume.bellStage = 1
				end

			elseif not isHoldingBell then
				self.costume.bellStage = 1
				Config.syncConfigs["bellStage"] = 1
			end
		end)

		events.ITEM_RENDER:register(function (item, mode)
			if item.id == "minecraft:bell" then
				if mode == "FIRST_PERSON_LEFT_HAND" then
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setPos(4, -13.5, 0.5)
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setRot(-90, -30, 180)
				elseif mode == "FIRST_PERSON_RIGHT_HAND" then
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setPos(7, -13.5, 0.5)
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setRot(-90, 30, 180)
				elseif mode == "THIRD_PERSON_LEFT_HAND" then
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setPos(5.5, -13.5, 0.5)
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setRot(-90, 0, 180)
				elseif mode == "THIRD_PERSON_RIGHT_HAND" then
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setPos(5.5, -13.5, 0.5)
					ModelAlias.alias.avatar.leftArmBottom.Handbell:setRot(-90, 0, 180)
				end
				return ModelAlias.alias.avatar.leftArmBottom.Handbell
			end
		end)

		EventManager.events["ON_CONFIG_SYNC"]:register(function (configData)
			self.costume.songIndex = configData["songIndex"] or 0
			self.costume.bellStage = configData["bellStage"] or 1
		end)
	end;
}

---Exスキル1後のハンドベルで演奏できるクリスマスソングを決める。
---@param index integer 曲のインデックス番号
function pings.selectChristmasSong(index)
    BlueArchiveCharacter.costume.songIndex = index
    local task = models.models.ex_skill_1.MusicStand.MusicStandBookHolder:getTask("music_stand_book_holder")
    if task ~= nil then
        task:setText("§8"..BlueArchiveCharacter.costume.songs[index].name)
    end
    if host:isHost() then
		Config.syncConfigs["songIndex"] = index
    end
end

return BlueArchiveCharacter
