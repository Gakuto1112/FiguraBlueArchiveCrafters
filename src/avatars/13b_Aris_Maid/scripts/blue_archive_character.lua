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
---| "NARROW" # 少し閉じた目
---| "CLOSED2" # 閉じた目2
---| "STARE" # 凝視目（Exスキル1の最後の目）
---| "ANGRY" # 怒った目
---| "TEAR" # 涙目
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目
---| "ANGRY_NARROW" # 怒りつつ少し閉じた目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "NARROW" # 少し閉じた目
---| "CLOSED2" # 閉じた目2
---| "STARE" # 凝視目（Exスキル1の最後の目）
---| "CENTER" # 少し反対側を見る目
---| "ANGRY" # 怒った目
---| "TEAR" # 涙目
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目
---| "ANGRY_NARROW" # 怒りつつ少し閉じた目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "CLOSED" # 閉じた口
---| "SMILE" # にっこり
---| "SMALL" # 小さく開いた口
---| "OPENED" # 開いた口
---| "ANGRY" # への口
---| "SHOCK" # あんぐり口
---| "BRAVE" # 勇ましい口
---| "TEETH" # 食いしばる口

---キャラクター固有の腕の状態
---@alias BlueArchiveCharacter.AdditionalArmState
---| "RAIL_GUN_MAIN_HAND" # レールガンを構えている際の、武器を構えている方の腕
---| "RAIL_GUN_OFF_HAND" # レールガンを構えている際の、武器を構えていない方の腕

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
		avatarName = "13b_Aris_Maid";

		birth = {
			month = 3;
			day = 25;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			NARROW = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(7, 0);
			STARE = vectors.vec2(8, 0);
			ANGRY = vectors.vec2(10, 0);
			TEAR = vectors.vec2(12, 0);
			ANGRY_CENTER = vectors.vec2(14, 0);
			ANGRY_NARROW = vectors.vec2(15, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			NARROW = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(6, 0);
			STARE = vectors.vec2(7, 0);
			CENTER = vectors.vec2(8, 0);
			ANGRY = vectors.vec2(10, 0);
			TEAR = vectors.vec2(11, 0);
			ANGRY_CENTER = vectors.vec2(12, 0);
			ANGRY_NARROW = vectors.vec2(15, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(0, 0);
			SMILE = vectors.vec2(1, 0);
			SMALL =  vectors.vec2(2, 0);
			OPENED = vectors.vec2(3, 0);
			ANGRY = vectors.vec2(4, 0);
			SHOCK = vectors.vec2(5, 0);
			BRAVE = vectors.vec2(6, 0);
			TEETH = vectors.vec2(7, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				local result = {right = right, left = left}
				if right == "GUN_MAIN_HAND" then
					result.right = "RAIL_GUN_MAIN_HAND"
				elseif right == "GUN_OFF_HAND" then
					result.right = "RAIL_GUN_OFF_HAND"
				elseif right == "CROSSBOW" and Gun.currentGunPosition == "RIGHT" then
					result.right = "RAIL_GUN_MAIN_HAND"
				end

				if left == "GUN_MAIN_HAND" then
					result.left = "RAIL_GUN_MAIN_HAND"
				elseif left == "GUN_OFF_HAND" then
					result.left = "RAIL_GUN_OFF_HAND"
				elseif left == "CROSSBOW" and Gun.currentGunPosition == "LEFT" then
					result.left = "RAIL_GUN_MAIN_HAND"
				end

				return result
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "RAIL_GUN_MAIN_HAND" then
					events.TICK:register(function ()
						if Arms.armState.right == "RAIL_GUN_MAIN_HAND" then
							Arms:processArmSwingCount()
							if player:isSwingingArm() and not player:isLeftHanded() then
								ModelAlias.alias.avatar.rightArm:setParentType("RightArm")
							else
								ModelAlias.alias.avatar.rightArm:setParentType("Body")
							end
							if player:getActiveItem().id == "minecraft:crossbow" then
								Arms:setArmState("CROSSBOW", "CROSSBOW")
							end
						end
					end, "right_arm_tick")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local rotY = headRot.y % 360
						rotY = rotY > 180 and 0 or rotY
						ModelAlias.alias.avatar.rightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3() or vectors.vec3(math.max(headRot.x - 40 + (player:isCrouching() and 30 or 0), -40) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5, rotY, 0))
					end, "right_arm_render")
					return true
				elseif state == "RAIL_GUN_OFF_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
					end, "right_arm_tick")
					events.RENDER:register(function (delta, context)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
						ModelAlias.alias.avatar.rightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.max(headRot.x + 50 + (player:isCrouching() and 30 or 0), 40), math.min(math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78) + 30, 65) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5, 0))
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "RAIL_GUN_MAIN_HAND" then
					events.TICK:register(function ()
						if Arms.armState.left == "RAIL_GUN_MAIN_HAND" then
							Arms:processArmSwingCount()
							if player:isSwingingArm() and player:isLeftHanded() then
								ModelAlias.alias.avatar.leftArm:setParentType("LeftArm")
							else
								ModelAlias.alias.avatar.leftArm:setParentType("Body")
							end
							if player:getActiveItem().id == "minecraft:crossbow" then
								Arms:setArmState("CROSSBOW", "CROSSBOW")
							end
						end
					end, "left_arm_tick")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local rotY = headRot.y % 360
						rotY = rotY < 180 and 0 or rotY
						ModelAlias.alias.avatar.leftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3() or vectors.vec3(math.max(headRot.x - 40 + (player:isCrouching() and 30 or 0), -40) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5, rotY, 0))
					end, "left_arm_render")
				elseif state == "RAIL_GUN_OFF_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
						ModelAlias.alias.avatar.leftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.max(headRot.x + 50 + (player:isCrouching() and 30 or 0), 40), math.max(math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21) - 30, -65) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5, 0))
					end, "left_arm_render")
				end
			end;
		};
	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt1};
	};

	gun = {
		scale = 2.2;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(6, -3, -15);
					left = vectors.vec3(-6, -3, -15);
				};

				thirdPersonPos = {
					right = vectors.vec3(0, 10, 0);
					left = vectors.vec3(0, 10, 0);
				};

				thirdPersonRot = {
					right = vectors.vec3(130, 0, 0);
					left = vectors.vec3(130, 0, 0);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, 1.5, 6);
					left = vectors.vec3(0, 1.5, 6);
				};

				rot = {
					right = vectors.vec3(0, -90, -32.5);
					left = vectors.vec3(0, 90, 32.5);
				};
			};
		};

		sound = {
			name = "minecraft:entity.blaze.hurt";
			pitch = 2;
		};
	};

	placementObjects = {
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.rightArmBottom.Broom};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(-56, 11, -28);
				};

				fin = {
					rot = vectors.vec3(-10, 180, -35);
					pos = vectors.vec3(-335, 11.3, -30);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						ModelAlias.alias.avatar.rightArmBottom.Broom.BroomBase:setPrimaryTexture("RESOURCE", "minecraft:textures/block/oak_planks.png")
						if host:isHost() then
							local gameVersion = client:getVersion()
							if StringUtils.compareVersions(gameVersion, "1.20.2") == gameVersion then
								textures:fromVanilla("heart_base", "minecraft:textures/gui/sprites/hud/heart/container.png")
								textures:fromVanilla("heart", "minecraft:textures/gui/sprites/hud/heart/full.png")
							else
								textures:fromVanilla("icons", "minecraft:textures/gui/icons.png")
							end

							---@diagnostic disable-next-line: discard-returns
							models:newPart("ex_skill_1_gui", "Gui")
							---@diagnostic disable-next-line: discard-returns
							models.ex_skill_1_gui:newPart("hearts")
							models.ex_skill_1_gui.hearts:setPos(-17.5, -17.5, 0)
							for i = 1, 3 do
								local baseSprite = models.ex_skill_1_gui.hearts:newSprite("ex_skill_1_heart_"..i.."_base")
								if textures.heart_base ~= nil then
									baseSprite:setTexture(textures.heart_base)
									baseSprite:setDimensions(9, 9)
									baseSprite:setRegion(9, 9)
									baseSprite:setSize(18, 18)
								else
									baseSprite:setTexture(textures.icons)
									baseSprite:setDimensions(256, 256)
									baseSprite:setRegion(9, 9)
									baseSprite:setUVPixels(16, 0)
									baseSprite:setSize(18, 18)
								end
								baseSprite:setPos((i - 1) * -19, 0, 0)
								local heartSprite = models.ex_skill_1_gui.hearts:newSprite("ex_skill_1_heart_"..i)
								if textures.heart ~= nil then
									heartSprite:setTexture(textures.heart)
									heartSprite:setDimensions(9, 9)
									heartSprite:setRegion(9, 9)
									heartSprite:setSize(18, 18)
								else
									heartSprite:setTexture(textures.icons)
									heartSprite:setDimensions(256, 256)
									heartSprite:setRegion(9, 9)
									heartSprite:setUVPixels(52, 0)
									heartSprite:setSize(18, 18)
								end
								heartSprite:setPos((i - 1) * -19, 0, -1)
							end
							---@diagnostic disable-next-line: discard-returns
							models.ex_skill_1_gui:newPart("coins")
							models.ex_skill_1_gui.coins:addChild(models.models.ex_skill_1.Coin:copy("Coin"))
							models.ex_skill_1_gui.coins.Coin:setPos(51, -11.5, 0)
							models.ex_skill_1_gui.coins.Coin:setScale(1.6, 1.6, 1)
							models.ex_skill_1_gui.coins.Coin:setPivot(0, 12, 0)
							models.ex_skill_1_gui.coins.Coin:setPrimaryRenderType()
							models.ex_skill_1_gui.coins.Coin:setVisible(true)
							models.ex_skill_1_gui.coins:newText("ex_skill_1_coin_counter"):setText("215"):setPos(38, -1, 0):setScale(2, 2, 2):setOutline(true):setOutlineColor(0.35, 0.35, 0.35)
						end
						self.exSkill.primary.isInitialized = true
					elseif host:isHost() then
						models.ex_skill_1_gui:setVisible(true)
					end
					if host:isHost() then
						models.ex_skill_1_gui.coins:setPos(client:getScaledWindowSize().x * -1 + 17.5, -18.5, 0)
					end
					self.exSkill.primary.coinCount = 215
					for i = -1, 4 do
						for j = 0, 18 do
							ExSkill1CoinManager:spawn(vectors.vec3(j * 32 - 96, 0, i * 32))
						end
					end
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 66, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun.DisplayContents:setVisible(false)
					elseif tick == 66 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 4, true)
					elseif tick == 70 then
						FaceParts:setEmotion("NORMAL", "CENTER", "SMALL", 15, true)
					elseif tick == 80 then
						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.5, 1.25)
					elseif tick == 85 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMALL", 2, true)
					elseif tick == 87 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 19, true)
						self.exSkill.primary.broomTipAnchorPosPrev = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightArmBottom.Broom)
					elseif tick >= 88 and tick < 92 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightArmBottom.Broom)
						if tick == 88 then
							sounds:playSound("minecraft:item.bucket.empty", anchorPos, 1, 0.75)
						end
						local directionVec = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightArmBottom.Broom.BroomParticleNAnchor):copy():sub(anchorPos)
						for i = -2, 2 do
							local offsetPos = directionVec:copy():scale(i)
							for j = 0, 1, 0.25 do
								particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy():sub(self.exSkill.primary.broomTipAnchorPosPrev):scale(j):add(anchorPos):add(offsetPos)):setScale(1.5):setColor(math.random() * 0.5 + 0.5, 1, 1)
							end
						end
						self.exSkill.primary.broomTipAnchorPosPrev = anchorPos:copy()
					elseif tick == 92 then
						if host:isHost() then
							models.ex_skill_1_gui:setVisible(false)
						end
						ModelAlias.alias.avatar.rightArmBottom.Broom:moveTo(ModelAlias.alias.avatar.body)
						RailGun.chargePercent = 0
						RailGun.chargeState = "STRONG"
						RailGun.animationLength = 20
						ModelAlias.alias.avatar.gun.DisplayContents:setVisible(true)
					elseif tick == 106 then
						FaceParts:setEmotion("NORMAL", "CENTER", "OPENED", 41, true)
					elseif tick == 109 then
						ExSkill1CoinManager:getAll()
					elseif tick == 111 then
						for _ = 1, 50 do
							ExSkill1CubeManager:spawn()
						end
					elseif tick == 118 then
						sounds:playSound("minecraft:block.note_block.bit", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 1.5)
					elseif tick == 120 then
						sounds:playSound("minecraft:block.note_block.bit", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 1.75)
					elseif tick == 122 then
						sounds:playSound("minecraft:block.note_block.bit", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 2)
					end

					if tick < 61 then
						if (tick - 1) % 2 == 0 then
							ExSkill1WaterManager:spawn(ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightArmBottom.Broom), vectors.rotateAroundAxis(player:getBodyYaw() * -1, -0.1, 0, 0, 0, 1, 0))
						end
						if tick % 8 == 0 then
							sounds:playSound("minecraft:entity.cod.flop", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.25, 0.75)
						end
						for _ = 1, 3 do
							particles:newParticle("minecraft:splash", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightArmBottom.Broom))
						end
					end
					if tick < 92 and host:isHost() then
						models.ex_skill_1_gui.coins:getTask("ex_skill_1_coin_counter"):setText(self.exSkill.primary.coinCount)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if ModelAlias.alias.avatar.body.Broom ~= nil then
						ModelAlias.alias.avatar.body.Broom:moveTo(ModelAlias.alias.avatar.rightArmBottom)
					end
					if Gun.currentGunPosition == "NONE" then
						local isLeftHanded = player:isLeftHanded()
						ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos[isLeftHanded and "left" or "right"]))
						ModelAlias.alias.avatar.gun:setRot(self.gun.gunPosition.put.rot[isLeftHanded and "left" or "right"])
						ModelAlias.alias.avatar.gun.DisplayContents:setVisible(false)
					end
					ExSkill1CubeManager:removeAll()
					if forcedStop then
						ExSkill1CoinManager:removeAll()
						ExSkill1WaterManager:removeAll()
						if host:isHost() then
							models.ex_skill_1_gui:setVisible(false)
						end
					else
						RailGun.isSpecialCharge = true
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---Exスキル中に表示されるコインカウンターの値
			---@type integer
			coinCount = 215;

			---前ティックの箒の先っちょの座標
			---@type Vector3
			broomTipAnchorPosPrev = vectors.vec3()
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt1:setVisible(not isVisible)
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
					FaceParts:setEmotion("ANGRY", "ANGRY", "ANGRY", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMALL", duration, true)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("TEAR", "TEAR", "SHOCK", duration, true)
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
		includeModels = {ModelAlias.alias.avatar.body.Hairs};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(10, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt1:setRot(35, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(-20, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt1:setRot(15, 0, 0)
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
						max = 5;
						sneakOffset = -20;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -40;
							min = -90;
							max = 5;
						};

						headRot = {
							multiplayer = 0.025;
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
						max = -25;

						headX = {
							multiplayer = -40;
							min = -45;
							max = -25;
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
							multiplayer = -40;
							min = -80;
							max = 80;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonRight};

				y = {
					vertical = {
						min = -70;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -40;
							min = -70;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.025;
							min = -70;
							max = 0;
						};
					};

					horizontal = {
						min = -70;
						neutral = 0;
						max = 0;

						bodyY = {
							multiplayer = 40;
							min = -70;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonRight.RibbonRightZPivot};

				z = {
					vertical = {
						min = -20;
						neutral = 0;
						max = 20;

						bodyY = {
							multiplayer = -20;
							min = -20;
							max = 20;
						};
					};

					horizontal = {
						min = -20;
						neutral = 0;
						max = 20;

						bodyX = {
							multiplayer = -20;
							min = -20;
							max = 20;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonLeft};

				y = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 70;

						bodyX = {
							multiplayer = 40;
							min = 0;
							max = 70;
						};

						bodyRot = {
							multiplayer = -0.025;
							min = 0;
							max = 70;
						};
					};

					horizontal = {
						min = 0;
						neutral = 0;
						max = 70;

						bodyY = {
							multiplayer = -40;
							min = 0;
							max = 70;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonLeft.RibbonLeftZPivot};

				z = {
					vertical = {
						min = -20;
						neutral = 0;
						max = 20;

						bodyY = {
							multiplayer = 20;
							min = -20;
							max = 20;
						};
					};

					horizontal = {
						min = -20;
						neutral = 0;
						max = 20;

						bodyX = {
							multiplayer = 20;
							min = -20;
							max = 20;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomRight, ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomLeft};

				x = {
					vertical = {
						min = -140;
						neutral = 0;
						max = 0;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = -60;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -140;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -60;
							max = 0;
						};
					};

					horizontal = {
						min = -140;
						neutral = 0;
						max = 0;

						bodyY = {
							multiplayer = 80;
							min = -60;
							max = 0;
						};
					};
				};
			};


			{
				models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomRight.RibbonBottomRightZPivot};

				z = {
					vertical = {
						min = -22.5;
						neutral = 0;
						max = 15;

						bodyX = {
							multiplayer = 10;
							min = -22.5;
							max = 15;
						};

						bodyRot = {
							multiplayer = -0.025;
							min = -22.5;
							max = 15;
						};
					};

					horizontal = {
						min = -22.5;
						neutral = 0;
						max = 10;

						bodyX = {
							multiplayer = 10;
							min = -22.5;
							max = 15;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomLeft.RibbonBottomLeftZPivot};

				z = {
					vertical = {
						min = -15;
						neutral = 0;
						max = 22.5;

						bodyX = {
							multiplayer = -10;
							min = -15;
							max = 22.5;
						};

						bodyRot = {
							multiplayer = 0.025;
							min = -15;
							max = 22.5;
						};
					};

					horizontal = {
						min = -22.5;
						neutral = 0;
						max = 10;

						bodyX = {
							multiplayer = 10;
							min = -22.5;
							max = 15;
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
						modelRot.x = math.min(modelRot.x, 50)
					end
					model:setRot(modelRot)
				end
			end;
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---レールガンを制御するクラス
		---@type RailGun
		RailGun = require("scripts.rail_gun")

		---Exスキルで使用するコインインスタンスのクラス
		---@type ExSkill1Coin
		ExSkill1Coin = require("scripts.ex_skill_1_coin")

		---Exスキルで使用するコインマネージャーのクラス
		---@type ExSkill1CoinManager
		ExSkill1CoinManager = require("scripts.ex_skill_1_coin_manager")
		ExSkill1CoinManager = ExSkill1CoinManager.new()

		---Exスキルで使用する水のエフェクトのクラス
		---@type ExSkill1Water
		ExSkill1Water = require("scripts.ex_skill_1_water")

		---Exスキルで使用する水のエフェクトマネージャーのクラス
		---@type ExSkill1WaterManager
		ExSkill1WaterManager = require("scripts.ex_skill_1_water_manager")
		ExSkill1WaterManager = ExSkill1WaterManager.new()

		---Exスキルで使用するキューブ状オブジェクトインスタンスのクラス
		---@type ExSkill1Cube
		ExSkill1Cube = require("scripts.ex_skill_1_cube")

		---Exスキルで使用するキューブ状オブジェクトマネージャーのクラス
		---@type ExSkill1CubeManager
		ExSkill1CubeManager = require("scripts.ex_skill_1_cube_manager")
		ExSkill1CubeManager = ExSkill1CubeManager.new()

		RailGun.init()
		RailGun:enable()
		ExSkill1CoinManager.init()
		ExSkill1WaterManager.init()
		ExSkill1CubeManager.init()
	end;
}

return BlueArchiveCharacter
