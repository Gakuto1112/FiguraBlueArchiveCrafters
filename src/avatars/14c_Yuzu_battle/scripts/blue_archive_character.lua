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
---| "ANGRY" # 怒った目
---| "FEAR" # 恐怖を感じているときの目
---| "CIRCLE" # 丸目
---| "UNEQUAL" # 不等号目
---| "NARROW" # 半目
---| "CLOSED2" # 閉じた目2
---| "NARROW_CENTER" # 中央を見る半目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
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
---@alias BlueArchiveCharacter.MouthTextures
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
	---@param self BlueArchiveCharacter
	init = function (self)
		---Exスキル1で使用するアイテムオブジェクトインスタンスのクラス
		---@type ExSkill1ItemObject
		ExSkill1ItemObject = require("scripts.ex_skill_1_item_object")

		---Exスキル1で使用するアイテムオブジェクトマネージャーのクラス
		---@type ExSkill1ItemObjectManager
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
