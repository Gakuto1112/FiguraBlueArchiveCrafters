---@class (exact) HeadBlock : HeadModelGenerator 頭ブロックのモデルを制御するクラス
---@field package forceGenerateCount integer 強制的に頭ブロックを生成するまでのカウンター。これが発火するのはアバタープレイヤーがオフラインの時のみ。

HeadBlock = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return HeadBlock
    new = function (parent)
        ---@type HeadBlock
        local instance = Avatar.instantiate(HeadBlock, HeadModelGenerator, parent)

        instance.processData = instance.parent.characterData.headBlock
        instance.parentName = "head_block"
        instance.parentType = "Skull"
        instance.forceGenerateCount = 2

        return instance
    end;

    ---初期化関数
    ---@param self HeadBlock
    init = function (self)
        HeadModelGenerator.init(self)
        events.WORLD_TICK:register(function ()
            self.forceGenerateCount = self.forceGenerateCount - 1
            if self.forceGenerateCount == 0 then
                self:generateHeadModel()
                events.WORLD_TICK:remove("head_block_world_tick")
            end
        end, "head_block_world_tick")
    end;
}