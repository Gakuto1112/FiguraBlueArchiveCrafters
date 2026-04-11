-- キャラクター固有のスクリプトがある場合、ここをエントリーポイントとして実行させる。

---Exスキルで使用するテキストオブジェクトのマネージャークラス
---@type ExSkillTextObject
ExSkillTextObject = require("scripts.ex_skill_primary_text_object")

---Exスキルで使用するテキストオブジェクトのマネージャークラス
---@type ExSkillTextObjectManager
ExSkillTextObjectManager = require("scripts.ex_skill_primary_text_object_manager")
ExSkillTextObjectManager = ExSkillTextObjectManager:new()

---忍術ワークの表現
---@type Teleport
Teleport = require("scripts.teleport")

events.ENTITY_INIT:register(function ()
	Teleport:init()
end)
