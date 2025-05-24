
---@alias DebugUtils.AutoPlayMode
---| "NONE" # 自動再生なし
---| "MAIN" # メインExスキル
---| "SUB" # サブExスキル

---@class (exact) DebugUtils : AvatarModule デバッグ作業向けのユーティリティクラス
---@field public EX_SKILL_AUTO_PLAY_MODE DebugUtils.AutoPlayMode アバター読み込み時にExスキルを自動再生するモード
---@field public DEATH_ANIMATION_DEBUG_MODE boolean 死亡アニメーションのデバッグモードを有効にするかどうか
---@field public applyAvatar fun(target?: string) プレイヤーに現在適用中のアバターのコピーを適用させる

DebugUtils = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return DebugUtils
    new = function (parent)
        ---@type DebugUtils
        local instance = Avatar.instantiate(DebugUtils, AvatarModule, parent)

        instance.EX_SKILL_AUTO_PLAY_MODE = "NONE"
        instance.DEATH_ANIMATION_DEBUG_MODE = false

        return instance
    end;

    ---初期化関数
    ---@param self DebugUtils
    init = function (self)
        AvatarModule.init(self)

        self.parent.avatarEvents.SCRIPT_INIT:register(function ()
            if self.EX_SKILL_AUTO_PLAY_MODE ~= "NONE" then
                self.parent.exSkill:play(self.parent.debugUtils.EX_SKILL_AUTO_PLAY_MODE == "SUB")
            end
            if self.DEATH_ANIMATION_DEBUG_MODE then
                ---@diagnostic disable-next-line: discard-returns
                models:newPart("script_death_animation_debug", "World")
                keybinds:newKeybind("[DEBUG] Spawn death animation phase1 model", "key.keyboard.x"):onPress(function ()
                    self.parent.deathAnimation.removeUnsafeModel(models.script_death_animation_debug.Avatar)
                    self.parent.deathAnimation:generateDummyAvatar(models.script_death_animation_debug)
                    self.parent.deathAnimation.resetDummyAvatar(models.script_death_animation_debug.Avatar)
                    self.parent.deathAnimation.setPhase1Pose(models.script_death_animation_debug.Avatar)
                    models.script_death_animation_debug.Avatar:setPos(player:getPos():add(0, -0.75, 0):scale(16))
                    if self.parent.characterData.deathAnimation.callbacks ~= nil and self.parent.characterData.deathAnimation.callbacks.onPhase1 ~= nil then
                        self.parent.characterData.deathAnimation.callbacks.onPhase1(self.parent.characterData, models.script_death_animation_debug.Avatar, self.parent.compatibilityUtils.upper(self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].name))
                    end
                end)
                keybinds:newKeybind("[DEBUG] Spawn death animation phase2 model", "key.keyboard.c"):onPress(function ()
                    self.parent.deathAnimation.removeUnsafeModel(models.script_death_animation_debug.Avatar)
                    self.parent.deathAnimation:generateDummyAvatar(models.script_death_animation_debug)
                    self.parent.deathAnimation.resetDummyAvatar(models.script_death_animation_debug.Avatar)
                    self.parent.deathAnimation.setPhase2Pose(models.script_death_animation_debug.Avatar)
                    models.script_death_animation_debug.Avatar:setPos(player:getPos():scale(16))
                    if self.parent.characterData.deathAnimation.callbacks ~= nil and self.parent.characterData.deathAnimation.callbacks.onPhase1 ~= nil then
                        self.parent.characterData.deathAnimation.callbacks.onPhase1(self.parent.characterData, models.script_death_animation_debug.Avatar, self.parent.compatibilityUtils.upper(self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].name))
                    end
                    if self.parent.characterData.deathAnimation.callbacks ~= nil and self.parent.characterData.deathAnimation.callbacks.onPhase2 ~= nil then
                        self.parent.characterData.deathAnimation.callbacks.onPhase2(self.parent.characterData, models.script_death_animation_debug.Avatar, self.parent.compatibilityUtils.upper(self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].name))
                    end
                end)
            end
        end)
    end;

    ---プレイヤーに現在適用中のアバターのコピーを適用させる。
    ---@param target? string アバターのコピーを適用させるプレイヤーの名前。省略した場合は視線を合わせているプレイヤーを対象とする。
    applyAvatar = function (target)
        local targetUuid = nil
        if target == nil then
            local targetEntity = player:getTargetedEntity()
            if targetEntity == nil then
                print("§cCannot find the target entity.§r")
                return
            elseif not targetEntity:isPlayer() then
                print("§cThe target entity must be a player.§r")
                return
            else
                targetUuid = targetEntity:getUUID()
            end
        else
            if player:getName() == target then
                print("§cCannot target yourself.§r")
                return
            else
                local players = world.getPlayers()
                if players[target] ~= nil then
                    targetUuid = players[target]:getUUID()
                else
                    print("§cCannot find the player whose name is \""..target.."\".§r")
                    return
                end
            end
        end
        host:sendChatCommand("figura set_avatar "..targetUuid.." "..player:getUUID())
    end
}

---プレイヤーに現在適用中のアバターのコピーを適用させる。チャットコマンドから実行するためのエイリアス。
---@param target? string アバターのコピーを適用させるプレイヤーの名前。省略した場合は視線を合わせているプレイヤーを対象とする。
---@diagnostic disable-next-line: lowercase-global
function applyAvatar(target)
    AvatarInstance.debugUtils.applyAvatar(target)
end