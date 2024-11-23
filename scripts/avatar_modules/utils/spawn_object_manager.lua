---@class (exact) SpawnObjectManager : AvatarModule オブジェクト（設置物、独自定義パーティクル、bbモデルetc.）をスポーンさせ、管理するマネージャークラス
---@field public managerName string このマネージャーの名前
---@field public objects SpawnObject[] スポーンさせたオブジェクトを保持するテーブル
---@field public getObject fun(self: SpawnObjectManager): SpawnObject スポーンオブジェクトのインスタンスを生成して返す
---@field public spawn fun(self: SpawnObjectManager, ...: any) オブジェクトをスポーンさせる
---@field public remove fun(self: SpawnObjectManager, index: integer) オブジェクトを1つ削除する
---@field public removeAll fun(self: SpawnObjectManager) オブジェクトをすべて削除する

SpawnObjectManager = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return SpawnObjectManager
    new = function (parent)
        ---@type SpawnObjectManager
        local instance = Avatar.instantiate(SpawnObjectManager, AvatarModule, parent)

        instance.managerName = "spawn_object"
        instance.objects = {}

        return instance
    end;

    ---スポーンオブジェクトのインスタンスを生成して返す。
    ---@param self SpawnObjectManager
    ---@return SpawnObject instance 生成したスポーンオブジェクト
    getObject = function (self)
        return SpawnObject.new(self.parent)
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
        end
        events.TICK:remove(self.managerName.."_tick")
        events.RENDER:remove(self.managerName.."_render")
    end;
}