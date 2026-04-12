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
---| "NONE" # 固有の腕の状態なし（追加時にこれは削除する）
---| "FLYING" # 飛行アニメーション中の腕

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
		avatarName = "13c_Aris_Battle";

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
			onArmStateChanged = function (self, right, left)
				local result = {right = right, left = left}
				if right == "DEFAULT" and self.costume.shouldPlayFlyingAnimation then
					result.right = "FLYING"
				elseif right == "GUN_OFF_HAND" then
					result.right = self.costume.shouldPlayFlyingAnimation and "FLYING" or "DEFAULT"
				end

				if left == "DEFAULT" and self.costume.shouldPlayFlyingAnimation then
					result.left = "FLYING"
				elseif left == "GUN_OFF_HAND" then
					result.left = self.costume.shouldPlayFlyingAnimation and "FLYING" or "DEFAULT"
				end

				return result
			end;

			onAdditionalRightArmProcess = function (self, state)
				if state == "GUN_MAIN_HAND" then
					Arms:registerRightArmTickEvent("GUN_MAIN_HAND")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local trueBodyRot = self.costume.flyingAnimationTransitionPercentage > 0 and self.costume.bodyRotPrev:copy():add(self.costume.bodyRot:copy():sub(self.costume.bodyRotPrev):scale(delta)):scale(math.clamp(self.costume.flyingAnimationTransitionPercentage + (self.costume.shouldPlayFlyingAnimation and self.costume.FLYING_ANIMATION_TRANSITION_SPEED * delta or self.costume.FLYING_ANIMATION_TRANSITION_SPEED * (1 - delta)), 0, 1)) or vectors.vec3()
						ModelAlias.alias.avatar.rightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3() or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 90 + (player:isCrouching() and 30 or 0), headRot.y, 0):add(trueBodyRot:scale(-1)))
					end, "right_arm_render")
					return true
				elseif state == "FLYING" then
					events.TICK:register(function ()
						Arms:processArmWingCount()
						if player:getActiveItem().id == "minecraft:crossbow" then
							Arms:setArmState("CROSSBOW", "CROSSBOW")
						end
					end, "right_arm_tick")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						if (player:isSwingingArm() and not player:isLeftHanded()) or (player:getActiveItem().id ~= "minecraft:air" and ((isLeftHanded and activeHand == "OFF_HAND") or (not isLeftHanded and activeHand == "MAIN_HAND"))) or context == "FIRST_PERSON" then
							ModelAlias.alias.avatar.rightArm:setParentType("RightArm")
						elseif Arms.armState.right == "FLYING" then
							ModelAlias.alias.avatar.rightArm:setParentType("Body")
						end
						local trueBodyRot = self.costume.bodyRotPrev:copy():add(self.costume.bodyRot:copy():sub(self.costume.bodyRotPrev):scale(delta)):scale(math.clamp(self.costume.flyingAnimationTransitionPercentage + (self.costume.isFlying and self.costume.FLYING_ANIMATION_TRANSITION_SPEED * delta or self.costume.FLYING_ANIMATION_TRANSITION_SPEED * (1 - delta)), 0, 1))
						ModelAlias.alias.avatar.rightArm:setRot(trueBodyRot:copy():scale(-0.25):add(0, 0, math.abs(trueBodyRot.x * -0.15) + math.sin((math.rad(self.costume.idleAnimationCount + delta) * 3.6)) * 2.5 + 2.5))
					end, "right_arm_render")
					return true
				end
			end;

			onAdditionalLeftArmProcess = function (self, state)
				if state == "GUN_MAIN_HAND" then
					Arms:registerLeftArmTickEvent("GUN_MAIN_HAND")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local trueBodyRot = self.costume.flyingAnimationTransitionPercentage > 0 and self.costume.bodyRotPrev:copy():add(self.costume.bodyRot:copy():sub(self.costume.bodyRotPrev):scale(delta)):scale(math.clamp(self.costume.flyingAnimationTransitionPercentage + (self.costume.shouldPlayFlyingAnimation and self.costume.FLYING_ANIMATION_TRANSITION_SPEED * delta or self.costume.FLYING_ANIMATION_TRANSITION_SPEED * (1 - delta)), 0, 1)) or vectors.vec3()
						ModelAlias.alias.avatar.leftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3() or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5 + 90 + (player:isCrouching() and 30 or 0), headRot.y, 0):add(trueBodyRot:scale(-1)))
					end, "left_arm_render")
					return true
				elseif state == "FLYING" then
					events.TICK:register(function ()
						Arms:processArmWingCount()
						if player:getActiveItem().id == "minecraft:crossbow" then
							Arms:setArmState("CROSSBOW", "CROSSBOW")
						end
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local isLeftHanded = player:isLeftHanded()
						local activeHand = player:getActiveHand()
						if (player:isSwingingArm() and isLeftHanded) or (player:getActiveItem().id ~= "minecraft:air" and ((isLeftHanded and activeHand == "MAIN_HAND") or (not isLeftHanded and activeHand == "OFF_HAND"))) or context == "FIRST_PERSON" then
							ModelAlias.alias.avatar.leftArm:setParentType("LeftArm")
						elseif Arms.armState.left == "FLYING" then
							ModelAlias.alias.avatar.leftArm:setParentType("Body")
						end
						local trueBodyRot = self.costume.bodyRotPrev:copy():add(self.costume.bodyRot:copy():sub(self.costume.bodyRotPrev):scale(delta)):scale(math.clamp(self.costume.flyingAnimationTransitionPercentage + (self.costume.isFlying and self.costume.FLYING_ANIMATION_TRANSITION_SPEED * delta or self.costume.FLYING_ANIMATION_TRANSITION_SPEED * (1 - delta)), 0, 1))
						ModelAlias.alias.avatar.leftArm:setRot(trueBodyRot:copy():scale(-0.25):add(0, 0, math.abs(trueBodyRot.x * 0.15) * -1) + math.sin((math.rad(self.costume.idleAnimationCount + delta) * 3.6)) * -2.5 - 2.5)
					end, "left_arm_render")
				end
			end;
		};
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 2, -10);
					left = vectors.vec3(0, 2, -10);
				};

				thirdPersonPos = {
					right = vectors.vec3(-2, 1, -8);
					left = vectors.vec3(2, 1, -8);
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

			models = {models.models.ex_skill_1.Windows};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-5, 10, 0);
					pos = vectors.vec3(2, 4, 10);
				};

				fin = {
					rot = vectors.vec3(-25, 125, 0);
					pos = vectors.vec3(247.65, 297.25, -1784.75);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.Windows.Window4.Window4Inner:newText("ex_skill_3_text_1"):setText("§bARIS"):setPos(7, 5, 0):setScale(0.2, 0.2, 0.2):setShadow(true)
						models.models.ex_skill_1.Windows.Window4.Window4Inner:newText("ex_skill_3_text_2"):setText("§bAnalyzing..."):setPos(-7, 5, 0):setScale(0.1, 0.1, 0.1):setAlignment("RIGHT"):setShadow(true)
						models.models.ex_skill_1.Windows.Window4.Window4Inner:newText("ex_skill_3_text_3"):setPos(5.8, 3.1, 0):setScale(0.1, 0.1, 0.1):setShadow(true)
						models.models.ex_skill_1.Windows.Window4.Window4Inner:newText("ex_skill_3_text_4"):setPos(5.8, 1.85, 0):setScale(0.1, 0.1, 0.1):setShadow(true)
						models.models.ex_skill_1.Windows.Window4.Window4Inner:newText("ex_skill_3_text_5"):setPos(5.8, 0.6, 0):setScale(0.1, 0.1, 0.1):setShadow(true)
						models.models.ex_skill_1.Windows.Window5.Window5Inner:newText("ex_skill_3_text_6"):setText("§bPOSITION"):setPos(0, 3, 0):setScale(0.07, 0.07, 0.07):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window5.Window5Inner:newText("ex_skill_3_text_7"):setPos(0, 2, 0):setScale(0.1, 0.1, 0.1):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window5.Window5Inner:newText("ex_skill_3_text_8"):setText("§bLOOK DIRECTION"):setPos(0, -1, 0):setScale(0.07, 0.07, 0.07):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window5.Window5Inner:newText("ex_skill_3_text_9"):setPos(0, -2, 0):setScale(0.1, 0.1, 0.1):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window3.Window3Inner:newText("ex_skill_3_text_10"):setPos(0, 4.5, 0):setScale(0.065, 0.065, 0.065):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window6.Window6Inner:newText("ex_skill_3_text_11"):setText("§bDAY"):setPos(2, 3, 0):setScale(0.07, 0.07, 0.07):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window6.Window6Inner:newText("ex_skill_3_text_12"):setPos(2, 2, 0):setScale(0.1, 0.1, 0.1):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window6.Window6Inner:newText("ex_skill_3_text_13"):setText("§bTIME"):setPos(-2, 3, 0):setScale(0.07, 0.07, 0.07):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window6.Window6Inner:newText("ex_skill_3_text_14"):setPos(-2, 2, 0):setScale(0.1, 0.1, 0.1):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window6.Window6Inner:newText("ex_skill_3_text_15"):setText("§bTOTAL TIME"):setPos(0, -1, 0):setScale(0.07, 0.07, 0.07):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window6.Window6Inner:newText("ex_skill_3_text_16"):setPos(0, -2, 0):setScale(0.1, 0.1, 0.1):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window11.Window11Inner:newText("ex_skill_3_text_17"):setText("§bMODEL COMPLEXITY"):setPos(0, 3.3, 0):setScale(0.07, 0.07, 0.07):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window11.Window11Inner:newText("ex_skill_3_text_18"):setPos(0, 2.3, 0):setScale(0.1, 0.1, 0.1):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window11.Window11Inner:newText("ex_skill_3_text_19"):setText("§bTICK INSTRUCTIONS"):setPos(0, 0.8, 0):setScale(0.07, 0.07, 0.07):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window11.Window11Inner:newText("ex_skill_3_text_20"):setPos(0, -0.2, 0):setScale(0.1, 0.1, 0.1):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window11.Window11Inner:newText("ex_skill_3_text_21"):setText("§bRENDER INSTRUCTIONS"):setPos(0, -1.7, 0):setScale(0.07, 0.07, 0.07):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window11.Window11Inner:newText("ex_skill_3_text_22"):setPos(0, -2.7, 0):setScale(0.1, 0.1, 0.1):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window1.Window1Inner.RollingItem.RollingItem2:newItem("ex_skill_3_item_1"):setScale(0.5, 0.5, 0.5)
						for y = 0, 3 do
							for x = 0, 6 do
								models.models.ex_skill_1.Windows.Window8.Window8Inner.ListOfItems:newItem("ex_skill_3_item_" .. (y * 7 + x + 1)):setPos(6 - x * 2, 4 - y * 2, 0):setScale(0.1, 0.1, 0.1):setVisible(false)
							end
						end
						models.models.ex_skill_1.Windows.Window8.Window8Inner:newText("ex_skill_3_text_21"):setText("§bListing items..."):setPos(0, -3.2, 0):setScale(0.2, 0.2, 0.2):setAlignment("CENTER"):setShadow(true)
						models.models.ex_skill_1.Windows.Window2.Window2Inner:newText("ex_skill_3_text_22"):setText("§bWelcome to CraftyOS 6.8.12\n\nThe programs included with the Crafty system are free software;\nthe exact distribution terms for each program are described in the individual files in /usr/share/doc/*/copyright.\n\nCrafty comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law.\n\nplayer@Aris:~# hostname -f\nAris.local\nplayer@Aris:~# _"):setPos(7, 5, 0):setScale(0.065, 0.065, 0.065):setWidth(220):setShadow(true)
						self.exSkill.primary.isInitialized = true
					end
					models.models.ex_skill_1.Windows.Window4.Window4Inner:getTask("ex_skill_3_text_3"):setText("§b" .. math.round(player:getHealth() + player:getAbsorptionAmount()))
					models.models.ex_skill_1.Windows.Window4.Window4Inner:getTask("ex_skill_3_text_4"):setText("§b" .. player:getFood())
					models.models.ex_skill_1.Windows.Window4.Window4Inner:getTask("ex_skill_3_text_5"):setText("§b" .. player:getArmor())
					local playerPos = player:getPos()
					models.models.ex_skill_1.Windows.Window5.Window5Inner:getTask("ex_skill_3_text_7"):setText(string.format("§cX§b: %.2f, §aY§b: %.2f, §9Z§b: %.2f", math.round(playerPos.x * 100) / 100, math.round(playerPos.y * 100) / 100, math.round(playerPos.z * 100) / 100))
					local lookDir = player:getLookDir()
					local dirXZ = (math.deg(math.atan2(lookDir.z, lookDir.x)) -90) % 360
					dirXZ = dirXZ > 180 and dirXZ - 360 or dirXZ
					models.models.ex_skill_1.Windows.Window5.Window5Inner:getTask("ex_skill_3_text_9"):setText(string.format("§cPITCH§b: %.2f, §aYAW§b: %.2f", math.round(math.deg(math.asin(lookDir.y)) * -100) / 100, math.round(dirXZ * 100) / 100))
					---@diagnostic disable-next-line: invisible
					models.models.ex_skill_1.Windows.Window1.Window1Inner.RollingItem.RollingItem2:getTask("ex_skill_3_item_1"):setItem(CompatibilityUtils.registries.item[math.random(#CompatibilityUtils.registries.item)])
					ModelAlias.alias.avatar.gun:setParentType("None")

					events.RENDER:register(function ()
						local colorIntensity = models.models.ex_skill_1.BoosterExhaustColor:getAnimScale().x
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RightBoosterExhaust, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LeftBoosterExhaust, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLArmorBoosterExhaust, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLArmorBoosterExhaust}) do
							modelPart:setColor(vectors.vec3(1, 1, 1):scale(colorIntensity))
						end
					end, "ex_skill_3_render")

					FaceParts:setEmotion("NORMAL", "NORMAL", "SMALL", 31, true)
					sounds:playSound("minecraft:block.beacon.activate", player:getPos(), 1, 0.8)
				end;

				onAnimationTick = function (self, tick)
					if tick == 1 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setVisible(true)
					elseif tick == 4 then
						sounds:playSound("minecraft:block.piston.extend", player:getPos(), 0.5, 1.5)
					elseif tick == 10 then
						sounds:playSound("minecraft:block.iron_trapdoor.open", player:getPos(), 0.5, 1.5)
					elseif tick == 31 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMALL", 5, true)
					elseif tick == 33 then
						sounds:playSound("minecraft:block.beacon.activate", player:getPos(), 1, 1.2)
					elseif tick == 36 then
						FaceParts:setEmotion("NORMAL", "CENTER", "SMALL", 22, true)
					elseif tick == 54 then
						sounds:playSound("minecraft:item.armor.equip_leather", player:getPos(), 1, 1.5)
					elseif tick == 58 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANGRY", 11, true)
					elseif tick == 69 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "ANGRY", 144, true)
					elseif tick == 79 then
						sounds:playSound("minecraft:block.piston.extend", player:getPos(), 0.5, 1.5)
					elseif tick == 83 or tick == 85 then
						sounds:playSound("minecraft:block.piston.extend", player:getPos(), 0.5, 2)
					elseif tick == 96 then
						local playerPos = player:getPos()
						sounds:playSound("minecraft:entity.firework_rocket.large_blast", playerPos, 1, 0.75)
						self.exSkill.primary.elytraSound = sounds:playSound("minecraft:item.elytra.flying", playerPos, 0.5, 0.8, true)
						if host:isHost() then
							ModelAlias.alias.avatar.root:setPrimaryTexture("CUSTOM", textures["textures.ex_skill_1_white"])
							ModelAlias.alias.avatar.root:setPrimaryRenderType("EMISSIVE_SOLID")
							models.models.ex_skill_1.CameraBackground:setVisible(true)
							models.models.ex_skill_1.Windows:setVisible(false)
							local windowSize = client:getWindowSize()
							models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(37.5))
							local shouldAdjustBackgroundRot = client:getVersion() >= "1.21"
							events.RENDER:register(function (delta, context)
								models.models.ex_skill_1.CameraBackground:setVisible(context == "RENDER")
								local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.6)), 0, 1, 0):scale(16 / 0.9375)
								models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
								models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
								if shouldAdjustBackgroundRot then
									models.models.ex_skill_1.CameraBackground.Background:setRot(0, 0, renderer:getCameraRot().z)
								end
							end, "ex_skill_3_background_render")
						end
					elseif tick == 100 then
						if host:isHost() then
							events.RENDER:remove("ex_skill_3_background_render")
							ModelAlias.alias.avatar.root:setPrimaryTexture("PRIMARY")
							ModelAlias.alias.avatar.root:setPrimaryRenderType("CUTOUT")
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							models.models.ex_skill_1.Windows:setVisible(true)
						end
					elseif tick == 128 then
						local anchorPos = player:getPos():add(0, 1, 0)
						local bodyYaw = player:getBodyYaw()
						for i = 0, 35 do
							particles:newParticle("minecraft:cloud", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 10, 0, 1, 0.1, 0, 0, 1), 0, 1, 0))
						end
						sounds:playSound("minecraft:entity.firework_rocket.launch", anchorPos, 1, 1.5)
					elseif tick == 132 then
						self.exSkill.primary.elytraSound:setVolume(0)
					elseif tick == 165 then
						sounds:playSound("minecraft:entity.firework_rocket.launch", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 2)
					end

					if tick >= 7 and tick <= 43 and (tick - 7) % 4 == 0 then
						if tick == 43 then
							for i = 1, 10 do
								models.models.ex_skill_1.Windows.Window13.Window13Inner["Window13_Gauge1_" .. i]:setUVPixels(0, -2)
							end
						else
							models.models.ex_skill_1.Windows.Window13.Window13Inner["Window13_Gauge1_" .. ((tick - 7) / 4 + 1)]:setUVPixels(0, -1)
						end
					end
					if tick >= 7 and tick <= 25 and (tick - 7) % 2 == 0 then
						if tick == 25 then
							for i = 1, 10 do
								models.models.ex_skill_1.Windows.Window13.Window13Inner["Window13_Gauge2_" .. i]:setUVPixels(0, -2)
							end
						else
							models.models.ex_skill_1.Windows.Window13.Window13Inner["Window13_Gauge2_" .. ((tick - 7) / 2 + 1)]:setUVPixels(0, -1)
						end
					end
					if tick >= 7 and tick <= 52 and (tick - 7) % 5 == 0 then
						if tick == 52 then
							for i = 1, 10 do
								models.models.ex_skill_1.Windows.Window14.Window14Inner["Window14_Gauge" .. i]:setUVPixels(0, -2)
							end
						else
							models.models.ex_skill_1.Windows.Window14.Window14Inner["Window14_Gauge" .. ((tick - 7) / 5 + 1)]:setUVPixels(0, -1)
						end
					end
					if tick >= 18 and tick <= 57 and (tick - 18) % 3 == 0 then
						if tick == 57 then
							for i = 1, 14 do
								models.models.ex_skill_1.Windows.Window15.Window15Inner["Window15_Gauge" .. i]:setUVPixels(0, -2)
							end
						else
							models.models.ex_skill_1.Windows.Window15.Window15Inner["Window15_Gauge" .. ((tick - 18) / 3 + 1)]:setUVPixels(0, -1)
						end
					end
					if tick >= 26 and tick < 54 then
						particles:newParticle("minecraft:end_rod", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftItemPivot):copy():add(math.random() * 0.2 - 0.1, math.random() * 0.2 - 0.1, math.random() * 0.2 - 0.1)):setScale(0.1):setVelocity(0, math.random() * 0.02 + 0.03, 0):setColor(0.919, 0.995, 1)
					end
					if tick <= 32 and tick % 4 == 0 then
						models.models.ex_skill_1.Windows.Window4.Window4Inner.Crafter:setUVPixels(tick, 0)
					end
					if tick >= 82 and tick < 96 then
						for _, modelParts in ipairs({{ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor1, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor2, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor3}, {ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor1, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor2, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor3}, {ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor1, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor2, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor3}, {ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor1, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor2, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor3}}) do
							local anchorPos = ModelUtils.getModelWorldPos(modelParts[1])
							local dirVectorX = ModelUtils.getModelWorldPos(modelParts[2]):copy():sub(anchorPos):normalize()
							local dirVectorY = ModelUtils.getModelWorldPos(modelParts[3]):copy():sub(anchorPos):normalize()
							for _ = 1, 10 do
								local offset = vectors.rotateAroundAxis(math.random() * 360, dirVectorY:copy():scale(1 + math.random()), dirVectorX)
								particles:newParticle("minecraft:firework", anchorPos:copy():add(offset)):setScale(0.25):setVelocity(offset:copy():scale(-0.2)):setGravity(0):setColor(1, 1, 1):setLifetime(6)
							end
						end
					elseif tick >= 96 then
						for _, modelParts in ipairs({{ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor1, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor2, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor3}, {ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor1, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor2, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor3}, {ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor1, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor2, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor3}, {ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor1, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor2, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor3}}) do
							local anchorPos = ModelUtils.getModelWorldPos(modelParts[1])
							local dirVectorX = ModelUtils.getModelWorldPos(modelParts[2]):copy():sub(anchorPos):normalize()
							local dirVectorY = ModelUtils.getModelWorldPos(modelParts[3]):copy():sub(anchorPos):normalize()
							local dirVectorZ = vectors.rotateAroundAxis(90, dirVectorY, dirVectorX)
							particles:newParticle("minecraft:soul_fire_flame", anchorPos):setScale(1.5):setVelocity(dirVectorX:copy():scale(0.5):add(dirVectorY:copy():scale(math.random() * 0.1 - 0.05)):add(dirVectorZ:copy():scale(math.random() * 0.1 - 0.05))):setLifetime(2)
							particles:newParticle("minecraft:firework", anchorPos):setScale(0.5):setVelocity(dirVectorX:copy():scale(1):add(dirVectorY:copy():scale(math.random() * 0.1 - 0.05)):add(dirVectorZ:copy():scale(math.random() * 0.1 - 0.05))):setGravity(0):setLifetime(20)
							if tick <= 128 then
								local playerPos = player:getPos():copy():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 0, -1, 0, 1, 0))
								for _ = 1, 2 do
									particles:newParticle("minecraft:campfire_cosy_smoke", playerPos):setScale(2):setVelocity(vectors.rotateAroundAxis(math.random() * 360, 0, 0.05, 0.5, 0, 1, 0))
								end
							else
								particles:newParticle("minecraft:end_rod", anchorPos):setScale(2):setColor(0, 1, 1):setGravity(0):setLifetime(40)
								self.exSkill.primary.elytraSound:setPos(anchorPos)
							end
						end
					end
					if tick < 103 then
						if tick % 2 == 0 then
							local window3Text = "§b"
							for i = 1, 14 do
								window3Text = window3Text .. client.intUUIDToString(client.generateUUID())
								if i < 14 then
									window3Text = window3Text .. "\n"
								end
							end
							models.models.ex_skill_1.Windows.Window3.Window3Inner:getTask("ex_skill_3_text_10"):setText(window3Text)
						end
						models.models.ex_skill_1.Windows.Window6.Window6Inner:getTask("ex_skill_3_text_12"):setText("§b" .. world.getDay())
						local time = world.getTimeOfDay()
						models.models.ex_skill_1.Windows.Window6.Window6Inner:getTask("ex_skill_3_text_14"):setText(string.format("§b%02d:%02d", (math.floor(time / 1000) + 6) % 24, math.floor((time % 1000) / (1000 / 60))))
						models.models.ex_skill_1.Windows.Window6.Window6Inner:getTask("ex_skill_3_text_16"):setText("§b" .. world.getTimeOfDay())
						models.models.ex_skill_1.Windows.Window11.Window11Inner:getTask("ex_skill_3_text_18"):setText("§b" .. avatar:getComplexity())
						models.models.ex_skill_1.Windows.Window11.Window11Inner:getTask("ex_skill_3_text_20"):setText("§b" .. avatar:getTickCount())
						models.models.ex_skill_1.Windows.Window11.Window11Inner:getTask("ex_skill_3_text_22"):setText("§b" .. avatar:getRenderCount())
						if tick % 3 == 0 then
							local task = models.models.ex_skill_1.Windows.Window8.Window8Inner.ListOfItems:getTask("ex_skill_3_item_" .. (math.floor(tick / 3) + 1))
							if task ~= nil then
								---@cast task ItemTask
								---@diagnostic disable-next-line: invisible
								task:setItem(CompatibilityUtils.registries.item[math.random(#CompatibilityUtils.registries.item)])
								task:setVisible(true)
							end
						end
						local playerPos = player:getPos()
						for _ = 1, 4 do
							particles:newParticle("minecraft:end_rod", playerPos:copy():add(vectors.rotateAroundAxis(math.random() * 360, 0, 0, 2.2, 0, 1, 0))):setVelocity(0, math.random() * 0.2 + 0.4, 0):setColor(0, 1, 1)
						end
					end
					if tick < 60 then
						local playerPos = player:getPos()
						for i = 0, 1 do
							particles:newParticle("minecraft:end_rod", playerPos:copy():add(vectors.rotateAroundAxis(tick * 24 + i * 180, 0, tick / 60 * 2.25, 0.5, 0, 1, 0))):setScale(0.25):setVelocity(0, 0.05, 0):setColor(0, 1, 1)
						end
					end
					if tick >= 152 and tick <= 165 then
						self.exSkill.primary.elytraSound:setVolume(tick * 0.04 - 5.85)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					events.RENDER:remove("ex_skill_3_render")
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RightBoosterExhaust, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LeftBoosterExhaust, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLArmorBoosterExhaust, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLArmorBoosterExhaust}) do
						modelPart:setColor(0, 0, 0)
					end
					for i = 1, 10 do
						models.models.ex_skill_1.Windows.Window13.Window13Inner["Window13_Gauge1_" .. i]:setUVPixels()
						models.models.ex_skill_1.Windows.Window13.Window13Inner["Window13_Gauge2_" .. i]:setUVPixels()
						models.models.ex_skill_1.Windows.Window14.Window14Inner["Window14_Gauge" .. i]:setUVPixels()
					end
					for i = 1, 14 do
						models.models.ex_skill_1.Windows.Window15.Window15Inner["Window15_Gauge" .. i]:setUVPixels()
					end

					if ModelAlias.alias.avatar.rightArmBottom.Gun ~= nil then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
						ModelAlias.alias.avatar.gun:setParentType("Item")
					end

					if self.exSkill.primary.elytraSound ~= nil then
						self.exSkill.primary.elytraSound:stop()
						self.exSkill.primary.elytraSound = nil
					end
					if forcedStop and host:isHost() then
						events.RENDER:remove("ex_skill_3_background_render")
						ModelAlias.alias.avatar.root:setPrimaryTexture("PRIMARY")
						ModelAlias.alias.avatar.root:setPrimaryRenderType("CUTOUT")
						models.models.ex_skill_1.CameraBackground:setVisible(false)
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---エリトラの飛行サウンドのインスタンス
			---@type Sound|nil
			elytraSound = nil;
		};

		secondary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_2.Missiles, ModelAlias.alias.avatar.gun.ExSkill2EnergyBall};

			animations = {"main", "gun", "ex_skill_2"};

			camera = {
				start = {
					rot = vectors.vec3(-30, 120, 0);
					pos = vectors.vec3(13, 105, -25);
				};

				fin = {
					rot = vectors.vec3(15, 200, 10);
					pos = vectors.vec3(-43.2, 1784.6, -1521.7);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if host:isHost() then
						ModelAlias.alias.avatar.gun.ExSkill2ShineEffects:setVisible(true)
						models.models.ex_skill_2.Gui.Background:setScale(client:getScaledWindowSize():copy():augmented(1))
					end
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RightBoosterExhaust, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LeftBoosterExhaust, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLArmorBoosterExhaust, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLArmorBoosterExhaust}) do
						modelPart:setColor(vectors.vec3(1, 1, 1))
					end
					ModelAlias.alias.avatar.gun:setParentType("None")
					for _, pixel in ipairs({{14, 0}, {14, 2}}) do
						textures["textures.accessories"]:setPixel(pixel[1], pixel[2], vectors.vec3(0.920, 0.744, 0.983))
					end
					textures["textures.accessories"]:update()
					textures["textures.gun"]:setPixel(0, 3, vectors.vec3(0.920, 0.744, 0.983))
					textures["textures.gun"]:update()
					self.exSkill.secondary.elytraSound = sounds:playSound("minecraft:item.elytra.flying", player:getPos(), 1, 0.8, true)
					FaceParts:setEmotion("ANGRY", "ANGRY_CENTER", "ANGRY", 4, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 1 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.leftArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.leftArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setSecondaryRenderType("GLINT2")
						ModelAlias.alias.avatar.gun:setVisible(true)
						sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 1)
					elseif tick == 4 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANGRY", 1, true)
					elseif tick == 5 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "BRAVE", 2, true)
					elseif tick == 7 then
						FaceParts:setEmotion("ANGRY", "ANGRY_CENTER", "BRAVE", 7, true)
					elseif tick == 14 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "BRAVE", 17, true)
					elseif tick == 20 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						local bodyYaw = player:getBodyYaw()
						for i = 0, 35 do
							particles:newParticle("minecraft:cloud", anchorPos):setScale(2):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 - 90, vectors.rotateAroundAxis(i * 10, 0, 1, 0, 0, 0, 1):add(0, 0, 2), 0, 1, 0)):setLifetime(4)
						end
						sounds:playSound("minecraft:entity.firework_rocket.launch", anchorPos, 1, 2)
						sounds:playSound("minecraft:entity.generic.explode", anchorPos, 1, 1)
					elseif tick == 30 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "BRAVE", 2, true)
					elseif tick == 32 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "ANGRY", 9, true)
					elseif tick == 41 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANGRY", 2, true)
						sounds:playSound("minecraft:entity.firework_rocket.launch", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 2)
					elseif tick == 43 then
						FaceParts:setEmotion("ANGRY_CENTER", "ANGRY", "BRAVE", 5, true)
					elseif tick == 45 or tick == 49 or tick == 54 then
						sounds:playSound("minecraft:entity.firework_rocket.launch", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 0.5)
					elseif tick == 48 then
						FaceParts:setEmotion("ANGRY_NARROW", "ANGRY_NARROW", "TEETH", 5, true)
					elseif tick == 52 then
						sounds:playSound("minecraft:entity.generic.explode", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 1)
					elseif tick == 53 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TEETH", 3, true)
					elseif tick == 56 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "TEETH", 9, true)
					elseif tick == 65 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TEETH", 2, true)
						sounds:playSound("minecraft:entity.firework_rocket.launch", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 0.5)
					elseif tick == 67 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "ANGRY", 16, true)
					elseif tick == 82 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						sounds:playSound("minecraft:entity.firework_rocket.launch", anchorPos, 1, 0.75)
						sounds:playSound("minecraft:entity.firework_rocket.launch", anchorPos, 1, 2)
					elseif tick == 83 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANGRY", 2, true)
					elseif tick == 85 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "BRAVE", 11, true)
					elseif tick == 96 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "BRAVE", 3, true)
					elseif tick == 99 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "BRAVE", 113, true)
					elseif tick == 103 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						sounds:playSound("minecraft:block.iron_door.close", anchorPos, 1, 1.5)
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 3)
					elseif tick == 106 or tick == 111 or tick == 124 or tick == 144 then
						sounds:playSound("minecraft:entity.firework_rocket.launch", ModelUtils.getModelWorldPos(models.models.ex_skill_2.ExSkill2ParticleAnchor1), 1, 0.5)
					elseif tick == 147 and host:isHost() then
						models.models.ex_skill_2.Gui:setVisible(true)
					elseif tick == 149 then
						if host:isHost() then
							models.models.ex_skill_2.Gui:setVisible(false)
						end
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.ExSkill2ParticleAnchor1)
						for _ = 1, 50 do
							particles:newParticle("minecraft:explosion", anchorPos:copy():add(math.random() * 10 - 5, math.random() * 10 - 5, math.random() * 10 - 5)):setScale(10)
							particles:newParticle("minecraft:flame", anchorPos:copy():add(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1)):setScale(20):setVelocity(math.random() * 1 - 0.5, math.random() * 1 - 0.5, math.random() * 1 - 0.5):setLifetime(30 + math.random() * 20)
						end
						for _ = 1, 100 do
							particles:newParticle("minecraft:large_smoke", anchorPos:copy():add(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1)):setScale(20):setVelocity(math.random() * 1 - 0.5, math.random() * 1 - 0.5, math.random() * 1 - 0.5):setLifetime(100 + math.random() * 40)
						end
						sounds:playSound("minecraft:entity.generic.explode", anchorPos, 1, 0.5)
						sounds:playSound("minecraft:entity.lightning_bolt.thunder", anchorPos, 1, 0.5)
					elseif tick == 207 then
						sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 0.75)
					elseif tick == 212 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "TEETH", 5, true)
					elseif tick == 217 then
						FaceParts:setEmotion("ANGRY", "ANGRY_CENTER", "TEETH", 55, true)
					elseif tick == 219 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 1.5)
						sounds:playSound("minecraft:entity.lightning_bolt.thunder", anchorPos, 1, 2)
						self.exSkill.secondary.beaconSound = sounds:playSound("minecraft:block.beacon.ambient", anchorPos, 1, 2, true)
					end

					if tick >= 41 and tick < 52 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 10 do
							particles:newParticle("minecraft:cloud", anchorPos:copy():add(math.random() * 4 - 2, math.random() * 4 - 2, math.random() * 4 - 2)):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 6, 0, 0, 0, 1, 0))
						end
					end
					if tick >= 103 and tick < 147 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.muzzleAnchor)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 10 do
							local sizeOffset = math.random()
							local offset = vectors.rotateAroundAxis(bodyYaw * -1,  vectors.rotateAroundAxis(math.random() * 360, 0, 10 + sizeOffset * 10 , 0, 0, 0, 1), 0, 1, 0)
							--vectors.vec3(0.971, 0.824, 0.968)
							particles:newParticle("minecraft:firework", anchorPos:copy():add(offset)):setScale(tick * 0.06 - 5.35):setVelocity(offset:copy():scale(-0.12)):setColor(vectors.vec3(0, 1, 1):add(vectors.vec3(0.971, -0.176, -0.032):scale(0.022727 * tick - 2.340909))):setGravity(0):setLifetime(14)
						end
						if tick < 139 then
							sounds:playSound("minecraft:block.beacon.activate", anchorPos, 0.75, 0.0441 * tick - 3.0441)
						end
					end
					if tick < 150 then
						for i = 1, 7 do
							if models.models.ex_skill_2.Missiles["Missile" .. i]:getAnimScale().x > 0 then
								local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.Missiles["Missile" .. i]["Missile" .. i .. "Exhaust"])
								if self.exSkill.secondary.missileAnchorsPrev[i] ~= nil then
									for j = 0, 7 do
										particles:newParticle("minecraft:large_smoke", anchorPos:copy():add(anchorPos:copy():sub(self.exSkill.secondary.missileAnchorsPrev[i]):scale(j / 8):add(math.random() * 1 - 0.5, math.random() * 1 - 0.5, math.random() * 1 - 0.5))):setScale(3)
										for _ = 1, 5 do
											particles:newParticle("minecraft:flame", anchorPos):setScale(5):setVelocity(anchorPos:copy():sub(self.exSkill.secondary.missileAnchorsPrev[i]):normalize():scale(math.random() * -1)):setLifetime(4)
										end
									end
								end
								self.exSkill.secondary.missileAnchorsPrev[i] = anchorPos

							end
						end
					end
					if tick < 108 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor1, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor1}) do
							particles:newParticle("minecraft:end_rod", ModelUtils.getModelWorldPos(modelPart)):setScale(2):setColor(0, 1, 1):setGravity(0):setLifetime(40)
						end
					end
					if tick >= 219 and math.random() >= 0.8 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.ExSkill2EnergyBall)
						local offset = vectors.vec3(math.random() * 0.07 - 0.035, math.random() * 0.07 - 0.035, math.random() * 0.07 - 0.035)
						particles:newParticle("minecraft:electric_spark", anchorPos:copy():add(offset)):setScale(0.15):setVelocity(offset:copy():scale(2)):setColor(0.5, 1, 1):setLifetime(1)
						sounds:playSound("minecraft:entity.firework_rocket.blast", anchorPos, 0.5, 2)
					end

					for _, modelParts in ipairs({{ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor1, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor2, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor3}, {ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor1, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor2, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor3}, {ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor1, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor2, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor3}, {ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor1, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor2, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor3}}) do
						local anchorPos = ModelUtils.getModelWorldPos(modelParts[1])
						local dirVectorX = ModelUtils.getModelWorldPos(modelParts[2]):copy():sub(anchorPos):normalize()
						local dirVectorY = ModelUtils.getModelWorldPos(modelParts[3]):copy():sub(anchorPos):normalize()
						local dirVectorZ = vectors.rotateAroundAxis(90, dirVectorY, dirVectorX)
						particles:newParticle("minecraft:soul_fire_flame", anchorPos):setScale(1.5):setVelocity(dirVectorX:copy():scale(0.5):add(dirVectorY:copy():scale(math.random() * 0.1 - 0.05)):add(dirVectorZ:copy():scale(math.random() * 0.1 - 0.05))):setLifetime(2)
						particles:newParticle("minecraft:firework", anchorPos):setScale(0.5):setVelocity(dirVectorX:copy():scale(1):add(dirVectorY:copy():scale(math.random() * 0.1 - 0.05)):add(dirVectorZ:copy():scale(math.random() * 0.1 - 0.05))):setGravity(0):setLifetime(20)
					end
					local avatarPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
					self.exSkill.secondary.elytraSound:setPos(avatarPos)
					self.exSkill.secondary.elytraSound:setVolume(math.max(1 - client:getCameraPos():copy():sub(avatarPos):length() * 0.05, 0))
				end;

				onPostAnimation = function (self, forcedStop)
					if ModelAlias.alias.avatar.leftArmBottom.Gun ~= nil then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.leftArmBottom)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
						ModelAlias.alias.avatar.gun:setParentType("Item")
					end
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RightBoosterExhaust, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LeftBoosterExhaust, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLArmorBoosterExhaust, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLArmorBoosterExhaust}) do
						modelPart:setColor(vectors.vec3(0, 0, 0))
					end
					for _, pixel in ipairs({{14, 0}, {14, 2}}) do
						textures["textures.accessories"]:setPixel(pixel[1], pixel[2], vectors.vec3(0.625, 0.988, 0.990))
					end
					textures["textures.accessories"]:update()
					textures["textures.gun"]:setPixel(0, 3, vectors.vec3(0.473, 0.835, 0.983))
					textures["textures.gun"]:update()
					if host:isHost() then
						ModelAlias.alias.avatar.gun.ExSkill2ShineEffects:setVisible(false)
						if forcedStop then
							models.models.ex_skill_2.Gui.Background:setVisible(false)
						end
					end
					self.exSkill.secondary.elytraSound:stop()
					self.exSkill.secondary.elytraSound = nil
					if self.exSkill.secondary.beaconSound ~= nil then
						self.exSkill.secondary.beaconSound:stop()
						self.exSkill.secondary.beaconSound = nil
					end
					self.exSkill.secondary.missileAnchorsPrev = {}
				end;
			};

			---前ティックのミサイルの排気アンカーの位置
			missileAnchorsPrev = {};

			---エリトラの飛行サウンドのインスタンス
			---@type Sound|nil
			elytraSound = nil;

			---チャージ済み武器のビーコンサウンドのインスタンス
			---@type Sound|nil
			beaconSound = nil
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.FrontHair:setPos(0, 0, isVisible and -1 or 0)
				elseif parts == "LEGGINGS" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.rightLeg.RLArmor, ModelAlias.alias.avatar.leftLeg.LLArmor}) do
						modelPart:setVisible(not isVisible)
					end
				end
			end;
		};

		---クリエイティブ飛行アニメーションを即刻停止させる。
		---@param self BlueArchiveCharacter
		stopFlyingAnimation = function (self)
			events.TICK:remove("costume_battle_creative_flight_tick")
			events.RENDER:remove("costume_battle_creative_flight_render")
			ModelAlias.alias.avatar.root:setPos()
			ModelAlias.alias.avatar.root:setRot()
			ModelAlias.alias.avatar.head:setRot()
			self.costume.bodyRot = vectors.vec3()
			self.costume.bodyRotPrev = vectors.vec3()
			self.costume.shouldPlayFlyingAnimation = false
			self.costume.shouldPlayFlyingAnimationPrev = false
			self.costume.flyingAnimationTransitionPercentage = 0
			self.costume.flyingAnimationTransitionPercentagePrev = 0
			self.costume.resetArmsAndLegs()
			if self.costume.flyingSound ~= nil then
				self.costume.flyingSound:stop()
				self.costume.flyingSound = nil
			end
		end;

		---クリエイティブ飛行で制御した四肢をリセットする。
		resetArmsAndLegs = function ()
			ModelAlias.alias.avatar.rightLeg:setParentType("RightLeg")
			ModelAlias.alias.avatar.leftLeg:setParentType("LeftLeg")
			Arms:setArmState(Arms.armState.right == "FLYING" and "DEFAULT" or Arms.armState.right, Arms.armState.left == "FLYING" and "DEFAULT" or Arms.armState.left)
		end;

		---ブースター点火/消火直後の黒煙を描画する。
		emitBoosterSmoke = function ()
			for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor1, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor1, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor1, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor1}) do
				local anchorPos = ModelUtils.getModelWorldPos(modelPart)
				for _ = 1, 3 do
					particles:newParticle("minecraft:large_smoke", anchorPos:copy():add(math.random() * 0.2 - 0.1, math.random() * 0.2 - 0.1, math.random() * 0.2 - 0.1))
				end
			end
		end;

		---クリエイティブ飛行のアニメーションのトランジションの速度
		---@type number
		FLYING_ANIMATION_TRANSITION_SPEED = 0.1;

		---ホストプレイヤーとしてクリエイティブ飛行中かどうか
		---@type boolean
		isHostFlying = false;

		---プレイヤーの移動速度
		---@type Vector3
		playerVelocity = vectors.vec3();

		---クリエイティブ飛行中かどうか
		---@type boolean
		isFlying = false;

		---クリエイティブ飛行中のアニメーションを再生すべきかどうか
		---@type boolean
		shouldPlayFlyingAnimation = false;

		---前ティックのクリエイティブ飛行中のアニメーションを再生すべきかどうか
		---@type boolean
		shouldPlayFlyingAnimationPrev = false;

		---クリエイティブ飛行中の現在の体の角度
		---@type Vector3
		bodyRot = vectors.vec3();

		---前ティックのクリエイティブ飛行中の体の角度
		---@type Vector3
		bodyRotPrev = vectors.vec3();

		---クリエイティブ飛行のアニメーションのトランジションの進行度（0-1）
		---@type number
		flyingAnimationTransitionPercentage = 0;

		---前ティックのクリエイティブ飛行のアニメーションのトランジションの進行度
		---@type number
		flyingAnimationTransitionPercentagePrev = 0;

		---飛行中のサウンドのインスタンス
		---@type Sound|nil
		flyingSound = nil;

		---クリエイティブ飛行中状態で静止しているときのアニメーションのタイミングを測るカウンター（腕のわずかな動き、飛行の上下のブレ）
		---@type number
		idleAnimationCount = 0;
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
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(30, 0, 30)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(30, 0, -30)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(-20, 0, 10)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(-20, 0, -20)
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
				models = {ModelAlias.alias.avatar.head.HairTails.RightHairTail};

				x = {
					vertical = {
						min = -180;
						neutral = -5;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 90;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -180;
							max = 0;
						};
					};

					horizontal = {
						min = -180;
						neutral = 45;
						max = 90;

						headX = {
							multiplayer = -80;
							min = -45;
							max = 90;
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
						min = -70;
						neutral = 5;
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
				models = {ModelAlias.alias.avatar.head.HairTails.LeftHairTail};

				x = {
					vertical = {
						min = -180;
						neutral = -5;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 90;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -180;
							max = 0;
						};
					};

					horizontal = {
						min = -180;
						neutral = 45;
						max = 90;

						headX = {
							multiplayer = -80;
							min = -45;
							max = 90;
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
						min = -70;
						neutral = -5;
						max = 70;

						headX = {
							multiplayer = 80;
							min = 10;
							max = 2.5;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	---@param self BlueArchiveCharacter
	init = function (self)
		vanilla_model.ELYTRA:setVisible(false)

		for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RightBoosterExhaust, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LeftBoosterExhaust, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLArmorBoosterExhaust, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLArmorBoosterExhaust}) do
			modelPart:setColor(vectors.vec3(0, 0, 0))
		end

		events.TICK:register(function ()
			Config.syncConfigs["isFlying"] = self.costume.isFlying --//FIXME: table以外をConfig.syncConfigsに書き込んでも後に値が変わることないので、このように連続書き込みを行う必要がある。もしくは別の方法か。

			if not client:isPaused() then
				if host:isHost() then
					local isFlying = host:isFlying()
					if isFlying ~= self.costume.isHostFlying then
						pings.setIsFlying(isFlying)
					end
					self.costume.isHostFlying = isFlying
				end

				self.costume.shouldPlayFlyingAnimation = self.costume.isFlying and player:getVehicle() == nil and not player:isUnderwater() and player:getPose() == "STANDING"
				if self.costume.shouldPlayFlyingAnimation then
					self.costume.flyingAnimationTransitionPercentage = math.min(self.costume.flyingAnimationTransitionPercentage + self.costume.FLYING_ANIMATION_TRANSITION_SPEED, 1)
				else
					self.costume.flyingAnimationTransitionPercentage = math.max(self.costume.flyingAnimationTransitionPercentage - self.costume.FLYING_ANIMATION_TRANSITION_SPEED, 0)
				end

				if self.costume.shouldPlayFlyingAnimation ~= self.costume.shouldPlayFlyingAnimationPrev then
					if self.costume.shouldPlayFlyingAnimation then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.rightLeg, ModelAlias.alias.avatar.leftLeg}) do
							modelPart:setParentType("None")
						end
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RightBoosterExhaust, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LeftBoosterExhaust, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLArmorBoosterExhaust, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLArmorBoosterExhaust}) do
							modelPart:setColor(vectors.vec3(1, 1, 1))
						end
						Arms:setArmState(Arms.armState.right == "DEFAULT" and "FLYING" or Arms.armState.right, Arms.armState.left == "DEFAULT" and "FLYING" or Arms.armState.left)
						self.costume.emitBoosterSmoke()
						local playerPos = player:getPos()
						sounds:playSound("minecraft:item.firecharge.use", playerPos, 1, 2)
						if host:isHost() then
							self.costume.flyingSound = sounds:playSound("minecraft:item.elytra.flying", playerPos, 0.2, 0.8, true)
						end
					end
					self.costume.shouldPlayFlyingAnimationPrev = self.costume.shouldPlayFlyingAnimation
				end

				if self.costume.flyingAnimationTransitionPercentage > 0 and self.costume.flyingAnimationTransitionPercentagePrev == 0 then
					events.TICK:register(function ()
						if not client:isPaused() then
							self.costume.bodyRotPrev = self.costume.bodyRot
							self.costume.bodyRot = vectors.vec3(math.clamp(Physics.velocityAverage[5][1] / 1.6 * -90, -90, 10), 0, math.clamp(Physics.velocityAverage[6][1] / 1.6 * -90, -30, 30))

							if self.costume.isFlying and self.costume.flyingAnimationTransitionPercentage > 0 then
								for _, modelParts in ipairs({{ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor1, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor2, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor3}, {ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor1, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor2, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor3}, {ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor1, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor2, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLBoosterAnchor3}, {ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor1, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor2, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLBoosterAnchor3}}) do
									local anchorPos = ModelUtils.getModelWorldPos(modelParts[1])
									local dirVectorX = ModelUtils.getModelWorldPos(modelParts[2]):copy():sub(anchorPos):normalize()
									local dirVectorY = ModelUtils.getModelWorldPos(modelParts[3]):copy():sub(anchorPos):normalize()
									local dirVectorZ = vectors.rotateAroundAxis(90, dirVectorY, dirVectorX)
									particles:newParticle("minecraft:soul_fire_flame", anchorPos):setScale(1.5):setVelocity(dirVectorX:copy():scale(0.5):add(dirVectorY:copy():scale(math.random() * 0.1 - 0.05)):add(dirVectorZ:copy():scale(math.random() * 0.1 - 0.05))):setLifetime(2)
									particles:newParticle("minecraft:firework", anchorPos):setScale(0.5):setVelocity(dirVectorX:copy():scale(1):add(dirVectorY:copy():scale(math.random() * 0.1 - 0.05)):add(dirVectorZ:copy():scale(math.random() * 0.1 - 0.05))):setGravity(0):setLifetime(20)
								end
								for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RBoosterAnchor1, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LBoosterAnchor1}) do
									particles:newParticle("minecraft:end_rod", ModelUtils.getModelWorldPos(modelPart)):setScale(1):setColor(0, 1, 1):setGravity(0):setLifetime(200)
								end
							elseif not self.costume.isFlying then
								self.costume.resetArmsAndLegs()
								if self.costume.flyingSound ~= nil then
									self.costume.flyingSound:stop()
									self.costume.flyingSound = nil
									self.costume.emitBoosterSmoke()
									sounds:playSound("minecraft:block.fire.extinguish", player:getPos(), 1, 1)
									for _, modelPart in ipairs({ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Right1.UpperFlyingArmor2Right2.RightBooster.RightBoosterExhaust, ModelAlias.alias.avatar.body.FlyingArmor.UpperFlyingArmor.UpperFlyingArmor2Left1.UpperFlyingArmor2Left2.LeftBooster.LeftBoosterExhaust, ModelAlias.alias.avatar.rightLeg.RLArmor.RLArmorBooster.RLArmorBoosterExhaust, ModelAlias.alias.avatar.leftLeg.LLArmor.LLArmorBooster.LLArmorBoosterExhaust}) do
										modelPart:setColor(vectors.vec3(0, 0, 0))
									end
								end
							end

							if self.costume.flyingSound ~= nil then
								self.costume.flyingSound:setPos(player:getPos())
							end

							if player:getVehicle() ~= nil or player:getPose() ~= "STANDING" then
								self.costume.stopFlyingAnimation(self)
							end

							self.costume.playerVelocity = player:getVelocity()
							if self.costume.idleAnimationCount == 99 then
								self.costume.idleAnimationCount = 0
							else
								self.costume.idleAnimationCount = self.costume.idleAnimationCount + 1
							end
						end
					end, "costume_battle_creative_flight_tick")
					events.RENDER:register(function (delta)
						if not client:isPaused() then
							local trueBodyRot = self.costume.bodyRotPrev:copy():add(self.costume.bodyRot:copy():sub(self.costume.bodyRotPrev):scale(delta)):scale(math.clamp(self.costume.flyingAnimationTransitionPercentage + (self.costume.isFlying and self.costume.FLYING_ANIMATION_TRANSITION_SPEED * delta or self.costume.FLYING_ANIMATION_TRANSITION_SPEED * (1 - delta)), 0, 1))
							ModelAlias.alias.avatar.root:setPos(math.sin(math.rad(trueBodyRot.z)) * 16, math.abs(math.sin(math.rad(trueBodyRot.x)) * -12) + math.sin(math.rad((self.costume.idleAnimationCount + delta) * 7.2)) * math.max(1 - self.costume.playerVelocity:length() * 2, 0), math.sin(math.rad(trueBodyRot.x)) * -16)
							ModelAlias.alias.avatar.root:setRot(trueBodyRot)
							ModelAlias.alias.avatar.head:setRot(trueBodyRot:copy():scale(-1))
							ModelAlias.alias.avatar.rightLeg:setRot(trueBodyRot:copy():scale(0.5))
							ModelAlias.alias.avatar.leftLeg:setRot(trueBodyRot:copy():scale(0.5))
						end
					end, "costume_battle_creative_flight_render")
				elseif self.costume.flyingAnimationTransitionPercentage == 0 and self.costume.flyingAnimationTransitionPercentagePrev > 0 then
					self.costume.stopFlyingAnimation(self)
				end
				self.costume.flyingAnimationTransitionPercentagePrev = self.costume.flyingAnimationTransitionPercentage
			end

			EventManager.events["ON_CONFIG_SYNC"]:register(function (configData)
				configData["isFlying"] = self.costume.isFlying
			end)
		end, "costume_battle_tick")
	end;
}

---非ホストにクリエイティブ飛行の切り替えを通知する。
---@param isFlying boolean クリエイティブ飛行中かどうか
function pings.setIsFlying(isFlying)
    BlueArchiveCharacter.costume.isFlying = isFlying
end

return BlueArchiveCharacter
