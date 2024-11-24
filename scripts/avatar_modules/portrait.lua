---@class (exact) Portrait : HeadModelGenerator ポートレートのモデルを管理するクラス

Portrait = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Portrait
    new = function (parent)
        ---@type Portrait
        local instance = Avatar.instantiate(Portrait, HeadModelGenerator, parent)

        instance.processData = instance.parent.characterData.portrait
        instance.parentName = "portrait"
        instance.parentType = "Portrait"

        return instance
    end;

    ---初期化関数
    ---@param self Portrait
    init = function (self)
        HeadModelGenerator.init(self)
    end;

    ---頭モデルのコピーを生成する。
    ---@param self HeadBlock
    generateHeadModel = function (self)
        HeadModelGenerator.generateHeadModel(self)
        if models.script_portrait.Head ~= nil then
            models.script_portrait.Head.HeadRing:remove()
        end
    end;
}