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

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "TRIANGLE" # 三角形の口
---| "SMILE" # にっこり
---| "WORRY" # 困った口

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
---@field public onAdditionalRightArmProcess? fun(self: BlueArchiveCharacter, state: Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState): boolean 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: BlueArchiveCharacter, state: Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState): boolean 左腕の追加処理

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
								ExSkillSplashParticleManager:spawn(pos, pos:copy():sub(center):scale(0.1))
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
						ExSkillSplashParticleManager:removeAll()
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
		---@see ExSkillSplashParticle
		ExSkillSplashParticle = require("scripts.ex_skill_splash_particle")

		---Exスキルでで使用するスプラッシュパーティクルを管理するクラス
		---@see ExSkillSplashParticleManager
		ExSkillSplashParticleManager = require("scripts.ex_skill_splash_particle_manager")
		ExSkillSplashParticleManager = ExSkillSplashParticleManager:new()

		ExSkillSplashParticleManager.init()
	end;
}

return BlueArchiveCharacter
