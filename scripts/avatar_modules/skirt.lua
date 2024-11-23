---@class Skirt : AvatarModule スカートを制御するクラス

Skirt = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Skirt
    new = function (parent)
        ---@type Skirt
        local instance = Avatar.instantiate(Skirt, AvatarModule, parent)

        return instance
    end;

    ---初期化関数
    ---@param self AvatarModule
    init = function (self)
        AvatarModule.init(self)

        if self.parent.characterData.skirt.skirtModels ~= nil and #self.parent.characterData.skirt.skirtModels > 0 then
            events.TICK:register(function ()
                local isCrouching = player:isCrouching()
                for _, skirtModel in ipairs(self.parent.characterData.skirt.skirtModels) do
                    if skirtModel:getVisible() then
                        skirtModel:setRot(isCrouching and 30 or 0, 0, 0)
                    end
                end
            end)
        end
    end;
}