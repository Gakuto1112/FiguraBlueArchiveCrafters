---@alias DebugUtils.AutoPlayMode
---| "NONE" # 自動再生なし
---| "PRIMARY" # メインExスキル
---| "SECONDARY" # サブExスキル

---@class (exact) DebugUtils デバッグ作業向けのユーティリティクラス
---@field public EX_SKILL_AUTO_PLAY_MODE DebugUtils.AutoPlayMode アバター読み込み時にExスキルを自動再生するモード
---@field public DEATH_ANIMATION_DEBUG_MODE boolean 死亡アニメーションのデバッグモードを有効にするかどうか
local DebugUtils = {
	EX_SKILL_AUTO_PLAY_MODE = "NONE";
	DEATH_ANIMATION_DEBUG_MODE = false;

    ---初期化関数
    ---@param self DebugUtils
    init = function (self)
		if self.EX_SKILL_AUTO_PLAY_MODE ~= "NONE" then
			events.TICK:register(function ()
				ExSkill:play(self.EX_SKILL_AUTO_PLAY_MODE == "SECONDARY")
				events.TICK:remove("debug_utils_ex_skill_auto_play_delay")
			end, "debug_utils_ex_skill_auto_play_delay")
		end
		if self.DEATH_ANIMATION_DEBUG_MODE then
			---@diagnostic disable-next-line: discard-returns
			models:newPart("script_death_animation_debug", "World")
			keybinds:newKeybind("[DEBUG] Spawn death animation phase1 model", "key.keyboard.x"):onPress(function ()
				DeathAnimation:generateDummyAvatar(models.script_death_animation_debug)
				DeathAnimation.resetDummyAvatar()
				DeathAnimation.setPhase1Pose()
				ModelAlias.alias.dummy_avatar.root:setPos(player:getPos():add(0, -0.75, 0):scale(16))
				if BlueArchiveCharacter.deathAnimation.callbacks ~= nil and BlueArchiveCharacter.deathAnimation.callbacks.onPhase1 ~= nil then
					BlueArchiveCharacter.deathAnimation.callbacks.onPhase1(BlueArchiveCharacter, Costume.isAltCostume)
				end
			end)
			keybinds:newKeybind("[DEBUG] Spawn death animation phase2 model", "key.keyboard.c"):onPress(function ()
				DeathAnimation:generateDummyAvatar(models.script_death_animation_debug)
				DeathAnimation.resetDummyAvatar()
				DeathAnimation.setPhase2Pose()
				ModelAlias.alias.dummy_avatar.root:setPos(player:getPos():add(0, -0.75, 0):scale(16))
				if BlueArchiveCharacter.deathAnimation.callbacks ~= nil and BlueArchiveCharacter.deathAnimation.callbacks.onPhase1 ~= nil then
					BlueArchiveCharacter.deathAnimation.callbacks.onPhase1(BlueArchiveCharacter, Costume.isAltCostume)
				end
				if BlueArchiveCharacter.deathAnimation.callbacks ~= nil and BlueArchiveCharacter.deathAnimation.callbacks.onPhase2 ~= nil then
					BlueArchiveCharacter.deathAnimation.callbacks.onPhase2(BlueArchiveCharacter, Costume.isAltCostume)
				end
			end)
		end
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
    DebugUtils.applyAvatar(target)
end

return DebugUtils
