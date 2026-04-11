-- キャラクター固有のスクリプトがある場合、ここをエントリーポイントとして実行させる。

---忍術ワープの表現
---@type Teleport
Teleport = require("scripts.teleport")

events.ENTITY_INIT:register(function ()
	Teleport:init()
end)
