

---@class (exact) Locale メッセージのローカライズを管理するクラス
---@field package CACHE_DIR_ROOT string ロケールキャッシュディレクトリのルートパス
---@field package REMOTE_LOCALE_ENDPOINT string ロケールデータの外部取得先URI
---@field package HARDCODED_LOCALES table<string, string> 外部からのロケール取得前に使用されるハードコードされた、最低限のローカライズメッセージ
---@field package localeVersion string? ロケールデータのバージョン
---@field package availableLocales string[] 利用可能なロケールのリスト
---@field package activeLocale string 現在有効になっているロケール
---@field package locales table<string, table<string, string>> ローカライズされたテキストを格納するテーブル
local Locale = {
	CACHE_DIR_ROOT = "Gakuto1112/FiguraBlueArchiveCrafters/locale/";
	REMOTE_LOCALE_ENDPOINT = "http://localhost/";

	HARDCODED_LOCALES = {
		["message.net_utils.err_response"] = "An error code (%d) was responded from the remote server.";
		["message.net_utils.err_network"] = "Cannot send a request to the remote server.";
		["message.net_utils.err_json_parse"] = "Failed to parse JSON data.";
		["message.net_utils.err_not_allowed"] = "There is not permission to use Figura Networking API or access to the remote endpoint! Please allow Figura Networking API and add the remote domain \"%s\" to the Network Filter in Figura settings!";
		["message.locale.err_not_allowed"] = "There is not permission to use Figura File API or access Figura home directory! Cannot get locale data!";
		["message.locale.err_io"] = "Failed to operate locale cache directory.";
	};

	localeVersion = nil;
	availableLocales = {};
	activeLocale = "en_us";
	locales = {};

	---初期化関数
	---@param self Locale
	init = function (self)
		-- ロケールデータの初期化
		self:initializeLocaleData()

		-- FileAPIへのアクセス許可を確認
		if self.checkAvailability() then
			-- キャッシュディレクトリの初期化
			if not file:exists(self.CACHE_DIR_ROOT) then
				self:initializeLocaleDirectory()
			end

			-- ロケールインデックスの取得
			self:getFile("index.json", function (data)
				self.localeVersion = data["localeVersion"]
				for _, locale in ipairs(data["availableLocales"]) do
					table.insert(self.availableLocales, locale)
				end

				--//TODO: インデックスの受信日時を記録する。
			end)
		else
			print(self:getLocalizedText("message.locale.err_not_allowed"))
		end
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

	---ロケールデータのキャッシュアクセスが許可されているかどうかを返す。
	---@return boolean isAllowed キャッシュアクセスが許可されているかどうか
	checkAvailability = function ()
		return file:allowed() and file:isPathAllowed("")
	end;

	---ロケールのキャッシュディレクトリを初期化する。
	---@param self Locale
	initializeLocaleDirectory = function (self)
		if self.checkAvailability() then
			if file:exists(self.CACHE_DIR_ROOT) then
				file:delete(self.CACHE_DIR_ROOT)
			end
			if not file:mkdirs(self.CACHE_DIR_ROOT) then
				print(self:getLocalizedText("message.locale.err_io"))
			end
		else
			print(self:getLocalizedText("message.locale.err_not_allowed"))
		end
	end;

	---ロケールデータに関するファイルの内容を取得する。
	---最初にキャッシュディレクトリから取得し、それがなければ外部から取得する。
	---@param self Locale
	---@param path string ロケールディレクトリからのファイルパス
	---@param callback fun(data: boolean|string|number|table) ロケールデータの準備ができた際に呼び出されるコールバック関数
	getFile = function (self, path, callback)
		if self.checkAvailability() then
			if file:exists(self.CACHE_DIR_ROOT .. "/" .. path) then
				-- キャッシュディレクトリから取ってくる
				local stream = file:openReadStream(self.CACHE_DIR_ROOT .. "/" .. path)
				local buffer = data:createBuffer()
				buffer:readFromStream(stream)
				buffer:setPosition(0)
				stream:close()

				local jsonData = NetUtils.toJson(buffer)
				if jsonData ~= nil then
					callback(jsonData)
				else
					print(self:getLocalizedText("message.net_utils.err_json_parse"))
				end

				return buffer
			else
				-- 外部から取ってくる
				NetUtils:get(self.REMOTE_LOCALE_ENDPOINT .. "/" .. path, function (status, data)
					if status == "SUCCESS" then
						---@cast data Buffer
						local jsonData = NetUtils.toJson(data)
						if jsonData ~= nil then
							callback(jsonData)
							file:writeString(self.CACHE_DIR_ROOT .. "/" .. path, toJson(jsonData), "utf8")
						else
							print(self:getLocalizedText("message.net_utils.err_json_parse"))
						end
					elseif status == "ERROR_RESPONSE_ERR" then
						print(self:getLocalizedText("message.net_utils.err_response"):format(data))
					elseif status == "ERROR_NETWORK_ERR" then
						print(self:getLocalizedText("message.net_utils.err_network"))
					elseif status == "ERROR_NOT_ALLOWED" then
						print(self:getLocalizedText("message.net_utils.err_not_allowed"):format(self.REMOTE_LOCALE_ENDPOINT:match("://([^:/]+)")))
					end
				end)

				return nil
			end
		else
			print(self:getLocalizedText("message.locale.err_not_allowed"))
		end
	end;

	---ロケールデータのキャッシュを削除する。
	---@param self Locale
	flushCache = function (self)
		if self.checkAvailability() then
			self:initializeLocaleDirectory()
		else
			print(self:getLocalizedText("message.locale.err_not_allowed"))
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
