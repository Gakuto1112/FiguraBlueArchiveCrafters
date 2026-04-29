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
---| "INVERTED" # 困りつつ、反対側を見る目
---| "UNEQUAL" # ><

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "UNEQUAL" # ><
---| "CENTER" # 少し反対側を見る目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "OPENED" # 開いた口
---| "TRIANGLE" # 三角形の口
---| "FRUST" # ぐじゅぐじゅ口
---| "SMILE" # にっこり
---| "WORRY" # 困った口

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
		avatarName = "01a_Shizuko";

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
			INVERTED = vectors.vec2(7, 0);
			UNEQUAL = vectors.vec2(6, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			UNEQUAL = vectors.vec2(5, 0);
			CENTER = vectors.vec2(4, 0);
		};

		mouth = {
			OPENED = vectors.vec2(1, 0);
			TRIANGLE = vectors.vec2(2, 0);
			FRUST = vectors.vec2(3, 0);
			SMILE = vectors.vec2(4, 0);
			WORRY = vectors.vec2(0, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.skirt};
	};

	gun = {
		scale = 1.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 1, -7);
					left = vectors.vec3(0, 1, -7);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.5, -0.25, -8);
					left = vectors.vec3(1.5, -0.25, -8);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(-1.5, 4, 3.5);
					left = vectors.vec3(1.5, 4, 3.5);
				};

				rot = {
					right = vectors.vec3(0, 90, -45);
					left = vectors.vec3(45, -90, 0);
				};
			};
		};

		sound = {
			name = "minecraft:entity.generic.explode";
			pitch = 2;
		};
	};

	placementObjects = {
            {
                model = models.models.ex_skill_1.Stall;

                boundingBox = {
                    size = vectors.vec3(20, 38, 20);
                };

                placementMode = "COPY";
            };
	};

	exSkill = {
		primary = {
			formationType = "SPECIAL";

			models = {models.models.ex_skill_1.Stall, ModelAlias.alias.avatar.rightArmBottom.TeaSet};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(-5, 23, -16);
				};

				fin = {
					rot = vectors.vec3(10, -105, 0);
					pos = vectors.vec3(-229.46, 22.31, -1.77);
				};

				legacyMode = true;
			};

			callbacks = {
				onPreTransition = function ()
					PlacementObjectManager:removeAll()
				end;

				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						ModelAlias.alias.avatar.rightArmBottom.TeaSet.WaterSpill:setPrimaryTexture("RESOURCE", "textures/block/water_still.png")
						ModelAlias.alias.avatar.rightArmBottom.TeaSet.WaterSpill:setColor(0.25, 0.39, 0.67)
						self.exSkill.primary.isInitialized = true
					end
					FaceParts:setEmotion("NORMAL", "CENTER", "OPENED", 22, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 22 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 2, true)
					elseif tick == 24 then
						FaceParts:setEmotion("INVERTED", "NORMAL", "WORRY", 1, true)
					elseif tick == 25 then
						self.exSkill.primary.textTask:setVisible(true)
						FaceParts:setEmotion("INVERTED", "NORMAL", "TRIANGLE", 8, true)
					elseif tick == 33 then
						self.exSkill.primary.textTask:setVisible(false)
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 1, true)
					elseif tick == 34 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "FRUST", 1, true)
					elseif tick == 35 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "FRUST", 1, true)
					elseif tick == 36 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 10, true)
					elseif tick == 46 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "TRIANGLE", 1, true)
					elseif tick == 47 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "FRUST", 6, true)
					elseif tick == 53 then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "TRIANGLE", 14, true)
						local gameVersion = client:getVersion()
						local shouldAdjustBackgroundRot = StringUtils.compareVersions(gameVersion, "1.21.0") == gameVersion
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground:setVisible(true)
							local windowSize = client:getWindowSize()
							models.models.ex_skill_1.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(45))
							events.RENDER:register(function (delta, context)
								models.models.ex_skill_1.CameraBackground:setVisible(context == "RENDER")
								local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw(delta) + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.75)), 0, 1, 0):scale(16 / 0.9375)
								models.models.ex_skill_1.CameraBackground:setOffsetPivot(backgroundPos)
								models.models.ex_skill_1.CameraBackground.Background:setPos(backgroundPos)
								if shouldAdjustBackgroundRot then
									models.models.ex_skill_1.CameraBackground.Background:setRot(0, 0, renderer:getCameraRot().z)
								end
							end, "ex_skill_1_background_render")
						end
						local particleAnchor = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.root):add(0, 5, 0)
						local fireworkColor = vectors.hsvToRGB(math.random(), 0.8, 1)
						particles:newParticle("minecraft:flash{color:[" .. fireworkColor[1] .. ", " .. fireworkColor[2] .. ", " .. fireworkColor[3] .. ", 1]}", particleAnchor):setColor(fireworkColor)
						for _ = 1, 400 do
							local particleAngleX = math.random() * math.pi * 2
								local particleAngleY = math.random() * math.pi * 2
								particles:newParticle("minecraft:firework", particleAnchor):setVelocity(math.cos(particleAngleX) * math.cos(particleAngleY) * 0.2, math.sin(particleAngleY) * 0.2, math.sin(particleAngleX) * math.cos(particleAngleY) * 0.2):setColor(fireworkColor)
						end
						sounds:playSound("minecraft:entity.firework_rocket.large_blast", player:getPos())
					elseif tick == 56 then
						ModelAlias.alias.avatar.rightArmBottom.TeaSet:moveTo(models.models.main)
					elseif tick == 67 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "WORRY", 8, true)
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							events.RENDER:remove("ex_skill_1_background_render")
						end
						elseif tick == 69 then
							sounds:playSound("minecraft:block.glass.break", ModelUtils.getModelWorldPos(models.models.main.TeaSet.ExSkillSoundAnchor2), 1, 0.5)
						local particleAnchor1Pos = ModelUtils.getModelWorldPos(models.models.main.TeaSet.WaterSpill)
						for _ = 1, 20 do
							particles:newParticle("minecraft:splash", particleAnchor1Pos:copy():add(math.random() - 0.5, 0, math.random() - 0.5)):setLifetime(10)
						end
					elseif tick == 74 then
						FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "FRUST", 21, true)
						sounds:playSound("minecraft:entity.generic.small_fall", player:getPos(), 1)
						local particleAnchor1Pos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head.ExSkillParticleAnchor1)
						for i = 0, 5 do
							local particleRot = math.rad(i * 60)
							particles:newParticle("minecraft:wax_off", particleAnchor1Pos):setColor(1, 1, 0):setLifetime(12):setVelocity(math.cos(particleRot) * 0.05, 0.1, math.sin(particleRot) * 0.05):setGravity(0.5)
						end
					end

					if tick >= 25 and tick < 33 then
						self.exSkill.primary.textTask:setPos(vectors.vec3(-9, 8, -8):add(math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25))
						if (tick - 25) % 2 == 0 then
							sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 1, 2)
						end
					end
					if tick < 56 and tick % 4 == 0 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.rightArmBottom.TeaSet.Yunomi1.ExSkill1ParticleAnchor2, ModelAlias.alias.avatar.rightArmBottom.TeaSet.Yunomi2.ExSkill1ParticleAnchor3}) do
							local particleAnchorPos = ModelUtils.getModelWorldPos(modelPart)
							particles:newParticle("minecraft:poof", particleAnchorPos):setScale(0.2):setVelocity():setLifetime(15)
						end
					end
					if tick % 2 == 0 and tick >= 70 then
						local particleAnchor5Pos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stall.ExSkillParticleAnchor5)
						for i = 0, 11 do
							local particleRot = i * (math.pi / 6)
							particles:newParticle("minecraft:block " .. "minecraft:dirt", particleAnchor5Pos:copy():add(math.cos(particleRot) * 0.6, 0, math.sin(particleRot) * 0.6))
						end
					end
					if tick % math.ceil((animations["models.main"]["ex_skill_1"]:getLength() * 20 - tick) / 20) == 0 then
						sounds:playSound("minecraft:entity.boat.paddle_land", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stall.Wheels.ExSkillSoundAnchor1))
					end
				end;

				onPostAnimation = function (self, forcedStop)
					if models.models.main.TeaSet ~= nil then
						models.models.main.TeaSet:moveTo(ModelAlias.alias.avatar.rightArmBottom)
					end
					if forcedStop then
						if host:isHost() then
							models.models.ex_skill_1.CameraBackground:setVisible(false)
							events.RENDER:remove("ex_skill_1_background_render")
						end
						self.exSkill.primary.textTask:setVisible(false)
					else
						local bodyYaw = player:getBodyYaw() % 360
						PlacementObjectManager:spawn(1, vectors.rotateAroundAxis(bodyYaw * -1, -12.75, 1, -0.8875, 0, 1, 0):add(player:getPos()), 180 + bodyYaw * -1)
					end
				end;
			};

			---初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;

			---アニメーションに表示する「!!!」のテキストレンダータスク
			---@type TextTask
			textTask = models.models.main.CameraAnchor:newText("ex_skill_text_1"):setVisible(false):setText("§c! !"):setRot(0, 180, 5):setScale(0.8, 0.8, 0.8):setOutline(true):setOutlineColor(1, 1, 1);
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "HELMET" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.head.Brim, ModelAlias.alias.avatar.head.HairTails}) do
						modelPart:setVisible(not isVisible)
					end
				elseif parts == "CHEST_PLATE" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.BackRibbon, ModelAlias.alias.avatar.body.Skirt}) do
						modelPart:setVisible(not isVisible)
					end
					if isVisible then
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
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Hairs.FrontHair, ModelAlias.alias.avatar.body.Hairs.BackHair}) do
							modelPart:setPos()
						end
						self.physics.physicData[1].x.vertical.neutral = -10
						self.physics.physicData[1].x.vertical.max = -10
						self.physics.physicData[1].x.vertical.bodyX.max = -10
						self.physics.physicData[1].x.vertical.bodyY.max = -10
						self.physics.physicData[1].x.vertical.bodyRot.max = -10
						self.physics.physicData[1].x.horizontal.neutral = -10
						self.physics.physicData[1].x.horizontal.max = -10
					end
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
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
					elseif type == "QUESTION" then
						FaceParts:setEmotion("NORMAL", "NORMAL", "WORRY", duration, true)
					elseif type == "SWEAT" then
						FaceParts:setEmotion("SURPRISED", "SURPRISED", "TRIANGLE", duration, true)
						ModelAlias.alias.avatar.head.FaceLayer:setVisible(true)
					end
				end
			end;

			onStop = function (_, _, forcedStop)
				if not forcedStop then
					FaceParts:resetEmotion()
				end
				ModelAlias.alias.avatar.head.FaceLayer:setVisible(false)
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
				ModelAlias.alias.avatar.body.Skirt:setRot(35, 0, 0)
			end;

			onPhase2 = function ()
				ModelAlias.alias.avatar.body.Skirt:setRot(15, 0, 0)
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
						neutral = -10;
						max = -10;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = -10;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = -10;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -10;
						};
					};

					horizontal = {
						min = -90;
						neutral = -10;
						max = -10;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Hairs.FrontHair};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 150;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
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
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailLeft};

				z = {
					vertical = {
						min = 20;
						neutral = 30;
						max = 140;

						bodyY = {
							multiplayer = -80;
							min = 20;
							max = 140;
						};
					};

					horizontal = {
						min = 20;
						neutral = 30;
						max = 140;

						bodyX = {
							multiplayer = -80;
							min = 20;
							max = 140;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.HairTailRight};

				z = {
					vertical = {
						min = -140;
						neutral = -30;
						max = -20;

						bodyY = {
							multiplayer = 80;
							min = -140;
							max = -20;
						};
					};

					horizontal = {
						min = -140;
						neutral = -30;
						max = -20;

						bodyX = {
							multiplayer = 80;
							min = -140;
							max = -20;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Brim.BrimRibbon.BrimLines.BrimLineLeft, ModelAlias.alias.avatar.head.Brim.BrimRibbon.BrimLines.BrimLineRight};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 150;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -160;
							min = 0;
							max = 90;
						};

						headRot = {
							multiplayer = -0.1;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -160;
							min = 0;
							max = 150;
						};
					};

					horizontal = {
						min = 0;
						neutral = 45;
						max = 150;

						headX = {
							multiplayer = -16;
							min = 0;
							max = 150;
						};
					};
				};

				z = {
					vertical = {
						min = -60;
						neutral = 0;
						max = 0;

						headZ = {
							multiplayer = -160;
							min = -60;
							max = 0;
						};
					};

					horizontal = {
						min = -60;
						neutral = 0;
						max = 0;
					};
				};
			};
		};
	};
}

return BlueArchiveCharacter
