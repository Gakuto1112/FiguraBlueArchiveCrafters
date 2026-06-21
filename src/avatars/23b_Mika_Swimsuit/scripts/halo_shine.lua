---@class (exact) HaloShine : SpawnObject ヘイローのキラキラエフェクトオブジェクトのクラス
---@field package object ModelPart インスタンスで制御するモデル
---@field package posOffset Vector3 オブジェクトの基準位置からの位置オフセット値
---@field package uvOffset Vector2 白いパーティクルからの相対UVオフセット値
---@field package isShineVisible boolean キラキラエフェクトが見えている状態かどうか
---@field package shineCount integer キラキラエフェクトの次状態までのカウンター
---@field package shineLength integer キラキラエフェクトを表示する時間
---@field package flickerCount integer キラキラエフェクトの揺らめきを示すカウンター
---@field package flickerLength integer キラキラエフェクトの揺らめきの長さ
---@field public new fun(target: ModelPart, uvOffset: Vector2): HaloShine コンストラクタ

local HaloShine = {
	---コンストラクタ
	---@param target ModelPart 制御対象のモデルパーツ
	---@param uvOffset Vector2 白いパーティクルからの相対UVオフセット値
	new = function (target, uvOffset)
        ---@type PlacementObjectCube
        local instance = MiscUtils.instantiate(HaloShine, SpawnObject)

		instance.object = target
		instance.posOffset = instance.object:getPivot():copy():sub(ModelAlias.alias.avatar.halo.HaloCenter.HaloRotatable:getPivot())
		instance.uvOffset = uvOffset:copy()
		instance.isShineVisible = false
		instance.shineCount = math.random(0, 400)
		instance.shineLength = 300
		instance.flickerCount = 0
		instance.flickerLength = 0

		instance.callbacks = {
			---@param self HaloShine
			onInit = function (self)
				self.object:setVisible(false)
				self.object:setPos(self.posOffset:copy():scale(-1))
				self.object:setUVPixels(self.uvOffset:copy():scale(-1))
			end;

			---@param self HaloShine
			onTick = function (self)
				if self.shineCount == 0 then
					if self.isShineVisible then
						self.shineCount = math.random(0, 400) + 1
						self.flickerLength = 0
						self.flickerCount = 0
					else
						local yaw = math.random() * 360
						local heightRandomValue = math.random()
						local cPink = vectors.vec3(1.000, 0.961, 1.000)
						local cBlue = vectors.vec3(0.937, 0.980, 1.000)
						local cMagenta = vectors.vec3(0.969, 0.906, 1.000)
						local shineColor = cBlue:copy():sub(cPink):scale(math.abs(math.cos(yaw + 45))):add(cPink)
						shineColor = cMagenta:copy():sub(shineColor):scale(heightRandomValue):add(shineColor)
						self.object:setPos(vectors.rotateAroundAxis(yaw, 0, heightRandomValue * 3 - 2, 2 + math.random() * 5, 0, 1, 0):sub(self.posOffset))
						self.object:setColor(shineColor)
						self.shineCount = self.shineLength + 1
					end
					self.object:setVisible(not self.isShineVisible)
					self.isShineVisible = not self.isShineVisible
				end
				self.shineCount = self.shineCount - 1

				if self.isShineVisible then
					if self.flickerCount == 0 then
						self.flickerLength = math.random(2, 6)
						self.flickerCount = 1
					end

					self.flickerCount = math.max(self.flickerCount - 1 / self.flickerLength , 0)
				end
			end;

			---@param self HaloShine
			onRender = function (self, delta)
				if self.isShineVisible then
					local trueTick = self.shineCount + delta
					local baseScale = 1
					if trueTick < 100 then
						baseScale = 1 / 100 * trueTick
					elseif trueTick > self.shineLength - 100 then
						baseScale = 1 / 100 * (self.shineLength - trueTick)
					end

					local trueFlickScale = math.max(self.flickerCount - (1 / self.flickerLength) * delta, 0) - 0.5
					trueFlickScale = trueFlickScale < 0 and trueFlickScale * -1 or trueFlickScale

					self.object:setScale(baseScale * (1 - trueFlickScale * 0.2))
					self.object:setColor(vectors.vec3(1, 1, 1):scale(1 - trueFlickScale * (client:hasShaderPack() and 0.2 or 0.05)))
				end
			end;
		}

		return instance
	end;
}

return HaloShine
