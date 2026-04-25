---レジストリの種類を示す列挙型
---@alias CompatibilityUtils.RegistryType
---| "BLOCK"    # ブロック
---| "ITEM"     # アイテム
---| "PARTICLE" # パーティクル
---| "SOUND"    # サウンド

---@class (exact) CompatibilityUtils Minecraftのゲームバージョンが異なっていてもある程度互換性を確保するためのユーティリティクラス
---@field package TARGET_MC_VERSION string アバターが想定しているMinecraftの最低バージョン。このバージョンより古い場合は読み込み時に警告メッセージが表示される。
---@field package ALTERNATIVE_ENTRIES {block: Minecraft.blockID, item: Minecraft.itemID, particle: Minecraft.particleID, sound: Minecraft.soundID} レジストリに存在しないIDが指定された場合に代わりに使用するIDを格納するテーブル
---@field package registries {block: Minecraft.blockID[], item: Minecraft.itemID[], particle: Minecraft.particleID[], sound: Minecraft.soundID[]} ゲームから取得した全アイテム名を保持するテーブル
---@field package checkedTable {block: {[Minecraft.blockID]: boolean}, item: {[Minecraft.itemID]: boolean}, particle: {[Minecraft.particleID]: boolean}, sound: {[Minecraft.soundID]: boolean}} レジストリへの確認が済んでいるIDを保持するテーブル
local CompatibilityUtils = {

    TARGET_MC_VERSION = "1.21.4";

    ALTERNATIVE_ENTRIES = {
        block = "minecraft:dirt";
        item = "minecraft:barrier";
        particle = "minecraft:poof";
        sound = "minecraft:empty";
    };

    registries = {};
    checkedTable = {
        block = {};
        item = {};
        particle = {};
        sound = {};
    };

    ---初期化関数
    ---@param self CompatibilityUtils
    init = function (self)
        -- レジストリの取得
        self.registries.block = client.getRegistry("minecraft:block")
        self.registries.item = client.getRegistry("minecraft:item")
        self.registries.particle = client.getRegistry("minecraft:particle_type")
        self.registries.sound = client.getRegistry("minecraft:sound_event")
        for name, _ in pairs(self.registries) do
            table.sort(self.registries[name])
        end

        -- 代替地のフラグ立て
        self.checkedTable.block["minecraft:dirt"] = true
        self.checkedTable.item["minecraft:barrier"] = true
        self.checkedTable.particle["minecraft:poof"] = true
        self.checkedTable.sound["minecraft:empty"] = true

        -- 古いゲームバージョン使用時の警告
        if host:isHost() and client:getVersion() < self.TARGET_MC_VERSION then
            print(Locale:getLocalizedText("avatar.old_version_warning"))
        end

        self:injectToBlockTaskSetBlock()
        self:injectToItemTaskSetItem()
        self:injectToParticlesNewParticle()
        self:injectToSoundsPlaySound()
        self:injectToRendererSetPostEffect()
    end;

    ---指定されたターゲットがレジストリに登録されているかどうかを返す。
    ---@param self CompatibilityUtils
    ---@param registryType CompatibilityUtils.RegistryType 検索をかける対象のレジストリ
    ---@param target string 検索対象名。"minecraft:"を抜かないこと。
    ---@return boolean idFound 指定されたターゲットがレジストリで見つかったかどうか
    find = function (self, registryType, target)
        ---リスト内の中央の要素（偶数の場合は中央から1つ左の要素）と指定されたターゲットのUnicode順を比較する。
        ---@param from integer リストの検索開始のインデックス番号
        ---@param to integer リストの検索終了のインスタンス番号（指定したインデックス番号の要素も検索に含む）
        ---@return integer compareResult 比較結果。0は同じ文字列、1はターゲットの方が大きい、-1はターゲットの方が小さいことを表す。
        local function compareToCenterElement(from, to)
            local centerIndex = math.floor((to - from) / 2) + from
            if self.registries[StringUtils.lower(registryType)][centerIndex] < target then
                return 1
            elseif self.registries[StringUtils.lower(registryType)][centerIndex] > target then
                return -1
            else
                return 0
            end
        end

        local startIndex = 1
        local endIndex = #self.registries[StringUtils.lower(registryType)]
        while startIndex < endIndex do
            local compareResult = compareToCenterElement(startIndex, endIndex)
            if compareResult == 1 then
                startIndex = math.floor((endIndex - startIndex) / 2) + startIndex + 1
            elseif compareResult == -1 then
                endIndex = math.floor((endIndex - startIndex) / 2) + startIndex
            else
                break
            end
        end
        if startIndex == endIndex then
            return compareToCenterElement(startIndex, endIndex) == 0
        else
            return true
        end
    end;

    ---指定されたブロックIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:dirt"を返す。
    ---@param self CompatibilityUtils
    ---@param block Minecraft.blockID 確認対象のブロックID
    ---@return Minecraft.blockID blockID レジストリに登録してある場合は確認対象のブロックIDをそのまま返し、未登録の場合は"minecraft:dirt"が返す。
    checkBlock = function (self, block)
        if self.checkedTable.block[block] == nil then
            self.checkedTable.block[block] = self:find("BLOCK", block)
        end
        return self.checkedTable.block[block] and block or self.ALTERNATIVE_ENTRIES.block
    end;

    ---指定されたアイテムIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:barrier"を返す。
    ---@param self CompatibilityUtils
    ---@param item Minecraft.itemID 確認対象のアイテムID
    ---@return Minecraft.itemID blockID レジストリに登録してある場合は確認対象のアイテムIDをそのまま返し、未登録の場合は"minecraft:barrier"が返す。
    checkItem = function (self, item)
        if self.checkedTable.item[item] == nil then
            self.checkedTable.item[item] = self:find("ITEM", item)
        end
        return self.checkedTable.item[item] and item or self.ALTERNATIVE_ENTRIES.item
    end;

    ---指定されたパーティクルIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:poof"を返す。
    ---@param self CompatibilityUtils
    ---@param particle Minecraft.particleID 確認対象のパーティクルID
    ---@return Minecraft.particleID particleID レジストリに登録してある場合は確認対象のパーティクルIDをそのまま返し、未登録の場合は"minecraft:poof"が返す。
    checkParticle = function (self, particle)
        if self.checkedTable.particle[particle] == nil then
            self.checkedTable.particle[particle] = self:find("PARTICLE", particle)
        end
        return self.checkedTable.particle[particle] and particle or self.ALTERNATIVE_ENTRIES.particle
    end;

    ---指定されたサウンドIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:empty"を返す。
    ---@param self CompatibilityUtils
    ---@param sound Minecraft.soundID 確認対象のサウンドID
    ---@return Minecraft.soundID particleID レジストリに登録してある場合は確認対象のサウンドIDをそのまま返し、未登録の場合は"minecraft:empty"が返す。
    checkSound = function (self, sound)
        if self.checkedTable.sound[sound] == nil then
            self.checkedTable.sound[sound] = self:find("SOUND", sound)
        end
        return self.checkedTable.sound[sound] and sound or self.ALTERNATIVE_ENTRIES.sound
    end;

    ---`models:newBlock():setBlock()`メソッドに対し、ブロックIDのチェック機能を注入する。
    injectToBlockTaskSetBlock = function (self)
        local dummyBlock = models:newBlock("dummy_block")
        local blockMT = getmetatable(dummyBlock)
        local originalSetBlockFunc = blockMT.__index.setBlock

        ---@param self2 BlockTask
        ---@param block BlockState|Minecraft.blockID
        blockMT.__index.setBlock = function (self2, block)
            if type(block) == "BlockState" then
                return originalSetBlockFunc(self2, block)
            else
                local trueBlockID = block
                if trueBlockID:find(":") == nil then
                    trueBlockID = "minecraft:" .. block
                end
                local stateBracketStart, stateBracketEnd = trueBlockID:find("%b[]")
                local blockState = ""
                if stateBracketStart ~= nil and stateBracketEnd ~= nil then
                    blockState = trueBlockID:sub(stateBracketStart, stateBracketEnd)
                    trueBlockID = trueBlockID:sub(1, stateBracketStart - 1)
                end
                trueBlockID = self:checkBlock(trueBlockID)
                if trueBlockID == self.ALTERNATIVE_ENTRIES.block then
                    blockState = ""
                end
                return originalSetBlockFunc(self2, self:checkBlock(trueBlockID) .. blockState)
            end
        end

        models:removeTask("dummy_block")
    end;

    ---`models:newItem():setItem()`メソッドに対し、アイテムIDのチェック機能を注入する。
    injectToItemTaskSetItem = function (self)
        local dummyItem = models:newItem("dummy_item")
        local itemMT = getmetatable(dummyItem)
        local originalSetItemFunc = itemMT.__index.setItem

        ---@param self2 ItemTask
        ---@param item ItemStack|Minecraft.itemID
        itemMT.__index.setItem = function (self2, item)
            if type(item) == "ItemStack" then
                return originalSetItemFunc(self2, item)
            else
                local trueItemID = item
                if trueItemID:find(":") == nil then
                    trueItemID = "minecraft:" .. trueItemID
                end
                return originalSetItemFunc(self2, self:checkItem(trueItemID))
            end
        end

        models:removeTask("dummy_item")
    end;

    ---ParticleAPIを改変し、`particles:newParticle()`メソッドに対し、パーティクルIDのチェック機能を注入する。
    injectToParticlesNewParticle = function (self)
        local particlesMT = figuraMetatables.ParticleAPI
        local originalParticleIndexFunc = particlesMT.__index

        ---@param self2 ParticleAPI
        ---@param key any
        particlesMT.__index = function (self2, key)
            if key == "newParticle" then
                ---@param self3 ParticleAPI
                ---@param name Minecraft.particleID
                return function (self3, name, ...)
                    local trueParticleID = name
                    if trueParticleID:find(":") == nil then
                        trueParticleID = "minecraft:" .. trueParticleID
                    end
                    local spaceIndex = name:find(" ")
                    local arg = ""
                    if spaceIndex ~= nil then
                        arg = name:sub(spaceIndex)
                        trueParticleID = name:sub(1, spaceIndex - 1)
                    end
                    trueParticleID = self:checkParticle(trueParticleID)
                    if trueParticleID == self.ALTERNATIVE_ENTRIES.particle then
                        arg = ""
                    end
                    return originalParticleIndexFunc(self2, "newParticle")(self3, self:checkParticle(trueParticleID) .. arg, ...)
                end
            else
                return originalParticleIndexFunc(self2, key)
            end
        end;
    end;

    ---SoundAPIを改変し、`sounds:playSound()`メソッドに対し、サウンドIDのチェック機能を注入する。
    injectToSoundsPlaySound = function (self)
        local soundsMT = figuraMetatables.SoundAPI
        local originalSoundIndexFunc = soundsMT.__index

        ---@param self2 SoundAPI
        ---@param key any
        soundsMT.__index = function (self2, key)
            if key == "playSound" then
                return function (self3, soundName, ...)
                    local trueSoundID = soundName
                    if trueSoundID:find(":") == nil then
                        trueSoundID = "minecraft:" .. trueSoundID
                    end
                    return originalSoundIndexFunc(self2, "playSound")(self3, self:checkSound(trueSoundID), ...)
                end
            else
                return originalSoundIndexFunc(self2, key)
            end
        end;
    end;

    ---RendererAPIを改変し、`renderer:setPostEffect()`メソッドに対し、ゲームバージョンチェック機能を注入する。
    injectToRendererSetPostEffect = function ()
        local rendererMT = figuraMetatables.RendererAPI
        local originalRendererIndexFunc = rendererMT.__index

        ---@param self2 RendererAPI
        ---@param key any
        rendererMT.__index = function (self2, key)
            if key == "setPostEffect" then
                return function (self3, effect)
                    -- ゲームバージョン1.20.5以降、ゲーム内レンダープロファイルが削除され、以降アクセスを試みるとエラーになる。
                    if client:getVersion() < "1.20.5" then
                        return originalRendererIndexFunc(self2, "setPostEffect")(self3, effect)
                    else
                        return originalRendererIndexFunc(self2, "setPostEffect")
                    end
                end
            else
                return originalRendererIndexFunc(self2, key)
            end
        end;
    end;
}

return CompatibilityUtils
