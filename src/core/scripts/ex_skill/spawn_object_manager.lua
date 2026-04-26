---@class (exact) SpawnObjectManager オブジェクト（設置物、独自定義パーティクル、bbモデルetc.）をスポーンさせ、管理する抽象マネージャークラス
---@field public managerName string このマネージャーの名前
---@field public objects SpawnObject[] スポーンさせたオブジェクトを保持するテーブル
local SpawnObjectManager = {
    ---コンストラクタ
    ---@return SpawnObjectManager
    new = function ()
        ---@type SpawnObjectManager
        ---@diagnostic disable-next-line: undefined-global
        local instance = MiscUtils.instantiate(SpawnObjectManager)

        instance.managerName = "spawn_object"
        instance.objects = {}

        return instance
    end;

    ---スポーンオブジェクトのインスタンスを生成して返す。
    ---@return SpawnObject instance 生成したスポーンオブジェクト
    getObject = function ()
        ---@diagnostic disable-next-line: undefined-global
        return SpawnObject.new()
    end;

    ---オブジェクトをスポーンさせる。
    ---@param self SpawnObjectManager
    ---@param ... any インスタンス生成時の引数
    spawn = function (self, ...)
        ---@diagnostic disable-next-line: redundant-parameter
        local instance = self:getObject(...)
        table.insert(self.objects, instance)
        if instance.callbacks ~= nil and instance.callbacks.onInit ~= nil then
            instance.callbacks.onInit(instance)
        end

        if #self.objects == 1 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    for index, ins in ipairs(self.objects) do
                        if ins.callbacks ~= nil and ins.callbacks.onTick ~= nil then
                            ins.callbacks.onTick(ins)
                        end
                        if ins.shouldDeinit then
                            if ins.callbacks ~= nil and ins.callbacks.onDeinit ~= nil then
                                ins.callbacks.onDeinit(ins)
                            end
                            table.remove(self.objects, index)
                            if #self.objects == 0 then
                                events.TICK:remove(self.managerName.."_tick")
                                events.RENDER:remove(self.managerName.."_render")
                            end
                        end
                    end
                end
            end, self.managerName.."_tick")

            events.RENDER:register(function (delta, ctx)
                if not client:isPaused() then
                    for _, ins in ipairs(self.objects) do
                        if ins.callbacks ~= nil and ins.callbacks.onRender ~= nil then
                            ins.callbacks.onRender(ins, delta, ctx)
                        end
                    end
                end
            end, self.managerName.."_render")
        end
    end;

    ---オブジェクトを1つ削除する。
    ---@param self SpawnObjectManager
    ---@param index integer 削除するオブジェクトのインデックス番号
    remove = function (self, index)
        if self.objects[index] ~= nil then
            if self.objects[index].callbacks ~= nil and self.objects[index].callbacks.onDeinit ~= nil then
                self.objects[index].callbacks.onDeinit(self.objects[index])
            end
            table.remove(self.objects, index)
            if #self.objects == 0 then
                events.TICK:remove(self.managerName.."_tick")
                events.RENDER:remove(self.managerName.."_render")
            end
        end
    end;

    ---オブジェクトをすべて削除する。
    ---@param self SpawnObjectManager
    removeAll = function (self)
        while #self.objects > 0 do
            if self.objects[1].callbacks ~= nil and self.objects[1].callbacks.onDeinit ~= nil then
                self.objects[1].callbacks.onDeinit(self.objects[1])
            end
            table.remove(self.objects, 1)
        end
        events.TICK:remove(self.managerName.."_tick")
        events.RENDER:remove(self.managerName.."_render")
    end;
}

return SpawnObjectManager
