---@alias UpdateChecker.CheckerStatus
---| "INIT" # 初期状態
---| "CHECKING" # アップデート確認中
---| "LATEST" # アップデート確認済み：最新版
---| "UPDATE_AVAILABLE" # アップデート確認済み：アップデートあり
---| "ERROR_INVALID_JSON" # エラー：予期しないJSONデータ
---| "ERROR_INVALID_JSON_SYNTAX" # エラー：不正なJSON構文
---| "ERROR_REQUEST_FAILED" # リクエストに失敗
---| "ERROR_NETWORK_ERR" # ネットワークエラー
---| "ERROR_NOT_ALLOWED" # ネットワーキングAPIが不許可

---@class (exact) UpdateChecker FBACのアップデートの確認を管理するクラス
---@field package AVATAR_VERSION string 現在のFBACバージョン
---@field public UPDATE_CHECK_ENDPOINT_URI string アップデート確認のためのAPIエンドポイントURI
---@field public RELEASE_PAGE_URL string アバターのリリースページのURL
---@field public latestVersion string リモート上にある最新のFBACバージョン
---@field public checkerStatus UpdateChecker.CheckerStatus アップデートチェッカーの状態
---@field public lastCheckTime integer 最後に更新を確認した時間（UNIX時間）
---@field package requestStatus integer 送信したリクエストのステータスコード
---@field package responseHandler Future.HttpResponse|nil httpレスポンスのハンドラ
---@field package textAnimationCount integer 新しいバージョン表示のテキストのアニメーションのカウンター
local UpdateChecker = {
	AVATAR_VERSION = "v3.1.1";
	UPDATE_CHECK_ENDPOINT_URI = "https://api.github.com/repos/Gakuto1112/FiguraBlueArchiveCrafters/tags";
	RELEASE_PAGE_URL = "https://github.com/Gakuto1112/FiguraBlueArchiveCrafters/releases/tag/";

	latestVersion = "v0.0.0";
	checkerStatus = "INIT";
	lastCheckTime = 0;
	requestStatus = 0;
	responseHandler = nil;
	textAnimationCount = 0;

    ---初期化関数
    ---@param self UpdateChecker
    init = function (self)
        if host:isHost() then
			self.latestVersion = Config:loadConfig("PUBLIC", "update_checker.latest_version", "v0.0.0")
			self.lastCheckTime = Config:loadConfig("PUBLIC", "update_checker.last_update_check_time", 0)

            models.models.action_wheel_gui.Gui.VersionDisplay:getTask("action_wheel.gui.version_display.l2"):setText(self.AVATAR_VERSION)

            if client:getSystemTime() >= self.lastCheckTime + 86400000 then
                self:checkUpdate()
            else
                local newerVersion = StringUtils.compareVersions(self.latestVersion, self.AVATAR_VERSION)
                if newerVersion ~= nil and newerVersion ~= self.AVATAR_VERSION then
                    self:showNewUpdateMessage()
                    self.checkerStatus = "UPDATE_AVAILABLE"
                else
                    self.checkerStatus = "LATEST"
                end
            end

			EventManager.events["ON_ACTION_WHEEL_OPEN"]:register(function ()
				local textTask = models.models.action_wheel_gui.Gui.VersionDisplay:getTask("action_wheel.gui.version_display.l4")
				if self.checkerStatus == "UPDATE_AVAILABLE" then
						events.TICK:register(function ()
						if math.floor(self.textAnimationCount / 20) % 2 == 0 then
							textTask:setText("§6§n" .. Locale:getLocalizedText("action_wheel.gui.update_check.update_available"):format(self.latestVersion))
						else
							textTask:setText("§n" .. Locale:getLocalizedText("action_wheel.gui.update_check.update_available"):format(self.latestVersion))
						end
						self.textAnimationCount = self.textAnimationCount + 1
					end, "update_check_text_animation_tick")
				elseif self.checkerStatus == "ERROR_REQUEST_FAILED" then
					textTask:setText(Locale:getLocalizedText("action_wheel.gui.update_check.error_request_failed"):format(tostring(self.requestStatus)))
				else
					textTask:setText(Locale:getLocalizedText("action_wheel.gui.update_check." .. StringUtils.lower(self.checkerStatus)))
				end
			end)

			EventManager.events["ON_ACTION_WHEEL_CLOSE"]:register(function ()
				events.TICK:remove("update_check_text_animation_tick")
				self.textAnimationCount = 0
			end)
        end
    end;

    ---新FBACバージョンのお知らせを表示する。
    ---@param self UpdateChecker
    showNewUpdateMessage = function (self)
        print(Locale:getLocalizedText("action_wheel.gui.update_check.update_available"):format(tostring(self.latestVersion)))
        sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 1, 1)
    end;

    ---FBACアップデートの確認を行う。
    ---@param self UpdateChecker
    checkUpdate = function (self)
        if host:isHost() and self.checkerStatus ~= "CHECKING" then
            self.checkerStatus = "CHECKING"
			NetUtils:fetch(self.UPDATE_CHECK_ENDPOINT_URI, function (status, data)
				if status == "SUCCESS" then
					---@cast data Buffer
					local jsonData = NetUtils.toJson(data)
					if type(jsonData) == "table" then
						if jsonData[1] ~= nil and jsonData[1].name ~= nil then
							local newerVersion = StringUtils.compareVersions(jsonData[1].name, self.AVATAR_VERSION)
							if newerVersion ~= nil then
								if newerVersion ~= self.AVATAR_VERSION then
									--新しいバージョンがある
									self.latestVersion = jsonData[1].name
									self.checkerStatus = "UPDATE_AVAILABLE"
									self:showNewUpdateMessage()
								else
									--現在は最新
									self.latestVersion = jsonData[1].name
									self.checkerStatus = "LATEST"
								end
								self.lastCheckTime = client:getSystemTime()
								Config:saveConfig("PUBLIC", "update_checker.last_update_check_time", self.lastCheckTime)
								Config:saveConfig("PUBLIC", "update_checker.latest_version", self.latestVersion)
							else
								--予期しないJSONデータ
								self.checkerStatus = "ERROR_INVALID_JSON"
							end
						end
					else
						self.checkerStatus = "ERROR_INVALID_JSON_SYNTAX"
					end
				elseif status == "ERR_NOT_ALLOWED" then
					self.checkerStatus = "ERROR_NOT_ALLOWED"
				elseif status == "ERR_RESPONSE_CODE" then
					self.checkerStatus = "ERROR_REQUEST_FAILED"
					---@cast data integer
					self.requestStatus = data
				elseif status == "ERR_NETWORK" then
					self.checkerStatus = "ERROR_NETWORK_ERR"
				end
			end)
		end
	end;
}

return UpdateChecker
