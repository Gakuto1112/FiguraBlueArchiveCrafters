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
---| "INVERTED" # 反対側を見る目
---| "NARROW" # 少し閉じた目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "NARROW_CENTER" # 少し反対側を見つつ、少し閉じた目
---| "NARROW" # 少し閉じた目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "CIRCLE" # 丸い口
---| "SMILE" # にっこり
---| "OPENED" # 開いた口
---| "DROOL" # 開いた口+よだれ
---| "YUMMY" # 美味しいな口
---| "OPENED2" # 開いた口2
---| "ANXIOUS" # への口

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
		avatarName = "08a_Umika";

		birth = {
			month = 7;
			day = 1;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(6, 0);
			INVERTED = vectors.vec2(7, 0);
			NARROW = vectors.vec2(8, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CENTER = vectors.vec2(4, 0);
			CLOSED2 = vectors.vec2(5, 0);
			NARROW_CENTER = vectors.vec2(8, 0);
			NARROW = vectors.vec2(9, 0);
		};

		mouth = {
			CIRCLE = vectors.vec2(0, 0);
			SMILE = vectors.vec2(1, 0);
			OPENED = vectors.vec2(2, 0);
			DROOL = vectors.vec2(3, 0);
			YUMMY = vectors.vec2(4, 0);
			OPENED2 = vectors.vec2(5, 0);
			ANXIOUS = vectors.vec2(6, 0);
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
					right = vectors.vec3(1.5, 0, -4);
					left = vectors.vec3(1.5, 0, -4);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.75, 0, -7);
					left = vectors.vec3(1.75, 0, -7);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, 3, 3);
					left = vectors.vec3(0, 3, 3);
				};

				rot = {
					right = vectors.vec3(0, -90, 45);
					left = vectors.vec3(0, 90, -45);
				};
			};
		};

		sound = {
			name = "minecraft:entity.firework_rocket.blast";
			pitch = 1;
		};
	};

	placementObjects = {
		{
			model = models.models.placement_object.PlacementObject;

			boundingBox = {
				size = vectors.vec3(38, 37, 38)
			};

			placementMode = "COPY";

			callbacks = {
				onInit = function (_, placementObject)
					placementObject.animationCount = -1
				end;

				onTick = function (_, placementObject)
					local fireworkPos = vectors.vec3()
					if placementObject.animationCount == 0 then
						local rot = placementObject.object:getRot().y
						fireworkPos = placementObject.currentPos:copy():add(vectors.rotateAroundAxis(rot, 0.234375, 1.734375, -0.72, 0, 1, 0))
						FireworkManager:spawn(fireworkPos, vectors.vec3(-17.5, rot + 177.5, 0))
					elseif placementObject.animationCount == 10 then
						local rot = placementObject.object:getRot().y
						fireworkPos = placementObject.currentPos:copy():add(vectors.rotateAroundAxis(rot, -0.234375, 1.734375, -0.72, 0, 1, 0))
						FireworkManager:spawn(fireworkPos, vectors.vec3(-17.5, rot + 182.5, 0))
					elseif placementObject.animationCount == 20 then
						local rot = placementObject.object:getRot().y
						fireworkPos = placementObject.currentPos:copy():add(vectors.rotateAroundAxis(rot, 0.234375, 1.296875, -0.72, 0, 1, 0))
						FireworkManager:spawn(fireworkPos, vectors.vec3(-17.5, rot + 177.5, 0))
					elseif placementObject.animationCount == 30 then
						local rot = placementObject.object:getRot().y
						fireworkPos = placementObject.currentPos:copy():add(vectors.rotateAroundAxis(rot, -0.234375, 1.296875, -0.72, 0, 1, 0))
						FireworkManager:spawn(fireworkPos, vectors.vec3(-17.5, rot + 182.5, 0))
					elseif placementObject.animationCount == 35 then
						placementObject.animationCount = -1
					end
					if placementObject.animationCount % 10 == 0 then
						for _ = 1, 10 do
							particles:newParticle("minecraft:smoke", fireworkPos:copy():add(math.random() * 0.25 - 0.125, math.random() * 0.25 + 0.25, math.random() * 0.25 - 0.125))
						end
						sounds:playSound("minecraft:entity.blaze.hurt", placementObject.currentPos, 1, 1.5)
					end
					if placementObject.animationCount >= 0 then
						placementObject.animationCount = placementObject.animationCount + 1
					end
				end;

				onRender = function (self, placementObject, delta)
					local count = placementObject.animationCount >= 0 and placementObject.animationCount + delta or -1
					self.placementObjects[1].barrelRender(placementObject.object.Cannon.CannonHead.CannonBarrel1, placementObject.animationCount >= 0 and math.max(count * -0.2 + 1, 0) or 0)
					self.placementObjects[1].barrelRender(placementObject.object.Cannon.CannonHead.CannonBarrel2, placementObject.animationCount >= 10 and math.clamp(count * -0.2 + 3, 0, 1) or 0)
					self.placementObjects[1].barrelRender(placementObject.object.Cannon.CannonHead.CannonBarrel3, placementObject.animationCount >= 20 and math.clamp(count * -0.2 + 5, 0, 1) or 0)
					self.placementObjects[1].barrelRender(placementObject.object.Cannon.CannonHead.CannonBarrel4, placementObject.animationCount >= 30 and math.clamp(count * -0.2 + 7, 0, 1) or 0)
				end;
			};

			---バレルのレンダー処理
			---@param barrelModel ModelPart 処理対象のバレルもモデル
			---@param barrelCount number バレルのカウンタ値。0~1。
			barrelRender = function (barrelModel, barrelCount)
				barrelModel:setPos(0, 0, barrelCount * 4)
				barrelModel:setColor(vectors.vec3(1, 1, 1):sub(vectors.vec3(0, 0.087, 0.242):scale(barrelCount)))
			end;
		};
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_1, ModelAlias.alias.avatar.head.FaceParts.Eyes.EyeShines, models.models.main.LaughterLines};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 160, 0);
					pos = vectors.vec3(-9, 24, -23);
				};

				fin = {
					rot = vectors.vec3(0, 180, -5);
					pos = vectors.vec3(25.9, 22.75, -43.4);
				};
			};

			callbacks = {
				onPreTransition = function (self)
					if #PlacementObjectManager.objects == 5 then
						PlacementObjectManager:remove(1)
					end
				end;

				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						self.exSkill.primary.makeTakoyakiText(models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallRoof.StallRoofFront, vectors.vec3(0, -6, -1.01), 0)
						self.exSkill.primary.makeTakoyakiText(models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallRoof.StallRoofRight, vectors.vec3(0.501, -6, 22.5), -90)
						self.exSkill.primary.makeTakoyakiText(models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallRoof.StallRoofLeft, vectors.vec3(-0.501, -6, 22.5), 90)
						for i = 1, 2 do
							models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallTable["MenuLabel"..i]:newText("MenuLabel"..i.."_takoyaki_text"):setText("§4§lた\nこ\nや\nき"):setPos(-0.25, -0.25, -0.01):setScale(0.25, 0.25, 0.25):setAlignment("CENTER"):setOutline(true)
							models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallTable["MenuLabel"..i]:newItem("MenuLabel"..i.."_emerald_item"):setItem("minecraft:emerald"):setPos(0.75, -10.75, -0.01):setScale(0.1, 0.1, 0)
							models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallTable["MenuLabel"..i]:newText("MenuLabel"..i.."_price_text"):setText("§0§lx5"):setPos(-0.5, -10.5, -0.01):setScale(0.1, 0.1, 0.1):setAlignment("CENTER")
						end
						models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallFrames.MenuSign:newText("MenuSign_takoyaki_text"):setText("§4§lたこ\n焼き"):setPos(-3.25, 4.25, -0.01):setScale(0.35, 0.35, 0.35):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
						models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallFrames.MenuSign:newItem("MenuSign_emerald_item"):setItem("minecraft:emerald"):setPos(3, -3.25, -0.01):setScale(0.175, 0.175, 0)
						models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallFrames.MenuSign:newText("MenuSign_price_text"):setText("§0§lx5"):setPos(0.5, -3, -0.01):setScale(0.15, 0.15, 0.15):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
						models.models.ex_skill_1.Stalls.TakoyakiStall:newBlock("TakoyakiStall_step"):setBlock("minecraft:scaffolding"):setPos(20, -6, 16)

						models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallTable.PlanksSheet:setPrimaryTexture("RESOURCE", "minecraft:textures/block/oak_planks.png")
						self.exSkill.primary.makeIkayakiText(models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallRoof.StallRoofFront, vectors.vec3(0, -6, -1.01), 0)
						self.exSkill.primary.makeIkayakiText(models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallRoof.StallRoofRight, vectors.vec3(0.501, -6, 22.5), -90)
						self.exSkill.primary.makeIkayakiText(models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallRoof.StallRoofLeft, vectors.vec3(-0.501, -6, 22.5), 90)
						for i = 1, 3 do
							models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallTable["MenuLabel"..i]:newItem("MenuLabel"..i.."_emerald_item"):setItem("minecraft:emerald"):setPos(1.75, -2, -0.01):setScale(0.25, 0.25, 0)
							models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallTable["MenuLabel"..i]:newText("MenuLabel"..i.."_price_text"):setText("§0§lx"..(i - 1) * 2 + 1):setPos(-1.5, -1.75, -0.01):setScale(0.25, 0.25, 0.25):setAlignment("CENTER")
						end
						models.models.ex_skill_1.Stalls.IkayakiStall:newBlock("IkayakiStall_step"):setBlock("minecraft:scaffolding"):setPos(15, -6, 16)
						self.exSkill.primary.isInitialized = true
					end

					events.RENDER:register(function ()
						models.models.main.LaughterLines:setOffsetPivot(models.models.main.LaughterLines.LaughterLinesInner:getAnimPos())
					end, "ex_skill_1_render")
					FaceParts:setEmotion("NORMAL", "CENTER", "CIRCLE", 11, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 11 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 10, true)
						sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.25, 0.75)
					elseif tick == 21 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 7, true)
						sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.25, 0.75)
					elseif tick == 28 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "SMILE", 6, true)
					elseif tick == 34 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 6, true)
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightItemPivot)
						local bodyYaw = player:getBodyYaw()
						for i = 0, 7 do
							particles:newParticle("minecraft:wax_off", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 45 + 0.1, 0, -0.015, 0, 0, 0, 1), 0, 1, 0)):setScale(0.25):setColor(1, 1, 0.71):setLifetime(20)
						end
						Bubble:play("GOOD", 20, false)
						sounds:playSound("minecraft:entity.egg.throw", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 0.5, 2)
						sounds:playSound("minecraft:entity.experience_orb.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 1.5)
					elseif tick == 40 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "OPENED", 14, true)
					elseif tick == 54 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.rightArmBottom.Dumplings, ModelAlias.alias.avatar.leftArmBottom.Takoyaki3, models.models.ex_skill_1.Dogs.Dog2.Dog2Head.Sweat}) do
							modelPart:setVisible(true)
						end
						FaceParts:setEmotion("NORMAL", "NORMAL", "DROOL", 26, true)
						if host:isHost() then
							sounds:playSound("minecraft:block.fire.extinguish", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallTable.IkayakiTableItems.IkayakiPlate.ExSkill1ParticleAnchor3), 0.25, 0.5)
						end
					elseif tick == 80 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "YUMMY", 12, true)
					elseif tick == 92 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "YUMMY", 2, true)
					elseif tick == 94 then
						FaceParts:setEmotion("NORMAL", "CENTER", "CIRCLE", 28, true)
					elseif tick == 97 then
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 1.25)
					elseif tick == 110 then
						models.models.ex_skill_1.Dogs.Dog2.Dog2Head.Sweat:setVisible(false)
						ModelAlias.alias.avatar.rightArmBottom.Ikayaki9:setVisible(true)
					elseif tick == 122 then
						FaceParts:setEmotion("NARROW", "NARROW_CENTER", "SMILE", 29, true)
					elseif tick == 129 then
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 0.75)
					elseif tick == 132 then
						ModelAlias.alias.avatar.rightArmBottom.Ikayaki9:moveTo(models.models.ex_skill_1.Dogs.Dog3.Dog3UpperBody.Dog3RightArm)
						models.models.ex_skill_1.Dogs.Dog3.Dog3UpperBody.Dog3RightArm.ChocoBanana:moveTo(ModelAlias.alias.avatar.rightArmBottom)
					elseif tick == 151 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 5, true)
					elseif tick == 156 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED2", 34, true)
						sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 1)
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.ExSkill1ParticleAnchor5)
						local bodyYaw = player:getBodyYaw()
						for i = 1, 6 do
							local particleColor = i <= 3 and (vectors.vec3(0.667, 0.949, 0.561):add(vectors.vec3(-0.02,- 0.137, -0.094):scale((i - 1) / 2))) or (vectors.vec3(1, 0.78, 0.38):add(vectors.vec3(0, 0.22, 0.165):scale((i - 4) / 2)))
							for j = 0, 4 * i do
								local offset = vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(j * (360 / (8 * i)) - 90.1, 0, 0.25, 0, 0, 0, 1), 0, 1, 0)
								particles:newParticle("minecraft:wax_off", anchorPos:copy():add(offset:copy():scale(i))):setVelocity(offset:copy():scale(0.35)):setScale(2):setLifetime(32):setColor(particleColor)
							end
						end
					end

					if tick >= 54 and tick < 92 and (tick - 54) % 8 == 0 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head):add(0, 0.25, 0)
						local bodyYaw = player:getBodyYaw()
						for i = 1, 7 do
							particles:newParticle("minecraft:happy_villager", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 45, 0, -0.1, 0, 0, 0, 1), 0, 1, 0)):setScale(0.75):setLifetime(10)
						end
						if tick >= 66 then
							sounds:playSound("minecraft:entity.egg.throw", anchorPos, 0.25, 2)
						end
					end
					local vaporAnchor1 = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallTable.TakoyakiTableItems.TakoyakiPlate.TakoyakiPlate2.ExSkill1ParticleAnchor1)
					local bodyYaw = player:getBodyYaw()
					for _ = 1, 2 do
						self.exSkill.primary.spawnVaporParticle(self, vaporAnchor1:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 1.874375 - 0.921875, 0, math.random() * 0.484375 - 0.2421875, 0, 1, 0)))
					end
					local vaporAnchor2 = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallTable.TakoyakiTableItems.Takoyaki.ExSkill1ParticleAnchor2)
					self.exSkill.primary.spawnVaporParticle(self, vaporAnchor2:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.6875 - 0.34375, 0, math.random() * 0.4375 - 0.21875, 0, 1, 0)))
					local vaporAnchor3 = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallTable.IkayakiTableItems.IkayakiPlate.ExSkill1ParticleAnchor3)
					for _ = 1, 2 do
						self.exSkill.primary.spawnVaporParticle(self, vaporAnchor3:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 1.6875 - 0.84375, 0, math.random() * 0.484375 - 0.2421875, 0, 1, 0)))
					end
					if tick >= 54 and tick % 2 == 0 then
						local vaporAnchor4 = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.leftArmBottom.Takoyaki3.ExSkill1ParticleAnchor4)
						self.exSkill.primary.spawnVaporParticle(self, vaporAnchor4:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.265625 - 0.1328125, 0, math.random() * 0.265625 - 0.1328125, 0, 1, 0)))
					end
					if tick % 4 == 0 and not host:isHost() then
						for _, anchorPos in ipairs({vaporAnchor1, vaporAnchor3}) do
							sounds:playSound("minecraft:block.fire.extinguish", anchorPos, 0.005, 0.5)
						end
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if models.models.ex_skill_1.Dogs.Dog3.Dog3UpperBody.Dog3RightArm.Ikayaki9 ~= nil then
						models.models.ex_skill_1.Dogs.Dog3.Dog3UpperBody.Dog3RightArm.Ikayaki9:moveTo(ModelAlias.alias.avatar.rightArmBottom)
					end
					if ModelAlias.alias.avatar.rightArmBottom.ChocoBanana ~= nil then
						ModelAlias.alias.avatar.rightArmBottom.ChocoBanana:moveTo(models.models.ex_skill_1.Dogs.Dog3.Dog3UpperBody.Dog3RightArm)
					end
					for _, modelPart in ipairs({ModelAlias.alias.avatar.rightArmBottom.Dumplings, ModelAlias.alias.avatar.leftArmBottom.Takoyaki3, ModelAlias.alias.avatar.rightArmBottom.Ikayaki9}) do
						modelPart:setVisible(false)
					end
					events.RENDER:remove("ex_skill_1_render")
					if forcedStop then
						Bubble:stop()
					else
						local bodyYaw = player:getBodyYaw()
						PlacementObjectManager:spawn(1, player:getPos():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 1, 4, 0, 1, 0)), (bodyYaw * -1 + 180) % 360)
					end
				end;

				onPostTransition = function (self, forcedStop)
					if not forcedStop and not self.exSkill.primary.didTipShow and host:isHost() then
						print(Locale:getLocalizedText("message.firework.tip_1"):format(KeyManager.keyMappings["ex_skill"].keybind:getKeyName()))
						print(Locale:getLocalizedText("message.firework.tip_2"):format(KeyManager.keyMappings["firework_launch"].keybind:getKeyName()))
						self.exSkill.primary.didTipShow = true
					end
				end;
			};

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			init = false;

			---ヒントメッセージを表示したかどうか
			---@type boolean
			didTipShow = false;

			---花火台発射のクールダウン
			---@type integer
			launcherCooldown = 0;

			---屋台のたこ焼き看板のテキストレンダータスクを作成する。
			---@param parentModel ModelPart テキストレンダータスクを作成する対象の親パーツ
			---@param posOffset Vector3 テキストレンダータスクの位置オフセット
			---@param rot number テキストレンダータスク設置の基準となるY軸の向き
			makeTakoyakiText = function (parentModel, posOffset, rot)
				local parentName = parentModel:getName()
				parentModel:newText(parentName.."_takoyaki_text_1"):setText("§0§lたこやき"):setPos(vectors.rotateAroundAxis(rot, 0, 3, 0, 0, 1, 0):add(posOffset)):setRot(0, rot, 0):setScale(0.85, 0.85, 0.85):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
				parentModel:newText(parentName.."_flavor_text_1"):setText("§2§l本場の味"):setPos(vectors.rotateAroundAxis(rot, -9, 5, 0, 0, 1, 0):add(posOffset)):setRot(0, rot, 0):setScale(0.25, 0.25, 0.25):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
				parentModel:newText(parentName.."_takoyaki_text_2"):setText("§0§lたこやき"):setPos(vectors.rotateAroundAxis(rot + 180, 0, 3, -1.02, 0, 1, 0):add(posOffset)):setRot(0, rot + 180, 0):setScale(0.85, 0.85, 0.85):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
				parentModel:newText(parentName.."_flavor_text_2"):setText("§2§l本場の味"):setPos(vectors.rotateAroundAxis(rot + 180, -9, 5, -1.02, 0, 1, 0):add(posOffset)):setRot(0, rot + 180, 0):setScale(0.25, 0.25, 0.25):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
			end;

			---屋台のいか焼き看板のテキストレンダータスクを作成する。
			---@param parentModel ModelPart テキストレンダータスクを作成する対象の親パーツ
			---@param posOffset Vector3 テキストレンダータスクの位置オフセット
			---@param rot number テキストレンダータスク設置の基準となるY軸の向き
			makeIkayakiText = function (parentModel, posOffset, rot)
				local parentName = parentModel:getName()
				parentModel:newText(parentName.."_ikayaki_text_1"):setText("§4§lいかやき"):setPos(vectors.rotateAroundAxis(rot, 0, 3, 0, 0, 1, 0):add(posOffset)):setRot(0, rot, 0):setScale(0.85, 0.85, 0.85):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
				parentModel:newText(parentName.."_flavor_text_1"):setText("§1§l海の味"):setPos(vectors.rotateAroundAxis(rot, 15, 5, 0, 0, 1, 0):add(posOffset)):setRot(rot % 360 == 90 and vectors.vec3(-90, 80, -90) or (rot % 360 == 270 and vectors.vec3(90, -80, -90) or vectors.vec3(0, 0, -10))):setScale(0.35, 0.35, 0.35):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
				parentModel:newText(parentName.."_ikayaki_text_2"):setText("§4§lいかやき"):setPos(vectors.rotateAroundAxis(rot + 180, 0, 3, -1.02, 0, 1, 0):add(posOffset)):setRot(0, rot + 180, 0):setScale(0.85, 0.85, 0.85):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
				parentModel:newText(parentName.."_flavor_text_2"):setText("§1§l海の味"):setPos(vectors.rotateAroundAxis(rot + 180, 15, 5, -1.02, 0, 1, 0):add(posOffset)):setRot((rot + 180) % 360 == 90 and vectors.vec3(-90, 80, -90) or ((rot + 180) % 360 == 270 and vectors.vec3(90, -80, -90) or vectors.vec3(0, 0, -10))):setScale(0.35, 0.35, 0.35):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
			end;

			---湯気のパーティクルを1つスポーンさせる。
			---@param self BlueArchiveCharacter
			---@param pos Vector3 パーティクルのスポーン座標
			spawnVaporParticle = function (self, pos)
				particles:newParticle("minecraft:poof", pos):setVelocity(math.random() * 0.05 - 0.025, 0.035, math.random() * 0.05 - 0.025):setScale(0.25)
			end;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "HELMET" then
					if isVisible then
						self.physics.physicData[3].z.vertical.max = 10
						self.physics.physicData[3].z.horizontal.max = 10
						self.physics.physicData[4].z.vertical.min = -10
						self.physics.physicData[4].z.horizontal.min = -10
						ModelAlias.alias.avatar.head.Brim:setVisible(false)
					else
						self.physics.physicData[3].z.vertical.max = 180
						self.physics.physicData[3].z.horizontal.max = 180
						self.physics.physicData[4].z.vertical.min = -180
						self.physics.physicData[4].z.horizontal.min = -180
						ModelAlias.alias.avatar.head.Brim:setVisible(true)
					end
				elseif parts == "CHEST_PLATE" then
					if isVisible then
						ModelAlias.alias.avatar.body.BackRibbons:setVisible(false)
						ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, -1)
						ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, 1)
					else
						ModelAlias.alias.avatar.body.BackRibbons:setVisible(true)
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Hairs.FrontHair, ModelAlias.alias.avatar.body.Hairs.BackHair}) do
							modelPart:setPos()
						end
					end
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
				end
			end;
		};

		---前ティックに脚とスカートの調整をしたかどうか
		---@type boolean
		shouldAdjustLegsPrev = false;

		---前ティックは脚を隠すべきだったかどうか
		---@type boolean
		shouldHideLegsPrev = false;
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						if ExSkill.animationCount == -1 then
							FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", duration, true)
						end
					elseif type == "HEART" then
						FaceParts:setEmotion("NARROW", "NARROW", "SMILE", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CIRCLE", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", duration, true)
					end
				end
			end;

			onStop = function (_, _, forcedStop)
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
				ModelAlias.alias.dummy_avatar.lowerBody:setVisible(false)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot()
				ModelAlias.alias.dummy_avatar.body.Skirt:setScale(1.75, 0.35, 1.75)
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.body.Skirt.Skirt2, ModelAlias.alias.dummy_avatar.body.Skirt.Skirt2.Skirt3}) do
					modelPart:setScale()
				end
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.lowerBody:setVisible(true)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt:setScale(1.2, 1, 1)
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
				models = {ModelAlias.alias.avatar.head.Ears.RightEar};

				z = {
					vertical = {
						min = 5;
						neutral = 10;
						max = 180;

						bodyY = {
							multiplayer = -80;
							min = 5;
							max = 180;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 5;
							max = 90;
						};
					};

					horizontal = {
						min = 5;
						neutral = 10;
						max = 180;

						bodyX = {
							multiplayer = -80;
							min = 5;
							max = 180;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Ears.LeftEar};

				z = {
					vertical = {
						min = -180;
						neutral = -10;
						max = -5;

						bodyY = {
							multiplayer = 80;
							min = -180;
							max = -5;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -5;
						};
					};

					horizontal = {
						min = -180;
						neutral = -10;
						max = -5;

						bodyX = {
							multiplayer = 80;
							min = -180;
							max = -5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Brim.BrimRightRibbon};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 0;

						headRotMultiplayer = -1;
					};
				};

				z = {
					vertical = {
						min = -35;
						neutral = 0;
						max = 150;

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};

						headZ = {
							multiplayer = -80;
							min = -35;
							max = 90;
						};

						headRot = {
							multiplayer = -0.05;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = -35;
						neutral = 10;
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
				models = {ModelAlias.alias.avatar.head.Brim.BrimLeftRibbon};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 0;

						headRotMultiplayer = -1;
					};
				};

				z = {
					vertical = {
						min = -150;
						neutral = 0;
						max = 35;

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = 0;
						};

						headZ = {
							multiplayer = -80;
							min = -90;
							max = 35;
						};

						headRot = {
							multiplayer = 0.05;
							min = -150;
							max = 0;
						};
					};

					horizontal = {
						min = -150;
						neutral = -10;
						max = 35;

						bodyX = {
							multiplayer = 80;
							min = -150;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BackRibbons.BackRibbon1, ModelAlias.alias.avatar.body.BackRibbons.BackRibbon2};

				x = {
					vertical = {
						min = -145;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = -70;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -145;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -70;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BackRibbons.BackRibbon3, ModelAlias.alias.avatar.body.BackRibbons.BackRibbon4};

				x = {
					vertical = {
						min = -140;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = -65;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -140;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -65;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BackRibbons.BackRibbon2.BackRibbon2ZPivot, ModelAlias.alias.avatar.body.BackRibbons.BackRibbon4.BackRibbon4ZPivot};

				z = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 90;

						bodyX = {
							multiplayer = -20;
							min = 0;
							max = 5;
						};

						bodyZ = {
							multiplayer = -80;
							min = -80;
							max = 90;
						};

						bodyRot = {
							multiplayer = 0.01;
							min = 0;
							max = 5;
						};
					};

					horizontal = {
						min = -80;
						neutral = 0;
						max = 90;

						bodyX = {
							multiplayer = -20;
							min = 0;
							max = 5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BackRibbons.BackRibbon1.BackRibbon1ZPivot, ModelAlias.alias.avatar.body.BackRibbons.BackRibbon3.BackRibbon3ZPivot};

				z = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 80;

						bodyX = {
							multiplayer = -20;
							min = -5;
							max = 0;
						};

						bodyZ = {
							multiplayer = -80;
							min = -90;
							max = 80;
						};

						bodyRot = {
							multiplayer = 0.01;
							min = -5;
							max = 0;
						};
					};

					horizontal = {
						min = -90;
						neutral = 0;
						max = 80;

						bodyX = {
							multiplayer = -20;
							min = -5;
							max = 0;
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
		---視覚上のロケット花火オブジェクトのインスタンスクラス
		---@type Firework
		Firework = require("scripts.firework")

		---視覚上のロケット花火オブジェクトのマネージャークラス
		---@type FireworkManager
		FireworkManager = require("scripts.firework_manager")
		FireworkManager = FireworkManager.new()

		FireworkManager:init()

        events.TICK:register(function ()
            local skirtVisible = ModelAlias.alias.avatar.body.Skirt:getVisible()
            local shouldHideLegs = skirtVisible and player:getVehicle() ~= nil
            if shouldHideLegs and not self.costume.shouldHideLegsPrev then
                ModelAlias.alias.avatar.legs:setVisible(false)
				ModelAlias.alias.avatar.body.Skirt:setRot()
                ModelAlias.alias.avatar.body.Skirt:setScale(2, 0.35, 2)
				for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt.Skirt2, ModelAlias.alias.avatar.body.Skirt.Skirt2.Skirt3}) do
					modelPart:setScale()
				end
            elseif not shouldHideLegs and self.costume.shouldHideLegsPrev then
                ModelAlias.alias.avatar.legs:setVisible(true)
                ModelAlias.alias.avatar.body.Skirt:setScale()
            end

            local shouldAdjustLegs = skirtVisible and not shouldHideLegs
            if shouldAdjustLegs and not self.costume.shouldAdjustLegsPrev then
                events.RENDER:register(function ()
                    local rightLegRotX = vanilla_model.RIGHT_LEG:getOriginRot().x
                    ModelAlias.alias.avatar.rightLeg:setRot(rightLegRotX * -0.55, 0, 0)
                    ModelAlias.alias.avatar.leftLeg:setRot(vanilla_model.LEFT_LEG:getOriginRot().x * -0.55, 0, 0)
                    local rightLegRotAbs = math.abs(rightLegRotX)
                    ModelAlias.alias.avatar.body.Skirt:setScale(1, 1, rightLegRotAbs * 0.0025 + 1)
                    local skirtScale2 = vectors.vec3(rightLegRotAbs * -0.000625 + 1, 1, rightLegRotAbs * 0.00125 + 1)
                    ModelAlias.alias.avatar.body.Skirt.Skirt2:setScale(skirtScale2)
                    ModelAlias.alias.avatar.body.Skirt.Skirt2.Skirt3:setScale(skirtScale2)
                end, "skirt_render")
            elseif not shouldAdjustLegs and self.costume.shouldAdjustLegsPrev then
                events.RENDER:remove("skirt_render")
                for _, modelPart in ipairs({ModelAlias.alias.avatar.rightLeg, ModelAlias.alias.avatar.leftLeg}) do
                    modelPart:setRot()
                end
                if not shouldHideLegs then
                    for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt, ModelAlias.alias.avatar.body.Skirt.Skirt2, ModelAlias.alias.avatar.body.Skirt.Skirt2.Skirt3}) do
                        modelPart:setScale()
                    end
                end
            end
            self.costume.shouldHideLegsPrev = shouldHideLegs
            self.costume.shouldAdjustLegsPrev = shouldAdjustLegs
        end)

        events.RENDER:register(function (_, context)
            if ExSkill.animationCount == -1 and context ~= "FIRST_PERSON" then
                if Gun.currentGunPosition == "NONE" then
                    ModelAlias.alias.avatar.rightArm.RightSleeve:setRot(math.clamp(vanilla_model.RIGHT_ARM:getOriginRot().x * -1 + 90, -35, 35), 0, 0)
                    ModelAlias.alias.avatar.leftArm.LeftSleeve:setRot(math.clamp(vanilla_model.LEFT_ARM:getOriginRot().x * -1 + 90, -35, 35), 0, 0)
                else
                    ModelAlias.alias.avatar.rightArm.RightSleeve:setRot(math.clamp(ModelAlias.alias.avatar.rightArm:getRot().x * -1 + 90, -35, 35), 0, 0)
                    ModelAlias.alias.avatar.leftArm.LeftSleeve:setRot(math.clamp(ModelAlias.alias.avatar.leftArm:getRot().x * -1 + 90, -35, 35), 0, 0)
                end
            else
                for _, modelPart in ipairs({ModelAlias.alias.avatar.rightArm.RightSleeve, ModelAlias.alias.avatar.leftArm.LeftSleeve}) do
                    modelPart:setRot()
                end
            end
            ModelAlias.alias.avatar.rightArm.RightSleeve:setOffsetPivot(0, ModelAlias.alias.avatar.rightArm.RightSleeve:getTrueRot().x < 0 and -7 or 0, 0)
            ModelAlias.alias.avatar.leftArm.LeftSleeve:setOffsetPivot(0, ModelAlias.alias.avatar.leftArm.LeftSleeve:getTrueRot().x < 0 and -7 or 0, 0)
        end)

        if host:isHost() then
			KeyManager:register("firework_launch", "key.keyboard.v"):onPress(function ()
				if #PlacementObjectManager.objects > 0 then
					if self.exSkill.primary.launcherCooldown == 0 then
						pings.launchFireworks()
						self.exSkill.primary.launcherCooldown = 200
					else
						MiscUtils.playErrorSound()
						print(Locale:getLocalizedText("message.firework.in_cool_down"):format(self.exSkill.primary.launcherCooldown / 20))
					end
				end
			end)

            events.TICK:register(function ()
                if not client:isPaused() then
                    self.exSkill.primary.launcherCooldown = math.max(self.exSkill.primary.launcherCooldown - 1, 0)
                end
            end)
        end
	end;
}

function pings.launchFireworks()
    PlacementObjectManager:applyFunc(1, function (object, i)
        object.animationCount = 0
    end)
end

return BlueArchiveCharacter
