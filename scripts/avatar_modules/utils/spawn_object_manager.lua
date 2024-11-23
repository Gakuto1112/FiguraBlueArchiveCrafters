---@class SpawnObjectManager : AvatarModule オブジェクト（設置物、独自定義パーティクル、bbモデルetc.）をスポーンさせ、管理するマネージャークラス
---@field public objects SpawnObject[] スポーンさせたオブジェクトを保持するテーブル

SpawnObjectManager = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return SpawnObjectManager
    new = function (parent)
        ---@type SpawnObjectManager
        local instance = Avatar.instantiate(SpawnObjectManager, AvatarModule, parent)

        instance.objects = {}

        return instance
    end;

    ---オブジェクトをスポーンさせる。
    ---@param self SpawnObjectManager
    ---@param pos Vector3 オブジェクトをスポーンさせるワールド位置
    ---@param rot number オブジェクトをスポーンさせるワールド方向（水平方向のみ）
    spawn = function (self, pos, rot)
        local instance = SpawnObject.new(self.parent)
        table.insert(self.objects, instance)
        if instance.callbacks ~= nil and instance.callbacks.onInit ~= nil then
            instance.callbacks.onInit()
        end

        if #self.objects == 1 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    for index, ins in ipairs(self.objects) do
                        if ins.callbacks ~= nil and ins.callbacks.onTick ~= nil then
                            ins.callbacks.onTick()
                        end
                        if ins.shouldDeinit then
                            if ins.callbacks ~= nil and ins.callbacks.onDeinit ~= nil then
                                ins.callbacks.onDeinit()
                            end
                            table.remove(self.objects, index)
                            if #self.objects == 0 then
                                events.TICK:remove("spawn_object_tick")
                                events.RENDER:remove("spawn_object_render")
                            end
                        end
                    end
                end
            end, "spawn_object_tick")

            events.RENDER:register(function (delta, ctx)
                if not client:isPaused() then
                    for _, ins in ipairs(self.objects) do
                        if ins.callbacks ~= nil and ins.callbacks.onRender ~= nil then
                            ins.callbacks.onRender(delta, ctx)
                        end
                    end
                end
            end, "spawn_object_render")
        end
    end;

    ---オブジェクトを1つ削除する。
    ---@param self SpawnObjectManager
    ---@param index integer 削除するオブジェクトのインデックス番号
    remove = function (self, index)
        if self.objects[index] ~= nil then
            if self.objects[index].callbacks ~= nil and self.objects[index].callbacks.onDeinit ~= nil then
                self.objects[index].callbacks.onDeinit()
            end
            table.remove(self.objects, index)
            if #self.objects == 0 then
                events.TICK:remove("spawn_object_tick")
                events.RENDER:remove("spawn_object_render")
            end
        end
    end;

    ---オブジェクトをすべて削除する。
    ---@param self SpawnObjectManager
    removeAll = function (self)
        while #self.objects > 0 do
            if self.objects[1].callbacks ~= nil and self.objects[1].callbacks.onDeinit ~= nil then
                self.objects[1].callbacks.onDeinit()
            end
        end
        events.TICK:remove("spawn_object_tick")
        events.RENDER:remove("spawn_object_render")
    end;
}