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
---| "HALF" # 半分目
---| "ANGRY" # 怒った目
---| "CENTER" # 少し反対側を見る目
---| "NARROW_CENTER" # 少し閉じつつ少し反対側を見る目
---| "NARROW_ANGRY_CENTER" # 少し閉じつつ怒りつつ少し反対側を見る目
---| "NARROW_ANGRY" # 少し閉じつつ怒った目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "HALF" # 半分目
---| "ANGRY" # 怒った目
---| "NARROW" # 少し閉じた目
---| "NARROW_ANGRY" # 少し閉じつつ怒った目
---| "CENTER" # 少し反対側を見る目
---| "NARROW_ANGRY_INVERTED" # 少し閉じつつ怒りつつ反対側を見る目
---| "INVERTED" # 反対側を見る目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "TRIANGLE" # 三角口
---| "ANGRY" # への口
---| "CLOSED" # 閉じた口
---| "CLOSED2" # 閉じた口2

---キャラクター固有の腕の状態
---@alias BlueArchiveCharacter.AdditionalArmState
---| "DRONE_HOLD" # ドローンに捕まっている時の腕
---| "DRONE" # ドローン飛行中の腕
---| "BICYCLE" # 自転車に乗っている時の腕
---| "BICYCLE_GUN" # 自転車に乗りながら銃を構える腕
---| "BICYCLE_AWAIT" # 自転車で待機中の腕

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
		avatarName = "06b_Shiroko_Swimsuit";

		birth = {
			month = 5;
			day = 16;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(6, 0); --必須
			CLOSED2 = vectors.vec2(7, 0);
			HALF = vectors.vec2(8, 0);
			ANGRY = vectors.vec2(10, 0);
			CENTER = vectors.vec2(12, 0);
			NARROW_CENTER = vectors.vec2(13, 0);
			NARROW_ANGRY_CENTER = vectors.vec2(15, 0);
			NARROW_ANGRY = vectors.vec2(18, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(5, 0); --必須
			CLOSED2 = vectors.vec2(6, 0);
			HALF = vectors.vec2(8, 0);
			ANGRY = vectors.vec2(10, 0);
			NARROW = vectors.vec2(13, 0);
			NARROW_ANGRY = vectors.vec2(15, 0);
			CENTER = vectors.vec2(16, 0);
			NARROW_ANGRY_INVERTED = vectors.vec2(18, 0);
			INVERTED = vectors.vec2(19, 0);
			ANGRY_INVERTED = vectors.vec2(20, 0);
		};

		mouth = {
			TRIANGLE = vectors.vec2(0, 0);
			ANGRY = vectors.vec2(1, 0);
			CLOSED = vectors.vec2(2, 0);
			CLOSED2 = vectors.vec2(3, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				if left == "GUN_OFF_HAND" and right == "GUN_MAIN_HAND" then
					if Drone.dronePosition ~= "NONE" then
						return {right = "GUN_MAIN_HAND", left = "DRONE_HOLD"}
					elseif Bicycle.bicycleEnabled then
						return {right = "BICYCLE_GUN", left = "BICYCLE"}
					end
				elseif left == "GUN_MAIN_HAND" and right == "GUN_OFF_HAND" then
					if Drone.dronePosition ~= "NONE" then
						return {right = "DRONE_HOLD", left = "GUN_MAIN_HAND"}
					elseif Bicycle.bicycleEnabled then
						return {right = "BICYCLE", left = "BICYCLE_GUN"}
					end
				elseif left == "DEFAULT" and right == "DEFAULT" then
					if Drone ~= nil and Bicycle ~= nil then
						if Drone.dronePosition == "RIGHT" then
							return {right = "DRONE", left = "DRONE_HOLD"}
						elseif Drone.dronePosition == "LEFT" then
							return {right = "DRONE_HOLD", left = "DRONE"}
						elseif Bicycle.bicycleEnabled then
							return {right = "BICYCLE", left = "BICYCLE"}
						end
					end
				end
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "GUN_MAIN_HAND" then
					events.RENDER:register(function (_, context)
						local isLeftHanded = player:isLeftHanded()
						if Drone.dronePosition == "RIGHT" and isLeftHanded then
							local isSwingingArm = player:isSwingingArm() and isLeftHanded
							ModelAlias.alias.avatar.rightArm:setParentType(context == "FIRST_PERSON" and "RightArm" or (isSwingingArm and "LeftArm" or "Body"))
							if isSwingingArm then
								ModelAlias.alias.avatar.rightArm:setRot()
							end
						end
					end, "right_arm_render")
				elseif state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						if Bicycle.bicycleEnabled and animations["models.main"]["bicycle_idle"]:getTime() * 4 > 0 then
							Arms:setArmState("BICYCLE", nil)
						end
					end, "right_arm_tick")
					Arms:registerRightArmRenderEvent("GUN_OFF_HAND")
					return true
				elseif state == "DRONE_HOLD" then
					--ドローンに掴まる腕
					events.RENDER:register(function (_, context)
						ModelAlias.alias.avatar.rightArm:setParentType(context == "FIRST_PERSON" and "RightArm" or "Body")
					end, "right_arm_render")
				elseif state == "DRONE" then
					--ドローンぶら下がり
					local isHoldingItem = false
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						isHoldingItem = (player:isLeftHanded() and player:getHeldItem(true).id or player:getHeldItem(false).id) ~= "minecraft:air"
					end, "right_arm_tick")
					events.RENDER:remove("right_arm_render")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						local isUsingSpyglass = player:getActiveItem().id == "minecraft:spyglass" and ((activeHand == "MAIN_HAND" and not isLeftHanded) or (activeHand == "OFF_HAND" and isLeftHanded))
						local isSwingingArm = (player:isSwingingArm() and not isLeftHanded) or isUsingSpyglass
						ModelAlias.alias.avatar.rightArm:setParentType((context == "FIRST_PERSON" or isSwingingArm) and "RightArm" or "Body")
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3((isHoldingItem and not isUsingSpyglass) and 20 or 0, 0, 0) or vectors.vec3(isHoldingItem and 20 or 0, 0, 10 + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5))
					end, "right_arm_render")
				elseif state == "BICYCLE" then
					--自転車
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if animations["models.main"]["bicycle_idle"]:getTime() * 4 == 0 then
							Arms:setArmState(Gun.currentGunPosition == "LEFT" and "GUN_OFF_HAND" or "BICYCLE_AWAIT", nil)
						end
					end, "right_arm_tick")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						local isUsingSpyglass = player:getActiveItem().id == "minecraft:spyglass" and ((activeHand == "MAIN_HAND" and not isLeftHanded) or (activeHand == "OFF_HAND" and isLeftHanded))
						local isSwingingArm = (player:isSwingingArm() and not isLeftHanded) or isUsingSpyglass
						ModelAlias.alias.avatar.rightArm:setParentType((context == "FIRST_PERSON" or isSwingingArm) and "RightArm" or "Body")
						local bicycleIdleFactor = 1 - animations["models.main"]["bicycle_idle"]:getTime() * 4
						local currentHandleRot = (Bicycle.handleRot - Bicycle.handleRotPrev) * delta + Bicycle.handleRot
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3(isUsingSpyglass and 40 or 20, 0, 0) or vectors.vec3(50 * (1 - bicycleIdleFactor) + 20, 8 * (1 - bicycleIdleFactor) + 8 * (currentHandleRot / 15), 0))
					end, "right_arm_render")
				elseif state == "BICYCLE_GUN" then
					--自転車で銃を持っているとき
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if player:isSwingingArm() and not player:isLeftHanded() then
							ModelAlias.alias.avatar.rightArm:setParentType("RightArm")
						else
							ModelAlias.alias.avatar.rightArm:setParentType("Body")
						end
						if player:getActiveItem().id == "minecraft:crossbow" then
							Arms:setArmState("CROSSBOW", "CROSSBOW")
						end
					end, "right_arm_tick")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local bicycleIdleFactor = 1 - animations["models.main"]["bicycle_idle"]:getTime() * 4
						ModelAlias.alias.avatar.rightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3(60, 0, 0) or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + (1 - bicycleIdleFactor) * 35 + 105, headRot.y, 0))
					end, "right_arm_render")
				elseif state == "BICYCLE_AWAIT" then
					--自転車で待機中
					events.TICK:register(function ()
						if animations["models.main"]["bicycle_idle"]:getTime() * 4 > 0 then
							Arms:setArmState("BICYCLE", nil)
						end
					end, "right_arm_tick")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "GUN_MAIN_HAND" then
					events.RENDER:register(function (_, context)
						local isLeftHanded = player:isLeftHanded()
						if Drone.dronePosition == "LEFT" and not isLeftHanded then
							local isSwingingArm = player:isSwingingArm() and not isLeftHanded
							ModelAlias.alias.avatar.leftArm:setParentType(context == "FIRST_PERSON" and "LeftArm" or (isSwingingArm and "RightArm" or "Body"))
							if isSwingingArm then
								ModelAlias.alias.avatar.leftArm:setRot()
							end
						end
					end, "left_arm_render")
				elseif state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						if Bicycle.bicycleEnabled and animations["models.main"]["bicycle_idle"]:getTime() * 4 > 0 then
							Arms:setArmState(nil, "BICYCLE")
						end
					end, "left_arm_tick")
					Arms:registerLeftArmRenderEvent("GUN_OFF_HAND")
					return true
				elseif state == "DRONE_HOLD" then
					--ドローンに掴まる腕
					events.RENDER:register(function (_, context)
						ModelAlias.alias.avatar.leftArm:setParentType(context == "FIRST_PERSON" and "LeftArm" or "Body")
					end, "left_arm_render")
				elseif state == "DRONE" then
					--ドローンぶら下がり
					local isHoldingItem = false
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						isHoldingItem = (player:isLeftHanded() and player:getHeldItem(false).id or player:getHeldItem(true).id) ~= "minecraft:air"
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						local isUsingSpyglass = player:getActiveItem().id == "minecraft:spyglass" and ((activeHand == "MAIN_HAND" and isLeftHanded) or (activeHand == "OFF_HAND" and not isLeftHanded))
						local isSwingingArm = (player:isSwingingArm() and isLeftHanded) or isUsingSpyglass
						ModelAlias.alias.avatar.leftArm:setParentType((context == "FIRST_PERSON" or isSwingingArm) and "LeftArm" or "Body")
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3((isHoldingItem and not isUsingSpyglass) and 20 or 0, 0, 0) or vectors.vec3(isHoldingItem and 20 or 0, 0, -10 + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5))
					end, "left_arm_render")
				elseif state == "BICYCLE" then
					--自転車
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if animations["models.main"]["bicycle_idle"]:getTime() * 4 == 0 then
							Arms:setArmState(nil, Gun.CurrentGunPosition == "RIGHT" and "GUN_OFF_HAND" or "BICYCLE_AWAIT")
						end
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						local isUsingSpyglass = player:getActiveItem().id == "minecraft:spyglass" and ((activeHand == "MAIN_HAND" and isLeftHanded) or (activeHand == "OFF_HAND" and not isLeftHanded))
						local isSwingingArm = (player:isSwingingArm() and isLeftHanded) or isUsingSpyglass
						ModelAlias.alias.avatar.leftArm:setParentType((context == "FIRST_PERSON" or isSwingingArm) and "LeftArm" or "Body")
						local bicycleIdleFactor = 1 - animations["models.main"]["bicycle_idle"]:getTime() * 4
						local currentHandleRot = (Bicycle.handleRot - Bicycle.handleRotPrev) * delta + Bicycle.handleRot
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3(isUsingSpyglass and 40 or 20, 0, 0) or vectors.vec3(50 * (1 - bicycleIdleFactor) + 20, -8 * (1 - bicycleIdleFactor) + 8 * (currentHandleRot / 15), 0))
					end, "left_arm_render")
				elseif state == "BICYCLE_GUN" then
					--自転車で銃を持っているとき
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						if player:isSwingingArm() and player:isLeftHanded() then
							ModelAlias.alias.avatar.leftArm:setParentType("LeftArm")
						else
							ModelAlias.alias.avatar.leftArm:setParentType("Body")
						end
						if player:getActiveItem().id == "minecraft:crossbow" then
							Arms:setArmState("CROSSBOW", "CROSSBOW")
						end
					end, "left_arm_tick")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local bicycleIdleFactor = 1 - animations["models.main"]["bicycle_idle"]:getTime() * 4
						ModelAlias.alias.avatar.leftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3(60, 0, 0) or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5 + (1 - bicycleIdleFactor) * 35 + 105, headRot.y, 0))
					end, "left_arm_render")
				elseif state == "BICYCLE_AWAIT" then
					--自転車で待機中
					events.TICK:register(function ()
						if animations["models.main"]["bicycle_idle"]:getTime() * 4 > 0 then
							Arms:setArmState(nil, "BICYCLE")
						end
					end, "left_arm_tick")
				end
			end;
		};
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 1.4;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-1.5, 0, -4);
					left = vectors.vec3(1.5, 0, -4);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.5, -0.5, -3);
					left = vectors.vec3(1.5, -0.5, -3);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, 2, 2.75);
					left = vectors.vec3(0, 2, 2.75);
				};

				rot = {
					right = vectors.vec3(-135, -90, 0);
					left = vectors.vec3(-135, 90, 0);
				};
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

			models = {ModelAlias.alias.avatar.rightArmBottom.FishingRod};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 160, 0);
					pos = vectors.vec3(13, 34, -33);
				};

				fin = {
					rot = vectors.vec3(-10, 160, 0);
					pos = vectors.vec3(-12, 36, -61);
				};
			};

			callbacks = {
				onPreTransition = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.UnderWater:setLight(15)
						models.models.ex_skill_1.Stage.Reef:setPrimaryTexture("RESOURCE", "textures/block/stone.png")
						models.models.ex_skill_1.Stage.Ocean:setPrimaryTexture("RESOURCE", "textures/block/water_still.png")
						self.exSkill.primary.isInitialized = true
					end
					models.models.ex_skill_1.Stage.Ocean:setColor(world.getBiome(player:getPos()):getWaterColor())
					models.models.ex_skill_1.Stage:setVisible(true)
					ModelAlias.alias.avatar.root:setPos(0, 8, 0)
				end;

				onPreAnimation = function (self)
					ModelAlias.alias.avatar.root:setPos()
					FaceParts:setEmotion("CENTER", "NORMAL", "CLOSED", 107, true)
					if host:isHost() then
						local windowSize = client:getWindowSize()
						models.models.ex_skill_1.UnderWater.ForCameraOffset.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(23))
						local bodyYaw = player:getBodyYaw()
						local backgroundPos = vectors.rotateAroundAxis(bodyYaw + 180, vectors.rotateAroundAxis(bodyYaw * -1 + 180, self.exSkill.primary.camera.start.pos, 0, 1, 0):add(client:getCameraDir()), 0, 1, 0):scale(16 / 0.9375)
						models.models.ex_skill_1.UnderWater:setOffsetPivot(backgroundPos)
						models.models.ex_skill_1.UnderWater.ForCameraOffset:setPos(backgroundPos)
						events.RENDER:register(function (_, context)
							models.models.ex_skill_1.UnderWater:setVisible(context == "RENDER")
						end, "ex_skill_1_render")
						sounds:playSound("minecraft:block.bubble_column.upwards_inside", player:getPos(), 1, 0.5)
					end
				end;

				onAnimationTick = function (_, tick)
					if tick <= 28 and host:isHost() then
						local finPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.UnderWater.ForCameraOffset.Tuna.RearBody.TailFin)
						for _ = 1, 5 do
							particles:newParticle("minecraft:underwater", finPos:copy():add(math.random() * 0.1 - 0.05, math.random() * 0.1 - 0.05, 0)):setScale(0.2)
						end
					elseif tick >= 37 and tick < 73 and host:isHost() then
						local headPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.UnderWater.ForCameraOffset.Tuna.FrontBody.Head)
						local tunaRotY = models.models.ex_skill_1.UnderWater.ForCameraOffset.Tuna:getAnimRot().y
						local cameraRotY = renderer:getCameraRot().y
						local particleCount = math.max(tick - 52, 0)
						for i = 0, 2 * math.pi, math.pi / 6 do
							particles:newParticle("minecraft:dust 1 1 1 1", vectors.rotateAroundAxis(tunaRotY + cameraRotY, 0, math.cos(i) * 0.3, math.sin(i) * 0.3, 0, 1, 0):add(headPos)):setScale(particleCount / 27 + 1):setColor(math.random() * 0.5 + 0.5, 1, 1):setVelocity(vectors.rotateAroundAxis(tunaRotY - cameraRotY - 90, 0, 0, 0.1, 0, 1, 0)):setLifetime(20)
						end
						sounds:playSound("minecraft:entity.squid.ambient", player:getPos(), 1, 0.75)
					elseif tick == 78 and host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						models.models.ex_skill_1.UnderWater:setVisible(false)
					elseif tick == 107 then
						FaceParts:setEmotion("NARROW_CENTER", "NARROW", "CLOSED", 27, true)
					elseif tick == 134 then
						FaceParts:setEmotion("NARROW_ANGRY_CENTER", "NARROW_ANGRY", "TRIANGLE", 16, true)
					elseif tick == 139 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
						if host:isHost() then
							local windowSize = client:getWindowSize()
							models.models.ex_skill_1.Flash.ForCameraOffset2.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(22.5))
							local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw() + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy()), 0, 1, 0):scale(16 / 0.9375)
							models.models.ex_skill_1.Flash:setOffsetPivot(backgroundPos)
							models.models.ex_skill_1.Flash.ForCameraOffset2:setPos(backgroundPos)
							models.models.ex_skill_1.Flash:setVisible(true)
						end
					elseif tick == 148 and host:isHost() then
						models.models.ex_skill_1.Flash:setVisible(false)
					elseif tick == 150 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 8, true)
						if host:isHost() then
							renderer:setPostEffect("phosphor")
						end
					elseif tick == 157 then
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.5, 2)
					elseif tick == 158 then
						FaceParts:setEmotion("CENTER", "NORMAL", "CLOSED", 48, true)
					elseif tick >= 160 and tick <= 170 and host:isHost() then
						local cameraPos = renderer:getCameraOffsetPivot()
						for i = 0, 8 do
							particles:newParticle("minecraft:dust 1 1 1 1", cameraPos:copy():add(player:getPos()):add((i % 3 - 1) * 0.25, 1.25, (math.floor(i / 3) - 1) * 0.25)):setScale(3):setColor(math.random() * 0.5 + 0.5, 1, 1):setVelocity(0, 0.25, 0):setLifetime(5)
						end
						if tick == 160 then
							local playerPos = player:getPos()
							sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.25)
							sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.5)
						elseif tick == 170 then
							renderer:setPostEffect()
						end
					elseif tick == 175 then
						models.models.ex_skill_1.UnderWater.ForCameraOffset.Tuna:moveTo(models.models.ex_skill_1)
						local playerPos = player:getPos()
						sounds:playSound("minecraft:entity.generic.splash", playerPos, 1, 0.5)
						sounds:playSound("minecraft:ambient.underwater.exit", playerPos, 0.5, 0.5)
					elseif tick == 180 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Tuna)
						for _ = 1, 50 do
							particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy()):setVelocity(vectors.rotateAroundAxis(player:getBodyYaw() * -1, math.random() * 0.2, math.random() * 0.25 + 0.125, math.random() * 0.2 - 0.1, 0, 1, 0)):setScale(3):setColor(math.random() * 0.5 + 0.5, 1, 1):setGravity(0.5):setLifetime(25)
						end
					end
					if tick % 35 == 24 and tick <= 160 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stage.Reef.ExSkill2ParticleAnchor)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 50 do
							local particleOffset = math.random()
							particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, particleOffset - 0.5, 0, 0, 0, 1, 0))):setScale(5):setColor(1, 1, 1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, particleOffset * 0.5 - 0.25, math.random() * 0.5 + 0.25, math.random() * 0.25 - 0.125, 0, 1, 0)):setGravity(1):setLifetime(40)
						end
						if tick >= 80 or not host:isHost() then
							local playerPos = player:getPos()
							sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.25)
							sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.5)
						end
					end
					if tick <= 139 or tick % 2 == 0 then
						local currentFrame = models.models.ex_skill_1.Stage.Ocean:getUVPixels().y / 16
						if currentFrame < 31 then
							models.models.ex_skill_1.Stage.Ocean:setUVPixels(0, (currentFrame + 1) * 16)
						else
							models.models.ex_skill_1.Stage.Ocean:setUVPixels()
						end
					end
					if (tick >= 83 and tick < 110) or (tick >= 110 and tick <= 130 and tick % 2 == 0) then
						sounds:playSound("minecraft:block.dispenser.fail", player:getPos(), 0.5, 5)
					end
				end;

				onPostAnimation = function (_, forcedStop)
					if models.models.ex_skill_1.Tuna ~= nil then
						models.models.ex_skill_1.Tuna:moveTo(models.models.ex_skill_1.UnderWater.ForCameraOffset)
					end
					if forcedStop and host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						for _, modelPart in ipairs({models.models.ex_skill_1.UnderWater, models.models.ex_skill_1.Flash}) do
							modelPart:setVisible(false)
						end
						renderer:setPostEffect()
					elseif not forcedStop then
						ModelAlias.alias.avatar.root:setPos(0, 8, 0)
					end
				end;

				onPostTransition = function ()
					models.models.ex_skill_1.Stage:setVisible(false)
					ModelAlias.alias.avatar.root:setPos()
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.HairTail:setVisible(not isVisible)
				end
			end
		};
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "CLOSED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL","NORMAL", "ANGRY", duration, true)
					elseif type == "SWEAT" then
						if not Bicycle.isTyreBurst then
							FaceParts:setEmotion("NARROW_ANGRY", "NARROW_ANGRY", "ANGRY", duration, true)
						else
							FaceParts:setEmotion("SURPRISED", "SURPRISED", "ANGRY", 60, true)
						end
					end
				end
			end;

			onStop = function(_, _, forcedStop)
				if not forcedStop then
					FaceParts:resetEmotion();
				end
			end;
		};
	};

	headModel = {
		callbacks = {
			onBeforeModelCopy = function ()
				ModelAlias.alias.avatar.head:setRot()
			end;
		};
	};

	headBlock = {
		includeModels = {};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onBeforeModelCopy = function ()
				if ModelAlias.alias.avatar.root.Drone ~= nil then
					ModelAlias.alias.avatar.root.Drone:setVisible(false)
				end
			end;

			onAfterModelCopy = function ()
				if ModelAlias.alias.avatar.root.Drone ~= nil then
					ModelAlias.alias.avatar.root.Drone:setVisible(true)
				end
			end;

			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.Ears.RightEarPivot:setRot(-49.02, -11.44, -9.77)
				ModelAlias.alias.dummy_avatar.head.Ears.LeftEarPivot:setRot(-49.02, 11.44, 9.77)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = true;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.HairTail};

				x = {
					vertical = {
						min = -140;
						neutral = 0;
						max = 0;

						headRotMultiplayer = -1;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -140;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTail.HairTailZPivot};

				z = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						bodyZ = {
							multiplayer = -80;
							min = -90;
							max = 90;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---視覚的なミサイルオブジェクトのインスタンスクラス
		---@type DroneMissile
		DroneMissile = require("scripts.drone_missile")

		---視覚的なミサイルオブジェクトのマネージャークラス
		---@type DroneMissileManager
		DroneMissileManager = require("scripts.drone_missile_manager")
		DroneMissileManager = DroneMissileManager.new()

		---ドローンを制御するクラス
		Drone = require("scripts.drone")

		---自転車を制御するクラス
		Bicycle = require("scripts.bicycle")

		DroneMissileManager:init()
		Drone:init()
		Bicycle:init()
	end;
}

return BlueArchiveCharacter
