---@class (exact) Car 車を制御するクラス
---@field public isRidingCar boolean 車に乗っているかどうか
---@field package isRidingCarPrev boolean 前ティックで車に乗っていたかどうか
---@field package modelOffsetPosY number アバターモデル全体のY軸オフセット位置
---@field public handleRot number 現在の車のハンドルの角度
---@field public handleRotPrev number 前ティックの車のハンドルの角度
---@field package engineSound Sound|nil 車のエンジン音のインスタンス
local Car = {
	isRidingCar = false;
	isRidingCarPrev = false;
	modelOffsetPosY = 0;
	handleRot = 0;
	handleRotPrev = 0;
	engineSound = nil;

	---初期化関数
	---@param self Car
	init = function (self)
		events.TICK:register(function ()
			if not client:isPaused() then
				local vehicle = player:getVehicle()
				self.isRidingCar = false
				if vehicle ~= nil then
					local vehicleType = vehicle:getType()
					local jockey = vehicle:getControllingPassenger()
					if jockey ~= nil then
						self.isRidingCar = ActionWheelConfig.shouldReplaceVehicleModel and (vehicleType == "minecraft:horse" or vehicleType == "minecraft:donkey" or vehicleType == "minecraft:mule") and vehicle:getControllingPassenger():getName() == player:getName()
					else
						self.isRidingCar = false
					end
					if self.isRidingCar then
						if vehicleType == "minecraft:horse" then
							self.modelOffsetPosY = 0
						elseif vehicleType == "minecraft:donkey" then
							self.modelOffsetPosY = 0.35
						elseif vehicleType == "minecraft:mule" then
							self.modelOffsetPosY = 0.27
						end
					end
				end
				if self.isRidingCar ~= self.isRidingCarPrev then
					if self.isRidingCar then
						BlueArchiveCharacter.physics.physicData[2].x.vertical.bodyX.multiplayer = 0
						BlueArchiveCharacter.physics.physicData[2].x.vertical.bodyY.multiplayer = 0
						BlueArchiveCharacter.physics.physicData[2].x.vertical.bodyRot.multiplayer = 0
						BlueArchiveCharacter.physics.physicData[2].y.vertical.bodyZ.multiplayer = 0
						models.models.ex_skill_1.Car:setVisible(true)
						renderer:setRenderVehicle(false)
						for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
							animations[animationModel]["car_idle"]:play()
							animations[animationModel]["car_engine"]:play()
						end
						animations["models.ex_skill_1"]["car_move"]:play()
						ModelAlias.alias.avatar.head:setRot(-12.5, 0, 0)
						if Gun.currentGunPosition == "RIGHT" then
							Arms:setArmState("CAR_GUN_MAIN_HAND", "CAR")
						elseif Gun.currentGunPosition == "LEFT" then
							Arms:setArmState("CAR", "CAR_GUN_MAIN_HAND")
						else
							Arms:setArmState("CAR", "CAR")
						end
						self.engineSound = sounds:playSound("minecraft:entity.bee.loop", player:getPos(), 0.5, 0.3, true)
						events.TICK:register(function ()
							if self.isRidingCar then
								for _, modelPart in ipairs({ModelAlias.alias.avatar.root, models.models.ex_skill_1.Car}) do
									modelPart:setPos(0, self.modelOffsetPosY * 16, 0)
								end
							end
							local velocity = player:getVelocity()
                        	local horizontalSpeed = math.sqrt(velocity.x ^ 2 + velocity.z ^ 2)
							for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
								animations[animationModel]["car_engine"]:setBlend(math.max(1 - horizontalSpeed * 1.5, 0))
							end
							animations["models.ex_skill_1"]["car_move"]:setSpeed(Physics.velocityAverage[5][2] * 10)
							self.handleRotPrev = self.handleRot
							self.handleRot = math.clamp(Physics.velocityAverage[3][2] + Physics.velocityAverage[4][2] / 500, -0.6, 0.6) * -75 or 0
							if self.engineSound ~= nil then
								self.engineSound:setPos(player:getPos())
								self.engineSound:setPitch(math.min(0.3 + horizontalSpeed * 0.25, 0.75))
								self.engineSound:setVolume(math.min(0.5 + horizontalSpeed * 0.5, 1))
								for i = 1, 4 do
									particles:newParticle("minecraft:poof", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Car.CarBody["ExhaustAnchor"..i])):setScale(math.min(0.5 + horizontalSpeed * 2, 5)):setLifetime(10)
								end
								local shouldLitLight = world.getLightLevel(player:getPos()) <= 7
								for _, modelPart in ipairs({models.models.ex_skill_1.Car.CarBody.RightCarLight.RightCarLightBase2.RightCarLight, models.models.ex_skill_1.Car.CarBody.LeftCarLight.LeftCarLightBase2.LeftCarLight, models.models.ex_skill_1.Car.CarBody.CarRearLight}) do
									modelPart:setPrimaryRenderType(shouldLitLight and "EMISSIVE_SOLID" or "CUTOUT")
								end
							end
						end, "car_ride_tick")
						events.RENDER:register(function (delta)
							local bodyYaw = player:getBodyYaw(delta)
							if renderer:isFirstPerson() then
								local animOffset = vectors.rotateAroundAxis(bodyYaw * -1, models.models.ex_skill_1.CarCameraAnchor:getAnimPos(), 0, 1, 0):scale(0.0625)
								CameraManager.setCameraPivot(vectors.rotateAroundAxis(bodyYaw * -1, -0.47, -0.1 + self.modelOffsetPosY, -0.6, 0, 1, 0):add(animOffset))
								renderer:setEyeOffset(vectors.rotateAroundAxis(bodyYaw * -1, -0.47, -0.1 + self.modelOffsetPosY, -0.6, 0, 1, 0):add(animOffset))
							else
								CameraManager.setCameraPivot(vectors.vec3(0, -1 + self.modelOffsetPosY, 0))
								renderer:setEyeOffset(0, -1 + self.modelOffsetPosY, 0)
							end
							local currentHandleRot = (self.handleRot - self.handleRotPrev) * delta + self.handleRot
							models.models.ex_skill_1.Car.CarBody.HandleBase.Handle:setRot(0, 0, currentHandleRot)
						end, "car_ride_render")
						events.ON_PLAY_SOUND:register(function (id, pos, _, _, _, _, path)
							if path ~= nil and (id:match("^minecraft:entity%.horse%.") or id:match("^minecraft:entity%.donkey%.") or id:match("^minecraft:entity%.mule%.")) and pos:copy():sub(player:getPos()):length() <= 1.5 then
								if id == "minecraft:entity.horse.jump" then
									sounds:playSound("minecraft:entity.bee.hurt", pos, 1, 0.3, false)
									sounds:playSound("minecraft:block.wool.step", pos, 1, 0.75, false)
								elseif id == "minecraft:entity.horse.land" then
									sounds:playSound("minecraft:block.wool.step", pos, 1, 0.75, false)
								elseif id:match("^minecraft:entity%.%w+%.hurt$") then
									sounds:playSound("minecraft:block.anvil.place", pos, 0.5, 2, false)
								elseif id:match("^minecraft:entity%.%w+%.death$") then
									for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
										animations[animationModel]["car_engine"]:stop()
									end
									models.models.ex_skill_1.Car:setColor(0.2, 0.2, 0.2)
									local playerPos = player:getPos()
									local bodyYaw = player:getBodyYaw()
									particles:newParticle("minecraft:explosion_emitter", playerPos)
									for _ = 0, 30 do
										local offsetPos = vectors.rotateAroundAxis(bodyYaw * -1 , math.random() * 3 - 1.5, math.random() * 2 - 0.5, math.random() * 5 - 2.5, 0, 1, 0)
										particles:newParticle("minecraft:poof", playerPos:copy():add(offsetPos)):setColor(vectors.vec3(1, 1, 1):scale(math.random() * 0.1 + 0.2)):setScale(2):setVelocity(offsetPos:copy():scale(0.05))
									end
									sounds:playSound("minecraft:entity.generic.explode", pos, 1, 1, false)
									if self.engineSound ~= nil then
										self.engineSound:stop()
										self.engineSound = nil
									end
									for _, modelPart in ipairs({models.models.ex_skill_1.Car.CarBody.RightCarLight.RightCarLightBase2.RightCarLight, models.models.ex_skill_1.Car.CarBody.LeftCarLight.LeftCarLightBase2.LeftCarLight, models.models.ex_skill_1.Car.CarBody.CarRearLight}) do
										modelPart:setPrimaryRenderType("CUTOUT")
									end
									Bubble:play("SWEAT", 40, false)
								end
								return true
							end
						end, "bicycle_ride_sound")
					else
						events.TICK:remove("car_ride_tick")
						events.RENDER:remove("car_ride_render")
						events.ON_PLAY_SOUND:remove("bicycle_ride_sound")
						BlueArchiveCharacter.physics.physicData[2].x.vertical.bodyX.multiplayer = -80
						BlueArchiveCharacter.physics.physicData[2].x.vertical.bodyY.multiplayer = 80
						BlueArchiveCharacter.physics.physicData[2].x.vertical.bodyRot.multiplayer = 0.05
						BlueArchiveCharacter.physics.physicData[2].y.vertical.bodyZ.multiplayer = -160
						models.models.ex_skill_1.Car:setVisible(false)
						models.models.ex_skill_1.Car:setColor(1, 1, 1)
						renderer:setRenderVehicle(true)
						for _, animationModel in ipairs({"models.main", "models.ex_skill_1"}) do
							animations[animationModel]["car_idle"]:stop()
							animations[animationModel]["car_engine"]:stop()
						end
						animations["models.ex_skill_1"]["car_move"]:stop()
						ModelAlias.alias.avatar.head:setRot()
						for _, modelPart in ipairs({ModelAlias.alias.avatar.root, models.models.ex_skill_1.Car}) do
							modelPart:setPos()
						end
						CameraManager.setCameraPivot()
                        renderer:setEyeOffset()
						if Gun.currentGunPosition == "RIGHT" then
							Arms:setArmState("GUN_MAIN_HAND", "GUN_OFF_HAND")
						elseif Gun.currentGunPosition == "LEFT" then
							Arms:setArmState("GUN_OFF_HAND", "GUN_MAIN_HAND")
						else
							Arms:setArmState("DEFAULT", "DEFAULT")
						end
						if self.engineSound ~= nil then
							self.engineSound:stop()
							self.engineSound = nil
						end
					end
					self.isRidingCarPrev = self.isRidingCar
				end
			end
		end)
	end;
}

return Car
