---@class (exact) ActionWheel : AvatarModule アクションホイールを管理するクラス
---@field package mainPage Page アクションホイールのメインページのインスタンスへの参照
---@field package selectingCostume integer 現在選択中の衣装
---@field package selectingName integer 現在選択中の表示名
---@field package selectingShouldShowClubName boolean 現在選択中の「部活名を表示するかどうか」
---@field package selectingExSkillParticleAmount integer 現在選択中のExスキルフレームのパーティクル量
---@field public shouldReplaceVehicleModels boolean 乗り物のモデルを置き換えるかどうか
---@field package fpmCompatibilityMode boolean First-person Model互換モードが有効かどうか
---@field package fpmMassageShowed boolean First-person Model互換モードに関するメッセージを表示したかどうか
---@field package isActionWheelOpenedPrev boolean 前ティックにアクションホイールを開けていたかどうか
---@field package currentTime integer アクションホイールを開けた瞬間の時間（UNIX時間）
---@field package refreshCostumeChangeActionTitle fun(self: ActionWheel) 衣装変更アクションのタイトルを更新する
---@field package refreshNameChangeActionTitle fun(self: ActionWheel) 名前変更アクションのタイトルを更新する
---@field package refreshExSkillParticleActionTitle fun(self: ActionWheel) Exスキルアニメーションのパーティクル量調整アクションのタイトルを更新する
---@field package refreshUpdateActionStatus fun(self: ActionWheel) アップデート確認アクションの状態を更新する
---@field package fpmCompatibilityModeRender fun(_, context: Event.Render.context) First-person Model互換性モードにおけるレンダー関数

