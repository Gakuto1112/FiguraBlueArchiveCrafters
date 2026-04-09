---@alias Gun.GunPosition
---| "NONE" # 構えていない
---| "RIGHT" # 右手に構える
---| "LEFT" # 左手に構える

---@alias Gun.HandDirection
---| "RIGHT" # 右手
---| "LEFT" # 左手

---@class (exact) Gun.HeldItemSet 手持ちアイテムを示すデータセット
---@field public mainHand ItemStack メインハンド
---@field public offHand ItemStack オフハンド

---@class (exact) Gun 生徒の銃を制御するクラス
---@field public GUN_ITEMS Minecraft.itemID[] 銃のモデルを適用するアイテムの配列
---@field public currentGunPosition Gun.GunPosition 現在の銃の位置
---@field package heldItemsPrev Gun.HeldItemSet 前ティックの手持ちアイテム
---@field package isLeftHandedPrev boolean 前ティックに左利きだったかどうか
---@field package isGunTickProcessed boolean このティック内で銃ティックを処理したかどうか
local Gun = {
	GUN_ITEMS = {"minecraft:bow", "minecraft:crossbow"};

	currentGunPosition = "NONE";
	heldItemsPrev = {
		mainHand = world.newItem("minecraft:air");
		offHand = world.newItem("minecraft:air");
	};
	isLeftHandedPrev = false;
	isGunTickProcessed = false;

    ---初期化関数
    ---@param self Gun
    init = function (self)
        self.isLeftHandedPrev = player:isLeftHanded();

        ModelAlias.alias.avatar.gun:setScale(vectors.vec3(1, 1, 1):scale(BlueArchiveCharacter.gun.scale))
        self:setGunPosition("NONE")
        if BlueArchiveCharacter.gun.callbacks ~= nil and BlueArchiveCharacter.gun.callbacks.onMainHandChange ~= nil then
            BlueArchiveCharacter.gun.callbacks.onMainHandChange(BlueArchiveCharacter, self.isLeftHandedPrev and "LEFT" or "RIGHT")
        end

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
                        sounds:playSound("minecraft:block.dispenser.fail", pos, 1, 2)
                    elseif player:isUnderwater() then
                        sounds:playSound("minecraft:entity.generic.extinguish_fire", pos, 0.5, 1.5)
                    else
                        local particleAnchor = ModelUtils.getModelWorldPos(renderer:isFirstPerson() and (self.currentGunPosition == "RIGHT" and ModelAlias.alias.avatar.rightItemPivot or ModelAlias.alias.avatar.leftItemPivot) or ModelAlias.alias.avatar.muzzleAnchor)
                        for _ = 1, 5 do
                            particles:newParticle("minecraft:smoke", particleAnchor)
                        end
                        sounds:playSound(BlueArchiveCharacter.gun.sound.name, pos, 1, BlueArchiveCharacter.gun.sound.pitch)
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
                        sounds:playSound("minecraft:item.flintandsteel.use", pos, 1, 2)
                        return true
                    elseif id == "minecraft:item.crossbow.loading_middle" then
                        return true
                    end
                end
            end
        end)

        events.ITEM_RENDER:register(function (item, mode, _, _, _, leftHanded)
            self = this
            if mode ~= "HEAD" and self.currentGunPosition == (leftHanded and "LEFT" or "RIGHT") then
                for _, gunItem in ipairs(self.GUN_ITEMS) do
                    if item.id == gunItem then
                        if leftHanded then
                            if mode == "FIRST_PERSON_LEFT_HAND" then
                                local offsetPos = vectors.vec3()
                                if BlueArchiveCharacter.gun.gunPosition.hold.firstPersonPos ~= nil and BlueArchiveCharacter.gun.gunPosition.hold.firstPersonPos.left ~= nil then
                                    offsetPos = BlueArchiveCharacter.gun.gunPosition.hold.firstPersonPos.left
                                end
                                local offsetRot = vectors.vec3()
                                if BlueArchiveCharacter.gun.gunPosition.hold.firstPersonRot ~= nil and BlueArchiveCharacter.gun.gunPosition.hold.firstPersonRot.left ~= nil then
                                    offsetRot = BlueArchiveCharacter.gun.gunPosition.hold.firstPersonRot.left
                                end
                                local activeItemId = player:getActiveItem().id
                                local gameVersion = client:getVersion()
                                if activeItemId == "minecraft:bow" then
                                    ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, -2.25, 4.25):add(offsetPos))
                                    ModelAlias.alias.avatar.gun:setRot(vectors.vec3(20, -7.5, -5):add(offsetRot))
                                elseif activeItemId == "minecraft:crossbow" then
                                    ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 0.25, 4.25):add(offsetPos))
                                    ModelAlias.alias.avatar.gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                elseif item.id == "minecraft:crossbow" and ((gameVersion >= "1.20.5" and #item.tag["minecraft:charged_projectiles"] >= 1) or (gameVersion < "1.20.5" and item.tag.Charged == 1)) then
                                    if player:isLeftHanded() then
                                        ModelAlias.alias.avatar.gun:setPos(vectors.vec3(-10, -1.25, 6):add(offsetPos))
                                        ModelAlias.alias.avatar.gun:setRot(vectors.vec3(0, 10, 0):add(offsetRot))
                                    else
                                        ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos))
                                        ModelAlias.alias.avatar.gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                    end
                                else
                                    ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos))
                                    ModelAlias.alias.avatar.gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                end
                            elseif mode == "THIRD_PERSON_LEFT_HAND" then
                                local offsetPos = vectors.vec3()
                                if BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonPos ~= nil and BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonPos.left ~= nil then
                                    offsetPos = BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonPos.left
                                end
                                local offsetRot = vectors.vec3()
                                if BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonRot ~= nil and BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonRot.left ~= nil then
                                    offsetRot = BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonRot.left
                                end
                                ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, -4.25, 4.25):add(offsetPos))
                                ModelAlias.alias.avatar.gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                            end
                        else
                            if mode == "FIRST_PERSON_RIGHT_HAND" then
                                local offsetPos = vectors.vec3()
                                if BlueArchiveCharacter.gun.gunPosition.hold.firstPersonPos ~= nil and BlueArchiveCharacter.gun.gunPosition.hold.firstPersonPos.right ~= nil then
                                    offsetPos = BlueArchiveCharacter.gun.gunPosition.hold.firstPersonPos.right
                                end
                                local offsetRot = vectors.vec3()
                                if BlueArchiveCharacter.gun.gunPosition.hold.firstPersonRot ~= nil and BlueArchiveCharacter.gun.gunPosition.hold.firstPersonRot.right ~= nil then
                                    offsetRot = BlueArchiveCharacter.gun.gunPosition.hold.firstPersonRot.right
                                end
                                local activeItemId = player:getActiveItem().id
                                local gameVersion = client:getVersion()
                                if activeItemId == "minecraft:bow" then
                                    ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, -2.25, 4.25):add(offsetPos))
                                    ModelAlias.alias.avatar.gun:setRot(vectors.vec3(20, 7.5, 5):add(offsetRot))
                                elseif activeItemId == "minecraft:crossbow" then
                                    ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 0.25, 4.25):add(offsetPos))
                                    ModelAlias.alias.avatar.gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                elseif item.id == "minecraft:crossbow" and ((gameVersion >= "1.20.5" and #item.tag["minecraft:charged_projectiles"] >= 1) or (gameVersion < "1.20.5" and item.tag.Charged == 1)) then
                                    if player:isLeftHanded() then
                                        ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos))
                                        ModelAlias.alias.avatar.gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                    else
                                        ModelAlias.alias.avatar.gun:setPos(vectors.vec3(10, -1.25, 6):add(offsetPos))
                                        ModelAlias.alias.avatar.gun:setRot(vectors.vec3(0, -10, 0):add(offsetRot))
                                    end
                                else
                                    ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos))
                                    ModelAlias.alias.avatar.gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                end
                            elseif mode == "THIRD_PERSON_RIGHT_HAND" then
                                local offsetPos = vectors.vec3()
                                if BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonPos ~= nil and BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonPos.right ~= nil then
                                    offsetPos = BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonPos.right
                                end
                                local offsetRot = vectors.vec3()
                                if BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonRot ~= nil and BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonRot.right ~= nil then
                                    offsetRot = BlueArchiveCharacter.gun.gunPosition.hold.thirdPersonRot.right
                                end
                                ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, -4.25, 4.25):add(offsetPos))
                                ModelAlias.alias.avatar.gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                            end
                        end
                        return ModelAlias.alias.avatar.gun
                    end
                end
            end
        end)
    end;

    ---背中の銃の位置・向きを設定する。
    ---@param self Gun
    setBodyGunPos = function (self)
        if ModelAlias.alias.avatar.gun ~= nil then
            local offsetPos = vectors.vec3()
            local offsetRot = vectors.vec3()
            if player:isLeftHanded() then
                if BlueArchiveCharacter.gun.gunPosition.put.pos ~= nil and BlueArchiveCharacter.gun.gunPosition.put.pos.left ~= nil then
                    offsetPos = BlueArchiveCharacter.gun.gunPosition.put.pos.left
                end
                if BlueArchiveCharacter.gun.gunPosition.put.rot ~= nil and BlueArchiveCharacter.gun.gunPosition.put.rot.left ~= nil then
                    offsetRot = BlueArchiveCharacter.gun.gunPosition.put.rot.left
                end
            else
                if BlueArchiveCharacter.gun.gunPosition.put.pos ~= nil and BlueArchiveCharacter.gun.gunPosition.put.pos.right ~= nil then
                    offsetPos = BlueArchiveCharacter.gun.gunPosition.put.pos.right
                end
                if BlueArchiveCharacter.gun.gunPosition.put.rot ~= nil and BlueArchiveCharacter.gun.gunPosition.put.rot.right ~= nil then
                    offsetRot = BlueArchiveCharacter.gun.gunPosition.put.rot.right
                end
            end
            ModelAlias.alias.avatar.gun:setPos(vectors.vec3(0, 12, 0):add(offsetPos))
            ModelAlias.alias.avatar.gun:setRot(offsetRot)
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
            ModelAlias.alias.avatar.gun:setParentType("None")
            ModelAlias.alias.avatar.gun:setSecondaryRenderType("NONE")
            Arms:setArmState("DEFAULT", "DEFAULT")
            if BlueArchiveCharacter.gun.gunPosition.put.type == "BODY" then
                self:setBodyGunPos()
            elseif BlueArchiveCharacter.gun.gunPosition.put.type == "HIDDEN" then
                ModelAlias.alias.avatar.gun:setVisible(false)
            end
        elseif gunPosition == "RIGHT" then
            events.TICK:remove("left_gun_tick")
            if events.TICK:getRegisteredCount("right_gun_tick") == 0 then
                events.TICK:register(function ()
                    local heldItem = player:getHeldItem(player:isLeftHanded())
                    local hasGlint = false
                    for _, gunItem in ipairs(self.GUN_ITEMS) do
                        if gunItem == heldItem.id and heldItem:hasGlint() then
                            ModelAlias.alias.avatar.gun:setSecondaryRenderType("GLINT"..(client:getVersion() == "1.21.4" and "2" or ""))
                            hasGlint = true
                            break
                        end
                    end
                    if not hasGlint then
                        ModelAlias.alias.avatar.gun:setSecondaryRenderType("NONE")
                    end
                end, "right_gun_tick")
            end
            Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
            ModelAlias.alias.avatar.gun:setVisible(true)
            ModelAlias.alias.avatar.gun:setParentType("Item")
            if not client:isPaused() then
                sounds:playSound("minecraft:item.flintandsteel.use", player:getPos(), 1, 2)
            end
        elseif gunPosition == "LEFT" then
            events.TICK:remove("right_gun_tick")
            if events.TICK:getRegisteredCount("left_gun_tick") == 0 then
                events.TICK:register(function ()
                    local heldItem = player:getHeldItem(not player:isLeftHanded())
                    local hasGlint = false
                    for _, gunItem in ipairs(self.GUN_ITEMS) do
                        if gunItem == heldItem.id and heldItem:hasGlint() then
                            ModelAlias.alias.avatar.gun:setSecondaryRenderType("GLINT"..(client:getVersion() == "1.21.4" and "2" or ""))
                            hasGlint = true
                            break
                        end
                    end
                    if not hasGlint then
                        ModelAlias.alias.avatar.gun:setSecondaryRenderType("NONE")
                    end
                end, "left_gun_tick")
            end
            Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
            ModelAlias.alias.avatar.gun:setVisible(true)
            ModelAlias.alias.avatar.gun:setParentType("Item")
            if not client:isPaused() then
                sounds:playSound("minecraft:item.flintandsteel.use", player:getPos(), 1, 2)
            end
        end
        self.currentGunPosition = gunPosition
    end;

    ---銃ティックを処理する。
    ---@param self Gun
    processGunTick = function (self)
        if not self.isGunTickProcessed then
            local heldItems = {}
            if player:getPose() ~= "SLEEPING" and ExSkill.animationCount == -1 then
                heldItems.mainHand = player:getHeldItem(false)
                heldItems.offHand = player:getHeldItem(true)
            else
                heldItems.mainHand = world.newItem("minecraft:air")
                heldItems.offHand = world.newItem("minecraft:air")
            end
            local targetItemFound = false
            local isLeftHanded = player:isLeftHanded()
            if heldItems.mainHand.id ~= self.heldItemsPrev.mainHand.id or heldItems.offHand.id ~= self.heldItemsPrev.offHand.id or isLeftHanded ~= self.isLeftHandedPrev then
                for _, gunItem in ipairs(self.GUN_ITEMS) do
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
                    for _, gunItem in ipairs(self.GUN_ITEMS) do
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
                    if BlueArchiveCharacter.gun.callbacks ~= nil and BlueArchiveCharacter.gun.callbacks.onMainHandChange ~= nil then
                        BlueArchiveCharacter.gun.callbacks.onMainHandChange(BlueArchiveCharacter, isLeftHanded and "LEFT" or "RIGHT")
                    end
                    self.isLeftHandedPrev = isLeftHanded
                end
                self.heldItemsPrev = heldItems
            end
            self.isGunTickProcessed = true
        end
    end;
}

return Gun
