---@alias Config.Storage
---| "PUBLIC" # FBACキャラクター共通ストレージ
---| "PRIVATE" # キャラクター固有ストレージ

---@class (exact) Config : AvatarModule アバター設定を管理するクラス
---@field package privateStorageName string キャラクター固有ストレージの名前
---@field package defaultValues {[string]: number|boolean|string} 読み込んだ値のデフォルト値を保持するテーブル
---@field package nextSyncCount integer 次の同期pingまでのカウンター
---@field package isSynced boolean 設定値がホストと同期されているかどうか
---@field public loadConfig fun(self: Config, storage: Config.Storage, keyName: string, defaultValue: any): any 設定を読み出す
---@field public saveConfig fun(self: Config, storage: Config.Storage, keyName: string, valueToSave: any) 設定を保存する

Config = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Config
    new = function (parent)
        ---@type Config
        local instance = Avatar.instantiate(Config, AvatarModule, parent)

		instance.privateStorageName = "BlueArchive_"..instance.parent.characterData.basic.firstName.en_us..instance.parent.characterData.basic.lastName.en_us
		instance.defaultValues = {}
		instance.nextSyncCount = 0
		instance.isSynced = host:isHost()

        return instance
    end;

    ---初期化関数
    ---@param self Config
    init = function (self)
		AvatarModule.init(self)

		if host:isHost() then
			events.TICK:register(function ()
				if self.nextSyncCount == 0 then
					pings.syncAvatarConfig(self.parent.nameplate.currentName, self.parent.nameplate.shouldShowClubName, self.parent.costume.currentCostume, self.parent.armor.shouldShowArmor, self.parent.actionWheel.shouldReplaceVehicleModels, self.parent.bubble.isChatOpened, self.parent.characterData.dataSync.syncData)
					self.nextSyncCount = 300
				else
					self.nextSyncCount = self.nextSyncCount - 1
				end
			end)
		end
    end;

	---設定を読み出す。
	---@generic T
	---@param self Config
	---@param storage Config.Storage 読み出し先のストレージ
	---@param keyName string 読み出す設定の名前
	---@param defaultValue `T` 該当の設定が無い場合や、ホスト外での実行の場合はこの値が返される。
	---@return `T` loadedValue 読み出した値
	loadConfig = function (self, storage, keyName, defaultValue)
		if host:isHost() then
			if storage == "PUBLIC" then
				config:setName("BlueArchive_public")
			else
				config:setName(self.privateStorageName)
			end
			local loadedData = config:load(keyName)
			self.defaultValues[keyName] = defaultValue
			if loadedData ~= nil then
				return loadedData
			else
				return defaultValue
			end
		else
			return defaultValue
		end
	end;

	---設定を保存する。
	---@param self Config
	---@param storage Config.Storage 書き込み先のストレージ
	---@param keyName string 保存する設定の名前
	---@param valueToSave any 保存する値
	saveConfig = function (self, storage, keyName, valueToSave)
		if host:isHost() then
			if storage == "PUBLIC" then
				config:setName("BlueArchive_public")
			else
				config:setName(self.privateStorageName)
			end
			if self.defaultValues[keyName] == valueToSave then
				config:save(keyName, nil)
			else
				config:save(keyName, valueToSave)
			end
		end
	end;
}

---アバター設定を他Figuraクライアントと同期する。
---@param nameTypeId integer 表示名の種類ID
---@param shouldShowClubName boolean 部活名を表示するかどうか
---@param costumeId integer 現在の衣装ID
---@param shouldShowArmor boolean 防具が見えているかどうか
---@param shouldReplaceVehicleModels boolean 乗り物モデルを置き換えるかどうか
---@param isChatOpened boolean チャット欄を開いているかどうか
---@param additionalData {[string]: any} キャラクター固有用に追加で同期するデータ
function pings.syncAvatarConfig(nameTypeId, shouldShowClubName, costumeId, shouldShowArmor, shouldReplaceVehicleModels, isChatOpened, additionalData)
	if not AvatarInstance.config.isSynced then
		AvatarInstance.nameplate:setName(nameTypeId, shouldShowClubName)
		AvatarInstance.armor.shouldShowArmor = shouldShowArmor
		AvatarInstance.actionWheel.shouldReplaceVehicleModels = shouldReplaceVehicleModels
		AvatarInstance.bubble.isChatOpened = isChatOpened
		if costumeId >= 2 then
			AvatarInstance.costume:setCostume(costumeId)
		end
		AvatarInstance.characterData.dataSync.syncData = additionalData
		if AvatarInstance.characterData.dataSync.callbacks ~= nil and AvatarInstance.characterData.dataSync.callbacks.onDataSynced ~= nil then
			AvatarInstance.characterData.dataSync.callbacks.onDataSynced(AvatarInstance.characterData)
		end
		AvatarInstance.config.isSynced = true
	end
end