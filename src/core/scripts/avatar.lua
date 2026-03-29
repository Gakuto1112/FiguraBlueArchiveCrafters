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

---キャラクターシートクラス
---@type BlueArchiveCharacter
BlueArchiveCharacter = require("scripts/blue_archive_character")

---物理演算の制御
---@type Physics
Physics = require("scripts.physics")

-- *** モジュールの初期化 ***
LocaleRefreshEvent:init()
VanillaModel.init()
ModelAlias:init()
CompatibilityUtils:init()
Config:init()
Locale:init()
--BlueArchiveCharacter:init()
