---キャッシュファイルの取得結果を表す列挙型
---@alias Locale.CacheFetchResult
---| "SUCCESS"         # 取得成功
---| "ERR_NOT_ALLOWED" # File APIの利用が許可されていない
---| "ERR_NOT_FOUND"   # キャッシュファイルが見つからない
---| "ERR_NOT_A_FILE"  # 指定されたパスはディレクトリ

---リモートからのファイルの取得結果を表す列挙型
---@alias Locale.RemoteFetchResult
---| "SUCCESS"           # 取得成功
---| "ERR_NOT_ALLOWED"   # Networking APIの利用が許可されていないか、リモートドメインとの通信が許可されていない。
---| "ERR_NETWORK"       # 通信エラー
---| "ERR_RESPONSE_CODE" # レスポンスコードが200番台以外の場合（httpリクエストエラー）

---ファイルの取得結果を表す列挙型
---@alias Locale.FetchResult
---| "SUCCESS"           # 取得成功
---| "ERR_NOT_ALLOWED"   # ファイルの取得必要な権限がない
---| "ERR_NOT_FOUND"     # ファイルが見つからない
---| "ERR_NOT_A_FILE"    # 取得しようとしたパスがディレクトリである
---| "ERR_NETWORK"       # 通信エラー
---| "ERR_RESPONSE_CODE" # レスポンスコードが200番台以外の場合（httpリクエストエラー）
---| "ERR_INVALID_DATA"  # 予期したデータと異なるデータが取得された

