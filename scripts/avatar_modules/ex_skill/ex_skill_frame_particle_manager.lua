---@alias ExSkillFrameParticleManager.ParticleType
---| "NORMAL" # 通常のパーティクル
---| "FIGURA" # Figuraマークのパーティクル（穴空き三角形）

---@class (exact) ExSkillFrameParticleManager : SpawnObjectManager Exスキルのフレームで使用するパーティクルを管理するクラス
---@field public getObject fun(self: ExSkillFrameParticleManager, pos: Vector2, velocity: Vector2): ExSkillFrameParticle スポーンオブジェクトのインスタンスを生成して返す
---@field public spawn fun(self: ExSkillFrameParticleManager, pos: Vector2, velocity: Vector2) オブジェクトをスポーンさせる

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

    ---初期化関数
    ---@param self ExSkillFrameParticleManager
    init = function (self)
        SpawnObjectManager.init(self)

        ---@diagnostic disable-next-line: discard-returns
        models.models.ex_skill_frame.Gui:newPart("script_ex_skill_frame_particles")
    end;

    ---Exスキルフレームのパーティクルのインスタンスを生成して返す。
    ---@param self ExSkillFrameParticleManager
    ---@param pos Vector2 パーティクルをスポーンさせる画面上の座標
    ---@param velocity Vector2 パーティクルの速度
    ---@return ExSkillFrameParticle instance 生成したインスタンス
    getObject = function (self, pos, velocity)
        return ExSkillFrameParticle.new(self.parent, pos, velocity, math.random() > 0.9999 and "FIGURA" or "NORMAL")
    end;

    ---Exスキルフレームのパーティクルをスポーンさせる。
    ---@param self ExSkillFrameParticleManager
    ---@param pos Vector2 パーティクルをスポーンさせる画面上の座標
    ---@param velocity Vector2 パーティクルの速度
    spawn = function (self, pos, velocity)
        SpawnObjectManager.spawn(self, pos, velocity)
    end;
}