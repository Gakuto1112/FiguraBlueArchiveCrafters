---@class AvatarModule アバターの動作を構成するモジュールの抽象クラス
---@field package parent Avatar アバターのメインクラスへの参照

AvatarModule = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return AvatarModule
    new = function (parent)
        ---@type AvatarModule
        local instance = Avatar.instantiate(AvatarModule)

        instance.parent = parent

        return instance
    end;
}