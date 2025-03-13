---@class (exact) HeadModelGenerator : AvatarModule 頭のモデルの生成を含む抽象クラス
---@field public processData BlueArchiveCharacter.HeadBlockStruct 頭モデルを生成する過程で参照するデータ
---@field public parentName string モデルを生成する名前空間
---@field public parentType ModelPart.parentType コピーした頭モデルに適用する親タイプ
---@field public generateHeadModel fun(self: HeadModelGenerator) 頭モデルのコピーを生成する
---@field package isScriptLoaded boolean スクリプトが全てロードされているかどうか

HeadModelGenerator = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return HeadModelGenerator
    new = function (parent)
        ---@type HeadModelGenerator
        local instance = Avatar.instantiate(HeadModelGenerator, AvatarModule, parent)

        instance.isScriptLoaded = false

        return instance
    end;

    ---初期化関数
    ---@param self HeadModelGenerator
    init = function (self)
        AvatarModule.init(self)

        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_"..self.parentName, "None")

        self.parent.avatarEvents.SCRIPT_INIT:register(function ()
            self.isScriptLoaded = true
        end)
    end;

    ---頭モデルのコピーを生成する。
    ---@param self HeadModelGenerator
    generateHeadModel = function (self)
        --既存の頭ブロックのモデルを削除する。
        if models["script_"..self.parentName].Head ~= nil then
            models["script_"..self.parentName].Head:remove()
        end

        --モデルコピー前の処理
        for _, modelPart in ipairs({models.models.main.Avatar.Head, models.models.main.Avatar.Head.HeadRing}) do
            modelPart:setVisible(true)
        end
        models.models.main.Avatar.Head:setPrimaryRenderType()
        models.models.main.Avatar.Head:setOpacity(1)
        local isHelmetVisible = self.isScriptLoaded and self.parent.armor.isArmorVisible.helmet or false
        if isHelmetVisible then
            self.parent.armor:setHelmet(world.newItem(self.parent.compatibilityUtils:checkItem("minecraft:air")))
        end
        if self.isScriptLoaded then
            self.parent.physics:disable()
        end
        if self.processData.callbacks ~= nil and self.processData.callbacks.onBeforeModelCopy ~= nil then
            self.processData.callbacks.onBeforeModelCopy(self.parent.characterData, self.isScriptLoaded)
        end

        --現在の衣装を基に新たな頭ブロックのモデルを生成する。
        local copiedPart = self.parent.modelUtils:copyModel(models.models.main.Avatar.Head)
        if copiedPart ~= nil then
            models["script_"..self.parentName]:addChild(copiedPart)
            models["script_"..self.parentName].Head:setParentType(self.parentType)
            models["script_"..self.parentName].Head:setPos(0, -24, 0)
            models["script_"..self.parentName].Head.HeadRing:setRot(self.parent.headRing.initialHaloRot)
            models["script_"..self.parentName].Head.HeadRing:setLight(15)
            for _, modelPart in ipairs({models["script_"..self.parentName].Head.FaceParts.Eyes.EyeRight, models["script_"..self.parentName].Head.FaceParts.Eyes.EyeLeft}) do
                modelPart:setUVPixels()
            end
            for _, modelPart in ipairs(self.processData.includeModels) do
                local copiedIncludePart = self.parent.modelUtils:copyModel(modelPart)
                if copiedIncludePart ~= nil then
                    models["script_"..self.parentName].Head:addChild(copiedIncludePart)
                end
            end
        end

        --非表示にしたモデルを元に戻す。
        if isHelmetVisible then
            self.parent.armor:setHelmet(self.parent.armor.armorSlotItems[1])
        end
        if self.isScriptLoaded then
            self.parent.physics:enable()
        end
        if self.processData.callbacks ~= nil and self.processData.callbacks.onAfterModelCopy ~= nil then
            self.processData.callbacks.onAfterModelCopy(self.parent.characterData, self.isScriptLoaded)
        end
    end;
}