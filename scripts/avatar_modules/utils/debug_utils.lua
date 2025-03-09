
---@alias DebugUtils.AutoPlayMode
---| "NONE" # 自動再生なし
---| "MAIN" # メインExスキル
---| "SUB" # サブExスキル

---@class (exact) DebugUtils : AvatarModule デバッグ作業向けのユーティリティクラス
---@field public EX_SKILL_AUTO_PLAY_MODE DebugUtils.AutoPlayMode アバター読み込み時にExスキルを自動再生するモード
---@field public DEATH_ANIMATION_DEBUG_MODE boolean 死亡アニメーションのデバッグモードを有効にするかどうか

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
                        self.parent.characterData.deathAnimation.callbacks.onPhase1(self.parent.characterData, models.script_death_animation_debug.Avatar, self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].name:upper())
                    end
                end)
                keybinds:newKeybind("[DEBUG] Spawn death animation phase2 model", "key.keyboard.c"):onPress(function ()
                    self.parent.deathAnimation.removeUnsafeModel(models.script_death_animation_debug.Avatar)
                    self.parent.deathAnimation:generateDummyAvatar(models.script_death_animation_debug)
                    self.parent.deathAnimation.resetDummyAvatar(models.script_death_animation_debug.Avatar)
                    self.parent.deathAnimation.setPhase2Pose(models.script_death_animation_debug.Avatar)
                    models.script_death_animation_debug.Avatar:setPos(player:getPos():scale(16))
                    if self.parent.characterData.deathAnimation.callbacks ~= nil and self.parent.characterData.deathAnimation.callbacks.onPhase1 ~= nil then
                        self.parent.characterData.deathAnimation.callbacks.onPhase1(self.parent.characterData, models.script_death_animation_debug.Avatar, self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].name:upper())
                    end
                    if self.parent.characterData.deathAnimation.callbacks ~= nil and self.parent.characterData.deathAnimation.callbacks.onPhase2 ~= nil then
                        self.parent.characterData.deathAnimation.callbacks.onPhase2(self.parent.characterData, models.script_death_animation_debug.Avatar, self.parent.characterData.costume.costumes[self.parent.costume.currentCostume].name:upper())
                    end
                end)
            end
        end)
    end;
}