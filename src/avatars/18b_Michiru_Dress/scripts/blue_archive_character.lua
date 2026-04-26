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
---| "LOWER" # 下を見る目
---| "CLOSED2" # 閉じた目2
---| "SCHEME" # 何かを企んでいる目
---| "TEAR_ANGRY" # 怒りつつ涙ぐんでいる目
---| "ANGRY" # 起った目
---| "UNEQUAL" # 不等号目
---| "TEAR" # 涙ぐんでいる目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "LOWER" # 下を見る目
---| "CLOSED2" # 閉じた目2
---| "SCHEME" # 何かを企んでいる目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "ANGRY" # 起った目
---| "CENTER" # 少し反対側を見る目
---| "UNEQUAL" # 不等号目
---| "TEAR" # 涙ぐんでいる目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "FRUST_OPENED" # ぐじゅぐじゅの開き口
---| "FRUST" # ぐじゅぐじゅ口
---| "SMALL" # 小さく開いた口
---| "OVER_SMILE" # 悪意を感じるにっこり
---| "UNCOMFORT" # 不満な口
---| "SHOCK" # あんぐり口
---| "OPENED2" # 開いた口2
---| "UNCOMFORT2" # への口
---| "SMILE" # にっこり口
---| "TEAR" # 涙ぐんでいる目

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
		avatarName = "18b_Michiru_Dress";

		birth = {
			month = 2;
			day = 22;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			LOWER = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(7, 0);
			SCHEME = vectors.vec2(8, 0);
			TEAR_ANGRY = vectors.vec2(9, 0);
			ANGRY = vectors.vec2(11, 0);
			UNEQUAL = vectors.vec2(14, 0);
			TEAR = vectors.vec2(15, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			LOWER = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(6, 0);
			SCHEME = vectors.vec2(7, 0);
			ANGRY_INVERTED = vectors.vec2(9, 0);
			ANGRY = vectors.vec2(11, 0);
			CENTER = vectors.vec2(12, 0);
			UNEQUAL = vectors.vec2(13, 0);
			TEAR = vectors.vec2(15, 0);
		};

		mouth = {
			OPENED = vectors.vec2(0, 0);
			FRUST_OPENED = vectors.vec2(1, 0);
			FRUST = vectors.vec2(2, 0);
			SMALL = vectors.vec2(3, 0);
			OVER_SMILE = vectors.vec2(4, 0);
			UNCOMFORT = vectors.vec2(5, 0);
			SHOCK = vectors.vec2(6, 0);
			OPENED2 = vectors.vec2(7, 0);
			UNCOMFORT2 = vectors.vec2(8, 0);
			SMILE = vectors.vec2(9, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 1.75;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(1, 2, -8);
					left = vectors.vec3(-1, 2, -8);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.5, 1.5, -6);
					left = vectors.vec3(1.5, 1.5, -6);
				};
			};

			put = {
				type = "HIDDEN";
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

			models = {models.models.ex_skill_1.Smokes, models.models.ex_skill_1.StandCamera, ModelAlias.alias.avatar.head.HeadShine, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 160, 0);
					pos = vectors.vec3(3.5, 23, -11.75);
				};

				fin = {
					rot = vectors.vec3(0, 190, 0);
					pos = vectors.vec3(-0.75, 21, -50.75);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						for i = 1, 4 do
							models.models.ex_skill_1.Smokes["Smoke" .. i]["Smoke" .. i .. "Top"]:newText("smoke_" .. i .. "_text"):setText("§5忍"):setPos(0, -0.09, 0.5):setRot(90, 0, 0):setScale(0.15):setAlignment("CENTER")
						end
						if host:isHost() then
							models.models.ex_skill_1.Gui.CameraGui:setScale(4, 4, 1)
							local windowSize = client:getScaledWindowSize()
							models.models.ex_skill_1.Gui.CameraGui:newText("ex_skill_1_camera_gui_rec"):setBackground(true):setBackgroundColor(0, 0, 0, 1)
							models.models.ex_skill_1.Gui.CameraGui:newText("ex_skill_1_camera_gui_resolution"):setScale(0.25):setAlignment("LEFT")
							models.models.ex_skill_1.Gui.CameraGui:newText("ex_skill_1_camera_gui_fps"):setScale(0.25):setAlignment("RIGHT")
						end
						self.exSkill.primary.isInitialized = true
					end
					if host:isHost() then
						local windowSize = client:getScaledWindowSize()
						local outerYOffset = 4
						local outerXOffset = outerYOffset * (windowSize.x / windowSize.y)
						models.models.ex_skill_1.Gui.CameraGui.OuterTL:setPos(-outerXOffset, -outerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.OuterTR:setPos(windowSize.x / 4 * -1 + outerXOffset, -outerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.OuterBL:setPos(-outerXOffset, windowSize.y / 4 * -1 + outerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.OuterBR:setPos(windowSize.x / 4 * -1 + outerXOffset, windowSize.y / 4 * -1 + outerYOffset, 0)
						local innerYOffset = 8
						local innerXOffset = innerYOffset * (windowSize.x / windowSize.y)
						local cameraCenter = windowSize:copy():scale(-0.125)
						models.models.ex_skill_1.Gui.CameraGui.InnerTL:setPos(cameraCenter.x + innerXOffset, cameraCenter.y + innerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.InnerTR:setPos(cameraCenter.x - innerXOffset, cameraCenter.y + innerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.InnerBL:setPos(cameraCenter.x + innerXOffset, cameraCenter.y - innerYOffset, 0)
						models.models.ex_skill_1.Gui.CameraGui.InnerBR:setPos(cameraCenter.x - innerXOffset, cameraCenter.y - innerYOffset, 0)
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.CameraGui.SplitHT, models.models.ex_skill_1.Gui.CameraGui.SplitHB, models.models.ex_skill_1.Gui.CameraGui.SplitVL, models.models.ex_skill_1.Gui.CameraGui.SplitVR}) do
							modelPart:setOpacity(0.5)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.CameraGui.SplitHT, models.models.ex_skill_1.Gui.CameraGui.SplitHB}) do
							modelPart:setScale(windowSize.x, 1, 1)
						end
						models.models.ex_skill_1.Gui.CameraGui.SplitHT:setPos(0, windowSize.y / 4 * -0.25, 1)
						models.models.ex_skill_1.Gui.CameraGui.SplitHB:setPos(0, windowSize.y / 4 * -0.75, 1)
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.CameraGui.SplitVL, models.models.ex_skill_1.Gui.CameraGui.SplitVR}) do
							modelPart:setScale(1, windowSize.y, 1)
						end
						models.models.ex_skill_1.Gui.CameraGui.SplitVL:setPos(windowSize.x / 4 * -0.25, 0, 1)
						models.models.ex_skill_1.Gui.CameraGui.SplitVR:setPos(windowSize.x / 4 * -0.75, 0, 1)
						local trueWindowSize = client:getWindowSize()
						models.models.ex_skill_1.Gui.CameraGui:getTask("ex_skill_1_camera_gui_rec"):setPos(cameraCenter.x, -4, 0):setScale(0.5):setAlignment("CENTER")
						models.models.ex_skill_1.Gui.CameraGui:getTask("ex_skill_1_camera_gui_resolution"):setText(trueWindowSize.x .. "x" .. trueWindowSize.y):setPos(-4 * (windowSize.x / windowSize.y) - 3, -4 - 3, 0)
						models.models.ex_skill_1.Gui.CameraGui:getTask("ex_skill_1_camera_gui_fps"):setPos(windowSize.x / 4 * -1 - (-4 * (windowSize.x / windowSize.y) - 3), -4 - 3, 0)
						models.models.ex_skill_1.Gui.CameraGui.Battery:setPos(-4 * (windowSize.x / windowSize.y) - 3, windowSize.y / 4 * -1 + 2 + 4, 0)
						models.models.ex_skill_1.Gui.CameraGui.Flash:setPos(windowSize.x / 4 * -1 - (-4 * (windowSize.x / windowSize.y) - 3), windowSize.y / 4 * -1 + 2 + 5, 0)
						models.models.ex_skill_1.Gui.CameraGui.Flash:setUVPixels(math.random() >= 0.95 and 16 or 0, 0)

						models.models.ex_skill_1.Gui.Transition.Transition:setScale(windowSize.x * 2, windowSize.y * 2, 1)
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.Transition:setPos(models.models.ex_skill_1.Gui.TransitionAnchor:getAnimPos():copy():mul(windowSize.y / math.cos(math.rad(30)), windowSize.y, 1):add(windowSize:copy():scale(-0.5):augmented(0)))
						end, "ex_skill_1_render")
					end
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "UNCOMFORT2", 27, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 27 then
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.5, 1)
					elseif tick == 29 then
						FaceParts:setEmotion("NORMAL", "CENTER", "OPENED", 42, true)
					elseif tick == 50 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					elseif tick == 71 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 1, true)
						local playerPos = player:getPos()
						local anchorPos = playerPos:copy():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0.5, 0, 0, 0, 1, 0))
						for i = 0, 17 do
							particles:newParticle("minecraft:poof", anchorPos):setScale(2):setVelocity(vectors.rotateAroundAxis(i * 20, 0, 0, 0.2, 0, 1, 0)):setColor(vectors.vec3(0.846, 0.736, 0.941):sub(vectors.vec3(0.151, 0.198, 0.058):scale(math.random())))
						end
						sounds:playSound("minecraft:entity.player.attack.sweep", playerPos, 1, 1.5)
					elseif tick == 72 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 34, true)
					elseif tick == 83 then
						self.exSkill.primary.spawnSmokeParticles(vectors.vec3(-16.5, 0, -16.25):scale(1 / 16))
					elseif tick == 89 then
						self.exSkill.primary.spawnSmokeParticles(vectors.vec3(27.5, 0, 24.75):scale(1 / 16))
					elseif tick == 100 then
						self.exSkill.primary.spawnSmokeParticles(vectors.vec3(4, 0, 28.75):scale(1 / 16))
					elseif tick == 106 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SMILE", 11, true)
						if host:isHost() then
							models.models.ex_skill_1.Gui.CameraGui:setVisible(false)
						end
					elseif tick == 117 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", 16, true)
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 3)
					elseif tick == 129 then
						for _ = 1, 10 do
							particles:newParticle("minecraft:electric_spark", ModelUtils.getModelWorldPos(models.models.ex_skill_1.StandCamera.HitEffect)):setScale(0.5):setVelocity(math.random() * 0.2 - 0.1, math.random() * 0.15, math.random() * 0.2 - 0.1):setColor(0.954, 0.392, 0.403):setGravity(0.5):setLifetime(8)
						end
						sounds:playSound("minecraft:block.anvil.place", player:getPos(), 0.5, 0.5)
					elseif tick == 133 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SMALL", 3, true)
					elseif tick == 136 then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SMALL", 15, true)
					elseif tick == 151 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "UNCOMFORT2", 4, true)
					elseif tick == 152 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.head.Hat, models.models.main, ModelAlias.alias.avatar.head)
					elseif tick == 155 then
						FaceParts:setEmotion("TEAR", "TEAR", "UNCOMFORT2", 1, true)
					elseif tick == 156 then
						FaceParts:setEmotion("TEAR", "TEAR", "SHOCK", 40, true)
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.5, 0.75)
					end
					if (tick >= 39 and tick < 45) or (tick >= 63 and tick < 69) then
						local anchorPos = models.models.ex_skill_1.Gui.Transition:getPos()
						local windowSize = client:getScaledWindowSize()
						for _ = 1, 5 do
							local offset = math.random() * 2 - 1
							ExSkillSpriteManager:spawn(models.models.ex_skill_1.Gui, vectors.vec3(0.804, 0.684, 0.997):add(vectors.vec3(0.196, 0.316, 0.003):scale(math.random())), anchorPos:copy():add(offset * windowSize.x * math.cos(math.rad(30)), offset * windowSize.y / math.cos(math.rad(30))), vectors.rotateAroundAxis(30, 0, 1500 * (tick < 45 and 1 or -1), 0, 0, 0, 1), math.random() * 720 - 360, 30, nil, 20, false, 1)
						end
					end
					if tick >= 156 and (tick - 156) % 2 == 0 then
						local bodyYaw = player:getBodyYaw()
						for index, modelPart in ipairs({ModelAlias.alias.avatar.rightEye, ModelAlias.alias.avatar.leftEye}) do
							local anchorPos = ModelUtils.getModelWorldPos(modelPart):copy():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0.2, 0.2, 0, 1, 0))
							particles:newParticle("minecraft:splash", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.1 + 0.1 * (index == 1 and -1 or 1), math.random() * 0.1 + 0.1, 0, 0, 1, 0))
						end
						if tick % 4 == 0 then
							sounds:playSound("minecraft:block.bubble_column.bubble_pop", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head), 0.15, 2 - math.random() * 0.5)
						end
					end
					if tick < 106 and host:isHost() then
						if tick % 10 == 0 then
							models.models.ex_skill_1.Gui.CameraGui:getTask("ex_skill_1_camera_gui_rec"):setText("§f" .. (tick % 20 == 0 and ":red:" or "  ") .. " REC")
						end
						models.models.ex_skill_1.Gui.CameraGui:getTask("ex_skill_1_camera_gui_fps"):setText("§f" .. client:getFPS() .. "fps")
					end
				end;

				onPostAnimation = function ()
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						models.models.ex_skill_1.Gui.CameraGui:setVisible(true)
					end
					if models.models.main.Hat ~= nil then
						ModelUtils.moveTo(models.models.main.Hat, ModelAlias.alias.avatar.head, models.models.main)
					end
				end;
			};

			---煙幕のパーティクルを表示する。
			---@param offset Vector3 パーティクルの表示位置のオフセット
			spawnSmokeParticles = function (offset)
				local anchorPos = player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, offset, 0, 1, 0))
				for _ = 1, 20 do
					particles:newParticle("minecraft:poof", anchorPos):setScale(5):setVelocity(math.random() * 0.6 - 0.3, math.random() * 0.3, math.random() * 0.6 - 0.3):setColor(vectors.vec3(0.846, 0.736, 0.941):sub(vectors.vec3(0.151, 0.198, 0.058):scale(math.random()))):setLifetime(20)
				end
				sounds:playSound("minecraft:entity.generic.explode", anchorPos, 0.5, 2)
			end;

			---このExスキルを初期化したかどうか
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.Hat:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Dress:setVisible(not isVisible)
					ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, isVisible and -1 or 0)
					ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, isVisible and 1 or 0)
					self.physics.physicData[8].x.vertical.neutral = isVisible and 0 or -15
					self.physics.physicData[8].x.vertical.max = isVisible and 0 or -15
					self.physics.physicData[8].x.vertical.bodyX.max = isVisible and 0 or -15
					self.physics.physicData[8].x.vertical.bodyY.max = isVisible and 0 or -15
					self.physics.physicData[8].x.vertical.bodyRot.max = isVisible and 0 or -15
					self.physics.physicData[8].x.horizontal.neutral = isVisible and 0 or -15
					self.physics.physicData[8].x.horizontal.max = isVisible and 0 or -15
				end
			end;
		};

		---前ティックで剣を持っていたかどうか。
		---@type boolean
		hadSwordPrev = false;

		---前ティックで花火のモデルを置き換えたかどうか。
		---@type boolean
		shouldReplaceFireworkModelPrev = false;
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("ANGRY", "ANGRY", "OPENED2", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("NORMAL", "CLOSED", "OPENED", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SMALL", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "FRUST", duration, true)
					end
				end
			end;

			onStop = function(_, _, forcedStop)
				if not forcedStop then
					FaceParts:resetEmotion()
				end
			end;
		};
	};

	headModel = {

	};

	headBlock = {
		includeModels = {ModelAlias.alias.avatar.body.Hairs};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-2, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Dress:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(15, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.FrontHair:setPos(0.5, 0.5, 0)
				ModelAlias.alias.dummy_avatar.body.Hairs.FrontHair:setRot(0, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-15, 0, -10)
				ModelAlias.alias.dummy_avatar.body.Dress:setRot(15, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(75, 0, -15)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.Cowlick};

				x = {
					vertical = {
						min = -85;
						neutral = -67.5;
						max = -47.5;

						bodyY = {
							multiplayer = -40;
							min = -85;
							max = -47.5;
						};
					};

					horizontal = {
						min = -85;
						neutral = -67.5;
						max = -47.5;

						bodyX = {
							multiplayer = -80;
							min = -85;
							max = -47.5;
						};
					};
				};

				y = {
					vertical = {
						min = 50;
						neutral = 50;
						max = 50;
					};

					horizontal = {
						min = 50;
						neutral = 50;
						max = 50;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Tail};

				x = {
					vertical = {
						min = -60;
						neutral = 45;
						max = 60;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 60;
						};

						bodyY = {
							multiplayer = 80;
							min = -60;
							max = 60;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = 0;
							max = 60;
						};
					};

					horizontal = {
						min = -60;
						neutral = 0;
						max = 60;
						sneakOffset = 30;

						bodyX = {
							multiplayer = 160;
							min = -60;
							max = 60;
						};
					};
				};

				y = {
					vertical = {
						min = -30;
						neutral = 0;
						max = 30;

						bodyZ = {
							multiplayer = -160;
							min = -30;
							max = 30;
						};
					};

					horizontal = {
						min = -30;
						neutral = 0;
						max = 30;

						bodyRot = {
							multiplayer = 0.05;
							min = -30;
							max = 30;
						};
					};
				};
			};

		{
				models = {ModelAlias.alias.avatar.head.Hat.HatRibbon.HatRibbon1};

				z = {
					vertical = {
						min = -150;
						neutral = -5;
						max = -5;

						headZ = {
							multiplayer = -120;
							min = -90;
							max = -5;
						};

						headRot = {
							multiplayer = 0.075;
							min = -90;
							max = -5;
						};
					};

					horizontal = {
						min = -150;
						neutral = -10;
						max = -5;

						bodyX = {
							multiplayer = 120;
							min = -150;
							max = -5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Hat.HatRibbon.HatRibbon1.HatRibbon1};

				x = {
					vertical = {
						min = -170;
						neutral = -12.5;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -120;
							min = -90;
							max = 90;
						};

						bodyY = {
							multiplayer = 120;
							min = -170;
							max = 12.5;
						};

					};

					horizontal = {
						min = -170;
						neutral = 32.5;
						max = 90;

						bodyX = {
							multiplayer = -120;
							min = -90;
							max = 90;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Hat.HatRibbon.HatRibbon2};

				z = {
					vertical = {
						min = -150;
						neutral = -7.5;
						max = -7.5;

						headZ = {
							multiplayer = -120;
							min = -90;
							max = -7.5;
						};

						headRot = {
							multiplayer = 0.075;
							min = -90;
							max = -7.5;
						};
					};

					horizontal = {
						min = -150;
						neutral = -10;
						max = -7.5;

						bodyX = {
							multiplayer = 120;
							min = -150;
							max = -7.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Hat.HatRibbon.HatRibbon2.HatRibbon2};

				x = {
					vertical = {
						min = -170;
						neutral = 0;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -120;
							min = -90;
							max = 90;
						};

						bodyY = {
							multiplayer = 120;
							min = -170;
							max = 0;
						};

					};

					horizontal = {
						min = -170;
						neutral = 45;
						max = 90;

						bodyX = {
							multiplayer = -120;
							min = -90;
							max = 90;
						};
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
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair};

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
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function (self)
		---忍術ワープの表現
		---@type Teleport
		Teleport = require("scripts.teleport")

		---Exスキルで使用するスプライトオブジェクトのインスタンスクラス
		---@type ExSkillSprite
		ExSkillSprite = require("scripts.ex_skill_sprite")

		---Exスキルで使用するスプライトオブジェクトのマネージャークラス
		---@type ExSkillSpriteManager
		ExSkillSpriteManager = require("scripts.ex_skill_sprite_manager")
		ExSkillSpriteManager = ExSkillSpriteManager.new()

		Teleport:init()

        events.TICK:register(function ()
			ModelAlias.alias.avatar.body.Dress:setRot(player:isCrouching() and 17.5 or 0, 0, 0)

            local hasSword = (player:getHeldItem().id:match("^minecraft:(%a+)_sword$") ~= nil or player:getHeldItem(true).id:match("^minecraft:(%a+)_sword$") ~= nil) and ExSkill.animationCount == -1
            if hasSword ~= self.costume.hadSwordPrev then
                if hasSword then
                    sounds:playSound("minecraft:block.anvil.place", player:getPos(), 0.5, 5)
                    local version = client:getVersion() == "1.21.4"
                    events.ITEM_RENDER:register(function (item, mode)
                        if item.id:match("^minecraft:(%a+)_sword$") ~= nil and mode ~= "HEAD" then
                            if mode == "FIRST_PERSON_LEFT_HAND" or mode == "FIRST_PERSON_RIGHT_HAND" then
                                models.models.sword.Sword:setPos(0, -7.5, -1)
                                models.models.sword.Sword:setRot(10, 0, 0)
                            elseif mode == "THIRD_PERSON_LEFT_HAND" or mode == "THIRD_PERSON_RIGHT_HAND" then
                                models.models.sword.Sword:setPos(0.5, -9.75, -1)
                                models.models.sword.Sword:setRot()
                            end
                            local material = item.id:match("^minecraft:(%a+)_sword$")
                            models.models.sword.Sword.SwordBlade:setUVPixels(material == "wooden" and -4 or (material == "stone" and -2 or (material == "golden" and 2 or (material == "diamond" and 4 or (material == "netherite" and 6 or 0)))), 0)
                            models.models.sword.Sword:setSecondaryRenderType(item:hasGlint() and "GLINT"..(version and "2" or "") or "NONE")
                            return models.models.sword.Sword
                        end
                    end, "sword_item_render")
                else
                    events.ITEM_RENDER:remove("sword_item_render")
                    sounds:playSound("minecraft:block.iron_trapdoor.close", player:getPos(), 0.5, 2)
                end
                self.costume.hadSwordPrev = hasSword
            end
        end)
	end;
}

return BlueArchiveCharacter
