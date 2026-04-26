---@class (exact) ExSkill1CoinManager : SpawnObjectManager Exスキル1で使用するコインを管理するクラス
---@field public objects ExSkill1Coin[] インスタンスで制御するオブジェクト
---@field package getObject fun(self: ExSkill1CoinManager, pos: Vector3): ExSkill1Coin コインのインスタンスを生成して返す
---@field public spawn fun(self: ExSkill1CoinManager, pos: Vector3) コインをスポーンさせる
---@field public getAll fun(self: ExSkill1CoinManager) 現在スポーン中の全てのコインオブジェクトに対して取得アニメーションを再生する
local ExSkill1CoinManager = {
    ---コンストラクタ
    ---@return ExSkill1CoinManager
    new = function ()
        ---@type ExSkill1CoinManager
        local instance = MiscUtils.instantiate(ExSkill1CoinManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_coin"

        return instance
    end;

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_ex_skill_1_coin")
    end;

    ---コインのインスタンスを生成して返す。
    ---@param pos Vector3 コインをスポーンさせるアバター座標
    ---@return ExSkill1Coin instance 生成したインスタンス
    getObject = function (_, pos)
        return ExSkill1Coin.new(pos)
    end;

    ---コインをスポーンさせる。
    ---@param self ExSkill1CoinManager
    ---@param pos Vector3 コインをスポーンさせるアバター座標
    spawn = function (self, pos)
        SpawnObjectManager.spawn(self, pos)

        events.TICK:remove(self.managerName.."_tick")
        events.TICK:register(function ()
            if not client:isPaused() then
                local animPos = models.models.main.Avatar:getAnimPos()
                for index, ins in ipairs(self.objects) do
                    if ins.callbacks ~= nil and ins.callbacks.onTick ~= nil then
                        ins.callbacks.onTick(ins, animPos)
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
    end;

    ---現在スポーン中の全てのコインオブジェクトに対して取得アニメーションを再生する。
    ---@param self ExSkill1CoinManager
    getAll = function (self)
        for _, obj in ipairs(self.objects) do
            obj:playGetAnimation(true)
        end
    end;
}

return ExSkill1CoinManager
