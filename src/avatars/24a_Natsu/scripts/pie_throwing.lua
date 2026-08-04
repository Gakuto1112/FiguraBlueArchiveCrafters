---@class (exact) PieThrowing パイ投げのアニメーションを制御するクラス
---@field package animationTick integer パイ投げのアニメーションのタイミングを測るカウンター。-1はアニメーションが停止していることを表す。
local PieThrowing = {
	animationTick = -1;

	---パイ投げのアニメーションを再生する。
	---@param self PieThrowing
	play = function (self)
		ModelAlias.alias.avatar.rightArmBottom.Pie:setVisible(true)
		for _, modelName in ipairs({"models.main", "models.pie"}) do
			animations[modelName]["pie_throwing"]:play()
		end
		Physics:disable()
		Arms:setHeldItemVisible(false)
		self.animationTick = 0

		events.TICK:register(function ()
			if not client:isPaused() then
				if self.animationTick == 0 then
					FaceParts:setEmotion("NORMAL", "NORMAL", "HAT", 5, true)
				elseif self.animationTick == 5 then
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAT", 2, true)
				elseif self.animationTick == 7 then
					FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 16, true)
					ModelAlias.alias.avatar.faceParts.Eyes.EyeShines:setVisible(true)
				elseif self.animationTick == 23 then
					FaceParts:setEmotion("CLOSED2", "CLOSED2", "HAPPY", 19, true)
					ModelAlias.alias.avatar.faceParts.Eyes.EyeShines:setVisible(false)
					ModelAlias.alias.avatar.rightEye:setRot(0, 0, -5)
					ModelAlias.alias.avatar.leftEye:setRot(0, 0, 5)
				elseif self.animationTick == 27 then
					PieManager:spawn(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 1.5, 0.5, 0, 1, 0):add(player:getPos()))
				elseif self.animationTick == 42 then
					self:stop()
				end
				self.animationTick = self.animationTick + 1
			end
		end, "pie_throwing_tick")
	end;

	---パイ投げのアニメーションを停止する。
	---@param self PieThrowing
	stop = function (self)
		events.TICK:remove("pie_throwing_tick")

		for _, modelPart in ipairs({ModelAlias.alias.avatar.rightArmBottom.Pie, ModelAlias.alias.avatar.faceParts.Eyes.EyeShines}) do
			modelPart:setVisible(false)
		end
		for _, modelName in ipairs({"models.main", "models.pie"}) do
			animations[modelName]["pie_throwing"]:stop()
		end
		for _, modelPart in ipairs({ModelAlias.alias.avatar.rightEye, ModelAlias.alias.avatar.leftEye}) do
			modelPart:setRot()
		end
		Physics:enable()
		Arms:setHeldItemVisible(true)
		self.animationTick = -1
	end;
}

return PieThrowing
