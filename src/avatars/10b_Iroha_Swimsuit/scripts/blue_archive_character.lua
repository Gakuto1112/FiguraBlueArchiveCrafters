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
---| "CENTER" # 少し反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "ANGRY" # 怒った目

---左目のテクスチャの列挙型
---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）
---| "INVERTED" # 反対側を見る目
---| "CLOSED2" # 閉じた目2
---| "CENTER" # 少し反対側を見る目
---| "ANGRY_INVERTED" # 怒りつつ、反対側を見る目
---| "ANGRY" # 怒った目

---口のテクスチャの列挙型
---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常
---| "CLOSED" # 閉じた口
---| "SMALL" # 小さく開いた口
---| "SIGH" # ため息口
---| "ANXIOUS" # への口
---| "SMILE" # にっこり
---| "FRUST" # グジュグジュ口
---| "FRUST2" # グジュグジュ口2
---| "SHOCK" # 驚いた口

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
		avatarName = "10b_Iroha_Swimsuit";

		birth = {
			month = 11;
			day = 16;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
			CENTER = vectors.vec2(6, 0);
			CLOSED2 = vectors.vec2(7, 0);
			ANGRY = vectors.vec2(9, 0);
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
			INVERTED = vectors.vec2(4, 0);
			CLOSED2 = vectors.vec2(6, 0);
			CENTER = vectors.vec2(7, 0);
			ANGRY_INVERTED = vectors.vec2(9, 0);
			ANGRY = vectors.vec2(10, 0);
		};

		mouth = {
			CLOSED = vectors.vec2(0, 0);
			SMALL = vectors.vec2(1, 0);
			SIGH = vectors.vec2(2, 0);
			ANXIOUS = vectors.vec2(3, 0);
			SMILE = vectors.vec2(4, 0);
			FRUST = vectors.vec2(5, 0);
			FRUST2 = vectors.vec2(6, 0);
			SHOCK = vectors.vec2(7, 0);
		};
	};

	arms = {
		callbacks = {
			onArmStateChanged = function (self, right, left)
				if self.costume.isRidingTank then
					if self.costume.tankTick <= 35 then
						return {right = "DEFAULT", left = "DEFAULT"}
					else
						return {right = right == "GUN_MAIN_HAND" and "TANK_GUN_MAIN_HAND" or (right == "GUN_OFF_HAND" and "TANK_GUN_OFF_HAND" or right), left = left == "GUN_MAIN_HAND" and "TANK_GUN_MAIN_HAND" or (left == "GUN_OFF_HAND" and "TANK_GUN_OFFHAND" or left)}
					end
				end
			end;

			onAdditionalRightArmProcess = function (self, state)
				if state == "TANK_GUN_MAIN_HAND" then
					--虎丸搭乗中の武器の構え
					events.TICK:register(function ()
						if Arms.armState.right == "TANK_GUN_MAIN_HAND" then
							Arms:processArmSwingCount()
							if player:isSwingingArm() and not player:isLeftHanded() and self.costume.shootTick == -1 then
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
						ModelAlias.alias.avatar.rightArm:setRot(((player:isSwingingArm() and not player:isLeftHanded()) or self.costume.shootTick >= 0) and vectors.vec3() or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 90, 70, 0))
					end, "right_arm_render")
				elseif state == "TANK_GUN_OFF_HAND" then
					--虎丸搭乗中の武器を持っていない手
					local isHolding = false
					events.TICK:remove("right_arm_tick")
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						local heldItem = player:getHeldItem(not player:isLeftHanded())
						local isNewerNbt = StringUtils.isNewerOrEqualVersion(client:getVersion(), "1.20.5")
						isHolding = player:getActiveItem().id == "minecraft:bow" or (heldItem.id == "minecraft:crossbow" and ((isNewerNbt and #heldItem.tag["minecraft:charged_projectiles"] >= 1) or (not isNewerNbt and heldItem.tag.Charged == 1)))
						ModelAlias.alias.avatar.rightArm:setParentType((isHolding or self.costume.shootTick >= 0) and "Body" or "RightArm")
					end, "right_arm_tick")
					events.RENDER:remove("right_arm_render")
					events.RENDER:register(function (delta)
						ModelAlias.alias.avatar.rightArm:setRot(isHolding and vectors.vec3(math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 35, 0, 0) or vectors.vec3())
					end, "right_arm_render")
				end
			end;

			onAdditionalLeftArmProcess = function (self, state)
				if state == "TANK_GUN_MAIN_HAND" then
					--虎丸搭乗中の武器の構え
					events.TICK:register(function ()
						if Arms.armState.left == "TANK_GUN_MAIN_HAND" then
							Arms:processArmSwingCount()
							if player:isSwingingArm() and player:isLeftHanded() and self.costume.shootTick == -1 then
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
						ModelAlias.alias.avatar.leftArm:setRot(((player:isSwingingArm() and player:isLeftHanded()) or self.costume.shootTick >= 0) and vectors.vec3() or vectors.vec3(headRot.x + math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 90, 90, 0))
					end, "left_arm_render")
				elseif state == "TANK_GUN_OFF_HAND" then
					--虎丸搭乗中の武器を持っていない手
					local isHolding = false
					events.TICK:remove("left_arm_tick")
					events.TICK:register(function ()
						Arms:processArmSwingCount()
						local heldItem = player:getHeldItem(player:isLeftHanded())
						local isNewerNbt = StringUtils.isNewerOrEqualVersion(client:getVersion(), "1.20.5")
						isHolding = player:getActiveItem().id == "minecraft:bow" or (heldItem.id == "minecraft:crossbow" and ((isNewerNbt and #heldItem.tag["minecraft:charged_projectiles"] >= 1) or (not isNewerNbt and heldItem.tag.Charged == 1)))
						ModelAlias.alias.avatar.leftArm:setParentType((isHolding or self.costume.shootTick >= 0) and "Body" or "LeftArm")
					end, "left_arm_tick")
					events.RENDER:remove("left_arm_render")
					events.RENDER:register(function (delta)
						ModelAlias.alias.avatar.leftArm:setRot(isHolding and vectors.vec3(math.sin((Arms.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 35, 0, 0) or vectors.vec3())
					end, "left_arm_render")
				end
			end
		};
	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 0.4;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(-0.5, -3.75, -3);
					left = vectors.vec3(0.5, -3.75, -3);
				};

				thirdPersonPos = {
					right = vectors.vec3(0, -3.75, -3);
					left = vectors.vec3(0, -3.75, -3);
				};
			};

			put = {
				type = "HIDDEN";
			};
		};

		sound = {
			name = "minecraft:entity.iron_golem.hurt";
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

			models = {models.models.ex_skill_1.ShulkerBox, models.models.ex_skill_1.Waves, models.models.ex_skill_1.ExSkillItems};

			animations = {"main", "ex_skill_1"};

			camera = {
				start = {
					rot = vectors.vec3(0, 160, 0);
					pos = vectors.vec3(-8.5, 17.4, -22.6);
				};

				fin = {
					rot = vectors.vec3(0, 170, -10);
					pos = vectors.vec3(-4, 26.4, -16.9);
				};
			};

			callbacks = {
				onPreAnimation = function (self)
					if not self.exSkill.primary.isInitialized then
						for _, modelPart in ipairs({models.models.ex_skill_1.ShulkerBox.ShulkerBoxTop.ShulkerBoxTop, models.models.ex_skill_1.ShulkerBox.ShulkerBoxBottom}) do
							modelPart:setPrimaryTexture("RESOURCE", "textures/entity/shulker/shulker_cyan.png")
						end

						models.models.ex_skill_1.Waves:setPrimaryTexture("RESOURCE", "textures/block/water_still.png")
						models.models.ex_skill_1.Waves:setColor(0.26274, 0.83529, 0.93333) -- 暖かい海バイオームの水の色

						for i, modelPart in ipairs(models.models.ex_skill_1.ExSkillItems:getChildren()) do
							modelPart:newItem("ex_skill_1_item_" .. i)
						end

						self.exSkill.primary.isInitialized = true;
					end;

					events.RENDER:register(function ()
						ModelAlias.alias.avatar.head.BackHair:setOffsetPivot(0, 0, ModelAlias.alias.avatar.head.BackHair:getAnimRot().x > 0 and 2 or 0)
					end, "ex_skill_1_render")

					local itemTable = {"melon", "potion", "melon_slice", "apple", "milk_bucket", "tube_coral_block", "brain_coral_block", "bubble_coral_block", "fire_coral_block", "horn_coral_block", "tube_coral", "brain_coral", "fire_coral", "horn_coral", "bubble_coral", "tube_coral_fan", "brain_coral_fan", "bubble_coral_fan", "fire_coral_fan", "horn_coral_fan", "cod", "cod_bucket", "salmon", "salmon_bucket", "tropical_fish", "tropical_fish_bucket", "seagrass", "sea_pickle", "kelp", "ink_sac", "turtle_scute", "sand", "heart_of_the_sea"}
					for i, modelPart in ipairs(models.models.ex_skill_1.ExSkillItems:getChildren()) do
						modelPart:getTask("ex_skill_1_item_" .. i)
							:setItem("minecraft:" .. itemTable[math.random(#itemTable)])
					end

					FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 20, true)
				end;

				onAnimationTick = function (self, tick)
					if tick == 11 or tick == 14 then
						sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 1, 1)
					elseif tick == 20 then
						FaceParts:setEmotion("NORMAL", "INVERTED", "CLOSED", 14, true)
					elseif tick == 27 then
						sounds:playSound("minecraft:entity.egg.throw", player:getPos(), 1, 0.75)
					elseif tick == 34 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 27, true)
					elseif tick == 42 then
						sounds:playSound("minecraft:block.wool.step", player:getPos(), 1, 1)
					elseif tick == 61 then
						FaceParts:setEmotion("NORMAL", "CENTER", "CLOSED", 24, true)
					elseif tick == 70 then
						sounds:playSound("minecraft:entity.shulker.close", player:getPos(), 1, 1)
						self.exSkill.primary.emitShulkerBoxCloseParticles()
					elseif tick == 83 then
						sounds:playSound("minecraft:block.shulker_box.close", player:getPos(), 0.75, 1)
					elseif tick == 85 then
						FaceParts:setEmotion("NORMAL", "CENTER", "SMALL", 7, true)
					elseif tick == 90 then
						self.exSkill.primary.emitShulkerBoxCloseParticles()
					elseif tick == 92 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMALL", 10, true)

						local bodyYaw = player:getBodyYaw() * -1 - 60
						particles:newParticle("minecraft:snowflake",ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.mouth):add(vectors.rotateAroundAxis(bodyYaw, 0, -0.2, -0.4, 0, 1, 0))):setScale(0.5):setVelocity(vectors.rotateAroundAxis(bodyYaw, -0.025, -0.01, -0.05, 0, 1, 0)):setGravity(0):setLifetime(8)
					elseif tick == 102 then
						FaceParts:setEmotion("NORMAL", "CENTER", "FRUST", 15, true)
					elseif tick == 113 then
						local playerPos = player:getPos()
						sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.25)
						sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.5)
					elseif tick == 117 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "FRUST", 5, true)
					elseif tick == 121 then
						FaceParts:setEmotion("NORMAL", "CENTER", "SMALL", 9, true)
					elseif tick == 130 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SMALL", 5, true)
					elseif tick == 135 then
						FaceParts:setEmotion("CENTER", "NORMAL", "SMALL", 12, true)
					elseif tick == 147 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "FRUST", 13, true)
					elseif tick == 160 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "FRUST2", 2, true)

						local anchorPos = player:getPos():copy():add(0, 0.75, 0)
						for _ = 1, 50 do
							local offset = vectors.vec3(math.random() * 1.5 - 0.75, 0, math.random() * 1.5 - 0.75)
							particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy():add(offset)):setScale(1):setColor(1, 1, 1):setVelocity(offset:copy():scale(0.1):add(0, 0.4 + math.random() * 0.1, 0)):setGravity(1):setLifetime(40)
						end

						sounds:playSound("minecraft:item.bucket.empty", anchorPos, 1, 0.25)
						sounds:playSound("minecraft:item.bucket.empty", anchorPos, 1, 0.5)
					elseif tick == 162 then
						FaceParts:setEmotion("CLOSED2", "CLOSED2", "FRUST2", 4, true)
					elseif tick == 166 then
						FaceParts:setEmotion("NORMAL", "NORMAL", "SHOCK", 37, true)
					end

					if tick >= 113 and tick < 125 then
						self.exSkill.primary.emitWaveStartParticles(ModelUtils.getModelWorldPos(models.models.ex_skill_1.Waves.Wave1.ParticleAnchor1))
					elseif tick >= 125 and tick < 141 then
						self.exSkill.primary.emitWaveStartParticles(ModelUtils.getModelWorldPos(models.models.ex_skill_1.Waves.Wave2.ParticleAnchor2))
					end

					if tick >= 114 and tick < 160 then
						self.exSkill.primary.emitItemWaveParticles(ModelUtils.getModelWorldPos(models.models.ex_skill_1.ExSkillItems.ExSkillItem1))
					end
					if tick >= 119 and tick < 160 then
						self.exSkill.primary.emitItemWaveParticles(ModelUtils.getModelWorldPos(models.models.ex_skill_1.ExSkillItems.ExSkillItem2))
					end
					if tick >= 125 and tick < 160 then
						self.exSkill.primary.emitItemWaveParticles(ModelUtils.getModelWorldPos(models.models.ex_skill_1.ExSkillItems.ExSkillItem3))
					end
					if tick >= 132 and tick < 160 then
						self.exSkill.primary.emitItemWaveParticles(ModelUtils.getModelWorldPos(models.models.ex_skill_1.ExSkillItems.ExSkillItem4))
					end

					if tick >= 112 and tick < 160 then
						for i = 1, 4 do
							local modelPart = models.models.ex_skill_1.Waves.Wave1["Wave1_" .. i]
							if modelPart:getAnimScale().y >= 1.1 then
								self.exSkill.primary.emitHighWaveParticles(modelPart, vectors.vec3(4, 0.75, 1), vectors.vec3(1, 0, 0.5), models.models.ex_skill_1.Waves.Wave1, i * 90)
							end
						end
						for i = 1, 4 do
							local modelPart = models.models.ex_skill_1.Waves.Wave2["Wave2_" .. i]
							if modelPart:getAnimScale().y >= 0.9 then
								self.exSkill.primary.emitHighWaveParticles(modelPart, vectors.vec3(2, 0.5, 1), vectors.vec3(0, 0, 0.5), models.models.ex_skill_1.Waves.Wave2, i * 90)
							end
						end

						if tick % 2 == 0 then
							sounds:playSound("minecraft:item.bucket.empty", player:getPos():copy():add(math.random() * 1.5 - 0.75, 0, math.random() * 1.5 - 0.75), 0.25, 0.5)
						end
					end
				end;

				onPostAnimation = function ()
					events.RENDER:remove("ex_skill_1_render")
				end;
			};

			---シュルカーボックスを閉じるパーティクルを再生する。
			emitShulkerBoxCloseParticles = function ()
				local anchorPos = player:getPos():copy():add(0, 0.5, 0)
				local bodyYaw = player:getBodyYaw()

				for _ = 1, 10 do
					particles:newParticle("minecraft:campfire_cosy_smoke", anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + math.random() * 180 - 90, 0, 0, 0.05, 0, 1, 0)):setLifetime(30)
				end
			end;

			---波の出現時のパーティクルを再生する。
			---@param targetPos Vector3 パーティクルの基準ワールド座標
			emitWaveStartParticles = function (targetPos)
				for _ = 1, 10 do
					particles:newParticle("minecraft:dust 1 1 1 1", targetPos:copy():add(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)):setScale(1):setColor(1, 1, 1):setVelocity(0, 0.25, 0):setGravity(1):setLifetime(40)
				end
			end;

			---アイテムが波に攫われている際のパーティクルを再生する。
			---@param targetPos Vector3 パーティクルの基準ワールド座標
			emitItemWaveParticles = function (targetPos)
				particles:newParticle("minecraft:dust 1 1 1 1", targetPos:copy():add(math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25)):setScale(1):setColor(1, 1, 1):setVelocity(0, 0.25, 0):setGravity(1):setLifetime(40)
			end;

			---波が高いときのパーティクルを再生する。
			---@param waveModel ModelPart 波のモデルパーツ
			---@param waveSize Vector3 波のモデルパーツの大きさ
			---@param pivotOffset Vector3 モデルパーツに対する各軸の位置（0 = 負の端、0.5 = 中央、1 = 正の端）
			---@param parentModel ModelPart 波の親モデルパーツ
			---@param offsetRot number パーティクルの出現範囲計算時のオフセット角度（親のモデルパーツからの相対角度）
			emitHighWaveParticles = function (waveModel, waveSize, pivotOffset, parentModel, offsetRot)
				local anchorPos = ModelUtils.getModelWorldPos(waveModel):copy():add(0, waveSize.y, 0)
				local parentRot = parentModel:getAnimRot().y

				for _ = 1, 2 do
					particles:newParticle("minecraft:dust 1 1 1 1", anchorPos:copy():add(vectors.rotateAroundAxis(parentRot + offsetRot, math.random() * waveSize.x - pivotOffset.x * waveSize.x, 0, math.random() * waveSize.z - pivotOffset.z * waveSize.z, 0, 1, 0))):setScale(0.25):setColor(1, 1, 1):setVelocity(0, 0.25, 0):setGravity(1):setLifetime(40)
				end
			end;

			---このExスキルの初期化処理が行われたかどうか
			---@type boolean
			isInitialized = false;
		};
	};

	costume = {
		isAltCostumeEnabled = false;

		callbacks = {
			onArmorChange = function (self, parts, isVisible)
				if parts == "HELMET" then
					ModelAlias.alias.avatar.head.StrawHat:setVisible(not isVisible)
				end
			end;
		};

		---戦車に乗っているかどうか
		---@type boolean
		isRidingTank = false;

		---前ティックに戦車に乗っていたかどうか
		---@type boolean
		isRidingTankPrev = false;

		---前ティックに戦車のエンジンが起動していたかどうか
		---@type boolean
		isEngineActivePrev = false;

		---戦車に乗っているときのティックカウンター
		---@type integer
		tankTick = 0;

		---ラクダが座っているかどうか
		---@type boolean
		isCamelSitting = true;

		---ラクダのY軸の向き
		---@type number
		camelRot = 0;

		---前ティックの体の向き
		---@type number
		bodyYawPrev = 0;

		---戦車の車体の向きを更新すべきかどうか
		---@type boolean
		shouldUpdateBaseRot = true;

		---砲弾を撃つ際のティックカウンター
		---@type integer
		shootTick = -1;

		---次の砲弾を撃つまでのクールダウン
		---@type integer
		shootCoolDown = 0;

		---ヒント表示をしたかどうか。
		---@type boolean
		isTipShowed = false;

		---イブキを搭乗させているかどうか。
		---@type boolean
		hasIbuki = false;

		---前ティックにイブキを搭乗させていたかどうか。
		---@type boolean
		hadIbukiPrev = false;
	};

	bubble = {

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
				ModelAlias.alias.dummy_avatar.head.BackHair:setRot(20, 0, 0)
				ModelAlias.alias.dummy_avatar.head.BackHair:setOffsetPivot(0, 0, 4)
				for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.head.StrawHat.StrawHatKnotRightTip, ModelAlias.alias.dummy_avatar.head.StrawHat.StrawHatKnotLeftTip}) do
					modelPart:setRot(30, 0, 0)
				end
			end;

			onPhase2 = function ()
				ModelAlias.alias.dummy_avatar.head.BackHair:setRot(-20, 0, 0)
				ModelAlias.alias.dummy_avatar.head.BackHair:setOffsetPivot()
				ModelAlias.alias.dummy_avatar.head.StrawHat.StrawHatKnotRightTip:setRot(-20, 0, -70)
				ModelAlias.alias.dummy_avatar.head.StrawHat.StrawHatKnotLeftTip:setRot(-20, 0, -30)
			end;
		};
	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = true;
	};

	physics = {
		physicData = {
			{
				models = {ModelAlias.alias.avatar.head.BackHair};

				x = {
					vertical = {
						min = -120;
						neutral = 0;
						max = 0;
						sneakOffset = -30;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 0;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -120;
							max = 0;
						};
					};

					horizontal = {
						min = -135;
						neutral = -30;
						max = 0;

						headX = {
							multiplayer = -80;
							min = -45;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.StrawHat.StrawHatKnotRightTip, ModelAlias.alias.avatar.head.StrawHat.StrawHatKnotLeftTip};

				x = {
					vertical = {
						min = -25;
						neutral = 0;
						max = 90;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -120;
							min = -25;
							max = 90;
						};

						bodyY = {
							multiplayer = -120;
							min = 0;
							max = 90;
						};

						headRot = {
							multiplayer = -0.075;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = -25;
						neutral = 45;
						max = 90;

						headX = {
							multiplayer = -160;
							min = -25;
							max = 90;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.StrawHat.StrawHatKnotRightTip.StrawHatKnotRightTipZPivot};

				z = {
					vertical = {
						min = -70;
						neutral = 0;
						max = 55;

						headZ = {
							multiplayer = -120;
							min = -75;
							max = 55;
						};
					};

					horizontal = {
						min = 0;
						neutral = 0;
						max = 0;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.StrawHat.StrawHatKnotLeftTip.StrawHatKnotLeftTipZPivot};

				z = {
					vertical = {
						min = -55;
						neutral = 0;
						max = 70;

						headZ = {
							multiplayer = -120;
							min = -55;
							max = 70;
						};
					};

					horizontal = {
						min = 0;
						neutral = 0;
						max = 0;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.RightSideRibbon.RibbonRight, ModelAlias.alias.avatar.body.LeftSideRibbon.RibbonRight};

				x = {
					vertical = {
						min = -10;
						neutral = 0;
						max = 10;

						bodyY = {
							multiplayer = -80;
							min = -10;
							max = 10;
						};
					};

					horizontal = {
						min = -10;
						neutral = 0;
						max = 10;

						bodyX = {
							multiplayer = -160;
							min = -10;
							max = 10;
						};
					};
				}
			};

			{
				models = {ModelAlias.alias.avatar.body.RightSideRibbon.RibbonLeft, ModelAlias.alias.avatar.body.LeftSideRibbon.RibbonLeft};

				x = {
					vertical = {
						min = -10;
						neutral = 0;
						max = 10;

						bodyY = {
							multiplayer = 80;
							min = -10;
							max = 10;
						};
					};

					horizontal = {
						min = -10;
						neutral = 0;
						max = 10;

						bodyX = {
							multiplayer = 160;
							min = -10;
							max = 10;
						};
					};
				}
			};

			{
				models = {ModelAlias.alias.avatar.body.RightSideRibbon.RightSideRibbonRightBottom, ModelAlias.alias.avatar.body.RightSideRibbon.RightSideRibbonLeftBottom};

				z = {
					vertical = {
						min = -5;
						neutral = 0;
						max = 175;

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 175;
						};

						bodyZ = {
							multiplayer = -80;
							min = -5;
							max = 90;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = -5;
						neutral = 0;
						max = 175;

						bodyX = {
							multiplayer = -80;
							min = -5;
							max = 175;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.LeftSideRibbon.LeftSideRibbonRightBottom, ModelAlias.alias.avatar.body.LeftSideRibbon.LeftSideRibbonLeftBottom};

				z = {
					vertical = {
						min = -175;
						neutral = 0;
						max = 5;

						bodyY = {
							multiplayer = 80;
							min = -175;
							max = 0;
						};

						bodyZ = {
							multiplayer = -80;
							min = -90;
							max = 5;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = 0;
						};
					};

					horizontal = {
						min = -175;
						neutral = 0;
						max = 5;

						bodyX = {
							multiplayer = 80;
							min = -175;
							max = 5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.RightSideRibbon.RightSideRibbonRightBottom.RightSideRibbonRightBottomZPivot, ModelAlias.alias.avatar.body.RightSideRibbon.RightSideRibbonLeftBottom.RightSideRibbonLeftBottomZPivot, ModelAlias.alias.avatar.body.LeftSideRibbon.LeftSideRibbonRightBottom.LeftSideRibbonRightBottomZPivot, ModelAlias.alias.avatar.body.LeftSideRibbon.LeftSideRibbonLeftBottom.LeftSideRibbonLeftBottomZPivot};

				x = {
					vertical = {
						min = -80;
						neutral = 0;
						max = 80;

						bodyX = {
							multiplayer = -80;
							min = -80;
							max = 80;
						};
					};

					horizontal = {
						min = -80;
						neutral = 0;
						max = 80;

						bodyY = {
							multiplayer = 80;
							min = -80;
							max = 80;
						};
					};
				};
			};
		};

		callbacks = {
			onPhysicPerformed = function (_, model)
				if model == ModelAlias.alias.avatar.head.BackHair then
					local rot = math.deg(math.asin(player:getLookDir().y)) - model:getRot().x
					if rot < 0 then
						ModelAlias.alias.avatar.head.BackHair:setOffsetPivot(0, 0, 2)
					else
						ModelAlias.alias.avatar.head.BackHair:setOffsetPivot()
					end
				end
			end
		};
	};

	---初期化関数
	---この関数は消しても構わない。
    ---@param self BlueArchiveCharacter
    init = function (self)
		---戦車の砲弾オブジェクトのインスタンスクラス
		---@type TankShell
		TankShell = require("scripts.tank_shell")

		---戦車の砲弾オブジェクトのマネージャークラス
		---@type TankShellManager
		TankShellManager = require("scripts.tank_shell_manager")
		TankShellManager = TankShellManager.new()

		TankShellManager.init()

        models.models.tank.Tank:setColor(1, 1, 1)
        for _, modelPart in ipairs({models.models.tank.Tank.TankBody.PSLogo1, models.models.tank.Tank.TankBody.Turret.PSLogo2, models.models.tank.Tank.TankBody.Turret.PSLogo3}) do
            modelPart:newText("toramaru_logo_text"):setText("§e万魔殿"):setPos(0, 2.25, 0):setScale(0.2):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.404, 0.306, 0.051)
        end
        models.models.tank.Tank.TankBody.Turret.Cannon.HangingSign:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/signs/hanging/oak.png")
        models.models.tank.Tank.TankBody.Turret.Cannon.HangingSign:newText("toramaru_sign_text_1"):setText("§0§l巡回中"):setPos(-1, -9, 0.5):setRot(0, 90, 0):setScale(0.5):setAlignment("CENTER")
        models.models.tank.Tank.TankBody.Turret.Cannon.HangingSign:newText("toramaru_sign_text_2"):setText("§0§l巡回中"):setPos(1, -9, -0.5):setRot(0, -90, 0):setScale(0.5):setAlignment("CENTER")

		for i = 0, 1 do
			for j = 0, 9 do
				models.models.tank.Tank.TankBody.BaseBase1:newBlock("toramaru_log_"..(i * 10 + j)):setBlock("minecraft:oak_log[axis=z]"):setPos(36 + i * -80, -2, j * 8 - 41):setScale(0.5)
			end
		end
		avatar:store("shouldReplaceVehicleModels", ActionWheelConfig.shouldReplaceVehicleModel)

		KeyManager:register("tank_shoot", "Main gun aim, fire", "key.keyboard.v"):setOnPress(function ()
			if self.costume.isRidingTank and self.costume.tankTick >= 36 and models.models.tank.Tank:getColor() == vectors.vec3(1, 1, 1) then
				if self.costume.shootCoolDown == 0 then
					pings.tankShoot()
				else
					MiscUtils.playErrorSound()
					print(Locale:getLocalizedText("message.tank_shot.in_cool_down"):format(math.ceil(self.costume.shootCoolDown / 20)))
				end
			end
		end)

        events.TICK:register(function ()
            if not client:isPaused() then
                local vehicle = player:getVehicle()
                self.costume.isRidingTank = false
                self.costume.hasIbuki = false
                if vehicle ~= nil then
                    local passengers = vehicle:getPassengers()
                    local controlledPassenger = vehicle:getControllingPassenger()
                    local avatarVars = world.avatarVars()
                    self.costume.hasIbuki = passengers[2] ~= nil and passengers[2]:hasAvatar() and avatarVars[passengers[2]:getUUID()].FBAC_Ibuki
                    self.costume.isRidingTank = vehicle:getType() == "minecraft:camel" and controlledPassenger ~= nil and controlledPassenger:getName() == player:getName() and (#passengers == 1 or self.costume.hasIbuki) and ActionWheelConfig.shouldReplaceVehicleModel and player:getHealth() > 0
                end
                if self.costume.isRidingTank ~= self.costume.isRidingTankPrev then
                    if self.costume.isRidingTank then
                        renderer:setRenderVehicle(false)
                        models.models.tank.Tank:setVisible(true)
                        ModelAlias.alias.avatar.root:setPos(-13, 16, 4)
                        models.models.tank.Tank:setOffsetPivot(0, 0, 8)
                        CameraManager:setThirdPersonCameraDistance(8)
                        Arms:setArmState("DEFAULT", "DEFAULT")
                        animations["models.main"]["tank_start"]:play()
                        animations["models.main"]["tank_idle"]:play()
                        for _, animationName in ipairs({"tank_start", "tank_move"}) do
                            animations["models.tank"][animationName]:play()
                        end
                        FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 35, true)
                        sounds:playSound("minecraft:block.iron_trapdoor.open", player:getPos(), 1, 0.5)
                        avatar:store("isEngineActive", false)
                        avatar:store("engineAnimTime", 0)
                        avatar:store("shootingStart", false)
                        avatar:store("isTankDied", false)
                        events.TICK:register(function ()
                            if not client:isPaused() then
                                local camelRot = vehicle:getRot().y
                                self.costume.isCamelSitting = (player:getPos():sub(vehicle:getPos()):length() - 1.51017) * -1.35 >= 0.04
                                if vehicle:isMoving(true) then
                                    self.costume.camelRot = camelRot
                                end
                                local bodyYaw = player:getBodyYaw()
                                self.costume.shouldUpdateBaseRot = math.abs(bodyYaw - self.costume.bodyYawPrev) < 330
                                local isEngineActive = self.costume.isRidingTank and (player:getPos():sub(vehicle:getPos()):length() - 1.51017) * -1.35 < 1 and models.models.tank.Tank:getColor() == vectors.vec3(1, 1, 1)
                                if isEngineActive and not self.costume.isEngineActivePrev then
                                    animations["models.main"]["tank_idle_powered"]:play()
                                    animations["models.tank"]["tank_idle"]:play()
                                    avatar:store("isEngineActive", true)
                                elseif not isEngineActive and self.costume.isEngineActivePrev then
                                    animations["models.main"]["tank_idle_powered"]:stop()
                                    animations["models.tank"]["tank_idle"]:stop()
                                    avatar:store("isEngineActive", false)
                                end
                                if isEngineActive then
                                    avatar:store("engineAnimTime", animations["models.main"]["tank_idle_powered"]:getTime())
                                end
                                animations["models.tank"]["tank_move"]:setSpeed(Physics.velocityAverage[5][2] * 2.5)
                                local beltOffset = math.floor(models.models.tank.Tank.RightCrawler.RightCrawlerWheel1:getTrueRot().x / 20) % 2
                                for _, modelPart in ipairs({models.models.tank.Tank.RightCrawler.RightCrawlerBelt, models.models.tank.Tank.LeftCrawler.LeftCrawlerBelt}) do
                                    modelPart:setUVPixels(0, beltOffset)
                                end
                                if FaceParts.blinkCount == 0 and FaceParts.emotionCount == 0 then
                                    FaceParts:setEmotion("CLOSED", "CLOSED", "CLOSED", 2, true)
                                else
                                    FaceParts:setEmotion("NORMAL", "INVERTED", "CLOSED", 1)
                                end
                                if self.costume.tankTick == 36 then
                                    if Gun.currentGunPosition == "RIGHT" then
                                        Arms:setArmState("TANK_GUN_MAIN_HAND", "TANK_GUN_OFF_HAND")
                                    elseif Gun.currentGunPosition == "LEFT" then
                                        Arms:setArmState("TANK_GUN_OFF_HAND", "TANK_GUN_MAIN_HAND")
                                    end
                                    if host:isHost() and not self.costume.isTipShowed then
                                        print(Locale:getLocalizedText("message.tank_shot.tip_1"):format(KeyManager.keyMappings["tank_shoot"].keybind:getKeyName()))
                                        self.costume.isTipShowed = true
                                    end
                                end
                                if self.costume.tankTick % 2 == 0 and isEngineActive then
                                    sounds:playSound(self.costume.tankTick % 4 == 0 and "minecraft:block.piston.extend" or "minecraft:block.piston.contract", vehicle:getPos(), 0.02, 0.5)
                                end
                                if self.costume.tankTick % 2 == 0 and isEngineActive then
                                    local anchorPos = vehicle:getPos()
                                    sounds:playSound(self.costume.tankTick % 4 == 0 and "minecraft:block.piston.extend" or "minecraft:block.piston.contract", vehicle:getPos(), 0.02, 0.5)
                                    local velocity = vehicle:getVelocity():mul(1, 0, 1):length()
                                    if velocity >= 0.1 then
                                        local volume = math.min(0.67 * velocity - 0.06, 0.2)
                                        local pitch = 0.25 * velocity + 0.175 + math.random() * 0.02 - 0.01
                                        sounds:playSound("minecraft:block.piston.extend", anchorPos, volume, pitch)
                                        sounds:playSound("minecraft:block.piston.contract", anchorPos, volume, pitch)
                                    end
                                end
                                local health = vehicle:getNbt().Health
                                if health < 16 then
                                    local playerPos = player:getPos()
                                    if health < 8 then
                                        particles:newParticle("minecraft:flame", playerPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1 , math.random() * 5 - 2.5, math.random() * 3 - 1.5, math.random() * 7 - 3.5, 0, 1, 0)))
                                    end
                                    particles:newParticle("minecraft:large_smoke", playerPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1 , math.random() * 5 - 2.5, math.random() * 3 - 1.5, math.random() * 7 - 3.5, 0, 1, 0)))
                                end
                                if self.costume.hasIbuki ~= self.costume.hadIbukiPrev then
                                    if self.costume.hasIbuki then
                                        animations["models.tank"]["tank_ibuki_start"]:setSpeed(1)
                                        animations["models.tank"]["tank_ibuki_start"]:play()
                                        sounds:playSound("minecraft:block.iron_trapdoor.open", player:getPos(), 1, 1.5)
                                    else
                                        animations["models.tank"]["tank_ibuki_start"]:setSpeed(-1)
                                        sounds:playSound("minecraft:block.iron_trapdoor.close", player:getPos(), 1, 1.5)
                                    end
                                end

                                if self.costume.shootTick >= 0 then
                                    self.costume.shootTick = self.costume.shootTick + 1
                                    if self.costume.shootTick == 2 then
                                        avatar:store("shootingStart", false)
                                    elseif self.costume.shootTick == 13 then
                                        local anchorPos = ModelUtils.getModelWorldPos(models.models.tank.Tank.TankBody.Turret.Cannon.MuzzleAnchor1)
                                        TankShellManager:spawn(anchorPos, vectors.vec3(models.models.tank.Tank.TankBody.Turret.Cannon:getRot().x * -1, player:getBodyYaw() * -1, 0))
                                        for _ = 1, 10 do
                                            particles:newParticle("minecraft:large_smoke", anchorPos:copy():add(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)):setScale(2)
                                        end
                                        sounds:playSound("minecraft:entity.firework_rocket.large_blast", player:getPos(), 1, 1)
                                    elseif self.costume.shootTick == 38 then
                                        self.costume.shootTick = -1
                                    end
                                end

                                self.costume.tankTick = self.costume.isRidingTank and self.costume.tankTick + 1 or 0
                                self.costume.isEngineActivePrev = isEngineActive
                                self.costume.bodyYawPrev = bodyYaw
                                self.costume.hadIbukiPrev = self.costume.hasIbuki
                            end
                        end, "tank_tick")
                        events.RENDER:register(function (delta)
                            if not client:isPaused() then
                                local bodyYaw = player:getBodyYaw(delta)
                                local baseRot = bodyYaw - self.costume.camelRot
                                local lookDir = player:getLookDir()
                                local turretRot = math.clamp(math.deg(math.asin(lookDir.y)), -15, 25)
                                local heightOffset = (player:getPos(delta):sub(vehicle:getPos(delta)):length() - 1.51017) * -1.35
                                ModelAlias.alias.avatar.root:setPos(-13, 16 + heightOffset * 16, 4)
                                models.models.tank.Tank:setPos(0, -24.5 + heightOffset * 16, models.models.tank.ShootAnimAnchor:getAnimPos().z)
                                models.models.tank.Tank.TankBody.Turret.Cannon:setRot(turretRot, 0, 0)
                                models.models.tank.Tank.TankBody.Turret.Cannon.HangingSign:setRot(turretRot * -1, 0, 0)
                                if vehicle:isMoving(true) then
                                    for _, modelPart in ipairs({models.models.tank.Tank, models.models.tank.Tank.TankBody.Turret}) do
                                        modelPart:setRot()
                                    end
                                elseif self.costume.isCamelSitting then
                                    models.models.tank.Tank:setRot()
                                    models.models.tank.Tank.TankBody.Turret:setRot()
                                elseif self.costume.shouldUpdateBaseRot then
                                    models.models.tank.Tank:setRot(0, baseRot, 0)
                                    models.models.tank.Tank.TankBody.Turret:setRot(0, baseRot * -1, 0)
                                end

                                if renderer:isFirstPerson() then
                                    renderer:setCameraPos(0.75, 0, 0)
                                    local animOffset = vectors.rotateAroundAxis(bodyYaw * -1, 0, models.models.tank.IdleAnimAnchor:getAnimPos().y, models.models.tank.ShootAnimAnchor:getAnimPos().z * -1, 0, 1, 0):scale(0.0625)
                                    CameraManager.setCameraPivot(vectors.rotateAroundAxis(bodyYaw * -1, 0, heightOffset + 1, -0.45, 0, 1, 0):add(animOffset))
                                    renderer:setEyeOffset(vectors.rotateAroundAxis(bodyYaw * -1, 0.75, heightOffset + 1, -0.45, 0, 1, 0):add(animOffset))
                                else
                                    CameraManager.setCameraPivot(vectors.vec3(0, heightOffset * 0.75, 0))
                                    renderer:setEyeOffset(0, heightOffset * 0.75, 0)
                                end
                            end
                        end, "tank_render")

                        events.ON_PLAY_SOUND:register(function (id, pos, _, _, _, _, path)
                            if pos:copy():sub(vehicle:getPos()):length() < 2 and path ~= nil then
                                if id:match("^minecraft:entity.camel") ~= nil or id == "minecraft:entity.horse.land" then
                                    if id == "minecraft:entity.camel.step" then
                                        sounds:playSound("minecraft:block.wool.step", pos, 0.25, 1)
                                    elseif id == "minecraft:entity.horse.land" then
                                        sounds:playSound("minecraft:block.wool.step", pos, 1, 1)
                                    elseif id == "minecraft:entity.camel.dash" then
                                        sounds:playSound("minecraft:entity.blaze.hurt", pos, 1, 1.5)
                                    elseif id == "minecraft:entity.camel.dash_ready" then
                                        sounds:playSound("minecraft:block.dispenser.fail", pos, 1, 2)
                                    elseif id == "minecraft:entity.camel.hurt" then
                                        sounds:playSound("minecraft:block.anvil.place", pos, 1, 2)
                                    elseif id == "minecraft:entity.camel.death" then
                                        models.models.tank.Tank:setColor(0.2, 0.2, 0.2)
                                        for _, modelPart in ipairs({models.models.tank.Tank.TankBody.PSLogo1, models.models.tank.Tank.TankBody.Turret.PSLogo2, models.models.tank.Tank.TankBody.Turret.PSLogo3}) do
                                            modelPart:getTask("toramaru_logo_text"):setText("§0万魔殿"):setOutlineColor(0, 0, 0)
                                        end
                                        for i = 0, 1 do
                                            for j = 0, 9 do
                                                models.models.tank.Tank.TankBody.BaseBase1:getTask("toramaru_log_"..(i * 10 + j)):setLight(0)
                                            end
                                        end
                                        local playerPos = player:getPos()
                                        local bodyYaw = player:getBodyYaw()
                                        particles:newParticle("minecraft:explosion_emitter", playerPos)
                                        for _ = 0, 50 do
                                            local offsetPos = vectors.rotateAroundAxis(bodyYaw * -1 , math.random() * 5 - 2.5, math.random() * 3 - 1.5, math.random() * 7 - 3.5, 0, 1, 0)
                                            particles:newParticle("minecraft:poof", playerPos:copy():add(offsetPos)):setColor(vectors.vec3(1, 1, 1):scale(math.random() * 0.1 + 0.2)):setScale(5):setVelocity(offsetPos:copy():scale(0.05))
                                        end
                                        sounds:playSound("minecraft:entity.generic.explode", pos, 1, 1)
                                        Bubble:play("SWEAT", 40, false)
                                        avatar:store("isTankDied", true)
                                    end
                                    return true
                                end
                            end
                        end, "tank_on_play_sound")
                    else
                        events.TICK:remove("tank_tick")
                        events.RENDER:remove("tank_render")
                        events.ON_PLAY_SOUND:remove("tank_on_play_sound")
                        renderer:setRenderVehicle(true)
                        models.models.tank.Tank:setVisible(false)
                        for _, modelPart in ipairs({models.models.tank.Tank, models.models.tank.Tank.TankBody.Turret, models.models.tank.Tank.TankBody.Turret.Cannon}) do
                            modelPart:setPos()
                            modelPart:setRot()
                        end
                        models.models.tank.Tank.TankBody.Turret.Cannon.HangingSign:setRot()
                        models.models.tank.Tank:setColor(1, 1, 1)
                        for _, modelPart in ipairs({models.models.tank.Tank.TankBody.PSLogo1, models.models.tank.Tank.TankBody.Turret.PSLogo2, models.models.tank.Tank.TankBody.Turret.PSLogo3}) do
                            modelPart:getTask("toramaru_logo_text"):setText("§e万魔殿"):setOutlineColor(0.404, 0.306, 0.051)
                        end
                        for i = 0, 1 do
                            for j = 0, 9 do
                                models.models.tank.Tank.TankBody.BaseBase1:getTask("toramaru_log_"..(i * 10 + j)):setLight()
                            end
                        end
                        ModelAlias.alias.avatar.root:setPos()
                        CameraManager:setThirdPersonCameraDistance(4)
                        CameraManager.setCameraPivot()
                        renderer:setEyeOffset()
                        for _, animationName in ipairs({"tank_start", "tank_idle", "tank_idle_powered", "tank_shoot_right", "tank_shoot_left"}) do
                            animations["models.main"][animationName]:stop()
                        end
                        for _, animationName in ipairs({"tank_start", "tank_idle", "tank_move", "tank_shoot"}) do
                            animations["models.tank"][animationName]:stop()
                        end
                        if Gun.currentGunPosition == "RIGHT" then
                            Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
                        elseif Gun.currentGunPosition == "LEFT" then
                            Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
                        end
                        avatar:store("isEngineActive", false)
                        avatar:store("engineAnimTime", 0)
                        avatar:store("isTankDied", false)
                        self.costume.tankTick = 0
                        self.costume.shootTick = -1
                        self.costume.isEngineActivePrev = false
                        self.costume.hadIbukiPrev = false
                    end
                end

                self.costume.isRidingTankPrev = self.costume.isRidingTank
                self.costume.shootCoolDown = math.max(self.costume.shootCoolDown - 1, 0)
            end
        end)

        avatar:store("FBAC_Iroha", true)
    end;
}

---虎丸の弾を発射する。
function pings.tankShoot()
    animations["models.main"]["tank_shoot"]:play()
    animations["models.main"]["tank_shoot_"..(player:isLeftHanded() and "left" or "right")]:play()
    animations["models.tank"]["tank_shoot"]:play()
    FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "CLOSED", 38, true)
    avatar:store("shootingStart", true)
    BlueArchiveCharacter.costume.shootTick = 0
    BlueArchiveCharacter.costume.shootCoolDown = 100
end

return BlueArchiveCharacter
