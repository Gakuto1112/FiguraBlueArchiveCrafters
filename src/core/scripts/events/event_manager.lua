---@class (exact) EventManager アバター独自定義のイベントを管理するクラス
---@field public events {[string]: AbstractEvent} イベントインスタンスを格納するテーブル
local EventManager = {
	events = {};
}

return EventManager
