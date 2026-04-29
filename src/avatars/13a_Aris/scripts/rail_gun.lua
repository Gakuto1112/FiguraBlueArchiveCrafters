---@alias RailGun.ChargeState
---| "NONE" # チャージなし
---| "WEAK" # 弱いチャージ（通常の射出時）
---| "STRONG" # 強いチャージ（Exスキル再生直後の射出時）

---@class (exact) RailGun アリスの武器を制御するクラス
---@field public chargeState RailGun.ChargeState 武器のチャージ状態
---@field public isSpecialCharge boolean オーバーチャージ状態かどうか
---@field public animationLength integer アニメーションの長さ
---@field public chargePercent number レールガンのチャージ割合（"WEAK"の場合は100%まで、"STRING"の場合は200%まで）
---@field package currentRot number[] レールガン回転パーツの現在の角度：1. マズル1, 2. マズル2, 3. マズル3, 4. エネルギー発生部
---@field package nextRot number[] レールガン回転パーツの次ティックの角度：1. マズル1, 2. マズル2, 3. マズル3, 4. エネルギー発生部
---@field package isChargeSoundPlayed boolean エネルギーチャージ音を再生したかどうか
---@field package fullChargeSound Sound|nil エネルギーフルチャージ時の音のオブジェクト
---@field package gunPositionPrev Gun.GunPosition 前ティックの銃の持ち位置
local RailGun = {
    chargeState = "NONE";
    isSpecialCharge = false;
    animationLength = 0;
    chargePercent = 0;
    currentRot = {0, 0, 0, 0};
    nextRot = {0, 0, 0, 0};
    isChargeSoundPlayed = false;
    fullChargeSound = nil;
    gunPositionPrev = "NONE";

    ---初期化関数
    init = function ()
        --ディスプレイのスプライトを配置
        local displayParent = ModelAlias.alias.avatar.gun:newPart("DisplayContents")
        displayParent:setVisible(false)
        for i = 1, 3 do
            local displayRDigit = displayParent:newSprite("displayR_digit_"..i)
            displayRDigit:setTexture(textures["textures.gun"])
            displayRDigit:setDimensions(textures["textures.gun"]:getDimensions())
            displayRDigit:setRegion(3, 5)
            displayRDigit:setPos(1.51, -0.55, 7.55 + (i - 1) * -0.215)
            displayRDigit:setRot(0, -90, 0)
            displayRDigit:setScale(0.06, 0.06, 1)
            displayRDigit:setSize(3, 5)
            displayRDigit:setRenderType("EMISSIVE_SOLID")
            local displayRArrow = displayParent:newSprite("displayR_arrow_"..i)
            displayRArrow:setTexture(textures["textures.gun"])
            displayRArrow:setDimensions(textures["textures.gun"]:getDimensions())
            displayRArrow:setRegion(3, 3)
            displayRArrow:setPos(1.51, -0.3, 7.55 + (i - 1) * -0.125)
            displayRArrow:setRot(0, -90, 0)
            displayRArrow:setScale(0.03, 0.03, 1)
            displayRArrow:setSize(3, 3)
            displayRArrow:setRenderType("EMISSIVE_SOLID")
            local displayLDigit = displayParent:newSprite("displayL_digit_"..i)
            displayLDigit:setTexture(textures["textures.gun"])
            displayLDigit:setDimensions(textures["textures.gun"]:getDimensions())
            displayLDigit:setRegion(3, 5)
            displayLDigit:setPos(-1.51, -0.55, 6.225 + (i - 1) * 0.225)
            displayLDigit:setRot(0, 90, 0)
            displayLDigit:setScale(0.06, 0.06, 1)
            displayLDigit:setSize(3, 5)
            displayLDigit:setRenderType("EMISSIVE_SOLID")
            local displayLArrow = displayParent:newSprite("displayL_arrow_"..i)
            displayLArrow:setTexture(textures["textures.gun"])
            displayLArrow:setDimensions(textures["textures.gun"]:getDimensions())
            displayLArrow:setRegion(3, 3)
            displayLArrow:setPos(-1.51, -0.3, 6.6 + (i - 1) * 0.125)
            displayLArrow:setRot(0, 90, 0)
            displayLArrow:setScale(0.03, 0.03, 1)
            displayLArrow:setSize(3, 3)
            displayLArrow:setRenderType("EMISSIVE_SOLID")
        end
        local displayRMeter = displayParent:newSprite("displayR_meter")
        displayRMeter:setTexture(textures["textures.gun"])
        displayRMeter:setDimensions(textures["textures.gun"]:getDimensions())
        displayRMeter:setRegion(11, 5)
        displayRMeter:setPos(1.51, -0.55, 6.9)
        displayRMeter:setRot(0, -90, 0)
        displayRMeter:setScale(0.06, 0.06, 1)
        displayRMeter:setSize(11, 5)
        displayRMeter:setRenderType("EMISSIVE_SOLID")
        local displayLMeter = displayParent:newSprite("displayL_meter")
        displayLMeter:setTexture(textures["textures.gun"])
        displayLMeter:setDimensions(textures["textures.gun"]:getDimensions())
        displayLMeter:setRegion(11, 5)
        displayLMeter:setPos(-1.51, -0.55, 6.9)
        displayLMeter:setRot(0, 90, 0)
        displayLMeter:setScale(0.06, 0.06, 1)
        displayLMeter:setSize(11, 5)
        displayLMeter:setRenderType("EMISSIVE_SOLID")
    end;

    ---レールガンのスクリプト機能を有効にする。
    ---@param self RailGun
    enable = function (self)
        if events.TICK:getRegisteredCount("rail_gun_tick") == 0 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    if Gun.currentGunPosition ~= self.gunPositionPrev then
                        if Gun.currentGunPosition == "RIGHT" or Gun.currentGunPosition == "LEFT" then
                            --レールガンを持ったとき
                            ModelAlias.alias.avatar.gun.DisplayContents:setVisible(true)
                        elseif ExSkill.animationCount == -1 then
                            --レールガンをしまったとき
                            ModelAlias.alias.avatar.gun.DisplayContents:setVisible(false)
                        end
                        self.gunPositionPrev = Gun.currentGunPosition
                    end

                    --弦引きの検出
                    local activeItem = player:getActiveItem()
                    local isLeftHanded = player:isLeftHanded()
                    local heldItems = {player:getHeldItem(isLeftHanded), player:getHeldItem(not isLeftHanded)}
                    local gameVersion = client:getVersion()
                    local isNewerNbt = StringUtils.compareVersions(gameVersion, "1.20.5") == gameVersion
                    local hasChargedCrossbow = (heldItems[1].id == "minecraft:crossbow" and ((isNewerNbt and #heldItems[1].tag["minecraft:charged_projectiles"] >= 1) or (not isNewerNbt < "1.20.5" and heldItems[1].tag.Charged == 1)) and Gun.currentGunPosition == "RIGHT") or (heldItems[2].id == "minecraft:crossbow" and ((gameVersion >= "1.20.5" and #heldItems[2].tag["minecraft:charged_projectiles"] >= 1) or (gameVersion < "1.20.5" and heldItems[2].tag.Charged == 1)) and Gun.currentGunPosition == "LEFT")
                    if (activeItem.id == "minecraft:bow" or activeItem.id == "minecraft:crossbow") and self.chargeState == "NONE" then
                        --チャージ開始
                        self.chargeState = self.isSpecialCharge and "STRONG" or "WEAK"
                        if activeItem.id == "minecraft:bow" then
                            self.animationLength = 20
                        else
                            local quickChargeLevel = 0
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
                            self.animationLength = quickChargeLevel <= 5 and 25 - quickChargeLevel * 5 or math.huge
                        end
                    elseif hasChargedCrossbow and self.chargeState == "NONE" then
                        self.chargeState = self.isSpecialCharge and "STRONG" or "WEAK"
                        self.animationLength = 0
                    elseif activeItem.id ~= "minecraft:bow" and activeItem.id ~= "minecraft:crossbow" and not hasChargedCrossbow and (self.chargeState == "WEAK" or self.chargeState == "STRONG") and ExSkill.animationCount == -1 then
                        --チャージ終了
                        self.chargeState = "NONE"
                        self.animationLength = 0
                    end

                    --レールガンのアニメーション制御
                    for i = 1, 4 do
                        self.currentRot[i] = self.nextRot[i]
                    end
                    self.nextRot[1] = self.currentRot[1] + math.max(self.chargePercent - 1.75, 0) * 640
                    self.nextRot[2] = self.currentRot[2] + math.max(self.chargePercent - 1.5, 0) * 320
                    self.nextRot[3] = self.currentRot[3] + math.max(self.chargePercent - 1.25, 0) * 213
                    self.nextRot[4] = self.currentRot[4] + self.chargePercent * 80

                    if self.chargeState == "WEAK" and self.chargePercent <= 1 then
                        self.chargePercent = math.min(self.chargePercent + 20 / self.animationLength * 0.05, 1)
                    elseif self.chargeState == "STRONG" then
                        self.chargePercent = math.min(self.chargePercent + 20 / self.animationLength * 0.1, 2)
                    else
                        if Gun.currentGunPosition == "NONE" then
                            self.chargePercent = 0
                        else
                            self.chargePercent = math.max(self.chargePercent - 0.05, 0)
                        end
                    end

                    --ディスプレイの表示
                    if Gun.currentGunPosition ~= "NONE" or ExSkill.animationCount >= 0 then
                        for _, spriteName in ipairs({"displayR_meter", "displayL_meter"}) do
                            ModelAlias.alias.avatar.gun.DisplayContents:getTask(spriteName):setUVPixels(69, math.floor(self.chargePercent * 6) * 5)
                        end
                        for _, spriteName in ipairs({"displayR_arrow_1", "displayL_arrow_1"}) do
                            ModelAlias.alias.avatar.gun.DisplayContents:getTask(spriteName):setUVPixels(63, self.chargePercent >= 1.25 and 3 or 0)
                        end
                        for _, spriteName in ipairs({"displayR_arrow_2", "displayL_arrow_2"}) do
                            ModelAlias.alias.avatar.gun.DisplayContents:getTask(spriteName):setUVPixels(63, self.chargePercent >= 1.75 and 3 or 0)
                        end
                        for _, spriteName in ipairs({"displayR_arrow_3", "displayL_arrow_3"}) do
                            ModelAlias.alias.avatar.gun.DisplayContents:getTask(spriteName):setUVPixels(63, self.chargePercent >= 2 and 3 or 0)
                        end
                    end

                    --パーティクルによる演出
                    local isFirstPerson = renderer:isFirstPerson()
                    if self.chargePercent >= 1.25 and (not isFirstPerson or Gun.shouldShowWeaponInFirstPerson) then
                        local gunPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun)
                        local axisX = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.GunX):sub(gunPos):normalize()
                        local axisY = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.GunY):sub(gunPos):normalize()
                        local axisZ = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.GunZ):sub(gunPos):normalize()
                        local lookDir = player:getLookDir()
                        local lookYaw = math.deg(math.atan2(lookDir.z, lookDir.x)) * -1 + 90
                        local lookPitch = math.deg(math.asin(lookDir.y)) * -1
                        local playerAnchor = player:getPos():add(0, player:getEyeHeight(), 0)
                        local anchorPos2 = isFirstPerson and playerAnchor:copy():add(vectors.rotateAroundAxis(lookYaw, vectors.rotateAroundAxis(lookPitch, Gun.currentGunPosition == "RIGHT" and -0.04 or 0.35, -0.3, 0.2, 1, 0, 0), 0, 1, 0)) or ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.ParticleAnchor1)
                        for _ = 1, 4 do
                            local plane = math.random(1, 4)
                            local sparkParticle = particles:newParticle("minecraft:electric_spark", 0, 0, 0):setScale(isFirstPerson and 0.1 or 0.5):setColor(0.624, 0.996, 1):setLifetime(1)
                            if plane <= 2 then
                                sparkParticle:setPos(anchorPos2:copy():add(isFirstPerson and vectors.rotateAroundAxis(lookYaw, vectors.rotateAroundAxis(lookPitch, math.random() * -0.3, plane == 2 and 0.3 or 0, math.random() * -0.15, 1, 0, 0), 0, 1, 0) or axisX:copy():scale(math.random() * -0.5):add(axisZ:copy():scale(math.random() * -1.125)):add(0, plane == 2 and 1.125 or 0, 0)))
                            else
                                sparkParticle:setPos(anchorPos2:copy():add(isFirstPerson and vectors.rotateAroundAxis(lookYaw, vectors.rotateAroundAxis(lookPitch, plane == 4 and -0.3 or 0, math.random() * 0.30, math.random() * -0.15, 1, 0, 0), 0, 1, 0) or axisX:copy():scale(plane == 4 and -0.5 or 0):add(axisZ:copy():scale(math.random() * -1.125)):add(0, math.random() * 1.125, 0)))
                            end
                        end
                        for i = 0, 1 do
                            particles:newParticle("minecraft:electric_spark", isFirstPerson and playerAnchor:copy():add(vectors.rotateAroundAxis(lookYaw, vectors.rotateAroundAxis(lookPitch, Gun.currentGunPosition == "RIGHT" and -0.35 or 0.35, -0.2, 0.25 + i * 0.05, 1, 0, 0), 0, 1, 0)) or ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.Engine):add(axisZ:copy():scale(0.18 * i - 0.09))):setScale(0.25):setVelocity(vectors.rotateAroundAxis(math.random() * 360, axisY:copy():scale(0.1), axisZ)):setColor(0.996, 0.859, 0.365):setLifetime(math.random(2, 4))
                        end

                        local offsetPos = isFirstPerson and vectors.rotateAroundAxis(lookYaw, vectors.rotateAroundAxis(lookPitch, math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 1, 1, 0, 0), 0, 1, 0) or axisX:copy():scale(math.random() * 2 - 1):add(axisY:copy():scale(math.random() * 2 - 1)):add(axisZ:copy():scale(math.random() * 1))
                        particles:newParticle("minecraft:firework", isFirstPerson and playerAnchor:copy():add(vectors.rotateAroundAxis(lookYaw, vectors.rotateAroundAxis(lookPitch, Gun.currentGunPosition == "RIGHT" and -0.35 or 0.35, -0.2, 0.75, 1, 0, 0), 0, 1, 0)):add(offsetPos) or ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.MuzzleAnchor):copy():add(offsetPos)):setScale(0.1):setVelocity(offsetPos:copy():scale(-0.1)):setGravity(0):setLifetime(8)
                    end

                    --音の演出
                    if self.chargePercent >= 1.25 and not self.isChargeSoundPlayed then
                        local avatarPos = player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, ModelAlias.alias.avatar.root:getAnimPos():mul(-1, 0, -1):scale(0.05859375), 0, 1, 0))
                        sounds:playSound("minecraft:block.beacon.activate", avatarPos, 1, 2)
                        self.fullChargeSound = sounds:playSound("minecraft:block.beacon.ambient", avatarPos, 1, 2, true)
                        self.isChargeSoundPlayed = true
                    elseif self.chargePercent < 1.25 then
                        self.isChargeSoundPlayed = false
                        if self.fullChargeSound ~= nil then
                            self.fullChargeSound:stop()
                            self.fullChargeSound = nil
                        end
                    end
                    if self.fullChargeSound ~= nil then
                        self.fullChargeSound:setPos(player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, ModelAlias.alias.avatar.root:getAnimPos():mul(-1, 0, -1):scale(0.05859375), 0, 1, 0)))
                    end
                end
            end, "rail_gun_tick")

            events.RENDER:register(function (delta)
                if not client:isPaused() then
                    --回転部の回転
                    for i = 1, 3 do
                        ModelAlias.alias.avatar.gun["Muzzle"..i]:setRot(0, 0, self.currentRot[i] + (self.nextRot[i] - self.currentRot[i]) * delta)
                    end
                    ModelAlias.alias.avatar.gun.Engine:setRot(0, 0, self.currentRot[4] + (self.nextRot[4] - self.currentRot[4]) * delta)

                    --デルタ値を考慮したチャージパーセントの計算
                    local truePercent = 0
                    if self.chargeState == "WEAK" and self.chargePercent <= 1 then
                        truePercent = math.min(self.chargePercent + 20 / self.animationLength * 0.05 * delta, 1)
                    elseif self.chargeState == "STRONG" then
                        truePercent = math.min(self.chargePercent + 20 / self.animationLength * 0.1 * delta, 2)
                    else
                        truePercent = math.max(self.chargePercent - 0.05 * delta, 0)
                    end

                    --殻が開くギミック
                    ModelAlias.alias.avatar.gun.UpperOuter1:setPos(0, math.clamp(truePercent * 4 - 4, 0, 0.5), 0)
                    ModelAlias.alias.avatar.gun.LowerOuter1:setPos(0, math.clamp(truePercent * -4 + 4, -0.5, 0), 0)
                    ModelAlias.alias.avatar.gun.UpperOuter1.UpperOuter2:setPos(0, math.clamp(truePercent * 4 - 6.5, 0, 0.5), 0)
                    ModelAlias.alias.avatar.gun.LowerOuter1.LowerOuter2:setPos(0, math.clamp(truePercent * -4 + 6.5, -0.5, 0), 0)
                    ModelAlias.alias.avatar.gun.UpperOuter1.UpperOuter2.UpperOuter3:setPos(0, math.clamp(truePercent * 4 - 7.5, 0, 0.5), 0)
                    ModelAlias.alias.avatar.gun.LowerOuter1.LowerOuter2.LowerOuter3:setPos(0, math.clamp(truePercent * -4 + 7.5, -0.5, 0), 0)

                    --マズルチャージ
                    ModelAlias.alias.avatar.gun.Muzzle1.Muzzle1Emissives.Muzzle1Emissive1:setColor(truePercent <= 1.75 and (vectors.vec3(0.004, 0.929, 1) * math.min(truePercent, 1)) or (vectors.vec3(0.004, 0.929, 1) + vectors.vec3(0.988, -0.011, -0.004) * (truePercent - 1.75) * 4))
                    ModelAlias.alias.avatar.gun.Muzzle1.Muzzle1Emissives.Muzzle1Emissive2:setColor(truePercent <= 1 and (vectors.vec3(0.004, 0.929, 1) * truePercent) or (vectors.vec3(0.004, 0.929, 1) + vectors.vec3(0.988, -0.011, -0.004) * (truePercent - 1)))
                    ModelAlias.alias.avatar.gun.Muzzle2.Muzzle2Emissives:setColor(truePercent <= 1.5 and (vectors.vec3(0.004, 0.929, 1) * math.min(truePercent, 1)) or (vectors.vec3(0.004, 0.929, 1) + vectors.vec3(0.988, -0.011, -0.004) * math.min(truePercent - 1.5, 0.5) * 2))
                    ModelAlias.alias.avatar.gun.Muzzle3.Muzzle3Emissives:setColor(truePercent <= 1.25 and (vectors.vec3(0.004, 0.929, 1) * math.min(truePercent, 1)) or (vectors.vec3(0.004, 0.929, 1) + vectors.vec3(0.988, -0.011, -0.004) * math.min(truePercent - 1.25, 0.75) * 1.3333))
                    ModelAlias.alias.avatar.gun.GunBodyEmissive1:setUVPixels(0, truePercent * 18 + 0)
                    ModelAlias.alias.avatar.gun.GunBodyEmissive2:setUVPixels( math.floor(math.max(truePercent - 1, 0) * 6) * 2, 0)

                    --ディスプレイの表示
                    if Gun.currentGunPosition ~= "NONE" or ExSkill.animationCount >= 0 then
                        local digits = {math.floor(truePercent) % 10, math.floor(truePercent * 10) % 10, math.floor(truePercent * 100) % 10}
                        for _, spriteName in ipairs({"displayR_digit_", "displayL_digit_"}) do
                            for i = 1, 3 do
                                ModelAlias.alias.avatar.gun.DisplayContents:getTask(spriteName..i):setUVPixels((digits[i] % 5) * 3 + 80, math.floor(digits[i] / 5) * 5)
                            end
                        end
                    end
                end
            end, "rail_gun_render")

            local this = self --Figuraにスクリプトを再構築させると参照がおかしくなることに対処しているコード
            events.ON_PLAY_SOUND:register(function (id, pos, _, pitch, _, _, path)
                self = this
                if id == BlueArchiveCharacter.gun.sound.name and pitch == BlueArchiveCharacter.gun.sound.pitch and path == nil and math.abs(pos:copy():sub(player:getPos()):length() - player:getVelocity():length()) < 1.2 and self.chargePercent >= 1.95 and not client:isPaused() then
                    sounds:playSound("minecraft:entity.blaze.death", player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, 0, 0.5, 0, 1, 0)), 1, 2)
                    local gunPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun)
                    local axisX = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.GunX):sub(gunPos):normalize()
                    local axisY = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.GunY):sub(gunPos):normalize()
                    local axisZ = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.GunZ):sub(gunPos):normalize()
                    local lookDir = player:getLookDir()
                    local lookYaw = math.deg(math.atan2(lookDir.z, lookDir.x)) * -1 + 90
                    local isFirstPerson = renderer:isFirstPerson()
                    local anchorPos = isFirstPerson and player:getPos():add(vectors.rotateAroundAxis(lookYaw, Gun.currentGunPosition == "RIGHT" and -1 or 1, 1, 0, 0, 1, 0)) or ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.gun.MuzzleAnchor)
                    local lookPitch = math.deg(math.asin(lookDir.y)) * -1
                    for _ = 1, 50 do
                        particles:newParticle("minecraft:firework", anchorPos):setVelocity(isFirstPerson and vectors.rotateAroundAxis(lookYaw, vectors.rotateAroundAxis(lookPitch, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, math.random() * 2, 1, 0, 0), 0, 1, 0) or axisX:copy():scale(math.random() * 0.25 - 0.125):add(axisY:copy():scale(math.random() * 0.25 - 0.125)):add(axisZ:copy():scale(math.random() * 2))):setScale(3):setGravity(0):setLifetime(20)
                    end
                    self.isSpecialCharge = false
                end
            end, "rail_gun_sound")
        end
    end;

    ---レールガンのスクリプト機能を無効にする。
    ---@param self RailGun
    disable = function (self)
        events.TICK:remove("rail_gun_tick")
        events.RENDER:remove("rail_gun_render")
        events.ON_PLAY_SOUND:remove("rail_gun_sound")
        self.chargeState = "NONE"
        self.isSpecialCharge = false
        self.animationLength = 0
        self.chargePercent = 0
        self.currentRot = {0, 0, 0, 0}
        self.nextRot = {0, 0, 0, 0}
        self.isChargeSoundPlayed = false
        if self.fullChargeSound ~= nil then
            self.fullChargeSound:stop()
            self.fullChargeSound = nil
        end
        self.gunPositionPrev = "NONE"
    end;
}

return RailGun
