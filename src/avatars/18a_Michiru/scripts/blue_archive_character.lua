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
		avatarName = "18a_Michiru";

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
				type = "BODY";

				pos = {
					right = vectors.vec3(1.5, 3.5, 3.5);
					left = vectors.vec3(1.5, 3.5, 3.5);
				};

				rot = {
					right = vectors.vec3(-20, -90, 0);
					left = vectors.vec3(-20, -90, 0);
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
			formationType = "STRIKER";

			models = {models.models.ex_skill_1.CameraBackground};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(10, 180, -10);
					pos = vectors.vec3(0, 26.2, -25);
				};

				fin = {
					rot = vectors.vec3(-10, 120, 10);
					pos = vectors.vec3(22.05, 19.35, -9.65);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						self.exSkill.primary.shadowFaceTexture = textures:newTexture("ex_skill_1_shadow_face_full", 64, 64)
						local dimensions = textures["textures.ex_skill_1_shadow_face"]:getDimensions()
						for y = 0, dimensions.y - 1 do
							for x = 0, dimensions.x - 1 do
								self.exSkill.primary.shadowFaceTexture:setPixel(x, y, textures["textures.ex_skill_1_shadow_face"]:getPixel(x, y))
							end
						end
						self.exSkill.primary.shadowFaceTexture:update()
						self.exSkill.primary.isInitialized = true
					end
					if host:isHost() then
						models.models.ex_skill_1.CameraBackground:setOpacity(0)
						local gameVersion = client:getVersion()
						local shouldAdjustBackgroundRot = StringUtils.compareVersions(gameVersion, "1.21.0") == gameVersion
						events.RENDER:register(function (delta)
							local opacity = models.models.ex_skill_1.CameraBackground.BackgroundOpacity:getAnimScale().x
							models.models.ex_skill_1.CameraBackground:setOpacity(opacity)
							if opacity > 0 then
								models.models.ex_skill_1.CameraBackground:setVisible(true)
								local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.8)), 0, 1, 0):scale(16 / 0.9375)
								models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
								models.models.ex_skill_1.CameraBackground.BackgroundCore:setPos(backgroundPos)
								local windowSize = client:getWindowSize()
								models.models.ex_skill_1.CameraBackground.BackgroundCore:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(40))
								if shouldAdjustBackgroundRot then
									models.models.ex_skill_1.CameraBackground.BackgroundCore:setRot(0, 0, renderer:getCameraRot().z)
								end
								models.models.ex_skill_1.CameraBackground.BackgroundCore.Flash.Flash:setOpacity(models.models.ex_skill_1.CameraBackground.BackgroundCore.FlashOpacity:getAnimScale().x)
							else
								models.models.ex_skill_1.CameraBackground:setVisible(false)
							end
						end, "ex_skill_1_render")
					end
					FaceParts:setEmotion("ANGRY", "ANGRY", "OPENED", 9, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 9 then
						FaceParts:setEmotion("LOWER", "LOWER", "OPENED", 5, true)
						sounds:playSound("minecraft:entity.player.attack.weak", player:getPos(), 0.5, 1.5)
					elseif tick == 14 then
						FaceParts:setEmotion("LOWER", "LOWER", "FRUST_OPENED", 8, true)
						sounds:playSound("minecraft:entity.player.attack.weak", player:getPos(), 0.5, 1.5)
					elseif tick == 19 then
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.25, 1.5)
					elseif tick == 22 then
						FaceParts:setEmotion("LOWER", "LOWER", "FRUST", 10, true)
					elseif tick == 25 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 0.5, 1.75)
					elseif tick == 32 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "FRUST", 3, true)
					elseif tick == 33 then
						ModelAlias.alias.avatar.head.Sweat:setVisible(true)
					elseif tick == 35 then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SMALL", 16, true)
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.mouth)
						local velocityVec = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.ExSkill1ParticleAnchor3):sub(anchorPos):normalize()
						for _ = 1, 3 do
							particles:newParticle("minecraft:smoke", anchorPos):setScale(0.8):setVelocity(velocityVec:copy():add(math.random() - 0.5, math.random() * 0.5, math.random() - 0.5):scale(0.05)):setLifetime(12)
						end
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 1, 0.5)
					elseif tick == 50  then
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground.BackgroundCore.Background:setColor(0, 0, 0)
						end
						ModelAlias.alias.avatar.head.Sweat:setVisible(false)
					elseif tick == 51 then
						FaceParts:setEmotion("SCHEME", "SCHEME", "OVER_SMILE", 16, true)
						ModelAlias.alias.avatar.head.Head:setPrimaryTexture("CUSTOM", self.exSkill.primary.shadowFaceTexture)
					elseif tick == 58 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 0.5, 1.5)
					elseif tick == 62 then
						ModelAlias.alias.avatar.leftArmBottom.Firework:setVisible(true)
						sounds:playSound("minecraft:item.flintandsteel.use", player:getPos(), 1, 1)
					elseif tick == 67 then
						FaceParts:setEmotion("TEAR_ANGRY", "ANGRY_INVERTED", "UNCOMFORT", 5, true)
						ModelAlias.alias.avatar.head.Head:setPrimaryTexture("PRIMARY")
						sounds:playSound("minecraft:entity.firework_rocket.launch", player:getPos(), 1, 0.75)
					elseif tick == 72 then
						FaceParts:setEmotion("TEAR_ANGRY", "ANGRY_INVERTED", "SHOCK", 30, true)
					end

					if tick >= 11 and tick <= 23 and (tick - 11) % 6 == 0 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = player:getPos():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 1.25, 0.4, 0, 1, 0))
						for i = 0, 11 do
							local offsetVec = vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 30, 1, 0, 0, 0, 0, 1), 0, 1, 0):normalize()
							particles:newParticle("minecraft:end_rod", anchorPos:copy():add(offsetVec:copy():scale(0.2))):setScale(0.25):setVelocity(offsetVec:copy():scale(0.05)):setColor(1, 1, 0.75):setLifetime(4)
						end
					elseif tick >= 9 and tick <= 19 and (tick - 9) % 5 == 0 then
						particles:newParticle("minecraft:sweep_attack", player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 1.35, 0.4, 0, 1, 0))):setScale(2):setLifetime(4)
					end

					if tick >= 1 and tick <= 23 then
						local animationProgress = tick / 23
						local playerPos = player:getPos()
						local bodyYaw = player:getBodyYaw()
						for i = 1, 2 do
							if i == 1 or tick >= 16 then
								local animPos = models.models.ex_skill_1["ExSkill1ParticleAnchor"..i]:getAnimPos():mul(-1, 1, -1)
								local dirVec = animPos:copy():sub(self.exSkill.primary.fireAnchorPosPrev[i])
								for j = 0, 7 do
									particles:newParticle("minecraft:flame", playerPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, self.exSkill.primary.fireAnchorPosPrev[i]:copy():add(dirVec:copy():scale(j / 8)):scale(0.0625), 0, 1, 0))):setLifetime(animationProgress * 10 + math.random(6, 14))
								end
								self.exSkill.primary.fireAnchorPosPrev[i] = animPos:copy()
							end
						end
					elseif tick >= 62 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.Firework.ExSkill1ParticleAnchor)
						for _ = 1, 2 do
							particles:newParticle("minecraft:firework", anchorPos):setScale(1):setVelocity(math.random() * 0.4 - 0.2, math.random() * 0.4 - 0.2, math.random() * 0.4 - 0.2):setGravity(0.25):setColor(1, 0.856, 0.185):setLifetime(4)
						end
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						models.models.ex_skill_1.CameraBackground.BackgroundCore.Background:setColor()
					end
					self.exSkill.primary.fireAnchorPosPrev = {vectors.vec3(-19, 25.5, 15), vectors.vec3(-21, 43, -11)};
					if forcedStop then
						ModelAlias.alias.avatar.head.Sweat:setVisible(false)
						ModelAlias.alias.avatar.head.Head:setPrimaryTexture("PRIMARY")
					end
				end;
			};

			---このExスキルが初期化されたかどうか
			---@type boolean
			isInitialized = false;

			---何かを企んでいる顔のテクスチャ
			---@type Texture
			shadowFaceTexture = nil;

			---前ティックの炎のトレイルの位置：[1]: アンカー1, [2]: アンカー2
			---@type Vector3[]
			fireAnchorPosPrev = {vectors.vec3(-19, 25.5, 15), vectors.vec3(-21, 43, -11)};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.Cowlick:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.AmmoBelt:setVisible(not isVisible)
					ModelAlias.alias.avatar.body.Scarfs:setPos(0, 0, isVisible and 1 or 0)
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
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
		includeModels = {};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(30, 0, 20)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(30, 0, -20)
				ModelAlias.alias.dummy_avatar.body.Scarfs.Scarf1:setRot(45, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(50, 0, 0)
				ModelAlias.alias.dummy_avatar.body.SwordGroup.Sword:setPos()
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(15, 0, 0)
				ModelAlias.alias.dummy_avatar.leftArmBottom.Firework:setVisible(false)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(-20, 0, 20)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(-20, 0, -20)
				ModelAlias.alias.dummy_avatar.body.Scarfs.Scarf1:setRot(75, 0, -30)
				ModelAlias.alias.dummy_avatar.body.Scarfs.Scarf2:setRot(75, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(35, 0, 0)
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
				models = {ModelAlias.alias.avatar.head.HairTails.LeftHairTail};
				x = {
					vertical = {
						min = -170;
						neutral = -10;
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
							multiplayer = -80;
							min = -45;
							max = 70;
						};
					};
				};

				z = {
					vertical = {
						min = -70;
						neutral = -10;
						max = 70;

						headZ = {
							multiplayer = -80;
							min = -70;
							max = 70;
						};
					};

					horizontal = {
						min = -70;
						neutral = -10;
						max = 70;

						headX = {
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
						min = -170;
						neutral = -10;
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
							multiplayer = -80;
							min = -45;
							max = 70;
						};
					};
				};

				z = {
					vertical = {
						min = -70;
						neutral = 10;
						max = 70;

						headZ = {
							multiplayer = -80;
							min = -70;
							max = 70;
						};
					};

					horizontal = {
						min = -70;
						neutral = 10;
						max = 70;

						headX = {
							multiplayer = 80;
							min = 10;
							max = 2.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HRibbons.RightHeadRibbon1};

				y = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						headX = {
							multiplayer = 160;
							min = -90;
							max = 90;
						};
					};

					horizontal = {
						min = -45;
						neutral = -45;
						max = 45;

						headX = {
							multiplayer = 80;
							min = -45;
							max = 45;
						};

						bodyY = {
							multiplayer = -160;
							min = -45;
							max = 45;
						};
					};
				};

				z = {
					vertical = {
						min = -75;
						neutral = 45;
						max = 65;

						bodyY = {
							multiplayer = 160;
							min = -75;
							max = 65;
						};

						headRot = {
							multiplayer = 0.08;
							min = 0;
							max = 65;
						};
					};

					horizontal = {
						min = -75;
						neutral = 45;
						max = 65;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HRibbons.RightHeadRibbon2};

				y = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						headX = {
							multiplayer = 160;
							min = -90;
							max = 90;
						};
					};

					horizontal = {
						min = -45;
						neutral = -45;
						max = 45;

						headX = {
							multiplayer = 80;
							min = -45;
							max = 45;
						};

						bodyY = {
							multiplayer = -160;
							min = -45;
							max = 45;
						};
					};
				};

				z = {
					vertical = {
						min = -65;
						neutral = 70;
						max = 82.5;

						bodyY = {
							multiplayer = 160;
							min = -65;
							max = 82.5;
						};

						headRot = {
							multiplayer = 0.08;
							min = 0;
							max = 82.5;
						};
					};

					horizontal = {
						min = -65;
						neutral = 70;
						max = 82.5;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HRibbons.LeftHeadRibbon1};

				y = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						headX = {
							multiplayer = -160;
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

						bodyY = {
							multiplayer = 160;
							min = -45;
							max = 45;
						};
					};
				};

				z = {
					vertical = {
						min = -65;
						neutral = -45;
						max = 75;

						bodyY = {
							multiplayer = -160;
							min = -65;
							max = 75;
						};

						headRot = {
							multiplayer = -0.08;
							min = -65;
							max = 0;
						};
					};

					horizontal = {
						min = -65;
						neutral = -45;
						max = 75;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HRibbons.LeftHeadRibbon2};

				y = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						headX = {
							multiplayer = -160;
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

						bodyY = {
							multiplayer = 160;
							min = -45;
							max = 45;
						};
					};
				};

				z = {
					vertical = {
						min = -82.5;
						neutral = -70;
						max = 65;

						bodyY = {
							multiplayer = -160;
							min = -82.5;
							max = 65;
						};

						headRot = {
							multiplayer = -0.08;
							min = -82.5;
							max = 0;
						};
					};

					horizontal = {
						min = -82.5;
						neutral = -70;
						max = 65;
					};
				};
			};

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
				models = {ModelAlias.alias.avatar.body.Scarfs.Scarf1};

				x = {
					vertical = {
						min = -30;
						neutral = 75;
						max = 75;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 75;
						};

						bodyY = {
							multiplayer = 80;
							min = -30;
							max = 75;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -30;
							max = 75;
						};
					};

					horizontal = {
						min = -30;
						neutral = 75;
						max = 75;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Scarfs.Scarf2};

				x = {
					vertical = {
						min = -30;
						neutral = 75;
						max = 75;

						bodyX = {
							multiplayer = -120;
							min = 0;
							max = 75;
						};

						bodyY = {
							multiplayer = 120;
							min = -30;
							max = 75;
						};

						bodyRot = {
							multiplayer = 0.075;
							min = -30;
							max = 75;
						};
					};

					horizontal = {
						min = -30;
						neutral = 75;
						max = 75;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Scarfs.Scarf1.Scarf1YPivot};

				y = {
					vertical = {
						min = -70;
						neutral = 15;
						max = 80;

						bodyX = {
							multiplayer = -20;
							min = 0;
							max = 15;
						};

						bodyZ = {
							multiplayer = -80;
							min = -70;
							max = 80;
						};

						bodyRot = {
							multiplayer = 0.01;
							min = 0;
							max = 15;
						};
					};

					horizontal = {
						min = -70;
						neutral = 15;
						max = 80;

						bodyX = {
							multiplayer = -20;
							min = 0;
							max = 15;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Scarfs.Scarf2.Scarf2YPivot};

				y = {
					vertical = {
						min = -80;
						neutral = -15;
						max = 70;

						bodyX = {
							multiplayer = 30;
							min = -15;
							max = 0;
						};

						bodyZ = {
							multiplayer = -120;
							min = -80;
							max = 70;
						};

						bodyRot = {
							multiplayer = -0.015;
							min = -15;
							max = 0;
						};
					};

					horizontal = {
						min = -80;
						neutral = -15;
						max = 70;

						bodyX = {
							multiplayer = 30;
							min = 0;
							max = -15;
						};
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

		Teleport:init()

        ModelAlias.alias.avatar.leftArmBottom.Firework:setPrimaryTexture("RESOURCE", "minecraft:textures/item/firework_rocket.png")

        events.TICK:register(function ()
            local hasSword = (player:getHeldItem().id:match("^minecraft:(%a+)_sword$") ~= nil or player:getHeldItem(true).id:match("^minecraft:(%a+)_sword$") ~= nil) and ExSkill.animationCount == -1
            if hasSword ~= self.costume.hadSwordPrev then
                if hasSword then
                    ModelAlias.alias.avatar.body.SwordGroup.Sword:setParentType("Item")
                    sounds:playSound("minecraft:block.anvil.place", player:getPos(), 0.5, 5)
                    local version = client:getVersion() == "1.21.4"
                    events.ITEM_RENDER:register(function (item, mode)
                        if item.id:match("^minecraft:(%a+)_sword$") ~= nil and mode ~= "HEAD" then
                            if mode == "FIRST_PERSON_LEFT_HAND" or mode == "FIRST_PERSON_RIGHT_HAND" then
                                ModelAlias.alias.avatar.body.SwordGroup.Sword:setPos(0, -7.5, -1)
                                ModelAlias.alias.avatar.body.SwordGroup.Sword:setRot(10, 0, 0)
                            elseif mode == "THIRD_PERSON_LEFT_HAND" or mode == "THIRD_PERSON_RIGHT_HAND" then
                                ModelAlias.alias.avatar.body.SwordGroup.Sword:setPos(0.5, -9.75, -1)
                                ModelAlias.alias.avatar.body.SwordGroup.Sword:setRot()
                            end
                            local material = item.id:match("^minecraft:(%a+)_sword$")
                            ModelAlias.alias.avatar.body.SwordGroup.Sword.SwordBlade:setUVPixels(material == "wooden" and -6 or (material == "stone" and -4 or (material == "copper" and -2 or (material == "golden" and 2 or (material == "diamond" and 4 or (material == "netherite" and 6 or 0))))), 0)
                            ModelAlias.alias.avatar.body.SwordGroup.Sword:setSecondaryRenderType(item:hasGlint() and "GLINT"..(version and "2" or "") or "NONE")
                            return ModelAlias.alias.avatar.body.SwordGroup.Sword
                        end
                    end, "sword_item_render")
                else
                    events.ITEM_RENDER:remove("sword_item_render")
                    ModelAlias.alias.avatar.body.SwordGroup.Sword:setPos()
                    ModelAlias.alias.avatar.body.SwordGroup.Sword:setRot()
                    ModelAlias.alias.avatar.body.SwordGroup.Sword:setParentType("None")
                    ModelAlias.alias.avatar.body.SwordGroup.Sword:setSecondaryRenderType("NONE")
                    sounds:playSound("minecraft:block.iron_trapdoor.close", player:getPos(), 0.5, 2)
                end
                self.costume.hadSwordPrev = hasSword
            end

            local shouldReplaceFireworkModel = ExSkill.animationCount == -1
            if shouldReplaceFireworkModel ~= self.costume.shouldReplaceFireworkModelPrev then
                if shouldReplaceFireworkModel then
                    ModelAlias.alias.avatar.leftArmBottom.Firework:setParentType("Item")
                    ModelAlias.alias.avatar.leftArmBottom.Firework:setVisible(true)
                    local version = client:getVersion() == "1.21.4"
                    events.ITEM_RENDER:register(function (item, mode)
                        if item.id == "minecraft:firework_rocket" then
                            if mode == "FIRST_PERSON_LEFT_HAND" then
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setPos(-2.5, 2, 0)
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setRot(60, 10, 0)
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setScale()
                            elseif mode == "FIRST_PERSON_RIGHT_HAND" then
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setPos(2.5, 2, 0)
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setRot(60, 10, 0)
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setScale()
                            elseif mode == "THIRD_PERSON_LEFT_HAND" or mode == "THIRD_PERSON_RIGHT_HAND" then
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setPos(0, -2, 0)
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setRot(90, 90, 0)
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setScale()
                            else
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setPos(0, 12.5, 0)
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setRot(90, 0, 0)
                                ModelAlias.alias.avatar.leftArmBottom.Firework:setScale(2, 2, 2)
                            end
                            ModelAlias.alias.avatar.leftArmBottom.Firework:setSecondaryRenderType(item:hasGlint() and "GLINT"..(version and "2" or "") or "NONE")
                            return ModelAlias.alias.avatar.leftArmBottom.Firework
                        end
                    end, "firework_item_render")
                else
                    events.ITEM_RENDER:remove("firework_item_render")
                    ModelAlias.alias.avatar.leftArmBottom.Firework:setPos()
                    ModelAlias.alias.avatar.leftArmBottom.Firework:setRot()
                    ModelAlias.alias.avatar.leftArmBottom.Firework:setScale(1, 1, 1)
                    ModelAlias.alias.avatar.leftArmBottom.Firework:setParentType("None")
                    ModelAlias.alias.avatar.leftArmBottom.Firework:setSecondaryRenderType("NONE")
                    ModelAlias.alias.avatar.leftArmBottom.Firework:setVisible(false)
                end
                self.costume.shouldReplaceFireworkModelPrev = shouldReplaceFireworkModel
            end
        end)
	end;
}

return BlueArchiveCharacter
