---@class (exact) Shield シールドの視覚効果（本家ブルーアーカイブの青いサッカーボール型のシールド。マインクラフトにおける衝撃吸収効果に相当。）を管理するクラス
---@field package animationCounts number[] シールドのアニメーションのカウンター
---@field public isShieldVisible boolean シールドが可視化状態かどうか
---@field package hadAbsorptionPrev boolean 前ティックの衝撃吸収のハートを持っていたかどうか
---@field package colorFactor number シールドの色の係数
local Shield = {
	animationCounts = {};
	isShieldVisible = false;
	hadAbsorptionPrev = false;
	colorFactor = 1;

    ---初期化関数
    ---@param self Shield
    init = function (self)
        events.TICK:register(function ()
			local hasAbsorption = player:getAbsorptionAmount() > 0 and player:getHealth() > 0
			if hasAbsorption ~= self.hadAbsorptionPrev then
				self:setShield(hasAbsorption)
				self.hadAbsorptionPrev = hasAbsorption
			end
        end)
    end;

	---シールドのレンダリング処理を行う。
	---@param self Shield
	---@param delta? number レンダーの出るた値
	processShieldRender = function (self, delta)
		for i = 1, 32 do
			local opacity = math.abs(-0.025 * (self.animationCounts[i] + (delta or 0)) + 0.5) + 0.5
			ModelAlias.alias.avatar.root.Shield["Shield"..i]:setOpacity(opacity)
			ModelAlias.alias.avatar.root.Shield["Shield"..i]:setColor(opacity * self.colorFactor, opacity * self.colorFactor, 1)

		end
	end;

	---シールドの可視性を設定する。
	---@param self Shield
	---@param isVisible boolean シールドを表示するかどうか
	setShield = function (self, isVisible)
		if isVisible then
			ModelAlias.alias.avatar.nameplate:setPos(0, 4, 0)
			for i = 1, 32 do
            	self.animationCounts[i] = math.random(0, 39)
			end
			self.colorFactor = client:hasShaderPack() and 0.5 or 1
			self:processShieldRender()

			events.TICK:register(function ()
				if not client:isPaused() then
					for i = 1, 32 do
						self.animationCounts[i] = self.animationCounts[i] + 1
						if self.animationCounts[i] == 40 then
							self.animationCounts[i] = 0
						end
					end
					self.colorFactor = client:hasShaderPack() and 0.5 or 1
				end
			end, "shield_tick")

			events.RENDER:register(function (delta, context)
				if context == "RENDER" then
					ModelAlias.alias.avatar.root.Shield:setVisible(true)
					if not client:isPaused() then
						self:processShieldRender(delta)
					end
				else
					ModelAlias.alias.avatar.root.Shield:setVisible(false)
				end
			end, "shield_render")
		else
			events.TICK:remove("shield_tick")
			events.RENDER:remove("shield_render")
			ModelAlias.alias.avatar.root.Shield:setVisible(false)
			ModelAlias.alias.avatar.nameplate:setPos(0, 0, 0)
        end
		self.isShieldVisible = isVisible
	end;
}

return Shield
