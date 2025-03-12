---@class (exact) Head : AvatarModule 頭を制御するクラス

Head = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Head
    new = function (parent)
        ---@type Head
        local instance = Avatar.instantiate(Head, AvatarModule, parent)

        return instance
    end;

    ---初期化関数
    ---@param self Head
    init = function (self)
        AvatarModule.init(self)

        if host:isHost() then
            events.RENDER:register(function (_, context)

            end)
        end
    end;
}