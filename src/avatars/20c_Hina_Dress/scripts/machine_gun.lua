---@class (exact) MachineGun ヒナのマシンガンを制御するクラス
---@field package isCharging boolean 弦引き中かどうか
---@field package animationLength integer アニメーションの長さ
---@field package chargePercent number マシンガンのチャージ割合
---@field package currentRot number 現在の回転角度
---@field package nextRot number 次ティックの回転角度
---@field public exSkillIsHolding boolean EXスキルの再生中にのみ、銃を持っているかのフラグの代わりに参照される変数
local MachineGun = {
    isCharging = false;
    animationLength = 0;
    chargePercent = 0;
    currentRot = 0;
    nextRot = 0;
    exSkillIsHolding = false;

    ---初期化関数
    ---@param self MachineGun
    init = function (self)
        events.TICK:register(function ()
            if not client:isPaused() then
                for _, modelPart in ipairs({ModelAlias.alias.avatar.gun.RotatableBarrel.RotatableBarrelEmissive, ModelAlias.alias.avatar.gun.GunBodyEmissive}) do
                    modelPart:setPrimaryRenderType((ExSkill.animationCount == -1 and (Gun.currentGunPosition ~= "NONE") or self.exSkillIsHolding) and "CUTOUT_EMISSIVE_SOLID" or "CUTOUT")
                end


                --弦引きの検出
                if ExSkill.animationCount == -1 then
                    local activeItem = player:getActiveItem()
                    local isLeftHanded = player:isLeftHanded()
                    local heldItems = {player:getHeldItem(isLeftHanded), player:getHeldItem(not isLeftHanded)}
                    local gameVersion = client:getVersion()
                    local isNewerNbt = StringUtils.compareVersions(gameVersion, "1.20.5") == gameVersion
                    local hasChargedCrossbow = (heldItems[1].id == "minecraft:crossbow" and ((isNewerNbt and #heldItems[1].tag["minecraft:charged_projectiles"] >= 1) or (not isNewerNbt and heldItems[1].tag.Charged == 1)) and Gun.currentGunPosition == "RIGHT") or (heldItems[2].id == "minecraft:crossbow" and ((gameVersion >= "1.20.5" and #heldItems[2].tag["minecraft:charged_projectiles"] >= 1) or (gameVersion < "1.20.5" and heldItems[2].tag.Charged == 1)) and Gun.currentGunPosition == "LEFT")
                    if (activeItem.id == "minecraft:bow" or activeItem.id == "minecraft:crossbow") and not self.isCharging then
                        --チャージ開始
                        self.isCharging = true
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
                    elseif hasChargedCrossbow and not self.isCharging then
                        self.isCharging = true
                        self.animationLength = 0
                    elseif activeItem.id ~= "minecraft:bow" and activeItem.id ~= "minecraft:crossbow" and not hasChargedCrossbow and self.isCharging then
                        --チャージ終了
                        self.isCharging = false
                        self.animationLength = 0
                    end
                else
                    self.isCharging = false
                    self.animationLength = 0
                end

                if self.isCharging then
                    self.chargePercent = math.min(self.chargePercent + 20 / self.animationLength * 0.05, 1)
                elseif Gun.currentGunPosition == "NONE" or ExSkill.animationCount >= 0 then
                    self.chargePercent = 0
                else
                    self.chargePercent = math.max(self.chargePercent - 0.05, 0)
                end

                self.currentRot = self.nextRot
                self.nextRot = self.currentRot + self.chargePercent * 80
            end
        end)

        events.RENDER:register(function (delta, ctx, matrix)
            if not client:isPaused() then
                ModelAlias.alias.avatar.gun.RotatableBarrel:setRot(0, 0, self.currentRot + (self.nextRot - self.currentRot) * delta)
            end
        end)
    end;
}

return MachineGun
