---@class ExSkill1TransitionManager : SpawnObjectManager Exスキル1で使用するトランジション効果のマネージャークラス
---@field public getObject fun(self: ExSkill1TransitionManager, pos: Vector2): ExSkill1TextObject トランジションスプライトのインスタンスを生成して返す
---@field public spawn fun(self:  ExSkill1TransitionManager, pos: Vector2) トランジションスプライトを生成する
---@field public play fun(self: ExSkill1TransitionManager) トランジションを再生する
---@field public stop fun(self: ExSkill1TransitionManager) トランジションを停止する
local ExSkill1TransitionManager = {
    ---コンストラクタ
    ---@return ExSkill1TransitionManager
    new = function ()
        ---@type ExSkill1TransitionManager
        ---@diagnostic disable-next-line: undefined-global
        local instance = MiscUtils.instantiate(ExSkill1TransitionManager, SpawnObjectManager)

        instance.managerName = "ex_skill_1_transition"

        return instance
    end;

    ---トランジションスプライトのインスタンスを生成して返す。
    ---@param pos Vector2 スプライトの位置（左からx番目、上からy番目のスプライト）
    ---@return ExSkill1TransitionSprite instance 生成したインスタンス
    getObject = function (_, pos)
        return ExSkill1TransitionSprite.new(pos)
    end;

    ---トランジションスプライトを生成する。
    ---@param self ExSkill1TransitionManager
    ---@param pos Vector2 スプライトの位置（左からx番目、上からy番目のスプライト）
    spawn = function (self, pos)
        SpawnObjectManager.spawn(self, pos)
    end;

    ---トランジションを再生する。
    ---@param self ExSkill1TransitionManager
    play = function (self)
        self:stop()

        local spriteDimension = client:getScaledWindowSize():scale(1 / 50):ceil()
        local linesPerTick = (spriteDimension.x + spriteDimension.y - 1) / 10
        local targetLine = 0
        local currentLine = 0

        events.TICK:register(function ()
            while currentLine <= targetLine do
                for i = 0, math.max(math.min(currentLine, spriteDimension.x - currentLine - 1), spriteDimension.y - 1) do
                    if currentLine - i >= 0 and currentLine - i <= spriteDimension.x - 1 then
                        self:spawn(vectors.vec2(currentLine - i, i))
                    end
                end
                currentLine = currentLine + 1
                if currentLine == spriteDimension.x + spriteDimension.y - 1 then
                    events.TICK:remove(self.managerName.."_play_tick")
                    break
                end
            end
            targetLine = targetLine + linesPerTick
        end, self.managerName.."_play_tick")
    end;

    ---トランジションを停止する。
    ---@param self ExSkill1TransitionManager
    stop = function (self)
        events.TICK:remove(self.managerName.."_play_tick")
        self:removeAll()
    end;
}

return ExSkill1TransitionManager
