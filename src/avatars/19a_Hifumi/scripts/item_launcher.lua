---@class (exact) ItemLauncher.LaunchedItemObject 発射したアイテムの情報を格納するクラス
---@field package item ItemTask 発射したアイテムのレンダータスク
---@field package currentPos Vector3 アイテムの現在のワールド位置
---@field package nextPos Vector3 アイテムの次ティックのワールド位置
---@field package baseScale number アイテムモデルの基本スケール
---@field package velocity Vector3 アイテムの現在の速度
---@field package lifetime integer アイテムを消すまでの残り時間（ティック単位）

---@class (exact) ItemLauncher アイテムを発射する演出のクラス
---@field private itemObjects ItemLauncher.LaunchedItemObject[] 発射したアイテムの情報を格納するテーブル
local ItemLauncher = {
	itemObjects = {};

	---初期化関数
	init = function ()
		---@diagnostic disable-next-line: discard-returns
		models:newPart("script_item_launcher", "World")
	end;

	---発射中のアイテムがある間、各ティック毎に呼び出される関数
	onTick = function(self)
		for index, object in ipairs(self.itemObjects) do
			--アイテムの位置を強制更新
			object.currentPos = object.nextPos:copy()
			object.item:setPos(object.currentPos:copy():scale(16):add(0, 2, 0))

			--アイテムの次ティックの位置を計算
			object.nextPos = object.currentPos:copy():add(object.velocity:copy():scale(0.05))
			object.velocity.y = object.velocity.y - 0.49 --重力加速度

			local block, hitPos, side = raycast:block(object.currentPos, object.nextPos, "COLLIDER", "NONE")
			if block ~= nil and block.id ~= "minecraft:air" and block.id ~= "minecraft:cave_air" and block.id ~= "minecraft:void_air" and side == "up" then
				object.nextPos = hitPos:copy()
				object.velocity.y = math.abs(object.velocity.y) * 0.2 --反発係数
				object.velocity.x = object.velocity.x * 0.8 --摩擦係数
				object.velocity.z = object.velocity.z * 0.8 --摩擦係数
			end

			--アイテムの表示残り時間を更新
			object.lifetime = object.lifetime - 1
			if object.lifetime == 0 then
				object.item:remove()
				table.remove(self.itemObjects, index)
				if #self.itemObjects == 0 then
					events.TICK:remove("item_launcher_tick")
					events.RENDER:remove("item_launcher_render")
				end
			end
		end
	end;

	---発射中のアイテムがある間、各レンダーティック毎に呼び出される関数
	---@param delta number デルタ値
	onRender = function (self, delta)
		for _, object in ipairs(self.itemObjects) do
			object.item:setPos(object.currentPos:copy():add(object.nextPos:copy():sub(object.currentPos):scale(delta)):scale(16):add(0, 2, 0))
			object.item:setScale(vectors.vec3(1, 1, 1):scale(math.min(0.4 * object.baseScale * (object.lifetime + (1 - delta)), object.baseScale)))
		end
	end;

	---アイテムを発射する。
	---@param item Minecraft.itemID 発射するアイテム
	---@param pos Vector3 ワールド座標での発射位置
	---@param rot number アイテムの角度（度単位）
	---@param scale number アイテムモデルの大きさ倍率
	---@param velocity Vector3 発射の初速
	---@param lifetime integer 発射したアイテムが存在する時間（ティック単位）
	launch = function (self, item, pos, rot, scale, velocity, lifetime)
		---@type ItemLauncher.LaunchedItemObject
		local object = {
			item = models.script_item_launcher:newItem(client.intUUIDToString(client.generateUUID())),
			currentPos = pos:copy(),
			nextPos = pos:copy(),
			baseScale = scale,
			velocity = velocity,
			lifetime = lifetime
		}

		object.item:setItem(item)
		object.item:setPos(pos:copy():scale(16):add(0, 2, 0))
		object.item:setRot(0, rot, 0)
		object.item:setScale(vectors.vec3(1, 1, 1):scale(object.baseScale))

		table.insert(self.itemObjects, object)

		if #self.itemObjects == 1 then
			events.TICK:register(function ()
				self:onTick()
			end, "item_launcher_tick")
			events.RENDER:register(function (delta)
				self:onRender(delta)
			end, "item_launcher_render")
		end
	end;

	---表示中のアイテムをすべて削除する。
	removeAll = function (self)
		while #self.itemObjects > 0 do
			self.itemObjects[1].item:remove()
			table.remove(self.itemObjects, 1)
		end
		events.TICK:remove("item_launcher_tick")
		events.RENDER:remove("item_launcher_render")
	end;
}

return ItemLauncher
