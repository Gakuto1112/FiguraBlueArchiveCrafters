---@class (exact) Character16a.SpawnObject.CallbackSet スポーンオブジェクトのコールバック関数のセット
---@field public onInit? fun(self: SpawnObject) オブジェクトの初期化直後に呼ばれる関数
---@field public onDeinit? fun(self: SpawnObject) オブジェクトの破棄直前に呼ばれる関数
---@field public onTick? fun(self: SpawnObject, trainPos: Vector3, backwardLength: integer) 各ティック毎に呼ばれる関数

---@class (exact) Character16a.RailObject : SpawnObject Exスキル1で使用する単一の線路オブジェクト
---@field package object ModelPart インスタンスで制御するオブジェクトのルート
---@field package task BlockTask インスタンスで制御するブロックタスク
---@field package pos Vector3 オブジェクトのワールド位置
---@field package rot number オブジェクトのワールド方向
---@field package lifeTime integer このオブジェクトが破棄されるまでの残り時間
---@field public new fun(pos: Vector3, rot: number): Character16a.RailObject コンストラクター
local RailObject = {
    ---コンストラクタ
    ---@param pos Vector3 線路オブジェクトを設置するワールド座標
    ---@param rot number 線路オブジェクトを設置するワールド方向
    ---@return Character16a.RailObject
    new = function (pos, rot)
        ---@type Character16a.RailObject
        local instance = MiscUtils.instantiate(Character16a_RailObject, SpawnObject)

        instance.object = models.script_ex_skill_1_rail:newPart(instance.uuid)
        instance.task = instance.object:newBlock(client.intUUIDToString(client.generateUUID()))
        instance.pos = pos:copy()
        instance.rot = rot
        instance.lifeTime = 200

        instance.callbacks = {
            ---@param self Character16a.RailObject
            onInit = function (self)
                self.object:setPos(self.pos)
                self.object:setRot(0, self.rot, 0)
                self.task:setBlock("minecraft:rail")
                self.task:setPos(-16, 0, -16)
                self.task:setScale(2, 1, 2)
            end;

            ---@param self Character16a.RailObject
            onDeinit = function (self)
                self.object:removeTask(self.task:getName())
                models.script_ex_skill_1_rail:removeChild(self.object)
                self.object:remove()
            end;

            ---@param self Character16a.RailObject
            ---@param trainPos Vector3 列車の現在位置
            ---@param backwardLength integer
            onTick = function (self, trainPos, backwardLength)
                if self.pos:copy():sub(trainPos):length() >= backwardLength * 32 or self.lifeTime == 0 then
                    self.shouldDeinit = true
                end
                self.lifeTime = self.lifeTime - 1
            end;
        }

        return instance
    end;
}

return RailObject
