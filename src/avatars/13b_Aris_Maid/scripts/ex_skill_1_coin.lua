---@class (exact) ExSkill1Coin.CallbackSet スポーンオブジェクトのコールバック関数のセット
---@field public onInit? fun(self: ExSkill1Coin) オブジェクトの初期化直後に呼ばれる関数
---@field public onDeinit? fun(self: ExSkill1Coin) オブジェクトの破棄直前に呼ばれる関数
---@field public onTick? fun(self: ExSkill1Coin, animPos: Vector3) 各ティック毎に呼ばれる関数
---@field public onRender? fun(self: ExSkill1Coin, delta: number, context: Event.Render.context) 各レンダーティック毎に呼ばれる関数

---@class (exact) ExSkill1Coin : SpawnObject Exスキル1で使用するコインオブジェクトの単一を管理するクラス
---@field package object ModelPart インスタンスで制御するオブジェクト
---@field package objectPos Vector3 コインオブジェクトの位置
---@field package animationCount integer コイン取得のアニメーションのタイミングを制御するカウンター
---@field package currentRot number コインの現在の回転角
---@field package rotSpeed number コインの回転速度
---@field package shouldPlaySound boolean コイン取得アニメーションを再生すべきかどうか
---@field package animMultiplayer number コイン取得アニメーションで浮き上がるコインの高さの倍率
---@field public callbacks? ExSkill1Coin.CallbackSet スポーンオブジェクトのコールバック関数
---@field public new fun(pos: Vector3): ExSkill1Coin コンストラクタ
---@field public playGetAnimation fun(self: ExSkill1Coin, shouldRandomizeMultiplayer: boolean) コイン取得アニメーションを再生する
local ExSkill1Coin = {
    ---コンストラクタ
    ---@param pos Vector3 コインをスポーンされるアバター座標
    ---@return ExSkill1Coin
    new = function (pos)
        ---@type ExSkill1Coin
        local instance = MiscUtils.instantiate(ExSkill1Coin, SpawnObject)

        instance.object = models.models.ex_skill_1.Coin:copy(instance.uuid)
        instance.objectPos = pos:copy()
        instance.animationCount = -1
        instance.currentRot = 0
        instance.rotSpeed = -5
        instance.shouldPlaySound = true
        instance.animMultiplayer = 1

        instance.callbacks = {
            onInit = function (self)
                models.script_ex_skill_1_coin:addChild(self.object)
                self.object:setVisible(true)
                self.object:setPos(instance.objectPos)
            end;

            onDeinit = function (self)
                models.script_ex_skill_1_coin:removeChild(self.object)
                self.object:remove()
            end;

            onTick = function (self, animPos)
                local worldPos = player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, self.objectPos:copy():add(0, math.sin(math.rad((10 - self.animationCount) * 9)) * 16 + 6.625, 0):mul(-1, self.animMultiplayer, -1):scale(0.05859375):add(math.random() * 0.75 - 0.325, math.random() * 0.75 - 0.325, math.random() * 0.75 - 0.325), 0, 1, 0))
                if (self.objectPos:copy():sub(animPos):length() < 16 or raycast:entity(worldPos:copy():add(0, -0.4140625, 0), worldPos:copy():add(0, 0.4140625, 0), function (entity)
                    return entity:isPlayer()
                end)) and self.animationCount == -1 then
                    self:playGetAnimation(false)
                end
                if self.animationCount >= 0 then
                    if self.animationCount == 10 and self.shouldPlaySound then
                        sounds:playSound("minecraft:entity.player.levelup", worldPos, 0.15, 2)
                    elseif self.animationCount == 0 then
                        self.shouldDeinit = true
                    end

                    particles:newParticle("minecraft:end_rod", worldPos):setColor(1, 0.984, 0.4):setVelocity(0, 0.1, 0):setLifetime(10)

                    self.animationCount = self.animationCount - 1
                end

                self.currentRot = self.currentRot + self.rotSpeed
            end;

            onRender = function (self, delta)
                self.object:setRot(0, self.currentRot + self.rotSpeed * delta, 0)
                if self.animationCount >= 0 then
                    local trueCount = (10 - self.animationCount + delta - 1) / 10
                    self.object:setPos(instance.objectPos:copy():add(0, math.sin(math.rad(trueCount * 90)) * 16 * self.animMultiplayer, 0))
                    self.object:setScale(vectors.vec3(1, 1, 1):scale(math.min((1 - trueCount) * 2, 1)))
                end
            end;
        }

        return instance
    end;

    ---コイン取得アニメーションを再生する。
    ---@param self ExSkill1Coin
    ---@param shouldRandomizeMultiplayer boolean コインが浮き上がるオフセット値にランダムな値を使用するかどうか
    playGetAnimation = function(self, shouldRandomizeMultiplayer)
        if shouldRandomizeMultiplayer then
            self.animMultiplayer = math.random() * 5 + 1
            self.shouldPlaySound = false
        else
            BlueArchiveCharacter.exSkill.primary.coinCount = BlueArchiveCharacter.exSkill.primary.coinCount + 1
        end
        self.rotSpeed = -50
        self.animationCount = 10
    end;
}

return ExSkill1Coin
