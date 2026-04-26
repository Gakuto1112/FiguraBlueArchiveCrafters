---@class (exact) HoshinoShield 盾を制御するクラス
---@field public hasShield boolean 盾を手に持っているかどうか
local HoshinoShield = {
    hasShield = false;

    ---初期化関数
    ---@param self HoshinoShield
    init = function (self)
        events.TICK:register(function ()
            self:setShield((player:getHeldItem().id == "minecraft:shield" or player:getHeldItem(true).id == "minecraft:shield") and ExSkill.animationCount == -1, true)
        end)

        events.ITEM_RENDER:register(function (item, mode)
            if item.id == "minecraft:shield" and mode ~= "HEAD" and self.hasShield then
                if mode == "FIRST_PERSON_LEFT_HAND" then
                    local leftHanded = player:isLeftHanded()
                    if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "OFF_HAND" and not leftHanded) or (player:getActiveHand() == "MAIN_HAND" and leftHanded)) then
                        ModelAlias.alias.avatar.body.Shield:setPos(8, -20.25, 2.5)
                        ModelAlias.alias.avatar.body.Shield:setRot(0, 0, -5)
                    else
                        ModelAlias.alias.avatar.body.Shield:setPos(6, -22.5, 2.5)
                        ModelAlias.alias.avatar.body.Shield:setRot(0, 0, 5)
                    end
                elseif mode == "FIRST_PERSON_RIGHT_HAND" then
                    local leftHanded = player:isLeftHanded()
                    if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "MAIN_HAND" and not leftHanded) or (player:getActiveHand() == "OFF_HAND" and leftHanded)) then
                        ModelAlias.alias.avatar.body.Shield:setPos(0, -19.25, 2.5)
                        ModelAlias.alias.avatar.body.Shield:setRot(0, 0, 5)
                    else
                        ModelAlias.alias.avatar.body.Shield:setPos(2, -22.5, 2.5)
                        ModelAlias.alias.avatar.body.Shield:setRot(0, 0, -5)
                    end
                elseif mode == "THIRD_PERSON_LEFT_HAND" then
                    if Arms.armState.left == "SHIELD_HAND" then
                        if player:isCrouching() then
                            ModelAlias.alias.avatar.body.Shield:setPos(3.5, -19.5, 0)
                            ModelAlias.alias.avatar.body.Shield:setRot(80, 5, 30)
                        else
                            ModelAlias.alias.avatar.body.Shield:setPos(2, -20.5, -1)
                            ModelAlias.alias.avatar.body.Shield:setRot(55, 20, 25)
                        end
                    else
                        local leftHanded = player:isLeftHanded()
                        if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "OFF_HAND" and not leftHanded) or (player:getActiveHand() == "MAIN_HAND" and leftHanded)) then
                            ModelAlias.alias.avatar.body.Shield:setPos(2, -20.5, -2)
                            ModelAlias.alias.avatar.body.Shield:setRot(50, 30, 30)
                        else
                            ModelAlias.alias.avatar.body.Shield:setPos(2, -20.5, 2.5)
                            ModelAlias.alias.avatar.body.Shield:setRot(5, 90, 0)
                        end
                    end
                elseif mode == "THIRD_PERSON_RIGHT_HAND" then
                    if Arms.armState.right == "SHIELD_HAND" then
                        if player:isCrouching() then
                            ModelAlias.alias.avatar.body.Shield:setPos(4.5, -19.5, 0)
                            ModelAlias.alias.avatar.body.Shield:setRot(80, -5, -30)
                        else
                            ModelAlias.alias.avatar.body.Shield:setPos(6, -20.5, -1)
                            ModelAlias.alias.avatar.body.Shield:setRot(55, -20, -25)
                        end
                    else
                        local leftHanded = player:isLeftHanded()
                        if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "MAIN_HAND" and not leftHanded) or (player:getActiveHand() == "OFF_HAND" and leftHanded)) then
                            ModelAlias.alias.avatar.body.Shield:setPos(6, -20.5, -2)
                            ModelAlias.alias.avatar.body.Shield:setRot(50, -30, -30)
                        else
                            ModelAlias.alias.avatar.body.Shield:setPos(6, -20.5, 2.5)
                            ModelAlias.alias.avatar.body.Shield:setRot(5, -90, 0)
                        end
                    end
                end
                ModelAlias.alias.avatar.body.Shield:setSecondaryRenderType(item:hasGlint() and "GLINT" or "NONE")
                return ModelAlias.alias.avatar.body.Shield
            end
        end)

        local this = self --Figuraにスクリプトを再構築させると参照がおかしくなることに対処しているコード
        events.ON_PLAY_SOUND:register(function (id, pos, _, _, _, _, path)
            self = this
            if path ~= nil then
                if id == "minecraft:item.shield.block" and math.abs(pos:copy():sub(player:getPos()):length() - player:getVelocity():length()) < 0.2 and player:getActiveItem().id == "minecraft:shield" then
                    sounds:playSound("minecraft:block.anvil.place", pos, 1, 4)
                    return true
                end
            end
        end)
    end;

    ---盾の展開状態を設定する。
    ---@param self Shield
    ---@param value boolean 新しい値
    ---@param shouldPlayShieldSound boolean 盾の展開音を再生するかどうか
    setShield = function (self, value, shouldPlayShieldSound)
        if value and not self.hasShield then
            for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Shield.Section2, ModelAlias.alias.avatar.body.Shield.Section2.Section1}) do
                modelPart:setRot()
            end
            for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Shield.Section2.GasCylinder3.GasPiston3, ModelAlias.alias.avatar.body.Shield.Section2.GasCylinder4.GasPiston4, ModelAlias.alias.avatar.body.Shield.Section2.Section1.GasCylinder1.GasPiston1, ModelAlias.alias.avatar.body.Shield.Section2.Section1.GasCylinder2.GasPiston2}) do
                modelPart:setPos(0, -1.4, 0)
            end
            ModelAlias.alias.avatar.body.Shield.Section3.Handle2:setPos(0, 0.25, 0)
            ModelAlias.alias.avatar.body.Shield.Section2.Section1.Handle:setPos(0, -0.25, 0)
            if shouldPlayShieldSound then
                sounds:playSound("minecraft:block.anvil.place", player:getPos(), 0.1, 2)
            end
        elseif not value and self.hasShield then
            ModelAlias.alias.avatar.body.Shield:setPos()
            ModelAlias.alias.avatar.body.Shield:setRot(5, 90, 0)
            for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Shield.Section2, ModelAlias.alias.avatar.body.Shield.Section2.Section1}) do
                modelPart:setRot(-180, 0, 0)
            end
            for _, modelPart in ipairs({ModelAlias.alias.avatar.body.Shield.Section2.GasCylinder3.GasPiston3, ModelAlias.alias.avatar.body.Shield.Section2.GasCylinder4.GasPiston4, ModelAlias.alias.avatar.body.Shield.Section2.Section1.GasCylinder1.GasPiston1, ModelAlias.alias.avatar.body.Shield.Section2.Section1.GasCylinder2.GasPiston2, ModelAlias.alias.avatar.body.Shield.Section3.Handle2, ModelAlias.alias.avatar.body.Shield.Section2.Section1.Handle}) do
                modelPart:setPos()
            end
        end
        self.hasShield = value
    end;
}

return HoshinoShield
