---@class (exact) RailGun アリスの武器を制御するクラス
---@field public isCharging boolean チャージ中かどうか
---@field public animationLength integer アニメーションの長さ
---@field public chargePercent number レールガンのチャージ割合
---@field package currentRot number[] レールガン回転パーツの現在の角度：1. マズル1, 2. マズル2, 3. マズル3, 4. エネルギー発生部
---@field package nextRot number[] レールガン回転パーツの次ティックの角度：1. マズル1, 2. マズル2, 3. マズル3, 4. エネルギー発生部
---@field package gunPositionPrev Gun.GunPosition 前ティックの銃の持ち位置
local RailGun = {
    isCharging = false;
    animationLength = 0;
    chargePercent = 0;
    currentRot = {0, 0, 0, 0};
    nextRot = {0, 0, 0, 0};
    isChargeSoundPlayed = false;
    fullChargeSound = nil;
    gunPositionPrev = "NONE";

    ---レールガンのスクリプト機能を有効にする。
    ---@param self RailGun
    enable = function (self)
        if events.TICK:getRegisteredCount("rail_gun_tick") == 0 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    if Gun.currentGunPosition ~= self.gunPositionPrev then
                        if Gun.currentGunPosition == "RIGHT" or Gun.currentGunPosition == "LEFT" then
                            --レールガンを持ったとき
                            for _, modelPart in ipairs({ModelAlias.alias.avatar.gun.GunBodyEmissive1, ModelAlias.alias.avatar.gun.GunBodyEmissive2, ModelAlias.alias.avatar.gun.GunBodyEmissive3, ModelAlias.alias.avatar.gun.TriggerGuard2.GunBodyEmissive4, ModelAlias.alias.avatar.gun.EnergyCore.EnergyCore2}) do
                                modelPart:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
                            end
                        elseif ExSkill.animationCount == -1 then
                            --レールガンをしまったとき
                            for _, modelPart in ipairs({ModelAlias.alias.avatar.gun.GunBodyEmissive1, ModelAlias.alias.avatar.gun.GunBodyEmissive2, ModelAlias.alias.avatar.gun.GunBodyEmissive3, ModelAlias.alias.avatar.gun.TriggerGuard2.GunBodyEmissive4, ModelAlias.alias.avatar.gun.EnergyCore.EnergyCore2}) do
                                modelPart:setPrimaryRenderType("CUTOUT")
                            end
                        end
                        self.gunPositionPrev = Gun.currentGunPosition
                    end

                    --弦引きの検出
                    local activeItem = player:getActiveItem()
                    local isLeftHanded = player:isLeftHanded()
                    local heldItems = {player:getHeldItem(isLeftHanded), player:getHeldItem(not isLeftHanded)}
                    local gameVersion = client:getVersion()
                    local isNewerNbt = StringUtils.compareVersions(gameVersion, "1.20.5") == gameVersion
                    local hasChargedCrossbow = (heldItems[1].id == "minecraft:crossbow" and ((isNewerNbt and #heldItems[1].tag["minecraft:charged_projectiles"] >= 1) or (not isNewerNbt and heldItems[1].tag.Charged == 1)) and Gun.currentGunPosition == "RIGHT") or (heldItems[2].id == "minecraft:crossbow" and ((gameVersion >= "1.20.5" and #heldItems[2].tag["minecraft:charged_projectiles"] >= 1) or (gameVersion < "1.20.5" and heldItems[2].tag.Charged == 1)) and Gun.currentGunPosition == "LEFT")
                    if (activeItem.id == "minecraft:bow" or activeItem.id == "minecraft:crossbow") and not self.isCharging then
                        --チャージ開始
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
                        self.isCharging = true
                    elseif hasChargedCrossbow and not self.isCharging then
                        self.isCharging = true
                        self.animationLength = 0
                    elseif activeItem.id ~= "minecraft:bow" and activeItem.id ~= "minecraft:crossbow" and not hasChargedCrossbow and self.isCharging and ExSkill.animationCount == -1 then
                        --チャージ終了
                        self.isCharging = false
                        self.animationLength = 0
                    end

                    --レールガンのアニメーション制御
                    for i = 1, 4 do
                        self.currentRot[i] = self.nextRot[i]
                    end
                    self.nextRot[1] = self.currentRot[1] + math.max(self.chargePercent - 0.75, 0) * 640
                    self.nextRot[2] = self.currentRot[2] + math.max(self.chargePercent - 0.5, 0) * 320
                    self.nextRot[3] = self.currentRot[3] + math.max(self.chargePercent - 0.25, 0) * 213
                    self.nextRot[4] = self.currentRot[4] + self.chargePercent * 80

                    if self.isCharging then
                        self.chargePercent = math.min(self.chargePercent + 20 / self.animationLength * 0.05, 1)
                    else
                        if Gun.currentGunPosition == "NONE" then
                            self.chargePercent = 0
                        else
                            self.chargePercent = math.max(self.chargePercent - 0.05, 0)
                        end
                    end
                end
            end, "rail_gun_tick")

            events.RENDER:register(function (delta)
                if not client:isPaused() then
                    --回転部の回転
                    for i = 1, 3 do
                        ModelAlias.alias.avatar.gun["Muzzle"..i]:setRot(0, 0, self.currentRot[i] + (self.nextRot[i] - self.currentRot[i]) * delta)
                    end
                    ModelAlias.alias.avatar.gun.EnergyCore:setRot(0, 0, self.currentRot[4] + (self.nextRot[4] - self.currentRot[4]) * delta)

                    --デルタ値を考慮したチャージパーセントの計算
                    local truePercent = 0
                    if self.isCharging then
                        truePercent = math.min(self.chargePercent + 20 / self.animationLength * 0.05 * delta, 1)
                    else
                        truePercent = math.max(self.chargePercent - 0.05 * delta, 0)
                    end

                    --殻が開くギミック
                    ModelAlias.alias.avatar.gun.UpperShell:setPos(0, math.clamp(truePercent * 4 - 3, 0, 1) * 0.5, 0)
                    ModelAlias.alias.avatar.gun.LowerShell:setPos(0, math.clamp(truePercent * 4 - 3, 0, 1) * -0.5, 0)
                    ModelAlias.alias.avatar.gun.UpperShell.UpperShellTop:setPos(0, math.clamp(truePercent * 4 - 3, 0, 1) * 0.1, 0)
                    ModelAlias.alias.avatar.gun.LowerShell.LowerShellBottom:setPos(0, math.clamp(truePercent * 4 - 3, 0, 1) * -0.1, 0)

                    --マズルチャージ
                    ModelAlias.alias.avatar.gun.Muzzle1.MuzzleEmissive1:setColor(vectors.vec3(0.970, 0.126, 0.418):scale(math.clamp(truePercent * 4 - 1, 0, 1)))
                    ModelAlias.alias.avatar.gun.Muzzle2.MuzzleEmissive2:setColor(vectors.vec3(0.970, 0.126, 0.418):scale(math.clamp(truePercent * 4 - 2, 0, 1)))
                    ModelAlias.alias.avatar.gun.Muzzle3.MuzzleEmissive3:setColor(vectors.vec3(0.970, 0.126, 0.418):scale(math.clamp(truePercent * 4 - 3, 0, 1)))
                    ModelAlias.alias.avatar.gun.Muzzle3.MuzzleEmissive4:setColor(vectors.vec3(0.970, 0.126, 0.418):scale(math.clamp(truePercent, 0, 1)))
                end
            end, "rail_gun_render")
        end
    end;

    ---レールガンのスクリプト機能を無効にする。
    ---@param self RailGun
    disable = function (self)
        events.TICK:remove("rail_gun_tick")
        events.RENDER:remove("rail_gun_render")
        self.isCharging = false
        self.animationLength = 0
        self.chargePercent = 0
        self.currentRot = {0, 0, 0, 0}
        self.nextRot = {0, 0, 0, 0}
        self.gunPositionPrev = "NONE"
    end;
}

return RailGun
