---@class (exact) ModelUtils モデルに関するユーティリティ関数群
local ModelUtils = {
    ---指定したモデルのワールド位置を返す。
    ---@param model ModelPart ワールド位置を取得するモデルパーツ
    ---@return Vector3 worldPos モデルのワールド位置
    getModelWorldPos = function(model)
        local modelMatrix = model:partToWorldMatrix()
        return vectors.vec3(modelMatrix[4][1], modelMatrix[4][2], modelMatrix[4][3])
    end;

    ---モデルパーツをディープコピーする。
    ---非表示のモデルパーツはコピーしない。
    ---@param modelPart ModelPart コピーするモデルパーツ
    ---@param name? string コピーしたモデルパーツの名前。省略した際はコピー元と同じ名前になる。
    ---@param forceCopy? boolean 非表示のモデルも強制的にコピーするかどうか
    ---@return ModelPart|nil copiedModelPart コピーされたモデルパーツ。入力されたモデルパーツが非表示の場合はnilが返る。
    copyModel = function (self, modelPart, name, forceCopy)
        if modelPart:getVisible() or forceCopy then
            local copy = modelPart:copy(name ~= nil and name or modelPart:getName())
            copy:setParentType("None")
            for _, child in ipairs(copy:getChildren()) do
                copy:removeChild(child)
                local childModel = self:copyModel(child)
                if childModel ~= nil then
                    copy:addChild(childModel)
                end
            end
            return copy
        end
    end;

    ---モデルパーツを別の親に移動させる。
    ---組み込みmoveTo()で何故かモデルパーツが残ってしまう問題に対処済み。
    ---@param target ModelPart 移動させる対象のモデルパーツ
    ---@param destination ModelPart 移動先の親
    ---@param originalParent ModelPart 移動元の親
    moveTo = function (target, destination, originalParent)
        target:moveTo(destination)
        local modelName = target:getName()
        if originalParent[modelName] ~= nil then
            originalParent:removeChild(target)
        end
    end;

    ---モデルの頭部をディープコピーし、ターゲットの子要素として挿入する。
    ---@param self ModelUtils
    ---@param target ModelPart コピーした頭部モデルの挿入先
    ---@param name? string コピーした頭部モデルの名前。省略した際はコピー元と同じ名前になる。
    copyHeadModel = function (self, target, name)
        --モデルコピー前の処理
        for _, modelPart in ipairs({ModelAlias.alias.avatar.head, ModelAlias.alias.avatar.halo}) do
            modelPart:setVisible(true)
        end
        Physics:disable()

        if BlueArchiveCharacter.headModel.callbacks ~= nil and BlueArchiveCharacter.headModel.callbacks.onBeforeModelCopy ~= nil then
            BlueArchiveCharacter.headModel.callbacks.onBeforeModelCopy(BlueArchiveCharacter)
        end

        --現在の衣装を基に新たな頭ブロックのモデルを生成する。
        local copiedPart = self:copyModel(ModelAlias.alias.avatar.head, name)
        copiedPart:setPos(0, -24, 0)
        copiedPart:setRot()
        copiedPart:setScale()
        copiedPart:setPrimaryRenderType()
        copiedPart:setOpacity(1)
        copiedPart:setParentType("None")
        copiedPart.Halo:setRot(Halo.initialHaloRot, 0, 0)
        copiedPart.Halo:setLight(15)
        for _, modelPart in ipairs({copiedPart.FaceParts.Eyes.RightEye, copiedPart.FaceParts.Eyes.LeftEye}) do
            modelPart:setUVPixels()
        end
        if copiedPart.ArmorH ~= nil then
            local model = copiedPart.ArmorH
            copiedPart:removeChild(model)
            model:remove()
        end
        target:addChild(copiedPart)

        if BlueArchiveCharacter.headModel.callbacks ~= nil and BlueArchiveCharacter.headModel.callbacks.onAfterModelCopy ~= nil then
            BlueArchiveCharacter.headModel.callbacks.onAfterModelCopy(BlueArchiveCharacter)
        end

        --非表示にしたモデルを元に戻す。
        Physics:enable()
    end;
}

return ModelUtils
