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

-- ** アバターモジュール **

---バニラのプレイヤーモデルの管理
---@type VanillaModel
VanillaModel = require("scripts.vanilla_model")

---モデルパーツのエイリアスの管理
---@type ModelAlias
ModelAlias = require("scripts.model_alias")



-- *** モジュールの初期化 ***
VanillaModel.init()
ModelAlias:init()
CompatibilityUtils:init()
