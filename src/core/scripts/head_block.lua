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
                self:generateHeadBlockModel(false)
                events.WORLD_TICK:remove("head_block_world_tick")
            end
        end, "head_block_world_tick")
    end;

	---頭ブロックのモデルを作成する。
	---@param self HeadBlock
	---@param isAlt boolean バリエーションコスチュームを設定中かどうか
	generateHeadBlockModel = function (self, isAlt)
		self.deleteHeadBlockModel()

		if BlueArchiveCharacter.headBlock.callbacks ~= nil and BlueArchiveCharacter.headBlock.callbacks.onBeforeModelCopy ~= nil then
			BlueArchiveCharacter.headBlock.callbacks.onBeforeModelCopy(BlueArchiveCharacter, isAlt)
		end

		ModelAlias.alias.avatar.mouth:setVisible(true)

		ModelUtils:copyAvatarModel(models.script_head_block, "Skull")

		ModelAlias.alias.avatar.mouth:setVisible(false)

		ModelAlias.alias.head_block_avatar = ModelAlias:getAliasTable(models.script_head_block.Skull)

		ModelAlias.alias.head_block_avatar.root:setParentType("Skull")
		if ModelAlias.alias.head_block_avatar.gun ~= nil then
			ModelAlias.alias.head_block_avatar.gun:remove()
		end
		if ModelAlias.alias.head_block_avatar.body.Bubble ~= nil then
			ModelAlias.alias.head_block_avatar.body.Bubble:remove()
		end

		ModelAlias.alias.head_block_avatar.root:setScale(0.5, 0.5, 0.5)
		ModelAlias.alias.head_block_avatar.head:setPos(0, -8, 0)
		ModelAlias.alias.head_block_avatar.halo:setPos()
		ModelAlias.alias.head_block_avatar.halo:setLight()
		ModelAlias.alias.head_block_avatar.upperBody:setScale(0.67, 0.67, 0.67)
		ModelAlias.alias.head_block_avatar.lowerBody:setScale(0.67, 0.67, 0.67)
		ModelAlias.alias.head_block_avatar.rightLeg:setRot(90, -10, 0)
		ModelAlias.alias.head_block_avatar.leftLeg:setRot(90, 10, 0)

		ModelAlias.alias.head_block_avatar.rightEye:setUVPixels(BlueArchiveCharacter.faceParts.rightEye[BlueArchiveCharacter.headBlock.emotion.rightEye]:copy():scale(6))
		ModelAlias.alias.head_block_avatar.leftEye:setUVPixels(BlueArchiveCharacter.faceParts.leftEye[BlueArchiveCharacter.headBlock.emotion.leftEye]:copy():scale(6))
		ModelAlias.alias.head_block_avatar.mouth:setUVPixels(BlueArchiveCharacter.faceParts.mouth[BlueArchiveCharacter.headBlock.emotion.mouth]:copy():mul(16, 8))

		if BlueArchiveCharacter.headBlock.callbacks ~= nil and BlueArchiveCharacter.headBlock.callbacks.onAfterModelCopy ~= nil then
			BlueArchiveCharacter.headBlock.callbacks.onAfterModelCopy(BlueArchiveCharacter, isAlt)
		end

		if events.SKULL_RENDER:getRegisteredCount("skull_render") == 0 then
			events.SKULL_RENDER:register(function (_, _, _, _, context)
				if context == "FIRST_PERSON_RIGHT_HAND" then
					ModelAlias.alias.head_block_avatar.root:setPos(0, 2, 0)
					ModelAlias.alias.head_block_avatar.root:setRot(0, -40, 0)
					ModelAlias.alias.head_block_avatar.rightArm:setRot(0, 0, 30)
					ModelAlias.alias.head_block_avatar.leftArm:setRot(0, 0, -30)
				elseif context == "FIRST_PERSON_LEFT_HAND" then
					ModelAlias.alias.head_block_avatar.root:setPos(0, 2, 0)
					ModelAlias.alias.head_block_avatar.root:setRot(0, 40, 0)
					ModelAlias.alias.head_block_avatar.rightArm:setRot(0, 0, 30)
					ModelAlias.alias.head_block_avatar.leftArm:setRot(0, 0, -30)
				elseif context == "HEAD" then
					ModelAlias.alias.head_block_avatar.root:setPos(0, 0, 4)
					ModelAlias.alias.head_block_avatar.rightArm:setRot(90, -10, 0)
					ModelAlias.alias.head_block_avatar.leftArm:setRot(90, 10, 0)
				else
					ModelAlias.alias.head_block_avatar.root:setPos(0, -3.5, 0)
					ModelAlias.alias.head_block_avatar.root:setRot()
					ModelAlias.alias.head_block_avatar.rightArm:setRot(0, 0, 30)
					ModelAlias.alias.head_block_avatar.leftArm:setRot(0, 0, -30)
				end
			end, "skull_render")
		end
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
