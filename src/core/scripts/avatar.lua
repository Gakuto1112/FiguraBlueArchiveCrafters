-- *** コアモジュールのインポート ***

-- **.抽象クラス群 **

---動的オブジェクトスポーン制御の抽象クラス
---@type SpawnObject
SpawnObject = require("scripts.ex_skill.spawn_object")

---動的オブジェクトスポーンのマネージャーの抽象クラス
---@type SpawnObjectManager
SpawnObjectManager = require("scripts.ex_skill.spawn_object_manager")

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

---銃の制御
---@type Gun
Gun = require("scripts.gun")

---設置物のインスタンスクラス
---@type PlacementObject
PlacementObject = require("scripts.placement_object.placement_object")

---設置物のインスタンスマネージャークラス
---@type PlacementObjectManager
PlacementObjectManager = require("scripts.placement_object.placement_object_manager")
PlacementObjectManager = PlacementObjectManager:new()

-- *** モジュールの初期化 ***
LocaleRefreshEvent:init()
VanillaModel.init()
ModelAlias:init()
CompatibilityUtils:init()
Config:init()
Locale:init()
KeyManager:init()
--BlueArchiveCharacter:init()
Physics:init()
Halo:init()
FaceParts:init()
Arms:init()
Skirt.init()
Gun:init()
PlacementObjectManager:init()
