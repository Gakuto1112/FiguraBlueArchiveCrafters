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
			if self.animationTick == 42 then
				self:stop()
			end
			self.animationTick = self.animationTick + 1
		end, "pie_throwing_tick")
	end;

	---パイ投げのアニメーションを停止する。
	---@param self PieThrowing
	stop = function (self)
		events.TICK:remove("pie_throwing_tick")

		ModelAlias.alias.avatar.rightArmBottom.Pie:setVisible(false)
		for _, modelName in ipairs({"models.main", "models.pie"}) do
			animations[modelName]["pie_throwing"]:stop()
		end
		Physics:enable()
		Arms:setHeldItemVisible(true)
		self.animationTick = -1
	end;
}

return PieThrowing
