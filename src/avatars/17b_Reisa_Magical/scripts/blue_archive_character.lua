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
---| "UNEQUAL" # 不等号目
---| "SHOCKED" # 丸い目
---| "CLOSED2" # 閉じた目2
---| "ANGRY_INVERTED" # 反対側を見る目
---| "CENTER" # 少し反対側を見る目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANGRY" # 怒った目
---| "UNEQUAL" # 不等号目
---| "SHOCKED" # 丸い目
---| "CLOSED2" # 閉じた目2
---| "CENTER" # 少し反対側を見る目
---| "INVERTED" # 怒りつつ反対側を見る目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "NARROW" # 細長い口
---| "FRUST" # ぐじゅぐじゅ口
---| "O" # 細く丸い口
---| "W" # W口
---| "TONGUE" # 舌を出した口

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
		avatarName = "17b_Reisa_Magical";

		birth = {
			month = 5;
			day = 31;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			ANGRY = vectors.vec2(5, 0);
			UNEQUAL = vectors.vec2(7, 0);
			SHOCKED = vectors.vec2(8, 0);
			CLOSED2 = vectors.vec2(9, 0);
			ANGRY_INVERTED = vectors.vec2(12, 0);
			CENTER = vectors.vec2(13, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			ANGRY = vectors.vec2(5, 0);
			UNEQUAL = vectors.vec2(6, 0);
			SHOCKED = vectors.vec2(7, 0);
			CLOSED2 = vectors.vec2(8, 0);
			CENTER = vectors.vec2(9, 0);
			INVERTED = vectors.vec2(10, 0);
		};

		mouth = {
			OPENED = vectors.vec2(0, 0);
			NARROW = vectors.vec2(1, 0);
			FRUST = vectors.vec2(2, 0);
			O = vectors.vec2(3, 0);
			W = vectors.vec2(4, 0);
			TONGUE = vectors.vec2(5, 0);
		};

		callbacks = {
			onPlay = function (_, right, left)
				if right ~= "CLOSED2" then
					ModelAlias.alias.avatar.rightEye:setRot()
				end
				if left ~= "CLOSED2" then
					ModelAlias.alias.avatar.leftEye:setRot()
				end
			end;
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 1;

		gunPosition = {
			hold = {
				thirdPersonPos = {
					right = vectors.vec3(-1.5, 0, -4.5);
					left = vectors.vec3(1.5, 0, -4.5);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, -2, 3);
					left = vectors.vec3(0, -2, 3);
				};

				rot = {
					right = vectors.vec3(0, 90, -10);
					left = vectors.vec3(0, -90, 10);
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
			formationType = "SPECIAL";

			models = {ModelAlias.alias.avatar.rightArmBottom.RocketLauncher, ModelAlias.alias.avatar.body.ChestRibbonBadge, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(0, 21.5, -10);
				};

				fin = {
					rot = vectors.vec3(0, -180, 0);
					pos = vectors.vec3(-3.5, 20, -33.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						if host:isHost() then
							for _, modelPart in ipairs(models.models.ex_skill_1.Gui.StarTransitions.Star1:getChildren()) do
								models.models.ex_skill_1.Gui.StarTransitions.Star2:addChild(modelPart:copy(modelPart:getName():gsub("1", "2")))
							end
						end
						for _, modelPart in ipairs(ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect2:getChildren()) do
							for i = 3, 4 do
								ModelAlias.alias.avatar.body.ChestRibbonBadge["ChestBadgeShineEffect" .. i]:addChild(modelPart:copy(client.intUUIDToString(client.generateUUID())))
							end
						end
						for _, modelPart in ipairs(ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect5:getChildren()) do
							for i = 6, 8 do
								ModelAlias.alias.avatar.body.ChestRibbonBadge["ChestBadgeShineEffect" .. i]:addChild(modelPart:copy(client.intUUIDToString(client.generateUUID())))
							end
						end
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect2:setColor(0.94, 1, 1)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect3:setColor(1, 0.54, 1)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect4:setColor(1, 1, 0.51)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect5:setColor(0.94, 1, 1)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect6:setColor(1, 1, 0.51)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect7:setColor(0.94, 1, 1)
						ModelAlias.alias.avatar.body.ChestRibbonBadge.ChestBadgeShineEffect8:setColor(1, 1, 0.51)
						self.exSkill.primary.isInitialized = true
					end
					events.TICK:remove("costume_magical_badge_shine")
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadgeEmissive, ModelAlias.alias.avatar.head.HairPin.HairPinBase.HairPinBaseEmissive}) do
						modelPart:setPrimaryRenderType("CUTOUT")
					end
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "O", 43, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 23 then
						ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadgeEmissive:setPrimaryRenderType("EMISSIVE_SOLID")
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadge)
						local bodyYaw = player:getBodyYaw()
						local colorTable = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)}
						for _ = 1, 24 do
							particles:newParticle("minecraft:firework", anchorPos):setScale(0.1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(math.random() * 360, 0, math.random() * 0.02 + 0.01, 0.02, 0, 0, 1), 0, 1, 0)):setColor(colorTable[math.random(#colorTable)]):setGravity(0):setLifetime(15)
						end
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 3)
					elseif tick == 35 and host:isHost() then
						models.models.ex_skill_1.Gui.StarTransitions:setVisible(true)
						local windowSize = client:getScaledWindowSize():copy():augmented(0)
						local baseStarScale = math.max(windowSize.x, windowSize.y) / 16
						models.models.ex_skill_1.Gui.StarTransitions.Star1:setScale(vectors.vec3(1, 1, 1):scale(baseStarScale))
						models.models.ex_skill_1.Gui.StarTransitions.Star2:setScale(vectors.vec3(1, 1, 1):scale(baseStarScale * 0.75))
						models.models.ex_skill_1.Gui.StarTransitions.Star1.Star1Outer:setColor(1, 0.76, 1)
						models.models.ex_skill_1.Gui.StarTransitions.Star2.Star2Outer:setColor(0.85, 0.8, 1)
						events.RENDER:register(function ()
							for i = 1, 2 do
								models.models.ex_skill_1.Gui.StarTransitions["Star" .. i]:setPos(models.models.ex_skill_1.Gui.StarTransitions["Star" .. i .. "PosAnchor"]:getAnimPos():copy():mul(windowSize))
							end
						end, "ex_skill_1_transition_1")
					elseif tick == 43 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "W", 5, true)
					elseif tick == 48 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "NARROW", 16, true)
					elseif tick == 50 and host:isHost() then
						models.models.ex_skill_1.Gui.StarTransitions:setVisible(false)
						events.RENDER:remove("ex_skill_1_transition_1")
					elseif tick == 64 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "W", 12, true)
					elseif tick == 72 then
						for _ = 1, 8 do
							table.insert(self.exSkill.primary.particleCircleTable, {math.random() * 2 + 0.5, math.random() * 360, math.random(3)}) --1. パーティクルの輪の高さ, 2. パーティクルの輪の開始角, 3. パーティクルの輪の色のインデックス番号
						end
					elseif tick == 76 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 2, true)
					elseif tick == 78 then
						FaceParts:setEmotion("NORMAL", "CENTER", "OPENED", 2, true)
					elseif tick == 80 then
						FaceParts:setEmotion("NORMAL", "INVERTED", "OPENED", 8, true)
					elseif tick == 88 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 17, true)
					elseif tick == 105 then
						FaceParts:setEmotion("CENTER", "NORMAL", "OPENED", 4, true)
					elseif tick == 106 then
						ModelAlias.alias.avatar.head.HairPin.HairPinBase.HairPinBaseEmissive:setPrimaryRenderType("EMISSIVE_SOLID")
					elseif tick == 109 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 13, true)
					elseif tick == 113 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.HairPin)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 24 do
							particles:newParticle("minecraft:firework", anchorPos):setScale(0.025):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(math.random() * 360, 0, math.random() * 0.01 + 0.005, 0.005, 0, 0, 1), 0, 1, 0)):setColor(1, 0.87, 1):setGravity(0):setLifetime(15)
						end
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 1)
					elseif tick == 119 and host:isHost() then
						models.models.ex_skill_1.Gui.TransitionBackground:setVisible(true)
						models.models.ex_skill_1.Gui.TransitionBackground.Background:setScale(client:getScaledWindowSize():copy():augmented(1))
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.TransitionBackground.Background:setOpacity(models.models.ex_skill_1.Gui.TransitionBackground.BackgroundOpacity:getAnimScale().x)
						end, "ex_skill_1_transition_2")
					elseif tick == 122 then
						FaceParts:setEmotion("ANGRY_INVERTED", "ANGRY", "TONGUE", 38, true)
					elseif tick == 123 then
						ModelAlias.alias.avatar.rightArmBottom.RocketLauncher:setPrimaryRenderType("EMISSIVE_SOLID")
					elseif tick == 134 and host:isHost() then
						events.RENDER:remove("ex_skill_1_transition_2")
					elseif tick == 138 then
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.5, 2)
					elseif tick == 139 then
						ModelAlias.alias.avatar.rightArmBottom.RocketLauncher:setPrimaryRenderType("CUTOUT")
					elseif tick == 155 and host:isHost() then
						models.models.main.Avatar:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
						models.models.ex_skill_1.CameraBackground:setVisible(true)
						local windowSize = client:getWindowSize()
						models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(40))
						events.RENDER:register(function (delta, ctx, matrix)
							local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.65)), 0, 1, 0):scale(16 / 0.9375)
							models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
							models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
						end, "ex_skill_1_transition_3")
					elseif tick == 159 then
						if host:isHost() then
							models.models.main.Avatar:setPrimaryRenderType("CUTOUT")
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							events.RENDER:remove("ex_skill_1_transition_3")
						end
						ModelAlias.alias.avatar.halo:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
						models.models.ex_skill_1.CameraStarEffect:setVisible(true)
						local windowSize = client:getScaledWindowSize()
						for i = 0, 5 do
							local starType = math.random(5)
							local rot = i * 60 + 10
							ExSkillSpriteManager:spawn(models.models.ex_skill_1.CameraStarEffect, vectors.vec2(0, starType <= 3 and 0 or 1), starType >= 4 and vectors.vec3(0.42, 1, 1) or (starType >= 2 and vectors.vec3(1, 0.47, 1) or vectors.vec3(1, 1, 0.6)), vectors.vec3(0, 0, 0), vectors.rotateAroundAxis(rot, 0, (math.random() * 60 + 40) * math.sqrt(math.pow(math.sin(math.rad(rot)) * (windowSize.x / windowSize.y), 2) + math.pow(math.cos(math.rad(rot)), 2)), -5, 0, 0, 1), math.random() * 50 + 10, math.random() * 20 + 10, nil, 53, false, 0.8)
						end
					elseif tick == 160 then
						FaceParts:setEmotion("CENTER", "NORMAL", "OPENED", 52, true)
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					end

					if tick >= 45 then
						local colorTable = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)}
						particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadge)):setScale(0.1):setVelocity(math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03):setColor(colorTable[math.random(#colorTable)]):setGravity(0):setLifetime(15)
					end
					if tick >= 127 then
						particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.HairPin)):setScale(0.1):setVelocity(math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03):setColor(1, 0.87, 1):setGravity(0):setLifetime(15)
						particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightArmBottom.RocketLauncher.Camera)):setScale(0.25):setVelocity(math.random() * 0.12 - 0.06, math.random() * 0.12 - 0.06, math.random() * 0.12 - 0.06):setColor(1, 0.65, 0.96):setGravity(0):setLifetime(15)
					end
					if tick >= 36 and tick <= 42 and host:isHost() then
						local windowSize = client:getScaledWindowSize():augmented(0)
						local starScale = math.max(windowSize.x, windowSize.y)
						for _ = 1, 4 do
							ExSkillSpriteManager:spawn(models.models.ex_skill_1.Gui.StarTransitions, vectors.vec2(0, 1), vectors.vec3(1, 0.88, 1), models.models.ex_skill_1.Gui.StarTransitions.Star1:getPos():copy():add(vectors.vec3(1, 1, 0):mul(math.random() * starScale - starScale / 2, math.random() * starScale - starScale / 2, 1)), windowSize:copy():normalize():scale(-1500), math.random() * 180 + 180, 20, nil, 8, false, 1)
						end
					end
					if tick >= 45 and tick <= 47 and host:isHost() then
						local windowSize = client:getScaledWindowSize():augmented(0)
						local starScale = math.max(windowSize.x, windowSize.y) * 0.75
						for _ = 1, 4 do
							ExSkillSpriteManager:spawn(models.models.ex_skill_1.Gui.StarTransitions, vectors.vec2(0, 1), vectors.vec3(0.93, 0.9, 1), models.models.ex_skill_1.Gui.StarTransitions.Star2:getPos():copy():add(vectors.vec3(1, 1, 0):mul(math.random() * starScale - starScale / 2, math.random() * starScale - starScale / 2, 1)), windowSize:copy():normalize():scale(-1500), math.random() * 180 + 180, 20, nil, 8, false, 1)
						end
					end
					if tick >= 72 and tick <= 108 then
						local playerPos = player:getPos()
						local colorTable = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)}
						for _, particleData in ipairs(self.exSkill.primary.particleCircleTable) do
							particles:newParticle("minecraft:firework", playerPos:copy():add(vectors.rotateAroundAxis(tick * 10 + particleData[2], 0, 0, 2, 0, 1, 0):add(0, particleData[1], 0))):setScale(math.random() * 0.25 + 0.25):setColor(colorTable[particleData[3]]):setGravity(0.25):setLifetime(25)
						end
						sounds:playSound("minecraft:entity.experience_orb.pickup", playerPos:copy():add(0, 2, 0), 0.25, 1 + ((tick - 72) / 36))
					end
				end;

				onPostAnimation = function (self, forcedStop)
					ModelAlias.alias.avatar.halo:setPrimaryRenderType("CUTOUT")
					self.exSkill.primary.particleCircleTable = {}
					if forcedStop then
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.StarTransitions, models.models.ex_skill_1.Gui.TransitionBackground}) do
							modelPart:setVisible(false)
						end
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadgeEmissive, ModelAlias.alias.avatar.head.HairPin.HairPinBase.HairPinBaseEmissive, ModelAlias.alias.avatar.rightArmBottom.RocketLauncher, models.models.main.Avatar}) do
							modelPart:setPrimaryRenderType("CUTOUT")
						end
						ExSkillSpriteManager:removeAll()
						if host:isHost() then
							for i = 1, 3 do
								events.RENDER:remove("ex_skill_1_transition_" .. i)
							end
						end
					else
						events.TICK:register(function ()
						if not renderer:isFirstPerson() then
							local colorTable = {vectors.vec3(0.94, 1, 1), vectors.vec3(1, 0.54, 1), vectors.vec3(1, 1, 0.51)}
							particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadge)):setScale(0.1):setVelocity(math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03):setColor(colorTable[math.random(#colorTable)]):setGravity(0):setLifetime(15)
							particles:newParticle("minecraft:firework", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.HairPin)):setScale(0.1):setVelocity(math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03, math.random() * 0.06 - 0.03):setColor(0.73, 0.47, 1):setGravity(0):setLifetime(15)
						end
						end, "costume_magical_badge_shine")
					end
				end;
			};

			---このExスキルが初期化されたかどうか。
			---@type boolean
			isInitialized = false;

			---パーティクルの輪の情報を保持するテーブル
			---@type number[][]
			particleCircleTable = {};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function(_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("ANGRY", "ANGRY", "OPENED", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("ANGRY", "ANGRY", "NARROW", duration, true)
						ModelAlias.alias.avatar.head.EyeShines:setVisible(true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "NARROW", duration, true)
						ModelAlias.alias.avatar.rightEye:setRot(0, 0, -5)
						ModelAlias.alias.avatar.leftEye:setRot(0, 0, 5)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("SHOCKED", "SHOCKED", "FRUST", duration, true)
						ModelAlias.alias.avatar.rightEye:setRot(0, 0, -5)
						ModelAlias.alias.avatar.leftEye:setRot(0, 0, 5)
					end
				end
			end;

			onStop = function(_, _, forcedStop)
				ModelAlias.alias.avatar.head.EyeShines:setVisible(false)
				if forcedStop then
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
			onBeforeModelCopy = function ()
				events.TICK:remove("costume_magical_badge_shine")
				for _, modelPart in ipairs({ModelAlias.alias.avatar.body.ChestRibbon.RibbonBadgeEmissive, ModelAlias.alias.avatar.head.HairPin.HairPinBase.HairPinBaseEmissive}) do
					modelPart:setPrimaryRenderType("CUTOUT")
				end
			end;

			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(30, 0, 20)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(30, 0, -20)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(60, 0, 0)
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomRight, ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomLeft}) do
					modelPart:setPos(0, 2, 0)
					modelPart:setRot(-120, 0, 0)
				end
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTails.RightHairTail:setRot(-20, 0, 20)
				ModelAlias.alias.dummy_avatar.head.HairTails.LeftHairTail:setRot(-20, 0, -20)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomRight:setPos()
				ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomRight:setRot(-15, 0, 5)
				ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomLeft:setPos()
				ModelAlias.alias.dummy_avatar.body.Skirt.BackRibbon.RibbonBottomLeft:setRot(-15, 0, -25)
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
						min = -50;
						neutral = -20;
						max = 20;

						headX = {
							multiplayer = 40;
							min = -50;
							max = 20;
						};

						bodyY = {
							multiplayer = 40;
							min = -50;
							max = 20;
						};
					};

					horizontal = {
						min = -50;
						neutral = -20;
						max = 20;

						bodyX = {
							multiplayer = 80;
							min = 0;
							max = 20;
						};
					};
				};

				y = {
					vertical = {
						min = -20;
						neutral = -20;
						max = -20;
					};

					horizontal = {
						min = -20;
						neutral = -20;
						max = -20;
					};
				};
			};

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
				models = {ModelAlias.alias.avatar.head.HairPin.HairPinWing, ModelAlias.alias.avatar.leftLegBottom.LeftBootsWing};

				z = {
					vertical = {
						min = -15;
						neutral = 0;
						max = 35;

						bodyY = {
							multiplayer = 40;
							min = -15;
							max = 35;
						};
					};

					horizontal = {
						min = -15;
						neutral = 0;
						max = 35;

						bodyY = {
							multiplayer = -40;
							min = -15;
							max = 35;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonRight};

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
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonRight.RibbonRightZPivot};

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
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonLeft};

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
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonLeft.RibbonLeftZPivot, ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonLeft.ChestRibbonLeftZPivot};

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
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonBottomRight, ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonBottomLeft};

				x = {
					vertical = {
						min = -140;
						neutral = 0;
						max = 15;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = -60;
							max = 15;
						};

						bodyY = {
							multiplayer = 80;
							min = -140;
							max = 15;
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
						max = 15;

						bodyY = {
							multiplayer = 80;
							min = -60;
							max = 15;
						};
					};
				};
			};


		{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonBottomRight.RibbonBottomRightZPivot, ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonBottomRight.ChestRibbonBottomRightZPivot};

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

						bodyY = {
							multiplayer = 20;
							min = 0;
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
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonBottomLeft.RibbonBottomLeftZPivot, ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonBottomLeft.ChestRibbonBottomLeftZPivot};

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

						bodyY = {
							multiplayer = -20;
							min = -15;
							max = 0;
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

			{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonRight};

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
				models = {ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonLeft};

				y = {
					vertical = {
						min = -70;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = 40;
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
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonRight};

				y = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 70;

						bodyX = {
							multiplayer = -40;
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
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.BackRibbon.RibbonRight.RibbonRightZPivot, ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonRight.ChestRibbonRightZPivot};

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
				models = {ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonBottomRight, ModelAlias.alias.avatar.body.ChestRibbon.ChestRibbonBottomLeft};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 140;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 140;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 60;
						};
					};

					horizontal = {
						min = 0;
						neutral = 0;
						max = 140;

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.rightLegBottom.RightBootsWing};

				z = {
					vertical = {
						min = -35;
						neutral = 0;
						max = 15;

						bodyY = {
							multiplayer = -40;
							min = -35;
							max = 15;
						};
					};

					horizontal = {
						min = -35;
						neutral = 0;
						max = 15;

						bodyY = {
							multiplayer = 40;
							min = -35;
							max = 15;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---Exスキルで使用するスプライトオブジェクトのインスタンスクラス
		---@type ExSkillSprite
		ExSkillSprite = require("scripts.ex_skill_sprite")

		---Exスキルで使用するスプライトオブジェクトのマネージャークラス
		---@type ExSkillSpriteManager
		ExSkillSpriteManager = require("scripts.ex_skill_sprite_manager")
		ExSkillSpriteManager = ExSkillSpriteManager.new()
	end;
}

return BlueArchiveCharacter
