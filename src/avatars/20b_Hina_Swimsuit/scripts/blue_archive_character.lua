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
---| "SWIM_RING" # 浮き輪を持つ手

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
		avatarName = "20b_Hina_Swimsuit";

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
			CLOSED2 = vectors.vec2(6, 0);
			SURPRISED_CENTER = vectors.vec2(7, 0);
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
			CLOSED2 = vectors.vec2(5, 0);
			SWIMSUIT_CENTER = vectors.vec2(7, 0);
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
			onArmStateChanged = function (self, right, left)
				local result = {right = right, left = left}

				if right == "DEFAULT" and self.costume.hasRing then
					result.right = "SWIM_RING"
				elseif right == "CROSSBOW" and Gun.currentGunPosition == "RIGHT" then
					result.right = "GUN_MAIN_HAND"
				end

				if left == "DEFAULT" and self.costume.hasRing then
					result.left = "SWIM_RING"
				elseif left == "CROSSBOW" and Gun.currentGunPosition == "LEFT" then
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
				elseif state == "SWIM_RING" then
					local shouldArmModified = false
					events.TICK:register(function ()
						if Arms.armState.right == "SWIM_RING" then
							local activeHand = player:getActiveHand()
							local isLeftHanded = player:isLeftHanded()
							shouldArmModified = (player:getActiveItem().id == "minecraft:air" or ((activeHand == "OFF_HAND" and not isLeftHanded) or (activeHand == "MAIN_HAND" and isLeftHanded))) and (not player:isSwingingArm() or isLeftHanded)
							ModelAlias.alias.avatar.rightArm:setRot(shouldArmModified and vectors.vec3(0, 0, 35) or vectors.vec3())
						end
					end, "right_arm_tick")
					events.RENDER:register(function (_, context)
						if Arms.armState.right == "SWIM_RING" then
							ModelAlias.alias.avatar.rightArm:setParentType((shouldArmModified and context ~= "FIRST_PERSON") and "Body" or "RightArm")
						end
					end, "right_arm_render")
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
				elseif state == "SWIM_RING" then
					local shouldArmModified = false
					events.TICK:register(function ()
						if Arms.armState.left == "SWIM_RING" then
							local activeHand = player:getActiveHand()
							local isLeftHanded = player:isLeftHanded()
							shouldArmModified = (player:getActiveItem().id == "minecraft:air" or ((activeHand == "MAIN_HAND" and not isLeftHanded) or (activeHand == "OFF_HAND" and isLeftHanded))) and (not player:isSwingingArm() or not isLeftHanded)
							ModelAlias.alias.avatar.leftArm:setParentType(shouldArmModified and "Body" or "LeftArm")
							ModelAlias.alias.avatar.leftArm:setRot(shouldArmModified and vectors.vec3(0, 0, -35) or vectors.vec3())
						end
					end, "left_arm_tick")
					events.RENDER:register(function (_, context)
						if Arms.armState.left == "SWIM_RING" then
							ModelAlias.alias.avatar.leftArm:setParentType((shouldArmModified and context ~= "FIRST_PERSON") and "Body" or "LeftArm")
						end
					end, "left_arm_render")
				end
			end;
		}
	};

	skirt = {
		skirtModels = {};
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

			models = {ModelAlias.alias.avatar.head.Cheek, ModelAlias.alias.avatar.body.RightWing, ModelAlias.alias.avatar.body.SwimRing.SRArmbandEmissive};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(15, 210, 0);
					pos = vectors.vec3(-12.75, 15, -4);
				};

				fin = {
					rot = vectors.vec3(0, 180, -25);
					pos = vectors.vec3(1.74, 20.33, -32.55);
				};
			};

			callbacks = {
				onPreAnimation = function ()
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.SwimRing, ModelAlias.alias.avatar.body.Wings}) do
						modelPart:setVisible(true)
					end
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "EMBARRASSING", 30, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 15 and host:isHost() then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.5, 0.75)
					elseif tick == 18 and host:isHost() then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.5, 1)
					elseif tick == 21 and host:isHost() then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 0.5, 1.25)
					elseif tick == 30 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "EMBARRASSING", 4, true)
					elseif tick == 34 then
						FaceParts:setEmotion("SURPRISED_CENTER", "SURPRISED", "ANXIOUS", 10, true)
						sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 1, 2)
					elseif tick == 44 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", 6, true)
					elseif tick == 45 then
						sounds:playSound("minecraft:entity.bat.takeoff", player:getPos(), 0.5, 1.25)
					elseif tick == 50 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", 3, true)
					elseif tick == 52 then
						MachineGun.exSkillIsHolding = true
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
					elseif tick == 53 then
						FaceParts:setEmotion("NORMAL", "SWIMSUIT_CENTER", "CLOSED", 46, true)
						sounds:playSound("minecraft:item.bucket.empty", player:getPos(), 1, 1.5)
					elseif tick == 55 then
						sounds:playSound("minecraft:entity.lightning_bolt.thunder", player:getPos(), 0.5, 2)
					end

					if tick <= 14 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.body.SwimRing.SRArmband)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 4 do
							particles:newParticle("minecraft:end_rod", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(20, math.random() * 0.6 - 0.3, math.random() * 0.4 - 0.2, math.random() * 0.6 - 0.3, 0, 0, 1), 0, 1, 0))):setScale(0.25):setColor(0.98, 0.62, 0.84):setGravity(0):setLifetime(10)
						end
					elseif tick >= 53 and tick <= 57 then
						local anchorPos = player:getPos():add(0, 1, 0)
						local bodyYaw = player:getBodyYaw()
						for i = 0, 5 do
							local offsetPos = vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(20, vectors.rotateAroundAxis(180 + ((tick - 52) * 6 + i) * 10 , 0, 0, 1, 0, 1, 0), 0, 0, 1), 0, 1, 0)
							particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy():add(offsetPos)):setScale(0.5):setVelocity(offsetPos:copy():scale(0.1)):setColor(vectors.vec3(0.96, 0.6, 1):add(vectors.vec3(1, 1, 1):sub(0.96, 0.6, 1):scale(math.random()))):setLifetime(4 + math.random() * 4)
						end
						if tick >= 54 and tick <= 55 then
							for _, particleData in ipairs({{1, -0.01}, {2.5, 0.00001}, {4, 0.02}}) do
								particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(20, vectors.rotateAroundAxis(180 + ((tick - 52) * 6 + particleData[1]) * 10 , 0, 0, 1, 0, 1, 0), 0, 0, 1), 0, 1, 0))):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, particleData[2], 0.03, 0, 1, 0)):setColor(vectors.vec3(0.96, 0.6, 1):add(vectors.vec3(1, 1, 1):sub(0.96, 0.6, 1):scale(math.random()))):setLifetime(45)
							end
						end
					end
					if tick >= 12 and tick < 48 then
						local anchorPos = player:getPos()
						for _ = 1, 4 do
							particles:newParticle("minecraft:end_rod", anchorPos:copy():add(vectors.rotateAroundAxis(math.random() * 360, 0, math.random() * 2, math.random() * 1.5, 0, 1, 0))):setColor(0.98, 0.62, 0.84):setScale(0.5):setLifetime(10)
						end
					end
					if tick >= 34 and tick < 44 then
						local anchorPos = player:getPos()
						for _ = 1, 4 do
							particles:newParticle("minecraft:firework", anchorPos:copy():add(vectors.rotateAroundAxis(math.random() * 360, 0, math.random() * 2, math.random() * 1.5, 0, 1, 0))):setScale(0.5):setGravity(0):setLifetime(20)
						end
					end
				end;

				onPostAnimation = function (self)
					ModelAlias.alias.avatar.body.Wings:setVisible(false)
					ModelAlias.alias.avatar.body.SwimRing:setVisible(self.costume.hasRing)
					for _, modelPart in ipairs({ModelAlias.alias.avatar.body.LeftWing, ModelAlias.alias.avatar.body.RightWing.RightWingZPivot.RightWingBone1.RightWingBone2.RightWingBone3.RightWingBone4.RightWingBone5.RightWingBone6.RightWingBone7.RightWingBone8.RightWingClaw}) do
						modelPart:setVisible(true)
					end
					if ModelAlias.alias.avatar.rightArmBottom.Gun ~= nil then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
						if Gun.currentGunPosition == "NONE" then
							if player:isLeftHanded() then
								ModelAlias.alias.avatar.body.Gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.left))
								ModelAlias.alias.avatar.body.Gun:setRot(self.gun.gunPosition.put.rot.left)
							else
								ModelAlias.alias.avatar.body.Gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos.right))
								ModelAlias.alias.avatar.body.Gun:setRot(self.gun.gunPosition.put.rot.right)
							end
						end
					end
					MachineGun.exSkillIsHolding = false
				end;
			};
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (_, parts, isVisible)
				if parts == "CHEST_PLATE" then
					ModelAlias.alias.avatar.body.FrontHair:setPos(0, 0, isVisible and -1 or 0)
				end
			end;
		};

		---浮き輪を装備しているかどうか。
		---@type boolean
		hasRing = false;

		---前ティックに浮き輪を装備していたかどうか。
		---@type boolean
		hasRingPrev = false;

		---浮き輪装備を解除する。
		---@param self BlueArchiveCharacter
		removeSwimRing = function (self)
			self.costume.hasRing = false
			self.costume.hasRingPrev = false
			ModelAlias.alias.avatar.body.SwimRing:setVisible(ExSkill.animationCount >= 0)
			ModelAlias.alias.avatar.body.SwimRing:setPos()
			ModelAlias.alias.avatar.body.SwimRing:setRot()
			if Gun.currentGunPosition == "NONE" then
				Arms:setArmState("DEFAULT", "DEFAULT")
			end
		end;
	};

	bubble = {
		callbacks = {
			onPlay = function (_, type, duration)
				if type == "GOOD" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", duration, true)
				elseif type == "HEART" then
					FaceParts:setEmotion("CLOSED", "CLOSED", "TEETH_SMILE", duration, true)
				elseif type == "NOTE" then
					FaceParts:setEmotion("NORMAL", "NORMAL", "TEETH_SMILE", duration, true)
				elseif type == "QUESTION" then
					ModelAlias.alias.avatar.head.Sweat:setVisible(true)
					FaceParts:setEmotion("NORMAL", "NORMAL", "EMBARRASSING", duration, true)
				elseif type == "SWEAT" then
					ModelAlias.alias.avatar.head.Cheek:setVisible(true)
					FaceParts:setEmotion("SURPRISED", "SURPRISED", "ANXIOUS", duration, true)
				end
			end;

			onStop = function(_, _, forcedStop)
				for _, modelPart in ipairs({ModelAlias.alias.avatar.head.Sweat, ModelAlias.alias.avatar.head.Cheek}) do
					modelPart:setVisible(false)
				end
				if forcedStop then
					FaceParts:resetEmotion()
				end
			end;
		};
	};

	headModel = {

	};

	headBlock = {
		includeModels = {ModelAlias.alias.avatar.body.FrontHair};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {
		callbacks = {
			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.BackHairs.BottomBackHair:setRot(22.5, 0, 0)
				ModelAlias.alias.dummy_avatar.head.SideHairTail:setRot(30, 0, -10)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.SideHairTail:setRot(-20, 0, -7.5)
				ModelAlias.alias.dummy_avatar.head.BackHairs.BottomBackHair:setRot(-20, 0, 0)
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.body.FrontHair.RightFrontHair, ModelAlias.alias.dummy_avatar.body.FrontHair.LeftFrontHair}) do
					modelPart:setRot(0, 0, -15)
				end
			end
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
						min = -70;
						neutral = -30;
						max = -5;

						headX = {
							multiplayer = 40;
							min = -70;
							max = -5;
						};

						bodyY = {
							multiplayer = 40;
							min = -50;
							max = -5;
						};
					};

					horizontal = {
						min = -70;
						neutral = -30;
						max = -30;

						bodyX = {
							multiplayer = 80;
							min = -70;
							max = -30;
						};
					};
				};

				y = {
					vertical = {
						min = -25;
						neutral = -25;
						max = -25;
					};

					horizontal = {
						min = -25;
						neutral = -25;
						max = -25;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.BackHairs.BottomBackHair};

				x = {
					vertical = {
						min = -130;
						neutral = -5;
						max = -15;
						sneakOffset = -30;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -40;
							min = -90;
							max = -5;
						};

						headRot = {
							multiplayer = 0.025;
							min = -90;
							max = -5;
						};

						bodyY = {
							multiplayer = 40;
							min = -130;
							max = -5;
						};
					};

					horizontal = {
						min = -130;
						neutral = -30;
						max = -5;

						headX = {
							multiplayer = -80;
							min = -45;
							max = -5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.FrontHair};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 150;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -60;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -60;
							min = 0;
							max = 150;
						};

						bodyRot = {
							multiplayer = -0.03;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
						max = 150;

						bodyX = {
							multiplayer = -60;
							min = 0;
							max = 150;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.SideHairTail};

				x = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -60;
							min = -90;
							max = 90;
						};
					};

					horizontal = {
						min = -45;
						neutral = 45;
						max = 45;

						headX = {
							multiplayer = -120;
							min = -45;
							max = 45;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.SideHairTail.SideHairTailZPivot};

				z = {
					vertical = {
						min = -170;
						neutral = -7.5;
						max = -7.5;

						headZ = {
							multiplayer = -40;
							min = -60;
							max = -7.5;
						};

						headRot = {
							multiplayer = 0.025;
							min = -60;
							max = -7.5;
						};

						bodyY = {
							multiplayer = 60;
							min = -170;
							max = -7.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Whistle.WhistleFront};

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
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model == ModelAlias.alias.avatar.head.BackHairs.BottomBackHair then
					local rot = math.deg(math.asin(player:getLookDir().y)) - model:getRot().x
					if rot < 0 then
						ModelAlias.alias.avatar.head.BackHairs.BottomBackHair:setOffsetPivot(0, 0, 2)
					else
						ModelAlias.alias.avatar.head.BackHairs.BottomBackHair:setOffsetPivot()
					end
				elseif model == ModelAlias.alias.avatar.head.BackHairs.TopBackHair then
					model:setRot(math.min(model:getRot().x, 20), 0, 0)
				elseif model == ModelAlias.alias.avatar.head.Horns.HornBL.LeftHornRibbon or model == ModelAlias.alias.avatar.head.Horns.HornBR.RightHornRibbon then
					model:setRot(math.min(model:getRot().x, 0), 0, 0)
				end
			end
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function (self)
		---ヒナのマシンガンを制御するクラス
		---@type MachineGun
		MachineGun = require("scripts.machine_gun")

		MachineGun:init()

		ModelAlias.alias.avatar.body:newText("costume_swimsuit_text_1"):setText("§05-A"):setPos(0, -3, -2):setScale(0.05):setAlignment("CENTER")
		ModelAlias.alias.avatar.body:newText("costume_swimsuit_text_2"):setText("§0ひな"):setPos(0, -3.35, -2):setScale(0.2):setAlignment("CENTER")
		ModelAlias.alias.avatar.body.SwimRing.SRArmband:newText("costume_swimsuit_text_3"):setText("§l風紀"):setPos(0, 0.75, -3.3):setScale(0.33):setAlignment("CENTER")

		events.TICK:register(function ()
			self.costume.hasRing = player:getItem(6).id == "minecraft:turtle_helmet" and not Armor.shouldShowArmor and not player:isUnderwater() and ExSkill.animationCount == -1
			if self.costume.hasRing ~= self.costume.hasRingPrev then
				if self.costume.hasRing then
					ModelAlias.alias.avatar.body.SwimRing:setVisible(true)
					ModelAlias.alias.avatar.body.SwimRing:setPos(0, 2, 0)
					ModelAlias.alias.avatar.body.SwimRing:setRot(90, 0, 0)
					if Gun.currentGunPosition == "NONE" then
						Arms:setArmState("SWIM_RING", "SWIM_RING")
					end
				else
					self.costume.removeSwimRing(self)
				end
			end
			self.costume.hasRingPrev = self.costume.hasRing
		end)

        events.RENDER:register(function ()
			if not client:isPaused() then
				local wingRotOffset = math.map(vanilla_model.RIGHT_LEG:getOriginRot().x, -90, 90, 20, 0)
				ModelAlias.alias.avatar.body.Wings.RightWing:setRot(0, wingRotOffset * -1, 0)
				ModelAlias.alias.avatar.body.Wings.LeftWing:setRot(0, wingRotOffset, 0)
			end
        end)
	end;
}

return BlueArchiveCharacter
