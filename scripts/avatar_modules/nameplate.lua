---@class (exact) Nameplate : AvatarModule プレイヤーの表示名を制御するクラス
---@field public currentName integer 現在の表示名：1. プレイヤー名, 2. 名のみ（英語）, 3. 名のみ（日本語）, 4. 名性（英語）, 5. 性名（英語）, 6. 性名（日本語）
---@field public shouldShowClubName boolean 部活名を表示するかどうか
---@field public getName fun(self: Nameplate, typeId: integer): string 指定されたtypeIdでの表示名を返す
---@field public setName fun(self: Nameplate, typeId: integer, shouldShowClubName: boolean) 入力された設定で表示名を設定する

Nameplate = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Nameplate
    new = function (parent)
        ---@type Nameplate
        local instance = Avatar.instantiate(Nameplate, AvatarModule, parent)

        instance.currentName = instance.parent.config:loadConfig("name", 1)
        instance.shouldShowClubName = instance.parent.config:loadConfig("showClubName", 1)

        return instance
    end;

    ---指定されたtypeIdでの表示名を返す。
    ---@param self Nameplate
    ---@param typeId integer 表示名の種類：1. プレイヤー名, 2. 名のみ（英語）, 3. 名のみ（日本語）, 4. 名性（英語）, 5. 性名（英語）, 6. 性名（日本語）
    ---@return string displayName 指定されたtypeIdでの表示名
    getName = function (self, typeId)
        local displayName = typeId == 1 and player:getName() or ((typeId == 2 or typeId == 4) and self.parent.characterData.basic.firstName.en_us or (typeId == 5 and self.parent.characterData.basic.lastName.en_us or (typeId == 3 and self.parent.characterData.basic.firstName.ja_jp or self.parent.characterData.basic.lastName.ja_jp)))
        if typeId >= 4 then
            displayName = displayName.." "..(typeId == 4 and self.parent.characterData.basic.lastName.en_us or (typeId == 5 and self.parent.characterData.basic.firstName.en_us or self.parent.characterData.basic.firstName.ja_jp))
        end
        return displayName
    end;

    ---入力された設定で表示名を設定する。
    ---@param self Nameplate
    ---@param typeId integer 表示名の種類：1. プレイヤー名, 2. 名のみ（英語）, 3. 名のみ（日本語）, 4. 名性（英語）, 5. 性名（英語）, 6. 性名（日本語）
    ---@param shouldShowClubName boolean 部活名を表示するかどうか
    setName = function (self, typeId, shouldShowClubName)
        local date = client:getDate()
        local displayName = self:getName(typeId)..((typeId >= 2 and date.month == self.parent.characterData.basic.birth.month and date.day == self.parent.characterData.basic.birth.day) and " :cake:" or "")
        nameplate.ALL:setText(displayName)
        if typeId >= 2 and shouldShowClubName then
            nameplate.ENTITY:setText(displayName.."\n§7"..self.parent.locale:getLocale("nameplate.club_name"))
        end
        self.currentName = typeId
        self.shouldShowClubName = shouldShowClubName
    end;

    ---初期化関数
    ---@param self Nameplate
    init = function (self)
        AvatarModule.init(self)

        if self.currentName >= 2 then
            self:setName(self.currentName, self.shouldShowClubName)
        end

        events.RENDER:register(function (delta, context)
            if context ~= "PAPERDOLL" then
                nameplate.ENTITY:setPivot(self.parent.modelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Body.NameplateAnchor):sub(player:getPos(delta)):add(0, self.parent.barrier.isBarrierVisible and 1.095 or 0.895, 0))
            else
                nameplate.ENTITY:setPivot()
            end
        end)
    end;
}