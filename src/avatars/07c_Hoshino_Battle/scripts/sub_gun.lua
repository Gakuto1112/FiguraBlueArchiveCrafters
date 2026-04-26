---@class (exact) SubGun 臨戦衣装の拳銃を制御するクラス
---@field public hasSubGun boolean サブハンドガンを持っているかどうか
local SubGun = {
    hasSubGun = false;

    ---サブハンドガンを有効にする。
    ---@param self SubGun
    enable = function (self)
        events.TICK:register(function ()
            if Gun.currentGunPosition ~= "NONE" then
                local isLeftHanded = player:isLeftHanded()
                local heldItem = player:getHeldItem(Gun.currentGunPosition == "RIGHT" ~= isLeftHanded)
                self.hasSubGun = false
                for _, gunItem in ipairs(Gun.GUN_ITEMS) do
                    if gunItem == heldItem.id then
                        self.hasSubGun = true
                        break
                    end
                end
            end
            if self.hasSubGun and ExSkill.animationCount == -1 then
                ModelAlias.alias.avatar.body.SubGun:setScale(1.5, 1.5, 1.5)
                ModelAlias.alias.avatar.body.SubGun:setParentType("Item")
            elseif ExSkill.animationCount == -1 then
                ModelAlias.alias.avatar.body.SubGun:setPos(-1, 17.5, -1.9)
                ModelAlias.alias.avatar.body.SubGun:setRot(-30, 90, 0)
                ModelAlias.alias.avatar.body.SubGun:setScale()
                ModelAlias.alias.avatar.body.SubGun:setParentType("None")
            end
        end, "sun_gun_tick")
        events.ITEM_RENDER:register(function (_, mode)
            if self.hasSubGun then
                if Gun.currentGunPosition == "RIGHT" then
                    if mode == "FIRST_PERSON_LEFT_HAND" then
                        ModelAlias.alias.avatar.body.SubGun:setPos(-1, 0.5, -2.5)
                        ModelAlias.alias.avatar.body.SubGun:setRot()
                        return ModelAlias.alias.avatar.body.SubGun
                    elseif mode == "THIRD_PERSON_LEFT_HAND" then
                        ModelAlias.alias.avatar.body.SubGun:setPos(0, -2, -1)
                        ModelAlias.alias.avatar.body.SubGun:setRot()
                        return ModelAlias.alias.avatar.body.SubGun
                    end
                elseif Gun.currentGunPosition == "LEFT" then
                    if mode == "FIRST_PERSON_RIGHT_HAND" then
                        ModelAlias.alias.avatar.body.SubGun:setPos(-1, 0.5, -1)
                        ModelAlias.alias.avatar.body.SubGun:setRot()
                        return ModelAlias.alias.avatar.body.SubGun
                    elseif mode == "THIRD_PERSON_RIGHT_HAND" then
                        ModelAlias.alias.avatar.body.SubGun:setPos(0, -2, -1)
                        ModelAlias.alias.avatar.body.SubGun:setRot()
                        return ModelAlias.alias.avatar.body.SubGun
                    end
                end
            end
        end, "sun_gun_item_render")
    end;

    ---サブハンドガンを無効にする。
    ---@param self SubGun
    disable = function (self)
        events.TICK:remove("sun_gun_tick")
        events.ITEM_RENDER:remove("sun_gun_item_render")
        self.hasSubGun = false
    end;
}

return SubGun
