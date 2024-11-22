---@alias PlayerUtils.DamageStatus
---| "NONE" # ダメージなし
---| "DAMAGE" # ダメージを受けた
---| "DIED" # 死亡した

---@class (exact) PlayerUtils : AvatarModule プレイヤーに関するユーティリティ関数群
---@field public damageStatus PlayerUtils.DamageStatus 現在のティックのダメージステータス
---@field package healthPrev integer 前ティックのHP量

PlayerUtils = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return PlayerUtils
    new = function (parent)
        ---@type PlayerUtils
        local instance = Avatar.instantiate(PlayerUtils, AvatarModule, parent)

        instance.damageStatus = "NONE"
        instance.healthPrev = player:getHealth()

        return instance
    end;

        ---初期化関数
    ---@param self PlayerUtils
    init = function (self)
        events.TICK:register(function ()
            local health = player:getHealth()
            self.damageStatus = self.healthPrev > health and (health == 0 and "DIED" or "DAMAGE") or "NONE"
            self.healthPrev = health
        end)
    end;
}