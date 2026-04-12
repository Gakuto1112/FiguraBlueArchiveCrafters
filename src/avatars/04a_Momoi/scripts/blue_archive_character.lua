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
---| "SURPRISED2" # 驚いて下を見る目
---| "ANGRY" # 怒っている目
---| "ANXIOUS" # 不満な目
---| "UNEQUAL" # ><
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "SURPRISED2" # 驚いて下を見る目
---| "ANGRY" # 怒っている目
---| "ANGRY2" # 怒っている目
---| "ANXIOUS" # 不満な目
---| "UNEQUAL" # ><
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "CENTER" # 少し反対側を見る目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "FUN" # 「美味しそう」な口
---| "ANXIOUS" # 口を膨らませる
---| "SHOCK" # あんぐり
---| "OPENED" # 開いた口
---| "SMILE" # こっちを舐め腐っているにっこり
---| "TRIANGLE" # 三角口
---| "ANGRY" # 怒った口


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
---@field public onAdditionalRightArmProcess? fun(self: BlueArchiveCharacter, state: Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState): boolean 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(self: BlueArchiveCharacter, state: Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState): boolean 左腕の追加処理

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
		avatarName = "04a_Momoi";

		birth = {
			month = 12;
			day = 8;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(4, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			SURPRISED2 = vectors.vec2(5, 0);
			ANGRY = vectors.vec2(6, 0);
			ANXIOUS = vectors.vec2(11, 0);
			UNEQUAL = vectors.vec2(13, 0);
			ANGRY_CENTER = vectors.vec2(7, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(2, 0); --必須
			SURPRISED2 = vectors.vec2(4, 0);
			ANGRY2 = vectors.vec2(9, 0);
			ANXIOUS = vectors.vec2(11, 0);
			UNEQUAL = vectors.vec2(12, 0);
			ANGRY = vectors.vec2(7, 0);
			ANGRY_INVERTED = vectors.vec2(8, 0);
			CENTER = vectors.vec2(13, 0);
		};

		mouth = {
			OPENED = vectors.vec2(0, 0);
			FUN = vectors.vec2(3, 0);
			ANXIOUS = vectors.vec2(2, 0);
			SHOCK = vectors.vec2(1, 0);
			ANGRY = vectors.vec2(4, 0);
			SMILE = vectors.vec2(6, 0);
			TRIANGLE = vectors.vec2(7, 0);
		};

		emotionSet = {
			onDamage = {
				rightEye = "SURPRISED";
				leftEye = "SURPRISED";
				mouth = "SHOCK";
			};
		};
	};

	arms = {
	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-0.5, 3, -8);
					left = vectors.vec3(0.5, 3, -8);
				};

				thirdPersonPos = {
					right = vectors.vec3(-2, 3, -6);
					left = vectors.vec3(2, 3, -6);
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
			name = {
				en_us = "The anguish of creation";
				ja_jp = "生みの苦しみ";
			};

			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.head.EffectPanel, ModelAlias.alias.avatar.leftArmBottom.GameConsole1, models.models.ex_skill_1.Midori, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(-10, 200, -25);
					pos = vectors.vec3(-12, 7, -28);
				};

				fin = {
					rot = vectors.vec3(10, 40, 0);
					pos = vectors.vec3(4, 18, 15);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.Midori.MidoriUpperBody.MidoriArms.MidoriLeftArm.MidoriLeftArmBottom.GameConsole2:addChild(ModelAlias.alias.avatar.leftArmBottom.GameConsole1:copy("GameConsole2"))
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI:newText("ex_skill_1_ko"):setText("§cK.O."):setScale(1.5, 1.5, 1.5):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.33, 0, 0):setVisible(false)
							models.models.ex_skill_1.Gui.TextAnchor:newText("ex_skill_1:text"):setText("§d§lMOMOI"):setScale(4, 4, 4):setAlignment("RIGHT"):setOutline(true):setOutlineColor(1, 1, 1)
							models.models.ex_skill_1.Gui.UI.MomoiUI.Background:setColor(0.71, 0.082, 0.067)
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.YellowBar, models.models.ex_skill_1.Gui.UI.MomoiUI.RedBar}) do
								modelPart:setPrimaryRenderType("EMISSIVE_SOLID")
							end
							models.models.ex_skill_1.Gui.UI.MomoiUI:newText("ex_skill_1_momoi_name"):setText("§d§lMOMOI"):setPos(130, 13, 0):setScale(1.5, 1.5, 1.5):setOutline(true):setOutlineColor(1, 1, 1)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setScale(2.3, 2.3, 2.3)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:addChild(ModelUtils:copyModel(models.script_head_block.Skull, "MomoiPaperDollHead"))
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:getTruePivot():add(0, -24, 0))
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.Halo:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts:addChild(ModelAlias.alias.avatar.mouth:copy("Mouth"))
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 16)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setVisible(true)
							models.models.ex_skill_1.Gui.UI.DeadEye:moveTo(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts)
							for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:getChildren()) do
								modelPart:setVisible(false)
							end
							models.models.ex_skill_1.Gui.UI:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Gui.UI.MomoiUI, "MidoriUI"))
							for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:getChildren()) do
								modelPart:setVisible(true)
							end
							models.models.ex_skill_1.Gui.UI.MidoriUI.Frame:setRot(0, 180, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.Background:setPos(-139.5, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.Background:setColor(0.098, 0.2, 0.686)
							models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setPos(36, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setOffsetPivot(-135, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setScale(0.7, 1, 1)
							models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setPrimaryRenderType("EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MidoriUI.RedBar:remove()
							models.models.ex_skill_1.Gui.UI.MidoriPaperDollBody:moveTo(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollBody:setPos(-139, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setPos(0, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setRot(0, -15, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setOffsetPivot(-139, 0, 0)
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Midori.MidoriHead, "MidoriPaperDollHead"))
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:getTruePivot():add(0, -24, 0))
							models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.MidoriHeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
							models.models.ex_skill_1.Gui.UI.MidoriUI:newText("ex_skill_1_midori_name"):setText("§a§lMIDORI"):setPos(48, 13, 0):setScale(1.5, 1.5, 1.5):setOutline(true):setOutlineColor(1, 1, 1):setAlignment("RIGHT")
						end
						self.exSkill.primary.isInitialized = true
					end
					if host:isHost() then
						models.models.ex_skill_1.Gui.UI.MidoriUI:setPos(client:getScaledWindowSize().x * -1 + 220, 0, 0)
					end
				end;

				onAnimationTick = function (_, tick)
					if tick == 0 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "FUN", 16, true)
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.5)
					elseif tick == 1 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.75)
					elseif tick == 2 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 2)
					elseif tick == 14 then
						for _, modelPart in ipairs({models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.RightEye, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye}) do
							modelPart:setUVPixels(12, 0)
						end
					elseif tick == 16 then
						FaceParts:setEmotion("ANXIOUS", "ANXIOUS", "ANXIOUS", 24, true)
					elseif tick == 24 then
						ExSkill1TextObjectManager:spawn("4")
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor(1, 0.75, 0.75)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye:setUVPixels(6, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye:setUVPixels(12, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 0)
						end
					elseif tick == 27 and host:isHost() then
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor()
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye}) do
							modelPart:setUVPixels()
						end
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 16)
					elseif tick == 31 then
						ExSkill1TextObjectManager:spawn("3")
						sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor(1, 0.75, 0.75)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye:setUVPixels(6, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye:setUVPixels(12, 0)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 0)
						end
					elseif tick == 34 and host:isHost() then
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor()
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye}) do
							modelPart:setUVPixels()
						end
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 16)
					elseif tick == 36 then
						ExSkill1TextObjectManager:spawn("5")
						local playerPos = player:getPos()
						sounds:playSound("minecraft:entity.generic.hurt", playerPos, 0.25, 1)
						sounds:playSound("minecraft:entity.player.levelup", playerPos, 1, 1.5)
						if host:isHost() then
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor(1, 0.75, 0.75)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes:setVisible(false)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 8)
							models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.DeadEye:setVisible(true)
							local task = models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko")
							task:setPos(client:getScaledWindowSize().x / 2 * -1, -12, -30)
							task:setVisible(true)
							events.RENDER:register(function (delta)
								local count = ExSkill.animationCount - 37 + delta
								task:setScale(vectors.vec3(1, 1, 1):scale(count <= 1.5 and (-1.667 * count + 5) or (count + 1)))
							end, "ex_skill_1_ko_render")
						end
					elseif tick == 38 then
						models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.RightEye:setUVPixels(24, 0)
						models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye:setUVPixels(18, 0)
						if host:isHost() then
							events.RENDER:remove("ex_skill_1_ko_render")
							models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko"):setScale(3, 3, 3)
						end
					elseif tick == 40 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "ANXIOUS", 3, true)
						models.models.ex_skill_1.Midori.MidoriUpperBody.MidoriArms.MidoriLeftArm.MidoriLeftArmBottom.GameConsole2:moveTo(models.models.ex_skill_1.Midori.MidoriLowerBody.MidoriLegs)
						for _, modelPart in ipairs({models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.RightEye, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye}) do
							modelPart:setUVPixels()
						end
					elseif tick == 43 then
						FaceParts:setEmotion("SURPRISED2", "SURPRISED2", "SHOCK", 24, true)
					elseif tick == 66 then
						models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.RightEye:setUVPixels(24, 0)
						models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye:setUVPixels(18, 0)
					elseif tick == 67 then
						models.models.ex_skill_1.Gui.UI:setVisible(false)
						FaceParts:setEmotion("ANGRY", "ANGRY2", "ANGRY", 41, true)
						ModelAlias.alias.avatar.head.EffectPanel:setUVPixels(9, 0)
						if host:isHost() then
							models.models.ex_skill_1.Gui.TextAnchor:setVisible(true)
							events.RENDER:register(function ()
								local windowSize = client:getScaledWindowSize()
								models.models.ex_skill_1.Gui.TextAnchor:setPos(models.models.ex_skill_1.Gui.TextAnchor:getAnimPos():scale(windowSize.y / 2 / 100):add(0, windowSize.y * -1 + 30, 0))
							end, "ex_skill_1_text_render")
						end
					elseif tick == 83 then
						sounds:playSound("minecraft:entity.generic.explode", player:getPos(), 0.25, 0.5)
					end
					if tick <= 38 and math.random() >= 0.75 then
						sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 0.1, 2)
					end
					if tick <= 38 and tick % 3 == 0 and host:isHost() then
						sounds:playSound("minecraft:entity.player.attack.nodamage", player:getPos(), 0.25, 1)
					end
				end;

				onPostAnimation = function (_, forcedStop)
					for _, modelPart in ipairs({ModelAlias.alias.avatar.head.EffectPanel, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.RightEye, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.LeftEye}) do
						modelPart:setUVPixels()
					end
					if models.models.ex_skill_1.Midori.MidoriLowerBody.MidoriLegs.GameConsole2 ~= nil then
						models.models.ex_skill_1.Midori.MidoriLowerBody.MidoriLegs.GameConsole2:moveTo(models.models.ex_skill_1.Midori.MidoriUpperBody.MidoriArms.MidoriLeftArm.MidoriLeftArmBottom)
					end
					if host:isHost() then
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes}) do
							modelPart:setVisible(true)
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.DeadEye, models.models.ex_skill_1.Gui.TextAnchor}) do
							modelPart:setVisible(false)
						end
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 16)
						models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor()
						models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko"):setVisible(false)
						for _, eventName in ipairs ({"ex_skill_1_text_render", "ex_skill_1_ko_render"}) do
							events.RENDER:remove(eventName)
						end
						if forcedStop then
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.LeftEye, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.RightEye}) do
								modelPart:setUVPixels()
							end
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
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.EffectPanel:setPos(0, 0, isVisible and -1 or 0)
				elseif parts == "LEGGINGS" then
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
						FaceParts:setEmotion("NORMAL", "NORMAL", "FUN", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "SHOCK", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("ANGRY", "ANGRY2", "ANGRY", duration, true)
					end
				end
			end;

			onStop = function(_, _, forcedStop)
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
			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(70, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(22.5, 0, 0)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.TailXPivot};
				x = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;
						sneakOffset = 15;

						bodyY = {
							multiplayer = 40;
							min = -40;
							max = 40;
						};
					};

					horizontal = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyX = {
							multiplayer = 40;
							min = -40;
							max = 40;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.TailXPivot.TailYPivot};

				y = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyZ = {
							multiplayer = -80;
							min = -40;
							max = 40;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---Exスキルで使用するテキストオブジェクトのマネージャークラス
		---@type ExSkill1TextObject
		ExSkill1TextObject = require("scripts.ex_skill_1_text_object")

		---Exスキルで使用するテキストオブジェクトのマネージャークラス
		---@type ExSkill1TextObjectManager
		ExSkill1TextObjectManager = require("scripts.ex_skill_1_text_object_manager")
		ExSkill1TextObjectManager = ExSkill1TextObjectManager.new()

		ExSkill1TextObjectManager.init()
	end;
}

return BlueArchiveCharacter
