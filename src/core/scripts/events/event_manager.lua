---@class (exact) EventManager.EventTable イベントインスタンスを格納するテーブルの構造体
---@field ON_LOCALE_REFRESH LocaleRefreshEvent ロケールデータ更新イベント
---@field ON_LOCALE_CHANGE LocaleChangeEvent ゲームのロケール変更イベント
---@field ON_CONFIG_SYNC ConfigSyncEvent アバター設定データ同期イベント
---@field ON_ACTION_WHEEL_CLOSE ActionWheelClosedEvent アクションホイール閉イベント

---@class (exact) EventManager アバター独自定義のイベントを管理するクラス
---@field public events EventManager.EventTable イベントインスタンスを格納するテーブル
local EventManager = {
	---@diagnostic disable-next-line: missing-fields
	events = {};
}

return EventManager
