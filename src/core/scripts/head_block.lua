---@class (exact) HeadBlock 頭ブロックのモデルを制御するクラス
---@field package forceGenerateCount integer 強制的に頭ブロックを生成するまでのカウンター。これが発火するのはアバタープレイヤーがオフラインの時のみ。
local HeadBlock = {
	forceGenerateCount = 2;

    ---初期化関数
    ---@param self HeadBlock
    init = function (self)
		---@diagnostic disable-next-line: discard-returns
		models:newPart("script_head_block")

		events.ENTITY_INIT:register(function ()
			self:generateHeadBlockModel()
			self.forceGenerateCount = 0
			events.WORLD_TICK:remove("head_block_world_tick")
		end)

        events.WORLD_TICK:register(function ()
            self.forceGenerateCount = self.forceGenerateCount - 1
            if self.forceGenerateCount == 0 then
                self:generateHeadModel()
                events.WORLD_TICK:remove("head_block_world_tick")
            end
        end, "head_block_world_tick")
    end;

	---頭ブロックのモデルを作成する。
	---@param self HeadBlock
	generateHeadBlockModel = function (self)
		self.deleteHeadBlockModel()
		ModelUtils:copyHeadModel(models.script_head_block, "Skull")
		models.script_head_block.Skull:setParentType("Skull")

		for _, modelPart in ipairs(BlueArchiveCharacter.headBlock.includeModels) do
			models.script_head_block.Skull:addChild(self:copyModel(modelPart))
		end
	end;

	---頭ブロックを削除する。
	deleteHeadBlockModel = function ()
		if models.script_head_block.Skull ~= nil then
			models.script_head_block:removeChild(models.script_head_block.Skull)
			models.script_head_block.Skull:remove()
		end
	end;
}

return HeadBlock
