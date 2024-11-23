---@class ExSkillFrameParticleManager : SpawnObjectManager Exスキルのフレームで使用するパーティクルを管理するクラス
---@field public getObject fun(self: SpawnObjectManager, pos: Vector2, velocity: Vector2): SpawnObject スポーンオブジェクトのインスタンスを生成して返す
---@field public spawn fun(self: SpawnObjectManager, pos: Vector2, velocity: Vector2) オブジェクトをスポーンさせる

ExSkillFrameParticleManager = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return ExSkillFrameParticleManager
    new = function (parent)
        ---@type ExSkillFrameParticleManager
        local instance = Avatar.instantiate(ExSkillFrameParticleManager, SpawnObjectManager, parent)

        instance.managerName = "ex_skill_frame_particle"

        return instance
    end;

    ---スポーンオブジェクトのインスタンスを生成して返す。
    ---@param self SpawnObjectManager
    ---@param pos Vector2 パーティクルをスポーンさせる画面上の座標
    ---@param velocity Vector2 パーティクルの速度
    ---@return SpawnObject instance 生成したスポーンオブジェクト
    getObject = function (self, pos, velocity)
        return ExSkillFrameParticle.new(self.parent, pos, velocity, math.random() > 0.9999 and "FIGURA" or "NORMAL")
    end;

    ---Exスキルフレームのパーティクルをスポーンさせる。
    ---@param self SpawnObjectManager
    ---@param pos Vector2 パーティクルをスポーンさせる画面上の座標
    ---@param velocity Vector2 パーティクルの速度
    spawn = function (self, pos, velocity)
        SpawnObjectManager.spawn(self, pos, velocity)
    end;

    ---初期化関数
    ---@param self ExSkillFrameParticleManager
    init = function (self)
        SpawnObjectManager.init(self)

        ---@diagnostic disable-next-line: discard-returns
        models.models.ex_skill_frame.Gui:newPart("script_ex_skill_frame_particles")
    end;
}

--[[
---@class FrameParticleManager Exスキルのフレームで使用するパーティクルを管理するクラス
FrameParticleManager = {
    ---フレームパーティクルのインスタンスを保持するテーブル
    ---@type table<table>
    Particles = {},

    ---レンダーイベントを処理したかどうか
    ---@type boolean
    IsRenderProcessed = false,

    ---パーティクルをスポーンさせる。
    ---@param screenPos Vector2 パーティクルをスポーンさせるスクリーン上の座標。GUIスケールも考慮される。
    ---@param velocity Vector2 パーティクルの秒間移動距離（ピクセル）
    spawn = function (self, screenPos, velocity)
        ---@diagnostic disable-next-line: undefined-field
        local instance = FrameParticle.spawn(client.intUUIDToString(client:generateUUID()), screenPos, math.random() > 0.9999 and "FIGURA" or "NORMAL", velocity)
        table.insert(self.Particles, instance)
        if #self.Particles == 1 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    for index, particle in ipairs(self.Particles) do
                        particle:tick()
                        if particle.shouldDeinit then
                            table.remove(self.Particles, index)
                            if #self.Particles == 0 then
                                events.TICK:remove("ex_skill_frame_particle_tick")
                                events.RENDER:remove("ex_skill_frame_particle_render")
                            end
                        end
                    end
                end
            end, "ex_skill_frame_particle_tick")
            events.RENDER:register(function (delta)
                if not client:isPaused() then
                    for _, particle in ipairs(self.Particles) do
                        particle:render(delta)
                    end
                end
            end, "ex_skill_frame_particle_render")
        end
    end,

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models.models.ex_skill_frame.Gui:newPart("script_ex_skill_frame_particles")
    end
}

FrameParticleManager.init()

return FrameParticleManager
]]