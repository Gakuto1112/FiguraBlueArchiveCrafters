---@class (exact) SpawnObject : AvatarModule オブジェクト（設置物、独自定義パーティクル、bbモデルetc.）クラス
---@field public object any インスタンスで制御するオブジェクト。ModelPartやRenderTaskを想定している。
---@field public shouldDeinit boolean このオブジェクトを破棄するかどうか。trueにするとオブジェクトが破棄され、その際に、onDeinit()コールバック関数が呼ばれる。
---@field public callbacks? SpawnObject.CallbackSet スポーンオブジェクトのコールバック関数

---@class (exact) SpawnObject.CallbackSet スポーンオブジェクトのコールバック関数のセット
---@field public onInit? fun() オブジェクトの初期化直後に呼ばれる関数
---@field public onDeinit? fun() オブジェクトの破棄直前に呼ばれる関数
---@field public onTick? fun() 各ティック毎に呼ばれる関数
---@field public onRender? fun(delta: number, context: Event.Render.context) 各レンダーティック毎に呼ばれる関数

SpawnObject = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return SpawnObject
    new = function (parent)
        ---@type SpawnObject
        local instance = Avatar.instantiate(SpawnObject, AvatarModule, parent)

        instance.shouldDeinit = false

        return instance
    end;
}