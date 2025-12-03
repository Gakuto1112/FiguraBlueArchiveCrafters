---@alias Gun.GunPosition
---| "NONE" # 構えていない
---| "RIGHT" # 右手に構える
---| "LEFT" # 左手に構える

---@alias Gun.HandDirection
---| "RIGHT" # 右手
---| "LEFT" # 左手

---@class (exact) Gun : AvatarModule 生徒の銃を制御するクラス
---@field public gunItems Minecraft.itemID[] 銃のモデルを適用するアイテム
---@field public shouldShowWeaponInFirstPerson boolean 一人称で武器（銃を含む）のモデルを表示するかどうか
---@field public currentGunPosition Gun.GunPosition 現在の銃の位置
---@field package heldItemsPrev Gun.HeldItemSet 前ティックの手持ちアイテム
---@field package isLeftHandedPrev boolean 前ティックに左利きだったかどうか
---@field package isGunTickProcessed boolean このティック内で銃ティックを処理したかどうか
---@field package setBodyGunPos fun(self: Gun) 背中の銃の位置・向きを設定する
---@field public setGunPosition fun(self: Gun, gonPosition: Gun.GunPosition) 銃の位置を変更する
---@field public processGunTick fun(self: Gun) 銃ティックを処理する

---@class (exact) Gun.HeldItemSet 手持ちアイテムを示すデータセット
---@field public mainHand ItemStack メインハンド
---@field public offHand ItemStack オフハンド

