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

		ModelUtils:copyAvatarModel(models.script_head_block, "Skull")

		ModelAlias.alias.head_block_avatar = ModelAlias:getAliasTable(models.script_head_block.Skull)

		ModelAlias.alias.head_block_avatar.root:setParentType("Skull")

		ModelAlias.alias.head_block_avatar.root:setScale(0.5, 0.5, 0.5)
		ModelAlias.alias.head_block_avatar.root:setPos(0, -3.5, 0)
		ModelAlias.alias.head_block_avatar.head:setPos(0, -8, 0)
		ModelAlias.alias.head_block_avatar.upperBody:setScale(0.67, 0.67, 0.67)
		ModelAlias.alias.head_block_avatar.lowerBody:setScale(0.67, 0.67, 0.67)
		ModelAlias.alias.head_block_avatar.rightArm:setRot(0, 0, 30)
		ModelAlias.alias.head_block_avatar.leftArm:setRot(0, 0, -30)
		ModelAlias.alias.head_block_avatar.rightLeg:setRot(90, -10, 0)
		ModelAlias.alias.head_block_avatar.leftLeg:setRot(90, 10, 0)
	end;

	---頭ブロックを削除する。
	deleteHeadBlockModel = function ()
		if models.script_head_block.Skull ~= nil then
			local skull = models.script_head_block.Skull
			models.script_head_block:removeChild(skull)
			skull:remove()
		end
	end;
}

return HeadBlock
