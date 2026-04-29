---@diagnostic disable: duplicate-doc-alias, duplicate-doc-field

---@alias BlueArchiveCharacter.GunPutType
---| "BODY" # アバターのBodyに銃を移動させる
---| "HIDDEN" # 銃を隠す

---@alias BlueArchiveCharacter.FormationType
---| "STRIKER" # ストライカー（前衛）
---| "SPECIAL" # スペシャル（後方支援）

--[[ ******************************** ]]

---右目のテクスチャの列挙型
---@alias BlueArchiveCharacter.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ABOVE" # 上を見る目
---| "CENTER" # 少し反対側を見る目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "ABOVE" # 上を見る目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "SMILE" # にっこり口
---| "O" # 丸めた口
---| "SURPRISED" # あんぐり口
---| "OPENED" # 開いた口

---キャラクター固有の腕の状態
---@alias BlueArchiveCharacter.AdditionalArmState
---| "NONE" # 固有の腕の状態なし（追加時にこれは削除する）

--[[ ******************************** ]]

---@class (exact) BlueArchiveCharacter.BasicStruct 生徒の基本情報のデータ構造体
---@field public avatarName string アバターのファイル名（例: "00a_base", "01a_shizuko", "01b_shizuko_swimsuit"）
---@field public birth BlueArchiveCharacter.MonthDaySet 生徒の誕生日

