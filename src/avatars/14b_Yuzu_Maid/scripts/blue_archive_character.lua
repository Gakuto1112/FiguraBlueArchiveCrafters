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
---| "IN_CHEST" # チェストの中に隠れている時の手

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
		avatarName = "14b_Yuzu_Maid";

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
		callbacks = {
			onArmStateChanged = function (self)
				if self.costume.shouldShowChest then
					return {right = "IN_CHEST", left = "IN_CHEST"}
				end
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "IN_CHEST" then
					ModelAlias.alias.avatar.rightArm:setRot(0, 0, 15)
					ModelAlias.alias.avatar.rightArm:setParentType("Body")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "IN_CHEST" then
					ModelAlias.alias.avatar.leftArm:setRot(0, 0, -15)
					ModelAlias.alias.avatar.leftArm:setParentType("Body")
				end
			end;
		};
	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt1};
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
			formationType = "SPECIAL";

			models = {ModelAlias.alias.avatar.head.ExSkill1H.ShineEffect, models.models.ex_skill_1.Pillagers, models.models.ex_skill_1.Gui.Hotbar, models.models.ex_skill_1.Gui.Map};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 175, 0);
					pos = vectors.vec3(13, 23, -24);
				};

				fin = {
					rot = vectors.vec3(5, 195, 0);
					pos = vectors.vec3(-5.75, 17, -18.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						---@diagnostic disable-next-line: discard-returns
						models:newPart("script_ex_skill_1_wall_model")
						models.script_ex_skill_1_wall_model:setPos(-8, 0, 8)
						for i = 1, 4 do
							models.script_ex_skill_1_wall_model:newBlock("ex_skill_1_block_"..i):setBlock("minecraft:stripped_dark_oak_log"):setPos(0, (i - 1) * 16, 0)
						end
						for i = 1, 3 do
							for j = 1, 4 do
								models.script_ex_skill_1_wall_model:newBlock("ex_skill_1_block_"..((i - 1) * 4) + j + 4):setBlock("minecraft:dark_oak_planks"):setPos((i - 1) * 16 + 16, (j - 1) * 16, 0)
							end
						end
						for _, modelPart in ipairs({models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Head.PillagerHead, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Head.Pillager1Nose, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Body, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1RightArm, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1LeftArm, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1RightLeg, models.models.ex_skill_1.Pillagers.Pillager1.Pillager1LeftLeg}) do
							modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/illager/pillager.png")
						end
						for _, part in ipairs({"Head", "Body", "RightArm", "LeftArm", "RightLeg", "LeftLeg"}) do
							models.models.ex_skill_1.Pillagers.Pillager2["Pillager2"..part]:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Pillagers.Pillager1["Pillager1"..part]))
						end
						for i = 1, 2 do
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."RightArm"]:newItem("ex_skill_1_pillager_"..i.."_crossbow"):setItem("minecraft:crossbow"):setPos(0, -12, -2):setRot(0, 0, -135)
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."Question"]["Pillager"..i.."Question2"]:newText("ex_skill_1_pillager_question_"..i):setText("§e?"):setPos(0, 7, 0):setAlignment("CENTER")
						end
						if host:isHost() then
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection1:newItem("ex_skill_1_hotbar_section1"):setItem("minecraft:firework_rocket"):setPos(0, 11, 0)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection2:newItem("ex_skill_1_hotbar_section2"):setItem("minecraft:comparator"):setPos(0, 11, 0)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection3:newItem("ex_skill_1_hotbar_section3"):setItem("minecraft:name_tag"):setPos(0, 11, 0)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection4:newItem("ex_skill_1_hotbar_section4"):setItem("minecraft:arrow"):setPos(0, 11, 0)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection5:newItem("ex_skill_1_hotbar_section5"):setItem("minecraft:book"):setPos(0, 11, 0)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection6:newItem("ex_skill_1_hotbar_section6"):setItem("minecraft:crossbow"):setPos(0, 11, -5)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection7:newItem("ex_skill_1_hotbar_section7"):setItem("minecraft:brush"):setPos(0, 11, -5)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection9:newItem("ex_skill_1_hotbar_section9"):setItem("minecraft:diamond"):setPos(0, 11, -5)
							models.models.ex_skill_1.Gui.Map.MapBackground:setPrimaryTexture("RESOURCE", "minecraft:textures/map/map_background.png")
							models.models.ex_skill_1.YuzuChest:setVisible(true)
							local chestModel = ModelUtils:copyModel(models.models.ex_skill_1.YuzuChest)
							chestModel:setPos(-60, -16, -2)
							chestModel:setRot(-33.4, 39.86, -22.91)
							chestModel:setScale(0.5, 0.5, 0.5)
							models.models.ex_skill_1.Gui.Hotbar.HotbarSection8:addChild(chestModel)
							models.models.ex_skill_1.Gui.ScreenEffects:setScale(8, 8, 8)
							for _, modelName in ipairs({"ScreenEffectTLBack", "ScreenEffectBRFront", "ScreenEffectBRBack"}) do
								models.models.ex_skill_1.Gui.ScreenEffects:addChild(models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectTLFront:copy(modelName))
							end
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRFront, models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRBack}) do
								modelPart:setRot(0, 0, 180)
							end
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectTLFront, models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRFront}) do
								modelPart:setColor(0.996, 0.4, 0.455)
							end
							for _, modelPart in ipairs({models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectTLBack, models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRBack}) do
								modelPart:setColor(0.231, 0.725, 0.988)
							end
							local gameVersion = client:getVersion()
							if StringUtils.compareVersions(gameVersion, "1.20.2") == gameVersion then
								for i = 1, 9 do
									models.models.ex_skill_1.Gui.Hotbar["HotbarSection"..i]["HotbarSection"..i]:setPrimaryTexture("RESOURCE", "minecraft:textures/gui/sprites/hud/hotbar.png")
								end
								models.models.ex_skill_1.Gui.Hotbar.HotbarSelection:setPrimaryTexture("RESOURCE", "minecraft:textures/gui/sprites/hud/hotbar_selection.png")
								models.models.ex_skill_1.Gui.Map.PlayerMarker:setPrimaryTexture("RESOURCE", "minecraft:textures/map/decorations/player.png")
								for i = 1, 2 do
									models.models.ex_skill_1.Gui.Map["EnemyMarker"..i]:setPrimaryTexture("RESOURCE", "minecraft:textures/map/decorations/red_marker.png")
								end
							else
								textures:fromVanilla("widgets", "minecraft:textures/gui/widgets.png")
								local hotbarTextureScale = textures["widgets"]:getDimensions().x / 256
								textures:newTexture("hotbar", 182 * hotbarTextureScale, 22 * hotbarTextureScale)
								for y = 0, 21 do
									for x = 0, 181 do
										textures["hotbar"]:setPixel(x, y, textures["widgets"]:getPixel(x, y))
									end
								end
								for i = 1, 9 do
									models.models.ex_skill_1.Gui.Hotbar["HotbarSection"..i]["HotbarSection"..i]:setPrimaryTexture("CUSTOM", textures["hotbar"])
								end
								textures:newTexture("hotbar_selection", 24 * hotbarTextureScale, 24 * hotbarTextureScale)
								for y = 0, 23 do
									for x = 0, 23 do
										textures["hotbar_selection"]:setPixel(x, y, textures["widgets"]:getPixel(x, y + 22))
									end
								end
								models.models.ex_skill_1.Gui.Hotbar.HotbarSelection:setPrimaryTexture("CUSTOM", textures["hotbar_selection"])
								textures:fromVanilla("map_icons", "minecraft:textures/map/map_icons.png")
								local mapTextureScale = textures["map_icons"]:getDimensions().x / 128
								textures:newTexture("player", 8 * mapTextureScale, 8 * mapTextureScale)
								for y = 0, 7 do
									for x = 0, 7 do
										textures["player"]:setPixel(x, y, textures["map_icons"]:getPixel(x, y))
									end
								end
								models.models.ex_skill_1.Gui.Map.PlayerMarker:setPrimaryTexture("CUSTOM", textures["player"])
								textures:newTexture("red_marker", 8 * mapTextureScale, 8 * mapTextureScale)
								for y = 0, 7 do
									for x = 0, 7 do
										textures["red_marker"]:setPixel(x, y, textures["map_icons"]:getPixel(x + 16, y))
									end
								end
								for i = 1, 2 do
									models.models.ex_skill_1.Gui.Map["EnemyMarker"..i]:setPrimaryTexture("CUSTOM", textures["red_marker"])
								end
							end

						end
						self.exSkill.primary.isInitialized = true
					else
						models.script_ex_skill_1_wall_model:setVisible(true)
					end
					if host:isHost() then
						local windowSize = client:getScaledWindowSize()
						models.models.ex_skill_1.Gui.Hotbar:setPos(windowSize.x / 2 * -1, windowSize.y * -1, 0)
						models.models.ex_skill_1.Gui.Map:setPos(windowSize.x * -1 + 50, -30, 0)
					end
					FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "CLOSED", 6)
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setVisible(true)
					elseif tick == 6 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 2)
					elseif tick == 8 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "SMALL", 22)
					elseif tick == 21 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1.Pillager1Question):add(0, 0.25, 0)
						for j = 0, 5 do
							particles:newParticle("minecraft:electric_spark", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(j * 60, 0.1, 0, 0, 0, 0, 1), 0, 1, 0)):setColor(1, 1, 0.33):setLifetime(5)
						end
						sounds:playSound("minecraft:entity.pillager.ambient", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1), 0.5, 1)
					elseif tick == 23 then
						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager2.Pillager2Question):add(0, 0.25, 0)
						for j = 0, 5 do
							particles:newParticle("minecraft:electric_spark", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(j * 60, 0.1, 0, 0, 0, 0, 1), 0, 1, 0)):setColor(1, 1, 0.33):setLifetime(5)
						end
					elseif tick == 29 then
						ModelAlias.alias.avatar.head.ExSkill1H.NoticeEffect:setVisible(true)
						sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 0.25, 1.5)
					elseif tick == 30 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMALL", 2)
					elseif tick == 31 then
						ModelAlias.alias.avatar.head.ExSkill1H.NoticeEffect:setVisible(false)
					elseif tick == 32 then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.head.ExSkill1H.FearEffect, ModelAlias.alias.avatar.head.ExSkill1H.NoticeEffect}) do
							modelPart:setVisible(true)
						end
						FaceParts:setEmotion("FEAR_CENTER", "FEAR", "FRUST", 2)
						sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 0.25, 1.5)
					elseif tick == 34 then
						ModelAlias.alias.avatar.head.ExSkill1H.NoticeEffect:setVisible(false)
						FaceParts:setEmotion("FEAR_CENTER", "FEAR", "FEAR", 8)
					elseif tick == 42 then
						FaceParts:setEmotion("FEAR", "FEAR_CENTER", "FEAR", 4)
					elseif tick == 46 then
						FaceParts:setEmotion("FEAR_CENTER", "FEAR", "FEAR", 4)
					elseif tick == 50 then
						FaceParts:setEmotion("FEAR", "FEAR_CENTER", "FEAR", 4)
					elseif tick == 54 then
						FaceParts:setEmotion("FEAR_CENTER", "FEAR", "FEAR", 4)
					elseif tick == 58 then
						FaceParts:setEmotion("FEAR", "FEAR_CENTER", "FEAR", 4)
					elseif tick == 62 then
						FaceParts:setEmotion("FEAR_CENTER", "FEAR", "FEAR", 4)
					elseif tick == 66 then
						FaceParts:setEmotion("FEAR", "FEAR_CENTER", "FEAR", 10)
					elseif tick == 71 and host:isHost() then
						sounds:playSound("minecraft:ui.button.click", player:getPos(), 0.5, 1)
					elseif tick == 74 then
						models.models.ex_skill_1.YuzuChest:setVisible(true)
						sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(models.models.ex_skill_1.YuzuChest), 1, 1)
					elseif tick == 76 then
						FaceParts:setEmotion("CLOSED2_WITH_TEAR", "CLOSED2_WITH_TEAR", "SHOCK", 17)
					elseif tick == 82 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.YuzuChest)
						for i = 0, 11 do
							particles:newParticle("minecraft:campfire_cosy_smoke", anchorPos:copy():add(vectors.rotateAroundAxis(i * 30, 0, 0, 0.5, 0, 1, 0))):setVelocity(vectors.rotateAroundAxis(i * 30, 0, 0, 0.05, 0, 1, 0)):setLifetime(20)
						end
						sounds:playSound("minecraft:entity.zombie.attack_wooden_door", ModelUtils.getModelWorldPos(models.models.ex_skill_1.YuzuChest), 0.2, 1.5)
					elseif tick == 84 then
						sounds:playSound("minecraft:entity.pillager.hurt", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1), 0.5, 1)
					elseif tick == 93 then
						ModelAlias.alias.avatar.head.ExSkill1H.FearEffect:setVisible(false)
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "SMALL", 44)
						sounds:playSound("minecraft:block.chest.open", player:getPos(), 0.1, 0.75)
					elseif tick == 105 and host:isHost() then
						events.RENDER:register(function (delta)
							local opacity = (ExSkill.animationCount + delta - 1) * -0.2 + 22
							for _, modelPart in ipairs({models.models.ex_skill_1.YuzuChest.YuzuChestBottom.YuzuChestBottomFront, models.models.ex_skill_1.YuzuChest.TheYuzu, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestTopFront, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestHook}) do
								modelPart:setOpacity(opacity)
							end
						end, "ex_skill_1_yuzu_chest")
						sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 0.5, 1.5)
					elseif tick == 106 and host:isHost() then
						models.models.ex_skill_1.Gui.ScreenEffects:setVisible(true)
						events.RENDER:register(function ()
							local windowSize = client:getScaledWindowSize()
							models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectTLFront:setPos(models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectFrontAnchor:getAnimPos().x * (windowSize.x / 427), -10, -1)
							models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectTLBack:setPos(models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBackAnchor:getAnimPos().x * (windowSize.x / 427), -11, 0)
							models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRFront:setPos(models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectFrontAnchor:getAnimPos().x * (windowSize.x / 427) * -1 + ((windowSize.x + math.sin(math.rad(-18.8)) * windowSize.y) * -1) / 8, (windowSize.y * -1 + math.sin(math.rad(-18.8)) * windowSize.x) / 8 + 10, -1)
							models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBRBack:setPos(models.models.ex_skill_1.Gui.ScreenEffects.ScreenEffectBackAnchor:getAnimPos().x * (windowSize.x / 427) * -1 + ((windowSize.x + math.sin(math.rad(-18.8)) * windowSize.y) * -1) / 8, (windowSize.y * -1 + math.sin(math.rad(-18.8)) * windowSize.x) / 8 + 11, 0)
						end, "ex_skill_1_screen_effects")
					elseif tick == 107 and host:isHost() then
						models.script_ex_skill_1_sprite:setPos(client:getScaledWindowSize():scale(-0.5):augmented(0))
						local windowSize = client:getScaledWindowSize()
						for i = 0, 5 do
							local offset = vectors.vec2(math.cos(math.rad(i * 60)), math.sin(math.rad(i * 60))):mul(windowSize.x / windowSize.y, 1)
							ExSkill1SpriteManager:spawn("STAR", offset:copy():scale(50), offset:copy():scale(math.random() * 5 + 10))
						end
						for _ = 1, 5 do
							local rot = math.random() * 360
							local offset = vectors.vec2(math.cos(math.rad(rot)), math.sin(math.rad(rot))):mul(windowSize.x / windowSize.y, 1)
							ExSkill1SpriteManager:spawn(math.random() < 0.5 and "MINISTAR" or "MINISTAR2", offset:copy():scale(50), offset:copy():scale(math.random() * 5 + 10))
						end
					elseif tick == 110 and host:isHost() then
						events.RENDER:remove("ex_skill_1_yuzu_chest")
						for _, modelPart in ipairs({models.models.ex_skill_1.YuzuChest.YuzuChestBottom.YuzuChestBottomFront, models.models.ex_skill_1.YuzuChest.TheYuzu, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestTopFront, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestHook}) do
							modelPart:setOpacity(0)
						end
					end
					if tick >= 32 and tick < 76 then
						particles:newParticle("minecraft:splash", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.head)):setPower(2)
						if (tick - 32) % 4 == 0 then
							sounds:playSound("minecraft:block.bubble_column.bubble_pop", player:getPos(), 0.15, 2 - math.random() * 0.5)
						end
					end
					if tick >= 37 and tick <= 67 and (tick - 37) % 4 == 0 and host:isHost() then
						sounds:playSound("minecraft:ui.button.click", player:getPos(), 0.25, 1.5)
					end
				end;

				onPostAnimation = function (self, forcedStop)
					ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
					ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					ModelAlias.alias.avatar.gun:setVisible(Gun.currentGunPosition ~= "NONE")

					models.script_ex_skill_1_wall_model:setVisible(false)
					models.models.ex_skill_1.YuzuChest:setVisible(self.costume.shouldShowChest)
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_screen_effects")
						models.models.ex_skill_1.Gui.ScreenEffects:setVisible(false)
						for _, modelPart in ipairs({models.models.ex_skill_1.YuzuChest.YuzuChestBottom.YuzuChestBottomFront, models.models.ex_skill_1.YuzuChest.TheYuzu, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestTopFront, models.models.ex_skill_1.YuzuChest.YuzuChestTop.YuzuChestHook}) do
							modelPart:setOpacity(1)
						end
					end
					if forcedStop then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.head.ExSkill1H.FearEffect, ModelAlias.alias.avatar.head.ExSkill1H.NoticeEffect}) do
							modelPart:setVisible(false)
						end
						if host:isHost() then
							ExSkill1SpriteManager:removeAll()
						end
					end
				end;

			};

			---このExスキルの初期化処理が行われたかどうか。
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.head.HairTip2, ModelAlias.alias.avatar.head.Brim}) do
						modelPart:setVisible(not isVisible)
					end
				elseif parts == "LEGGINGS" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt1, ModelAlias.alias.avatar.body.BackRibbon}) do
						modelPart:setVisible(not isVisible)
					end
				end
			end;
		};

		---この衣装の初期化処理が行われたかどうか
		---@type boolean
		isInitialized = false;

		---前ティックに脚とスカートの調整をしたかどうか
		---@type boolean
		shouldAdjustLegsPrev = false;

		---前ティックは脚を隠すべきだったかどうか
		---@type boolean
		shouldHideLegsPrev = false;

		---チェストを表示すべきかどうか
		---@type boolean
		shouldShowChest = false;

		---前ティックにチェストを表示していたかどうか
		---@type boolean
		shouldShowChestPrev = false;

		---チェストの中に隠れていたかどうか
		---@type boolean
		shouldHideInChest = false;

		---前ティックにチェストの中に隠れていたかどうか
		---@type boolean
		shouldHideInChestPrev = false;

		---前ティックのBodyYaw
		---@type number
		bodyYawPrev = 0;

		---チェストに隠れているときのAFKカウンター
		---@type integer
		chestAFKCount = 0;

		---チェストに隠れられる機能を停止する。
		---@param self BlueArchiveCharacter
		stopChest = function (self)
			events.TICK:remove("chest_tick")
			events.RENDER:remove("chest_render")
			events.DAMAGE:remove("chest_damage")
			models.models.ex_skill_1.YuzuChest:setVisible(false)
			for _, anim in ipairs({animations["models.ex_skill_1"]["chest_idle"], animations["models.main"]["chest_hide"], animations["models.ex_skill_1"]["chest_hide"], animations["models.main"]["chest_afk"], animations["models.main"]["chest_afk_overwrite"], animations["models.ex_skill_1"]["chest_afk"]}) do
				anim:stop()
			end
			FaceParts:resetEmotion()
			CameraManager.setCameraPivot()
			renderer:setEyeOffset()
			self.costume.shouldShowChest = false
			self.costume.shouldShowChestPrev = false
			self.costume.shouldHideInChest = false
			self.costume.shouldHideInChestPrev = false
			self.costume.chestAFKCount = 0
			if Gun.currentGunPosition == "RIGHT" then
				Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
			elseif Gun.currentGunPosition == "LEFT" then
				Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
			else
				Arms:setArmState("DEFAULT", "DEFAULT")
			end
		end;
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
						ModelAlias.alias.avatar.head.ExSkill1H.FearEffect:setVisible(true)
					end
				end
			end;

			onStop = function(_, _, forcedStop)
				ModelAlias.alias.avatar.head.ExSkill1H.FearEffect:setVisible(false)
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
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(20, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt1:setScale(1.5, 0.5, 1.5)
				ModelAlias.alias.dummy_avatar.legs:setVisible(false)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.HairTail:setRot(-15, 0, -5)
				ModelAlias.alias.dummy_avatar.body.Skirt1:setRot(20, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Skirt1:setScale(1, 1, 1)
				ModelAlias.alias.dummy_avatar.body.BackRibbon.RibbonBottomRight:setRot(15, 0, 0)
				ModelAlias.alias.dummy_avatar.body.BackRibbon.RibbonBottomLeft:setRot(15, 0, 0)
				ModelAlias.alias.dummy_avatar.legs:setVisible(true)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
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

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopLeftYPivot};

			y = {
				vertical = {
					min = 0;
					neutral = 0;
					max = 80;
					headRotMultiplayer = 0.5;

					headX = {
						multiplayer = 160;
						min = 0;
						max = 80;
					};

					headRot = {
						multiplayer = -0.1;
						min = 0;
						max = 80;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopLeftYPivot.HairBandRibbonTopLeftZPivot};

			z = {
				vertical = {
					min = -75;
					neutral = 0;
					max = 27.5;

					bodyY = {
						multiplayer = 20;
						min = -75;
						max = 27.5;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopRightYPivot};

			y = {
				vertical = {
					min = -80;
					neutral = 0;
					max = 0;
					headRotMultiplayer = -0.5;

					headX = {
						multiplayer = -160;
						min = -80;
						max = 0;
					};

					headRot = {
						multiplayer = 0.1;
						min = -80;
						max = 0;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopRightYPivot.HairBandRibbonTopRightZPivot};

			z = {
				vertical = {
					min = -27.5;
					neutral = 0;
					max = 75;

					bodyY = {
						multiplayer = -20;
						min = -27.5;
						max = 75;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomLeftXPivot, ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomRightXPivot};

			x = {
				vertical = {
					min = -170;
					neutral = 0;
					max = 0;
					headRotMultiplayer = -1;

					headX = {
						multiplayer = -160;
						min = -80;
						max = 0;
					};

					headRot = {
						multiplayer = 0.1;
						min = -80;
						max = 0;
					};

					bodyY = {
						multiplayer = 160;
						min = -170;
						max = 0;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomLeftXPivot.HairBandRibbonBottomLeftZPivot};

			z = {
				vertical = {
					min = 0;
					neutral = 0;
					max = 30;

					headX = {
						multiplayer = 20;
						min = 0;
						max = 30;
					};

					headRot = {
						multiplayer = -0.1;
						min = 0;
						max = 30;
					};

					bodyY = {
						multiplayer = 20;
						min = 0;
						max = 30;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomRightXPivot.HairBandRibbonBottomRightZPivot};

			z = {
				vertical = {
					min = -30;
					neutral = 0;
					max = 0;

					headX = {
						multiplayer = -20;
						min = -30;
						max = 0;
					};

					headRot = {
						multiplayer = 0.1;
						min = -30;
						max = 0;
					};

					bodyY = {
						multiplayer = -20;
						min = -30;
						max = 0;
					};
				};
			};
		};

		{
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonRight};

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
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonRight.RibbonRightZPivot};

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
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonLeft};

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
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonLeft.RibbonLeftZPivot};

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
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomRight, ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomLeft};

			x = {
				vertical = {
					min = -140;
					neutral = 0;
					max = 0;
					sneakOffset = 30;

					bodyX = {
						multiplayer = -80;
						min = -60;
						max = 0;
					};

					bodyY = {
						multiplayer = 80;
						min = -140;
						max = 0;
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
					max = 0;

					bodyY = {
						multiplayer = 80;
						min = -60;
						max = 0;
					};
				};
			};
		};


		{
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomRight.RibbonBottomRightZPivot};

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
			models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomLeft.RibbonBottomLeftZPivot};

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
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model == ModelAlias.alias.avatar.head.HairTail then
					model:setRot(math.min(model:getRot().x, 30), 0, 0)
				elseif model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopRightYPivot then
					model:setRot(0, math.min(model:getRot().y, 0), 0)
				elseif model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonTopLeftYPivot then
					model:setRot(0, math.max(model:getRot().y, 0), 0)
				elseif model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomRightXPivot or model == ModelAlias.alias.avatar.head.HairBandRibbon.HairBandRibbonBottom.HairBandRibbonBottomLeftXPivot then
					model:setRot(math.min(model:getRot().x, 0), 0, 0)
				end
			end
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	---@param self BlueArchiveCharacter
	init = function (self)
		---Exスキル1で使用するスプライトインスタンスのクラス
		---@type ExSkill1Sprite
		ExSkill1Sprite = require("scripts.ex_skill_1_sprite")

		---Exスキル1で使用するスプライトマネージャーのクラス
		---@type ExSkill1SpriteManager
		ExSkill1SpriteManager = require("scripts.ex_skill_1_sprite_manager")
		ExSkill1SpriteManager = ExSkill1SpriteManager.new()

		ExSkill1SpriteManager.init()

		for _, modelPart in ipairs({models.models.ex_skill_1.YuzuChest.YuzuChestBottom, models.models.ex_skill_1.YuzuChest.YuzuChestTop}) do
			modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/chest/normal.png")
		end

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

				local skirtVisible = ModelAlias.alias.avatar.body.Skirt1:getVisible()
				local shouldHideLegs = skirtVisible and player:getVehicle() ~= nil
				if shouldHideLegs and not self.costume.shouldHideLegsPrev then
					ModelAlias.alias.avatar.legs:setVisible(false)
					ModelAlias.alias.avatar.body.Skirt1:setScale(1.5, 0.5, 1.5)
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt1.Skirt2, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3.Skirt4}) do
						modelPart:setScale()
					end
				elseif not shouldHideLegs and self.costume.shouldHideLegsPrev then
					ModelAlias.alias.avatar.legs:setVisible(true)
				end

				local shouldAdjustLegs = skirtVisible and not shouldHideLegs
				if shouldAdjustLegs and not self.costume.shouldAdjustLegsPrev then
					events.RENDER:register(function (delta)
						local rightLegRotX = vanilla_model.RIGHT_LEG:getOriginRot().x
						ModelAlias.alias.avatar.rightLeg:setRot(rightLegRotX * -0.45, 0, 0)
						ModelAlias.alias.avatar.leftLeg:setRot(vanilla_model.LEFT_LEG:getOriginRot().x * -0.45, 0, 0)
						if self.costume.shouldHideInChest then
							for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt1, ModelAlias.alias.avatar.body.Skirt1.Skirt2, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3.Skirt4}) do
								modelPart:setScale()
							end
						else
							local rightLegRotAbs = math.abs(rightLegRotX)
							local playerPose = player:getPose()
							local skirtFlipVal = math.min(math.abs(Physics.getValueBetweenTicks(Physics.velocityAverage[7], delta)) * 0.00025 + ((playerPose == "SWIMMING" or playerPose == "FALL_FLYING") and 0 or math.max(Physics.getValueBetweenTicks(Physics.velocityAverage[2], delta) * -0.25, 0)), 0.5)
							ModelAlias.alias.avatar.body.Skirt1:setScale(1 + skirtFlipVal, 1 - skirtFlipVal * 0.75, rightLegRotAbs * 0.001 + 1 + skirtFlipVal)
							ModelAlias.alias.avatar.body.Skirt1.Skirt2:setScale(rightLegRotAbs * -0.0001 + 1, 1, rightLegRotAbs * 0.001 + 1)
							ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3:setScale(rightLegRotAbs * -0.0001 + 1, 1, rightLegRotAbs * 0.001 + 1)
							ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3.Skirt4:setScale(rightLegRotAbs * -0.00005 + 1, 1, rightLegRotAbs * 0.0005 + 1)
						end
					end, "costume_maid_render")
				elseif not shouldAdjustLegs and self.costume.shouldAdjustLegsPrev then
					events.RENDER:remove("costume_maid_render")
					for _, modelPart in ipairs({ModelAlias.alias.avatar.rightLeg, ModelAlias.alias.avatar.leftLeg}) do
						modelPart:setRot()
					end
					if not shouldHideLegs then
						for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Skirt1, ModelAlias.alias.avatar.body.Skirt1.Skirt2, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3, ModelAlias.alias.avatar.body.Skirt1.Skirt2.Skirt3.Skirt4}) do
							modelPart:setScale()
						end
					end
				end
				self.costume.shouldHideLegsPrev = shouldHideLegs
				self.costume.shouldAdjustLegsPrev = shouldAdjustLegs

				self.costume.shouldShowChest = player:getItem(6).id == "minecraft:carved_pumpkin" and not Armor.shouldShowArmor and ExSkill.animationCount == -1 and player:getPose() ~= "SLEEPING"
				if self.costume.shouldShowChest ~= self.costume.shouldShowChestPrev then
					if self.costume.shouldShowChest then
						models.models.ex_skill_1.YuzuChest:setVisible(true)
						for _, anim in ipairs({animations["models.ex_skill_1"]["chest_idle"], animations["models.main"]["chest_hide"], animations["models.ex_skill_1"]["chest_hide"]}) do
							anim:play()
						end
						for _, anim in ipairs({animations["models.main"]["chest_hide"], animations["models.ex_skill_1"]["chest_hide"]}) do
							anim:setTime(0)
							anim:setSpeed(-1)
						end
						Arms:setArmState("IN_CHEST", "IN_CHEST")
						events.TICK:register(function ()
							if not client:isPaused() then
								self.costume.shouldHideInChest = player:isCrouching()
								if self.costume.shouldHideInChest ~= self.costume.shouldHideInChestPrev then
									if self.costume.shouldHideInChest then
										for _, anim in ipairs({animations["models.main"]["chest_hide"], animations["models.ex_skill_1"]["chest_hide"]}) do
											anim:setSpeed(1)
										end
										sounds:playSound("minecraft:block.ender_chest.close", player:getPos(), 0.1, 2)
									else
										for _, anim in ipairs({animations["models.main"]["chest_hide"], animations["models.ex_skill_1"]["chest_hide"]}) do
											anim:setSpeed(-1)
										end
										sounds:playSound("minecraft:block.chest.open", player:getPos(), 0.1, 2)
									end
									self.costume.shouldHideInChestPrev = self.costume.shouldHideInChest
								end
								local bodyYaw = player:getBodyYaw()
								if self.costume.shouldHideInChest and not player:isMoving() and bodyYaw == self.costume.bodyYawPrev and not player:isInWater() and not player:isInLava() and player:getFrozenTicks() == 0 and player:getSwingArm() == nil and player:getActiveItem().id == "minecraft:air" then
									if self.costume.chestAFKCount == -135 then
										FaceParts:setEmotion("NORMAL", "INVERTED", "FRUST", 35, true)
										sounds:playSound("minecraft:block.chest.open", player:getPos(), 0.1, 2)
									elseif self.costume.chestAFKCount == -100 then
										FaceParts:setEmotion("INVERTED", "NORMAL", "FRUST", 35, true)
									elseif self.costume.chestAFKCount == -65 then
										FaceParts:setEmotion("NORMAL", "NORMAL", "FRUST", 15, true)
									elseif self.costume.chestAFKCount == -50 then
										FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMALL", 40, true)
									elseif self.costume.chestAFKCount == -10 then
										sounds:playSound("minecraft:block.ender_chest.close", player:getPos(), 0.1, 2)
									elseif self.costume.chestAFKCount == 1200 then
										for _, anim in ipairs({animations["models.main"]["chest_afk"], animations["models.main"]["chest_afk_overwrite"], animations["models.ex_skill_1"]["chest_afk"]}) do
											anim:play()
										end
										self.costume.chestAFKCount = -140
									end
									self.costume.chestAFKCount = self.costume.chestAFKCount + 1
								else
									for _, anim in ipairs({animations["models.main"]["chest_afk"], animations["models.main"]["chest_afk_overwrite"], animations["models.ex_skill_1"]["chest_afk"]}) do
										anim:stop()
									end
									FaceParts:resetEmotion()
									self.costume.chestAFKCount = 0
								end
								self.costume.bodyYawPrev = bodyYaw
							end
						end, "chest_tick")

						events.RENDER:register(function ()
							local lookYOffset = (models.models.ex_skill_1.YuzuChest:getAnimPos().y / 16 - 0.75) * 0.5
							CameraManager.setCameraPivot(vectors.vec3(0, lookYOffset, 0))
							renderer:setEyeOffset(0, lookYOffset, 0)
						end, "chest_render")

						events.DAMAGE:register(function ()
							for _, anim in ipairs({animations["models.main"]["chest_afk"], animations["models.main"]["chest_afk_overwrite"], animations["models.ex_skill_1"]["chest_afk"]}) do
								anim:stop()
							end
							self.costume.chestAFKCount = 0
						end, "chest_damage")
					else
						self.costume.stopChest(self)
					end
					self.costume.shouldShowChestPrev = self.costume.shouldShowChest
				end
            end
        end)
	end;
}

return BlueArchiveCharacter
