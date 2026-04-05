---@class (exact) DeathAnimation プレイヤーが死亡した際のキャラクターがヘリコプターで回収されるアニメーションを管理するクラス
---@field public dummyAvatarRoot? ModelPart 死亡アニメーションに使用されるダミーのアバターのルート。アバターが未生成の場合はnilが入っている。
---@field package deathCheckDelay integer 死亡チェックの遅延カウンター
---@field package animationCount integer 死亡アニメーションの再生カウンター
---@field package animationPos Vector3 アニメーションを再生している場所の座標
---@field package animationRot number アニメーションを再生している向き（度数法で示す）
---@field package isDUmmyAvatarAltCostume boolean ダミーアバターがバリエーション衣装かどうか
---@field package isPlayerInvisible boolean プレイヤーモデルが不可視状態かどうか
---@field package isScriptLoaded boolean スクリプトを全て読み込んだかどうか
local DeathAnimation = {
	deathCheckDelay = -1;
	animationCount = 0;
	animationPos = vectors.vec3();
	animationRot = 0;
	isDummyAvatarAltCostume = false;
	isPlayerInvisible = false;
	isScriptLoaded = false;

    ---初期化関数
    ---@param self DeathAnimation
    init = function (self)
        events.TICK:register(function ()
            local health = player:getHealth()
            if self.deathCheckDelay == 0 and health == 0 then
                self:play()
                models.models.main:setVisible(false)
                for _, vanillaModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM, vanilla_model.ELYTRA}) do
                    vanillaModel:setVisible(false)
                end
                self.isPlayerInvisible = true
            elseif self.isPlayerInvisible and health > 0 then
                models.models.main:setVisible(true)
                for _, vanillaModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM, vanilla_model.ELYTRA}) do
                    vanillaModel:setVisible(true)
                end
                self.isPlayerInvisible = false
            end
            self.deathCheckDelay = math.max(self.deathCheckDelay - 1, -1)
        end)

        events.DAMAGE:register(function ()
            self.deathCheckDelay = 1
        end)

		KeyManager:register("debug_death_animation", "key.keyboard.keypad.5"):onPress(function (modifiers, self2)
			self:play()
		end)
    end;

    ---存在しないかもしれないモデルパーツを安全に削除する。
    ---@param target? ModelPart 削除対象のモデルパーツ
    removeUnsafeModel = function (target)
        if target ~= nil then
            target:getParent():removeChild(target)
            target:remove()
        end
    end;

    ---ヘリコプターの出現/消滅パーティクルを生成する。
    ---@param self DeathAnimation
    spawnHelicopterParticles = function (self)
        local helicopterPos = ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter)
        for _ = 1, 100 do
            particles:newParticle("minecraft:poof", helicopterPos:copy():add(vectors.rotateAroundAxis(self.animationRot, math.random() * 9.375 - 4.6875, math.random() * 11.125 - 5.5625, math.random() * 23.875 - 11.9375, 0, math.abs(helicopterPos.y), 0)))
        end
    end;

    ---死亡アニメーション用のダミーアバターを生成する。
    ---@param self DeathAnimation
    ---@param parent ModelPart ダミーアバターをアタッチする親のモデルパーツ
    generateDummyAvatar = function (self, parent)
        for _, modelPart in ipairs({ModelAlias.alias.avatar.head, ModelAlias.alias.avatar.halo}) do
            modelPart:setVisible(true)
        end
        ModelAlias.alias.avatar.head:setPrimaryRenderType()
        ModelAlias.alias.avatar.head:setOpacity(1)
        local isArmorVisible = {
            helmet = Armor.isArmorVisible.helmet;
            chestplate = Armor.isArmorVisible.chestplate;
            leggings = Armor.isArmorVisible.leggings;
            boots = Armor.isArmorVisible.boots;
        }
        if isArmorVisible.helmet then
            Armor:setHelmet(world.newItem("minecraft:air"))
        end
        if isArmorVisible.chestplate then
            Armor:setChestplate(world.newItem("minecraft:air"))
        end
        if isArmorVisible.leggings then
            Armor:setLeggings(world.newItem("minecraft:air"))
        end
        if isArmorVisible.boots then
            Armor:setBoots(world.newItem("minecraft:air"))
        end
        Physics:disable()
        if BlueArchiveCharacter.deathAnimation.callbacks ~= nil and BlueArchiveCharacter.deathAnimation.callbacks.onBeforeModelCopy ~= nil then
            BlueArchiveCharacter.deathAnimation.callbacks.onBeforeModelCopy(BlueArchiveCharacter)
        end

        parent:addChild(ModelUtils:copyModel(models.models.main.Avatar))
		ModelAlias.alias.dummy_avatar = ModelAlias.getAliasTable(parent.Avatar)
        ModelAlias.alias.dummy_avatar.rightEye:setUVPixels(BlueArchiveCharacter.faceParts.leftEye.TIRED:copy():scale(6))
        ModelAlias.alias.dummy_avatar.leftEye:setUVPixels(BlueArchiveCharacter.faceParts.rightEye.TIRED:copy():scale(6))
        ModelAlias.alias.dummy_avatar.halo:setRot(Halo.initialHaloRot, 0, 0)
        for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.rightItemPivot, ModelAlias.alias.dummy_avatar.leftItemPivot}) do
            modelPart:remove()
        end
        local unsafeModels = {ModelAlias.alias.dummy_avatar.mouth, ModelAlias.alias.dummy_avatar.head.ArmorH, ModelAlias.alias.dummy_avatar.body.Bubble, ModelAlias.alias.dummy_avatar.body.ArmorB, ModelAlias.alias.dummy_avatar.rightArm.ArmorRA, ModelAlias.alias.dummy_avatar.rightArmBottom.ArmorRAB, ModelAlias.alias.dummy_avatar.leftArm.ArmorLA, ModelAlias.alias.dummy_avatar.leftArmBottom.ArmorLAB, ModelAlias.alias.dummy_avatar.rightLeg.ArmorRL, ModelAlias.alias.dummy_avatar.rightLegBottom.ArmorRLB, ModelAlias.alias.dummy_avatar.leftLeg.ArmorLL, ModelAlias.alias.dummy_avatar.leftLegBottom.ArmorLLB}
        for i = 1, 12 do
            self.removeUnsafeModel(unsafeModels[i])
        end
        if ModelAlias.alias.dummy_avatar.gun ~= nil then
            if BlueArchiveCharacter.gun.gunPosition.put.type == "BODY" then
                local leftHanded = player:isLeftHanded()
                ModelAlias.alias.dummy_avatar.gun:setPos(vectors.vec3(0, 12, 0):add(BlueArchiveCharacter.gun.gunPosition.put.pos[leftHanded and "left" or "right"]))
                ModelAlias.alias.dummy_avatar.gun:setRot(BlueArchiveCharacter.gun.gunPosition.put.rot[leftHanded and "left" or "right"])
            else
                ModelAlias.alias.dummy_avatar.gun:remove()
            end
        end

        if isArmorVisible.helmet then
            Armor:setHelmet(Armor.armorSlotItems[1])
        end
        if isArmorVisible.chestplate then
            Armor:setChestplate(Armor.armorSlotItems[2])
        end
        if isArmorVisible.leggings then
            Armor:setLeggings(Armor.armorSlotItems[3])
        end
        if isArmorVisible.boots then
            Armor:setBoots(Armor.armorSlotItems[4])
        end
        Physics:enable()
        if BlueArchiveCharacter.deathAnimation.callbacks ~= nil and BlueArchiveCharacter.deathAnimation.callbacks.onAfterModelCopy ~= nil then
            BlueArchiveCharacter.deathAnimation.callbacks.onAfterModelCopy(BlueArchiveCharacter)
        end
    end;

    ---ダミーアバター状態をリセットする。
    resetDummyAvatar = function ()
        for _, modelPart in ipairs({ModelAlias.alias.dummy_avatar.root, ModelAlias.alias.dummy_avatar.head, ModelAlias.alias.dummy_avatar.upperBody, ModelAlias.alias.dummy_avatar.body, ModelAlias.alias.dummy_avatar.arms, ModelAlias.alias.dummy_avatar.rightArm, ModelAlias.alias.dummy_avatar.rightArmBottom, ModelAlias.alias.dummy_avatar.leftArm, ModelAlias.alias.dummy_avatar.leftArmBottom, ModelAlias.alias.dummy_avatar.lowerBody, ModelAlias.alias.dummy_avatar.legs, ModelAlias.alias.dummy_avatar.rightLeg, ModelAlias.alias.dummy_avatar.rightLegBottom, ModelAlias.alias.dummy_avatar.leftLeg, ModelAlias.alias.dummy_avatar.leftLegBottom}) do
            modelPart:setPos()
            modelPart:setRot()
            modelPart:setScale()
        end
    end;

    ---ダミーアバターをフェーズ1のポーズにする。
    setPhase1Pose = function ()
        ModelAlias.alias.dummy_avatar.root:setPos(0, -12, 0)
        ModelAlias.alias.dummy_avatar.head:setRot(-30, 0, 0)
        ModelAlias.alias.dummy_avatar.rightArm:setRot(35, 0, -20)
        ModelAlias.alias.dummy_avatar.leftArm:setRot(35, 0, 20)
        ModelAlias.alias.dummy_avatar.rightLeg:setRot(90, -10, 0)
        ModelAlias.alias.dummy_avatar.leftLeg:setRot(90, 10, 0)
    end;

    ---ダミーアバターをフェーズ2のポーズにする。
    setPhase2Pose = function ()
        ModelAlias.alias.dummy_avatar.root:setPos(3, -210, 2)
        ModelAlias.alias.dummy_avatar.root:setRot(105, 75, 90)
        ModelAlias.alias.dummy_avatar.head:setRot(0, -40, 0)
        ModelAlias.alias.dummy_avatar.rightArm:setRot(47.5, 0, 20)
        ModelAlias.alias.dummy_avatar.leftArm:setRot(-30, 0, -15)
        ModelAlias.alias.dummy_avatar.rightLeg:setRot(80, 0, 0)
        ModelAlias.alias.dummy_avatar.rightLegBottom:setRot(-75, 0, 0)
        ModelAlias.alias.dummy_avatar.leftLeg:setRot(10, 0, 0)
        ModelAlias.alias.dummy_avatar.root:setLight()
    end;

    ---死亡アニメーションを再生する。
    ---@param self DeathAnimation
    play = function (self)
        self:stop()
        self.isDummyAvatarAltCostume = Costume.isAltCostume

        --ダミーアバターを生成する。
		if ModelAlias.alias.dummy_avatar ~= nil then
			ModelAlias.alias.dummy_avatar.root:remove()
			ModelAlias.alias.dummy_avatar = nil
		end

        self:generateDummyAvatar(models.models.death_animation)

        --死亡アニメーションを生成する。
        self.resetDummyAvatar()
        self.setPhase1Pose()
        self.animationPos = player:getPos()
        models.models.death_animation:setPos(self.animationPos:copy():scale(16))
        self.animationRot = (player:getBodyYaw() * -1 + 180) % 360
        models.models.death_animation:setRot(0, self.animationRot)
        models.models.death_animation:setVisible(true)
        animations["models.death_animation"]["death_animation"]:play()
        if BlueArchiveCharacter.deathAnimation.callbacks ~= nil and BlueArchiveCharacter.deathAnimation.callbacks.onPhase1 ~= nil then
            BlueArchiveCharacter.deathAnimation.callbacks.onPhase1(BlueArchiveCharacter, self.isDummyAvatarAltCostume)
        end

        if events.TICK:getRegisteredCount("death_animation_tick") == 0 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    local particleAnchorPos = ModelUtils.getModelWorldPos(models.models.death_animation.DeathAnimationParticleAnchor)
                    for _ = 1, 3 do
                        local particleRot = math.random() * math.pi * 2
                        local particleOffset = math.random() * 3
                        particles:newParticle("minecraft:poof", particleAnchorPos:copy():add(math.cos(particleRot) * particleOffset, 0, math.sin(particleRot) * particleOffset)):setVelocity(math.cos(particleRot), 0, math.sin(particleRot))

                    end
                    if self.animationCount % 2 == 1 then
                        sounds:playSound("minecraft:block.bamboo_wood_door.close", ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter.DeathAnimationSoundAnchor1), 1, 0.5):setAttenuation(2)
                    end
                    if self.animationCount < 120 then
                        ModelAlias.alias.dummy_avatar.root:setLight(world.getBlockLightLevel(self.animationPos), world.getSkyLightLevel(self.animationPos))
                    end
                    if self.animationCount == 1 then
                        self:spawnHelicopterParticles()
                    elseif self.animationCount == 10 then
                        sounds:playSound("minecraft:block.iron_door.open", ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter.DeathAnimationSoundAnchor1), 1, 0.5)
                    elseif self.animationCount >= 57 and self.animationCount < 76 then
                        sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14), 0.25, -0.056 * (self.animationCount - 57) + 2)
                    elseif self.animationCount == 120 then
						ModelAlias.alias.dummy_avatar.root:moveTo(models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14)
						ModelAlias.alias.dummy_avatar.root = models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14.Avatar
                        self.setPhase2Pose()
                        if BlueArchiveCharacter.deathAnimation.callbacks ~= nil and BlueArchiveCharacter.deathAnimation.callbacks.onPhase2 ~= nil then
                            BlueArchiveCharacter.deathAnimation.callbacks.onPhase2(BlueArchiveCharacter, self.isDummyAvatarAltCostume)
                        end
                    elseif self.animationCount == 180 then
                        ModelAlias.alias.dummy_avatar.root:setVisible(false)
                    elseif self.animationCount == 230 then
                        sounds:playSound("minecraft:block.iron_door.close", ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter.DeathAnimationSoundAnchor1), 1, 0.5)
                    elseif self.animationCount == 255 then
                        self:spawnHelicopterParticles()
                        self:stop()
                    end
                end
            end, "death_animation_tick")
        end
        if events.WORLD_TICK:getRegisteredCount("death_animation_world_tick") == 0 then
            events.WORLD_TICK:register(function ()
                if not client:isPaused() then
                    self.animationCount = self.animationCount + 1
                end
            end, "death_animation_world_tick")
        end
    end;

    ---死亡アニメーションを停止する。
    ---@param self DeathAnimation
    stop = function (self)
        models.models.death_animation:setVisible(false)
        animations["models.death_animation"]["death_animation"]:stop()
        events.TICK:remove("death_animation_tick")
        events.WORLD_TICK:remove("death_animation_world_tick")
        self.dummyAvatarRoot = nil
        self.animationCount = 0
    end;
}

return DeathAnimation
