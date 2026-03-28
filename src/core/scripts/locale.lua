---ロケールデータの取得結果を表す列挙型
---@alias Locale.DataReadStatus
---| "SUCCESS"         # 取得成功
---| "ERR_NOT_ALLOWED" # File APIの利用が許可されていない
---| "ERR_RESPONSE"    # リモートエンドポイントからの取得の際にエラーコードが返された
---| "ERR_NETWORK"     # ネットワークエラー
---| "ERR_JSON_PARSE"  # jsonのパースに失敗

---@class (exact) Locale メッセージのローカライズを管理するクラス
---@field package CACHE_DIR_ROOT string ロケールキャッシュディレクトリのルートパス
---@field package REMOTE_LOCALE_ENDPOINT string ロケールデータの外部取得先URI
---@field package AVATAR_NAME string ロケールデータの取得に使用されるアバターの名前
---@field package HARDCODED_LOCALES table<string, string> 外部からのロケール取得前に使用されるハードコードされた、最低限のローカライズメッセージ
---@field package localeVersion string? ロケールデータのバージョン
---@field package availableLocales string[] 利用可能なロケールのリスト
---@field package activeLocale string 現在有効になっているロケール
---@field package locales table<string, table<string, string>> ローカライズされたテキストを格納するテーブル
local Locale = {
	CACHE_DIR_ROOT = "Gakuto1112/FiguraBlueArchiveCrafters/locale/";
	REMOTE_LOCALE_ENDPOINT = "http://localhost/";
	AVATAR_NAME = "00a_base";

	HARDCODED_LOCALES = {
		["message.net_utils.err_response"] = "An error code (%d) was responded from the remote server.";
		["message.net_utils.err_network"] = "Cannot send a request to the remote server.";
		["message.net_utils.err_json_parse"] = "Failed to parse JSON data.";
		["message.locale.err_fetch"] = "Failed to fetch locale data: %s";
		["message.locale.err_not_found"] = "The specified locale data was not found! Redirecting to en_us locale.";
		["message.net_utils.err_not_allowed"] = "There is not permission to use Figura Networking API or access to the remote endpoint! Please allow Figura Networking API and add the remote domain \"%s\" to the Network Filter in Figura settings!";
		["message.locale.err_not_allowed"] = "There is not permission to use Figura File API or access Figura home directory! Cannot get locale data!";
		["message.locale.err_io"] = "Failed to operate locale cache directory.";
	};

	localeVersion = nil;
	availableLocales = {};
	activeLocale = "auto";
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
			self:getFile("index.json", function (status, data)
				if status == "SUCCESS" then
					self.localeVersion = data["localeVersion"]
					for _, locale in ipairs(data["availableLocales"]) do
						table.insert(self.availableLocales, locale)
					end

					--//TODO: インデックスの受信日時を記録する。

					-- en_usのロケールデータを取得
					self:getFile("core/en_us.json", function (status2, data2)
						if status2 == "SUCCESS" then
							---@cast data2 table<string, string>
							for key, value in pairs(data2) do
								self.locales["en_us"][key] = value
							end
						else
							print(self:getLocalizedText("message.locale.err_fetch"):format("core/en_us.json"))
						end
					end)
					self:getFile("avatars/" .. self.AVATAR_NAME .. "/en_us.json", function (status2, data2)
						if status2 == "SUCCESS" then
							---@cast data2 table<string, string>
							for key, value in pairs(data2) do
								self.locales["en_us"][key] = value
							end
						else
							print(self:getLocalizedText("message.locale.err_fetch"):format("avatar/" .. self.AVATAR_NAME .. "/en_us.json"))
						end
					end)

					-- 現在のロケールのデータを取得
					local currentLocale = self.activeLocale == "auto" and client:getActiveLang() or self.activeLocale
					self:getFile("core/" .. currentLocale .. ".json", function (status2, data2)
						if status2 == "SUCCESS" then
							---@cast data2 table<string, string>
							self.locales[currentLocale] = {}
							if self.locales[currentLocale] == nil then
								self.locales[currentLocale] = {}
							end
							for key, value in pairs(data2) do
								self.locales[currentLocale][key] = value
							end
						elseif status2 == "ERR_RESPONSE" and data2 == 404 then
							print(self:getLocalizedText("message.locale.err_not_found"))
						else
							print(self:getLocalizedText("message.locale.err_fetch"):format("core/" .. currentLocale .. ".json"))
						end
					end)
					self:getFile("avatars/" .. self.AVATAR_NAME .. "/" .. currentLocale .. ".json", function (status2, data2)
						if status2 == "SUCCESS" then
							---@cast data2 table<string, string>
							if self.locales[currentLocale] == nil then
								self.locales[currentLocale] = {}
							end
							for key, value in pairs(data2) do
								self.locales[currentLocale][key] = value
							end
						elseif status2 == "ERR_RESPONSE" and data2 == 404 then
							print(self:getLocalizedText("message.locale.err_not_found"))
						else
							print(self:getLocalizedText("message.locale.err_fetch"):format("avatar/" .. self.AVATAR_NAME .. "/" .. currentLocale .. ".json"))
						end
					end)

				else
					print(self:getLocalizedText("message.locale.err_fetch"):format("index.json"))
				end
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
			if not file:mkdirs(self.CACHE_DIR_ROOT) or not file:mkdirs(self.CACHE_DIR_ROOT .. "/core") or not file:mkdirs(self.CACHE_DIR_ROOT .. "/avatars/" .. self.AVATAR_NAME) then
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
	---@param callback fun(status: Locale.DataReadStatus, data: boolean|string|number|table)? ロケールデータの準備ができた際に呼び出されるコールバック関数
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
					callback("SUCCESS", jsonData)
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
							callback("SUCCESS", jsonData)
							file:writeString(self.CACHE_DIR_ROOT .. "/" .. path, toJson(jsonData), "utf8")
						else
							print(self:getLocalizedText("message.net_utils.err_json_parse"))
						end
					elseif status == "ERR_RESPONSE" then
						callback("ERR_RESPONSE", data)
					elseif status == "ERR_NETWORK" then
						callback("ERR_NETWORK", nil)
					elseif status == "ERR_NOT_ALLOWED" then
						print(self:getLocalizedText("message.net_utils.err_not_allowed"):format(self.REMOTE_LOCALE_ENDPOINT:match("://([^:/]+)")))
						callback("ERR_NOT_ALLOWED", nil)
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
		local locale = self.activeLocale == "auto" and client:getActiveLang() or self.activeLocale
		if self.locales[locale] ~= nil and self.locales[locale][key] ~= nil then
			return self.locales[locale][key]
		elseif self.locales["en_us"] ~= nil and self.locales["en_us"][key] ~= nil then
			return self.locales["en_us"][key]
		else
			return key
		end
	end;
}

return Locale
