---アバターベースに含まれる腕の状態
---@alias Arms.BaseArmState
---| "DEFAULT" # 初期状態（バニラと同様）
---| "GUN_MAIN_HAND" # 銃を構えている際の、銃を構えている方の腕
---| "GUN_OFF_HAND" # 銃を構えている際の、銃を構えていない方の腕
---| "CROSSBOW" # クロスボウ装填中

---@class (exact) Arms.ArmStateSet 腕の状態を示すセット
---@field public right Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState 右腕の状態
---@field public left Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState 左腕の状態

---@class (exact) Arms アバターの腕を制御するクラス
---@field public armState Arms.ArmStateSet 腕の状態：0. バニラ状態, 1. 銃を構えている際の、銃を構えている方の腕, 2. 銃を構えている際の、銃を構えていない方の腕, 3. クロスボウ装填中
---@field package armStatePrev Arms.ArmStateSet 前ティックの腕の状態
---@field public swingCount integer 腕をプラプラさせるカウンター
---@field package isSwingCountProcessed boolean 腕プラプラカウンターを処理したかどうか
local Arms = {
    armState = {
		right = "DEFAULT";
		left = "DEFAULT";
    };
	armStatePrev = {
		right = "DEFAULT";
		left = "DEFAULT";
	};
    swingCount = 0;
    isSwingCountProcessed = false;

    ---初期化関数
    ---@param self Arms
    init = function (self)
        events.TICK:register(function ()
            self.isSwingCountProcessed = false
        end)
    end;

    ---腕プラプラカウンターを処理する。
    ---@param self Arms
    processArmSwingCount = function (self)
        if not client:isPaused() and not self.isSwingCountProcessed then
            self.swingCount = self.swingCount + 1
            self.swingCount = self.swingCount == 100 and 0 or self.swingCount
            self.isSwingCountProcessed = true
        end
    end;

    ---腕の状態を設定する。
    ---@param self Arms
    ---@param right? (Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState)? 右腕の状態
    ---@param left? (Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState)? 左腕の状態
    setArmState = function (self, right, left)
        if right ~= nil then
            self.armState.right = right
        end
        if left ~= nil then
            self.armState.left = left
        end
        if (self.armState.right == "GUN_MAIN_HAND" or self.armState.left == "GUN_MAIN_HAND") and player:getActiveItem().id == "minecraft:crossbow" then
            self:setArmState("CROSSBOW", "CROSSBOW")
            return
        end
        if BlueArchiveCharacter.arms.callbacks ~= nil and BlueArchiveCharacter.arms.callbacks.onArmStateChanged ~= nil then
            local result = BlueArchiveCharacter.arms.callbacks.onArmStateChanged(BlueArchiveCharacter, self.armState.right, self.armState.left)
            if result ~= nil then
                if result.right ~= nil then
                    self.armState.right = result.right
                end
                if result.left ~= nil then
                    self.armState.left = result.left
                end
            end
        end

        --右腕の操作
        if self.armState.right ~= self.armStatePrev.right then
            --腕の状態をリセット
            ModelAlias.alias.avatar.rightArm:setRot()
            ModelAlias.alias.avatar.rightArm:setParentType("RightArm")
            events.TICK:remove("right_arm_tick")
            events.RENDER:remove("right_arm_render")
            local shouldPreventDefault = false
            if BlueArchiveCharacter.arms.callbacks ~= nil and BlueArchiveCharacter.arms.callbacks.onAdditionalRightArmProcess ~= nil then
                shouldPreventDefault = BlueArchiveCharacter.arms.callbacks.onAdditionalRightArmProcess(BlueArchiveCharacter, self.armState.right)
            end
            if not shouldPreventDefault then
                if self.armState.right == "GUN_OFF_HAND" then
                    ModelAlias.alias.avatar.rightArm:setParentType("Body")
                end
                self:registerRightArmTickEvent(self.armState.right)
                self:registerRightArmRenderEvent(self.armState.right)
            end
            self.armStatePrev.right = self.armState.right
        end
        --左腕の操作
        if self.armState.left ~= self.armStatePrev.left then
            --腕の状態をリセット
            ModelAlias.alias.avatar.leftArm:setRot()
            ModelAlias.alias.avatar.leftArm:setParentType("LeftArm")
            events.TICK:remove("left_arm_tick")
            events.RENDER:remove("left_arm_render")
            local shouldPreventDefault = false
            if BlueArchiveCharacter.arms.callbacks ~= nil and BlueArchiveCharacter.arms.callbacks.onAdditionalLeftArmProcess ~= nil then
                shouldPreventDefault = BlueArchiveCharacter.arms.callbacks.onAdditionalLeftArmProcess(BlueArchiveCharacter, self.armState.left)
            end
            if not shouldPreventDefault then
                if self.armState.left == "GUN_OFF_HAND" then
                    ModelAlias.alias.avatar.leftArm:setParentType("Body")
                end
                self:registerLeftArmTickEvent(self.armState.left)
                self:registerLeftArmRenderEvent(self.armState.left)
            end
            self.armStatePrev.left = self.armState.left
        end
    end;

    ---右腕のティック処理を登録する。
    ---@param self Arms
    ---@param state Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState 腕の状態
    registerRightArmTickEvent = function (self, state)
        if state == "GUN_MAIN_HAND" then
            events.TICK:register(function ()
                if self.armState.right == "GUN_MAIN_HAND" then
                    self:processArmSwingCount()
                    if player:isSwingingArm() and not player:isLeftHanded() then
                        ModelAlias.alias.avatar.rightArm:setParentType("RightArm")
                    else
                        ModelAlias.alias.avatar.rightArm:setParentType("Body")
                    end
                    if player:getActiveItem().id == "minecraft:crossbow" then
                        self:setArmState("CROSSBOW", "CROSSBOW")
                    end
                end
            end, "right_arm_tick")
        elseif state == "GUN_OFF_HAND" then
            events.TICK:register(function ()
                self:processArmSwingCount()
            end, "right_arm_tick")
        elseif state == "CROSSBOW" then
            events.TICK:register(function ()
                if player:getActiveItem().id ~= "minecraft:crossbow" and self.armState.right == "CROSSBOW" then
                    if Gun.currentGunPosition == "RIGHT" then
                        self:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
                    elseif Gun.currentGunPosition == "LEFT" then
                        self:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
                    end
                end
            end, "right_arm_tick")
        end
    end;

    ---右腕のレンダー処理を登録する。
    ---@param self Arms
    ---@param state Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState 腕の状態
    registerRightArmRenderEvent = function (self, state)
        if state == "GUN_MAIN_HAND" then
            events.RENDER:register(function (delta)
                local headRot = vanilla_model.HEAD:getOriginRot()
                ModelAlias.alias.avatar.rightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 90 + (player:isCrouching() and 30 or 0), headRot.y, 0))
            end, "right_arm_render")
        elseif state == "GUN_OFF_HAND" then
            events.RENDER:register(function (delta, context)
                local headRot = vanilla_model.HEAD:getOriginRot()
                local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
                ModelAlias.alias.avatar.rightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
                ModelAlias.alias.avatar.rightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 90 + (player:isCrouching() and 30 or 0), math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78), 0))
            end, "right_arm_render")
        end
    end;

    ---左腕のティック処理を登録する。
    ---@param self Arms
    ---@param state Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState 腕の状態
    registerLeftArmTickEvent = function (self, state)
        if state == "GUN_MAIN_HAND" then
            events.TICK:register(function ()
                if self.armState.left == "GUN_MAIN_HAND" then
                    self:processArmSwingCount()
                    if player:isSwingingArm() and player:isLeftHanded() then
                        ModelAlias.alias.avatar.leftArm:setParentType("LeftArm")
                    else
                        ModelAlias.alias.avatar.leftArm:setParentType("Body")
                    end
                    if player:getActiveItem().id == "minecraft:crossbow" then
                        self:setArmState("CROSSBOW", "CROSSBOW")
                    end
                end
            end, "left_arm_tick")
        elseif state == "GUN_OFF_HAND" then
            events.TICK:register(function ()
                self:processArmSwingCount()
            end, "left_arm_tick")
        elseif state == "CROSSBOW" then
            events.TICK:register(function ()
                if player:getActiveItem().id ~= "minecraft:crossbow" and self.armState.left == "CROSSBOW" then
                    if Gun.currentGunPosition == "RIGHT" then
                        self:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
                    elseif Gun.currentGunPosition == "LEFT" then
                        self:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
                    end
                end
            end, "left_arm_tick")
        end
    end;

    ---左腕のレンダー処理を登録する。
    ---@param self Arms
    ---@param state Arms.BaseArmState|BlueArchiveCharacter.AdditionalArmState 腕の状態
    registerLeftArmRenderEvent = function (self, state)
        if state == "GUN_MAIN_HAND" then
            events.RENDER:register(function (delta)
                local headRot = vanilla_model.HEAD:getOriginRot()
                ModelAlias.alias.avatar.leftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.swingCount + delta) / 100 * math.pi * 2) * -2.5 + 90 + (player:isCrouching() and 30 or 0), headRot.y, 0))
            end, "left_arm_render")
        elseif state == "GUN_OFF_HAND" then
            events.RENDER:register(function (delta, context)
                local headRot = vanilla_model.HEAD:getOriginRot()
                local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
                ModelAlias.alias.avatar.leftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
                ModelAlias.alias.avatar.leftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.swingCount + delta) / 100 * math.pi * 2) * -2.5 + 90 + (player:isCrouching() and 30 or 0), math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21), 0))
            end, "left_arm_render")
        end
    end;
}

return Arms
