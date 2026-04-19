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
---| "CENTER" # 少し反対側を見る目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CLOSED2" # 閉じた目2
---| "CENTER" # 少し反対側を見る目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "ANXIOUS" # への口
---| "TRIANGLE" # 三角口
---| "SMILE" # にっこり

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
		avatarName = "15a_Hikari";

		birth = {
			month = 6;
			day = 14;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(5, 0);
			CENTER = vectors.vec2(7, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CLOSED2 = vectors.vec2(4, 0);
			CENTER = vectors.vec2(5, 0);
		};

		mouth = {
			ANXIOUS = vectors.vec2(0, 0);
			TRIANGLE = vectors.vec2(1, 0);
			SMILE = vectors.vec2(2, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				local armState = {right = right, left = left}
				if SyupogakiDance ~= nil and SyupogakiDance.danceState ~= "NOT_STANDBY" then
					armState.right = "DEFAULT"
					armState.left = "DEFAULT"
				else
					armState.right = armState.right == "GUN_OFF_HAND" and "DEFAULT" or armState.right
					armState.left = armState.left == "GUN_OFF_HAND" and "DEFAULT" or armState.left
				end
				return armState
			end;
		};
	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 0.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-1, -3.5, -2);
					left = vectors.vec3(1, -3.5, -2);
				};

				thirdPersonPos = {
					right = vectors.vec3(0, -3.5, -3);
					left = vectors.vec3(0, -3.5, -3);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(-4.5, -9, 0);
					left = vectors.vec3(-4.5, -9, 0);
				};

				rot = {
					right = vectors.vec3(-90, 0, 0);
					left = vectors.vec3(-90, 0, 0);
				};
			};
		};

		sound = {
			name = "minecraft:entity.iron_golem.hurt";
			pitch = 2;
		};
	};

	placementObjects = {

	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.rightArmBottom.Puncher, ModelAlias.alias.avatar.leftArmBottom.Ticket, models.models.ex_skill_1.Gui.TransitionArea, models.models.ex_skill_1.PopEffectCenter, models.models.ex_skill_1.ShineEffect};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(-61, 32, -77);
				};

				fin = {
					rot = vectors.vec3(-10, 135, 5);
					pos = vectors.vec3(16, 25, -8.25);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.didInit then
						if host:isHost() then
							for i = 1, 8 do
								models.models.ex_skill_1.Gui.TransitionArea:addChild(models.models.ex_skill_1.TransitionPart.TransitionPartLtoR:copy("TransitionPartLtoR"..i))
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setRot(0, 0, -15)
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setVisible(true)
								models.models.ex_skill_1.Gui.TransitionArea:addChild(models.models.ex_skill_1.TransitionPart.TransitionPartRtoL:copy("TransitionPartRtoL"..i))
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setRot(0, 0, -15)
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setVisible(true)
							end
						end
						---@diagnostic disable-next-line: discard-returns
						models.models.ex_skill_1:newPart("VillagerArea")
						for i = 1, 8 do
							models.models.ex_skill_1.VillagerArea:newEntity("ex_skill_1_villager_"..i):setNbt("minecraft:villager", "{}")
						end
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_1"):setPos(12, 0, -18):setRot(0, -30, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_2"):setPos(-12, 0, -18):setRot(0, 30, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_3"):setPos(64, 0, -64):setRot(0, -45, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_4"):setPos(28, 0, -64):setRot(0, -25, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_5"):setPos(48, 0, -40):setRot(0, -50, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_6"):setPos(24, 0, -40):setRot(0, -35, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_7"):setPos(0, 0, -64):setRot(0, 0, 0)
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_8"):setPos(-24, 0, -40):setRot(0, 35, 0)
						for i = 1, 2 do
							models.models.ex_skill_1.VillagerArea:addChild(models.models.ex_skill_1.ShockEffect:copy("ShockEffect"..i))
							models.models.ex_skill_1.VillagerArea["ShockEffect"..i]:setVisible(true)
						end
						models.models.ex_skill_1.VillagerArea.ShockEffect1:setPos(-9, 29, -22)
						models.models.ex_skill_1.VillagerArea.ShockEffect1:setRot(0, -60, 0)
						models.models.ex_skill_1.VillagerArea.ShockEffect2:setPos(62, 29, -64)
						models.models.ex_skill_1.VillagerArea.ShockEffect2:setRot(0, 45, 0)
						for i = 1, 2 do
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp1["Stamp1ShineEffect"..i]:setColor(0.996, 1, 0.663)
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp2["Stamp2ShineEffect"..i]:setColor(1, 0.698, 0.624)
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp3["Stamp3ShineEffect"..i]:setColor(0.714, 0.996, 0.812)
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp4["Stamp4ShineEffect"..i]:setColor(0.714, 0.996, 0.812)
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp6["Stamp6ShineEffect"..i]:setColor(1, 0.769, 0.988)
							ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp7["Stamp7ShineEffect"..i]:setColor(1, 0.635, 0.996)
						end
						self.exSkill.primary.didInit = true
					else
						models.models.ex_skill_1.VillagerArea:setVisible(true)
					end
					if host:isHost() then
						local windowSize = client:getScaledWindowSize()
						models.models.ex_skill_1.Gui.TransitionArea:setPos(windowSize:copy():scale(-0.5):augmented(0))
						local height = math.sqrt(windowSize.y ^ 2 + (math.tan(math.rad(15)) * windowSize.y) ^ 2) + math.tan(math.rad(15)) * 64
						local halfWidth = windowSize.x / 2 + math.tan(math.rad(15)) * windowSize.y + 1
						for i = 1, 8 do
							models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setPos(halfWidth, 0, 0)
							models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setScale(16, height, 1)
							models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setPos(halfWidth * -1, 0, 0)
							models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setScale(16, height, 1)
						end
					end
					local villagerTypes = client.getRegistry("minecraft:villager_type")
					local villagerProfessions = client.getRegistry("minecraft:villager_profession")
					for i = 1, 8 do
						models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_"..i):setNbt("minecraft:villager", "{\"VillagerData\": {\"level\": "..math.random(1, 5)..", \"profession\": \""..villagerProfessions[math.random(1, #villagerProfessions)].."\", \"type\": \""..villagerTypes[math.random(1, #villagerTypes)].."\"}}")
					end
					for i = 15, 54 do
						ModelAlias.alias.avatar.leftArmBottom.Ticket["Hole"..i]:setVisible(false)
					end
					ModelAlias.alias.avatar.leftArmBottom.Ticket.Stamp1.Stamp1:setUVPixels(0, math.random() >= 0.95 and 32 or 0)
					FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", 47, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 9 then
						self.exSkill.primary.playAngryVillagerEffect(player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, -1.5, 0, 2.5, 0, 1, 0)))
					elseif tick == 22 then
						self.exSkill.primary.playAngryVillagerEffect(player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, -1.75, 0, 4, 0, 1, 0)))
					elseif tick == 39 then
						self.exSkill.primary.playAngryVillagerEffect(player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 0, 4, 0, 1, 0)))
					elseif tick == 47 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 15, true)
					elseif tick == 62 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TRIANGLE", 2, true)
					elseif tick == 64 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 48, true)
					elseif tick == 80 and host:isHost() then
						local windowSize = client:getScaledWindowSize()
						local moveWidth = windowSize.x + math.tan(math.rad(15)) * windowSize.y * 2 + 2
						events.RENDER:register(function ()
							for i = 1, 8 do
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setPos(models.models.ex_skill_1.Gui.TransitionArea["TransitionAnchorRtoL"..i]:getAnimPos().x * moveWidth, 0, 0)
							end
						end, "ex_skill_1_render")
					elseif tick == 86 then
						if host:isHost() then
							ModelAlias.alias.avatar.head:setVisible(false)
						end
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole15:setVisible(true)
						for i = 23, 54 do
							ModelAlias.alias.avatar.leftArmBottom.Ticket["Hole"..i]:setVisible(true)
						end
					elseif tick == 88 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole22:setVisible(true)
					elseif tick == 91 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole21:setVisible(true)
					elseif tick == 93 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole20:setVisible(true)
					elseif tick == 94 then
						if host:isHost() then
							events.RENDER:remove("ex_skill_1_render")
						end
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole19:setVisible(true)
					elseif tick == 96 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole18:setVisible(true)
					elseif tick == 99 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole17:setVisible(true)
					elseif tick == 100 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.Hole16:setVisible(true)
					elseif tick >= 111 and tick <= 121 and (tick - 111) % 2 == 0 then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.5, 1.85)
					elseif tick == 112 then
						if host:isHost() then
							ModelAlias.alias.avatar.head:setVisible(true)
						end
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 22, true)
					elseif tick == 130 and host:isHost() then
						local windowSize = client:getScaledWindowSize()
						local moveWidth = windowSize.x + math.tan(math.rad(15)) * windowSize.y * 2 + 2
						local height = math.sqrt(windowSize.y ^ 2 + (math.tan(math.rad(15)) * windowSize.y) ^ 2) + math.tan(math.rad(15)) * 64
						events.RENDER:register(function ()
							for i = 1, 8 do
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setPos(models.models.ex_skill_1.Gui.TransitionArea["TransitionAnchorLtoR"..i]:getAnimPos().x * moveWidth, 0, 0)
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartLtoR"..i]:setScale(models.models.ex_skill_1.Gui.TransitionArea["TransitionAnchorLtoR"..i]:getAnimScale():mul(16, height, 1))
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setPos(models.models.ex_skill_1.Gui.TransitionArea["TransitionAnchorRtoL"..i]:getAnimPos().x * moveWidth, 0, 0)
								models.models.ex_skill_1.Gui.TransitionArea["TransitionPartRtoL"..i]:setScale(models.models.ex_skill_1.Gui.TransitionArea["TransitionAnchorRtoL"..i]:getAnimScale():mul(16, height, 1))
							end
						end, "ex_skill_1_render")
					elseif tick == 134 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", 16, true)
					elseif tick == 141 and host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
					elseif tick == 143 then
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.25, 1)
					elseif tick == 147 and host:isHost() then
						models.models.ex_skill_1.Gui.ScreenFilter:setScale(client:getScaledWindowSize():augmented(1))
						models.models.ex_skill_1.Gui.ScreenFilter:setVisible(true)
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.ScreenFilter:setOpacity(models.models.ex_skill_1.Gui.ScreenFilterOpacity:getAnimScale().x)
						end, "ex_skill_1_render")
					elseif tick == 150 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TRIANGLE", 2, true)
					elseif tick == 152 then
						FaceParts:setEmotion("NORMAL", "CENTER", "TRIANGLE", 40, true)
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
					elseif tick == 154 and host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						models.models.ex_skill_1.Gui.ScreenFilter:setVisible(false)
					elseif tick == 160 then
						ModelAlias.alias.avatar.leftArmBottom.Ticket.TicketShineEffect:setOffsetPivot(-0.5, 0, 0)
					end

					for _, villagerId in ipairs({1, 5}) do
						local anchorPos = player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, models.models.ex_skill_1.VillagerArea:getTask("ex_skill_1_villager_"..villagerId):getPos():scale(-0.0575):add(0, 1.5, 0), 0, 1, 0))
						particles:newParticle("minecraft:splash", anchorPos):setPower(1.2)
					end
					if tick < 47 and tick % 4 == 0 then
						sounds:playSound("minecraft:block.bubble_column.bubble_pop", player:getPos(), 0.25, 2 - math.random() * 0.5)
					elseif ((tick >= 47 and tick < 61) or (tick >= 69 and tick < 108)) and (tick - 47) % 6 == 0 then
						sounds:playSound("minecraft:entity.sheep.shear", player:getPos(), 0.25, 2)
					end
					if tick < 86 and tick % 2 == 0 then
						particles:newParticle("minecraft:angry_villager", player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, math.random() * 2 - 1, math.random() * 2, 0, 0, 1, 0)))
					end
					if math.random() > 0.95 then
						sounds:playSound("minecraft:entity.villager.ambient", player:getPos(), 0.25, 1)
					end
				end;

				onPostAnimation = function (_, forcedStop)
					models.models.ex_skill_1.VillagerArea:setVisible(false)
					for i = 15, 54 do
						ModelAlias.alias.avatar.leftArmBottom.Ticket["Hole"..i]:setVisible(false)
					end
					ModelAlias.alias.avatar.leftArmBottom.Ticket.TicketShineEffect:setOffsetPivot()
					if forcedStop and host:isHost() then
						events.RENDER:remove("ex_skill_1_render")
						ModelAlias.alias.avatar.head:setVisible(true)
						models.models.ex_skill_1.Gui.ScreenFilter:setVisible(false)
					end
				end;
			};

			---このExスキルの初期化処理がされたかどうか
			---@type boolean
			didInit = false;

			---村人が怒っている演出を再生する。
			playAngryVillagerEffect = function (anchorPos)
				for _ = 1, 5 do
					particles:newParticle("minecraft:angry_villager", anchorPos:copy():add(math.random() * 1 - 0.5, math.random() * 1 + 0.5, math.random() * 1 - 0.5))
				end
				sounds:playSound("minecraft:entity.villager.no", anchorPos, 1, 1)
			end;
		};

		callbacks = {
			additionalCheckFunc = function ()
				return SyupogakiDance.danceState == "NOT_STANDBY"
			end;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.Hat:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					if isVisible then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.ShoulderBag, ModelAlias.alias.avatar.body.BeltAccessories}) do
							modelPart:setVisible(false)
						end
						ModelAlias.alias.avatar.body.Hairs.FrontHair:setPos(0, 0, -1)
						ModelAlias.alias.avatar.body.Hairs.BackHair:setPos(0, 0, 1)
						self.physics.physicData[1].x.vertical.neutral = 0
						self.physics.physicData[1].x.vertical.max = 0
						self.physics.physicData[1].x.vertical.bodyX.max = 0
						self.physics.physicData[1].x.vertical.bodyY.max = 0
						self.physics.physicData[1].x.vertical.bodyRot.max = 0
						self.physics.physicData[1].x.horizontal.neutral = 0
						self.physics.physicData[1].x.horizontal.max = 0
					else
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.ShoulderBag, ModelAlias.alias.avatar.body.BeltAccessories}) do
							modelPart:setVisible(true)
						end
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Hairs.FrontHair, ModelAlias.alias.avatar.body.Hairs.BackHair}) do
							modelPart:setPos()
						end
						self.physics.physicData[1].x.vertical.neutral = -17.5
						self.physics.physicData[1].x.vertical.max = -17.5
						self.physics.physicData[1].x.vertical.bodyX.max = -17.5
						self.physics.physicData[1].x.vertical.bodyY.max = -17.5
						self.physics.physicData[1].x.vertical.bodyRot.max = -17.5
						self.physics.physicData[1].x.horizontal.neutral = -17.5
						self.physics.physicData[1].x.horizontal.max = -17.5
					end
				elseif parts == "LEGGINGS" then
					ModelAlias.alias.avatar.body.Skirt:setVisible(not isVisible)
				end
			end;
		};
	};

	bubble = {
		callbacks = {
			additionalCheckFunc = function ()
				return SyupogakiDance.danceState == "NOT_STANDBY"
			end;

			onPlay = function (_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", duration, true)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", duration, true)
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
				ModelAlias.alias.dummy_avatar.body.TailXPivot:setRot(10, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(60, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.body.Hairs.BackHair:setRot(-20, 0, -15)
				ModelAlias.alias.dummy_avatar.body.TailXPivot:setRot(60, 0, -15)
				ModelAlias.alias.dummy_avatar.body.TailXPivot.TailYPivot.Tail.Tail2:setRot(0, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt:setRot(10, 0, 0)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair},

				x = {
					vertical = {
						min = -150;
						neutral = -17.5;
						max = -17.5;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = -17.5;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = -17.5;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -17.5;
						};
					};

					horizontal = {
						min = -90;
						neutral = -17.5;
						max = -17.5;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Hairs.FrontHair};

				x = {
					vertical = {
						min = 2.5;
						neutral = 2.5;
						max = 150;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 2.5;
							max = 90;
						};

						bodyY = {
							multiplayer = -80;
							min = 2.5;
							max = 150;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 2.5;
							max = 90;
						};
					};

					horizontal = {
						min = 2.5;
						neutral = 90;
						max = 150;

						bodyX = {
							multiplayer = -80;
							min = 2.5;
							max = 150;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BeltAccessories};

				x = {
					vertical = {
						min = 22.5;
						neutral = 22.5;
						max = 155;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -160;
							min = 22.5;
							max = 90;
						};

						bodyY = {
							multiplayer = -160;
							min = 22.5;
							max = 155;
						};
					};

					horizontal = {
						min = 22.5;
						neutral = 90;
						max = 155;

						bodyX = {
							multiplayer = 22.5;
							min = -40;
							max = 155;
						};
					};
				};
			};

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
		---シュポガキダンスを制御するクラス
		---@type SyupogakiDance
		SyupogakiDance = require("scripts.syupogaki_dance")

		SyupogakiDance:init()
	end;
}

return BlueArchiveCharacter
