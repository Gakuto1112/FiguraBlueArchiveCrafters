-- コアモジュールのインポート

---@type VanillaModel
local VanillaModel = require("scripts.vanilla_model")

---@type ModelAlias
local ModelAlias = require("scripts.model_alias")

-- モジュールの初期化
VanillaModel.init()
ModelAlias:init()
