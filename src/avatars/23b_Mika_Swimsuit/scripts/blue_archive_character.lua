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
---| "CLOSED2" # 閉じた目2
---| "NARROW2" # 細目2
---| "NARROW" # 細目
---| "NARROW_CENTER" # 少し反対側を見る細目
---| "UNEQUAL" # 不等号目
---| "FRUST" # 不満そうな目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "NARROW2" # 細目2
---| "NARROW" # 細目
---| "NARROW_CENTER" # 少し反対側を見る細目
---| "UNEQUAL" # 不等号目
---| "FRUST" # 不満そうな目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "OPENED_SMALL" # 小さく開いた口
---| "SMILE" # にっこり
---| "TEETH" # 歯を見せてにっこり
---| "OPENED" # 開いた口
---| "OPENED2" # 開いた口2
---| "OPENED3" # 開いた口3
---| "FRUST" # への口

---キャラクター固有の腕の状態
---@alias BlueArchiveCharacter.AdditionalArmState
---| "NONE" # 固有の腕の状態なし（追加時にこれは削除する）

--[[ ******************************** ]]

---@class (exact) BlueArchiveCharacter.BasicStruct 生徒の基本情報のデータ構造体
---@field public avatarName string アバターのファイル名（例: "00a_Base", "01a_shizuko", "01b_shizuko_swimsuit"）
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
		avatarName = "23b_Mika_Swimsuit";

		birth = {
			month = 5;
			day = 8;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(5, 0);
			NARROW2 = vectors.vec2(6, 0);
			NARROW = vectors.vec2(8, 0);
			NARROW_CENTER = vectors.vec2(11, 0);
			UNEQUAL = vectors.vec2(12, 0);
			FRUST = vectors.vec2(13, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CLOSED2 = vectors.vec2(4, 0);
			NARROW2 = vectors.vec2(6, 0);
			NARROW = vectors.vec2(8, 0);
			NARROW_CENTER = vectors.vec2(9, 0);
			UNEQUAL = vectors.vec2(11, 0);
			FRUST = vectors.vec2(13, 0);
		};

		mouth = {
			OPENED_SMALL = vectors.vec2(0, 0);
			SMILE = vectors.vec2(1, 0);
			TEETH = vectors.vec2(2, 0);
			OPENED = vectors.vec2(3, 0);
			OPENED2 = vectors.vec2(4, 0);
			OPENED3 = vectors.vec2(5, 0);
			FRUST = vectors.vec2(6, 0);
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
					right = vectors.vec3(0, 2, -6);
					left = vectors.vec3(0, 2, -6);
				};

				thirdPersonPos = {
					right = vectors.vec3(-2, 0.5, -8);
					left = vectors.vec3(2, 0.5, -8);
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

			models = {models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-10, 90, 0);
					pos = vectors.vec3(16, 20.9, -8);
				};

				fin = {
					rot = vectors.vec3(-5, 90, 0);
					pos = vectors.vec3(-175, 23.4, -20);
				};
			};

			callbacks = {
				onPreAnimation = function ()
					events.TICK:remove("shooting_star_tick")

					if host:isHost() then
						models.models.ex_skill_1.Gui.ScreenFilter:setScale(client:getScaledWindowSize():copy():augmented(1))
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.ScreenFilter:setOpacity(models.models.ex_skill_1.Gui.FilterOpacity:getAnimScale().x)
						end, "ex_skill_1_render")
					end

					FaceParts:setEmotion("NARROW", "NARROW_CENTER", "TEETH", 31, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 31 then
						FaceParts:setEmotion("NARROW", "NARROW_CENTER", "OPENED", 14, true)
					elseif tick == 42 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.ExSkill1ParticleAnchor1)
						local bodyYaw = player:getBodyYaw()
						for i = 0, 35 do
							particles:newParticle("minecraft:end_rod", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + 80, vectors.rotateAroundAxis(i * 10, 0, 0.2, 0, 0, 0, 1), 0, 1, 0)):setColor(0.991, 0.783, 0.999):setLifetime(5)
						end
						for _ = 1, 20 do
							particles:newParticle("minecraft:firework", anchorPos):setScale(0.1):setVelocity(math.random() * 0.1 - 0.05, math.random() * 0.1 - 0.05, math.random() * 0.1 - 0.05):setColor(0.991, 0.783, 0.999):setGravity(0)
						end
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 3)
					elseif tick == 45 then
						FaceParts:setEmotion("NARROW", "NARROW_CENTER", "SMILE", 16, true)
					elseif tick == 61 then
						FaceParts:setEmotion("NARROW_CENTER", "NARROW", "SMILE", 6, true)
					elseif tick == 67 then
						FaceParts:setEmotion("NARROW", "NARROW", "SMILE", 16, true)
					elseif tick == 83 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED2", 67, true)
					elseif tick == 150 then
						FaceParts:setEmotion("NARROW", "NARROW_CENTER", "OPENED3", 21, true)
					elseif tick == 171 then
						FaceParts:setEmotion("CLOSED", "NARROW_CENTER", "TEETH", 62, true)

						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
							:copy()
							:add(vectors.rotateAroundAxis(bodyYaw * -1 + 90, 0, 0, -1, 0, 1, 0))
							:add(0, 1, 0)
						for i = 0, 35 do
							particles:newParticle("minecraft:firework", anchorPos)
								:setScale(0.5)
								:setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + 90, vectors.rotateAroundAxis(i * 10, 0, 0.1 + math.random() * 0.15, 0, 0, 0, 1), 0, 1, 0))
								:setColor(0.991, 0.783, 0.999)
								:setGravity(0)
								:setLifetime(57 + math.random(0, 5))
						end

						sounds:playSound("minecraft:entity.experience_orb.pickup", anchorPos, 1, 2)
					end

					if tick >= 42 and tick < 55 then
						local anchorPos = player:getPos()
						local bodyYaw = player:getBodyYaw()
						for i = 0, 1 do
							for j = 0, 1 do
								local tickCount = tick - 42
								particles:newParticle("minecraft:end_rod", vectors.rotateAroundAxis(bodyYaw * -1 + 50 - ((tickCount * 2 + j) * 10) , 0, 1.2 + (i == 0 and (tickCount * 0.04) or (tickCount * 0.15)), 0.8, 0, 1, 0):add(anchorPos)):setScale(0.5):setColor(0.991, 0.783, 0.999):setLifetime(8)
							end
						end
					end

					if tick % 4 == 0 then
						local bodyYaw = player:getBodyYaw()
						ExSkillShootingStarManager:spawn(vectors.rotateAroundAxis(bodyYaw * -1 - 90, vectors.rotateAroundAxis(-45, math.random() * 1024 - 512, 256, 256, 1, 0, 0), 0, 1, 0):add(player:getPos()), vectors.rotateAroundAxis(bodyYaw * -1 - 90, vectors.rotateAroundAxis(-45, -0.5, -1, 0, 1, 0, 0), 0, 1, 0))
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
					end

					if not forcedStop then
						self.costume.showerShootingStars(self, -90)
					end
				end;
			};
		};

		secondary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 150, 0);
					pos = vectors.vec3(10.4, 22.5, -36);
				};

				fin = {
					rot = vectors.vec3(-40, -20, 0);
					pos = vectors.vec3(11.4, 26.5, -17);
				};
			};

			callbacks = {
				onPreAnimation = function ()
					events.TICK:remove("shooting_star_tick")

					if host:isHost() then
						models.models.ex_skill_1.Gui.ScreenFilter:setScale(client:getScaledWindowSize():copy():augmented(1))
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.ScreenFilter:setOpacity(models.models.ex_skill_1.Gui.FilterOpacity:getAnimScale().x)
						end, "ex_skill_2_render")
					end

					FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 50, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 50 then
						FaceParts:setEmotion("NARROW", "NARROW", "SMILE", 33, true)

						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
							:copy()
							:add(vectors.rotateAroundAxis(bodyYaw * -1 + 30, 0, 0, -1, 0, 1, 0))
							:add(0, 1, 0)
						for i = 0, 35 do
							particles:newParticle("minecraft:firework", anchorPos)
								:setScale(0.5)
								:setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + 30, vectors.rotateAroundAxis(i * 10, 0, 0.1 + math.random() * 0.15, 0, 0, 0, 1), 0, 1, 0))
								:setColor(0.991, 0.783, 0.999)
								:setGravity(0)
								:setLifetime(40 + math.random(-3, 3))
						end

						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 3)
					elseif tick == 83 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 9, true)
					elseif tick == 92 then
						FaceParts:setEmotion("NARROW_CENTER", "NARROW", "OPENED_SMALL", 11, true)
					elseif tick == 103 then
						FaceParts:setEmotion("NARROW_CENTER", "NARROW", "SMILE", 4, true)
					elseif tick == 107 then
						FaceParts:setEmotion("NARROW_CENTER", "NARROW", "OPENED", 79, true)
					end

					if tick % 4 == 0 then
						local bodyYaw = player:getBodyYaw()
						ExSkillShootingStarManager:spawn(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(-45, math.random() * 1024 - 512, 256, 256, 1, 0, 0), 0, 1, 0):add(player:getPos()), vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(-45, -0.5, -1, 0, 1, 0, 0), 0, 1, 0))
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_2_render")
					end

					if not forcedStop then
						self.costume.showerShootingStars(self, 0)
					end
				end;
			};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Chest:setVisible(not isVisible)
					ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, isVisible and -1 or 0)
				end
			end;
		};

		---ヘイローのキラキラエフェクトのクラスを格納する配列
		---@type HaloShine[]
		haloShines = {};

		---流れ星の基準ワールド座標
		---@type Vector3
		shootingStarBasePos = vectors.vec3();

		---流れ星の発生させる基準の向き
		---@type number
		shootingStarBaseDir = 0;

		---流れ星の残り時間
		---@type integer
		shootingStarLifetimeCount = 0;

		---流れ星を30秒間降らせる。
		---@param self BlueArchiveCharacter
		---@param yaw number 流れ星を降らせる方向（ヨー）
		showerShootingStars = function (self, yaw)
			self.costume.shootingStarBasePos = player:getPos()
			self.costume.shootingStarBaseDir = player:getBodyYaw() % 360
			self.costume.shootingStarLifetimeCount = 600

			events.TICK:register(function ()
				if not client:isPaused() then
					if self.costume.shootingStarLifetimeCount % 4 == 0 then
						ExSkillShootingStarManager:spawn(vectors.rotateAroundAxis(self.costume.shootingStarBaseDir * -1 + yaw, vectors.rotateAroundAxis(-45, math.random() * 1024 - 512, 256, 256, 1, 0, 0), 0, 1, 0):add(player:getPos()), vectors.rotateAroundAxis(self.costume.shootingStarBaseDir * -1 + yaw, vectors.rotateAroundAxis(-45, -0.5, -1, 0, 1, 0, 0), 0, 1, 0))
					end

					if self.costume.shootingStarLifetimeCount == 0 then
						events.TICK:remove("shooting_star_tick")
					end
					self.costume.shootingStarLifetimeCount = self.costume.shootingStarLifetimeCount - 1
				end
			end, "shooting_star_tick")
		end;
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("NARROW", "NARROW", "OPENED3", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED2", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED_SMALL", duration, true)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("FRUST", "FRUST", "FRUST", duration, true)
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
		callbacks = {
			onBeforeModelCopy = function ()
				ModelAlias.alias.avatar.body.Hairs.BackHair:setRot()
			end;

			onAfterModelCopy = function (self)
				if models.script_head_block and not self.headBlock.isHeadBlockInitialized then

					HaloShine = require("scripts.halo_shine")

					for i = 1, 4 do
						models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable["HaloShine" .. i]["HaloShine" .. i .. "Inner"]:setParentType("Camera")
					end
					table.insert(self.headBlock.headBlockHaloShines, HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine1, vectors.vec2(2, 0)))
					table.insert(self.headBlock.headBlockHaloShines, HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine2, vectors.vec2(1, 0)))
					table.insert(self.headBlock.headBlockHaloShines, HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine3, vectors.vec2(2, 0)))
					table.insert(self.headBlock.headBlockHaloShines, HaloShine.new(models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable.HaloShine4, vectors.vec2(3, 0)))

					for _, shine in ipairs(self.headBlock.headBlockHaloShines) do
						shine.callbacks.onInit(shine)
					end

					events.WORLD_TICK:register(function ()
						if not client:isPaused() then
							self.headBlock.headBlockHaloRot = self.headBlock.headBlockHaloRot + 0.15

							for _, shine in ipairs(self.headBlock.headBlockHaloShines) do
								shine.callbacks.onTick(shine)
							end
						end
					end)

					events.WORLD_RENDER:register(function (delta)
						if not client:isPaused() then
							models.script_head_block.Skull.Halo.HaloCenter.HaloRotatable:setRot(0, self.headBlock.headBlockHaloRot + 0.15 * delta, 0)

							for _, shine in ipairs(self.headBlock.headBlockHaloShines) do
								shine.callbacks.onRender(shine, delta)
							end
						end
					end)

					self.headBlock.isHeadBlockInitialized = true
				end
			end;
		};
	};

	headBlock = {
		includeModels = {ModelAlias.alias.avatar.body.Hairs};

		---頭ブロックが初期化されたかどうか
		---@type boolean
		isHeadBlockInitialized = false;

		---頭ブロックのヘイローのキラキラエフェクトのクラスを格納する配列
		---@type HaloShine[]
		headBlockHaloShines = {};

		---頭ブロックのヘイローの回転角度
		---@type number
		headBlockHaloRot = 0;
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(5, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Wings.RightWing:setRot(0, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Wings.LeftWing:setRot(0, 0, 10)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-15, 0, -15)
				ModelAlias.alias.dummy_avatar.body.Wings.RightWing:setRot(0, 0, -50)
				ModelAlias.alias.dummy_avatar.body.Wings.LeftWing:setRot(0, 0, 35)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair},

				x = {
					vertical = {
						min = -150;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
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
						neutral = -10;
						max = -10;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Hairs.FrontHair};

				x = {
					vertical = {
						min = 5;
						neutral = 5;
						max = 150;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 5;
							max = 90;
						};

						bodyY = {
							multiplayer = -80;
							min = 5;
							max = 150;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 5;
							max = 90;
						};
					};

					horizontal = {
						min = 5;
						neutral = 90;
						max = 150;

						bodyX = {
							multiplayer = -80;
							min = 5;
							max = 150;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Wings.RightWing.RightWing2},

				z = {
					vertical = {
						min = -70;
						neutral = -65;
						max = -55;

						bodyY = {
							multiplayer = -20;
							min = -70;
							max = -55;
						};
					};

					horizontal = {
						min = -65;
						neutral = -65;
						max = -65;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Wings.LeftWing.LeftWing2},

				z = {
					vertical = {
						min = 55;
						neutral = 65;
						max = 70;

						bodyY = {
							multiplayer = 20;
							min = 55;
							max = 70;
						};
					};

					horizontal = {
						min = 65;
						neutral = 65;
						max = 65;
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	---@param self BlueArchiveCharacter
	init = function (self)
		---ヘイローのキラキラエフェクトオブジェクトのクラス
		---@type HaloShine
		HaloShine = require("scripts.halo_shine")

		---水濡れを制御するクラス
		---@type Wet
		Wet = require("scripts.wet")
		Wet:init()

		---Exスキルで使用する流れ星パーティクルのインスタンスクラス
		---@type ExSkillShootingStar
		ExSkillShootingStar = require("scripts.ex_skill_shooting_star")

		---Exスキルで使用する流れ星パーティクルのマネージャークラス
		---@type ExSkillShootingStarManager
		ExSkillShootingStarManager = require("scripts.ex_skill_shooting_star_manager")
		ExSkillShootingStarManager = ExSkillShootingStarManager.new()

		table.insert(self.costume.haloShines, HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine1, vectors.vec2(2, 0)))
		table.insert(self.costume.haloShines, HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine2, vectors.vec2(1, 0)))
		table.insert(self.costume.haloShines, HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine3, vectors.vec2(2, 0)))
		table.insert(self.costume.haloShines, HaloShine.new(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable.HaloShine4, vectors.vec2(3, 0)))

		for _, shine in ipairs(self.costume.haloShines) do
			shine.callbacks.onInit(shine)
		end

		events.TICK:register(function ()
			if not client:isPaused() then
				for _, shine in ipairs(self.costume.haloShines) do
					shine.callbacks.onTick(shine)
				end
			end
		end)

		events.RENDER:register(function (delta, context)
			if not client:isPaused() then
				for _, shine in ipairs(self.costume.haloShines) do
					shine.callbacks.onRender(shine, delta, context)
				end

				local wingRotOffset = math.map(vanilla_model.RIGHT_LEG:getOriginRot().x, -90, 90, 20, 0)
				ModelAlias.alias.avatar.body.Wings.RightWing:setRot(0, wingRotOffset * -1, 0)
				ModelAlias.alias.avatar.body.Wings.LeftWing:setRot(0, wingRotOffset, 0)
			end
		end)
	end;
}

return BlueArchiveCharacter
