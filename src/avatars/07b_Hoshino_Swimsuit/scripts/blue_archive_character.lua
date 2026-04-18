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
---| "CLOSED2" # 閉じた目2
---| "INVERTED" # 反対側を見る目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "NARROW" # 半閉じ目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "INVERTED" # 反対側を見る目
---| "ANGRY" # 怒った目
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "NARROW" # 半閉じ目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "CLOSED" # 閉じた口
---| "W" # ω
---| "YAWN" あくび
---| "OUT_OF_BREATH" # 息切れ口
---| "TEETH" 食いしばる口
---| "SAD" # への口

---キャラクター固有の腕の状態
---@alias BlueArchiveCharacter.AdditionalArmState
---| "SHIELD_HAND" # 盾を持つ腕の状態
---| "WHALE_FLOAT" # クジラフロートに乗っているときの腕の状態

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
		avatarName = "07b_Hoshino_Swimsuit";

		birth = {
			month = 1;
			day = 2;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(6, 0); --必須
			ANGRY = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(10, 0);
			INVERTED = vectors.vec2(11, 0);
			ANGRY_INVERTED = vectors.vec2(12, 0);
			NARROW = vectors.vec2(14, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(5, 0); --必須
			ANGRY = vectors.vec2(7, 0);
			ANGRY_CENTER = vectors.vec2(8, 0);
			ANGRY_INVERTED = vectors.vec2(12, 0);
			CLOSED2 = vectors.vec2(9, 0);
			NARROW = vectors.vec2(14, 0);
			INVERTED = vectors.vec2(15, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(1, 0);
			W = vectors.vec2(2, 0);
			YAWN = vectors.vec2(3, 0);
			OPENED = vectors.vec2(0, 0);
			OUT_OF_BREATH = vectors.vec2(4, 0);
			TEETH = vectors.vec2(5, 0);
			SAD = vectors.vec2(6, 0);
		};

		emotionSet = {
			onSleep = {
				rightEye = "CLOSED";
				leftEye = "CLOSED";
				mouth = "YAWN";
			};
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				if WhaleFloat ~= nil and right == "DEFAULT" and left == "DEFAULT" then
					return {right = "WHALE_FLOAT", left = "WHALE_FLOAT"}
				elseif right == "GUN_MAIN_HAND" and left == "GUN_OFF_HAND" then
					local isLeftHanded = player:isLeftHanded()
					if (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem().id == "minecraft:shield" and isLeftHanded) then
						return {right = "GUN_MAIN_HAND", left = "SHIELD_HAND"}
					elseif WhaleFloat.isAFK then
						return {right = "DEFAULT", left = "DEFAULT"}
					end
				elseif right == "GUN_OFF_HAND" and left == "GUN_MAIN_HAND" then
					local isLeftHanded = player:isLeftHanded()
					if (player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded) then
						return {right = "SHIELD_HAND", left = "GUN_MAIN_HAND"}
					elseif WhaleFloat.isAFK then
						return {right = "DEFAULT", left = "DEFAULT"}
					end
				end
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "GUN_MAIN_HAND" then
					Arms:registerRightArmTickEvent("GUN_MAIN_HAND")
					Arms:registerRightArmRenderEvent("GUN_MAIN_HAND")
					events.RENDER:register(function ()
						if WhaleFloat.whaleFloatEnabled then
							ModelAlias.alias.avatar.rightArm:setRot(ModelAlias.alias.avatar.rightArm:getRot():add(10, 0, 0))
						end
					end, "right_arm_render")
					return true
				elseif state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded)) and Arms.armState.right == "GUN_OFF_HAND" then
							Arms:setArmState("SHIELD_HAND", nil)
						end
					end, "right_arm_tick")
					Arms:registerRightArmRenderEvent("GUN_OFF_HAND")
					events.RENDER:register(function ()
						if WhaleFloat.whaleFloatEnabled then
							ModelAlias.alias.avatar.rightArm:setRot(ModelAlias.alias.avatar.rightArm:getRot():add(10, 0, 0))
						end
					end, "right_arm_render")
					return true
				elseif state == "SHIELD_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id ~= "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id ~= "minecraft:shield" and isLeftHanded)) and Arms.armState.right == "SHIELD_HAND" then
							Arms:setArmState("GUN_OFF_HAND", nil)
						end
					end, "right_arm_tick")
					events.RENDER:register(function (delta, context)
						local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
						ModelAlias.alias.avatar.rightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 40, 30, 0))
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "GUN_MAIN_HAND" then
					Arms:registerLeftArmTickEvent("GUN_MAIN_HAND")
					Arms:registerLeftArmRenderEvent("GUN_MAIN_HAND")
					events.RENDER:register(function ()
						if WhaleFloat.whaleFloatEnabled then
							ModelAlias.alias.avatar.leftArm:setRot(ModelAlias.alias.avatar.leftArm:getRot():add(10, 0, 0))
						end
					end, "left_arm_render")
					return true
				elseif state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id == "minecraft:shield" and isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded)) and Arms.armState.left == "GUN_OFF_HAND" then
							Arms:setArmState(nil, "SHIELD_HAND")
						end
					end, "left_arm_tick")
					Arms:registerLeftArmRenderEvent("GUN_OFF_HAND")
					events.RENDER:register(function ()
						if WhaleFloat.whaleFloatEnabled then
							ModelAlias.alias.avatar.leftArm:setRot(ModelAlias.alias.avatar.leftArm:getRot():add(10, 0, 0))
						end
					end, "left_arm_render")
					return true
				elseif state == "SHIELD_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id ~= "minecraft:shield" and isLeftHanded) or (player:getHeldItem(true).id ~= "minecraft:shield" and not isLeftHanded)) and Arms.armState.left == "SHIELD_HAND" then
							Arms:setArmState(nil, "GUN_OFF_HAND")
						end
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
						ModelAlias.alias.avatar.leftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5 + 40, -30, 0))
					end, "left_arm_render")
				end;
			end;
		};
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 1.3;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-1, 0, -8);
					left = vectors.vec3(1, 0, -8);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.75, 0, -8);
					left = vectors.vec3(1.75, 0, -8);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(-3, 3.5, 3);
					left = vectors.vec3(3, 3.5, 3);
				};

				rot = {
					right = vectors.vec3(-45, -90, 0);
					left = vectors.vec3(-45, 90, 0);
				};
			};
		};

		sound = {
			name = "minecraft:entity.generic.explode";
			pitch = 2;
		};

		callbacks = {
			onMainHandChange = function (_, direction)
				if direction == "RIGHT" then
					ModelAlias.alias.avatar.body.GunBag:setPos()
					ModelAlias.alias.avatar.body.GunBag:setRot(0, 0, 45)
					ModelAlias.alias.avatar.body.GunBag.ShoulderRope:setRot(0, 0, -2.5)
					ModelAlias.alias.avatar.body.GunBag.ShoulderRope.ShoulderRopeKnob:setRot()
					ModelAlias.alias.avatar.body.GunBag.BagTop.WhaleStrap:setPos()
					ModelAlias.alias.avatar.body.GunBag.BagTop.WhaleStrap:setRot(0, 0, -45)
				else
					ModelAlias.alias.avatar.body.GunBag:setPos(6, 0, 0)
					ModelAlias.alias.avatar.body.GunBag:setRot(0, 180, -45)
					ModelAlias.alias.avatar.body.GunBag.ShoulderRope:setRot(0, 180, 1)
					ModelAlias.alias.avatar.body.GunBag.ShoulderRope.ShoulderRopeKnob:setRot(0, 180, 0)
					ModelAlias.alias.avatar.body.GunBag.BagTop.WhaleStrap:setPos(0, 0, 2.3)
					ModelAlias.alias.avatar.body.GunBag.BagTop.WhaleStrap:setRot(0, 180, -45)
				end
			end;
		};
	};

	placementObjects = {

	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.lowerBody.WhaleFloat, models.models.ex_skill_1.Waves};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-15, -150, 0);
					pos = vectors.vec3(-54, 100.6, -147.4);
				};

				---Exスキルアニメーション終了時
				fin = {
					rot = vectors.vec3(-15, -180, 30);
					pos = vectors.vec3(-248, 17.6, -340.6);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						for _, modelPart in ipairs({models.models.ex_skill_1.Waves.Surface, models.models.ex_skill_1.Waves.Wave1}) do
							modelPart:setPrimaryTexture("RESOURCE", "textures/block/water_still.png")
						end
						models.models.ex_skill_1.Waves.Wave2:setPrimaryTexture("RESOURCE", "textures/block/water_flow.png")
						self.exSkill.primary.isInitialized = true
					end
					self.exSkill.primary.resetExSkill2Feature()
					models.models.ex_skill_1.Waves:setColor(world.getBiome(player:getPos()):getWaterColor())
					FaceParts:setEmotion("NORMAL", "NORMAL", "W", 13, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 3 then
						local modelPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Waves.Wave1):add(0, 7, 0)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 500 do
							local offset = vectors.vec3(math.random() * 32 - 16, 0, math.random() * 5)
							local particleOffset = offset:copy()
							particleOffset.x = particleOffset.x * (math.random() * 0.025 + 0.025)
							particleOffset.y = 0.25
							particleOffset.z = (particleOffset.z - 2.5) * (math.random() * 0.025 + 0.025)
							particles:newParticle("minecraft:dust 1 1 1 1", modelPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, offset, 0, 1, 0))):setScale(3):setColor(1, 1, 1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, particleOffset, 0, 1, 0)):setGravity(1):setLifetime(40)
						end
						sounds:playSound("minecraft:item.bucket.empty", modelPos, 1, 0.5)
					elseif tick == 13 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 29, true)
					elseif tick == 39 then
						sounds:playSound("minecraft:entity.generic.splash", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
					elseif tick == 42 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "W", 13, true)
					elseif tick == 52 then
						sounds:playSound("minecraft:entity.generic.swim", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
					elseif tick == 55 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "W", 13, true)
					elseif tick == 68 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 2, true)
					elseif tick == 70 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 12, true)
						sounds:playSound("minecraft:entity.generic.swim", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
					elseif tick == 82 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 4, true)
					elseif tick == 85 then
						FaceParts:setEmotion("INVERTED", "CLOSED", "OPENED", 28, true)
					elseif tick == 86 then
						sounds:playSound("minecraft:item.bucket.empty", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
					end

					if tick >= 8 and tick < 28 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Waves.Wave2.Wave2ParticleAnchor)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 20 do
							particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 32 - 16, 0, 0, 0, 1, 0))):setScale(3):setColor(1, 1, 1):setVelocity(math.random() * 0.2 - 0.1, 0.5, math.random() * 0.2 - 0.1):setGravity(1):setLifetime(20)
						end
						sounds:playSound("minecraft:item.bucket.empty", anchorPos, 1, 0.5)
					elseif tick >= 41 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor1)
						local dirVector = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor2):sub(anchorPos):normalize()
						local YVector = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.WhaleFloat.WhaleParticleAnchor3):sub(anchorPos):normalize()
						for _ = 1, 20 do
							local particleDirection = math.random() * 60 - 30
							particleDirection = particleDirection > 0 and particleDirection + 30 or particleDirection - 30
							particles:newParticle("minecraft:dust 1 1 1 1", anchorPos):setScale(2):setColor(1, 1, 1):setVelocity(vectors.rotateAroundAxis(particleDirection, dirVector, YVector):add(YVector:copy():scale(math.random())):normalize():scale(0.5)):setGravity(0.5):setLifetime(10)
						end
						if tick % 2 == 0 then
							sounds:playSound("minecraft:item.bucket.empty", anchorPos, 0.1, 0.5)
						end
					end

					if tick % 2 == 0 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Waves.Surface, models.models.ex_skill_1.Waves.Wave1}) do
							modelPart:setUVPixels(0, modelPart:getUVPixels().y + 16)
						end
					end
					models.models.ex_skill_1.Waves.Wave2:setUVPixels(0, models.models.ex_skill_1.Waves.Wave2.Wave2:getUVPixels().y + 16)
				end;

				onPostTransition = function (self, forcedStop)
					if not forcedStop then
						local playerPos = player:getPos()
						for i = 1, 6 do
							for j = 0, 35 do
								particles:newParticle("minecraft:dust 1 1 1 1", playerPos):setScale(2):setColor(1, 1, 1):setVelocity(vectors.rotateAroundAxis(j * 12, 0, -0.25, i * 0.05, 0, 1, 0)):setPower(0.25):setColor((i - 1) * 0.2, 1, 1)
							end
						end
						ExSkill1WaveParticleManager:play()
						sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.5)
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.RashGuardB, ModelAlias.alias.avatar.rightArm.RashGuardRA, ModelAlias.alias.avatar.rightArmBottom.RashGuardRAB, ModelAlias.alias.avatar.leftArm.RashGuardLA, ModelAlias.alias.avatar.leftArmBottom.RashGuardLAB, ModelAlias.alias.avatar.rightLeg.RashGuardRL, ModelAlias.alias.avatar.leftLeg.RashGuardLL}) do
							modelPart:setVisible(false)
						end
						ModelAlias.alias.avatar.head.Glasses:setPos(0, -4, 0)
						self.exSkill.primary.costumeChangeTimer = 1000
						events.TICK:register(function ()
							if not client:isPaused() then
								if self.exSkill.primary.costumeChangeTimer == 0 then
									self.exSkill.primary.resetExSkill2Feature()
								end
								self.exSkill.primary.costumeChangeTimer = self.exSkill.primary.costumeChangeTimer - 1
							end
						end, "ex_skill_1_post_tick")
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			init = false;

			---Exスキル2で衣装を変化させる時間を測るタイマー
			---@type integer
			costumeChangeTimer = 1000;

			---Exスキル2の衣装変化機能をリセットする
			resetExSkill2Feature = function ()
				for _, modelPart in ipairs({ModelAlias.alias.avatar.body.RashGuardB, ModelAlias.alias.avatar.rightArm.RashGuardRA, ModelAlias.alias.avatar.rightArmBottom.RashGuardRAB, ModelAlias.alias.avatar.leftArm.RashGuardLA, ModelAlias.alias.avatar.leftArmBottom.RashGuardLAB, ModelAlias.alias.avatar.rightLeg.RashGuardRL, ModelAlias.alias.avatar.leftLeg.RashGuardLL}) do
					modelPart:setVisible(true)
				end
				ModelAlias.alias.avatar.head.Glasses:setPos()
				events.TICK:remove("ex_skill_1_post_tick")
			end;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onAltChange = function (_, isAlt)
				ModelAlias.alias.avatar.head.CMaskedH:setVisible(isAlt)
				for _, modelPart in ipairs({ModelAlias.alias.avatar.head.HairEnds, ModelAlias.alias.avatar.body.Hairs}) do
					modelPart:setVisible(not isAlt)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "W", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "YAWN", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "W", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "YAWN", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SAD", duration, true)
					end
				end
			end;

			onStop = function(_, _, forcedStop)
				if forcedStop then
					FaceParts:resetEmotion()
				end
			end
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
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.head.HairTails.HairTailLeft.HairLeftBottom, ModelAlias.alias.dummy_avatar.head.HairTails.HairTailRight.HairRightBottom}) do
					modelPart:setRot(25, 0, 0)
				end
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.HairTailLeft.HairLeftBottom:setRot(-15, 0, 30)
				ModelAlias.alias.dummy_avatar.head.HairTails.HairTailRight.HairRightBottom:setRot(-15, 0, -10)
			end;

			onBeforeModelCopy = function (self)
				ModelAlias.alias.avatar.lowerBody.WhaleFloat:setVisible(false)
				self.deathAnimation.hasShield = HoshinoShield.hasShield
				if self.deathAnimation.hasShield then
					HoshinoShield:setShield(false, false)
				end
			end;

			onAfterModelCopy = function (self)
				if self.deathAnimation.hasShield then
					HoshinoShield:setShield(true, false)
				end
			end;
		};

		---盾を持っているかどうか
		---@type boolean
		hasShield = false;
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = true;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.Cowlick};

				x = {
					vertical = {
						min = -30;
						neutral = -20;
						max = 0;

						bodyY = {
							multiplayer = -40;
							min = -30;
							max = 0;
						};
					};

					horizontal = {
						min = -30;
						neutral = -20;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 150;
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
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailLeft.HairLeftBottom};

				x = {
					vertical = {
						min = -165;
						neutral = 0;
						max = 10;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -82.5;
							max = 10;
						};

						headRot = {
							multiplayer = 0.05;
							min = -82.5;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -165;
							max = 7.5;
						};
					};

					horizontal = {
						min = -155;
						neutral = -45;
						max = -45;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailLeft.HairLeftBottom.HairLeftBottomZ};

				z = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 100;

						headZ = {
							multiplayer = -80;
							min = -80;
							max = 100;
						};
					};

					horizontal = {
						min = -80;
						neutral = 0;
						max = 100;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailRight.HairRightBottom};

				x = {
					vertical = {
						min = -165;
						neutral = 0;
						max = 10;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -82.5;
							max = 10;
						};

						headRot = {
							multiplayer = 0.05;
							min = -82.5;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -165;
							max = 7.5;
						};
					};

					horizontal = {
						min = -155;
						neutral = -45;
						max = -45;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailRight.HairRightBottom.HairRightBottomZ};

				z = {
					vertical = {
						min = -100;
						neutral = 0;
						max = 80;

						headZ = {
							multiplayer = -80;
							min = -100;
							max = 80;
						};
					};

					horizontal = {
						min = -100;
						neutral = -20;
						max = 80;
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---盾を制御するクラス
		---@type HoshinoShield
		HoshinoShield = require("scripts.hoshino_shield")

		---クジラフロートを制御するクラス
		---@type WhaleFloat
		WhaleFloat = require("scripts.whale_float")

		---Exスキル1のパーティクルインスタンスのクラス
		---@type ExSkill1Particle
		ExSkill1WaveParticle = require("scripts.ex_skill_1_wave_particle")

		---Exスキル1のパーティクルマネージャーのクラス
		---@type ExSkill1ParticleManager
		ExSkill1WaveParticleManager = require("scripts.ex_skill_1_wave_particle_manager")
		ExSkill1WaveParticleManager = ExSkill1WaveParticleManager.new()

		HoshinoShield:init()
		WhaleFloat:enable()
	end;
}

return BlueArchiveCharacter
