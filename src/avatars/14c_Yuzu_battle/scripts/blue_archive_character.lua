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
---| "UNEQUAL" # 不等号目（><）
---| "INVERTED" # 反対側を見る目
---| "ANGRY" # 怒った目
---| "CLOSED2" # 閉じた目2
---| "FEAR" # 恐怖を感じているときの目
---| "FEAR_CENTER" # 恐怖を感じてつつ少し反対側を見る目
---| "CLOSED2_WITH_TEAR" # 涙ぐみつつ閉じた目2

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "UNEQUAL" # 不等号目（><）
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "FEAR" # 恐怖を感じているときの目
---| "FEAR_CENTER" # 恐怖を感じてつつ少し反対側を見る目
---| "CLOSED2_WITH_TEAR" # 涙ぐみつつ閉じた目2
---| "ANGRY" # 怒った目
---| "INVERTED" # 反対側を見る目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "SHOCK" # あんぐり口
---| "FRUST" # ぐにゅぐにゅ口
---| "SMALL" # 小さく開けた口
---| "CLOSED" # 閉じた口
---| "ANGRY" # 怒った口
---| "FEAR" # 恐怖を感じているときの口
---| "SMILE" # にっこり
---| "OPENED" # 開いた口

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
		avatarName = "14a_Yuzu";

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
			UNEQUAL = vectors.vec2(5, 0);
			INVERTED = vectors.vec2(6, 0);
			ANGRY = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(9, 0);
			FEAR = vectors.vec2(10, 0);
			FEAR_CENTER = vectors.vec2(11, 0);
			CLOSED2_WITH_TEAR = vectors.vec2(12, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			UNEQUAL = vectors.vec2(4, 0);
			ANGRY_INVERTED = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(8, 0);
			FEAR = vectors.vec2(9, 0);
			FEAR_CENTER = vectors.vec2(10, 0);
			CLOSED2_WITH_TEAR = vectors.vec2(11, 0);
			ANGRY = vectors.vec2(12, 0);
			INVERTED = vectors.vec2(13, 0);
		};

		mouth = {
			SHOCK = vectors.vec2(0, 0);
			FRUST = vectors.vec2(1, 0);
			SMALL = vectors.vec2(2, 0);
			CLOSED = vectors.vec2(3, 0);
			ANGRY = vectors.vec2(4, 0);
			FEAR = vectors.vec2(5, 0);
			SMILE = vectors.vec2(6, 0);
			OPENED = vectors.vec2(7, 0);
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
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.head.ShineRing};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-10, 130, 0);
					pos = vectors.vec3(9, 22, -12.7);
				};

				fin = {
					rot = vectors.vec3(0, 180, -15);
					pos = vectors.vec3(0, 24, -16.7);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						if host:isHost() then
							models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:newText("ex_skill_1_action_text"):setAlignment("CENTER"):setOutlineColor(0.33, 1, 1)
							models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:newText("ex_skill_1_cancel_text"):setText("CANCEL"):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.33, 1, 1)
							models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionBackground:setColor(0.055, 0.341, 0.702)
							models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelBackground:setColor(0.698, 0.016, 0.184)
							models.models.ex_skill_1.Gui.NameArea:setScale(4, 4, 4)
							models.models.ex_skill_1.Gui.NameArea.NameAreaRight:newText("ex_skill_1_name_text_1"):setText("§lYUZU"):setPos(30, 5.5, -1):setScale(1.2, 1.2, 1):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.33, 1, 1)
							models.models.ex_skill_1.Gui.NameArea.NameAreaRight:newText("ex_skill_1_name_text_2"):setText("§lYUZU"):setPos(30, 4.5, -0.5):setScale(1.2, 1.2, 1):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.33, 0.5, 0.5)
						end
						self.exSkill.primary.isInitialized = true
					end
					if host:isHost() then
						local randomNum = math.random()
						self.exSkill.primary.actionTextIndex = randomNum < 0.95 and 1 or (randomNum < 0.975 and 2 or 3)
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setText("§7"..(self.exSkill.primary.actionTextIndex == 1 and "ACTION" or (self.exSkill.primary.actionTextIndex == 2 and "MINE" or "CRAFT")))
						models.models.ex_skill_1.Gui.NameArea:setPos(client:getScaledWindowSize():scale(-1):augmented(0))
					end
					FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "SHOCK", 9, true)
					sounds:playSound("minecraft:ui.toast.in", player:getPos(), 1, 1)
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun.Grenade:setVisible(true)
						ModelAlias.alias.avatar.gun.GameDisplay.Display:setColor(0, 0, 0)
						ModelAlias.alias.avatar.gun.GameDisplay.DisplayFlash:setVisible(true)
						ModelAlias.alias.avatar.gun:setVisible(true)
					end

					if tick == 8 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.GameDisplay.ExSkill1ParticleAnchor)
						for i = -2, 5 do
							particles:newParticle("minecraft:electric_spark", anchorPos):setScale(0.25):setVelocity(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0.01, i * 0.01, -0.025, 0, 1, 0)):setColor(0.996, 1, 0.039)
						end
						sounds:playSound("minecraft:block.chiseled_bookshelf.insert", anchorPos, 0.5, 5)
					elseif tick == 9 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "FRUST", 9, true)
					elseif tick == 18 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "FRUST", 8, true)
					elseif tick == 21 then
						ModelAlias.alias.avatar.gun.GameDisplay.Display:setColor()
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.GameDisplay), 0.25, 2)
						if host:isHost() then
							models.models.ex_skill_1.Background:setVisible(true)
							local barWidthScale = 0.135 * client:getScaledWindowSize().x
							for _, modelPart in ipairs({models.models.ex_skill_1.Background.Background2.Action.ActionBackground, models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground}) do
								modelPart:setScale(barWidthScale, 1, 1)
							end
							for _, modelPart in ipairs({models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor, models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor}) do
								modelPart:setPos(1 / barWidthScale * -15, 0, 0)
							end
							models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setPos(0, 1.4, 0)
							models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:getTask("ex_skill_1_cancel_text"):setPos(0, 1.4, 0)
							events.RENDER:register(function ()
								local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw() + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.3)), 0, 1, 0):scale(16 / 0.9375)
								models.models.ex_skill_1.Background:setOffsetPivot(backgroundPos)
								models.models.ex_skill_1.Background.Background2:setPos(backgroundPos)
								models.models.ex_skill_1.Background.Background2:setRot(0, 0, renderer:getCameraRot().z)
								local actionTextScale = models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getScale().x
								models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setScale(vectors.vec3(1 / barWidthScale, 1, 1):scale(0.4 * actionTextScale))
								local cancelTextScale = models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:getScale().x
								models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:getTask("ex_skill_1_cancel_text"):setScale(vectors.vec3(1 / barWidthScale, 1, 1):scale(0.4 * cancelTextScale))
							end, "ex_skill_1_background_render")
						end
					elseif tick == 26 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "FRUST", 3, true)
					elseif tick == 29 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "SMALL", 4, true)
					elseif tick == 33 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "SMALL", 2, true)
					elseif tick == 31 and host:isHost() then
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setText(self.exSkill.primary.actionTextIndex == 1 and "ACTION" or (self.exSkill.primary.actionTextIndex == 2 and "MINE" or "CRAFT")):setOutline(true)
						models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:getTask("ex_skill_1_cancel_text"):setText("§7CANCEL"):setOutline(false)
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionBackground:setVisible(true)
						models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelBackground:setVisible(false)
						sounds:playSound("minecraft:ui.button.click", player:getPos(), 0.25, 1.5)
					elseif tick == 35 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "SMALL", 2, true)
					elseif tick == 36 and host:isHost() then
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setOutlineColor(1, 1, 1)
						sounds:playSound("minecraft:ui.button.click", player:getPos(), 0.5, 1)
					elseif tick == 38 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "CLOSED", 16, true)
					elseif tick == 40 and host:isHost() then
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setOutlineColor(0.33, 1, 1)
					elseif tick == 44 and host:isHost() then
						events.RENDER:remove("ex_skill_1_background_render")
						models.models.ex_skill_1.Background:setVisible(false)
					elseif tick == 47 then
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					elseif tick == 54 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 2, true)
					elseif tick == 56 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "CLOSED", 2, true)
					elseif tick == 58 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "ANGRY", 28, true)
						if host:isHost() then
							models.models.ex_skill_1.Gui:setVisible(true)
							events.RENDER:register(function ()
								local windowSize = client:getScaledWindowSize()
								models.models.ex_skill_1.Gui.NameArea.NameAreaLeft:setPos(models.models.ex_skill_1.Gui.NameArea.NameAreaLeftAnchor:getAnimPos().x * (windowSize.x / 427), 24.5, 0)
								models.models.ex_skill_1.Gui.NameArea.NameAreaRight:setPos(models.models.ex_skill_1.Gui.NameArea.NameAreaRightAnchor:getAnimPos().x * (windowSize.x / 427), 17, 0)
							end, "ex_skill_1_name_render")
						end
					elseif tick == 61 then
						for i = 0, 5 do
							ExSkill1ItemObjectManager:spawn("ITEM", i * 60 + math.random() * 60 - 30)
						end
						for _ = 1, 5 do
							ExSkill1ItemObjectManager:spawn("CROSS")
						end
						for _ = 1, 10 do
							ExSkill1ItemObjectManager:spawn("DOT")
						end
					elseif tick == 70 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.5)
					elseif tick == 72 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.75)
					elseif tick == 74 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 2)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
					ModelAlias.alias.avatar.gun.Grenade:setVisible(false)
					ModelAlias.alias.avatar.gun.GameDisplay.Display:setColor()
					ModelAlias.alias.avatar.gun.GameDisplay.DisplayFlash:setVisible(false)
					ModelAlias.alias.avatar.gun:setVisible(Gun.currentGunPosition ~= "NONE")

					if host:isHost() then
						events.RENDER:remove("ex_skill_1_name_render")
						models.models.ex_skill_1.Gui:setVisible(false)
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setOutline(false)
						models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelTextAnchor:getTask("ex_skill_1_cancel_text"):setText("CANCEL"):setOutline(true)
						models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionBackground:setVisible(false)
						models.models.ex_skill_1.Background.Background2.Cancel.CancelBackground.CancelBackground:setVisible(true)
					end
					if forcedStop then
						ExSkill1ItemObjectManager:removeAll()
						if host:isHost() then
							events.RENDER:remove("ex_skill_1_background_render")
							models.models.ex_skill_1.Background:setVisible(false)
							models.models.ex_skill_1.Background.Background2.Action.ActionBackground.ActionTextAnchor:getTask("ex_skill_1_action_text"):setOutlineColor(0.33, 1, 1)
						end
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---「Action」の項目に出すテキスト
			---1.ACTION, 2.MINE, 3.CRAFT
			---@type integer
			actionTextIndex = 1;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.HairTip2:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, isVisible and -1 or 0)
					ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, isVisible and 1 or 0)
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
		includeModels = {ModelAlias.alias.avatar.body.Hairs};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setPos(0, 0.5, 0.5)
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-15, 0, -15)
				ModelAlias.alias.dummy_avatar.rightLegBottom:setOffsetPivot(0, 0, -2)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.Hairs.FrontHair};

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
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair};

				x = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = -80;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -80;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -80;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTip1.HairTipCore},

				z = {
					vertical = {
						min = -20;
						neutral = 32.5;
						max = 60;
					};

					horizontal = {
						min = -20;
						neutral = 32.5;
						max = 60;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTip1.HairTipCore.HairTipCoreZPivot},

				y = {
					vertical = {
						min = -10;
						neutral = 0;
						max = 10;
					};

					horizontal = {
						min = -10;
						neutral = 0;
						max = 10;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTip2};

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
						min = -40;
						neutral = -40;
						max = -40;
					};

					horizontal = {
						min = -40;
						neutral = -40;
						max = -40;
					};
				};
			};
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model:getName():match("^HairTipCore") then
					local playerPose = player:getPose()
					local isHorizontal = playerPose == "SWIMMING" or playerPose == "FALL_FLYING"
					local velocityY = math.clamp(Physics.velocityAverage[1][2] * -40, -20, 20)
					local velocityZ = math.clamp(Physics.velocityAverage[2][2] * (isHorizontal and 160 or -40), -20, 60)
					local lookRotY = math.deg(math.asin(player:getLookDir().y)) / 90
					local rotY = velocityZ * (1 - math.abs(lookRotY)) * -1 + velocityY * lookRotY
					local rotZ = velocityY * (1 - math.abs(lookRotY)) * -1 + velocityZ * lookRotY
					if model == ModelAlias.alias.avatar.head.HairTip1.HairTipCore then
						ModelAlias.alias.avatar.head.HairTip1.HairTipCore:setRot(0, 0, (isHorizontal and rotZ or rotY) + 32.5)
					elseif model == ModelAlias.alias.avatar.head.HairTip1.HairTipCore.HairTipCoreZPivot then
						ModelAlias.alias.avatar.head.HairTip1.HairTipCore.HairTipCoreZPivot:setRot(0, isHorizontal and rotY or rotZ, 0)
					end
				end
			end
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
