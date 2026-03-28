-- *** コアモジュールのインポート ***


-- ** ユーティリティクラス群 **

---文字列ユーティリティ
---@type StringUtils
StringUtils = require("scripts.utils.string_utils")


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
