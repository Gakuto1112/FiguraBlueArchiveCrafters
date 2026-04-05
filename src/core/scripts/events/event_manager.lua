---@class (exact) EventManager.EventTable イベントインスタンスを格納するテーブルの構造体
---@field ON_LOCALE_REFRESH LocaleRefreshEvent ロケールデータ更新イベント
---@field ON_LOCALE_CHANGE LocaleChangeEvent ゲームのロケール変更イベント
---@field ON_CONFIG_SYNC ConfigSyncEvent アバター設定データ同期イベント

---@class (exact) EventManager アバター独自定義のイベントを管理するクラス
---@field public events EventManager.EventTable イベントインスタンスを格納するテーブル
local EventManager = {
	events = {};
}

return EventManager
