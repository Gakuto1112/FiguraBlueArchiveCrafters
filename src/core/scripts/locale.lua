

---@class (exact) Locale メッセージのローカライズを管理するクラス
---@field package HARDCODED_LOCALES table<string, string> 外部からのロケール取得前に使用されるハードコードされた、最低限のローカライズメッセージ
---@field package activeLocale string 現在有効になっているロケール
---@field package locales table<string, table<string, string>> ローカライズされたテキストを格納するテーブル
local Locale = {
	HARDCODED_LOCALES = {};

	activeLocale = "en_us";
	locales = {};

	---初期化関数
	---@param self Locale
	init = function (self)
		self:initializeLocaleData()
	end;

	---ロケールデータを初期化する。
	---@param self Locale
	initializeLocaleData = function (self)
		self.locales = {}
		self.locales["en_us"] = {}
		for key, value in pairs(self.HARDCODED_LOCALES) do
			self.locales["en_us"][key] = value
		end
	end;

	---翻訳キーに対応するローカライズされたテキストを返す。
	---現在有効なロケールでのテキストが見つからない場合は、英語（en_us）でのテキストを返す。
	---どちらも見つからない場合は、翻訳キー自体を返す。
	---@param self Locale
	---@param key string ローカライズされたテキストを取得するための翻訳キー
	---@return string localizedText ローカライズされたテキスト、または翻訳キー自体。
	getLocalizedText = function (self, key)
		if self.locales[self.activeLocale] ~= nil and self.locales[self.activeLocale][key] ~= nil then
			return self.locales[self.activeLocale][key]
		elseif self.locales["en_us"] ~= nil and self.locales["en_us"][key] ~= nil then
			return self.locales["en_us"][key]
		else
			return key
		end
	end;
}

return Locale
