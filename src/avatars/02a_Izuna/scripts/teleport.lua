---@class Teleport 忍術ワープを表現するクラス
---@field package playerPosPrev Vector3 前ティックのプレイヤーの位置
---@field package isStandingPrev boolean 前ティックにプレイヤーが立っていたかどうか
---@field package bodyYawPrev number 前ティックの体の向き
---@field package healthPrev integer 前ティックのHP量
local Teleport = {
	playerPosPrev = vectors.vec3();
	isStandingPrev = true;
	bodyYawPrev = 0;
	healthPrev = 20;

    ---初期化関数
    ---@param self Teleport
    init = function (self)
		self.playerPosPrev = player:getPos()
		self.isStandingPrev = player:getPose() == "STANDING" and player:getVehicle() == nil
		self.bodyYawPrev = player:getBodyYaw()
		self.healthPrev = player:getHealth()

        events.TICK:register(function ()
            local playerPos = player:getPos()
            local isStanding = player:getPose() == "STANDING" and player:getVehicle() == nil
            if playerPos:copy():sub(self.playerPosPrev):length() - 1 > player:getVelocity():length() and isStanding and self.isStandingPrev and self.healthPrev > 0 then
                pings.teleport(playerPos, self.playerPosPrev, self.bodyYawPrev)
            end

            self.playerPosPrev = playerPos
            self.isStandingPrev = isStanding
            self.bodyYawPrev = player:getBodyYaw()
            self.healthPrev = player:getHealth()
        end)
    end;
}

---テレポート時の演出（パーティクル、狐の人形）
---@param currentPos Vector3 テレポート先のワールド座標
---@param previousPos Vector3 テレポート元のワークフロー座標
---@param previousRot number テレポート時の体の向き
function pings.teleport(currentPos, previousPos, previousRot)
    PlacementObjectManager:removeAll()
    if math.random() >= 0.95 then
        BlueArchiveCharacter.placementObjects[1].model:setPrimaryTexture("RESOURCE", "textures/entity/fox/snow_fox.png")
    else
        BlueArchiveCharacter.placementObjects[1].model:setPrimaryTexture("PRIMARY")
    end
    PlacementObjectManager:spawn(1, previousPos, previousRot * -1 + 180)
    for _ = 1, 70 do
        particles:newParticle("minecraft:poof", currentPos:copy():add(math.random() * 2 - 1, math.random() * 3 - 0.5, math.random() * 2 - 1))
        particles:newParticle("minecraft:poof", previousPos:copy():add(math.random() * 2 - 1, math.random() * 3 - 0.5, math.random() * 2 - 1))
    end
    sounds:playSound("minecraft:entity.shulker.shoot", currentPos, 1, 2)
end

return Teleport
