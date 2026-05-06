---@class (exact) ExSkill1Text : SpawnObject Exスキル内で使用するテキストのオブジェクトのクラス
---@field package object TextTask インスタンスで制御するテキストオブジェクト
---@field package face integer テキストの向きを決定する値（1: 下面, 2: 上面, 3: 左面, 4: 右面）
---@field package currentPos Vector3 オブジェクトの現在位置
---@field package nextPos Vector3 次ティックのオブジェクトの位置
local ExSkill1Text = {
	textList = {
		"if #BlueArchiveCharacter.skirt.skirtModels > 0 then",
		"local heldItems = {player:getHeldItem(isLeftHanded), player:getHeldItem(not isLeftHanded)}",
		"EventManager.events[\"ON_LOCALE_READY\"]:register(function ()",
		"if Gun.currentGunPosition ~= self.gunPositionPrev then",
		"if self.locales[locale] == nil and self.availableLocales[locale] ~= nil then",
		"skirtModel:setRot(isCrouching and 30 or 0, 0, 0)",
		"for _, skirtModel in ipairs(BlueArchiveCharacter.skirt.skirtModels) do",
		"models.models.action_wheel_gui.Gui.VersionDisplay:getTask(\"action_wheel.gui.version_display.l3\"):setText(Locale:getLocalizedText(\"action_wheel.gui.update_check.locale_version\"):format(self.localeVersion or \"v?.?.?\"))",
		"if Gun.currentGunPosition == \"RIGHT\" or Gun.currentGunPosition == \"LEFT\" then",
		"local isLeftHanded = player:isLeftHanded()"
	};

	---コンストラクタ
    ---@param pos Vector3 オブジェクトをスポーンさせる位置
	---@param face integer テキストの向きを決定する値（1: 下面, 2: 上面, 3: 左面, 4: 右面）
	---@return ExSkill1Text
	new = function (pos, face)
		---@type ExSkill1Text
		local instance = MiscUtils.instantiate(ExSkill1Text, SpawnObject)

		instance.object = models.models.ex_skill_1.CyberArea:newText(instance.uuid)
		instance.face = face
		instance.currentPos = pos:copy()
		instance.nextPos = instance.currentPos:copy()

		instance.callbacks = {
			---@param self ExSkill1Text
			onInit = function (self)
				local text = ExSkill1Text.textList[math.random(#ExSkill1Text.textList)]
				self.object:setText(text)
				self.currentPos.z = self.currentPos.z + client.getTextWidth(text) / 4
				self.nextPos = self.currentPos:copy()
				self.object:setPos(self.currentPos)
				self.object:setScale(0.25)
				self.object:setLight(15, 15)
				if self.face == 1 then
					self.object:setRot(90, self.currentPos.x >= 0 and 90 or -90, 0)
					self.object:setAlignment(self.currentPos.x >= 0 and "RIGHT" or "LEFT")
				elseif self.face == 2 then
					self.object:setRot(-90, self.currentPos.x >= 0 and -90 or 90, 0)
					self.object:setAlignment(self.currentPos.x >= 0 and "LEFT" or "RIGHT")
				elseif self.face == 3 then
					self.object:setRot(0, -90, 0)
				elseif self.face == 4 then
					self.object:setRot(0, 90, 0)
					self.object:setAlignment("RIGHT")
				end
			end;

			---@param self ExSkill1Text
			onDeinit = function (self)
				models.models.ex_skill_1.CyberArea:removeTask(self.uuid)
			end;

			---@param self ExSkill1Text
			onTick = function (self)
				--オブジェクトの位置を強制更新
				self.currentPos = self.nextPos:copy()
				self.object:setPos(self.currentPos)
				if self.currentPos.z <= -72 then
					self.shouldDeinit = true
				end

				self.nextPos = self.currentPos:copy():add(0, 0, -2)
			end;

			---@param self ExSkill1Text
			onRender = function (self, delta, context)
				self.object:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos))
			end;
		}

		return instance
	end;
}

return ExSkill1Text
