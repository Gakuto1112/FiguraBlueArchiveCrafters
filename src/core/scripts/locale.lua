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
---| "ERR_IO"            # キャッシュファイルの読み書きに失敗した

---@class (exact) Locale メッセージのローカライズを管理するクラス
---@field package CACHE_DIR_ROOT string ロケールキャッシュディレクトリのルートパス
---@field package REMOTE_LOCALE_ENDPOINT string ロケールデータの外部取得先URI
---@field package CACHE_LIFETIME integer ローカルキャッシュの有効期限
---@field package HARDCODED_LOCALES {[string]: string} 外部からのロケール取得前に使用されるハードコードされた、最低限のローカライズメッセージ
---@field package localeVersion string? ロケールデータのバージョン
---@field public availableLocales {[string]: string} 利用可能なロケールのリスト
---@field package locales {[string]: {[string]: string}} ローカライズされたテキストを格納するテーブル
---@field public isFetching boolean ロケールデータの取得中かどうか
---@field package localeDataChecks integer ロケールデータの取得試行回数
---@field package localePrev string 前ティックのゲームのロケール
---@field package errorCode Locale.FetchResult ロケールデータの取得結果コード
---@field package localeDataPrev {[string]: table|string|nil}|nil ロケールデータの際フェッチ前のロケールデータのコピー
---@field package isForcedRemoteFetch boolean ローカルキャッシュを無視して、リモートからのフェッチを強制するかどうか。
local Locale = {
	CACHE_DIR_ROOT = "Gakuto1112/FiguraBlueArchiveCrafters/locales/";
	REMOTE_LOCALE_ENDPOINT = "https://raw.githubusercontent.com/Gakuto1112/FBAC_Locales/refs/heads/main/src/";
	CACHE_LIFETIME = 24 * 60 * 60 * 1000;

	HARDCODED_LOCALES = {
		["action_wheel.gui.update_check.checking"] = "Checking for updates...";
		["action_wheel.gui.update_check.latest"] = "No FBAC update available";
		["action_wheel.gui.update_check.update_available"] = "New FBAC update is available: %s";
		["action_wheel.gui.update_check.error_not_allowed"] = "Failed to check for updates - Networking API not allowed";
		["action_wheel.gui.update_check.error_network_err"] = "Failed to check for updates - Network error";
		["action_wheel.gui.update_check.error_request_failed"] = "Failed to check for updates - Request failure (%s)";
		["action_wheel.gui.update_check.error_invalid_json_syntax"] = "Failed to check for updates - Json parsing failure";
		["action_wheel.gui.update_check.error_invalid_json"] = "Failed to check for updates - Unexpected Response";
		["action_wheel.gui.update_check.locale_version"] = "Locale version: %s";

		["message.net_utils.not_allowed"] = "§9§l[TIP]§r There is no permission to use Figura Networking API or access to the remote endpoint. Please allow using Figura Networking API and add the remote domain \"§b%s§r\" to the Network Filter in Figura settings.";
		["message.locale.fail"] = "Failed to fetch locale data. Error code: §b%s";
	};

	localeVersion = nil;
	availableLocales = {};
	locales = {};
	isFetching = false;
	localeDataChecks = 0;
	localePrev = "en_us";
	errorCode = "SUCCESS";
	localeDataPrev = nil;
	isForcedRemoteFetch = false;

	---初期化関数
	---@param self Locale
	init = function (self)
		if host:isHost() then
			self:initializeLocale()
		end

		self.localePrev = client:getActiveLang()
		events.TICK:register(function ()
			local locale = client:getActiveLang()
			if locale ~= self.localePrev then
				if self.locales[locale] == nil and self.availableLocales[locale] ~= nil then
					self.locales[locale] = {}
					self:fetchLocaleDataSet(locale)
				end
				self:onLocaleRefresh()
				self.localePrev = locale
			end
		end)
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
		if not self.checkAvailability() then
			return
		end

		if file:exists(self.CACHE_DIR_ROOT) then
			self:deleteDirectory(self.CACHE_DIR_ROOT:sub(1, -2))
		end
		file:mkdirs(self.CACHE_DIR_ROOT)
		file:mkdirs(self.CACHE_DIR_ROOT .. "core")
		file:mkdirs(self.CACHE_DIR_ROOT .. "avatars/" .. BlueArchiveCharacter.basic.avatarName)
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
		if not self.isForcedRemoteFetch then
			-- ローカルキャッシュから取得
			local result, data = self:fetchFileFromCache("index.json")
			if result == "SUCCESS" and type(data) ~= "table" then
				data = nil
			end

			-- ローカルキャッシュが有効か判断
			if result == "SUCCESS" then
				local lastFetchTime = Config:loadConfig("PUBLIC", "locale.last_fetch_time", 0)
				if client:getSystemTime() - lastFetchTime <= self.CACHE_LIFETIME then
					callback("SUCCESS", data)
					return
				end
			end
		end

		-- リモートから取得
		self:fetchFileFromRemote("index.json", function (status2, data2)
			if status2 == "SUCCESS" then
				if type(data2) == "table" then
					Config:saveConfig("PUBLIC", "locale.last_fetch_time", client:getSystemTime())
					file:writeString(self.CACHE_DIR_ROOT .. "index.json", toJson(data2), "utf8")
					callback("SUCCESS", data2)
				else
					callback("ERR_INVALID_DATA", data)
				end
			elseif status2 == "ERR_NOT_ALLOWED" then
				callback("ERR_NOT_ALLOWED", data)
			elseif status2 == "ERR_NETWORK" then
				callback("ERR_NETWORK", data)
			elseif status2 == "ERR_RESPONSE_CODE" then
				---@cast data2 integer
				callback("ERR_RESPONSE_CODE", data2)
			end
		end)
	end;

	---ロケールデータを取得する。
	---@param self Locale
	---@param path string 取得するロケールデータのパス
	---@param callback fun(status: Locale.FetchResult, data: (boolean|string|number|table)?) ロケールデータの取得が完了した際に呼び出されるコールバック関数
	fetchLocaleData = function (self, path, callback)
		if not self.isForcedRemoteFetch then
			-- ローカルキャッシュから取得
			local result, data = self:fetchFileFromCache(path)
			if result == "SUCCESS" then
				if type(data) == "table" then
					callback("SUCCESS", data)
					return
				else
					file:delete(self.CACHE_DIR_ROOT .. path)
					data = nil
				end
			end
		end

		-- リモートから取得
		self:fetchFileFromRemote(path, function (status2, data2)
			if status2 == "SUCCESS" then
				if type(data2) == "table" then
					file:writeString(self.CACHE_DIR_ROOT .. path, toJson(data2), "utf8")
					callback("SUCCESS", data2)
				else
					callback("ERR_INVALID_DATA", nil)
				end
			elseif status2 == "ERR_NOT_ALLOWED" then
				callback("ERR_NOT_ALLOWED", nil)
			elseif status2 == "ERR_NETWORK" then
				callback("ERR_NETWORK", nil)
			elseif status2 == "ERR_RESPONSE_CODE" then
				callback("ERR_RESPONSE_CODE", data2)
			end
		end)
	end;

	---ロケールデータのコアとキャラクターのセットを取得する。
	---@param self Locale
	---@param locale string 取得するロケールのMinecraft内部の識別子（例: "en_us", "ja_jp"）
	fetchLocaleDataSet = function (self, locale)
		self:fetchLocaleData("core/" .. locale .. ".json", function (status, data)
			if status == "SUCCESS" then
				---@cast data table
				for key, value in pairs(data) do
					self.locales[locale][key] = value
				end
			else
				self.errorCode = status
			end
			self.localeDataChecks = self.localeDataChecks + 1
			if self.localeDataChecks == 4 then
				self:onLocaleRefresh()
			end
		end)
		self:fetchLocaleData("avatars/" .. BlueArchiveCharacter.basic.avatarName .. "/" .. locale .. ".json", function (status, data)
			if status == "SUCCESS" then
				---@cast data table
				for key, value in pairs(data) do
					self.locales[locale][key] = value
				end
			else
				self.errorCode = status
			end

			self.localeDataChecks = self.localeDataChecks + 1
			if self.localeDataChecks == 4 then
				self:onLocaleRefresh()
			end
		end)
	end;

	---ロケールの初期化を行う。
	---ロケールインデックスから必要なロケールの取得まで行う。
	---@param self Locale
	initializeLocale = function (self)
		self.isFetching = true
		self.errorCode = "SUCCESS"

		-- ロケールデータの初期化
		self:initializeLocaleData()

		-- File APIの利用可能確認
		if self.checkAvailability() then
			if not file:exists(self.CACHE_DIR_ROOT .. "avatars/" .. BlueArchiveCharacter.basic.avatarName) then
				file:mkdirs(self.CACHE_DIR_ROOT .. "avatars/" .. BlueArchiveCharacter.basic.avatarName)
			end

			-- インデックスの取得
			local locale = client:getActiveLang()
			self:fetchLocaleIndex(function (status, data)
				local cacheVersion = Config:loadConfig("PUBLIC", "locale.version", "v0.0.0")
				self.localeVersion = cacheVersion
				if status ~= "SUCCESS" then
					self.errorCode = status
				end

				if type(data) == "table" then
					local indexVersion = data["localeVersion"]
					---@cast cacheVersion string
					if cacheVersion == nil and indexVersion ~= nil or StringUtils.isNewerVersion(indexVersion, cacheVersion) then
						self:flushCache()
						self:initializeLocaleDirectory()
						file:writeString(self.CACHE_DIR_ROOT .. "index.json", toJson(data), "utf8")
						self.localeVersion = indexVersion
						Config:saveConfig("PUBLIC", "locale.version", indexVersion)
					end

					-- インデックスの展開
					if type(data) == "table" then
						for key, value in pairs(data["availableLocales"]) do
							self.availableLocales[key] = value
						end
					end

					-- 選択中のロケールの取得
					if self.availableLocales[locale] ~= nil then
						if locale ~= "en_us" then
							self.locales[locale] = {}
							self:fetchLocaleDataSet(locale)
						end
					else
						self.localeDataChecks = self.localeDataChecks + 2
						if self.localeDataChecks == 4 then
							self:onLocaleRefresh()
						end
					end
				else
					-- フェッチ失敗。キャッシュもなし。
					self.localeVersion = nil
					self.errorCode = status
					self:onLocaleRefresh()
				end
				-- en_usロケールの取得
				self:fetchLocaleDataSet("en_us")
			end)
		else
			self.errorCode = "ERR_NOT_ALLOWED"
			self:onLocaleRefresh()
		end
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
					file:delete(path .. "/" .. childPath)
				end
			end
		end

		file:delete(path)
	end;

	---ロケールデータのキャッシュを削除する。
	---@param self Locale
	flushCache = function (self)
		if not self.checkAvailability() then
			self.errorCode = "ERR_NOT_ALLOWED"
			ActionWheelConfig.isLocaleDataFetchErrorOccurred = true
			ActionWheelConfig.isLocaleReloadedByAction = false
			self:onLocaleRefresh()
			return
		end

		self:makeLocaleBackup()

		self.isForcedRemoteFetch = true
	end;

	---メモリ上にあるロケールデータを、同じくメモリ上にバックアップする。
	---@param self Locale
	makeLocaleBackup = function (self)
		self.localeDataPrev = {}
		self.localeDataPrev["localeVersion"] = self.localeVersion
		self.localeDataPrev["locales"] = self.locales
		self.localeDataPrev["availableLocales"] = self.availableLocales
	end;

	---翻訳キーに対応するローカライズされたテキストを返す。
	---現在有効なロケールでのテキストが見つからない場合は、英語（en_us）でのテキストを返す。
	---どちらも見つからない場合は、翻訳キー自体を返す。
	---@param self Locale
	---@param key string ローカライズされたテキストを取得するための翻訳キー
	---@param forceGlobal? boolean `true`にすると、現在のロケールに関係なく、グローバルロケール（en_us）からテキストを取得する。
	---@return string localizedText ローカライズされたテキスト、または翻訳キー自体。
	getLocalizedText = function (self, key, forceGlobal)
		local locale = client:getActiveLang()
		if not forceGlobal and self.locales[locale] ~= nil and self.locales[locale][key] ~= nil then
			return self.locales[locale][key]
		elseif self.locales["en_us"] ~= nil and self.locales["en_us"][key] ~= nil then
			return self.locales["en_us"][key]
		else
			return key
		end
	end;

	---ロケールの（再）読み込みが完了した際に呼び出すイベント関数。
	---ロケールの読み込みの成否問わず、処理完了時に呼び出す。
	---@param self Locale
	onLocaleRefresh = function (self)
		events.TICK:register(function ()
			models.models.action_wheel_gui.Gui.VersionDisplay:getTask("action_wheel.gui.version_display.l3"):setText(Locale:getLocalizedText("action_wheel.gui.update_check.locale_version"):format(self.localeVersion or "v?.?.?"))
			events.TICK:remove("locale_set_locale_version_delay_tick")
		end, "locale_set_locale_version_delay_tick")
		self.isFetching = false
		self.localeDataChecks = 0
		ActionWheelConfig.isLocaleDataFetchErrorOccurred = true
		ActionWheelConfig.isLocaleReloadedByAction = false

		if self.errorCode ~= "SUCCESS" then
			if self.localeDataPrev ~= nil then
				---@diagnostic disable-next-line: assign-type-mismatch
				self.localeVersion = self.localeDataPrev["localeVersion"]
				---@diagnostic disable-next-line: assign-type-mismatch
				self.locales = self.localeDataPrev["locales"]
				---@diagnostic disable-next-line: assign-type-mismatch
				self.availableLocales = self.localeDataPrev["availableLocales"]
			end

			print(Locale:getLocalizedText("message.locale.fail"):format(self.errorCode))
			if self.errorCode == "ERR_NOT_ALLOWED" then
				print(Locale:getLocalizedText("message.net_utils.not_allowed"):format(self.REMOTE_LOCALE_ENDPOINT:match("://([^:/]+)")))
			end
		end

		EventManager.events["ON_LOCALE_READY"]:fire()
	end
}

return Locale
