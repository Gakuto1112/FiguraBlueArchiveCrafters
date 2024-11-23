---@class (exact) HypixelZombies : AvatarModule Hypixelの「Zombies」にアバターを対応させるパッチ
---@field package isEnabled boolean Zombiesモードが有効かどうか
---@field package damagerPercentPrev number[] 前ティック以前のツールの耐久度割合
---@field public enable fun(self: HypixelZombies) Zombiesモードを有効にする
---@field public disable fun(self: HypixelZombies) Zombiesモードを無効にする

HypixelZombies = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return HypixelZombies
    new = function (parent)
        ---@type HypixelZombies
        local instance = Avatar.instantiate(HypixelZombies, AvatarModule, parent)

        instance.isEnabled = false
        instance.damagerPercentPrev = {1, 1}

        return instance
    end;

    ---Zombiesモードを有効にする。
    ---@param self HypixelZombies
    enable = function (self)
        if not self.isEnabled then
            self.parent.gun.gunItems = {"minecraft:bow", "minecraft:crossbow", "minecraft:wooden_hoe", "minecraft:stone_hoe", "minecraft:iron_hoe", "minecraft:wooden_shovel", "minecraft:stone_shovel", "minecraft:shears", "minecraft:diamond_hoe", "minecraft:golden_hoe", "minecraft:iron_shovel", "minecraft:diamond_pickaxe", "minecraft:golden_pickaxe", "minecraft:golden_shovel", "minecraft:flint_and_steel"}

            events.TICK:register(function ()
                local heldItem = player:getHeldItem()
                local maxDamage = heldItem:getMaxDamage()
                local damagePercent = (maxDamage - heldItem:getDamage()) / maxDamage
                if maxDamage > 0 then
                    if damagePercent - self.damagerPercentPrev[1] > 0 and damagePercent - self.damagerPercentPrev[1] <= 0.2 then
                        if self.parent.bubble.bubbleCount == 0 then
                            self.parent.bubble:play("RELOAD", -1, vectors.vec2(), 0, false)
                        end
                    elseif self.parent.bubble.emoji == "RELOAD" then
                        self.parent.bubble:stop()
                    end
                    table.insert(self.damagerPercentPrev, damagePercent)
                else
                    if self.parent.bubble.emoji == "RELOAD" then
                        self.parent.bubble:stop()
                    end
                    table.insert(self.damagerPercentPrev, 1)
                end
                table.remove(self.damagerPercentPrev, 1)
            end, "hypixel_zombies_tick")

            if host:isHost() then
                print(self.parent.locale:getLocale("avatar.zombies_mode.enable"))
                sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:entity.lightning_bolt.thunder"), player:getPos(), 0.5, 2)
            end

            self.isEnabled = true
        elseif host:isHost() then
            print(self.parent.locale:getLocale("avatar.zombies_mode.already_enabled"))
        end
    end;

    ---Zombiesモードを無効にする。
    ---@param self HypixelZombies
    disable = function (self)
        if self.isEnabled then
            events.TICK:remove("hypixel_zombies_tick")
            self.parent.gun.gunItems = {"minecraft:bow", "minecraft:crossbow"}

            if host:isHost() then
                print(self.parent.locale:getLocale("avatar.zombies_mode.disable"))
            end
        elseif host:isHost() then
            print(self.parent.locale:getLocale("avatar.zombies_mode.already_disabled"))
        end
        self.isEnabled = false
    end
}

---Zombiesモードを有効にする。
function pings.enableZombiesMode()
    AvatarInstance.hypixelZombies:enable()
end

---Zombiesモードを無効にする。
function pings.disableZombiesMode()
    AvatarInstance.hypixelZombies:disable()
end