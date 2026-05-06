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

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "CLOSED" # 閉じた口
---| "SMILE" # にっこり

---キャラクター固有の腕の状態
---@alias BlueArchiveCharacter.AdditionalArmState
---| "RAIL_GUN_MAIN_HAND" # レールガンを構えている際の、武器を構えている方の腕
---| "RAIL_GUN_OFF_HAND" # レールガンを構えている際の、武器を構えていない方の腕

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
		avatarName = "00a_base";

		birth = {
			month = 1;
			day = 1;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(5, 0);
			CENTER = vectors.vec2(6, 0)
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CLOSED2 = vectors.vec2(4, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(0, 0);
			SMILE = vectors.vec2(1, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				local result = {right = right, left = left}
				if right == "GUN_MAIN_HAND" then
					result.right = "RAIL_GUN_MAIN_HAND"
				elseif right == "GUN_OFF_HAND" then
					result.right = "RAIL_GUN_OFF_HAND"
				elseif right == "CROSSBOW" and Gun.currentGunPosition == "RIGHT" then
					result.right = "RAIL_GUN_MAIN_HAND"
				end

				if left == "GUN_MAIN_HAND" then
					result.left = "RAIL_GUN_MAIN_HAND"
				elseif left == "GUN_OFF_HAND" then
					result.left = "RAIL_GUN_OFF_HAND"
				elseif left == "CROSSBOW" and Gun.currentGunPosition == "LEFT" then
					result.left = "RAIL_GUN_MAIN_HAND"
				end

				return result
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "RAIL_GUN_MAIN_HAND" then
					events.TICK:register(function ()
						if Arms.armState.right == "RAIL_GUN_MAIN_HAND" then
							Arms:processArmSwingCount()
							if player:isSwingingArm() and not player:isLeftHanded() then
								ModelAlias.alias.avatar.rightArm:setParentType("RightArm")
							else
								ModelAlias.alias.avatar.rightArm:setParentType("Body")
							end
							if player:getActiveItem().id == "minecraft:crossbow" then
								Arms:setArmState("CROSSBOW", "CROSSBOW")
							end
						end
					end, "right_arm_tick")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local rotY = headRot.y % 360
						rotY = rotY > 180 and 0 or rotY
						ModelAlias.alias.avatar.rightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3() or vectors.vec3(math.max(headRot.x - 40 + (player:isCrouching() and 30 or 0), -40) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5, rotY, 0))
					end, "right_arm_render")
					return true
				elseif state == "RAIL_GUN_OFF_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
					end, "right_arm_tick")
					events.RENDER:register(function (delta, context)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
						ModelAlias.alias.avatar.rightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.max(headRot.x + 50 + (player:isCrouching() and 30 or 0), 40), math.min(math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78) + 30, 65) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5, 0))
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "RAIL_GUN_MAIN_HAND" then
					events.TICK:register(function ()
						if Arms.armState.left == "RAIL_GUN_MAIN_HAND" then
							Arms:processArmSwingCount()
							if player:isSwingingArm() and player:isLeftHanded() then
								ModelAlias.alias.avatar.leftArm:setParentType("LeftArm")
							else
								ModelAlias.alias.avatar.leftArm:setParentType("Body")
							end
							if player:getActiveItem().id == "minecraft:crossbow" then
								Arms:setArmState("CROSSBOW", "CROSSBOW")
							end
						end
					end, "left_arm_tick")
					events.RENDER:register(function (delta)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local rotY = headRot.y % 360
						rotY = rotY < 180 and 0 or rotY
						ModelAlias.alias.avatar.leftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3() or vectors.vec3(math.max(headRot.x - 40 + (player:isCrouching() and 30 or 0), -40) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5, rotY, 0))
					end, "left_arm_render")
				elseif state == "RAIL_GUN_OFF_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local headRot = vanilla_model.HEAD:getOriginRot()
						local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
						ModelAlias.alias.avatar.leftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.max(headRot.x + 50 + (player:isCrouching() and 30 or 0), 40), math.max(math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21) - 30, -65) + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5, 0))
					end, "left_arm_render")
				end
			end;
		};
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 3;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(6, 0, -22);
					left = vectors.vec3(-6, 0, -22);
				};

				thirdPersonPos = {
					right = vectors.vec3(0, 7, 3);
					left = vectors.vec3(0, 7, 3);
				};

				thirdPersonRot = {
					right = vectors.vec3(130, 0, 0);
					left = vectors.vec3(130, 0, 0);
				};
			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(0, 1.5, 4);
					left = vectors.vec3(0, 1.5, 4);
				};

				rot = {
					right = vectors.vec3(0, -90, -25);
					left = vectors.vec3(0, 90, 25);
				};
			};
		};

		sound = {
			name = "minecraft:entity.blaze.hurt";
			pitch = 2;
		};
	};

	placementObjects = {
		{
			model = models.models.placement_object.PlacementObject;

			boundingBox = {
				size = vectors.vec3(8, 8, 8)
			};

			placementMode = "COPY";
		};
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {ModelAlias.alias.avatar.head.EyeShines, ModelAlias.alias.avatar.gun.UpperShell.UpperShellTop.BeltFront, ModelAlias.alias.avatar.gun.BeltBack, models.models.ex_skill_1.Desk, models.models.ex_skill_1.Gui};

			animations = {"main", "gun", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(45, 160, 0);
					pos = vectors.vec3(25, 40, 91);
				};

				fin = {
					rot = vectors.vec3(0, -180, 0);
					pos = vectors.vec3(0, 23.5, -52);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						--デスクの準備
						for i = 0, 1 do
							models.models.ex_skill_1.Desk:newBlock("ex_skill_1_desk_block_" .. (i + 1))
								:setBlock("minecraft:smooth_quartz_stairs[facing=east,half=top]")
								:setPos(-16, 0, i * 16)
						end
						for i = 0, 2 do
							for j = 0, 1 do
								models.models.ex_skill_1.Desk:newBlock("ex_skill_1_desk_block_" .. (i * 2 + j + 3))
									:setBlock("minecraft:smooth_quartz_slab[type=top]")
									:setPos((i + 2) * -16, 0, j * 16)
							end
						end
						for i = 0, 1 do
							models.models.ex_skill_1.Desk:newBlock("ex_skill_1_desk_block_" .. (i + 9))
								:setBlock("minecraft:smooth_quartz_stairs[facing=west,half=top]")
								:setPos(-80, 0, i * 16)
						end
						local paintings = {"minecraft:alban", "minecraft:aztec", "minecraft:aztec2", "minecraft:bomb", "minecraft:kebab", "minecraft:plant", "minecraft:wasteland", "minecraft:meditative"}
						local gameVersion = client:getVersion()
						for i = 0, 1 do
							models.models.ex_skill_1.Desk:newBlock("ex_skill_1_desk_block_" .. (i + 11))
								:setBlock("minecraft:iron_block")
								:setPos(i * 16 - 48, 16, 16)
							models.models.ex_skill_1.Desk:newEntity("ex_skill_1_entity_" .. (i + 1))
								:setNbt("minecraft:painting", "{variant: \"" .. (paintings[math.random(StringUtils.compareVersions(gameVersion, "1.21.0") == gameVersion and 7 or #paintings)]) .. "\"}")
								:setPos(i * -16 - 24, 24, 16)
								:setRot(0, 180, 0)
						end
						models.models.ex_skill_1.Desk:newBlock("ex_skill_1_desk_block_13")
							:setBlock("minecraft:potted_blue_orchid")
							:setPos(-64, 16, 16)
						models.models.ex_skill_1.Desk:newBlock("ex_skill_1_desk_block_14")
							:setBlock("minecraft:heavy_weighted_pressure_plate")
							:setPos(-32, 16, 0)
						models.models.ex_skill_1.Desk:newItem("ex_skill_1_desk_item")
							:setItem("minecraft:iron_pickaxe")
							:setPos(-46, 16.5, 8)
							:setRot(90, 70, 0)

						--写真の色味調整
						for i = 1, 4 do
							models.models.ex_skill_1.CyberArea.CyberImages["CyberImage" .. i]["CyberImage" .. i]:setLight(15, 15)
						end

						self.exSkill.primary.isInitialized = true
					end

					if host:isHost() then
						local gameVersion = client:getVersion()
						local shouldAdjustBackgroundRot = StringUtils.compareVersions(gameVersion, "1.21.0") == gameVersion
						models.models.ex_skill_1.Gui.ScreenFilter:setScale(client:getScaledWindowSize():copy():augmented(1))
						events.RENDER:register(function ()
							if shouldAdjustBackgroundRot then
								for i = 1, 4 do
									models.models.ex_skill_1.CyberArea.CyberImages["CyberImage" .. i]["CyberImage" .. i]:setRot(0, 0, renderer:getCameraRot().z)
								end
							end
							models.models.ex_skill_1.Gui.ScreenFilter:setOpacity(models.models.ex_skill_1.Gui.ScreenFilterOpacity:getAnimScale().x)
						end, "ex_skill_1_render_host")
					end
					events.RENDER:register(function ()
						ModelAlias.alias.avatar.head.EyeShines:setOpacity(ModelAlias.alias.avatar.head.EyeShines.EyeShinesOpacity:getAnimScale().x)
					end, "ex_skill_1_render")

					FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED", 188, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 0 then
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
					elseif tick == 36 then
						models.models.ex_skill_1.Desk.Mascot.MascotHead.MascotFace:setUVPixels(0, 7)
					elseif tick == 46 then
						models.models.ex_skill_1.Desk.Mascot.MascotHead.MascotFace:setUVPixels(0, 14)
					elseif tick == 59 then
						models.models.ex_skill_1.Desk.Mascot.MascotHead.MascotFace:setUVPixels(0, 21)
						sounds:playSound("minecraft:block.beacon.activate", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Desk.Mascot), 0.5, 2)
					elseif tick == 65 then
						models.models.ex_skill_1.Desk.Mascot.MascotHead.MascotFace:setPrimaryRenderType("EMISSIVE_SOLID")
					elseif tick == 93 and host:isHost() then
						models.models.ex_skill_1.CyberArea.CyberAreaBase:setColor(0, 0, 1)
						models.models.ex_skill_1.CyberArea.CyberAreaEffect1:setColor(0.757, 0.859, 1)
						models.models.ex_skill_1.CyberArea:setVisible(true)
					elseif tick == 94 and host:isHost() then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.CyberArea.Face)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 50 do
							local offset = vectors.vec3(math.random() * 2.5 - 1.25, math.random() * 1.75 - 0.875, 0)
							particles:newParticle("minecraft:end_rod", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, offset, 0, 1, 0))):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, offset.x * 0.025, offset.y * 0.025, 0.15 * math.random(), 0, 1, 0)):setColor(0.833, 0.977, 0.999)
						end
						sounds:playSound("minecraft:entity.player.splash", anchorPos, 1, 2)
					elseif tick == 185 and host:isHost() then
						models.models.ex_skill_1.CyberArea.CyberAreaBase:setColor(0.987, 0.731, 0.910)
						models.models.ex_skill_1.CyberArea.CyberAreaEffect1:setColor(0.998, 0.959, 1)
						models.models.ex_skill_1.CyberArea.CyberImages:setVisible(false)
					elseif tick == 188 then
						FaceParts:setEmotion("CENTER", "NORMAL", "SMILE", 37, true)
						local bodyYaw = player:getBodyYaw()
						local anchorPos = ModelUtils.getModelWorldPos(models.models.main.Avatar):copy():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 1.5, -1, 0, 1, 0))
						for i = 0, 35 do
							particles:newParticle("minecraft:end_rod", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 10, 0, 0.1 + math.random() * 0.1, 0, 0, 0, 1), 0, 1, 0))
						end
						sounds:playSound("minecraft:entity.player.levelup", anchorPos, 1, 1.5)
					end

					if tick >= 80 then
						local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Desk.Mascot.MascotHead.MascotFace)
						local bodyYaw = player:getBodyYaw()
						for _ = 1, 2 do
							particles:newParticle("minecraft:end_rod", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.2083 - 0.1042, math.random() * 0.1458 - 0.0729, 0, 0, 1, 0))):setScale(0.05):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, 0.008, 0, 1, 0)):setColor(1, 0.749, 0.271)
						end
					end
					if host:isHost() and tick % 4 == 0 then
						local face = math.random(1, 4)
						if face == 1 then
							--下面
							ExSkill1TextManager:spawn(vectors.vec3(math.random() * 144 - 72, math.random() * 10, 72), face)
						elseif face == 2 then
							--上面
							ExSkill1TextManager:spawn(vectors.vec3(math.random() * 144 - 72, 144 - math.random() * 10, 72), face)
						elseif face == 3 then
							--左面
							ExSkill1TextManager:spawn(vectors.vec3(math.random() * 10 - 72, math.random() * 144, 72), face)
						elseif face == 4 then
							--右面
							ExSkill1TextManager:spawn(vectors.vec3(math.random() * 10 + 62, math.random() * 144, 72), face)
						end
					end
				end;

				onPostAnimation = function (self, forcedStop)
					events.RENDER:remove("ex_skill_1_render")
					if Gun.currentGunPosition == "NONE" then
						local isLeftHanded = player:isLeftHanded()
						ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 12, 0):add(self.gun.gunPosition.put.pos[isLeftHanded and "left" or "right"]))
						ModelAlias.alias.avatar.gun:setRot(self.gun.gunPosition.put.rot[isLeftHanded and "left" or "right"])
					end
					models.models.ex_skill_1.Desk.Mascot.MascotHead.MascotFace:setUVPixels()
					models.models.ex_skill_1.Desk.Mascot.MascotHead.MascotFace:setPrimaryRenderType("CUTOUT")
					if host:isHost() then
						events.RENDER:remove("ex_skill_1_render_host")
						models.models.ex_skill_1.CyberArea:setVisible(false)
						models.models.ex_skill_1.CyberArea.CyberImages:setVisible(true)
						ExSkill1TextManager:removeAll()
					end
				end;
			};

			---このExスキルが初期化されたかどうか
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;
	};

	bubble = {

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
						min = -170;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -40;
							min = -80;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -170;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.025;
							min = -80;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Ribbon.RibbonRightTip};

				z = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyY = {
							multiplayer = -20;
							min = -40;
							max = 40;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Ribbon.RibbonRightTip.RibbonRightTipZPivot};

				y = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 0;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
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
				models = {ModelAlias.alias.avatar.head.Ribbon.RibbonLeftTip};

				z = {
					vertical = {
						min = -40;
						neutral = 0;
						max = 40;

						bodyY = {
							multiplayer = 20;
							min = -40;
							max = 40;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Ribbon.RibbonLeftTip.RibbonLeftTipZPivot};

				y = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 80;
						headRotMultiplayer = 1;

						headX = {
							multiplayer = 80;
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
				models = {ModelAlias.alias.avatar.head.Ribbon.RibbonBottomTip.RibbonBottomRightTip, ModelAlias.alias.avatar.head.Ribbon.RibbonBottomTip.RibbonBottomLeftTip};

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
				models = {ModelAlias.alias.avatar.head.Ribbon.RibbonBottomTip.RibbonBottomRightTip.RibbonBottomRightTipZPivot};

				z = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 22.5;

						headX = {
							multiplayer = 10;
							min = 0;
							max = 22.5;
						};

						headRot = {
							multiplayer = -0.025;
							min = 0;
							max = 22.5;
						};

						bodyY = {
							multiplayer = 10;
							min = 0;
							max = 22.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Ribbon.RibbonBottomTip.RibbonBottomLeftTip.RibbonBottomLeftTipZPivot};

				z = {
					vertical = {
						min = -22.5;
						neutral = 0;
						max = 0;

						headX = {
							multiplayer = -10;
							min = -22.5;
							max = 0;
						};

						headRot = {
							multiplayer = 0.025;
							min = -22.5;
							max = 0;
						};

						bodyY = {
							multiplayer = -10;
							min = -22.5;
							max = 0;
						};
					};
				};
			};
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model == ModelAlias.alias.avatar.head.Ribbon.RibbonRightTip.RibbonRightTipZPivot then
					model:setRot(0, math.min(model:getRot().y, 0), 0)
				elseif model == ModelAlias.alias.avatar.head.Ribbon.RibbonLeftTip.RibbonLeftTipZPivot then
					model:setRot(0, math.max(model:getRot().y, 0), 0)
				elseif model == ModelAlias.alias.avatar.head.Ribbon.RibbonBottomTip.RibbonBottomRightTip or model == ModelAlias.alias.avatar.head.Ribbon.RibbonBottomTip.RibbonBottomLeftTip then
					model:setRot(math.min(model:getRot().x, 0), 0, 0)
				elseif model == ModelAlias.alias.avatar.body.Hairs.BackHair then
					if player:isCrouching() then
						local rot = model:getRot().x
						model:setRot(math.min(rot + 30, 0))
						model.BackHairBottom:setRot(math.max(rot + 30, 0))
					else
						model.BackHairBottom:setRot()
					end
				end
			end;
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---レールガンを制御するクラス
		---@type RailGun
		RailGun = require("scripts.rail_gun")

		---Exスキルで使用するテキストオブジェクトのインスタンスクラス
		---@type ExSkillSprite
		ExSkill1Text = require("scripts.ex_skill_1_text")

		---Exスキルで使用するテキストオブジェクトのマネージャークラス
		---@type ExSkill1TextManager
		ExSkill1TextManager = require("scripts.ex_skill_1_text_manager")
		ExSkill1TextManager = ExSkill1TextManager.new()

		RailGun:enable()
	end;
}

return BlueArchiveCharacter
