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
		avatarName = "07c_Hoshino_Battle";

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
				if right == "GUN_MAIN_HAND" and left == "GUN_OFF_HAND" then
					local isLeftHanded = player:isLeftHanded()
					if (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem().id == "minecraft:shield" and isLeftHanded) then
						return {right = "GUN_MAIN_HAND", left = "SHIELD_HAND"}
					end
				elseif right == "GUN_OFF_HAND" and left == "GUN_MAIN_HAND" then
					local isLeftHanded = player:isLeftHanded()
					if (player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded) then
						return {right = "SHIELD_HAND", left = "GUN_MAIN_HAND"}
					end
				end
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded)) and Arms.armState.right == "GUN_OFF_HAND" then
							Arms:setArmState("SHIELD_HAND", nil)
						elseif SubGun.hasSubGun then
							Arms:setArmState("GUN_MAIN_HAND", "GUN_MAIN_HAND")
						end
					end, "right_arm_tick")
					Arms:registerRightArmRenderEvent("GUN_OFF_HAND")
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
				if state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id == "minecraft:shield" and isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded)) and Arms.armState.left == "GUN_OFF_HAND" then
							Arms:setArmState(nil, "SHIELD_HAND")
						elseif SubGun.hasSubGun then
							Arms:setArmState("GUN_MAIN_HAND", "GUN_MAIN_HAND")
						end
					end, "left_arm_tick")
					Arms:registerLeftArmRenderEvent("GUN_OFF_HAND")
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
	};

	placementObjects = {

	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_1.Illagers};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, -123, 0);
					pos = vectors.vec3(96.8, 40.4, -27);
				};
				fin = {
					rot = vectors.vec3(-10, -155, -10);
					pos = vectors.vec3(-9, 14.9, -30);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.Illagers.Ravager:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/illager/ravager.png")
						for index, modelPart in ipairs({models.models.ex_skill_1.Illagers.Ravager.Pillager1, models.models.ex_skill_1.Illagers.Pillager2}) do
							modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/illager/pillager.png")
							modelPart["P"..index.."RightArm"]:newItem("pillager_"..index.."_crossbow"):setItem("minecraft:crossbow"):setPos(0, -15, -2.5):setRot(0, 0, -135)
						end
						for i = 1, 2 do
							models.models.ex_skill_1.Illagers["Vindicator"..i]:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/illager/vindicator.png")
							models.models.ex_skill_1.Illagers["Vindicator"..i]["V"..i.."RightArm"]:newItem("vindicator_"..i.."_iron_axe"):setItem("minecraft:iron_axe"):setPos(1, -9, -5):setRot(-90, -45, -90)
						end
						models.models.ex_skill_1.Firework:setPrimaryTexture("RESOURCE", "minecraft:textures/item/firework_rocket.png")
						self.exSkill.primary.isInitialized = true
					end
					FaceParts:setEmotion("ANGRY", "ANGRY", "OUT_OF_BREATH", 20, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.body.SubGun:setPos(-1, 17.5, -1.9)
						ModelAlias.alias.avatar.body.SubGun:setRot(-30, 90, 0)
						ModelAlias.alias.avatar.body.SubGun:setScale()
						ModelAlias.alias.avatar.body.SubGun:setParentType("None")
					elseif tick == 1 then
						sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.5, 0.5)
					elseif tick == 13 then
						sounds:playSound("minecraft:block.chest.locked", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.Shield), 0.5, 2)
					elseif tick == 14 then
						ModelAlias.alias.avatar.body.Shield.Section2.ShoulderBelt:setVisible(false)
						ModelUtils.moveTo(ModelAlias.alias.avatar.body.Shield, ModelAlias.alias.avatar.leftArmBottom, ModelAlias.alias.avatar.body)
					elseif tick == 19 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root):add(0, 0.25, 0)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 10 do
							local offset = vectors.vec3(math.random() * 1 - 0.5, 0, math.random() * 1 - 0.5)
							particles:newParticle("minecraft:campfire_cosy_smoke", anchorPos:copy():add(offset)):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, -0.1, 0, offset.z * -0.1, 0, 1, 0)):setLifetime(20)
						end
					elseif tick == 20 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "CLOSED", 68, true)
					elseif tick == 21 then
						sounds:playSound("minecraft:block.anvil.place", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.Shield), 0.15, 2)
					elseif tick == 23 and host:isHost() then
						renderer:setPostEffect("phosphor")
						sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(models.models.main.CameraAnchor), 0.15, 0.5)
					elseif tick == 36 then
						sounds:playSound("minecraft:entity.vindicator.ambient", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Illagers.Vindicator1), 1, 1)
					elseif tick == 38 and host:isHost() then
						renderer:setPostEffect()
					elseif tick == 42 then
						sounds:playSound("minecraft:entity.ravager.roar", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Illagers.Ravager), 1, 1)
					elseif tick == 46 then
						sounds:playSound("minecraft:entity.pillager.ambient", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Illagers.Pillager2), 1, 1)
					elseif tick == 49 then
						models.models.ex_skill_1.Firework:setVisible(true)
						sounds:playSound("minecraft:item.crossbow.shoot", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Illagers.Ravager.Pillager1), 1, 1)
						self.exSkill.primary.fireworkSound = sounds:playSound("minecraft:entity.firework_rocket.launch", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Firework), 1, 0.5)
					elseif tick == 88 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "TEETH", 21, true)
					elseif tick == 97 and host:isHost() then
						models.models.ex_skill_1.Gui:setScale(client:getScaledWindowSize():augmented(1))
						models.models.ex_skill_1.Gui:setVisible(true)
					elseif tick == 99 and host:isHost() then
						models.models.ex_skill_1.Gui.Filter:setUVPixels(1, 0)
					elseif tick == 100 then
						sounds:playSound("minecraft:block.anvil.place", player:getPos(), 0.15, 2)
						self.exSkill.primary.grindstoneSound = sounds:playSound("minecraft:block.grindstone.use", player:getPos(), 1, 1.25)
					elseif tick == 102 and host:isHost() then
						models.models.ex_skill_1.Gui:setVisible(false)
					elseif tick == 109 then
						self.exSkill.primary.grindstoneSound:stop()
						sounds:playSound("minecraft:block.anvil.place", player:getPos(), 0.5, 0.75)
						particles:newParticle("minecraft:sweep_attack", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Firework.ExSkill1ParticleAnchor2):add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0.75, 0, -0.4, 0, 1, 0))):setColor(1, 0.98, 0.69)
						FaceParts:setEmotion("ANGRY_INVERTED", "ANGRY", "OUT_OF_BREATH", 17, true)
					elseif tick == 122 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Firework)
						sounds:playSound("minecraft:entity.generic.explode", anchorPos, 1, 0.75)
						for _ = 1, 100 do
							local particleOffset = vectors.vec3(math.random() - 0.5, math.random() * 0.5, math.random() - 0.5)
							particles:newParticle("minecraft:poof", anchorPos:copy():add(particleOffset)):setScale(10):setVelocity(particleOffset:mul(1, 0.5, 1):scale(2)):setColor(vectors.vec3(0.45, 0.35, 0.35):scale(math.random() * 0.2 - 0.1 + 1)):setGravity(math.random() * -0.1):setLifetime(120)
						end
						models.models.ex_skill_1.Explosion:setColor(client:hasShaderPack() and vectors.vec3(1, 0.85, 0.5) or vectors.vec3(1, 1, 1))
						models.models.ex_skill_1.Firework:setVisible(false)
						models.models.ex_skill_1.Explosion:setVisible(true)
					elseif tick == 126 then
						FaceParts:setEmotion("ANGRY_INVERTED", "ANGRY", "W", 14, true)
					elseif tick == 131 then
						models.models.ex_skill_1.Explosion:setVisible(false)
					elseif tick == 138 then
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.5, 0.75)
					elseif tick == 140 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "W", 48, true)
					end
					if tick >= 49 and tick <= 109 then
						self.exSkill.primary.fireworkSound:setPos(ModelUtils.getModelWorldPos(models.models.ex_skill_1.Firework))
						local anchor2Pos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Firework.ExSkill1ParticleAnchor2)
						local anchorPos = anchor2Pos:copy()
						if host:isHost() and tick < 100 then
							anchorPos:add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 0, -1.5, 0, 1, 0))
						elseif tick >= 100 then
							local bodyYaw = player:getBodyYaw()
							anchorPos:add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, 0.3, 0, 1, 0))
							for _ = 0, 3 do
								particles:newParticle("minecraft:electric_spark", anchor2Pos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.2 - 0.1, math.random() * 0.2 - 0.1, 0.05, 0, 1, 0)):setColor(1, 0.804, 0.357):setLifetime(2)
							end
						end
						local axisVector = anchor2Pos:copy():sub(ModelUtils.getModelWorldPos(models.models.ex_skill_1.Firework.ExSkill1ParticleAnchor1))
						for i = 0, 3 do
							local offset = vectors.rotateAroundAxis(i * 90 + tick * 20, 0, 0.1, 0, axisVector)
							particles:newParticle("minecraft:cloud", anchorPos:copy():add(offset)):setScale(0.5):setVelocity(offset:scale(0.5)):setGravity(0):setColor(0.5, 0.5, 0.5):setLifetime(4)
						end
					end
					if tick >= 49 and tick < 122 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Firework.ExSkill1ParticleAnchor1)
						if host:isHost() and tick < 100 then
							anchorPos:add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 0, -1.5, 0, 1, 0))
						end
						particles:newParticle("minecraft:firework", anchorPos):setColor(1, 0.804, 0.357)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if ModelAlias.alias.avatar.rightArmBottom.Gun ~= nil then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					end
					if player:isLeftHanded() then
						ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.left))
						ModelAlias.alias.avatar.gun:setRot(self.gun.gunPosition.put.rot.left)
					else
						ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.right))
						ModelAlias.alias.avatar.gun:setRot(self.gun.gunPosition.put.rot.right)
					end
					if ModelAlias.alias.avatar.leftArmBottom.Shield ~= nil then
						ModelUtils.moveTo(ModelAlias.alias.avatar.leftArmBottom.Shield, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.leftArmBottom)
					end
					ModelAlias.alias.avatar.body.Shield.Section2.ShoulderBelt:setVisible(true)
					self.exSkill.primary.fireworkSound = nil
					self.exSkill.primary.grindstoneSound = nil
					if forcedStop then
						for _, modelPart in ipairs({models.models.ex_skill_1.Firework, models.models.ex_skill_1.Explosion}) do
							modelPart:setVisible(false)
						end
						models.models.ex_skill_1.Gui.Filter:setUVPixels()
						if host:isHost() then
							renderer:setPostEffect()
							models.models.ex_skill_1.Gui:setVisible(false)
						end
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---花火の音のインスタンス
			---@type Sound|nil
			fireworkSound = nil;

			---砥石の音のインスタンス
			---@type Sound|nil
			grindstoneSound = nil;
		};

		secondary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_2.Zombie, models.models.ex_skill_2.Creeper, ModelAlias.alias.avatar.gun.MuzzleFlash};

			animations = {"main", "gun", "ex_skill_2"};

			camera = {
				start = {
					rot = vectors.vec3(0, 30, -10);
					pos = vectors.vec3(17, 12, 7);
				};

				fin = {
					rot = vectors.vec3(-5, 30, 15);
					pos = vectors.vec3(-1, 10, -235);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.secondary.isInitialized then
						models.models.ex_skill_2.Zombie:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/zombie/zombie.png")
						local gameVersion = client:getVersion()
						local isNewerPath = StringUtils.compareVersions(gameVersion, "1.21.2") == gameVersion
						for _, modelPart in ipairs({models.models.ex_skill_2.Zombie.ZHead.ZHelmet, models.models.ex_skill_2.Zombie.ZUpperBody.ZBody.ZChestPlateB, models.models.ex_skill_2.Zombie.ZUpperBody.ZArms.ZRightArm.ZChestPlateRA, models.models.ex_skill_2.Zombie.ZUpperBody.ZArms.ZLeftArm.ZChestPlateLA, models.models.ex_skill_2.Zombie.ZLowerBody.ZLegs.ZRightLeg.ZBootsRL, models.models.ex_skill_2.Zombie.ZLowerBody.ZLegs.ZLeftLeg.ZBootsLL}) do
							modelPart:setPrimaryTexture("RESOURCE", isNewerPath and "minecraft:textures/entity/equipment/humanoid/iron.png" or "minecraft:textures/models/armor/iron_layer_1.png")
						end
						for _, modelPart in ipairs({models.models.ex_skill_2.Zombie.ZUpperBody.ZBody.ZLeggingsB,models.models.ex_skill_2.Zombie.ZLowerBody.ZLegs.ZRightLeg.ZLeggingsRL, models.models.ex_skill_2.Zombie.ZLowerBody.ZLegs.ZLeftLeg.ZLeggingsLL}) do
							modelPart:setPrimaryTexture("RESOURCE", isNewerPath and "minecraft:textures/entity/equipment/humanoid_leggings/iron.png" or "minecraft:textures/models/armor/iron_layer_2.png")
						end
						models.models.ex_skill_2.Creeper:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/creeper/creeper.png")
						self.exSkill.secondary.isInitialized = true
					end
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 18, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.body.SubGun:setPos()
						ModelAlias.alias.avatar.body.SubGun:setRot()
						ModelAlias.alias.avatar.body.SubGun:setScale(1.5, 1.5, 1.5)
						ModelAlias.alias.avatar.body.SubGun:setParentType("None")
						ModelUtils.moveTo(ModelAlias.alias.avatar.body.SubGun, ModelAlias.alias.avatar.leftArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.body.Shield.Section2.ShoulderBelt:setVisible(false)
					elseif tick == 1 then
						sounds:playSound("minecraft:entity.zombie.ambient", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.5, 1)
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						for _ = 1, 50 do
							particles:newParticle("minecraft:campfire_cosy_smoke", anchorPos:copy():add(math.random() * 5 - 2.5, 0.5, math.random() * 5 - 2.5)):scale(5):setVelocity(0, 0.01, 0):setLifetime(60)
						end
					elseif tick == 18 then
						FaceParts:setEmotion("NARROW", "NARROW", "CLOSED", 22, true)
					elseif tick == 40 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 19, true)
					elseif tick == 50 then
						ModelAlias.alias.avatar.head.EyeShine:setVisible(true)
					elseif tick == 52 and host:isHost() then
						renderer:setPostEffect("phosphor")
						sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 0.5)
					elseif tick == 59 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 16, true)
						if host:isHost() then
							renderer:setPostEffect()
						end
					elseif tick == 66 then
						ModelAlias.alias.avatar.head.EyeShine:setVisible(false)
					elseif tick == 70 or tick == 82 then
						sounds:playSound("minecraft:entity.zombie.hurt", ModelUtils.getModelWorldPos(models.models.ex_skill_2.Zombie), 1, 1)
						if tick == 70 then
							local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.Zombie.ZUpperBody.ZBody.ExSkill2ParticleAnchor1)
							local bodyYaw = player:getBodyYaw()
							for _ = 1, 50 do
								particles:newParticle("minecraft:electric_spark", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + 90, math.random() * 0.6 - 0.3, math.random() * 0.6 - 0.3, math.random() * 0.4, 0, 1, 0)):setColor(1, 0.877, 0.436):setLifetime(4)
							end
						end
					elseif tick == 75 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 4, true)
					elseif tick == 79 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 11, true)
					elseif tick == 86 then
						sounds:playSound("minecraft:entity.zombie.death", ModelUtils.getModelWorldPos(models.models.ex_skill_2.Zombie), 1, 1)
					elseif tick == 90 then
						FaceParts:setEmotion("NORMAL", "INVERTED", "CLOSED", 31, true)
					elseif tick == 95 or tick == 98 then
						sounds:playSound("minecraft:entity.creeper.hurt", ModelUtils.getModelWorldPos(models.models.ex_skill_2.Creeper), 1, 1)
					elseif tick == 117 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.muzzleAnchor)
						local dirVector = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.ExSkill2Anchor3):sub(anchorPos):normalize()
						local normalVector = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.ExSkill2Anchor4):sub(anchorPos):normalize()
						for i = 0, 4 do
							for j = 0, 11 do
								local offsetLength = i / 4
								particles:newParticle("minecraft:electric_spark", anchorPos):setVelocity(dirVector:copy():scale(math.cos(offsetLength * math.pi / 2) * 0.5):add(vectors.rotateAroundAxis(j * 30, normalVector:copy():scale(offsetLength * 0.45), dirVector))):setScale(5):setColor(1, 0.877, 0.436):setLifetime(8)
								if i == 0 then
									break
								end
							end
						end
						for _ = 1, 10 do
							particles:newParticle("minecraft:large_smoke", anchorPos:copy():add(math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25))
						end
						sounds:playSound("minecraft:entity.firework_rocket.large_blast",  anchorPos, 1, 0.75)
						local anchorPos2 = ModelUtils.getModelWorldPos(models.models.ex_skill_2.Creeper)
						sounds:playSound("minecraft:entity.creeper.death", anchorPos2, 1, 1)
						particles:newParticle("minecraft:explosion_emitter", anchorPos2)
						for _ = 1, 30 do
							local offset = vectors.vec3(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)
							particles:newParticle("minecraft:poof", anchorPos2:copy():add(offset.x * 2, offset.y * 2 + 0.5, offset.z * 2)):setVelocity(offset:copy():scale(0.5))
						end
						sounds:playSound("minecraft:entity.generic.explode", anchorPos2, 1, 1)
						models.models.ex_skill_2.Creeper:setVisible(false)
					elseif tick == 121 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 11, true)
					elseif tick == 124 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 25, true)
					elseif tick == 149 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 39, true)
					elseif tick == 150 then
						ModelAlias.alias.avatar.muzzleAnchor:setColor(client:hasShaderPack() and vectors.vec3(1, 0.85, 0.5) or vectors.vec3(1, 1, 1))
					elseif tick == 152 then
						sounds:playSound("minecraft:entity.generic.explode", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head), 1, 0.5)
					elseif tick == 157 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.muzzleAnchor)
						for _ = 1, 50 do
							particles:newParticle("minecraft:lava", anchorPos):setVelocity(math.random() * 0.25 - 0.125, math.random() * 0.1, math.random() * 0.25 - 0.125):setColor(1, 0.877, 0.436):setLifetime(30)
						end
					end
					if tick == 70 or tick == 82 or tick == 86 or tick == 95 or tick == 98 then
						--ピストル発砲
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.SubGun.MuzzleAnchor2)
						local velocityVector = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.SubGun.ExSkill2Anchor1):sub(anchorPos):normalize():scale(0.5)
						local offsetVector = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.SubGun.ExSkill2Anchor2):sub(anchorPos):normalize():scale(0.25)
						for i = 0, 5 do
							particles:newParticle("minecraft:electric_spark", anchorPos):setVelocity(velocityVector:copy():add(vectors.rotateAroundAxis(i * 60, offsetVector, velocityVector))):setScale(1.5):setColor(1, 0.877, 0.436):setLifetime(2)
							particles:newParticle("minecraft:smoke", anchorPos:copy():add(math.random() * 0.1 - 0.05, math.random() * 0.1 - 0.05, math.random() * 0.1 - 0.05))
						end
						sounds:playSound("minecraft:entity.firework_rocket.blast", anchorPos, 1, 0.5)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					ModelAlias.alias.avatar.body.Shield.Section2.ShoulderBelt:setVisible(true)
					if ModelAlias.alias.avatar.rightArmBottom.Gun ~= nil then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					end
					if ModelAlias.alias.avatar.leftArmBottom.SubGun ~= nil then
						ModelUtils.moveTo(ModelAlias.alias.avatar.leftArmBottom.SubGun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.leftArmBottom)
					end
					if player:isLeftHanded() then
						ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.left))
						ModelAlias.alias.avatar.gun:setRot(self.gun.gunPosition.put.rot.left)
					else
						ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.right))
						ModelAlias.alias.avatar.gun:setRot(self.gun.gunPosition.put.rot.right)
					end
					ModelAlias.alias.avatar.body.SubGun:setPos(-1, 17.5, -1.9)
					ModelAlias.alias.avatar.body.SubGun:setRot(-30, 90, 0)
					ModelAlias.alias.avatar.body.SubGun:setScale()
					if forcedStop then
						ModelAlias.alias.avatar.head.EyeShine:setVisible(false)
						if host:isHost() then
							renderer:setPostEffect()
						end
					end
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
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Porch:setVisible(not isVisible)
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
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(12, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Shield:setPos(4.5, -2.5, 0)
				ModelAlias.alias.dummy_avatar.body.Shield:setRot(70, 90, 0)
				ModelAlias.alias.dummy_avatar.body.Shield.Section2.ShoulderBelt:setRot(-55, 0, 0)
				ModelAlias.alias.dummy_avatar.body.SubGun:setPos(-1, 17.5, -1.9)
				ModelAlias.alias.dummy_avatar.body.SubGun:setRot(-30, 90, 0)
				ModelAlias.alias.dummy_avatar.body.SubGun:setScale()
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Shield:setPos()
				ModelAlias.alias.dummy_avatar.body.Shield:setRot(0, 90, 0)
				ModelAlias.alias.dummy_avatar.body.Shield.Section2.ShoulderBelt:setRot()
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(-20, 0, 0)
			end;

			onBeforeModelCopy = function (self)
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
		isVehicleReplacementEnabled = false;
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
	init = function ()
		---盾を制御するクラス
		---@type HoshinoShield
		HoshinoShield = require("scripts.hoshino_shield")

		---サブ拳銃を制御するクラス
		---@type SubGun
		SubGun = require("scripts.sub_gun")

		HoshinoShield:init()
		SubGun:enable()
	end;
}

return BlueArchiveCharacter