ActionWheel = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return ActionWheel
    new = function (parent)
        ---@type ActionWheel
        local instance = Avatar.instantiate(ActionWheel, AvatarModule, parent)

        instance.mainPage = action_wheel:newPage("main")
        instance.selectingCostume = instance.parent.costume.currentCostume
        instance.selectingName = instance.parent.nameplate.currentName
        instance.selectingShouldShowClubName = instance.parent.nameplate.shouldShowClubName
        instance.selectingExSkillParticleAmount = instance.parent.exSkill.frameParticleAmount
        instance.shouldReplaceVehicleModels = instance.parent.config:loadConfig("PRIVATE", "replaceVehicleModels", true)
        instance.fpmCompatibilityMode = instance.parent.config:loadConfig("PRIVATE", "fpmCompatibilityMode", false)
        instance.fpmMassageShowed = false
        instance.isActionWheelOpenedPrev = false
        instance.currentTime = 0

        return instance
    end;

    ---初期化関数
    ---@param self ActionWheel
    init = function (self)
        AvatarModule.init(self)

        if host:isHost() then
            events.TICK:register(function()
                local isActionWheelOpened = action_wheel:isEnabled()
                if isActionWheelOpened  then
                    local mainAction3 = self.mainPage:getAction(3)
                    mainAction3:setTitle(self.parent.locale:getLocale("action_wheel.main.action_3.title").."§c"..self.parent.locale:getLocale("action_wheel.toggle_off"))
                    mainAction3:setToggleTitle(self.parent.locale:getLocale("action_wheel.main.action_3.title").."§a"..self.parent.locale:getLocale("action_wheel.toggle_on"))
                    local mainAction4 = self.mainPage:getAction(4)
                    mainAction4:setTitle(self.parent.locale:getLocale("action_wheel.main.action_4.title").."§c"..self.parent.locale:getLocale("action_wheel.toggle_off"))
                    mainAction4:setToggleTitle(self.parent.locale:getLocale("action_wheel.main.action_4.title").."§a"..self.parent.locale:getLocale("action_wheel.toggle_on"))
                    local mainAction6 = self.mainPage:getAction(6)
                    if self.parent.characterData.actionWheel.isVehicleOptionEnabled then
                        mainAction6:setTitle(self.parent.locale:getLocale("action_wheel.main.action_6.title").."§c"..self.parent.locale:getLocale("action_wheel.toggle_off"))
                    else
                        mainAction6:setTitle("§7"..self.parent.locale:getLocale("action_wheel.main.action_6.title")..self.parent.locale:getLocale("action_wheel.toggle_off"))
                    end
                    mainAction6:setToggleTitle(self.parent.locale:getLocale("action_wheel.main.action_6.title").."§a"..self.parent.locale:getLocale("action_wheel.toggle_on"))
                    local mainAction7 = self.mainPage:getAction(7)
                    mainAction7:setTitle(self.parent.locale:getLocale("action_wheel.main.action_7.title").."§c"..self.parent.locale:getLocale("action_wheel.toggle_off"))
                    mainAction7:setToggleTitle(self.parent.locale:getLocale("action_wheel.main.action_7.title").."§a"..self.parent.locale:getLocale("action_wheel.toggle_on"))
                    self.currentTime = client:getSystemTime()
                    self:refreshCostumeChangeActionTitle()
                    self:refreshNameChangeActionTitle()
                    self:refreshExSkillParticleActionTitle()
                    self:refreshUpdateActionStatus()
                elseif not isActionWheelOpened and self.isActionWheelOpenedPrev then
                    if self.selectingCostume ~= self.parent.costume.currentCostume then
                        pings.actionWheelChangeCostume(self.selectingCostume)
                        self.parent.config:saveConfig("PRIVATE", "costume", self.selectingCostume)
                        sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:item.armor.equip_leather"), player:getPos())
                        print(self.parent.locale:getLocale("action_wheel.main.action_1.done_first")..self.parent.costume:getCostumeLocalName(self.selectingCostume)..self.parent.locale:getLocale("action_wheel.main.action_1.done_last"))
                    end
                    if self.selectingName ~= self.parent.nameplate.currentName or self.selectingShouldShowClubName ~= self.parent.nameplate.shouldShowClubName then
                        pings.actionWheelChangeName(self.selectingName, self.selectingShouldShowClubName)
                        self.parent.config:saveConfig("PRIVATE", "name", self.selectingName)
                        self.parent.config:saveConfig("PRIVATE", "showClubName", self.selectingShouldShowClubName)
                        sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:ui.cartography_table.take_result"), player:getPos())
                        print(self.parent.locale:getLocale("action_wheel.main.action_2.done_first")..self.parent.nameplate:getName(self.selectingName)..self.parent.locale:getLocale("action_wheel.main.action_2.done_last"))
                    end
                    if self.selectingExSkillParticleAmount ~= self.parent.exSkill.frameParticleAmount then
                        self.parent.exSkill.frameParticleAmount = self.selectingExSkillParticleAmount
                        self.parent.config:saveConfig("PRIVATE", "exSkillFrameParticleAmount", self.selectingExSkillParticleAmount)
                        sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:entity.item.pickup"), player:getPos(), 1, 0.5)
                        print(self.parent.locale:getLocale("action_wheel.main.action_5.done_first")..self.parent.locale:getLocale("action_wheel.main.action_5.option_"..self.selectingExSkillParticleAmount)..self.parent.locale:getLocale("action_wheel.main.action_5.done_last"))
                    end
                end
                self.isActionWheelOpenedPrev = isActionWheelOpened
            end)

            --アクションの設定

            --アクション1. 衣装を変更
            self.mainPage:newAction(1):setItem(self.parent.compatibilityUtils:checkItem("minecraft:leather_chestplate")):setOnScroll(function(direction)
                if #self.parent.costume.costumeList >= 2 then
                    if direction < 0 then
                        self.selectingCostume = self.selectingCostume == #self.parent.costume.costumeList and 1 or self.selectingCostume + 1
                    else
                        self.selectingCostume = self.selectingCostume == 1 and #self.parent.costume.costumeList or self.selectingCostume - 1
                    end
                    self:refreshCostumeChangeActionTitle()
                else
                    print(self.parent.locale:getLocale("action_wheel.main.action_1.unavailable"))
                end
            end):setOnLeftClick(function()
                if #self.parent.costume.costumeList >= 2 then
                    self.selectingCostume = self.parent.costume.currentCostume
                    self:refreshCostumeChangeActionTitle()
                end
            end):setOnRightClick(function()
                if #self.parent.costume.costumeList >= 2 then
                    self.selectingCostume = 1
                    self:refreshCostumeChangeActionTitle()
                end
            end)

            if #self.parent.costume.costumeList >= 2 then
                local action = self.mainPage:getAction(1)
                action:setColor(0.78, 0.78, 0.78)
                action:setHoverColor(1, 1, 1)
            else
                local action = self.mainPage:getAction(1)
                action:setColor(0.16, 0.16, 0.16)
                action:setHoverColor(1, 0.33, 0.33)
            end

            --アクション2. 表示名の変更
            self.mainPage:newAction(2):setItem(self.parent.compatibilityUtils:checkItem("minecraft:name_tag")):setColor(0.78, 0.78, 0.78):setHoverColor(1, 1, 1):setOnScroll(function(direction)
                if direction < 0 then
                    self.selectingName = self.selectingName == 6 and 1 or self.selectingName + 1
                else
                    self.selectingName = self.selectingName == 1 and 6 or self.selectingName - 1
                end
                self:refreshNameChangeActionTitle()
            end):setOnLeftClick(function()
                self.selectingShouldShowClubName = not self.selectingShouldShowClubName
                self:refreshNameChangeActionTitle()
            end):setOnRightClick(function()
                self.selectingName = 1
                self.selectingShouldShowClubName = false
                self:refreshNameChangeActionTitle()
            end)

            --アクション3. 防具の表示
            self.mainPage:newAction(3):setItem(self.parent.compatibilityUtils:checkItem("minecraft:iron_chestplate")):setColor(0.67, 0, 0):setHoverColor(1, 0.33, 0.33):setToggleColor(0, 0.67, 0):setOnToggle(function (_, action)
                pings.actionWheelSetArmorVisible(true)
                action:setHoverColor(0.33, 1, 0.33)
                self.parent.config:saveConfig("PRIVATE", "showArmor", true)
            end):setOnUntoggle(function(_, action)
                pings.actionWheelSetArmorVisible(false)
                action:setHoverColor(1, 0.33, 0.33)
                self.parent.config:saveConfig("PRIVATE", "showArmor", false)
            end)
            if self.parent.config:loadConfig("PRIVATE", "showArmor", false) then
                local action = self.mainPage:getAction(3)
                action:setToggled(true)
                action:setHoverColor(0.33, 1, 0.33)
            end

            --アクション4. 一人称視点での武器モデルの表示
            self.mainPage:newAction(4):setItem(self.parent.compatibilityUtils:checkItem("minecraft:bow")):setColor(0.67, 0, 0):setHoverColor(1, 0.33, 0.33):setToggleColor(0, 0.67, 0):setOnToggle(function (_, action)
                self.parent.gun.shouldShowWeaponInFirstPerson = true
                action:setHoverColor(0.33, 1, 0.33)
                self.parent.config:saveConfig("PRIVATE", "firstPersonWeapon", true)
            end):setOnUntoggle(function (_, action)
                self.parent.gun.shouldShowWeaponInFirstPerson = false
                action:setHoverColor(1, 0.33, 0.33)
                self.parent.config:saveConfig("PRIVATE", "firstPersonWeapon", false)
            end)
            if self.parent.config:loadConfig("PRIVATE", "firstPersonWeapon", true) then
                local action = self.mainPage:getAction(4)
                action:setToggled(true)
                action:setHoverColor(0.33, 1, 0.33)
            end

            --アクション5. Exスキルフレームのパーティクルの量
            self.mainPage:newAction(5):setItem(self.parent.compatibilityUtils:checkItem("minecraft:glowstone_dust")):setColor(0.78, 0.78, 0.78):setHoverColor(1, 1, 1):setOnScroll(function (direction)
                if direction < 0 then
                    self.selectingExSkillParticleAmount = self.selectingExSkillParticleAmount == 4 and 1 or self.selectingExSkillParticleAmount + 1
                else
                    self.selectingExSkillParticleAmount = self.selectingExSkillParticleAmount == 1 and 4 or self.selectingExSkillParticleAmount - 1
                end
                self:refreshExSkillParticleActionTitle()
            end):setOnLeftClick(function ()
                self.selectingExSkillParticleAmount = self.parent.exSkill.frameParticleAmount
                self:refreshExSkillParticleActionTitle()
            end):setOnRightClick(function ()
                self.selectingExSkillParticleAmount = 1
                self:refreshExSkillParticleActionTitle()
            end)

            --アクション6. 乗り物モデルの置き換え
            self.mainPage:newAction(6):setItem(self.parent.compatibilityUtils:checkItem("minecraft:oak_boat")):setColor(0.67, 0, 0):setHoverColor(1, 0.33, 0.33):setToggleColor(0, 0.67, 0):setOnToggle(function (_, action)
                if self.parent.characterData.actionWheel.isVehicleOptionEnabled then
                    pings.actionWheelSetShouldReplaceVehicleModels(true)
                    action:setHoverColor(0.33, 1, 0.33)
                    self.parent.config:saveConfig("PRIVATE", "replaceVehicleModels", true)
                else
                    print(self.parent.locale:getLocale("action_wheel.main.action_6.unavailable"))
                    action:setToggled(false)
                end
            end):setOnUntoggle(function (_, action)
                pings.actionWheelSetShouldReplaceVehicleModels(false)
                action:setHoverColor(1, 0.33, 0.33)
                self.parent.config:saveConfig("PRIVATE", "replaceVehicleModels", false)
            end)
            if not self.parent.characterData.actionWheel.isVehicleOptionEnabled then
                local action = self.mainPage:getAction(6)
                action:setColor(0.16, 0.16, 0.16)
                action:setHoverColor(1, 0.33, 0.33)
                self.shouldReplaceVehicleModels = false
            elseif self.shouldReplaceVehicleModels then
                local action = self.mainPage:getAction(6)
                action:setToggled(true)
                action:setHoverColor(0.33, 1, 0.33)
            end

            --アクション7. First-person Model互換モード
            self.mainPage:newAction(7):setColor(0.67, 0, 0):setHoverColor(1, 0.33, 0.33):setToggleColor(0, 0.67, 0):setOnToggle(function (_, action)
                action:setHoverColor(0.33, 1, 0.33)
                events.RENDER:register(self.fpmCompatibilityModeRender, "fpm_compatibility_render")
                if not self.fpmMassageShowed then
                    print(self.parent.locale:getLocale("action_wheel.main.action_7.message"))
                    self.fpmMassageShowed = true
                end
                self.parent.config:saveConfig("PRIVATE", "fpmCompatibilityMode", true)
            end):setOnUntoggle(function (_, action)
                action:setHoverColor(1, 0.33, 0.33)
                events.RENDER:remove("fpm_compatibility_render")
                models.models.main.Avatar.Head:setVisible(true)
                models.models.main.Avatar.Head:setOpacity(1)
                self.parent.config:saveConfig("PRIVATE", "fpmCompatibilityMode", false)
            end)
            if client:getVersion() >= "1.20.5" then
                self.mainPage:getAction(7):setItem(self.parent.compatibilityUtils:checkItem("minecraft:player_head", "[profile={name:\""..player:getName().."\"}]"))
            else
                self.mainPage:getAction(7):setItem(self.parent.compatibilityUtils:checkItem("minecraft:player_head", "{SkullOwner: \""..player:getName().."\"}"))
            end
            if self.parent.config:loadConfig("PRIVATE", "fpmCompatibilityMode", true) then
                local action = self.mainPage:getAction(7)
                action:setToggled(true)
                action:setHoverColor(0.33, 1, 0.33)
                events.RENDER:register(self.fpmCompatibilityModeRender, "fpm_compatibility_render")
            end

            --アクション8. アップデートの確認
            self.mainPage:newAction(8):setItem(self.parent.compatibilityUtils:checkItem("minecraft:compass")):setOnLeftClick(function ()
                if not self.parent.updateChecker.checkerStatus ~= "CHECKING" then
                    self.parent.updateChecker:checkUpdate()
                else
                    print("action_wheel.main.action_8.ongoing")
                    sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:block.note_block.bass"), player:getPos(), 1, 0.5)
                end
                if not net:isNetworkingAllowed() or not net:isLinkAllowed("https://api.github.com") then
                    print(self.parent.locale:getLocale("action_wheel.main.action_8.networking_api"))
                    sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:block.note_block.bass"), player:getPos(), 1, 0.5)
                end
            end):onRightClick(function ()
                if self.parent.updateChecker.latestVersion ~= nil and self.currentTime < self.parent.updateChecker.lastCheckTime + 86400000 then
                    host:setClipboard("https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/releases/tag/"..self.parent.updateChecker.latestVersion)
                    print(self.parent.locale:getLocale("action_wheel.main.action_8.copied"))
                else
                    print(self.parent.locale:getLocale("action_wheel.main.action_8.cannot_check_latest"))
                    sounds:playSound(self.parent.compatibilityUtils:checkSound("minecraft:block.note_block.bass"), player:getPos(), 1, 0.5)
                end
            end)

            action_wheel:setPage(self.mainPage)
        end
    end;

    ---衣装変更アクションのタイトルを更新する。
    ---@param self ActionWheel
    refreshCostumeChangeActionTitle = function (self)
        if #self.parent.costume.costumeList >= 2 then
            self.mainPage:getAction(1):setTitle(self.parent.locale:getLocale("action_wheel.main.action_1.title").."§b"..self.parent.costume:getCostumeLocalName(self.selectingCostume))
        else
            self.mainPage:getAction(1):setTitle("§7"..self.parent.locale:getLocale("action_wheel.main.action_1.title")..self.parent.costume:getCostumeLocalName(self.selectingCostume))
        end
    end;

    ---名前変更アクションのタイトルを更新する。
    ---@param self ActionWheel
    refreshNameChangeActionTitle = function (self)
        if self.selectingName >= 2 then
            if self.selectingShouldShowClubName then
                self.mainPage:getAction(2):setTitle(self.parent.locale:getLocale("action_wheel.main.action_2.title").."§b"..self.parent.nameplate:getName(self.selectingName).."\n§r"..self.parent.locale:getLocale("action_wheel.main.action_2.title_2").."§a"..self.parent.locale:getLocale("action_wheel.toggle_on"))
            else
                self.mainPage:getAction(2):setTitle(self.parent.locale:getLocale("action_wheel.main.action_2.title").."§b"..self.parent.nameplate:getName(self.selectingName).."\n§r"..self.parent.locale:getLocale("action_wheel.main.action_2.title_2").."§c"..self.parent.locale:getLocale("action_wheel.toggle_off"))
            end
        else
            self.mainPage:getAction(2):setTitle(self.parent.locale:getLocale("action_wheel.main.action_2.title").."§b"..self.parent.nameplate:getName(self.selectingName).."\n§7"..self.parent.locale:getLocale("action_wheel.main.action_2.title_2")..self.parent.locale:getLocale("action_wheel.toggle_"..(self.selectingShouldShowClubName and "on" or "off")))
        end
    end;

    ---Exスキルアニメーションのパーティクル量調整アクションのタイトルを更新する。
    ---@param self ActionWheel
    refreshExSkillParticleActionTitle = function (self)
        self.mainPage:getAction(5):title(self.parent.locale:getLocale("action_wheel.main.action_5.title").."§b"..self.parent.locale:getLocale("action_wheel.main.action_5.option_"..self.selectingExSkillParticleAmount))
    end;

    ---アップデート確認アクションの状態を更新する。
    ---@param self ActionWheel
    refreshUpdateActionStatus = function (self)
        local action = self.mainPage:getAction(8)
        local actionTitle = ""
        if self.parent.updateChecker.checkerStatus == "CHECKING" then
            actionTitle = actionTitle.."§7"..self.parent.locale:getLocale("action_wheel.main.action_8.title_1")..self.parent.locale:getLocale("action_wheel.main.action_8.title_2").."\n"
            action:setColor(0.16, 0.16, 0.16)
            action:setHoverColor(1, 0.33, 0.33)
        else
            actionTitle = actionTitle..self.parent.locale:getLocale("action_wheel.main.action_8.title_1").."§b"..self.parent.locale:getLocale("action_wheel.main.action_8.title_2").."\n"
            action:setColor(0.78, 0.78, 0.78)
            action:setHoverColor(1, 1, 1)
        end
        if self.parent.updateChecker.latestVersion ~= nil and self.currentTime < self.parent.updateChecker.lastCheckTime + 86400000 then
            actionTitle = actionTitle.."§r"..self.parent.locale:getLocale("action_wheel.main.action_8.title_3").."§b"..self.parent.locale:getLocale("action_wheel.main.action_8.title_4")
        else
            actionTitle = actionTitle.."§7"..self.parent.locale:getLocale("action_wheel.main.action_8.title_3")..self.parent.locale:getLocale("action_wheel.main.action_8.title_4")
        end
        action:setTitle(actionTitle)
    end;

    ---First-person Model互換性モードにおけるレンダー関数
    ---@param context Event.Render.context
    fpmCompatibilityModeRender = function (_, context)
        local hasShaderPack = client:hasShaderPack()
        models.models.main.Avatar.Head:setVisible(context ~= "OTHER" or hasShaderPack)
        models.models.main.Avatar.Head:setOpacity((context ~= "OTHER" or not hasShaderPack) and 1 or 0)
    end;
}

---アクションホイールから衣装を変更するトリガー関数
---@param costumeId integer 新しい衣装のインデックス番号
function pings.actionWheelChangeCostume(costumeId)
    if costumeId >= 2 then
        AvatarInstance.costume:setCostume(costumeId)
    else
        AvatarInstance.costume:resetCostume()
    end
end

---アクションホイールから名前を変更するトリガー関数
---@param typeId integer 新しい名前の表示形式のインデックス番号
---@param shouldShowClubName boolean 部活名を表示するかどうか
function pings.actionWheelChangeName(typeId, shouldShowClubName)
    AvatarInstance.nameplate:setName(typeId, shouldShowClubName)
end

---アクションホイールから防具の可視性を変更するトリガー関数
---@param visible boolean 防具を表示するかどうか
function pings.actionWheelSetArmorVisible(visible)
    AvatarInstance.armor.shouldShowArmor = visible
end

---アクションホイールから乗り物モデルの置き換えを変更するトリガー関数
---@param enabled boolean 乗り物モデルの置き換えを有効化するかどうか
function pings.actionWheelSetShouldReplaceVehicleModels(enabled)
    AvatarInstance.actionWheel.shouldReplaceVehicleModels = enabled
end