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
---@field public shouldShowClubName boolean 部活名を表示するかどうか
---@field package localePrev string 前ティックの設定言語
local Nameplate = {
	nameDisplayType = 1;
	shouldShowClubName = false;

    ---コンストラクタ
    ---@param self Nameplate
    init = function (self)
		if host:isHost() then
			self.nameDisplayType = Config:loadConfig("PRIVATE", "name.name_display_type", 1)
			self.shouldShowClubName = Config:loadConfig("PRIVATE", "name.should_show_club_name", false)

			local displayNameData = self.getDisplayNameData(self.nameDisplayType, self.shouldShowClubName)
			pings.nameplate_setName(displayNameData)

			Config.syncConfigs["displayNameData"] = displayNameData;
		end

        --events.TICK:register(function () --//TODO: アクションホイールによる名前変更実装後
        --    local locale = client:getActiveLang()
        --    if locale ~= self.localePrev then
        --        if self.shouldShowClubName then
        --            self:setName(self.currentName, true)
        --        end
        --        self.localePrev = locale
        --    end
        --end)

        events.RENDER:register(function (delta, context)
            if context ~= "PAPERDOLL" then
                --nameplate.ENTITY:setPivot(ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.nameplate):sub(player:getPos(delta)):add(0, self.parent.barrier.isBarrierVisible and 1.095 or 0.895, 0)) --//TODO: バリアの再実装後
				nameplate.ENTITY:setPivot(ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.nameplate):sub(player:getPos(delta)):add(0, 0.895, 0))
            else
                nameplate.ENTITY:setPivot()
            end
        end)
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
