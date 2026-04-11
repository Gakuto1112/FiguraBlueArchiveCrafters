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
---| "NARROW1" # 狭めの目1
---| "NARROW2" # 狭めの目2
---| "CLOSED2" # 横線目
---| "INVERTED" # 反対側を見る目
---| "TEAR" # 横線目+涙
---| "UNEQUAL" # ><

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
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
---@alias BlueArchiveCharacter.MouthTextures
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

			models = {ModelAlias.alias.avatar.rightArmBottom.DrinkBottle1, ModelAlias.alias.avatar.body.DrinkBottle2, ModelAlias.alias.avatar.body.DrinkBottle3, models.models.ex_skill_primary.Mobs};

			animations = {"main", "ex_skill_primary"};

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
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob1.Mob1Head.Mob1HeadColor, models.models.ex_skill_primary.Mobs.Mob1.Mob1Head.Mob1HeadLayerColor}) do
							modelPart:setColor(0.318, 0.235, 0.282)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob1.Mob1UpperBody.Mob1Body.Mob1BodyColor, models.models.ex_skill_primary.Mobs.Mob1.Mob1UpperBody.Mob1Body.Mob1BodyLayerColor, models.models.ex_skill_primary.Mobs.Mob1.Mob1UpperBody.Mob1Arms.Mob1RightArm.Mob1RightArmColor, models.models.ex_skill_primary.Mobs.Mob1.Mob1UpperBody.Mob1Arms.Mob1RightArm.Mob1RightArmLayerColor, models.models.ex_skill_primary.Mobs.Mob1.Mob1UpperBody.Mob1Arms.Mob1LeftArm.Mob1LeftArmColor, models.models.ex_skill_primary.Mobs.Mob1.Mob1UpperBody.Mob1Arms.Mob1LeftArm.Mob1LeftArmLayerColor, models.models.ex_skill_primary.Mobs.Mob1.Mob1LowerBody.Mob1Legs.Mob1RightLeg.Mob1RightLegColor, models.models.ex_skill_primary.Mobs.Mob1.Mob1LowerBody.Mob1Legs.Mob1RightLeg.Mob1RightLegLayerColor, models.models.ex_skill_primary.Mobs.Mob1.Mob1LowerBody.Mob1Legs.Mob1LeftLeg.Mob1LeftLegColor, models.models.ex_skill_primary.Mobs.Mob1.Mob1LowerBody.Mob1Legs.Mob1LeftLeg.Mob1LeftLegLayerColor}) do
							modelPart:setColor(0.788, 0.263, 0.275)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob1.Mob1Head.Mob1HeadRing, models.models.ex_skill_primary.Mobs.Mob2.Mob2Head.Mob2HeadRing, models.models.ex_skill_primary.Mobs.Mob3.Mob3Head.Mob3HeadRing}) do
							modelPart:setColor(0.996, 0.824, 0.843)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob2.Mob2Head.Mob2HeadColor, models.models.ex_skill_primary.Mobs.Mob2.Mob2Head.Mob2HeadLayerColor, models.models.ex_skill_primary.Mobs.Mob2.Mob2Head.Mob2HairTail}) do
							modelPart:setColor(0.502, 0.369, 0.408)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob2.Mob2UpperBody.Mob2Body.Mob2BodyColor, models.models.ex_skill_primary.Mobs.Mob2.Mob2UpperBody.Mob2Body.Mob2BodyLayerColor, models.models.ex_skill_primary.Mobs.Mob2.Mob2UpperBody.Mob2Arms.Mob2RightArm.Mob2RightArmColor, models.models.ex_skill_primary.Mobs.Mob2.Mob2UpperBody.Mob2Arms.Mob2RightArm.Mob2RightArmLayerColor, models.models.ex_skill_primary.Mobs.Mob2.Mob2UpperBody.Mob2Arms.Mob2LeftArm.Mob2LeftArmColor, models.models.ex_skill_primary.Mobs.Mob2.Mob2UpperBody.Mob2Arms.Mob2LeftArm.Mob2LeftArmLayerColor, models.models.ex_skill_primary.Mobs.Mob2.Mob2LowerBody.Mob2Legs.Mob2RightLeg.Mob2RightLegColor, models.models.ex_skill_primary.Mobs.Mob2.Mob2LowerBody.Mob2Legs.Mob2RightLeg.Mob2RightLegLayerColor, models.models.ex_skill_primary.Mobs.Mob2.Mob2LowerBody.Mob2Legs.Mob2LeftLeg.Mob2LeftLegColor, models.models.ex_skill_primary.Mobs.Mob2.Mob2LowerBody.Mob2Legs.Mob2LeftLeg.Mob2LeftLegLayerColor}) do
							modelPart:setColor(0.596, 0.6, 0.757)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob3.Mob3Head.Mob3HeadColor, models.models.ex_skill_primary.Mobs.Mob3.Mob3Head.Mob3HeadLayerColor, models.models.ex_skill_primary.Mobs.Mob3.Mob3Head.Mob3Bun}) do
							modelPart:setColor(0.275, 0.212, 0.227)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob3.Mob3UpperBody.Mob3Body.Mob3BodyColor, models.models.ex_skill_primary.Mobs.Mob3.Mob3UpperBody.Mob3Body.Mob3BodyLayerColor, models.models.ex_skill_primary.Mobs.Mob3.Mob3UpperBody.Mob3Arms.Mob3RightArm.Mob3RightArmColor, models.models.ex_skill_primary.Mobs.Mob3.Mob3UpperBody.Mob3Arms.Mob3RightArm.Mob3RightArmLayerColor, models.models.ex_skill_primary.Mobs.Mob3.Mob3UpperBody.Mob3Arms.Mob3LeftArm.Mob3LeftArmColor, models.models.ex_skill_primary.Mobs.Mob3.Mob3UpperBody.Mob3Arms.Mob3LeftArm.Mob3LeftArmLayerColor, models.models.ex_skill_primary.Mobs.Mob3.Mob3LowerBody.Mob3Legs.Mob3RightLeg.Mob3RightLegColor, models.models.ex_skill_primary.Mobs.Mob3.Mob3LowerBody.Mob3Legs.Mob3RightLeg.Mob3RightLegLayerColor, models.models.ex_skill_primary.Mobs.Mob3.Mob3LowerBody.Mob3Legs.Mob3LeftLeg.Mob3LeftLegColor, models.models.ex_skill_primary.Mobs.Mob3.Mob3LowerBody.Mob3Legs.Mob3LeftLeg.Mob3LeftLegLayerColor}) do
							modelPart:setColor(0.231, 0.298, 0.22)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob4.Mob4Head.Mob4HeadColor, models.models.ex_skill_primary.Mobs.Mob4.Mob4Head.Mob4HeadLayerColor, models.models.ex_skill_primary.Mobs.Mob4.Mob4Head.Mob4Bun}) do
							modelPart:setColor(0.345, 0.251, 0.251)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob4.Mob4UpperBody.Mob4Body.Mob4BodyColor, models.models.ex_skill_primary.Mobs.Mob4.Mob4UpperBody.Mob4Body.Mob4BodyLayerColor, models.models.ex_skill_primary.Mobs.Mob4.Mob4UpperBody.Mob4Arms.Mob4RightArm.Mob4RightArmColor, models.models.ex_skill_primary.Mobs.Mob4.Mob4UpperBody.Mob4Arms.Mob4RightArm.Mob4RightArmLayerColor, models.models.ex_skill_primary.Mobs.Mob4.Mob4UpperBody.Mob4Arms.Mob4LeftArm.Mob4LeftArmColor, models.models.ex_skill_primary.Mobs.Mob4.Mob4UpperBody.Mob4Arms.Mob4LeftArm.Mob4LeftArmLayerColor, models.models.ex_skill_primary.Mobs.Mob4.Mob4LowerBody.Mob4Legs.Mob4RightLeg.Mob4RightLegColor, models.models.ex_skill_primary.Mobs.Mob4.Mob4LowerBody.Mob4Legs.Mob4RightLeg.Mob4RightLegLayerColor, models.models.ex_skill_primary.Mobs.Mob4.Mob4LowerBody.Mob4Legs.Mob4LeftLeg.Mob4LeftLegColor, models.models.ex_skill_primary.Mobs.Mob4.Mob4LowerBody.Mob4Legs.Mob4LeftLeg.Mob4LeftLegLayerColor}) do
							modelPart:setColor(0.49, 0.42, 0.522)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob4.Mob4Head.Mob4HeadRing, models.models.ex_skill_primary.Mobs.Mob5.Mob5Head.Mob5HeadRing, models.models.ex_skill_primary.Mobs.Mob6.Mob6Head.Mob6HeadRing}) do
							modelPart:setColor(1, 0.98, 0.804)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob5.Mob5Head.Mob5HeadColor, models.models.ex_skill_primary.Mobs.Mob5.Mob5Head.Mob5HeadLayerColor}) do
							modelPart:setColor(0.349, 0.286, 0.365)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob5.Mob5UpperBody.Mob5Body.Mob5BodyColor, models.models.ex_skill_primary.Mobs.Mob5.Mob5UpperBody.Mob5Body.Mob5BodyLayerColor, models.models.ex_skill_primary.Mobs.Mob5.Mob5UpperBody.Mob5Arms.Mob5RightArm.Mob5RightArmColor, models.models.ex_skill_primary.Mobs.Mob5.Mob5UpperBody.Mob5Arms.Mob5RightArm.Mob5RightArmLayerColor, models.models.ex_skill_primary.Mobs.Mob5.Mob5UpperBody.Mob5Arms.Mob5LeftArm.Mob5LeftArmColor, models.models.ex_skill_primary.Mobs.Mob5.Mob5UpperBody.Mob5Arms.Mob5LeftArm.Mob5LeftArmLayerColor, models.models.ex_skill_primary.Mobs.Mob5.Mob5LowerBody.Mob5Legs.Mob5RightLeg.Mob5RightLegColor, models.models.ex_skill_primary.Mobs.Mob5.Mob5LowerBody.Mob5Legs.Mob5RightLeg.Mob5RightLegLayerColor, models.models.ex_skill_primary.Mobs.Mob5.Mob5LowerBody.Mob5Legs.Mob5LeftLeg.Mob5LeftLegColor, models.models.ex_skill_primary.Mobs.Mob5.Mob5LowerBody.Mob5Legs.Mob5LeftLeg.Mob5LeftLegLayerColor}) do
							modelPart:setColor(0.294, 0.337, 0.49)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob6.Mob6Head.Mob6HeadColor, models.models.ex_skill_primary.Mobs.Mob6.Mob6Head.Mob6HeadLayerColor, models.models.ex_skill_primary.Mobs.Mob6.Mob6Head.Mob6HairTail}) do
							modelPart:setColor(0.506, 0.369, 0.322)
						end
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob6.Mob6UpperBody.Mob6Body.Mob6BodyColor, models.models.ex_skill_primary.Mobs.Mob6.Mob6UpperBody.Mob6Body.Mob6BodyLayerColor, models.models.ex_skill_primary.Mobs.Mob6.Mob6UpperBody.Mob6Arms.Mob6RightArm.Mob6RightArmColor, models.models.ex_skill_primary.Mobs.Mob6.Mob6UpperBody.Mob6Arms.Mob6RightArm.Mob6RightArmLayerColor, models.models.ex_skill_primary.Mobs.Mob6.Mob6UpperBody.Mob6Arms.Mob6LeftArm.Mob6LeftArmColor, models.models.ex_skill_primary.Mobs.Mob6.Mob6UpperBody.Mob6Arms.Mob6LeftArm.Mob6LeftArmLayerColor, models.models.ex_skill_primary.Mobs.Mob6.Mob6LowerBody.Mob6Legs.Mob6RightLeg.Mob6RightLegColor, models.models.ex_skill_primary.Mobs.Mob6.Mob6LowerBody.Mob6Legs.Mob6RightLeg.Mob6RightLegLayerColor, models.models.ex_skill_primary.Mobs.Mob6.Mob6LowerBody.Mob6Legs.Mob6LeftLeg.Mob6LeftLegColor, models.models.ex_skill_primary.Mobs.Mob6.Mob6LowerBody.Mob6Legs.Mob6LeftLeg.Mob6LeftLegLayerColor}) do
							modelPart:setColor(0.58, 0.231, 0.29)
						end

						ModelAlias.alias.avatar.head.FaceShadow:setOpacity(0.5)

						self.exSkill.primary.stairs:setPos(6, 0, 6)
						self.exSkill.primary.stairs:setRot(0, 180, 0)
						self.exSkill.primary.stairs:setBlock("minecraft:oak_stairs")
						self.exSkill.primary.stairs:setVisible(false)
						if host:isHost() then
							models.models.ex_skill_primary.Gui.AnxiousFrame:setColor(0.282, 0.29, 0.725)
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
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob1, models.models.ex_skill_primary.Mobs.Mob4}) do
							modelPart:setVisible(false)
						end
					elseif tick == 42 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "OPENED", 5, true)
					elseif tick == 45 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 3, true)
						sounds:playSound("minecraft:entity.wither.spawn", player:getPos(), 0.15, 2)
						if host:isHost() then
							local windowSize = client:getScaledWindowSize()
							models.models.ex_skill_primary.Gui.AnxiousFrame:setScale(windowSize.x, windowSize.y, 1)
							models.models.ex_skill_primary.Gui.AnxiousFrame:setVisible(true)
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
						models.models.ex_skill_primary.Gui.AnxiousFrame:setVisible(false)
					elseif tick == 81 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 4, true)
					elseif tick == 85 then
						FaceParts:setEmotion("TEAR", "TEAR", "TRIANGLE2", 15, true)
					elseif tick == 100 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.DrinkBottle2, ModelAlias.alias.avatar.body.DrinkBottle3, models.models.ex_skill_primary.Mobs}) do
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
							models.models.ex_skill_primary.Gui.AnxiousFrame:setOpacity(math.map(tick, 45, 56, 0, 1))
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
						for _, modelPart in ipairs({models.models.ex_skill_primary.Mobs.Mob1, models.models.ex_skill_primary.Mobs.Mob4}) do
							modelPart:setVisible(true)
						end
					end
					if forcedStop then
						ModelAlias.alias.avatar.root:setColor()
						if host:isHost() then
							models.models.ex_skill_primary.Gui.AnxiousFrame:setVisible(false)
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
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(-5, 0, -17.5)
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