---@class (exact) Locale メッセージのローカライズを管理するクラス
---@field package CACHE_DIR_ROOT string ロケールキャッシュディレクトリのルートパス
---@field package REMOTE_LOCALE_ENDPOINT string ロケールデータの外部取得先URI
---@field package CACHE_LIFETIME integer ローカルキャッシュの有効期限
---@field package HARDCODED_LOCALES {[string]: string} 外部からのロケール取得前に使用されるハードコードされた、最低限のローカライズメッセージ
---@field package localeVersion string? ロケールデータのバージョン
---@field package availableLocales {[string]: string} 利用可能なロケールのリスト
---@field package activeLocale string 現在有効になっているロケール
---@field package locales {[string]: {[string]: string}} ローカライズされたテキストを格納するテーブル
local Locale = {
	CACHE_DIR_ROOT = "Gakuto1112/FiguraBlueArchiveCrafters/locales/";
	REMOTE_LOCALE_ENDPOINT = "http://localhost/";
	CACHE_LIFETIME = 24 * 60 * 60 * 1000;

	HARDCODED_LOCALES = {
		["message.label.warn"] = "§e§l[WARN]§r ";
		["message.label.error"] = "§c§l[ERROR]§r ";
		["message.net_utils.err_not_allowed"] = "There is no permission to use Figura Networking API or access to the remote endpoint! Please allow Figura Networking API and add the remote domain \"%s\" to the Network Filter in Figura settings!";
		["message.net_utils.err_network"] = "Failed to send a request to the remote server.";
		["message.net_utils.err_response"] = "An error code (%d) was responded from the remote server (%s)";
		["message.locale.err_not_allowed"] = "There is no permission to use Figura File API";
		["message.locale.err_not_a_file"] = "Expected a file but a directory was specified (%s)";
		["message.locale.err_invalid_data"] = "Expected %s but fetched %s (%s)";
		["message.locale.err_io"] = "Failed to operate locale cache file";
		["message.locale.err_fetch_index"] = "Failed to fetch locale index data! Cannot proceed to localize! Error code: %s";
		["message.locale.err_fetch_en_us"] = "Failed to fetch default locale data! Cannot proceed to localize! Error code: %s";
		["message.locale.err_fetch_locale"] = "Failed to fetch selected locale data! (%s) Redirecting to \"en_us\" locale! Error code: %s";
		["message.locale.err_not_available"] = "The selected locale (%s) is not available! Redirecting to \"en_us\" locale.";
	};

	localeVersion = nil;
	availableLocales = {};
	activeLocale = "auto";
	locales = {};

	---初期化関数
	---@param self Locale
	init = function (self)
		if host:isHost() then
			-- ロケールデータの初期化
			self:initializeLocaleData()

			-- File APIの利用可能確認
			if self.checkAvailability() then
				-- インデックスの取得
				self:fetchLocaleIndex(function (status, data)
					if status == "SUCCESS" then
						local indexVersion = data["localeVersion"]
						local cacheVersion = Config:loadConfig("PUBLIC", "localeVersion", "v0.0.0")
						---@cast cacheVersion string
						if cacheVersion == nil or StringUtils.compareVersions(cacheVersion, indexVersion) ~= cacheVersion then
							self:flushCache()
							file:writeString(self.CACHE_DIR_ROOT .. "index.json", toJson(data), "utf8")
							Config:saveConfig("PUBLIC", "localeVersion", indexVersion)
						end

						-- インデックスの展開
						for key, value in pairs(data["availableLocales"]) do
							self.availableLocales[key] = value
						end

						-- 選択中のロケールの取得
						local currentLocale = self.activeLocale == "auto" and client:getActiveLang() or self.activeLocale
						if self.availableLocales[currentLocale] ~= nil then
							self.locales[currentLocale] = {}
							self:fetchLocale("core/" .. currentLocale .. ".json", function (status2, data2)
								if status2 == "SUCCESS" then
									---@cast data2 table
									for key, value in pairs(data2) do
										self.locales[currentLocale][key] = value
									end
									EventManager.events["ON_LOCALE_REFRESH"]:fire()
								else
									print(self:getLocalizedText("message.label.warn") .. self:getLocalizedText("message.locale.err_fetch_locale"):format(currentLocale, status2))
								end
							end)
							self:fetchLocale("avatars/" .. BlueArchiveCharacter.basic.avatarName .. "/" .. currentLocale .. ".json", function (status2, data2)
								if status2 == "SUCCESS" then
									---@cast data2 table
									for key, value in pairs(data2) do
										self.locales[currentLocale][key] = value
									end
									EventManager.events["ON_LOCALE_REFRESH"]:fire()
								else
									print(self:getLocalizedText("message.label.warn") .. self:getLocalizedText("message.locale.err_fetch_locale"):format(currentLocale, status2))
								end
							end)
						else
							print(self:getLocalizedText("message.label.warn") .. self:getLocalizedText("message.locale.err_not_available"):format(currentLocale))
						end
					else
						print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_fetch_index"):format(status))
					end
				end)

				-- en_usロケールの取得
				self:fetchLocale("core/en_us.json", function (status, data)
					if status == "SUCCESS" then
						---@cast data table
						for key, value in pairs(data) do
							self.locales["en_us"][key] = value
						end
						EventManager.events["ON_LOCALE_REFRESH"]:fire()
					else
						print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_fetch_en_us"):format(status))
					end
				end)
				self:fetchLocale("avatars/" .. BlueArchiveCharacter.basic.avatarName .. "/en_us.json", function (status, data)
					if status == "SUCCESS" then
						---@cast data table
						for key, value in pairs(data) do
							self.locales["en_us"][key] = value
						end
						EventManager.events["ON_LOCALE_REFRESH"]:fire()
					else
						print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_fetch_en_us"):format(status))
					end
				end)
			else
				print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_not_allowed"))
			end
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
				self:deleteDirectory(self.CACHE_DIR_ROOT:sub(1, -2))
			end
			if not file:mkdirs(self.CACHE_DIR_ROOT) or not file:mkdirs(self.CACHE_DIR_ROOT .. "core") or not file:mkdirs(self.CACHE_DIR_ROOT .. "avatars/" .. BlueArchiveCharacter.basic.avatarName) then
				print(self:getLocalizedText("message.locale.err_io"))
			end
		else
			print(self:getLocalizedText("message.locale.err_not_allowed"))
		end
	end;

	---キャッシュディレクトリからファイルを取得する。
	---@param self Locale
	---@param path string ロケールディレクトリからのファイルパス
	---@return Locale.CacheFetchResult result キャッシュの取得結果
	---@return boolean|string|number|table? data キャッシュから取得したデータ
	fetchFileFromCache = function (self, path)
		if self.checkAvailability() then
			if file:exists(self.CACHE_DIR_ROOT .. path) then
				if file:isFile(self.CACHE_DIR_ROOT .. path) then
					local stringData = file:readString(self.CACHE_DIR_ROOT .. path, "utf8")
					if json.isSerializable(stringData) then
						return "SUCCESS", parseJson(stringData)
					else
						return "SUCCESS", stringData
					end
				else
					return "ERR_NOT_A_FILE", nil
				end
			else
				return "ERR_NOT_FOUND", nil
			end
		else
			return "ERR_NOT_ALLOWED", nil
		end
	end;

	---リモートからファイルを取得する。
	---@param self Locale
	---@param path string 取得するファイルのパス。キャッシュディレクトリからのパスと同じにする。
	---@param callback fun(status: Locale.RemoteFetchResult, data: (boolean|string|number|table)?) ファイルの取得が完了した際に呼び出されるコールバック関数
	fetchFileFromRemote = function (self, path, callback)
		NetUtils:fetch(self.REMOTE_LOCALE_ENDPOINT .. path, function (status, data)
			if status == "SUCCESS" then
				---@cast data Buffer
				local stringData = data:readByteArray()
				if json.isSerializable(stringData) then
					callback("SUCCESS", parseJson(stringData))
				else
					callback("SUCCESS", stringData)
				end
			elseif status == "ERR_NOT_ALLOWED" then
				callback("ERR_NOT_ALLOWED", nil)
			elseif status == "ERR_NETWORK" then
				callback("ERR_NETWORK", nil)
			elseif status == "ERR_RESPONSE_CODE" then
				---@cast data integer
				callback("ERR_RESPONSE_CODE", data)
			end
		end)
	end;

	---ロケールインデックスを取得する。
	---@param self Locale
	---@param callback fun(status: Locale.FetchResult, data: (boolean|string|number|table)?) ロケールインデックスの取得が完了した際に呼び出されるコールバック関数
	fetchLocaleIndex = function (self, callback)
		-- ローカルキャッシュから取得
		local result, data = self:fetchFileFromCache("index.json")
		if result == "SUCCESS" then
			if type(data) ~= "table" then
				print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_invalid_data"):format("table", type(data), self.CACHE_DIR_ROOT .. "index.json"))
				data = nil
			end
		elseif result == "ERR_NOT_ALLOWED" then
			print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_not_allowed"))
		elseif result == "ERR_NOT_A_FILE" then
			print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_not_a_file"):format(self.CACHE_DIR_ROOT .. "index.json"))
		end

		-- ローカルキャッシュが有効か判断
		if result == "SUCCESS" then
			local lastFetchTime = Config:loadConfig("PUBLIC", "localeLastFetchTime", 0)
			if client:getSystemTime() - lastFetchTime <= self.CACHE_LIFETIME then
				callback("SUCCESS", data)
				return
			end
		end

		-- リモートから取得
		self:fetchFileFromRemote("index.json", function (status2, data2)
			if status2 == "SUCCESS" then
				if type(data2) == "table" then
					Config:saveConfig("PUBLIC", "localeLastFetchTime", client:getSystemTime())
					file:writeString(self.CACHE_DIR_ROOT .. "index.json", toJson(data2), "utf8")
					callback("SUCCESS", data2)
				else
					print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_invalid_data"):format("table", type(data2), self.REMOTE_LOCALE_ENDPOINT .. "index.json"))
					callback("ERR_INVALID_DATA", nil)
				end
			elseif status2 == "ERR_NOT_ALLOWED" then
				print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.net_utils.err_not_allowed"):format(self.REMOTE_LOCALE_ENDPOINT:match("://([^:/]+)")))
				callback("ERR_NOT_ALLOWED", nil)
			elseif status2 == "ERR_NETWORK" then
				print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.net_utils.err_network"))
				callback("ERR_NETWORK", nil)
			elseif status2 == "ERR_RESPONSE_CODE" then
				---@cast data2 integer
				print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.net_utils.err_response"):format(data2, self.REMOTE_LOCALE_ENDPOINT .. "index.json"))
				callback("ERR_RESPONSE_CODE", data2)
			end
		end)
	end;

	---ロケールデータを取得する。
	---@param self Locale
	---@param path string 取得するロケールデータのパス
	---@param callback fun(status: Locale.FetchResult, data: (boolean|string|number|table)?) ロケールデータの取得が完了した際に呼び出されるコールバック関数
	fetchLocale = function (self, path, callback)
		-- ローカルキャッシュから取得
		local result, data = self:fetchFileFromCache(path)
		if result == "SUCCESS" then
			if type(data) == "table" then
				callback("SUCCESS", data)
				return
			else
				print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_invalid_data"):format("table", type(data), self.CACHE_DIR_ROOT .. "index.json"))
				file:delete(self.CACHE_DIR_ROOT .. path)
				data = nil
			end
		elseif result == "ERR_NOT_ALLOWED" then
			print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_not_allowed"))
		elseif result == "ERR_NOT_A_FILE" then
			print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_not_a_file"):format(self.CACHE_DIR_ROOT .. "index.json"))
		end

		-- リモートから取得
		self:fetchFileFromRemote(path, function (status2, data2)
			if status2 == "SUCCESS" then
				if type(data2) == "table" then
					file:writeString(self.CACHE_DIR_ROOT .. path, toJson(data2), "utf8")
					callback("SUCCESS", data2)
				else
					print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_invalid_data"):format("table", type(data2), self.REMOTE_LOCALE_ENDPOINT .. "index.json"))
					callback("ERR_INVALID_DATA", nil)
				end
			elseif status2 == "ERR_NOT_ALLOWED" then
				print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.net_utils.err_not_allowed"):format(self.REMOTE_LOCALE_ENDPOINT:match("://([^:/]+)")))
				callback("ERR_NOT_ALLOWED", nil)
			elseif status2 == "ERR_NETWORK" then
				print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.net_utils.err_network"))
				callback("ERR_NETWORK", nil)
			elseif status2 == "ERR_RESPONSE_CODE" then
				---@cast data2 integer
				print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.net_utils.err_response"):format(data2, self.REMOTE_LOCALE_ENDPOINT .. "index.json"))
				callback("ERR_RESPONSE_CODE", data2)
			end
		end)
	end;

	---指定したパスのディレクトリを削除する。
	---ファイルが指定され場合でも削除する。
	---Figura File APIの`delete()`はディレクトリを空にしないと削除できないらしい。
	---@param self Locale
	---@param path string 削除するディレクトリのパス
	deleteDirectory = function (self, path)
		if file:isDirectory(path) then
			for _, childPath in ipairs(file:list(path)) do
				if file:isDirectory(path .. "/" .. childPath) then
					self:deleteDirectory(path .. "/" .. childPath)
				else
					if not file:delete(path .. "/" .. childPath) then
						print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_io"))
						return
					end
				end
			end
		end
		file:delete(path)
	end;

	---ロケールデータのキャッシュを削除する。
	---@param self Locale
	flushCache = function (self)
		if self.checkAvailability() then
			self:initializeLocaleDirectory()
		else
			print(self:getLocalizedText("message.label.error") .. self:getLocalizedText("message.locale.err_not_allowed"))
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
