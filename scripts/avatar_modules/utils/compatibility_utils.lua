---レジストリの種類を示す列挙型
---@alias CompatibilityUtils.RegistryType
---| "BLOCK" # ブロック名
---| "ITEM" # アイテム名
---| "PARTICLE" # パーティクル名
---| "SOUND" # サウンド名

---@class (exact) CompatibilityUtils : AvatarModule Minecraftのゲームバージョンが異なっていてもある程度互換性を確保するためのユーティリティクラス
---@field package registries {block: Minecraft.blockID[], item: Minecraft.itemID[], particle: Minecraft.particleID[], sound: Minecraft.soundID[]} ゲームから取得した全アイテム名を保持するテーブル
---@field package checkedTable {block: {[Minecraft.blockID]: boolean}, item: {[Minecraft.itemID]: boolean}, particle: {[Minecraft.particleID]: boolean}, sound: {[Minecraft.soundID]: boolean}} レジストリへの確認が済んでいるIDを保持するテーブル
---@field package find fun(self: CompatibilityUtils, registryType: CompatibilityUtils.RegistryType, target: string): boolean 指定されたターゲットがレジストリに登録されているかどうかを返す。
---@field public checkBlock fun(self: CompatibilityUtils, block: Minecraft.blockID): Minecraft.blockID 指定されたブロックIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:dirt"を返す。
---@field public checkItem fun(self: CompatibilityUtils, item: Minecraft.itemID): Minecraft.itemID 指定されたアイテムIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:barrier"を返す。
---@field public checkParticle fun(self: CompatibilityUtils, particle: Minecraft.particleID): Minecraft.particleID 指定されたパーティクルIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:poof"を返す。
---@field public checkSound fun(self: CompatibilityUtils, sound: Minecraft.soundID): Minecraft.soundID 指定されたサウンドIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:empty"を返す。
---@field public getBlockParticleId fun(block: Minecraft.blockID): string ブロックの破片のパーティクルを示す文字列を返す。Minecraftのバージョン違いを吸収するための関数。
---@field public getDustParticleId fun(color: Vector3, size: number): string dustパーティクルを示す文字列を返す。Minecraftのバージョン違いを吸収するための関数。

CompatibilityUtils = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return CompatibilityUtils
    new = function (parent)
        ---@type CompatibilityUtils
        local instance = Avatar.instantiate(CompatibilityUtils, AvatarModule, parent)

        instance.registries = {}
        instance.checkedTable = {
            block = {};
            item = {};
            particle = {};
            sound = {};
        }

        return instance
    end;

    ---初期化関数
    ---@param self CompatibilityUtils
    init = function (self)
        self.registries.block = client.getRegistry("minecraft:block")
        self.registries.item = client.getRegistry("minecraft:item")
        self.registries.particle = client.getRegistry("minecraft:particle_type")
        self.registries.sound = client.getRegistry("minecraft:sound_event")
        for name, _ in pairs(self.registries) do
            table.sort(self.registries[name])
        end
        self.checkedTable.block["minecraft:dirt"] = true
        self.checkedTable.item["minecraft:barrier"] = true
        self.checkedTable.particle["minecraft:poof"] = true
        self.checkedTable.sound["minecraft:empty"] = true
        if host:isHost() and client:getVersion() < "1.20.1" then
            print(Language:getTranslate("avatar__old_version_warning"))
        end
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
            if self.registries[registryType:lower()][centerIndex] < target then
                return 1
            elseif self.registries[registryType:lower()][centerIndex] > target then
                return -1
            else
                return 0
            end
        end

        local startIndex = 1
        local endIndex = #self.registries[registryType:lower()]
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
    ---@param blockState string? ブロックステートを示す文字列
    ---@return Minecraft.blockID blockID レジストリに登録してある場合は確認対象のブロックIDをそのまま返し、未登録の場合は"minecraft:dirt"が返す。
    checkBlock = function (self, block, blockState)
        if self.checkedTable.block[block] == nil then
            self.checkedTable.block[block] = self:find("BLOCK", block)
        end
        local state = blockState ~= nil and blockState or ""
        return self.checkedTable.block[block] and block..state or "minecraft:dirt"
    end;

    ---指定されたアイテムIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:barrier"を返す。
    ---@param self CompatibilityUtils
    ---@param item Minecraft.itemID 確認対象のアイテムID
    ---@return Minecraft.itemID blockID レジストリに登録してある場合は確認対象のアイテムIDをそのまま返し、未登録の場合は"minecraft:barrier"が返す。
    checkItem = function (self, item)
        if self.checkedTable.item[item] == nil then
            self.checkedTable.item[item] = self:find("ITEM", item)
        end
        return self.checkedTable.item[item] and item or "minecraft:barrier"
    end;

    ---指定されたパーティクルIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:poof"を返す。
    ---@param self CompatibilityUtils
    ---@param particle Minecraft.particleID 確認対象のパーティクルID
    ---@return Minecraft.particleID particleID レジストリに登録してある場合は確認対象のパーティクルIDをそのまま返し、未登録の場合は"minecraft:poof"が返す。
    checkParticle = function (self, particle)
        if self.checkedTable.particle[particle] == nil then
            self.checkedTable.particle[particle] = self:find("PARTICLE", particle)
        end
        return self.checkedTable.particle[particle] and particle or "minecraft:poof"
    end;

    ---指定されたサウンドIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:empty"を返す。
    ---@param self CompatibilityUtils
    ---@param sound Minecraft.soundID 確認対象のサウンドID
    ---@return Minecraft.soundID particleID レジストリに登録してある場合は確認対象のサウンドIDをそのまま返し、未登録の場合は"minecraft:empty"が返す。
    checkSound = function (self, sound)
        if self.checkedTable.sound[sound] == nil then
            self.checkedTable.sound[sound] = self:find("SOUND", sound)
        end
        return self.checkedTable.sound[sound] and sound or "minecraft:empty"
    end;

    ---ブロックの破片のパーティクルを示す文字列を返す。Minecraftのバージョン違いを吸収するための関数。
    ---@param block Minecraft.blockID ブロックの破片パーティクルとして表示するブロックのID。レジストリへの確認は行わない。
    ---@return string particleData ブロックの破片のパーティクルを示す文字列
    getBlockParticleId = function (block)
        return client:getVersion() >= "1.20.5" and "minecraft:block{block_state:\""..block.."\"}" or "minecraft:block "..block
    end;

    ---dustパーティクルを示す文字列を返す。Minecraftのバージョン違いを吸収するための関数。
    ---@param color Vector3 dustの色
    ---@param size number dustの大きさ
    ---@return string particleData dustの破片のパーティクルを示す文字列
    getDustParticleId = function (color, size)
        return client:getVersion() >= "1.20.5" and "minecraft:dust{color:["..color.x..","..color.y..","..color.z.."],scale:"..size.."}" or "minecraft:dust "..color.x.." "..color.y.." "..color.z.." "..size
    end;
}