Gun = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Gun
    new = function (parent)
        ---@type Gun
        local instance = Avatar.instantiate(Gun, AvatarModule, parent)

        instance.gunItems = {"minecraft:bow", "minecraft:crossbow"}
        instance.shouldShowWeaponInFirstPerson = instance.parent.config:loadConfig("PRIVATE", "firstPersonWeapon", true)
        instance.currentGunPosition = "NONE"
        instance.heldItemsPrev = {
            mainHand = world.newItem(instance.parent.compatibilityUtils:checkItem("minecraft:air"));
            offHand = world.newItem(instance.parent.compatibilityUtils:checkItem("minecraft:air"));
        }
        instance.isLeftHandedPrev = player:isLeftHanded()
        instance.isGunTickProcessed = false

        return instance
    end;

    ---初期化関数
    ---@param self Gun
    init = function (self)
        AvatarModule.init(self)

        events.TICK:register(function ()
            self:processGunTick()
            self.isGunTickProcessed = false
        end)

        local this = self --Figuraにスクリプトを再構築させると参照がおかしくなることに対処しているコード
        events.ON_PLAY_SOUND:register(function (id, pos, _, _, _, _, path)
            self = this
            if path ~= nil then
                local velocityDistance = player:getVelocity():length()
                local distanceFromSound = math.abs(pos:copy():sub(player:getPos()):length() - velocityDistance)
                if (id == "minecraft:entity.arrow.shoot" or id == "minecraft:item.crossbow.loading_end" or id == "minecraft:item.crossbow.shoot") and math.abs(velocityDistance - distanceFromSound) < 1.2 then
                    if id == "minecraft:item.crossbow.loading_end" then
                        sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:block.dispenser.fail"), pos, 1, 2)
                    elseif player:isUnderwater() then
                        sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:entity.generic.extinguish_fire"), pos, 0.5, 1.5)
                    else
                        local particleAnchor = self.parent.modelUtils.getModelWorldPos(renderer:isFirstPerson() and (Gun.CurrentGunPosition == "RIGHT" and models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightItemPivot or models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftItemPivot) or models.models.main.Avatar.UpperBody.Body.Gun.MuzzleAnchor)
                        for _ = 1, 5 do
                            particles:newParticle(self.parent.compatibilityUtils:checkParticle("minecraft:smoke"), particleAnchor)
                        end
                        sounds:playSound(self.parent.compatibilityUtils:checkSound(self.parent.characterData.gun.sound.name), pos, 1, self.parent.characterData.gun.sound.pitch)
                    end
                    return true
                elseif (id == "minecraft:item.crossbow.loading_start" or id == "minecraft:item.crossbow.loading_middle" or id:match("^minecraft:item%.crossbow%.quick_charge_[1-3]$") ~= nil) and distanceFromSound < 1 and player:getActiveItem().id == "minecraft:crossbow" then
                    local activeItemTime = player:getActiveItemTime()
                    local quickChargeLevel = 0
                    local activeItem = player:getActiveItem()
                    local gameVersion = client:getVersion()
                    if gameVersion >= "1.21.5" then
                        quickChargeLevel = activeItem.tag["minecraft:enchantments"]["minecraft:quick_charge"] ~= nil and activeItem.tag["minecraft:enchantments"]["minecraft:quick_charge"] or 0
                    elseif gameVersion >= "1.20.5" then
                        quickChargeLevel = activeItem.tag["minecraft:enchantments"].levels["minecraft:quick_charge"] ~= nil and activeItem.tag["minecraft:enchantments"].levels["minecraft:quick_charge"] or 0
                    elseif activeItem.tag.Enchantments ~= nil then
                        for _, enchant in ipairs(activeItem.tag.Enchantments) do
                            if enchant.id == "minecraft:quick_charge" then
                                quickChargeLevel = enchant.lvl
                                break
                            end
                        end
                    end
                    if (quickChargeLevel <= 4 and activeItemTime + quickChargeLevel >= 4 and activeItemTime + quickChargeLevel <= 6) or (quickChargeLevel == 5 and activeItemTime <= 2) then
                        sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:item.flintandsteel.use"), pos, 1, 2)
                        return true
                    elseif id == "minecraft:item.crossbow.loading_middle" then
                        return true
                    end
                end
            end
        end)

        events.ITEM_RENDER:register(function (item, mode, _, _, _, leftHanded)
            self = this
            if mode ~= "HEAD" and self.currentGunPosition == (leftHanded and "LEFT" or "RIGHT") and (self.shouldShowWeaponInFirstPerson or mode =="THIRD_PERSON_LEFT_HAND" or mode == "THIRD_PERSON_RIGHT_HAND") then
                for _, gunItem in ipairs(self.gunItems) do
                    if item.id == gunItem then
                        if leftHanded then
                            if mode == "FIRST_PERSON_LEFT_HAND" then
                                local offsetPos = vectors.vec3()
                                if self.parent.characterData.gun.gunPosition.hold.firstPersonPos ~= nil and self.parent.characterData.gun.gunPosition.hold.firstPersonPos.left ~= nil then
                                    offsetPos = self.parent.characterData.gun.gunPosition.hold.firstPersonPos.left
                                end
                                local offsetRot = vectors.vec3()
                                if self.parent.characterData.gun.gunPosition.hold.firstPersonRot ~= nil and self.parent.characterData.gun.gunPosition.hold.firstPersonRot.left ~= nil then
                                    offsetRot = self.parent.characterData.gun.gunPosition.hold.firstPersonRot.left
                                end
                                local activeItemId = player:getActiveItem().id
                                local gameVersion = client:getVersion()
                                if activeItemId == "minecraft:bow" then
                                    models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -2.25, 4.25):add(offsetPos))
                                    models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(20, -7.5, -5):add(offsetRot))
                                elseif activeItemId == "minecraft:crossbow" then
                                    models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, 0.25, 4.25):add(offsetPos))
                                    models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                elseif item.id == "minecraft:crossbow" and ((gameVersion >= "1.20.5" and #item.tag["minecraft:charged_projectiles"] >= 1) or (gameVersion < "1.20.5" and item.tag.Charged == 1)) then
                                    if player:isLeftHanded() then
                                        models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(-10, -1.25, 6):add(offsetPos))
                                        models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 10, 0):add(offsetRot))
                                    else
                                        models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos))
                                        models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                    end
                                else
                                    models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos))
                                    models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                end
                            elseif mode == "THIRD_PERSON_LEFT_HAND" then
                                local offsetPos = vectors.vec3()
                                if self.parent.characterData.gun.gunPosition.hold.thirdPersonPos ~= nil and self.parent.characterData.gun.gunPosition.hold.thirdPersonPos.left ~= nil then
                                    offsetPos = self.parent.characterData.gun.gunPosition.hold.thirdPersonPos.left
                                end
                                local offsetRot = vectors.vec3()
                                if self.parent.characterData.gun.gunPosition.hold.thirdPersonRot ~= nil and self.parent.characterData.gun.gunPosition.hold.thirdPersonRot.left ~= nil then
                                    offsetRot = self.parent.characterData.gun.gunPosition.hold.thirdPersonRot.left
                                end
                                models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -4.25, 4.25):add(offsetPos))
                                models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                            end
                        else
                            if mode == "FIRST_PERSON_RIGHT_HAND" then
                                local offsetPos = vectors.vec3()
                                if self.parent.characterData.gun.gunPosition.hold.firstPersonPos ~= nil and self.parent.characterData.gun.gunPosition.hold.firstPersonPos.right ~= nil then
                                    offsetPos = self.parent.characterData.gun.gunPosition.hold.firstPersonPos.right
                                end
                                local offsetRot = vectors.vec3()
                                if self.parent.characterData.gun.gunPosition.hold.firstPersonRot ~= nil and self.parent.characterData.gun.gunPosition.hold.firstPersonRot.right ~= nil then
                                    offsetRot = self.parent.characterData.gun.gunPosition.hold.firstPersonRot.right
                                end
                                local activeItemId = player:getActiveItem().id
                                local gameVersion = client:getVersion()
                                if activeItemId == "minecraft:bow" then
                                    models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -2.25, 4.25):add(offsetPos))
                                    models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(20, 7.5, 5):add(offsetRot))
                                elseif activeItemId == "minecraft:crossbow" then
                                    models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, 0.25, 4.25):add(offsetPos))
                                    models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                elseif item.id == "minecraft:crossbow" and ((gameVersion >= "1.20.5" and #item.tag["minecraft:charged_projectiles"] >= 1) or (gameVersion < "1.20.5" and item.tag.Charged == 1)) then
                                    if player:isLeftHanded() then
                                        models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos))
                                        models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                    else
                                        models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(10, -1.25, 6):add(offsetPos))
                                        models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, -10, 0):add(offsetRot))
                                    end
                                else
                                    models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos))
                                    models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                end
                            elseif mode == "THIRD_PERSON_RIGHT_HAND" then
                                local offsetPos = vectors.vec3()
                                if self.parent.characterData.gun.gunPosition.hold.thirdPersonPos ~= nil and self.parent.characterData.gun.gunPosition.hold.thirdPersonPos.right ~= nil then
                                    offsetPos = self.parent.characterData.gun.gunPosition.hold.thirdPersonPos.right
                                end
                                local offsetRot = vectors.vec3()
                                if self.parent.characterData.gun.gunPosition.hold.thirdPersonRot ~= nil and self.parent.characterData.gun.gunPosition.hold.thirdPersonRot.right ~= nil then
                                    offsetRot = self.parent.characterData.gun.gunPosition.hold.thirdPersonRot.right
                                end
                                models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -4.25, 4.25):add(offsetPos))
                                models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                            end
                        end
                        return models.models.main.Avatar.UpperBody.Body.Gun
                    end
                end
            end
        end)

        models.models.main.Avatar.UpperBody.Body.Gun:setScale(vectors.vec3(1, 1, 1):scale(self.parent.characterData.gun.scale))
        self:setGunPosition("NONE")
        if self.parent.characterData.gun.callbacks ~= nil and self.parent.characterData.gun.callbacks.onMainHandChange ~= nil then
            self.parent.characterData.gun.callbacks.onMainHandChange(self.parent.characterData, self.isLeftHandedPrev and "LEFT" or "RIGHT")
        end
    end;

    ---背中の銃の位置・向きを設定する。
    ---@param self Gun
    setBodyGunPos = function (self)
        if models.models.main.Avatar.UpperBody.Body.Gun ~= nil then
            local offsetPos = vectors.vec3()
            local offsetRot = vectors.vec3()
            if player:isLeftHanded() then
                if self.parent.characterData.gun.gunPosition.put.pos ~= nil and self.parent.characterData.gun.gunPosition.put.pos.left ~= nil then
                    offsetPos = self.parent.characterData.gun.gunPosition.put.pos.left
                end
                if self.parent.characterData.gun.gunPosition.put.rot ~= nil and self.parent.characterData.gun.gunPosition.put.rot.left ~= nil then
                    offsetRot = self.parent.characterData.gun.gunPosition.put.rot.left
                end
            else
                if self.parent.characterData.gun.gunPosition.put.pos ~= nil and self.parent.characterData.gun.gunPosition.put.pos.right ~= nil then
                    offsetPos = self.parent.characterData.gun.gunPosition.put.pos.right
                end
                if self.parent.characterData.gun.gunPosition.put.rot ~= nil and self.parent.characterData.gun.gunPosition.put.rot.right ~= nil then
                    offsetRot = self.parent.characterData.gun.gunPosition.put.rot.right
                end
            end
            models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, 12, 0):add(offsetPos))
            models.models.main.Avatar.UpperBody.Body.Gun:setRot(offsetRot)
        end
    end;

    ---銃の位置を変更する。
    ---@param self Gun
    ---@param gunPosition Gun.GunPosition 変更先の構え位置
    setGunPosition = function (self, gunPosition)
        if gunPosition == "NONE" then
            for _, tickName in ipairs({"right_gun_tick", "left_gun_tick"}) do
                events.TICK:remove(tickName)
            end
            models.models.main.Avatar.UpperBody.Body.Gun:setParentType("None")
            models.models.main.Avatar.UpperBody.Body.Gun:setSecondaryRenderType("NONE")
            self.parent.arms:setArmState(0, 0)
            if self.parent.characterData.gun.gunPosition.put.type == "BODY" then
                self:setBodyGunPos()
            elseif self.parent.characterData.gun.gunPosition.put.type == "HIDDEN" then
                models.models.main.Avatar.UpperBody.Body.Gun:setVisible(false)
            end
        elseif gunPosition == "RIGHT" then
            events.TICK:remove("left_gun_tick")
            if events.TICK:getRegisteredCount("right_gun_tick") == 0 then
                events.TICK:register(function ()
                    local heldItem = player:getHeldItem(player:isLeftHanded())
                    local hasGlint = false
                    for _, gunItem in ipairs(self.gunItems) do
                        if gunItem == heldItem.id and heldItem:hasGlint() then
                            models.models.main.Avatar.UpperBody.Body.Gun:setSecondaryRenderType("GLINT"..(client:getVersion() == "1.21.4" and "2" or ""))
                            hasGlint = true
                            break
                        end
                    end
                    if not hasGlint then
                        models.models.main.Avatar.UpperBody.Body.Gun:setSecondaryRenderType("NONE")
                    end
                end, "right_gun_tick")
            end
            self.parent.arms:setArmState(1, 2)
            models.models.main.Avatar.UpperBody.Body.Gun:setVisible(true)
            models.models.main.Avatar.UpperBody.Body.Gun:setParentType("Item")
            if not client:isPaused() then
                sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:item.flintandsteel.use"), player:getPos(), 1, 2)
            end
        elseif gunPosition == "LEFT" then
            events.TICK:remove("right_gun_tick")
            if events.TICK:getRegisteredCount("left_gun_tick") == 0 then
                events.TICK:register(function ()
                    local heldItem = player:getHeldItem(not player:isLeftHanded())
                    local hasGlint = false
                    for _, gunItem in ipairs(self.gunItems) do
                        if gunItem == heldItem.id and heldItem:hasGlint() then
                            models.models.main.Avatar.UpperBody.Body.Gun:setSecondaryRenderType("GLINT"..(client:getVersion() == "1.21.4" and "2" or ""))
                            hasGlint = true
                            break
                        end
                    end
                    if not hasGlint then
                        models.models.main.Avatar.UpperBody.Body.Gun:setSecondaryRenderType("NONE")
                    end
                end, "left_gun_tick")
            end
            self.parent.arms:setArmState(2, 1)
            models.models.main.Avatar.UpperBody.Body.Gun:setVisible(true)
            models.models.main.Avatar.UpperBody.Body.Gun:setParentType("Item")
            if not client:isPaused() then
                sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:item.flintandsteel.use"), player:getPos(), 1, 2)
            end
        end
        self.currentGunPosition = gunPosition
    end;

    ---銃ティックを処理する。
    ---@param self Gun
    processGunTick = function (self)
        if not self.isGunTickProcessed then
            local heldItems = {}
            if player:getPose() ~= "SLEEPING" and self.parent.exSkill.animationCount == -1 then
                heldItems.mainHand = player:getHeldItem(false)
                heldItems.offHand = player:getHeldItem(true)
            else
                heldItems.mainHand = world.newItem(self.parent.compatibilityUtils:checkItem("minecraft:air"))
                heldItems.offHand = world.newItem(self.parent.compatibilityUtils:checkItem("minecraft:air"))
            end
            local targetItemFound = false
            local isLeftHanded = player:isLeftHanded()
            if heldItems.mainHand.id ~= self.heldItemsPrev.mainHand.id or heldItems.offHand.id ~= self.heldItemsPrev.offHand.id or isLeftHanded ~= self.isLeftHandedPrev then
                for _, gunItem in ipairs(self.gunItems) do
                    if heldItems.mainHand.id == gunItem then
                        --メインハンドに対象アイテムを持つ
                        targetItemFound = true
                        if isLeftHanded then
                            if self.currentGunPosition ~= "LEFT" then
                                self:setGunPosition("LEFT")
                            end
                        else
                            if self.currentGunPosition ~= "RIGHT" then
                                self:setGunPosition("RIGHT")
                            end
                        end
                        break
                    end
                end
                if not targetItemFound then
                    for _, gunItem in ipairs(self.gunItems) do
                        if heldItems.offHand.id == gunItem then
                            --オフハンドに対象アイテムを持つ
                            targetItemFound = true
                            if isLeftHanded then
                                if self.currentGunPosition ~= "RIGHT" then
                                    self:setGunPosition("RIGHT")
                                end
                            else
                                if self.currentGunPosition ~= "LEFT" then
                                    self:setGunPosition("LEFT")
                                end
                            end
                            break
                        end
                    end
                end
                if not targetItemFound then
                    --対象アイテムは持たない
                    if self.currentGunPosition ~= "NONE" then
                        self:setGunPosition("NONE")
                    end
                end
                if isLeftHanded ~= self.leftHandedPrev then
                    if self.currentGunPosition == "NONE" then
                        self:setBodyGunPos()
                    end
                    if self.parent.characterData.gun.callbacks ~= nil and self.parent.characterData.gun.callbacks.onMainHandChange ~= nil then
                        self.parent.characterData.gun.callbacks.onMainHandChange(self.parent.characterData, isLeftHanded and "LEFT" or "RIGHT")
                    end
                    self.isLeftHandedPrev = isLeftHanded
                end
                self.heldItemsPrev = heldItems
            end
            self.isGunTickProcessed = true
        end
    end;
}