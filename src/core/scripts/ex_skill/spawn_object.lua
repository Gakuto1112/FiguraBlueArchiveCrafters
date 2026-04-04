---@class (exact) SpawnObject.CallbackSet スポーンオブジェクトのコールバック関数のセット
---@field public onInit? fun(self: SpawnObject) オブジェクトの初期化直後に呼ばれる関数
---@field public onDeinit? fun(self: SpawnObject) オブジェクトの破棄直前に呼ばれる関数
---@field public onTick? fun(self: SpawnObject) 各ティック毎に呼ばれる関数
---@field public onRender? fun(self: SpawnObject, delta: number, context: Event.Render.context) 各レンダーティック毎に呼ばれる関数

---@class (exact) SpawnObject オブジェクト（設置物、独自定義パーティクル、bbモデルetc.）を制御するの抽象クラス
---@field public object any インスタンスで制御するオブジェクト。ModelPartやRenderTaskを想定している。
---@field public uuid string このインスタンスのUUID。オブジェクトの名前付けなどにどうぞ。
---@field public shouldDeinit boolean このオブジェクトを破棄するかどうか。trueにするとオブジェクトが破棄され、その際に、onDeinit()コールバック関数が呼ばれる。
---@field public callbacks? SpawnObject.CallbackSet スポーンオブジェクトのコールバック関数
local SpawnObject = {
    ---コンストラクタ
    ---@return SpawnObject
    new = function ()
        ---@type SpawnObject
        ---@diagnostic disable-next-line: undefined-global
        local instance = MiscUtils.instantiate(SpawnObject)

        instance.uuid = client.intUUIDToString(client.generateUUID())
        instance.shouldDeinit = false

        return instance
    end;
}

return SpawnObject
