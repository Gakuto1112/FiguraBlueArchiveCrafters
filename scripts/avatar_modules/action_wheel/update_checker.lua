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

---@class (exact) UpdateChecker : AvatarModule FBACのアップデートの確認を管理するクラス
---@field package FBAC_VERSION string 現在のFBACバージョン
---@field package BRANCH_NAME string このブランチ名（キャラクター名）
---@field public latestVersion? string リモート上にある最新のFBACバージョン
---@field public checkerStatus UpdateChecker.CheckerStatus アップデートチェッカーの状態
---@field package requestStatus integer 送信したリクエストのステータスコード
---@field package responseHandler Future.HttpResponse|nil httpレスポンスのハンドラ
---@field package textAnimationCount integer 新しいバージョン表示のテキストのアニメーションのカウンター
---@field package isActionWheelOpenedPrev boolean 前ティックにアクションホイールを開けていたかどうか
---@field package compareVersions fun(version1: string, version2: string): string|nil 2つのバージョン文字列を比較し、新しい方を返す
---@field package showNewUpdateMessage fun(self: UpdateChecker) 新FBACバージョンのお知らせを表示する
---@field public checkUpdate fun(self: UpdateChecker) FBACアップデートの確認を行う

UpdateChecker = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return UpdateChecker
    new = function (parent)
        ---@type UpdateChecker
        local instance = Avatar.instantiate(UpdateChecker, AvatarModule, parent)

        instance.FBAC_VERSION = "v2.1.0_dev"
        instance.BRANCH_NAME = "BaseAvatar"
        instance.latestVersion = instance.parent.config:loadConfig("PUBLIC", "latestVersion", nil)
        instance.checkerStatus = "INIT"
        instance.requestStatus = 0
        instance.textAnimationCount = 0

        return instance
    end;

    ---初期化関数
    ---@param self UpdateChecker
    init = function (self)
        AvatarModule.init(self)

        if host:isHost() then
            models.models.action_wheel_gui.Gui.VersionDisplay:getTask("action_wheel.gui.version_display.l2"):setText(self.FBAC_VERSION.." - "..self.BRANCH_NAME)

            events.TICK:register(function ()
                local isActionWheelOpened = action_wheel:isEnabled()
                if isActionWheelOpened then
                    local textTask = models.models.action_wheel_gui.Gui.VersionDisplay:getTask("action_wheel.gui.version_display.l3")
                    local newerVersion = self.compareVersions(self.latestVersion, self.FBAC_VERSION)
                    if newerVersion ~= nil and newerVersion ~= self.FBAC_VERSION then
                        if math.floor(self.textAnimationCount / 20) % 2 == 0 then
                            textTask:setText("§6§n"..self.parent.locale:getLocale("action_wheel.gui.update_check.update_available")..self.latestVersion)
                        else
                            textTask:setText("§n"..self.parent.locale:getLocale("action_wheel.gui.update_check.update_available")..self.latestVersion)
                        end
                        self.textAnimationCount = self.textAnimationCount + 1
                    end
                    if self.checkerStatus == "ERROR_REQUEST_FAILED" then
                        textTask:setText(self.parent.locale:getLocale("action_wheel.gui.update_check.error_request_failed").."("..self.requestStatus..")")
                    else
                        textTask:setText(self.parent.locale:getLocale("action_wheel.gui.update_check."..self.checkerStatus:lower()))
                    end
                elseif not isActionWheelOpened and self.isActionWheelOpenedPrev then
                    self.textAnimationCount = 0
                end
                self.isActionWheelOpenedPrev = isActionWheelOpened
            end)

            local lastUpdateCheckTime = self.parent.config:loadConfig("PUBLIC", "lastUpdateCheckTime", 0)
            if client:getSystemTime() >= lastUpdateCheckTime + 86400000 then
                self:checkUpdate()
            else
                local newerVersion = self.compareVersions(self.latestVersion, self.FBAC_VERSION)
                if newerVersion ~= nil and newerVersion ~= self.FBAC_VERSION then
                    self:showNewUpdateMessage()
                    self.checkerStatus = "UPDATE_AVAILABLE"
                else
                    self.checkerStatus = "LATEST"
                end
            end
        end
    end;

    ---2つのバージョン文字列を比較し、新しい方を返す。
    ---@param version1 string 比較するバージョン文字列1
    ---@param version2 string 比較するバージョン文字列2
    ---@return string|nil newerVersion 新しい方のバージョン文字列。比較不可能だった場合はnilを返す。
    compareVersions = function (version1, version2)
        local major1, minor1, patch1 = version1:match("^v(%d+)%.(%d+)%.(%d+)")
        local major2, minor2, patch2 = version2:match("^v(%d+)%.(%d+)%.(%d+)")
        major1 = tonumber(major1)
        minor1 = tonumber(minor1)
        patch1 = tonumber(patch1)
        major2 = tonumber(major2)
        minor2 = tonumber(minor2)
        patch2 = tonumber(patch2)
        if major1 ~= nil and minor1 ~= nil and patch1 ~= nil and major2 ~= nil and minor2 ~= nil and patch2 ~= nil then
            return (major1 > major2 or (major1 == major2 and minor1 > minor2) or (major1 == major2 and minor1 == minor2 and patch1 > patch2)) and version1 or version2
        end
    end;

    ---新FBACバージョンのお知らせを表示する。
    ---@param self UpdateChecker
    showNewUpdateMessage = function (self)
        print(self.parent.locale:getLocale("action_wheel.gui.update_check.update_available")..self.latestVersion)
        sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:entity.experience_orb.pickup"), player:getPos(), 1, 1)
    end;

    ---FBACアップデートの確認を行う。
    ---@param self UpdateChecker
    checkUpdate = function (self)
        if host:isHost() and self.checkerStatus ~= "CHECKING" then
            self.checkerStatus = "CHECKING"
            if net:isNetworkingAllowed() and net:isLinkAllowed("https://api.github.com") then
                local request = net.http:request("https://api.github.com/repos/Gakuto1112/FiguraBlueArchiveCharacters/tags")
                self.responseHandler = request:send()
                events.TICK:register(function ()
                    if self.responseHandler:isDone() then
                        local response = self.responseHandler:getValue()
                        if response ~= nil then
                            local stats = response:getResponseCode()
                            if math.floor(stats / 100) == 2 then
                                local stream = response:getData()
                                local buffer = data:createBuffer()
                                buffer:readFromStream(stream)
                                buffer:setPosition(0)
                                local jsonData = buffer:readByteArray()
                                if json.isSerializable(jsonData) then
                                    local parseData = parseJson(jsonData)
                                    if parseData[1] ~= nil and parseData[1].name ~= nil then
                                        local newerVersion = self.compareVersions(parseData[1].name, self.FBAC_VERSION)
                                        if newerVersion ~= nil then
                                            if newerVersion ~= self.FBAC_VERSION then
                                                --新しいバージョンがある
                                                self.latestVersion = parseData[1].name
                                                self.checkerStatus = "UPDATE_AVAILABLE"
                                                self:showNewUpdateMessage()
                                            else
                                                --現在は最新
                                                self.latestVersion = parseData[1].name
                                                self.checkerStatus = "LATEST"
                                            end
                                            self.parent.config:saveConfig("PUBLIC", "lastUpdateCheckTime", client:getSystemTime())
                                            self.parent.config:saveConfig("PUBLIC", "latestVersion", parseData[1].name)
                                        else
                                            --予期しないJSONデータ
                                            self.checkerStatus = "ERROR_INVALID_JSON"
                                        end
                                    else
                                        --予期しないJSONデータ
                                        self.checkerStatus = "ERROR_INVALID_JSON"
                                    end
                                else
                                    --JSON解析エラー
                                    self.checkerStatus = "ERROR_INVALID_JSON_SYNTAX"
                                end
                                stream:close()
                                buffer:close()
                            else
                                --ステータスコードが200番台以外
                                self.checkerStatus = "ERROR_REQUEST_FAILED"
                                self.requestStatus = stats
                            end
                        else
                            --ネットワークエラー
                            self.checkerStatus = "ERROR_NETWORK_ERR"
                        end
                        events.TICK:remove("update_checker_http_tick")
                    end
                end, "update_checker_http_tick")
            else
                ---ネットワーキングAPIが不許可
                self.checkerStatus = "ERROR_NOT_ALLOWED"
            end
        end
    end;
}
