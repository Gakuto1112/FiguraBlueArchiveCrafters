---@class AvatarModule アバターの動作を構成するモジュールの抽象クラス
---@field public parent Avatar アバターのメインクラスへの参照
---@field public new fun(parent: Avatar): AvatarModule コンストラクタ
---@field public init fun(self: AvatarModule) 初期化関数

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

    ---初期化関数
    ---@param self AvatarModule
    init = function (self)
    end;
}