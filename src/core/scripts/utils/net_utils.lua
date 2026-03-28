---ネットワークリクエストの結果を表す列挙型
---@alias NetUtils.ResponseStatus
---| "SUCCESS"            # 通信成功
---| "ERROR_RESPONSE_ERR" # レスポンスコードが200番台以外の場合（httpリクエストエラー）
---| "ERROR_NETWORK_ERR"  # 通信エラー
---| "ERROR_NOT_ALLOWED"  # ネットワーキング機能が許可されていない

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
	---@param callback fun(status: NetUtils.ResponseStatus, data: Buffer?) リクエストの結果が確定した際に呼び出されるコールバック関数。`data`にはレスポンスの内容が格納されている。リクエストに失敗した場合は`nil`になる。
	get = function (self, uri, callback)
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
						else
							-- エラーコード
							callback("ERROR_RESPONSE_ERR", nil)
						end
					else
						callback("ERROR_NETWORK_ERR", nil)
					end
					events.TICK:remove(requestUUID)
				end
			end, requestUUID)
		else
			callback("ERROR_NOT_ALLOWED", nil)
		end
	end;
}

return NetUtils
