---@class (exact) TrainManager : SpawnObjectManager Exスキル1で使用する列車を管理するクラス
---@field public objects RailObject[] インスタンスで制御するオブジェクト
---@field package railForwardLength integer 列車の前方に設置するレールの長さ
---@field package railBackwardLength integer 列車の通過後に残しておくレールの長さ
---@field package maxRailPerTick number 1ティックに設置する最大のレールの数
---@field package currentPos Vector3 線路の設置処理を行う現在の座標
---@field package railRot number 線路の向き
---@field package trainPos Vector3 列車の現在位置（線路の設置判定の基準にする）
---@field package railPlaceCount integer 現在のティックで設置したレールの数
---@field package trainAnimationTick integer 列車アニメーションのティック数
---@field package trainNextPos Vector3 列車の次ティックでの位置（列車アニメーション用）
---@field package trainVelocity number 列車の速度（列車アニメーション用）
---@field package trainSoundCounter integer 汽車のシュポシュポ音の回数をカウントする変数
---@field package whistleSound Sound|nil 汽笛の音のインスタンス
---@field public getObject fun(self: TrainManager, pos: Vector3, rot: number): RailObject 線路オブジェクトを生成して返す。
local TrainManager = {
    ---コンストラクタ
    ---@return TrainManager
    new = function ()
        ---@type TrainManager
        local instance = MiscUtils.instantiate(TrainManager, SpawnObjectManager)

        instance.railForwardLength = 32
        instance.railBackwardLength = math.huge
        instance.maxRailPerTick = math.huge

        instance.managerName = "ex_skill_1_rail"
        instance.currentPos = vectors.vec3()
        instance.railRot = 0
        instance.trainPos = vectors.vec3()
        instance.railPlaceCount = 0
        instance.trainAnimationTick = 0
        instance.trainNextPos = vectors.vec3()
        instance.trainVelocity = 0
        instance.trainSoundCounter = 0
        instance.whistleSound = nil

        return instance
    end;

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_ex_skill_1_rail", "World")
    end;

    ---線路オブジェクトを生成して返す。
    ---@param pos Vector3 線路オブジェクトを設置するワールド座標
    ---@param rot number 線路オブジェクトを設置するワールド方向
    ---@return RailObject instance 生成したインスタンス
    getObject = function (_, pos, rot)
        return RailObject.new(pos, rot)
    end;

    ---線路オブジェクトをスポーンさせる。
    ---@param self TrainManager
    ---@param pos Vector3 線路オブジェクトを設置するワールド座標
    ---@param rot number 線路オブジェクトを設置するワールド方向
    spawnRail = function (self, pos, rot)
        ---@diagnostic disable-next-line: redundant-parameter
        local instance = self:getObject(pos, rot)
        table.insert(self.objects, instance)
        if instance.callbacks ~= nil and instance.callbacks.onInit ~= nil then
            instance.callbacks.onInit(instance)
        end

        if #self.objects == 1 then
            events.TICK:remove(self.managerName.."_tick")
            events.RENDER:remove(self.managerName.."_render")
            events.TICK:register(function ()
                if not client:isPaused() then
                    for index, ins in ipairs(self.objects) do
                        if ins.callbacks ~= nil and ins.callbacks.onTick ~= nil and self.trainPos ~= nil then
                            ins.callbacks.onTick(ins, self.trainPos, self.railBackwardLength)
                        end
                        if ins.shouldDeinit then
                            if ins.callbacks ~= nil and ins.callbacks.onDeinit ~= nil then
                                ins.callbacks.onDeinit(ins)
                            end
                            table.remove(self.objects, index)
                            if #self.objects == 0 then
                                events.TICK:remove(self.managerName.."_tick")
                            end
                        end
                    end
                end
            end, self.managerName.."_tick")
        end
    end;

    ---Exスキル用の線路をスポーンさせる。
    ---@param self TrainManager
    spawnExSkillRail = function (self)
        self.railForwardLength = 32
        self.railBackwardLength = math.huge
        self.maxRailPerTick = math.huge
        self.currentPos = player:getPos()
        self.rot = (player:getBodyYaw() * -1) % 360
        self.trainPos = self.currentPos:copy()
        events.TICK:register(function ()
            while self.currentPos:copy():sub(self.trainPos:copy():add(vectors.rotateAroundAxis(self.rot, 0, 0, 2 * self.railForwardLength, 0, 1, 0))):length() >= 2 and self.railPlaceCount < self.maxRailPerTick do
                self:spawnRail(self.currentPos:copy():scale(16), self.rot)
                self.currentPos:add(vectors.rotateAroundAxis(self.rot, 0, 0, 2, 0, 1, 0))
                self.railPlaceCount = self.railPlaceCount + 1
            end
            self.trainPos = player:getPos():add(vectors.rotateAroundAxis(self.rot, ModelAlias.alias.avatar.root:getAnimPos():mul(-0.0625 * 0.9375, 0, -0.0625 * 0.9375), 0, 1, 0))
            self.railPlaceCount = 0
        end, "train_manager_ex_skill_tick")
    end;

    ---Exスキル用の線路スポーン処理を停止させる。
    ---@param self TrainManager
    stopExSkillRail = function (self)
        events.TICK:remove("train_manager_ex_skill_tick")
        self:removeAll()
    end;

    ---（Exスキル再生後の）列車アニメーションを再生する。
    ---@param self TrainManager
    playTrainAnimation = function (self)
        self.railForwardLength = 8
        self.railBackwardLength = 8
        self.maxRailPerTick = 1
        local bodyYaw = player:getBodyYaw()
        self.currentPos = player:getPos():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, 1, 0, 1, 0)):scale(16)
        self.rot = (player:getBodyYaw() * -1) % 360
        self.trainPos = player:getPos():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, 6, 0, 1, 0)):scale(16)
        self.trainNextPos = self.trainPos:copy()
        ModelAlias.alias.avatar.lowerBody.Train:setPos(self.trainPos)
        ModelAlias.alias.avatar.lowerBody.Train:setRot(0, bodyYaw * -1 + 180, 0)
        ModelAlias.alias.avatar.lowerBody.Train:setParentType("World")
        ModelAlias.alias.avatar.lowerBody.Train:setVisible(true)
        for _, animationName in ipairs({"train_animation", "train_go"}) do
            animations["models.ex_skill_1"][animationName]:play()
        end
        events.TICK:register(function ()
            while self.currentPos:copy():sub(self.trainPos:copy():add(vectors.rotateAroundAxis(self.rot, 0, 0, 32 * self.railForwardLength, 0, 1, 0))):length() >= 32 and self.railPlaceCount < self.maxRailPerTick do
                self:spawnRail(self.currentPos, self.rot)
                self.currentPos:add(vectors.rotateAroundAxis(self.rot, 0, 0, 32, 0, 1, 0))
                self.railPlaceCount = self.railPlaceCount + 1
            end
            self.railPlaceCount = 0

            self.trainPos = self.trainNextPos:copy()
            self.trainNextPos = self.trainPos:copy():add(vectors.rotateAroundAxis(self.rot, 0, 0, self.trainVelocity, 0, 1, 0))

            for _, modelPart in ipairs({ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1RightFirework.TrainCar1RightFireworkParticleAnchor, ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1LeftFirework.TrainCar1LeftFireworkParticleAnchor}) do
                local anchorPos = ModelUtils.getModelWorldPos(modelPart)
                particles:newParticle("minecraft:large_smoke", ModelUtils.getModelWorldPos(modelPart):add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, 2, 0, 1, 0))):setScale(2)
                particles:newParticle("minecraft:soul_fire_flame", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, 2, 0, 1, 0))):setScale(2)
                particles:newParticle("minecraft:firework", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, 2, 0, 1, 0))):setScale(1.5)
            end

            if self.trainAnimationTick >= 30 then
                if self.trainAnimationTick == 30 then
                    self.whistleSound = sounds:playSound("minecraft:item.goat_horn.sound.1", self.trainPos:copy():scale(0.0625), 1, 0.5):setAttenuation(5)
                    self.trainVelocity = 20
                elseif self.trainAnimationTick == 230 then
                    self:explode()
                    return
                end
                if self.trainAnimationTick % 3 == 0 then
                    sounds:playSound(self.trainSoundCounter % 2 == 0 and "minecraft:block.piston.extend" or "minecraft:block.piston.contract", ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train), 0.5, 0.35 * (math.random() * 0.1 + 0.9))
                    self.trainSoundCounter = self.trainSoundCounter + 1
                end
                self.whistleSound:setPos(self.trainPos:copy():scale(0.0625))

                --当たり判定チェック
                local pos = ModelAlias.alias.avatar.lowerBody.Train:getPos():scale(0.0625):add(vectors.rotateAroundAxis(self.rot, 0, 1, 6, 0, 1, 0))
                for _, collisionBox in ipairs(world.getBlockState(pos):getCollisionShape()) do
                    local collisionBoxStart = pos:copy():floor():add(collisionBox[1])
                    local collisionBoxEnd = pos:copy():floor():add(collisionBox[2])

                    if collisionBoxStart.x <= pos.x and collisionBoxEnd.x >= pos.x and collisionBoxStart.y <= pos.y and collisionBoxEnd.y >= pos.y and collisionBoxStart.z <= pos.z and collisionBoxEnd.z >= pos.z then
                        self:explode()
                        return
                    end
                end

                local anchorPos = ModelUtils.getModelWorldPos(ModelAlias.alias.avatar.lowerBody.Train.TrainCar1.TrainCar1ShineEffects)
                for i = 0, 11 do
                    particles:newParticle("minecraft:cloud", anchorPos:copy():add(vectors.rotateAroundAxis(self.rot, 0, 0, 4, 0, 1, 0))):setScale(5):setColor(0.796, 0.996, 0.596):setVelocity(vectors.rotateAroundAxis(self.rot, vectors.rotateAroundAxis(i * 30, 0, 0.5, 0, 0, 0, 1), 0, 1, 0)):setLifetime(5)
                end
            end
            animations["models.ex_skill_1"]["train_go"]:setSpeed(self.trainVelocity * 20 / 55)
            self.trainAnimationTick = self.trainAnimationTick + 1
        end, "train_manager_train_tick")
        events.RENDER:register(function (delta)
            ModelAlias.alias.avatar.lowerBody.Train:setPos(self.trainPos:copy():add(self.trainNextPos:copy():sub(self.trainPos):scale(delta)))
        end, "train_manager_train_render")
    end;

    ---列車を爆破する（列車アニメーション用）
    ---@param self TrainManager
    explode = function (self)
        local pos = ModelAlias.alias.avatar.lowerBody.Train:getPos():scale(0.0625):add(vectors.rotateAroundAxis(self.rot, 0, 1, 0, 0, 1, 0))
        particles:newParticle("minecraft:explosion_emitter", pos)
        for _ = 1, 20 do
            local randomOffset = vectors.vec3(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)
            particles:newParticle("minecraft:poof", pos:copy():add(randomOffset:copy():scale(5))):setScale(3):setVelocity(randomOffset:copy():scale(1))
        end
        sounds:playSound("minecraft:entity.generic.explode", pos, 0.5, 1):setAttenuation(5)
        self:stopTrainAnimation()
    end;

    ---（Exスキル再生後の）列車アニメーションを停止する。
    ---@param self TrainManager
    stopTrainAnimation = function (self)
        events.TICK:remove("train_manager_train_tick")
        events.RENDER:remove("train_manager_train_render")
        ModelAlias.alias.avatar.lowerBody.Train:setPos()
        ModelAlias.alias.avatar.lowerBody.Train:setRot()
        ModelAlias.alias.avatar.lowerBody.Train:setParentType("None")
        ModelAlias.alias.avatar.lowerBody.Train:setVisible(false)
        for _, animationName in ipairs({"train_animation", "train_go"}) do
            animations["models.ex_skill_1"][animationName]:stop()
        end
        self.trainAnimationTick = 0
        self.trainVelocity = 0
        self.trainSoundCounter = 0
        self.whistleSound = nil
    end;
}

return TrainManager
