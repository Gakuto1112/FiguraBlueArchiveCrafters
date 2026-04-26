---ネットワークリクエストの結果を表す列挙型
---@alias NetUtils.ResponseStatus
---| "SUCCESS"           # 通信成功
---| "ERR_NOT_ALLOWED"   # Networking APIの利用が許可されていないか、通信を試みたドメインが許可されていない。
---| "ERR_NETWORK"       # 通信エラー
---| "ERR_RESPONSE_CODE" # レスポンスコードが200番台以外の場合（httpリクエストエラー）

---@class (exact) NetUtils ネットワーク関連のユーティリティ関数群
local NetUtils = {
	---指定したURI（ドメイン）との通信が許可されているかどうか返す。
	---@param uri string 通信の可否を確認するURI
	---@return boolean isAllowed 指定したURI（ドメイン）との通信が許可されているかどうか
	checkAvailability = function (uri)
		return net:isNetworkingAllowed() and net:isLinkAllowed(uri)
	end;

	---指定したURIへGETリクエストを送信する。
	---@param self NetUtils
	---@param uri string 通信相手のURI
	---@param callback fun(status: NetUtils.ResponseStatus, data: Buffer|integer?) リクエストの結果が確定した際に呼び出されるコールバック関数
	fetch = function (self, uri, callback)
		if self.checkAvailability(uri) then
			local request = net.http:request(uri)
			local requestUUID = client.intUUIDToString(client.generateUUID())
			local responseHandler = request:send()

			events.TICK:register(function ()
				if responseHandler:isDone() then
					local response = responseHandler:getValue()
					if response ~= nil then
						local statusCode = response:getResponseCode()
						if math.floor(statusCode / 100) == 2 then
							-- 成功コード
							local stream = response:getData()
							local buffer = data:createBuffer()
							buffer:readFromStream(stream)
							buffer:setPosition(0)
							callback("SUCCESS", buffer)
							stream:close()
						else
							-- エラーコード
							callback("ERR_RESPONSE_CODE", statusCode)
						end
					else
						callback("ERR_NETWORK", nil)
					end
					events.TICK:remove(requestUUID)
				end
			end, requestUUID)
		else
			callback("ERR_NOT_ALLOWED", nil)
		end
	end;

	---入力されたバッファデータをJSON形式としてパースして返す。
	---@param buffer Buffer JSON形式のデータが格納されたバッファ
	---@return (boolean|string|number|table)? jsonData パースされたデータ。
	toJson = function (buffer)
		local jsonData = buffer:readByteArray()
		if json.isSerializable(jsonData) then
			return parseJson(jsonData)
		end
	end;
}

return NetUtils
