-- *** コアモジュールのインポート ***

-- ** ユーティリティクラス群 **

---文字列ユーティリティ
---@type StringUtils
StringUtils = require("scripts.utils.string_utils")

---モデル操作ユーティリティ
---@type ModelUtils
ModelUtils = require("scripts.utils.model_utils")

---互換性ユーティリティ
---@type CompatibilityUtils
CompatibilityUtils = require("scripts.utils.compatibility_utils")

---ネットワークリクエストユーティリティ
---@type NetUtils
NetUtils = require("scripts.utils.net_utils")

---その他ユーティリティ
---@type MiscUtils
MiscUtils = require("scripts.utils.misc_utils")


-- **.抽象クラス群 **

---動的オブジェクトスポーン制御の抽象クラス
---@type SpawnObject
SpawnObject = require("scripts.ex_skill.spawn_object")

---動的オブジェクトスポーンのマネージャーの抽象クラス
---@type SpawnObjectManager
SpawnObjectManager = require("scripts.ex_skill.spawn_object_manager")


-- **.イベントモジュール **

---独自定義イベント抽象クラス
---@type AbstractEvent
AbstractEvent = require("scripts.events.abstract_event")

---独自定義イベントマネージャー
---@type EventManager
EventManager = require("scripts.events.event_manager")

---ロケールデータ更新イベント
---@type LocaleRefreshEvent
LocaleRefreshEvent = require("scripts.events.locale_refresh_event")

---ゲームのロケール変更イベント
---@type LocaleChangeEvent
LocaleChangeEvent = require("scripts.events.locale_change_event")

---アバター設定データ同期イベント
---@type ConfigSyncEvent
ConfigSyncEvent = require("scripts.events.config_sync_event")

---アクションホイール閉イベント
---@type ActionWheelClosedEvent
ActionWheelClosedEvent = require("scripts.events.action_wheel_closed_event")


-- ** アバターモジュール **

---アバターの設定管理
---@type Config
Config = require("scripts.config")

---アバターのローカライゼーション管理
---@type Locale
Locale = require("scripts.locale")

---バニラのプレイヤーモデルの管理
---@type VanillaModel
VanillaModel = require("scripts.vanilla_model")

---モデルパーツのエイリアスの管理
---@type ModelAlias
ModelAlias = require("scripts.model_alias")

---カメラ制御管理
---@type CameraManager
CameraManager = require("scripts.camera_manager")

---キーアサイン管理
---@type KeyManager
KeyManager = require("scripts.key_manager")

---キャラクターシートクラス
---@type BlueArchiveCharacter
BlueArchiveCharacter = require("scripts/blue_archive_character")

---物理演算の制御
---@type Physics
Physics = require("scripts.physics")

---ヘイローの制御
---@type Halo
Halo = require("scripts.halo")

---目や口の制御
---@type FaceParts
FaceParts = require("scripts.face_parts")

---腕の制御
---@type Arms
Arms = require("scripts.arms")

---スカートの制御
---@type Skirt
Skirt = require("scripts.skirt")

---防具モデルの制御
---@type Armor
Armor = require("scripts.armor")

---プレイヤーの表示名やネームプレートの制御
---@type Nameplate
Nameplate = require("scripts.nameplate")

---頭ブロックのモデルの制御
---@type HeadBlock
HeadBlock = require("scripts.head_block")

---ポートレート（Tabキーで表示できるプレイヤーリストに表示される顔）のモデルの制御
---@type Portrait
Portrait = require("scripts.portrait")

---銃の制御
---@type Gun
Gun = require("scripts.gun")

---シールド視覚効果の制御
---@type Shield
Shield = require("scripts.shield")

---設置物のインスタンスクラス
---@type PlacementObject
PlacementObject = require("scripts.placement_object.placement_object")

---設置物のインスタンスマネージャークラス
---@type PlacementObjectManager
PlacementObjectManager = require("scripts.placement_object.placement_object_manager")
PlacementObjectManager = PlacementObjectManager:new()

---Exスキルの制御クラス
---@type ExSkill
ExSkill = require("scripts.ex_skill.ex_skill")

---Exスキル再生中のフレーム上のパーティクルのインスタンスクラス
---@type ExSkillFrameParticle
ExSkillFrameParticle = require("scripts.ex_skill.ex_skill_frame_particle")

---Exスキル再生中のフレーム上のパーティクルのマネージャークラス
---@type ExSkillFrameParticleManager
ExSkillFrameParticleManager = require("scripts.ex_skill.ex_skill_frame_particle_manager")
ExSkillFrameParticleManager = ExSkillFrameParticleManager:new()

---衣装の管理
---@type Costume
Costume = require("scripts.costume")

---アクションホイールの管理
---@type ActionWheel
ActionWheel = require("scripts.action_wheel.action_wheel")

---アクションホイールのアバター設定ページの管理
---@type ActionWheelConfig
ActionWheelConfig = require("scripts.action_wheel.action_wheel_config")


-- *** モジュールの初期化 ***
ModelAlias:init()
HeadBlock:init()
Halo:init()

events.ENTITY_INIT:register(function ()
	LocaleRefreshEvent:init()
	LocaleChangeEvent:init()
	ConfigSyncEvent:init()
	ActionWheelClosedEvent:init()
	VanillaModel.init()
	CompatibilityUtils:init()
	Config:init()
	Locale:init()
	KeyManager:init()
	--BlueArchiveCharacter:init()
	--Physics:init()
	FaceParts:init()
	Arms:init()
	Skirt.init()
	Armor:init()
	Nameplate:init()
	Portrait.init()
	Gun:init()
	Shield:init()
	PlacementObjectManager:init()
	ExSkill:init()
	ExSkillFrameParticleManager.init()
	Costume:init()
	ActionWheel:init()
	ActionWheelConfig:init()
end)