---@class (exact) BlueArchiveCharacter.FacePartsStruct 目や口による表情のデータ構造体。UVマッピング情報は、デフォルトパーツから見て左からx番目、上からy番目とする。
---@field public rightEye {[BlueArchiveCharacter.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[BlueArchiveCharacter.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[BlueArchiveCharacter.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きする
---@field public callbacks? BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック

---@class (exact) BlueArchiveCharacter.ArmsStruct 腕のデータ構造体
---@field public callbacks? BlueArchiveCharacter.ArmsCallbacksSet 腕の制御のコールバック関数群

---@class (exact) BlueArchiveCharacter.SkirtStruct スカートのデータ構造体
---@field public skirtModels? ModelPart[] スカートとして制御するモデル

---@class (exact) BlueArchiveCharacter.GunStruct 銃のデータ構造体
---@field public scale number 銃モデルの大きさの倍率
---@field public gunPosition BlueArchiveCharacter.GunPositionSet 銃モデルの位置や向き
---@field public sound BlueArchiveCharacter.GunSoundSet 銃の射撃音
---@field public callbacks? BlueArchiveCharacter.GunCallbacksSet 銃のコールバック関数

---@class (exact) BlueArchiveCharacter.PlacementObjectStruct 設置物のデータ構造体
---@field public model ModelPart 設置物として扱うモデル
---@field public boundingBox BlueArchiveCharacter.PlacementObjectBoundingBoxSet 設置物の当たり判定
---@field public placementMode PlacementObjectManager.PlacementMode 設置物の設置モード
---@field public gravity? number 設置物にかかる重力。1が標準的な自由落下。0で空中静止。負の数で反重力（上に向かって落ちる）。
---@field public hasFireResistance? boolean 設置物に火炎耐性を付与するかどうか。`true`にすると炎やマグマで焼かれなくなる。
---@field public callbacks? BlueArchiveCharacter.PlacementObjectCallbacksSet 設置物のコールバック関数

---@class (exact) BlueArchiveCharacter.ExSkillStruct Exスキルのデータ構造体
---@field public primary BlueArchiveCharacter.ExSkillDataSet メインのExスキルデータ
---@field public secondary? BlueArchiveCharacter.ExSkillDataSet サブのExスキルデータ
---@field public callbacks? BlueArchiveCharacter.ExSkillCallbacks Exスキルのコールバック関数

---@class (exact) BlueArchiveCharacter.CostumeStruct コスチュームのデータ構造体
---@field public isAltCostumeEnabled boolean バリエーション衣装が有効（ある）かどうか
---@field public callbacks? BlueArchiveCharacter.CostumeCallbacks コスチュームのコールバック関数

---@class (exact) BlueArchiveCharacter.BubbleStruct 吹き出しエモートのデータ構造体
---@field public callbacks? BlueArchiveCharacter.BubbleCallbacks 吹き出しエモートのコールバック関数

---@class (exact) BlueArchiveCharacter.HeadModelStruct 頭モデルのデータ構造体
---@field public callbacks? BlueArchiveCharacter.HeadModelCallbacks 頭モデルのコピー処理のコールバック関数

---@class (exact) BlueArchiveCharacter.HeadBlockStruct 頭ブロックのデータ構造体
---@field public includeModels ModelPart[] 頭ブロックに追加でアタッチするモデル

---@class (exact) BlueArchiveCharacter.portraitStruct ポートレートのデータ構造体
---@field public includeModels ModelPart[] ポートレートに追加でアタッチするモデル

---@class BlueArchiveCharacter.DeathAnimationStruct 死亡アニメーションのデータ構造体
---@field public callbacks? BlueArchiveCharacter.DeathAnimationCallbacks 死亡アニメーションのコールバック関数

---@class (exact) BlueArchiveCharacter.PhysicsStruct 物理演算のデータ構造体
---@field public physicData BlueArchiveCharacter.PhysicDataSet[] 物理演算データ
---@field public callbacks? BlueArchiveCharacter.PhysicCallbacks 物理演算のコールバック関数

--[[ ******************************** ]]

---@class (exact) BlueArchiveCharacter.OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? BlueArchiveCharacter.EmotionSet ダメージを受けたとき
---@field public onSleep? BlueArchiveCharacter.EmotionSet ベッドで寝ているとき

---@class (exact) BlueArchiveCharacter.EmotionSet 表情のデータセット
---@field public rightEye BlueArchiveCharacter.RightEyeTextures 右目の表情名
---@field public leftEye BlueArchiveCharacter.LeftEyeTextures 左目の表情名
---@field public mouth BlueArchiveCharacter.MouthTextures 口の表情名

---@class (exact) BlueArchiveCharacter.FacePartsCallbacksSet 表情のコールバック関数のセット
---@field public onPlay? fun(self: BlueArchiveCharacter, right: BlueArchiveCharacter.RightEyeTextures, left: BlueArchiveCharacter.LeftEyeTextures, mouth: BlueArchiveCharacter.MouthTextures) 表情が変化したときのコールバック関数

---@class (exact) BlueArchiveCharacter.ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(self: BlueArchiveCharacter, right: Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState, left: Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState): {right?: Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState, left?: Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(self: BlueArchiveCharacter, state: Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState): boolean? 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: BlueArchiveCharacter, state: Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState): boolean? 左腕の追加処理

---@class (exact) BlueArchiveCharacter.GunPositionSet 銃のモデルの位置や向きのデータセット
---@field public hold BlueArchiveCharacter.GunHoldPositionSet 銃を構えているとき
---@field public put BlueArchiveCharacter.GunPutPositionSet 銃をしまっているとき

---@class (exact) BlueArchiveCharacter.GunHoldPositionSet 構えているときの銃のモデルの位置や向きのデータセット
---@field public firstPersonPos? BlueArchiveCharacter.Vector3RightLeftSet 一人称視点での銃の位置
---@field public firstPersonRot? BlueArchiveCharacter.Vector3RightLeftSet 一人称視点での銃の方向
---@field public thirdPersonPos? BlueArchiveCharacter.Vector3RightLeftSet 三人称視点での銃の位置
---@field public thirdPersonRot? BlueArchiveCharacter.Vector3RightLeftSet 三人称視点での銃の方向

---@class (exact) BlueArchiveCharacter.GunPutPositionSet しまっているときの銃のモデルの位置や向きのデータセット
---@field public type BlueArchiveCharacter.GunPutType 銃のしまい方の種類
---@field public pos? BlueArchiveCharacter.Vector3RightLeftSet 一人称視点での銃の位置
---@field public rot? BlueArchiveCharacter.Vector3RightLeftSet 一人称視点での銃の方向

---@class (exact) BlueArchiveCharacter.GunSoundSet 銃の音のデータセット
---@field public name Minecraft.soundID 銃の音として使用するゲームの音源名
---@field public pitch number 音源の再生ピッチ（0.5～2）

---@class (exact) BlueArchiveCharacter.GunCallbacksSet 銃のコールバック関数のセット
---@field public onMainHandChange? fun(self: BlueArchiveCharacter, direction: Gun.HandDirection) 利き手が変更されたときに呼び出される関数

---@class (exact) BlueArchiveCharacter.PlacementObjectBoundingBoxSet 設置物の当たり判定のデータセット
---@field public offsetPos? Vector3 設置物の底の中心点のオフセット位置（任意）。基準点は(0, 0, 0)。
---@field public size? Vector3 当たり判定の大きさ。BlockBenchでのサイズの値をそのまま入力する。基準点はモデルの底面の中心。

---@class (exact) BlueArchiveCharacter.PlacementObjectCallbacksSet 設置物のコールバック関数のセット
---@field public onInit? fun(self: BlueArchiveCharacter, placementObject: PlacementObject) 設置物インスタンスが生成された直後に呼ばれる関数
---@field public onDeinit? fun(self: BlueArchiveCharacter, placementObject: PlacementObject) 設置物インスタンスが破棄される直前に呼ばれる関数
---@field public onTick? fun(self: BlueArchiveCharacter, placementObject: PlacementObject) 各ティック毎に呼ばれる関数
---@field public onRender? fun(self: BlueArchiveCharacter, placementObject: PlacementObject, delta: number) 各レンダーティック毎に呼ばれる関数
---@field public onGround? fun(self: BlueArchiveCharacter, placementObject: PlacementObject) 設置物が接地した瞬間に呼ばれる関数

---@class (exact) BlueArchiveCharacter.ExSkillCallbacks Exスキルのコールバック関数のセット
---@field public additionalCheckFunc? fun(self: BlueArchiveCharacter): boolean Exスキルを再生するかどうかの追加チェック関数

---@class (exact) BlueArchiveCharacter.ExSkillDataSet Exスキルのデータセット
---@field public formationType BlueArchiveCharacter.FormationType この生徒の戦闘配置タイプ
---@field public models ModelPart[] Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
---@field public animations string[] Exスキルアニメーションが含まれるモデルファイル名。アニメーション名は"ex_skill_<Exスキルのインデックス番号>"にすること。
---@field public camera BlueArchiveCharacter.ExSkillCameraSet Exスキルアニメーション中のカメラワーク
---@field public callbacks? BlueArchiveCharacter.ExSkillAnimationCallbacks Exスキルアニメーションのコールバック関数

---@class (exact) BlueArchiveCharacter.ExSkillCameraSet Exスキルアニメーション中のカメラワークのセット
---@field public start BlueArchiveCharacter.ExSkillCameraPositionSet Exスキルアニメーション開始地点
---@field public fin BlueArchiveCharacter.ExSkillCameraPositionSet Exスキルアニメーション終了地点
---@field public legacyMode? boolean 旧式のカメラ補正モード。一部のキャラクターに対してのみ`true`にする。

---@class (exact) BlueArchiveCharacter.ExSkillCameraPositionSet Exスキルアニメーション中のカメラワークの開始/終了地点の位置のデータセット
---@field public pos Vector3 カメラの位置
---@field public rot Vector3 カメラの方向

---@class (exact) BlueArchiveCharacter.ExSkillAnimationCallbacks Exスキルアニメーションのコールバック関数のセット
---@field public onPreTransition? fun(self: BlueArchiveCharacter) Exスキルアニメーション開始前のトランジション開始前に実行されるコールバック関数
---@field public onPreAnimation? fun(self: BlueArchiveCharacter) Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数
---@field public onAnimationTick? fun(self: BlueArchiveCharacter, tick: integer) Exスキルアニメーション再生中のみ実行されるティック関数
---@field public onPostAnimation? fun(self: BlueArchiveCharacter, forcedStop: boolean) Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数
---@field public onPostTransition? fun(self: BlueArchiveCharacter, forcedStop: boolean) Exスキルアニメーション終了後のトランジション終了後に実行されるコールバック関数

---@class (exact) BlueArchiveCharacter.CostumeCallbacks コスチュームのコールバック関数のセット
---@field public onAltChange? fun(self: BlueArchiveCharacter, isAlt: boolean) 衣装のバリエーションが変更されたときに実行されるコールバック関数
---@field public onArmorChange? fun(self: BlueArchiveCharacter, parts: Armor.ArmorPart, isVisible: boolean) 防具が変更された（防具が見える/見えない）ときに実行されるコールバック関数

---@class (exact) BlueArchiveCharacter.BubbleCallbacks 吹き出しエモートのコールバック関数のセット
---@field public additionalCheckFunc? fun(self: BlueArchiveCharacter): boolean 吹き出しエモートを表示するかどうかの追加チェック関数
---@field public onPlay? fun(self: BlueArchiveCharacter, type: Bubble.BubbleType, duration: integer, isShownInGui: boolean) 吹き出しエモートが再生された時に実行されるコールバック関数
---@field public onStop? fun(self: BlueArchiveCharacter, type: Bubble.BubbleType, forcedStop: boolean) 吹き出しアニメーション終了時に実行されるコールバック関数

---@class (exact) BlueArchiveCharacter.HeadModelCallbacks 頭モデルのコピー処理のコールバック関数のセット
---@field public onBeforeModelCopy? fun(self: BlueArchiveCharacter) モデルのコピー直前に実行される関数
---@field public onAfterModelCopy? fun(self: BlueArchiveCharacter) モデルのコピー直後に実行される関数

---@class (exact) BlueArchiveCharacter.DeathAnimationCallbacks 死亡アニメーションのコールバック関数のセット
---@field public onPhase1? fun(self: BlueArchiveCharacter, isAltCostume: boolean) 死亡アニメーションが再生された直後に実行される関数
---@field public onPhase2? fun(self: BlueArchiveCharacter, isAltCostume: boolean) ダミーアバターが縄ばしごにつかまった直後に実行される関数
---@field public onBeforeModelCopy? fun(self: BlueArchiveCharacter) モデルのコピー直前に実行される関数
---@field public onAfterModelCopy? fun(self: BlueArchiveCharacter) モデルのコピー直後に実行される関数

---@class BlueArchiveCharacter.ActionWheelConfigStruct アクションホイール上のアバター設定データの構造体
---@field public isVehicleReplacementEnabled boolean 乗り物のモデル置き換えオプションを有効にするかどうか

---@class (exact) BlueArchiveCharacter.PhysicDataSet 物理演算のデータセット
---@field public models ModelPart[] 物理演算の対象にするモデルパーツ
---@field public x? BlueArchiveCharacter.PhysicAxisData x軸のデータ
---@field public y? BlueArchiveCharacter.PhysicAxisData y軸のデータ
---@field public z? BlueArchiveCharacter.PhysicAxisData z軸のデータ

---@class (exact) BlueArchiveCharacter.PhysicAxisData 物理演算の1軸のデータセット
---@field public vertical? BlueArchiveCharacter.PhysicCoreData 体が垂直方向である時（通常時）の物理演算データ
---@field public horizontal? BlueArchiveCharacter.PhysicCoreData 体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ

---@class (exact) BlueArchiveCharacter.PhysicCoreData 物理演算のコアデータ
---@field public min number このモデルパーツ、回転軸の絶対的な回転の最小値（度）
---@field public neutral number このモデルパーツ、回転軸の中立の回転位置（度）
---@field public max number このモデルパーツ、回転軸の絶対的な回転の最大値（度）
---@field public sneakOffset? number スニーク時にこのモデルパーツの回転に加えられるオフセット値
---@field public headRotMultiplayer? number 頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率
---@field public headX? BlueArchiveCharacter.PhysicFactorData 頭を基準とした、前後方向移動によるモデルパーツの回転データ
---@field public headZ? BlueArchiveCharacter.PhysicFactorData 頭を基準とした、左右方向移動によるモデルパーツの回転データ
---@field public headRot? BlueArchiveCharacter.PhysicFactorData 頭の回転によるによるモデルパーツの回転データ
---@field public bodyX? BlueArchiveCharacter.PhysicFactorData 体を基準とした、前後方向移動によるモデルパーツの回転データ
---@field public bodyY? BlueArchiveCharacter.PhysicFactorData 体を基準とした、上下方向移動によるモデルパーツの回転データ
---@field public bodyZ? BlueArchiveCharacter.PhysicFactorData 体を基準とした、左右方向移動によるモデルパーツの回転データ
---@field public bodyRot? BlueArchiveCharacter.PhysicFactorData 体の回転によるによるモデルパーツの回転データ

---@class (exact) BlueArchiveCharacter.PhysicFactorData 物理演算を働かせる要因を定義するデータセット
---@field public multiplayer number この回転事象がモデルパーツに与える回転の倍率
---@field public min number この回転事象がモデルパーツに与える回転の最小値
---@field public max number この回転事象がモデルパーツに与える回転の最大値

---@class (exact) BlueArchiveCharacter.PhysicCallbacks 物理演算のコールバック関数のセット
---@field public onPhysicPerformed? fun(self: BlueArchiveCharacter, model: ModelPart) 物理演算処理後に実行されるコールバック関数（省略可）。ここでモデルパーツの向きを上書きできる。

--[[ ******************************** ]]

---@class (exact) BlueArchiveCharacter.MonthDaySet 日月のデータセット
---@field public month integer 月
---@field public day integer 日

---@class (exact) BlueArchiveCharacter.Vector3RightLeftSet 左右で別々にVector3が定義できるデータセット
---@field public right? Vector3 右
---@field public left? Vector3 左

--[[ ******************************** ]]

---@class (exact) BlueArchiveCharacter キャラクターシートクラス。別のキャラクターに対してもここを変更するだけで対応できるようにする。
---@field public basic BlueArchiveCharacter.BasicStruct 生徒の基本情報
---@field public faceParts BlueArchiveCharacter.FacePartsStruct 目や口による表情
---@field public arms BlueArchiveCharacter.ArmsStruct 腕
---@field public skirt BlueArchiveCharacter.SkirtStruct スカート
---@field public gun BlueArchiveCharacter.GunStruct 銃
---@field public placementObjects BlueArchiveCharacter.PlacementObjectStruct[] 設置物
---@field public exSkill BlueArchiveCharacter.ExSkillStruct Exスキル
---@field public costume BlueArchiveCharacter.CostumeStruct コスチューム
---@field public bubble BlueArchiveCharacter.BubbleStruct 吹き出しエモート
---@field public headModel BlueArchiveCharacter.HeadModelStruct コピーした頭モデル
---@field public headBlock BlueArchiveCharacter.HeadBlockStruct 頭ブロック
---@field public portrait BlueArchiveCharacter.portraitStruct ポートレート（Tabキーで表示できるプレイヤーリストに表示される顔）
---@field public deathAnimation BlueArchiveCharacter.DeathAnimationStruct 死亡アニメーション
---@field public actionWheelConfig BlueArchiveCharacter.ActionWheelConfigStruct アクションホイール上のアバター設定
---@field public physics BlueArchiveCharacter.PhysicsStruct 物理演算
local BlueArchiveCharacter = {
	basic = {
		avatarName = "21a_Hanae";

		birth = {
			month = 5;
			day = 12;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			ABOVE = vectors.vec2(6, 0);
			CENTER = vectors.vec2(8, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CENTER = vectors.vec2(4, 0);
			ABOVE = vectors.vec2(6, 0);
		};

		mouth = {
			SMILE = vectors.vec2(0, 0);
			O = vectors.vec2(1, 0);
			SURPRISED = vectors.vec2(2, 0);
			OPENED = vectors.vec2(3, 0);
		};
	};

	arms = {
		callbacks = {
			onAdditionalRightArmProcess = function (self, state)
				if state == "MEDICAL_BOX_HELD" then
					ModelAlias.alias.avatar.rightArm:setParentType("Body")
					events.TICK:remove("right_arm_tick")
					events.TICK:register(function ()
						if self.costume.medicalBoxPos == 0 then
							Arms:setArmState("DEFAULT", "DEFAULT")
						end
					end, "right_arm_tick")
					events.RENDER:remove("right_arm_render")
					events.RENDER:register(function (delta)
						local swingPos = (player:getSwingTime() + (player:isSwingingArm() and delta or 0)) / player:getSwingDuration()
						for _, modelPart in ipairs({ModelAlias.alias.avatar.rightArm, ModelAlias.alias.avatar.leftArm}) do
							modelPart:setRot(swingPos < 0.25 and (360 * swingPos + 40) or (-120 * swingPos + 160), 0, 0)
						end
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "MEDICAL_BOX_HELD" then
					ModelAlias.alias.avatar.leftArm:setParentType("Body")
				end
			end;
		};
	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 0, -8);
					left = vectors.vec3(0, 0, -8);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.5, -0.5, -6);
					left = vectors.vec3(1.5, -0.5, -6);
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
			formationType = "SPECIAL";

			models = {ModelAlias.alias.avatar.body.Rabbit};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 140, 0);
					pos = vectors.vec3(9, 25, -11);
				};

				fin = {
					rot = vectors.vec3(5, 190, 5);
					pos = vectors.vec3(-4, 22.5, -118.64);
				};
			};

			callbacks = {
				onPreAnimation = function ()
					local rabbitVariants = {"black", "brown", "gold", "salt", "white", "white_splotched"}
					local variantValue = math.random(#rabbitVariants)
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Rabbit.RHead.RabbitHead, ModelAlias.alias.avatar.body.Rabbit.RHead.RRightEar.RabbitRightEar, ModelAlias.alias.avatar.body.Rabbit.RHead.RLeftEar.RabbitLeftEar, ModelAlias.alias.avatar.body.Rabbit.RHead.RNose.RabbitNose, ModelAlias.alias.avatar.body.Rabbit.RBody.RabbitBody, ModelAlias.alias.avatar.body.Rabbit.RBody.RFrontRightLeg.RabbitFrontRightLeg, ModelAlias.alias.avatar.body.Rabbit.RBody.RFrontLeftLeg.RabbitFrontLeftLeg, ModelAlias.alias.avatar.body.Rabbit.RBody.RRearLeftLeg.RabbitLeftHaunch, ModelAlias.alias.avatar.body.Rabbit.RBody.RRearLeftLeg.RRearLeftLegBottom.RabbitRearLeftLeg, ModelAlias.alias.avatar.body.Rabbit.RBody.RRearRightLeg.RabbitRightHaunch, ModelAlias.alias.avatar.body.Rabbit.RBody.RRearRightLeg.RRearRightLegBottom.RabbitRearRightLeg, ModelAlias.alias.avatar.body.Rabbit.RBody.RTail.RabbitTail}) do
						modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/rabbit/" .. rabbitVariants[variantValue] .. ".png")
					end
					FaceParts:setEmotion("NORMAL", "CENTER", "SMILE", 14, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 13 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.Rabbit)
						local bodyYaw = player:getBodyYaw()
						local colorTable = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)}
						for _ = 1, 6 do
							particles:newParticle("minecraft:electric_spark", anchorPos):setScale(1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.2 - 0.1, math.random() * 0.2, 0, 0, 1, 0)):setColor(colorTable[math.random(#colorTable)]):setLifetime(9 + math.random() * 4)
						end
					elseif tick == 14 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 2, true)
						sounds:playSound("minecraft:entity.egg.throw", player:getPos(), 1, 2)
					elseif tick == 15 then
						ModelAlias.alias.avatar.body.Rabbit:moveTo(models.models.main)
					elseif tick == 16 then
						FaceParts:setEmotion("ABOVE", "ABOVE", "O", 13, true)
					elseif tick == 27 then
						sounds:playSound("minecraft:entity.rabbit.hurt", ModelUtils.getModelWorldPos(models.models.main.Rabbit), 1, 1)
					elseif tick == 29 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "O", 2, true)
					elseif tick == 31 then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SURPRISED", 16, true)
					elseif tick == 47 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 29, true)
					elseif tick == 50 then
						models.models.main.Rabbit:moveTo(ModelAlias.alias.avatar.body)
					elseif tick == 51 then
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground:setVisible(true)
							local windowSize = client:getWindowSize()
							local gameVersion = client:getVersion()
							local shouldAdjustBackgroundRot = StringUtils.compareVersions(gameVersion, "1.21.0") == gameVersion
							events.RENDER:register(function (delta, ctx, matrix)
								local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(2.15)), 0, 1, 0):scale(16 / 0.9375)
								models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
								models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
								models.models.ex_skill_1.CameraBackground.Background:setScale(48 * math.max(windowSize.x / windowSize.y, 1) * models.models.ex_skill_1.CameraBackground.BackgroundScale:getAnimScale().x)
								if shouldAdjustBackgroundRot then
									models.models.ex_skill_1.CameraBackground.Background:setRot(0, 0, renderer:getCameraRot().z)
								end
							end, "ex_skill_1_background")
						end
						local anchorPos = ModelUtils.getModelWorldPos(models.models.main.Avatar)
						sounds:playSound("minecraft:entity.item.pickup", anchorPos, 1, 1.75)
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 1.5)
					elseif tick == 52 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = player:getPos():copy():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 1.5, 4, 0, 1, 0))
						for i = 1, 18 do
							particles:newParticle("minecraft:firework", anchorPos):setScale(1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 20, 0, 0.15 + math.random() * 0.1, 0, 0, 0, 1), 0, 1, 0))
						end
					end
				end;

				onPostAnimation = function (_, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_background")
						models.models.ex_skill_1.CameraBackground:setVisible(false)
					end
					if forcedStop and models.models.main.Rabbit ~= nil then
						models.models.main.Rabbit:moveTo(ModelAlias.alias.avatar.body)
					end
				end
			};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.NurseCap:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Chest, ModelAlias.alias.avatar.body.RabbitPouch}) do
						modelPart:setVisible(not isVisible)
					end
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.leftLeg.LegSyringe:setVisible(not isVisible)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("CLOSED", "NORMAL", "OPENED", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "O", duration, true)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("SURPRISED", "SURPRISED", "SURPRISED", duration, true)
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
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(20, 0, 20)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(20, 0, -20)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(40, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(-20, 0, 10)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(-20, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot()
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.HairTails.LeftHairTail};
				x = {
					vertical = {
						min = -180;
						neutral = -5;
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
							min = -170;
							max = -7.5;
						};
					};

					horizontal = {
						min = -170;
						neutral = 45;
						max = 70;

						headX = {
							multiplayer = -160;
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
						min = -70;
						neutral = -5;
						max = 70;

						headZ = {
							multiplayer = 80;
							min = -10;
							max = -2.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail};

				x = {
					vertical = {
						min = -180;
						neutral = -5;
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
							min = -170;
							max = -7.5;
						};
					};

					horizontal = {
						min = -170;
						neutral = 45;
						max = 70;

						headX = {
							multiplayer = -160;
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
						min = -70;
						neutral = 5;
						max = 70;

						headZ = {
							multiplayer = 80;
							min = 10;
							max = 2.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Chest};

				x = {
					vertical = {
						min = 40;
						neutral = 45;
						max = 50;

						bodyY = {
							multiplayer = -10;
							min = 40;
							max = 50;
						};
					};

					horizontal = {
						min = 40;
						neutral = 45;
						max = 50;

						bodyX = {
							multiplayer = -10;
							min = 40;
							max = 50;
						};
					}
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function (self)
		events.TICK:register(function ()
			if Gun.currentGunPosition == "NONE" and ExSkill.animationCount == -1 then
				local healingPotionPos = 0
				for i = 1, 2 do
					local heldItem = player:getHeldItem(i == 2)
					local gameVersion = client:getVersion()
					local isNewerNbt = StringUtils.compareVersions(gameVersion, "1.20.5") == gameVersion
					if (heldItem.id == "minecraft:potion" or heldItem.id == "minecraft:splash_potion" or heldItem.id == "minecraft:lingering_potion") and ((isNewerNbt and heldItem.tag["minecraft:potion_contents"].potion ~= nil and heldItem.tag["minecraft:potion_contents"].potion:match("minecraft:.*regeneration") ~= nil) or (not isNewerNbt and heldItem.tag.Potion ~= nil and heldItem.tag.Potion:match("minecraft:.*regeneration") ~= nil)) then
						healingPotionPos = i
						break
					end
				end
				self.costume.medicalBoxPos = healingPotionPos
			else
				self.costume.medicalBoxPos = 0
			end
			if self.costume.medicalBoxPos > 0 and Arms.armState.right ~= "MEDICAL_BOX_HELD" then
				Arms:setArmState("MEDICAL_BOX_HELD", "MEDICAL_BOX_HELD")
			end
		end)

		events.ITEM_RENDER:register(function (_, mode)
			local isLeftHanded = player:isLeftHanded()
			if (isLeftHanded and self.costume.medicalBoxPos == 2) or (not isLeftHanded and self.costume.medicalBoxPos == 1) then
				--右手に救急箱を持つ
				if mode == "THIRD_PERSON_RIGHT_HAND" then
					models.models.medical_box.MedicalBox:setPos(-5.5, -4, 0)
					models.models.medical_box.MedicalBox:setRot(45, 0, 0)
					models.models.medical_box.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.medical_box.MedicalBox
				elseif mode == "FIRST_PERSON_RIGHT_HAND" then
					models.models.medical_box.MedicalBox:setPos(-9, -3, 0)
					models.models.medical_box.MedicalBox:setRot(0, 0, 0)
					models.models.medical_box.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.medical_box.MedicalBox
				end
			elseif (isLeftHanded and self.costume.medicalBoxPos == 1) or (not isLeftHanded and self.costume.medicalBoxPos == 2) then
				--左手に救急箱を持つ
				if mode == "THIRD_PERSON_LEFT_HAND" then
					models.models.medical_box.MedicalBox:setPos(5.5, -4, 0)
					models.models.medical_box.MedicalBox:setRot(45, 0, 0)
					models.models.medical_box.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.medical_box.MedicalBox
				elseif mode == "FIRST_PERSON_LEFT_HAND" then
					models.models.medical_box.MedicalBox:setPos(9, -3, 0)
					models.models.medical_box.MedicalBox:setRot(0, 0, 0)
					models.models.medical_box.MedicalBox:setScale(0.8, 0.8, 0.8)
					return models.models.medical_box.MedicalBox
				end
			end
		end)
	end;
}

return BlueArchiveCharacter
