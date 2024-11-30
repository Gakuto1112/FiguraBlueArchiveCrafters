---@class AvatarEvents : AvatarModule アバター独自のイベントを定義し、管理するクラス
---@field public SCRIPT_INIT ScriptInitEvent 全てのスクリプトの初期化が完了した後に1度だけ呼ばれるイベント

AvatarEvents = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return AvatarEvents
    new = function (parent)
        ---@type AvatarEvents
        local instance = Avatar.instantiate(AvatarEvents, AvatarModule, parent)

        instance.SCRIPT_INIT = ScriptInitEvent.new(instance.parent)

        return instance
    end;
}