---@class (exact) Nameplate.DisplayNameData プレイヤーの表示名データの構造体
---@field public displayType integer 表示名の種類：1. プレイヤー名, 2. 名のみ（英語）, 3. 名性（英語）, 4. 性名（英語）, 5. 名のみ（ローカル）, 6. 名性（ローカル）, 7. 性名（ローカル）
---@field public globalName? Nameplate.CharacterNameSet 英語での姓名
---@field public localName? Nameplate.CharacterNameSet ローカル言語での姓名
---@field public shouldShowClubName boolean 部活名を表示するかどうか
---@field public globalClubName? string 英語での部活名
---@field public locale? string ロケール名
---@field public localClubName? string ローカル言語での部活名
---@field public isBirthday boolean 誕生日かどうか

---@class (exact) Nameplate.CharacterNameSet キャラクター名を格納するデータせっと
---@field public firstName string キャラクターの名
---@field public lastName string キャラクターの姓

---@class (exact) Nameplate プレイヤーの表示名やネームプレートを制御するクラス
---@field public nameDisplayType integer 現在の表示名のタイプ：1. プレイヤー名, 2. 名のみ（英語）, 3. 名性（英語）, 4. 性名（英語）, 5. 名のみ（ローカル）, 6. 名性（ローカル）, 7. 性名（ローカル）
---@field package selectingNameDisplayType integer アクションホイールで選択中の表示名タイプ
---@field public shouldShowClubName boolean 部活名を表示するかどうか
---@field package selectingShouldShowClubName boolean アクションホイールで選択中の部活名表示のオンオフ
---@field public changeDisplayNameAction Action プレイヤーの表示名を切り替えるアクション
---@field package localePrev string 前ティックの設定言語
local Nameplate = {
	nameDisplayType = 1;
	selectingNameDisplayType = 1;
	shouldShowClubName = false;
	selectingShouldShowClubName = false;
	changeDisplayNameAction = nil;

    ---コンストラクタ
    ---@param self Nameplate
    init = function (self)
		if host:isHost() then
			self.nameDisplayType = Config:loadConfig("PRIVATE", "name.name_display_type", 1)
			self.selectingNameDisplayType = self.nameDisplayType
			self.shouldShowClubName = Config:loadConfig("PRIVATE", "name.should_show_club_name", false)
			self.selectingShouldShowClubName = self.shouldShowClubName

			local displayNameData = self.getDisplayNameData(self.nameDisplayType, self.shouldShowClubName)
			pings.nameplate_setName(displayNameData)
			Config.syncConfigs["displayNameData"] = displayNameData

			self.changeDisplayNameAction = ActionWheel:getAction()
				:setItem("minecraft:name_tag")
				:setOnScroll(function (direction)
					local lang = client:getActiveLang()
					local maxNumber = (lang ~= "en_us" and Locale.availableLocales[lang] ~= nil) and 7 or 4
					if direction < 0 then
						self.selectingNameDisplayType = self.selectingNameDisplayType >= maxNumber and 1 or self.selectingNameDisplayType + 1
					else
						self.selectingNameDisplayType = self.selectingNameDisplayType == 1 and maxNumber or self.selectingNameDisplayType - 1
					end
					self:setChangeDisplayNameActionTitle()
				end)
				:setOnLeftClick(function (action)
					if self.selectingNameDisplayType >= 2 then
						self.selectingShouldShowClubName = not self.selectingShouldShowClubName
						self:setChangeDisplayNameActionTitle()
					end
				end)
			self:setChangeDisplayNameActionTitle()

			ActionWheel:setAction(self.changeDisplayNameAction, 2)

			EventManager.events["ON_ACTION_WHEEL_CLOSE"]:register(function ()
				if self.selectingNameDisplayType ~= self.nameDisplayType or self.selectingShouldShowClubName ~= self.shouldShowClubName then
					local displayNameData2 = self.getDisplayNameData(self.selectingNameDisplayType, self.selectingShouldShowClubName)
					pings.nameplate_setName(displayNameData2)
					Config.syncConfigs["displayNameData"] = displayNameData2
					if self.selectingNameDisplayType ~= self.nameDisplayType then
						print(Locale:getLocalizedText("message.action_wheel.change_display_name.done"):format(self.getDisplayName(self.selectingNameDisplayType)))
						Config:saveConfig("PRIVATE", "name.name_display_type", self.selectingNameDisplayType)
						Config:saveConfig("PRIVATE", "name.should_show_club_name", self.selectingShouldShowClubName)
					elseif self.selectingShouldShowClubName then
						print(Locale:getLocalizedText("message.action_wheel.change_display_name.club_name_on"))
						Config:saveConfig("PRIVATE", "name.should_show_club_name", true)
					else
						print(Locale:getLocalizedText("message.action_wheel.change_display_name.club_name_off"))
						Config:saveConfig("PRIVATE", "name.should_show_club_name", false)
					end
					sounds:playSound("minecraft:ui.cartography_table.take_result", player:getPos())
					self.nameDisplayType = self.selectingNameDisplayType
					self.shouldShowClubName = self.selectingShouldShowClubName
				end
			end)
		end

        events.RENDER:register(function (delta, context)
            if context ~= "PAPERDOLL" then
				nameplate.ENTITY:setPivot(ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.nameplate):sub(player:getPos(delta)))
            else
                nameplate.ENTITY:setPivot()
            end
        end)

		EventManager.events["ON_LOCALE_REFRESH"]:register(function ()
			self:setChangeDisplayNameActionTitle()
		end)

		EventManager.events["ON_CONFIG_SYNC"]:register(function (syncData)
			self.setName(syncData["displayNameData"])
		end)
    end;

	---入力された表示タイプに対応するプレイヤーの表示名を返す。
	---@param type integer 表示名の種類：1. プレイヤー名, 2. 名のみ（英語）, 3. 名性（英語）, 4. 性名（英語）, 5. 名のみ（ローカル）, 6. 名性（ローカル）, 7. 性名（ローカル）
	---@return string displayName プレイヤーの表示名
	getDisplayName = function (type)
		if type == 1 then
			return player:getName()
		else
			local name = Locale:getLocalizedText("character.first_name", type <= 4)
			if (type - 2) % 3 == 0 then
				return name
			else
				local lastName = Locale:getLocalizedText("character.last_name", type <= 4)
				if (type - 2) % 3 == 1 then
					return name .. " " .. lastName
				else
					return lastName .. " " .. name
				end
			end
		end
	end;

	---プレイヤー表示名切り替えアクションのタイトルを更新する。
	---@param self Nameplate
	setChangeDisplayNameActionTitle = function (self)
		local text = Locale:getLocalizedText("action_wheel.main_page.change_display_name.title") .. "§b"
		text = text .. self.getDisplayName(self.selectingNameDisplayType)
		if self.selectingNameDisplayType == 1 then
			text = text .. "\n" .. "§8" .. Locale:getLocalizedText("action_wheel.main_page.change_display_name.sub_option") .. "§8" .. Locale:getLocalizedText("action_wheel.action.toggle_off")
		else
			text = text .. "\n" .. "§r" .. Locale:getLocalizedText("action_wheel.main_page.change_display_name.sub_option")
			if self.selectingShouldShowClubName then
				text = text .. "§a" .. Locale:getLocalizedText("action_wheel.action.toggle_on")
			else
				text = text .. "§c" .. Locale:getLocalizedText("action_wheel.action.toggle_off")
			end
		end
		self.changeDisplayNameAction:setTitle(text)
	end;

	---表示名設定用のデータ構造体を返す。
	---@param displayNameType integer 表示名の種類：1. プレイヤー名, 2. 名のみ（英語）, 3. 名性（英語）, 4. 性名（英語）, 5. 名のみ（ローカル）, 6. 名性（ローカル）, 7. 性名（ローカル）
	---@param shouldShowClubName boolean 部活名を表示するかどうか
	---@return Nameplate.DisplayNameData displayNameData 表示名のデータ構造体
	getDisplayNameData = function (displayNameType, shouldShowClubName)
		local today = client:getDate()
		---@type Nameplate.DisplayNameData
		local displayNameData = {
			displayType = displayNameType;
			shouldShowClubName = displayNameType >= 2 and shouldShowClubName or false;
			isBirthday = (today.month == BlueArchiveCharacter.basic.birth.month and today.day == BlueArchiveCharacter.basic.birth.day);
		}
		displayNameData.displayType = displayNameType
		if displayNameType >= 2 then
			local activeLang = client:getActiveLang()
			displayNameData.globalName = {
				firstName = Locale:getLocalizedText("character.first_name", true);
				lastName = Locale:getLocalizedText("character.last_name", true);
			}
			if (displayNameType >= 5 and activeLang ~= "en_us") or shouldShowClubName then
				displayNameData.locale = activeLang
				if displayNameType >= 5 and activeLang ~= "en_us" then
					displayNameData.localName = {
						firstName = Locale:getLocalizedText("character.first_name");
						lastName = Locale:getLocalizedText("character.last_name");
					}
				end
				if shouldShowClubName then
					displayNameData.globalClubName = Locale:getLocalizedText("character.club_name", true)
					if activeLang ~= "en_us" then
						displayNameData.localClubName = Locale:getLocalizedText("character.club_name")
					end
				end
			end
		end

		return displayNameData
	end;

    ---入力された設定でプレイヤーの表示名を設定する。
	---@param displayNameData Nameplate.DisplayNameData 表示名のデータ
    setName = function (displayNameData)
		local displayName = ""
		local lang = client:getActiveLang()
		if displayNameData.displayType == 1 then
			displayName = player:getName()
		elseif displayNameData.displayType <= 4 or lang ~= displayNameData.locale then
			displayName = displayNameData.globalName.firstName
			if displayNameData.displayType == 3 then
				displayName = displayName .. " " .. displayNameData.globalName.lastName
			elseif displayNameData.displayType == 4 then
				displayName = displayNameData.globalName.lastName .. " " .. displayName
			end
		else
			displayName = displayNameData.localName.firstName
			if displayNameData.displayType == 6 then
				displayName = displayName .. " " .. displayNameData.localName.lastName
			elseif displayNameData.displayType == 7 then
				displayName = displayNameData.localName.lastName .. " " .. displayName
			end
		end
		if displayNameData.displayType >= 2 and displayNameData.isBirthday then
			displayName = displayName .. " :cake:"
		end
		nameplate.ALL:setText(displayName)
		if displayNameData.displayType >= 2 and displayNameData.shouldShowClubName then
			nameplate.ENTITY:setText(displayName .. "\n§7" .. ((lang ~= displayNameData.locale) and displayNameData.globalClubName or displayNameData.localClubName))
		end
	end;
}

---プレイヤーの表示名を設定する。
---@param displayNameData Nameplate.DisplayNameData 表示名のデータ
function pings.nameplate_setName(displayNameData)
	Nameplate.setName(displayNameData)
end

return Nameplate
