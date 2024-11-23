---@class (exact) Arms : AvatarModule アバターの腕を制御するクラス
---@field public armState Arms.ArmStateSet 腕の状態：0. バニラ状態, 1. 銃を構えている際の、銃を構えている方の腕, 2. 銃を構えている際の、銃を構えていない方の腕, 3. クロスボウ装填中
---@field package armStatePrev Arms.ArmStateSet 前ティックの腕の状態
---@field package swingCount integer 腕をプラプラさせるカウンター
---@field package isSwingCountProcessed boolean 腕プラプラカウンターを処理したかどうか
---@field package processArmWingCount fun(self: Arms) 腕プラプラカウンターを処理する
---@field public setArmState fun(self: Arms, right?: integer, left?: integer) 腕の状態を設定する

---@class (exact) Arms.ArmStateSet 腕の状態を示すデータセット
---@field public right integer 右腕の状態
---@field public left integer 左腕の状態

Arms = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Arms
    new = function (parent)
        ---@type Arms
        local instance = Avatar.instantiate(Arms, AvatarModule, parent)

        instance.armState = {
            right = 0;
            left = 0;
        }
        instance.armStatePrev = {
            right = 0;
            left = 0;
        }
        instance.swingCount = 0
        instance.isSwingCountProcessed = false

        return instance
    end;

    ---初期化関数
    ---@param self Arms
    init = function (self)
        AvatarModule.init(self)

        events.TICK:register(function ()
            self.isSwingCountProcessed = false
        end)
    end;

    ---腕プラプラカウンターを処理する。
    ---@param self Arms
    processArmWingCount = function (self)
        if not client:isPaused() and not self.isSwingCountProcessed then
            self.swingCount = self.swingCount + 1
            self.swingCount = self.swingCount == 100 and 0 or self.swingCount
            self.isSwingCountProcessed = true
        end
    end;

    ---腕の状態を設定する。
    ---@param self Arms
    ---@param right? integer 右腕の状態
    ---@param left? integer 左腕の状態
    setArmState = function (self, right, left)
        if right ~= nil then
            self.armState.right = right
        end
        if left ~= nil then
            self.armState.left = left
        end
        if (self.armState.right == 1 or self.armState.left == 1) and player:getActiveItem().id == "minecraft:crossbow" then
            self:setArmState(3, 3)
            return
        end
        if self.parent.characterData.arms.callbacks ~= nil and self.parent.characterData.arms.callbacks.onArmStateChanged ~= nil then
            local result = self.parent.characterData.arms.callbacks.onArmStateChanged(self.armState.right, self.armState.left)
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
            models.models.main.Avatar.UpperBody.Arms.RightArm:setRot()
            models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("RightArm")
            events.TICK:remove("right_arm_tick")
            events.RENDER:remove("right_arm_render")
            if self.armState.right == 1 then
                --銃を構えている際の、銃を構えている方の腕
                events.TICK:register(function ()
                    if self.armState.right == 1 then
                        self:processArmWingCount()
                        if player:isSwingingArm() and not player:isLeftHanded() then
                            models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("RightArm")
                        else
                            models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("Body")
                        end
                        if player:getActiveItem().id == "minecraft:crossbow" then
                            self:setArmState(3, 3)
                        end
                    end
                end, "right_arm_tick")
                events.RENDER:register(function (delta)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 90, headRot.y, 0))
                end, "right_arm_render")
            elseif self.armState.right == 2 then
                --銃を構えている際の、銃を構えていない方の腕
                events.TICK:register(function ()
                    self:processArmWingCount()
                end, "right_arm_tick")
                events.RENDER:register(function (delta, context)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
                    models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.swingCount + delta) / 100 * math.pi * 2) * 2.5 + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78), 0))
                end, "right_arm_render")
            elseif self.armState.right == 3 then
                --クロスボウ装填中
                events.TICK:register(function ()
                    if player:getActiveItem().id ~= "minecraft:crossbow" and self.armState.right == 3 then
                        if Gun.CurrentGunPosition == "RIGHT" then
                            self:setArmState(1, 2)
                        elseif Gun.CurrentGunPosition == "LEFT" then
                            self:setArmState(2, 1)
                        end
                    end
                end, "right_arm_tick")
            end
            if self.parent.characterData.arms.callbacks ~= nil and self.parent.characterData.arms.callbacks.onAdditionalRightArmProcess ~= nil then
                self.parent.characterData.arms.callbacks.onAdditionalRightArmProcess(self.armState.right)
            end
            self.armStatePrev.right = self.armState.right
        end
        --左腕の操作
        if self.armState.left ~= self.armStatePrev.left then
            --腕の状態をリセット
            models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot()
            models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("LeftArm")
            events.TICK:remove("left_arm_tick")
            events.RENDER:remove("left_arm_render")
            if self.armState.left == 1 then
                --銃を構えている際の、銃を構えている方の腕
                events.TICK:register(function ()
                    if self.armState.left == 1 then
                        self:processArmWingCount()
                        if player:isSwingingArm() and player:isLeftHanded() then
                            models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("LeftArm")
                        else
                            models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("Body")
                        end
                        if player:getActiveItem().id == "minecraft:crossbow" then
                            self:setArmState(3, 3)
                        end
                    end
                end, "left_arm_tick")
                events.RENDER:register(function (delta)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.swingCount + delta) / 100 * math.pi * 2) * -2.5 + 90, headRot.y, 0))
                end, "left_arm_render")
            elseif self.armState.left == 2 then
                --銃を構えている際の、銃を構えていない方の腕
                models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("Body")
                events.TICK:register(function ()
                    self:processArmWingCount()
                end, "left_arm_tick")
                events.RENDER:register(function (delta, context)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.swingCount + delta) / 100 * math.pi * 2) * -2.5 + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21), 0))
                end, "left_arm_render")
            elseif self.armState.left == 3 then
                --クロスボウ装填中
                events.TICK:register(function ()
                    if player:getActiveItem().id ~= "minecraft:crossbow" and self.armState.left == 3 then
                        if Gun.CurrentGunPosition == "RIGHT" then
                            self:setArmState(1, 2)
                        elseif Gun.CurrentGunPosition == "LEFT" then
                            self:setArmState(2, 1)
                        end
                    end
                end, "left_arm_tick")
            end
            if self.parent.characterData.arms.callbacks ~= nil and self.parent.characterData.arms.callbacks.onAdditionalLeftArmProcess ~= nil then
                self.parent.characterData.arms.callbacks.onAdditionalLeftArmProcess(self.armState.left)
            end
            self.armStatePrev.left = self.armState.left
        end
    end;
}