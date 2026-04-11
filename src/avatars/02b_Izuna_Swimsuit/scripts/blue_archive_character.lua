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
---| "ANGRY" # 上釣り目
---| "CLOSED2" # 横棒

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "ANGRY" # 怒った目
---| "CLOSED2" # 横棒

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "CIRCLE" # 丸口
---| "SMILE" # にっこり
---| "SAD" # への口

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
		avatarName = "02b_Izuna_Swimsuit";

		birth = {
			month = 7;
			day = 7;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			ANGRY = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(7, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			ANGRY = vectors.vec2(5, 0);
			CLOSED2 = vectors.vec2(6, 0);
		};

		mouth = {
			OPENED = vectors.vec2(0, 0);
			CIRCLE = vectors.vec2(1, 0);
			SMILE = vectors.vec2(2, 0);
			SAD = vectors.vec2(3, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 1, -6);
					left = vectors.vec3(2.25, 1, -6);
				};

				thirdPersonPos = {
					right = vectors.vec3(-0.5, 0, -7);
					left = vectors.vec3(2.5, 0, -7);
				}
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, 1, 3);
					left = vectors.vec3(2, 1, 3);
				};

				rot = {
					right = vectors.vec3(-20, 90, 0);
					left = vectors.vec3(-20, -90, 0);
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
			model = models.models.kitsune_puppet.PlacementObject;

			boundingBox = {
				size = vectors.vec3(12, 19, 12)
			};

			placementMode = "MOVE";

			callbacks = {
				onInit = function (self)
					animations["models.kitsune_puppet"]["swing"]:play()
					self.placementObjects.swingCoolDown = 60
				end;

				onTick = function (self, placementObject)
					if raycast:entity(placementObject.currentPos, placementObject.currentPos:copy():add(0, 1.2, 0), function (entity)
						return entity:isLiving() and entity:isMoving()
					end) and self.placementObjects.swingCoolDown == 0 then
						animations["models.kitsune_puppet"]["swing"]:play()
						self.placementObjects.swingCoolDown = 60
					end
					self.placementObjects.swingCoolDown = math.max(self.placementObjects.swingCoolDown - 1, 0)
				end;
			};

			---人形が揺れるアニメーション再生後に再び再生できるようになるまでの時間
			---@type integer
			swingCoolDown = 60
		};
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_1.BeachBall};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, -160, -10);
					pos = vectors.vec3(-6, 30, -60);
				};

				fin = {
					rot = vectors.vec3(-10, -150, -10);
					pos = vectors.vec3(-4, 154, -350);
				};

				legacyMode = true;
			};

			callbacks = {
				onAnimationTick = function (_, tick)
					if tick < 25 then
						if tick == 0 then
							FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", 19, true)
						elseif tick == 19 then
							FaceParts:setEmotion("ANGRY", "ANGRY", "CIRCLE", 2, true)
						elseif tick == 21 then
							FaceParts:setEmotion("CLOSED", "CLOSED", "CIRCLE", 22, true)
						end
						local anchor1Pos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						local particleBlock = world.getBlockState(anchor1Pos:copy() - 1).id
						if particleBlock ~= "minecraft:air" and particleBlock ~= "minecraft:void_air" then
							for _ = 1, 50 do
								particles:newParticle("minecraft:block " .. particleBlock, anchor1Pos:copy():add(math.random() - 0.5, 0, math.random() - 0.5)):setVelocity(math.random() * 0.5 - 0.25, math.random() * 0.5, math.random() * 0.5 - 0.25)
							end
						end
					elseif tick == 25 then
						ModelAlias.alias.avatar.root:setVisible(false)
						local anchor1Pos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root)
						for _ = 1, 30 do
							particles:newParticle("minecraft:poof", anchor1Pos:copy():add(math.random() - 0.5, math.random() * 2, math.random() - 0.5))
						end
						sounds:playSound("minecraft:entity.bat.takeoff", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 2)
					elseif tick == 28 then
						renderer:setPostEffect("phosphor")
					elseif tick == 38 then
						renderer:setPostEffect()
					elseif tick == 43 then
						ModelAlias.alias.avatar.root:setVisible(true)
						FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", 42, true)
					elseif tick == 44 then
						local avatarPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root):add(0, -1.5, 0)
						for _ = 1, 30 do
							particles:newParticle("minecraft:poof", avatarPos:copy():add(math.random() - 0.5, math.random() * 2, math.random() - 0.5))
						end
					elseif tick >= 45 and tick <= 60 then
						local avatarPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body)
						if tick == 45 then
							local bodyYaw = player:getBodyYaw()
							local particleDirection = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(40, 0, 0, 1, 1, 0, 0), 0, 1, 0)
							for i = 1, 30 do
								for j = 0.7, 1.5, 0.1 do
									particles:newParticle("minecraft:dust 1 1 1 1", vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(40, math.cos(math.rad(i * 12)) * j, math.sin(math.rad(i * 12)) * j, 0, 1, 0, 0), 0, 1, 0):add(avatarPos)):setColor(math.random() * 0.25 + 0.5, 1, 1):setVelocity(particleDirection:copy():scale(math.random() * 0.1 + 0.2)):setLifetime(math.random() * 10 + 10)
								end
								local particlePos = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(40, math.cos(math.rad(i * 12)) * 1.5, math.sin(math.rad(i * 12)) * 1.5, 0, 1, 0, 0), 0, 1, 0):add(avatarPos)
								particles:newParticle("minecraft:dust 1 1 1 1", particlePos):setColor(1, 1, 1):setVelocity(particleDirection:copy():scale(math.random() * 0.1 + 0.2)):setLifetime(math.random() * 10 + 10)
							end
						end
						sounds:playSound("minecraft:item.bucket.empty", avatarPos, 1 - math.map(tick, 45, 60, 0, 0.5), 0.75)
					elseif tick == 79 and host:isHost() then
						models.models.ex_skill_1.CameraBackground:setVisible(true)
						local windowSize = client:getWindowSize()
						models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(45))
						local shouldAdjustBackgroundRot = client:getVersion() >= "1.21"
						events.RENDER:register(function (delta, context)
							models.models.ex_skill_1.CameraBackground:setVisible(context == "RENDER")
							local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(2)), 0, 1, 0):scale(16 / 0.9375)
							models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
							models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
							if shouldAdjustBackgroundRot then
								models.models.ex_skill_1.CameraBackground.Background:setRot(0, 0, renderer:getCameraRot().z)
							end
						end, "ex_skill_2_background_render")
						ModelAlias.alias.avatar.root:setColor(0, 0, 0)
						for _, modelPart in ipairs({ModelAlias.alias.avatar.root, models.models.ex_skill_1.BeachBall}) do
							modelPart:setColor(0, 0, 0)
						end
					elseif tick == 80 then
						renderer:setPostEffect("invert")
					elseif tick == 84 then
						renderer:setPostEffect()
					elseif tick == 85 then
						FaceParts:setEmotion("ANGRY", "ANGRY", "OPENED", 16, true)
						models.models.ex_skill_1.BeachBall:setUVPixels(0, 7)
						models.models.ex_skill_1.BeachBall:setPrimaryRenderType("EMISSIVE_SOLID")
						sounds:playSound("minecraft:entity.blaze.death", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root), 1, 2)
					elseif tick == 86 then
						local bodyYaw = player:getBodyYaw()
						local anchor2Pos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root):add(vectors.rotateAroundAxis(-bodyYaw, -0.1, 0, 0, 0, 1, 0)):add(0, 0.4, 0)
						local particleAxis = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(30, 0, 0, 1, 1, 0, 0), 0, 1, 0)
						local particleVelocityDirection = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(-50, 0, 0, 1, 1, 0, 0), 0, 1, 0)
						for i = 1, 60 do
							local currentParticleVelocityDirection = vectors.rotateAroundAxis(i * 6, particleVelocityDirection, particleAxis)
							for _, particleData in ipairs({{0.5, 0.4, 0.1}, {0.25, 0.6, 0.025}, {0.375, 2, 0.05}}) do --[1]. 輪っかの半径, [2]. 輪っかの位置のスケール, [3]. 輪っかの拡散速度のスケール
								particles:newParticle("minecraft:dust 1 0 0 1", vectors.rotateAroundAxis(i * 6, 0, particleData[1], 0, particleAxis):add(anchor2Pos):add(0, 0.7, 0):add(particleAxis:copy():scale(particleData[2]))):setVelocity(currentParticleVelocityDirection:copy():scale(particleData[3])):setLifetime(20)
								particles:newParticle("minecraft:dust 0 0 0 1", vectors.rotateAroundAxis(i * 6, 0, particleData[1] * 1.5, 0, particleAxis):add(anchor2Pos):add(0, 0.7, 0):add(particleAxis:copy():scale(particleData[2]))):setVelocity(currentParticleVelocityDirection:copy():scale(particleData[3])):setLifetime(20)
							end
						end
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							events.RENDER:remove("ex_skill_2_background_render")
							for _, modelPart in ipairs({ModelAlias.alias.avatar.root, models.models.ex_skill_1.BeachBall}) do
								modelPart:setColor()
							end
						end
					elseif tick >= 101 then
						local bodyYaw = player:getBodyYaw()
						local anchor2Pos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root):add(vectors.rotateAroundAxis(-bodyYaw, -0.1, 0, 0, 0, 1, 0)):add(0, 0.8, 0)
						local particleAxis = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(30, 0, 0, 1, 1, 0, 0), 0, 1, 0)
						local particleVelocityDirection = vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(-50, 0, 0, 1, 1, 0, 0), 0, 1, 0)
						if tick == 101 then
							FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 42, true)
							models.models.ex_skill_1.BeachBall:setUVPixels(0, 14)
							for i = 1, 60 do
								local currentParticleVelocityDirection = vectors.rotateAroundAxis(i * 6, particleVelocityDirection, particleAxis)
								for _, particleData in ipairs({{0.3, 3.5, 0.01, 0.5}, {0.5, 3.5, 0.01, 0.5}, {0.25, 7.9, 0.003, 0.2}, {0.28, 7.89, 0.003, 0.2}, {0.45, 7.85, 0.003, 0.5}}) do --[1]. 輪っかの半径, [2]. 輪っかの位置のスケール, [3]. 輪っかの拡散速度のスケール, [4]. 輪っかのパーティクルの大きさ
								local colorOffset = math.random() * 0.5 + 0.5
									particles:newParticle("minecraft:dust 1 1 1 1", vectors.rotateAroundAxis(i * 6, 0, particleData[1], 0, particleAxis):add(anchor2Pos):add(particleAxis:copy():scale(particleData[2]))):setScale(particleData[4]):setColor(1, colorOffset, colorOffset):setVelocity(currentParticleVelocityDirection:copy():scale(particleData[3])):setLifetime(45)
								end
							end
							sounds:playSound("minecraft:entity.lightning_bolt.thunder", ModelUtils.getModelWorldPos(models.models.ex_skill_1.BeachBall), 1, 2)
						end
						for _ = 1, 10 do
							local colorOffset = math.random() * 0.5 + 0.5
							particles:newParticle("minecraft:dust 1 1 1 1", anchor2Pos:copy():add(particleAxis:copy():scale(7.5)):add(vectors.rotateAroundAxis(-bodyYaw, 0, 0, 0.8, 0, 1, 0)):add(math.random() * 0.2 - 0.1, math.random() * 0.2 - 0.1 - 0.4, math.random() * 0.2 - 0.1)):setColor(1, colorOffset, colorOffset):setVelocity(particleAxis:copy():scale(-1))
						end
					end
					if tick <= 28 and tick % 4 == 0 then
						sounds:playSound("minecraft:block.sand.step", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root))
					end
				end;

				onPostAnimation = function (_, forcedStop)
					ModelAlias.alias.avatar.root:setVisible(true)
					models.models.ex_skill_1.BeachBall:setUVPixels()
					models.models.ex_skill_1.BeachBall:setPrimaryRenderType("CUTOUT")
					if host:isHost() then
						models.models.ex_skill_1.CameraBackground.Background:setColor()
						models.models.ex_skill_1.CameraBackground.Background:setOpacity(1)
						if forcedStop then
							events.RENDER:remove("ex_skill_2_background_render")
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							for _, modelPart in ipairs({ModelAlias.alias.avatar.root, models.models.ex_skill_1.BeachBall}) do
								modelPart:setColor()
							end
							renderer:setPostEffect()
						end
					end
				end;
			};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.SunVisor:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.Scarf:setPos(0, 0, isVisible and -1 or 0)
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.leftLeg.LegAccessory:setVisible(not isVisible)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if duration > 0 then
					if type == "GOOD" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", duration, true)
					elseif type == "HEART" then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
					elseif type == "NOTE" then
						FaceParts:setEmotion("ANGRY", "ANGRY", "OPENED", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SAD", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SAD", duration, true)
					end
				end
			end;

			onStop = function (_, _, forcedStop)
				if not forcedStop then
					FaceParts:resetEmotion()
				end
			end;
		}
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
				ModelAlias.alias.dummy_avatar.head.Ears.RightEarPivot:setRot(-49.02, -11.44, -9.77)
				ModelAlias.alias.dummy_avatar.head.Ears.LeftEarPivot:setRot(-49.02, 11.44, 9.77)
				ModelAlias.alias.dummy_avatar.head.HairAccessories.HairAccessoryRight.HairTail:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairAccessories.HairAccessoryRight.Braid:setRot(30, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(25, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairAccessories.HairAccessoryRight.HairTail:setRot(-15, 0, 0)
				ModelAlias.alias.dummy_avatar.head.HairAccessories.HairAccessoryRight.Braid:setRot(-15, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Tail:setRot(30, 0, 0)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
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
				models = {ModelAlias.alias.avatar.head.HairAccessories.HairAccessoryRight.HairTail};

				x = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
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
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessories.HairAccessoryRight.HairTail.HairTailZPivot};

				z = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 60;

						headZ = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};

						headRot = {
							multiplayer = -0.05;
							min = 0;
							max = 60;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessories.HairAccessoryRight.Braid};

				x = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;
						headRotMultiplayer = -1;

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
					};
				};

				z = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 60;

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 60;
						};

						headZ = {
							multiplayer = -160;
							min = 0;
							max = 60;
						};

						headRot = {
							multiplayer = -0.05;
							min = 0;
							max = 60;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.SunVisor.SunflowerAccessory.WhiteRibbon};

				z = {
					vertical = {
						min = -40;
						neutral = -20;
						max = 160;

						bodyY = {
							multiplayer = -160;
							min = -20;
							max = 160;
						};

						headZ = {
							multiplayer = -160;
							min = -40;
							max = 70;
						};

						headRot = {
							multiplayer = -0.1;
							min = -20;
							max = 70;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Scarf};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 90;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};

						bodyRot = {
							multiplayer = -0.1;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
						max = 90;

						headX = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};
					};
				};
			};
		};
	};

	---初期化関数
	init = function ()
		---忍術ワープの表現
		---@type Teleport
		Teleport = require("scripts.teleport")

		ModelAlias.alias.avatar.head.SunVisor.SunflowerAccessory.Sunflower:setPrimaryTexture("RESOURCE", "textures/block/sunflower_front.png")
		Teleport:init()

		events.RENDER:register(function ()
			if ModelAlias.alias.avatar.leftLeg.LegAccessory:getVisible() then
				ModelAlias.alias.avatar.leftLeg.LegAccessory:setRot((vanilla_model.LEFT_LEG:getOriginRot().x + ModelAlias.alias.avatar.leftLeg:getTrueRot().x) * -1, 0, 0)
			end
		end)
	end;
}

return BlueArchiveCharacter
