---設定の保存先の列挙型
---@alias Config.StorageType
---| "PUBLIC" # FBACキャラクター共通ストレージ
---| "PRIVATE" # キャラクター固有ストレージ

---@class (exact) Config アバター設定を管理するクラス
---@field package SYNC_INTERVAL integer 設定の同期pingを送信する間隔
---@field package privateStorageName string キャラクター固有ストレージの名前
---@field package defaultValues {[string]: number|boolean|string} 読み込んだ値のデフォルト値を保持するテーブル
---@field package nextSyncCount integer 次の同期pingまでのカウンター
---@field public syncConfigs {[string]: any} 同期する設定値を格納するテーブル
---@field package isSynced boolean 設定値がホストと同期されているかどうか
local Config = {
	SYNC_INTERVAL = 300;

	defaultValues = {};
	nextSyncCount = 0;
	syncConfigs = {};
	isSynced = false;

    ---初期化関数
    ---@param self Config
    init = function (self)
		if host:isHost() then
			self.isSynced = true
			events.TICK:register(function ()
				if self.nextSyncCount == 0 then
					pings.config_syncAvatarConfigs(self.syncConfigs)
					self.nextSyncCount = self.SYNC_INTERVAL
				else
					self.nextSyncCount = self.nextSyncCount - 1
				end
			end)
		end
    end;

	---設定を読み出す。
	---@generic T
	---@param self Config
	---@param storage Config.StorageType 読み出し先のストレージ
	---@param keyName string 読み出す設定の名前
	---@param defaultValue `T` 該当の設定が無い場合や、ホスト外での実行の場合はこの値が返される。
	---@return `T` loadedValue 読み出した値
	loadConfig = function (self, storage, keyName, defaultValue)
		if host:isHost() then
			if storage == "PUBLIC" then
				config:setName("FiguraBlueArchiveCharacters_public")
			else
				config:setName("FiguraBlueArchiveCharacters_" .. BlueArchiveCharacter.basic.avatarName)
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
	---@param storage Config.StorageType 書き込み先のストレージ
	---@param keyName string 保存する設定の名前
	---@param valueToSave any 保存する値
	saveConfig = function (self, storage, keyName, valueToSave)
		if host:isHost() then
			if storage == "PUBLIC" then
				config:setName("FiguraBlueArchiveCharacters_public")
			else
				config:setName("FiguraBlueArchiveCharacters_" .. BlueArchiveCharacter.basic.avatarName)
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
---@param configData {[string]: any} 同期する設定値を格納したテーブル
function pings.config_syncAvatarConfigs(configData)
	if not Config.isSynced then
		Config.syncConfigs = configData
		EventManager.events["ON_CONFIG_SYNC"]:fire(Config.syncConfigs)
		Config.isSynced = true
	end
end

return Config
