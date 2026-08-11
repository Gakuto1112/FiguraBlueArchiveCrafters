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
---| "ANGRY" # 怒った目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "CENTER" # 少し反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "INVERTED" # 反対側を見る目
---| "ANGRY_INVERTED" # 怒りつつ反対側を見る目
---| "ANGRY" # 怒った目
---| "ANGRY_CENTER" # 怒りつつ少し反対側を見る目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "TRIANGLE" # 三角口
---| "HAT" # への口
---| "HAPPY" # 幸せのぐじゅぐじゅ口

---キャラクター固有の腕の状態
---@alias BlueArchiveCharacter.AdditionalArmState
---| "NONE" # 固有の腕の状態なし（追加時にこれは削除する）

--[[ ******************************** ]]

---@class (exact) BlueArchiveCharacter.BasicStruct 生徒の基本情報のデータ構造体
---@field public avatarName string アバターのファイル名（例: "00a_Base", "01a_shizuko", "01b_shizuko_swimsuit"）
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
		avatarName = "24a_Natsu";

		birth = {
			month = 12;
			day = 4;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CLOSED2 = vectors.vec2(6, 0);
			ANGRY = vectors.vec2(8, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			CENTER = vectors.vec2(4, 0);
			CLOSED2 = vectors.vec2(5, 0);
			INVERTED = vectors.vec2(6, 0);
			ANGRY_INVERTED = vectors.vec2(8, 0);
			ANGRY = vectors.vec2(9, 0);
			ANGRY_CENTER = vectors.vec2(10, 0);
		};

		mouth = {
			TRIANGLE = vectors.vec2(0, 0);
			HAT = vectors.vec2(1, 0);
			HAPPY = vectors.vec2(2, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (_, right, left)
				if right == "GUN_MAIN_HAND" and left == "GUN_OFF_HAND" then
					local isLeftHanded = player:isLeftHanded()
					if (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem().id == "minecraft:shield" and isLeftHanded) then
						return {right = "GUN_MAIN_HAND", left = "SHIELD_HAND"}
					end
				elseif right == "GUN_OFF_HAND" and left == "GUN_MAIN_HAND" then
					local isLeftHanded = player:isLeftHanded()
					if (player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded) then
						return {right = "SHIELD_HAND", left = "GUN_MAIN_HAND"}
					end
				end
			end;

			onAdditionalRightArmProcess = function (_, state)
				if state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded)) and Arms.armState.right == "GUN_OFF_HAND" then
							Arms:setArmState("SHIELD_HAND", nil)
						end
					end, "right_arm_tick")
					Arms:registerRightArmRenderEvent("GUN_OFF_HAND")
					return true
				elseif state == "SHIELD_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id ~= "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id ~= "minecraft:shield" and isLeftHanded)) and Arms.armState.right == "SHIELD_HAND" then
							Arms:setArmState("GUN_OFF_HAND", nil)
						end
					end, "right_arm_tick")
					events.RENDER:register(function (delta, context)
						local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
						ModelAlias.alias.avatar.rightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
						ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 40, 30, 0))
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (_, state)
				if state == "GUN_OFF_HAND" then
					events.TICK:register(function ()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id == "minecraft:shield" and isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded)) and Arms.armState.left == "GUN_OFF_HAND" then
							Arms:setArmState(nil, "SHIELD_HAND")
						end
					end, "left_arm_tick")
					Arms:registerLeftArmRenderEvent("GUN_OFF_HAND")
					return true
				elseif state == "SHIELD_HAND" then
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						local isLeftHanded = player:isLeftHanded()
						if ((player:getHeldItem().id ~= "minecraft:shield" and isLeftHanded) or (player:getHeldItem(true).id ~= "minecraft:shield" and not isLeftHanded)) and Arms.armState.left == "SHIELD_HAND" then
							Arms:setArmState(nil, "GUN_OFF_HAND")
						end
					end, "left_arm_tick")
					events.RENDER:register(function (delta, context)
						local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
						ModelAlias.alias.avatar.leftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
						ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * -2.5 + 40, -30, 0))
					end, "left_arm_render")
				end;
			end;
		};
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 0.5;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, -6, -2.5);
					left = vectors.vec3(0, -6, -2.5);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.5, -7, -2.5);
					left = vectors.vec3(1.3, -7, -2.5);
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

			models = {models.models.ex_skill_1.Pillagers, models.models.ex_skill_1.AnimationArrow, ModelAlias.alias.avatar.rightArmBottom.ExSkillItemAnchor1};

			animations = {"main", "gun", "shield_item", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(15, -35, 0);
					pos = vectors.vec3(25, 26, -39);
				};

				fin = {
					rot = vectors.vec3(30, -25, 0);
					pos = vectors.vec3(4, 32, 8);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						models.models.ex_skill_1.Pillagers:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/illager/pillager.png")
						--models.models.ex_skill_1.AnimationArrow:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/projectiles/arrow.png")
						ModelAlias.alias.avatar.rightArmBottom.ExSkillItemAnchor1:newItem("ex_skill_1_item_1")
							:setItem("minecraft:milk_bucket")

						for i = 1, 2 do
							models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."RightArm"]:newItem("ex_skill_1_pillager_"..i.."_crossbow")
								:setItem("minecraft:crossbow")
								:setPos(0, -12, -2)
								:setRot(0, 0, -135)
						end

						self.exSkill.primary.isInitialized = true
					end

					models.models.shield_item.Item:setParentType("None")

					FaceParts:setEmotion("NORMAL", "CENTER", "HAT", 34, true)
				end;

				onAnimationTick = function (_, tick)
					if tick == 0 then
						ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.rightArmBottom, ModelAlias.alias.avatar.body)
						ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.rightArmBottom.Gun
						ModelAlias.alias.avatar.gun:setPos()
						ModelAlias.alias.avatar.gun:setRot()
						ModelAlias.alias.avatar.gun:setVisible(true)
					elseif tick == 34 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAT", 2, true)
					elseif tick == 36 then
						FaceParts:setEmotion("NORMAL", "CENTER", "TRIANGLE", 12, true)
						local playerPos = player:getPos()
						sounds:playSound("minecraft:item.shield.block", playerPos, 1, 1)
						sounds:playSound("minecraft:entity.arrow.hit", playerPos, 1, 1)
					elseif tick == 48 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAT", 2, true)
						sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.25, 2)
					elseif tick == 50 then
						FaceParts:setEmotion("NORMAL", "INVERTED", "HAT", 4, true)
					elseif tick == 54 then
						FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "HAT", 20, true)
					elseif tick == 74 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAT", 3, true)
					elseif tick == 77 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "TRIANGLE", 5, true)
					elseif tick == 82 then
						local shouldLookCamera = math.random() < 0.1
						ModelAlias.alias.avatar.faceParts.Eyes.EyeShines:setVisible(true)
						if shouldLookCamera then
							FaceParts:setEmotion("ANGRY", "ANGRY_CENTER", "TRIANGLE", 31, true)
							ModelAlias.alias.avatar.faceParts.Eyes.EyeShines.LeftEyeShine:setPos(-0.5, 0, 0)
						else
							FaceParts:setEmotion("ANGRY", "ANGRY", "TRIANGLE", 31, true)
						end

						local playerPos = player:getPos()
						sounds:playSound("minecraft:entity.player.levelup", playerPos, 1, 1)
						sounds:playSound("minecraft:entity.item.pickup", playerPos, 1, 1.5)
					elseif tick == 86 then
						local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.rightArmBottom.ExSkillItemAnchor1)
						local bodyYaw = player:getBodyYaw()
						local hasShader = client:hasShaderPack()
						for i = 1, 17 do
							particles:newParticle("minecraft:end_rod", anchorPos)
								:setScale(0.1)
								:setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + 30, vectors.rotateAroundAxis(20, vectors.rotateAroundAxis(i * 20, 0, 0.01 + math.random() * 0.02, 0, 0, 0, 1), 1, 0, 0), 0, 1, 0))
								:setGravity(0)
								:setColor((math.random() < 0.5 and vectors.vec3(0.993, 0.819, 0.99) or vectors.vec3(0.994, 0.988, 0.721)):scale(hasShader and 0.5 or 1))
								:setLifetime(40)
						end
					end

					if tick <= 76 then
						local shotChances = {math.random() < 0.05, math.random() < 0.05}
						if shotChances[1] or shotChances[2] then
							local bodyYaw = player:getBodyYaw()
							local playerAnchorPos = player:getPos():copy():add(vectors.rotateAroundAxis(bodyYaw * -1, -0.25, 1, 0, 0, 1, 0))
							for i = 1, 2 do
								if shotChances[i] then
									local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers["Pillager"..i]["Pillager"..i.."RightArm"]["Pillager"..i.."ArrowAnchor"])
									local offsetRot = math.random() * 360
									ExSkillArrowManager:spawn(anchorPos, playerAnchorPos:copy():sub(anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(offsetRot, 0, 1, 0, 0, 0, 1), 0, 1, 0))):normalize())

									sounds:playSound("minecraft:item.crossbow.shoot", anchorPos, 0.5, 1)
								end
							end
						end

						if math.random() < 0.04 then
							sounds:playSound("minecraft:entity.pillager.ambient", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Pillagers.Pillager1.Pillager1RightArm.Pillager1ArrowAnchor), 0.5, 1)
						end
					end
				end;

				onPostAnimation = function (_, forcedStop)
					ModelUtils.moveTo(ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.body, ModelAlias.alias.avatar.rightArmBottom)
					ModelAlias.alias.avatar.gun = ModelAlias.alias.avatar.body.Gun
					models.models.shield_item.Item:setParentType("Item")
					for _, modelPart in ipairs({ModelAlias.alias.avatar.gun, ModelAlias.alias.avatar.faceParts.Eyes.EyeShines}) do
						modelPart:setVisible(false)
					end
					ModelAlias.alias.avatar.faceParts.Eyes.EyeShines.LeftEyeShine:setPos()

					if forcedStop then
						ExSkillArrowManager:removeAll()
					end
				end;
			};
		};

		---このExスキルが初期化されたかどうか。
		---@type boolean
		isInitialized = false;
	};

	costume = {
		isAltCostumeEnabled = false;
	};

	bubble = {

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
			onBeforeModelCopy = function ()
				ModelAlias.alias.avatar.faceParts.Eyes.EyeShines:setVisible(false)
			end;

			onPhase1 = function ()
				ModelAlias.alias.dummy_avatar.head.SideTail:setRot(30, 0, 20)
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.SideTail:setRot(-17.5, 0, -2.5)
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
						min = -82.5;
						neutral = -57.5;
						max = -27.5;

						bodyY = {
							multiplayer = -40;
							min = -82.5;
							max = -27.5;
						};
					};

					horizontal = {
						min = -82.5;
						neutral = -67.5;
						max = -27.5;

						bodyX = {
							multiplayer = -80;
							min = -82.5;
							max = -27.5;
						};
					};
				};

				y = {
					vertical = {
						min = 30;
						neutral = 30;
						max = 30;
					};

					horizontal = {
						min = 30;
						neutral = 30;
						max = 30;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.FrontHair};

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
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		---Exスキルで使用する矢のインスタンスクラス
		---@type ExSkillArrow
		ExSkillArrow = require("scripts.ex_skill_arrow")

		---Exスキルで使用する矢のマネージャークラス
		---@type ExSkillArrowManager
		ExSkillArrowManager = require("scripts.ex_skill_arrow_manager")
		ExSkillArrowManager = ExSkillArrowManager.new()
		ExSkillArrowManager.init()

		---パイ投げのアニメーションを制御するクラス
		---@type PieThrowing
		PieThrowing = require("scripts.pie_throwing")

		---投げるパイオブジェクトのインスタンスクラス
		---@type Pie
		Pie = require("scripts.pie")

		---投げるパイオブジェクトのマネージャークラス
		---@type PieManager
		PieManager = require("scripts.pie_manager")
		PieManager = PieManager.new()
		PieManager.init()

		ModelAlias.alias.avatar.gun.Cake:newItem("gun_cake_strap")
			:setItem("minecraft:cake")
			:setScale(0.19)

		KeyManager:register("pie_throwing", "Eat this and cheer up", "key.keyboard.v"):onPress(function ()
			if ExSkill:getCanPlayAnimation() and not PieThrowing:getIsAnimationPlaying() then
				pings.throwPie()
			end
		end)

		events.ITEM_RENDER:register(function (item, mode)
			if item.id == "minecraft:shield" then
                if mode == "FIRST_PERSON_LEFT_HAND" then
                    local leftHanded = player:isLeftHanded()
                    if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "OFF_HAND" and not leftHanded) or (player:getActiveHand() == "MAIN_HAND" and leftHanded)) then
                        models.models.shield_item.Item:setPos(5, -14, -1)
                        models.models.shield_item.Item:setRot(0, 0, -5)
                    else
                        models.models.shield_item.Item:setPos(4, -16, 1)
                        models.models.shield_item.Item:setRot(0, 0, 5)
                    end
                elseif mode == "FIRST_PERSON_RIGHT_HAND" then
                    local leftHanded = player:isLeftHanded()
                    if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "MAIN_HAND" and not leftHanded) or (player:getActiveHand() == "OFF_HAND" and leftHanded)) then
                        models.models.shield_item.Item:setPos(-5, -12.5, -1)
                        models.models.shield_item.Item:setRot(0, 0, 5)
                    else
                        models.models.shield_item.Item:setPos(-4, -16, 1)
                        models.models.shield_item.Item:setRot(0, 0, -5)
                    end
				elseif mode == "THIRD_PERSON_LEFT_HAND" then
                    if Arms.armState.left == "SHIELD_HAND" then
                        if player:isCrouching() then
                            models.models.shield_item.Item:setPos(0, -11, 0)
                            models.models.shield_item.Item:setRot(80, 5, 30)
                        else
                            models.models.shield_item.Item:setPos(0, -12, -2)
                            models.models.shield_item.Item:setRot(55, 20, 25)
                        end
                    else
						local leftHanded = player:isLeftHanded()
						if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "OFF_HAND" and not leftHanded) or (player:getActiveHand() == "MAIN_HAND" and leftHanded)) then
							models.models.shield_item.Item:setPos(0, -13, -1)
							models.models.shield_item.Item:setRot(40, 20, 15)
						else
							models.models.shield_item.Item:setPos(-1, -13, 2)
							models.models.shield_item.Item:setRot(0, 80, 0)
						end
					end
				elseif mode == "THIRD_PERSON_RIGHT_HAND" then
                    if Arms.armState.right == "SHIELD_HAND" then
                        if player:isCrouching() then
                            models.models.shield_item.Item:setPos(0, -11, 0)
                            models.models.shield_item.Item:setRot(80, -5, -30)
                        else
                            models.models.shield_item.Item:setPos(0, -12, -2)
                            models.models.shield_item.Item:setRot(55, -20, -25)
                        end
                    else
						local leftHanded = player:isLeftHanded()
						if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "MAIN_HAND" and not leftHanded) or (player:getActiveHand() == "OFF_HAND" and leftHanded)) then
							models.models.shield_item.Item:setPos(0, -13, -1)
							models.models.shield_item.Item:setRot(40, -20, -15)
						else
							models.models.shield_item.Item:setPos(1, -13, 2)
							models.models.shield_item.Item:setRot(0, -80, 0)
						end
                    end
				end

				return models.models.shield_item.Item
			end
		end)
	end;
}

---パイ投げのpingメソッド
function pings.throwPie()
	PieThrowing:play()
end

return BlueArchiveCharacter
