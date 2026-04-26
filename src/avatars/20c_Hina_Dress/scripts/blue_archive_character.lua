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
---| "SURPRISED_CENTER" # 驚きつつ少し反対側を見る目
---| "DRESS_INVERTED" # 反対側を見る目（ドレス衣装用）
---| "WORRY" # 戸惑いの目
---| "DARK_ANGRY" # 完全に怒っているときの目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "SWIMSUIT_CENTER" # 少し反対側を見る目（水着衣装用）
---| "WORRY" # 戸惑いの目
---| "DARK_ANGRY" # 完全に怒っているときの目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "TEETH" # 歯が見える口
---| "CLOSED" # ハイフンみたいな口
---| "EMBARRASSING" # 恥ずかしい口
---| "ANXIOUS" # への口
---| "SMILE" # にっこり口
---| "OPENED" # 開いた口
---| "TEETH_SMILE" # 歯を見せてにっこり

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
		avatarName = "20c_Hina_Dress";

		birth = {
			month = 2;
			day = 19;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(8, 0);
			SURPRISED_CENTER = vectors.vec2(9, 0);
			DRESS_INVERTED = vectors.vec2(11, 0);
			WORRY = vectors.vec2(12, 0);
			DARK_ANGRY = vectors.vec2(14, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CENTER = vectors.vec2(4, 0);
			CLOSED2 = vectors.vec2(7, 0);
			SWIMSUIT_CENTER = vectors.vec2(9, 0);
			WORRY = vectors.vec2(12, 0);
			DARK_ANGRY = vectors.vec2(14, 0);
		};

		mouth = {
			TEETH = vectors.vec2(0, 0);
			CLOSED = vectors.vec2(1, 0);
			EMBARRASSING = vectors.vec2(2, 0);
			ANXIOUS = vectors.vec2(3, 0);
			SMILE = vectors.vec2(4, 0);
			OPENED = vectors.vec2(5, 0);
			TEETH_SMILE = vectors.vec2(6, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				local result = {right = right, left = left}

				if right == "CROSSBOW" and Gun.currentGunPosition == "RIGHT" then
					result.right = "GUN_MAIN_HAND"
				end

				if left == "CROSSBOW" and Gun.currentGunPosition == "LEFT" then
					result.left = "GUN_MAIN_HAND"
				end

				return result;
			end;

			onAdditionalRightArmProcess = function (_, state)
				ModelAlias.alias.avatar.rightArmBottom:setRot(state == "GUN_MAIN_HAND" and 40 or 0, 0, 0)
				if state == "GUN_MAIN_HAND" then
					Arms:registerRightArmTickEvent("GUN_MAIN_HAND")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local rotY = headRot.y % 360
						rotY = rotY > 180 and 0 or rotY
						ModelAlias.alias.avatar.rightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3() or vectors.vec3(math.max(headRot.x - 15 + (player:isCrouching() and 30 or 0), -15) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5, rotY, 10))
					end, "right_arm_render")
					return true
				elseif state == "GUN_OFF_HAND" then
					Arms:registerRightArmTickEvent("GUN_OFF_HAND")
					events.RENDER:register(function (delta, context)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
						ModelAlias.alias.avatar.rightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.max(headRot.x + 55 + (player:isCrouching() and 30 or 0), 55), math.min(math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78) + 30, 65) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5, 0))
					end, "right_arm_render")
					return true
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				ModelAlias.alias.avatar.leftArmBottom:setRot(state == "GUN_MAIN_HAND" and 40 or 0, 0, 0)
				if state == "GUN_MAIN_HAND" then
					Arms:registerLeftArmTickEvent("GUN_MAIN_HAND")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local rotY = headRot.y % 360
						rotY = rotY < 180 and 0 or rotY
						ModelAlias.alias.avatar.leftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3() or vectors.vec3(math.max(headRot.x - 15 + (player:isCrouching() and 30 or 0), -15) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5, rotY, -10))
					end, "left_arm_render")
					return true
				elseif state == "GUN_OFF_HAND" then
					Arms:registerLeftArmTickEvent("GUN_OFF_HAND")
					events.RENDER:register(function (delta, context)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
						ModelAlias.alias.avatar.leftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.max(headRot.x + 55 + (player:isCrouching() and 30 or 0), 55), math.max(math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21) - 30, -65) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5, 0))
					end, "left_arm_render")
					return true
				end
			end;
		}
	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Dress};
	};

	gun = {
		scale = 2.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 2, -15);
					left = vectors.vec3(0, 2, -15);
				};
				thirdPersonPos = {
					right = vectors.vec3(-2, 10, -5);
					left = vectors.vec3(2, 10, -5);
				};
				thirdPersonRot = {
					right = vectors.vec3(70, 10, 0);
					left = vectors.vec3(70, -10, 0);
				}
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, 4, 2);
					left = vectors.vec3(0, 4, 2);
				};

				rot = {
					right = vectors.vec3(0, 90, 45);
					left = vectors.vec3(0, -90, -45);
				};
			};
		};

		sound = {
			name = "minecraft:entity.firework_rocket.blast";
			pitch = 0.5;
		};
	};

	placementObjects = {

	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {models.models.ex_skill_1.GrandPiano, models.models.ex_skill_1.PianoChair, models.models.ex_skill_1.Gui};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(5, 180, 0);
					pos = vectors.vec3(0, 20.5, -13);
				};

				fin = {
					rot = vectors.vec3(-5, -500, 0);
					pos = vectors.vec3(-11, 22.6, -14.5);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.GrandPiano.PianoBodyBottomTexture:setPrimaryTexture("RESOURCE", "minecraft:textures/block/oak_planks.png")
						models.models.ex_skill_1.GrandPiano.PianoInnerBottomTexture:setPrimaryTexture("RESOURCE", "minecraft:textures/block/nether_bricks.png")
						models.models.ex_skill_1.PianoChair.PianoChair:setPrimaryTexture("RESOURCE", "minecraft:textures/block/black_wool.png")
						models.models.ex_skill_1.GrandPiano.NoteStand.MusicSheet1:newText("ex_skill_1_text"):setText("§0夢路の花"):setPos(0, 8, 0):setRot(0, 180, 0):setScale(0.08, 0.08, 0.08):setAlignment("CENTER")
						self.exSkill.primary.isInitialized = true
					end

					if host:isHost() then
						--廃屋の生成
						--床
						for z = -10, 10 do
							for x = -10, 10 do
								---@type Minecraft.blockID
								local block = "minecraft:light_blue_terracotta"
								local blockProperty = nil
								if (z == 3 and x >= 3 and x <= 4) or (z == 4 and x >= 2 and x <= 5) or (z == 5 and x >= 2 and x <= 5) or (z == 6 and x >= 3 and x <= 6) or (z == 7 and x >= 4 and x <= 8) or (z == 8 and x >= 4 and x <= 7) then
									block = "minecraft:dirt"
									if math.random() >= 0.9 then
										FadingBlockManager:spawn(vectors.vec3(x, 1, z), "minecraft:short_grass", nil, 118, false, 0)
									end
								elseif x <= -9 or x >= 9 or z <= -9 or z >= 9 then
									if math.random() >= 0.5 then
										block = "minecraft:moss_block"
									end
								else
									local randValue = math.random()
									if randValue >= 0.95 then
										block = "minecraft:moss_block"
									elseif randValue >= 0.85 then
										block = "minecraft:blue_terracotta"
									end
								end
								local r = math.max(math.abs(x), math.abs(z))
								FadingBlockManager:spawn(vectors.vec3(x, 0, z), block, blockProperty, 118, true, 2 * r + ((r >= 7 and math.random() >= 0.5) and 23 or 6))
							end
						end
						--壁
						for z = -10, 10 do
							for x = -10, 10, 20 do
								for y = 1, 7 do
									---@type Minecraft.blockID
									local block = "minecraft:cyan_terracotta"
									local blockProperty = nil
									if x == -10 and y >= 2 and y <= 4 and ((z >= -2 and z <= -1) or (z >= 1 and z <= 2)) then
										--割れたガラス窓
										if math.random() >= 0.5 then
											block = "minecraft:glass_pane"
											blockProperty = "[north=true,south=true]"
										else
											block = "minecraft:air"
										end
										FadingBlockManager:spawn(vectors.vec3(x - 1, y, z), "minecraft:black_concrete", nil, 123 + (y - 1) * 2, false)
									elseif x == -10 and y >= 2 and y <= 4 and ((z >= -4 and z <= -3) or (z >= 3 and z <= 4)) then
										--打ち付けた板
										block = math.random() >= 0.5 and "minecraft:spruce_planks" or "minecraft:dark_oak_planks"
									end
									FadingBlockManager:spawn(vectors.vec3(x, y, z), block, blockProperty, 123 + (y - 1) * 2, true, 5)
								end
								--壁装飾
								if (z >= -9 and z <= -8) or (z >= -5 and z <= 5) or (z >= 9 and z <= 10) or x == 10 then
									local randValue = math.random()
									if randValue >= 0.75 then
										FadingBlockManager:spawn(vectors.vec3(x == -10 and -9 or 9, 6, z), "minecraft:cobweb", nil, 133, false, 0)
									elseif randValue >= 0.25 then
										for y = 1, math.random(1, 5) do
											if x == -10 then
												FadingBlockManager:spawn(vectors.vec3(-9, y, z), "minecraft:vine", "[west=true]", 123 + (y - 1) * 2, false, 0)
											else
												FadingBlockManager:spawn(vectors.vec3(9, y, z), "minecraft:vine", "[east=true]", 123 + (y - 1) * 2, false, 0)
											end
										end
									end
								end
							end
						end
						for x = -9, 9 do
							for z = -10, 10, 20 do
								for y = 1, 7 do
									---@type Minecraft.blockID
									local block = "minecraft:cyan_terracotta"
									local blockProperty = nil
									if z == -10 and y >= 2 and y <= 4 and ((x >= -2 and x <= -1) or (x >= 1 and x <= 2)) then
										--割れたガラス窓
										if math.random() >= 0.5 then
											block = "minecraft:glass_pane"
											blockProperty = "[east=true,west=true]"
										else
											block = "minecraft:air"
										end
										FadingBlockManager:spawn(vectors.vec3(x, y, z - 1), "minecraft:black_concrete", nil, 123 + (y - 1) * 2, false, 0)
									elseif (z == -10 and y >= 2 and y <= 4 and ((x >= -4 and x <= -3) or (x >= 3 and x <= 4))) or (z == 10 and y >= 2 and y <= 4 and((x >= -6 and x <= -5) or (x >= -2 and x <= -1) or(x >= 2 and x <= 3))) then
										--打ち付けた板
										block = math.random() >= 0.5 and "minecraft:spruce_planks" or "minecraft:dark_oak_planks"
									elseif z == 10 and x == 6 and y == 1 then
										--ドア
										block = "minecraft:spruce_door"
										blockProperty = "[half=lower,hinge=left,facing=north]"
									elseif z == 10 and x == 6 and y == 2 then
										--ドア
										block = "minecraft:spruce_door"
										blockProperty = "[half=upper,hinge=left,facing=north]"
									elseif z == 10 and x == 7 and y == 1 then
										--ドア
										block = "minecraft:spruce_door"
										blockProperty = "[half=lower,hinge=right,facing=north]"
									elseif z == 10 and x == 7 and y == 2 then
										--ドア
										block = "minecraft:spruce_door"
										blockProperty = "[half=upper,hinge=right,facing=north]"
									end
									FadingBlockManager:spawn(vectors.vec3(x, y, z), block, blockProperty, 123 + (y - 1) * 2, true, 5)
								end
								--壁装飾
								if (x >= -9 and x <= -8) or (x >= -5 and x <= 5) or (x >= 9 and x <= 10) or z == 10 then
									local randValue = math.random()
									if randValue >= 0.75 then
										FadingBlockManager:spawn(vectors.vec3(z == -10 and -9 or 9, 6, z), "minecraft:cobweb", nil, 133, false, 0)
									elseif randValue >= 0.25 then
										for y = 1, math.random(1, 5) do
											if z == -10 then
												FadingBlockManager:spawn(vectors.vec3(x, y, -9), "minecraft:vine", "[north=true]", 123 + (y - 1) * 2, false, 0)
											else
												FadingBlockManager:spawn(vectors.vec3(x, y, 9), "minecraft:vine", "[south=true]", 123 + (y - 1) * 2, false, 0)
											end
										end
									end
								end
							end
						end
						--天井
						for z = -9, 9 do
							for x = -9, 9 do
								local r = math.max(math.abs(x), math.abs(z))
								FadingBlockManager:spawn(vectors.vec3(x, 7, z), "minecraft:cyan_terracotta", nil, 134 + (9 - r) * 2, true, 5)
							end
						end
						--柱
						for i = -7, 7, 13 do
							for z = i, i + 1 do
								for y = 1, 6 do
									FadingBlockManager:spawn(vectors.vec3(-9, y, z), "minecraft:cyan_terracotta", nil, 123 + (y - 1) * 2, false, 0)
								end
							end
							for x = i, i + 1 do
								for y = 1, 6 do
									FadingBlockManager:spawn(vectors.vec3(x, y, -9), "minecraft:cyan_terracotta", nil, 123 + (y - 1) * 2, false, 0)
								end
							end
						end
						--黒板
						for z = -4, 4 do
							for y = 1, 3 do
								FadingBlockManager:spawn(vectors.vec3(9, z <= -1 and (y + 1) or y, z), "minecraft:green_terracotta", nil, 123 + ((z <= -1 and (y + 1) or y) - 1) * 2, false, 0)
							end
							if z <= -1 then
								FadingBlockManager:spawn(vectors.vec3(9, 1, z), "minecraft:spruce_slab", "[type=top]", 123, false, 0)
							end
						end
						--枯れ木
						for y = 1, 5 do
							FadingBlockManager:spawn(vectors.vec3(4, y, 5), "minecraft:spruce_log", nil, 118, true, y * 10)
						end
						FadingBlockManager:spawn(vectors.vec3(5, 2, 5), "minecraft:spruce_log", "[axis=x]", 118, true, 20)
						FadingBlockManager:spawn(vectors.vec3(4, 3, 4), "minecraft:spruce_log", "[axis=z]", 118, true, 30)
						FadingBlockManager:spawn(vectors.vec3(3, 3, 5), "minecraft:spruce_log", "[axis=x]", 118, true, 30)
						FadingBlockManager:spawn(vectors.vec3(4, 4, 6), "minecraft:spruce_log", "[axis=z]", 118, true, 40)

						--トランジション用のフィルター
						models.models.ex_skill_1.Gui.GuiFilter:setScale(client:getScaledWindowSize():copy():augmented(1))
						events.RENDER:register(function ()
							models.models.ex_skill_1.Gui.GuiFilter:setOpacity(models.models.ex_skill_1.Gui.GuiFilterOpacity:getAnimScale().x)
						end, "ex_skill_1_render")
					end

					--演奏曲の初期化
					self.exSkill.primary.songIndex = math.random() >= 0.95 and 2 or 1
					self.exSkill.primary.songCount = 0
					self.exSkill.primary.noteIndex = 1

					FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 22, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 1 then
						ModelAlias.alias.avatar.gun:setVisible(false)
					elseif tick == 22 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 33, true)
					elseif tick == 55 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 6, true)
					elseif tick == 61 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 120, true)
					elseif tick == 181 then
						FaceParts:setEmotion("DRESS_INVERTED", "NORMAL", "SMILE", 25, true)
					elseif tick == 206 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 1, true)
					elseif tick == 207 then
						FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 46, true)
						if host:isHost() then
							models.models.ex_skill_1.Gui.GuiFilter:setUVPixels(0, 16)
						end
						local bodyYaw = player:getBodyYaw()
						local anchorPos = player:getPos():copy():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 1.5, 0.2, 0, 1, 0))
						for i = 0, 17 do
							particles:newParticle("minecraft:end_rod", anchorPos):setScale(0.1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 - 32, vectors.rotateAroundAxis(i * 20, 0, 0.04 + math.random() * 0.04, 0, 0, 0, 1), 0, 1, 0)):setGravity(0)
						end
					end

					if tick >= 44 then
						self.exSkill.primary.songCount = self.exSkill.primary.songCount + self.exSkill.primary.songs[self.exSkill.primary.songIndex].tempo / 1200
						local playerPos = player:getPos()
						while(self.exSkill.primary.songs[self.exSkill.primary.songIndex].notes[self.exSkill.primary.noteIndex] ~= nil and self.exSkill.primary.songs[self.exSkill.primary.songIndex].notes[self.exSkill.primary.noteIndex][2] <= self.exSkill.primary.songCount) do
							sounds:playSound("minecraft:block.note_block.harp", playerPos, 1 * self.exSkill.primary.songs[self.exSkill.primary.songIndex].notes[self.exSkill.primary.noteIndex][3], math.pow(2, (self.exSkill.primary.songs[self.exSkill.primary.songIndex].notes[self.exSkill.primary.noteIndex][1] - 12) / 12))
							self.exSkill.primary.noteIndex = self.exSkill.primary.noteIndex + 1
						end
					end
					if tick < 118 then
						local anchorPos = player:getPos()
						local subVec = vectors.vec3(1, 1, 1):sub(0.7, 0.56, 0.97)
						for _ = 1, 2 do
							particles:newParticle("minecraft:firework", anchorPos:copy():add(math.random() - 0.5, math.random() * 2, math.random() - 0.5)):setScale(0.1):setColor(vectors.vec3(0.7, 0.56, 0.97):add(subVec:copy():scale(math.random()))):setGravity(0):setLifetime(10)
						end
					end
					if tick >= 94 and tick < 184 then
						local anchorPos = player:getPos()
						local deg = (tick - 94) * 15
						for i = 0, 1 do
							particles:newParticle("minecraft:cherry_leaves", anchorPos:copy():add(vectors.rotateAroundAxis(deg + i * 180, 0, 2 + math.random() * 3, 4 + math.random() * 3, 0, 1, 0))):setScale(1):setVelocity(math.random() * 0.1 - 0.05, math.random() * 0.1 - 0.05, math.random() * 0.1 - 0.05)
						end
					end
				end;

				onPostAnimation = function (self, forcedStop)
					ModelAlias.alias.avatar.gun:setVisible(true)
					if host:isHost() then
						models.models.ex_skill_1.Gui.GuiFilter:setUVPixels()
						if forcedStop then
							events.RENDER:remove("ex_skill_1_render")
							FadingBlockManager:removeAll()
						end
					end
				end;
			};

			---このExスキルが初期化されたかどうか。
			---@type boolean
			isInitialized = false;

			---Exスキル中に再生する曲のデータ
			songs = {
				-- 1. 夢路の花
				{
					---曲のテンポ（BPM）
					tempo = 86; --真のテンポは110
					---音符情報（1. 音階（音符ブロックのクリック回数）, 2. タイミング（何符目か？）, 3. 音量倍率）
					notes = {
							{10, 0, 1}, {-14, 0, 0.8},
							{15, 1, 1}, {7, 1, 0.8}, {3, 1, 0.8}, {-2, 1, 0.8},
							{19, 2, 1},
							{26, 3, 1}, {14, 3, 1}, {-14, 3, 0.8},
							{7, 4, 0.8}, {1, 4, 0.8}, {-2, 4, 0.8},
							{24, 5, 1}, {15, 5, 1}, {12, 5, 0.8}, {9, 5, 0.8}, {3, 5, 0.8}, {0, 5, 0.8},
							{27, 6, 1}, {15, 6, 1}, {-14, 6, 0.8},
							{24, 7, 1}, {15, 7, 1}, {12, 7, 0.8}, {8, 7, 0.8}, {7, 7, 0.8}, {3, 7, 0.8},
							{20, 8, 1},
							{19, 9, 1}, {-14, 9, 0.8}
						};
				};

				-- 2. Beginning2（マインクラフトのタイトルBGM） - https://musescore.com/filipepimenta/beginning-2-minecraft-extended
				{
					---曲のテンポ（BPM）
					tempo = 102; --真のテンポは90
					---音符情報（1. 音階（音符ブロックのクリック回数）, 2. タイミング（何符目か？）, 3. 音量倍率）
					notes = {
						{28, 0, 1}, {21, 0, 1}, {-15, 0, 1},
						{-8, 1, 1},
						{26, 2, 1}, {-3, 2, 1},
						{21, 3, 1}, {4, 3, 1},
						{-8, 4, 1},
						{24, 5, 1}, {0, 5, 1},
						{-3, 6, 1},
						{23, 7, 1}, {9, 7, 1},
						{21, 8, 1}, {14, 8, 1}, {-5, 8, 1},
						{7, 9, 1},
						{23, 10, 1}, {2, 10, 1},
						{-5, 11, 1},
						{23, 11.75, 1},
						{19, 12, 1}, {12, 12, 1}, {-12, 12, 1},
						{2, 13, 1}
					};
				};
			};

			---Exスキル中に再生する曲のインデックス番号
			songIndex = 1;

			---曲の再生位置
			songCount = 0;

			---音符の再生インデックス
			noteIndex = 1;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.DressHair:setVisible(not isVisible)
				elseif parts == "CHEST_PLATE" then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Dress, ModelAlias.alias.avatar.body.BackRibbon}) do
						modelPart:setVisible(not isVisible)
					end
					ModelAlias.alias.avatar.body.DressFrontHair:setPos(0, 0, isVisible and -1 or 0)
				end
			end;
		};

		---現ティックで脚とドレスの調整をするかどうか
		---@type boolean
		shouldAdjustLegs = false;

		---前ティックに脚とドレスの調整をしたかどうか
		---@type boolean
		shouldAdjustLegsPrev = false;

		---前ティックは脚を隠すべきだったかどうか
		---@type boolean
		shouldHideLegsPrev = false;
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", duration, true)
				elseif type == "QUESTION" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", duration, true)
				elseif type == "SWEAT" then
					FaceParts:setEmotion("WORRY", "WORRY", "CLOSED", duration, true)
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
		includeModels = {ModelAlias.alias.avatar.body.DressFrontHair};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function ()
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.body.Wings.RightWing.RightWingZPivot.RightWingBone1.RightWingBone2.RightWingFinger1.RightWingTip1, ModelAlias.alias.dummy_avatar.body.Wings.RightWing.RightWingZPivot.RightWingBone1.RightWingBone2.RightWingBone3.RightWingFinger2.RightWingTip2, ModelAlias.alias.dummy_avatar.body.Wings.RightWing.RightWingZPivot.RightWingBone1.RightWingBone2.RightWingBone3.RightWingBone4.RightWingFinger3.RightWingTip3, ModelAlias.alias.dummy_avatar.body.Wings.RightWing.RightWingZPivot.RightWingBone1.RightWingBone2.RightWingBone3.RightWingBone4.RightWingBone5.RightWingBone6.RightWingBone7.RightWingBone8.RightWingFinger4.RightWingFinger4_2.RightWingFinger4_3.RightWingTip4, ModelAlias.alias.dummy_avatar.body.Wings.LeftWing.LeftWingZPivot.LeftWingBone1.LeftWingBone2.LeftWingFinger1.LeftWingTip1, ModelAlias.alias.dummy_avatar.body.Wings.LeftWing.LeftWingZPivot.LeftWingBone1.LeftWingBone2.LeftWingBone3.LeftWingFinger2.LeftWingTip2, ModelAlias.alias.dummy_avatar.body.Wings.LeftWing.LeftWingZPivot.LeftWingBone1.LeftWingBone2.LeftWingBone3.LeftWingBone4.LeftWingFinger3.LeftWingTip3, ModelAlias.alias.dummy_avatar.body.Wings.LeftWing.LeftWingZPivot.LeftWingBone1.LeftWingBone2.LeftWingBone3.LeftWingBone4.LeftWingBone5.LeftWingBone6.LeftWingBone7.LeftWingBone8.LeftWingFinger4.LeftWingFinger4_2.LeftWingFinger4_3.LeftWingTip4}) do
					modelPart:setPrimaryRenderType("CUTOUT")
				end
				ModelAlias.alias.dummy_avatar.head.DressHair.DressHairTail:setRot(50, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Dress:setScale(1.5, 0.7, 1.5)
				ModelAlias.alias.dummy_avatar.legs:setVisible(false)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.DressHair.DressHairTail:setRot(0, 0, -2.5)
				ModelAlias.alias.dummy_avatar.body.DressFrontHair:setRot(0, 0, -15)
				ModelAlias.alias.dummy_avatar.body.BackRibbon.RibbonBottomRight:setRot(15, 0, -20)
				ModelAlias.alias.dummy_avatar.body.BackRibbon.RibbonBottomLeft:setRot(15, 0, -5)
				ModelAlias.alias.dummy_avatar.body.Dress:setRot(20, 0, 0)
				ModelAlias.alias.dummy_avatar.body.Dress:setScale()
				ModelAlias.alias.dummy_avatar.legs:setVisible(true)
				ModelAlias.alias.dummy_avatar.body.Wings.RightWing:setRot(0, -120, 0)
				ModelAlias.alias.dummy_avatar.body.Wings.LeftWing:setRot(0, 40, 0)
			end
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.body.FlappablePendant};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 75;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -120;
							min = 0;
							max = 75;
						};

						bodyY = {
							multiplayer = -120;
							min = 0;
							max = 75;
						};

						bodyRot = {
							multiplayer = -0.1;
							min = 0;
							max = 75;
						};
					};

					horizontal = {
						min = 0;
						neutral = 75;
						max = 75;

						bodyX = {
							multiplayer = -120;
							min = 0;
							max = 75;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.DressHair.DressHairTail};

				x = {
					vertical = {
						min = -162.5;
						neutral = 20;
						max = 57.5;
						sneakOffset = -20;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -70;
							max = 57.5;
						};

						headRot = {
							multiplayer = 0.05;
							min = -70;
							max = 20;
						};

						bodyY = {
							multiplayer = 80;
							min = -162.5;
							max = 20;
						};
					};

					horizontal = {
						min = -162.5;
						neutral = -25;
						max = 57.5;

						headX = {
							multiplayer = -80;
							min = 57.5;
							max = -25;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.DressHair.DressHairTail.DressHairTailZPivot};

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
				models = {ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonRight};

				y = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 0;
						headRotMultiplayer = -0.5;

						headX = {
							multiplayer = -80;
							min = -80;
							max = 0;
						};

						headRot = {
							multiplayer = 0.05;
							min = -80;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonRight.DressHairRibbonRightZPivot};

				z = {
					vertical = {
						min = -35;
						neutral = -35;
						max = 0;

						bodyY = {
							multiplayer = -40;
							min = -35;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonLeft};

				y = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 80;
						headRotMultiplayer = 0.5;

						headX = {
							multiplayer = 80;
							min = 0;
							max = 80;
						};

						headRot = {
							multiplayer = -0.05;
							min = 0;
							max = 80;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonLeft.DressHairRibbonLeftZPivot};

				z = {
					vertical = {
						min = 0;
						neutral = 35;
						max = 35;

						bodyY = {
							multiplayer = 40;
							min = 0;
							max = 35;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonBottomRight, ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonBottomLeft};

				x = {
					vertical = {
						min = -162.5;
						neutral = 0;
						max = 0;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -70;
							max = 0;
						};

						headRot = {
							multiplayer = 0.05;
							min = -70;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -162.5;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonBottomRight.DressHairRibbonBottomRightZPivot};

				z = {
					vertical = {
						min = -15;
						neutral = 7.5;
						max = 30;

						headZ = {
							multiplayer = -20;
							min = -15;
							max = 30;
						};

						headRot = {
							multiplayer = 0.1;
							min = -15;
							max = 30;
						};

						bodyY = {
							multiplayer = -20;
							min = -15;
							max = 30;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonBottomLeft.DressHairRibbonBottomLeftZPivot};

				z = {
					vertical = {
						min = -30;
						neutral = -7.5;
						max = 15;

						headZ = {
							multiplayer = -20;
							min = -30;
							max = 15;
						};

						headRot = {
							multiplayer = -0.1;
							min = -30;
							max = 15;
						};

						bodyY = {
							multiplayer = 20;
							min = -30;
							max = 15;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.DressFrontHair};

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
						min = -145;
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
							min = -145;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -60;
							max = 0;
						};
					};

					horizontal = {
						min = -145;
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
						min = -30;
						neutral = 0;
						max = 30;

						bodyX = {
							multiplayer = 10;
							min = -30;
							max = 30;
						};

						bodyRot = {
							multiplayer = -0.025;
							min = -30;
							max = 30;
						};
					};

					horizontal = {
						min = -30;
						neutral = 0;
						max = 30;

						bodyX = {
							multiplayer = 10;
							min = -30;
							max = 30;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.BackRibbon.RibbonBottomLeft.RibbonBottomLeftZPivot};

				z = {
					vertical = {
						min = -30;
						neutral = 0;
						max = 30;

						bodyX = {
							multiplayer = -10;
							min = -30;
							max = 30;
						};

						bodyRot = {
							multiplayer = 0.025;
							min = -30;
							max = 30;
						};
					};

					horizontal = {
						min = -30;
						neutral = 0;
						max = 30;

						bodyX = {
							multiplayer = 10;
							min = -30;
							max = 30;
						};
					};
				};
			};
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model == ModelAlias.alias.avatar.head.DressHair.DressHairTail then
					model:setRot(math.min(model:getRot().x, 45), 0, 0)
				elseif model == ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonRight or model == ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonLeft then
					model:setRot(0, math.min(model:getRot().y, 0), 0)
				elseif model == ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonBottomRight or model == ModelAlias.alias.avatar.head.DressHair.DressHairRibbon.DressHairRibbonBottomLeft then
					model:setRot(math.min(model:getRot().x, 30), 0, 0)
				end
			end;
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	---@param self BlueArchiveCharacter
	init = function (self)
		---ヒナのマシンガンを制御するクラス
		---@type MachineGun
		MachineGun = require("scripts.machine_gun")

		---消えるブロックオブジェクトのインスタンスクラス
		---@type FadingBlock
		FadingBlock = require("scripts.fading_block")

		---消えるブロックオブジェクトのマネージャークラス
		---@type FadingBlockManager
		FadingBlockManager = require("scripts.fading_block_manager")
		FadingBlockManager = FadingBlockManager.new()

		MachineGun:init()
		FadingBlockManager.init()

		events.TICK:register(function ()
			if not client:isPaused() then
				local dressVisible = ModelAlias.alias.avatar.body.Dress:getVisible()
				local shouldHideLegs = dressVisible and player:getVehicle() ~= nil
				if shouldHideLegs and not self.costume.shouldHideLegsPrev then
					ModelAlias.alias.avatar.leg:setVisible(false)
					ModelAlias.alias.avatar.body.Dress:setScale(1.5, 0.7, 1.5)
				elseif not shouldHideLegs and self.costume.shouldHideLegsPrev then
					ModelAlias.alias.avatar.leg:setVisible(true)
					ModelAlias.alias.avatar.body.Dress:setScale()
				end

				self.costume.shouldAdjustLegs = dressVisible and not shouldHideLegs
				if not self.costume.shouldAdjustLegs and self.costume.shouldAdjustLegsPrev then
					for _, modelPart in ipairs({ModelAlias.alias.avatar.rightLeg, ModelAlias.alias.avatar.leftLeg}) do
						modelPart:setRot()
					end
				end

				self.costume.shouldHideLegsPrev = shouldHideLegs
				self.costume.shouldAdjustLegsPrev = self.costume.shouldAdjustLegs
			end
		end)

		events.RENDER:register(function (_, context)
			if not client:isPaused() then
				local wingRotOffset = math.map(vanilla_model.RIGHT_LEG:getOriginRot().x, -90, 90, 20, 0)
				ModelAlias.alias.avatar.body.Wings.RightWing:setRot(0, wingRotOffset * -1, 0)
				ModelAlias.alias.avatar.body.Wings.LeftWing:setRot(0, wingRotOffset, 0)

				local blockLightLevel = 15
				local skyLightLevel = 15
				if context ~= "FIGURA_GUI" and context ~= "MINECRAFT_GUI" and context ~= "PAPERDOLL" then
					local playerPos = player:getPos()
					blockLightLevel = world.getBlockLightLevel(playerPos)
					skyLightLevel = world.getSkyLightLevel(playerPos)
				end
				for _, modelPart in ipairs({ModelAlias.alias.avatar.body.DressBodyStarLayer, ModelAlias.alias.avatar.body.Dress.Dress2.Dress2StarLayer, ModelAlias.alias.avatar.body.Dress.Dress2.Dress3.Dress3StarLayer, ModelAlias.alias.avatar.body.Dress.Dress2.Dress3.Dress4.Dress4StarLayer}) do
					modelPart:setLight(math.min(blockLightLevel + 5, 15), math.min(skyLightLevel + 5, 15))
				end

				if self.costume.shouldAdjustLegs then
					local rightLegRotX = vanilla_model.RIGHT_LEG:getOriginRot().x
					ModelAlias.alias.avatar.rightLeg:setRot(rightLegRotX * -0.45, 0, 0)
					ModelAlias.alias.avatar.leftLeg:setRot(vanilla_model.LEFT_LEG:getOriginRot().x * -0.45, 0, 0)
				end
			end
		end)
	end;
}

return BlueArchiveCharacter
