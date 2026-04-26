---@class (exact) FaceParts 目と口のテクスチャを管理するクラス
---@field package emotionCount integer エモートの時間を計るカウンター
---@field public blinkCount integer 瞬きのタイミングを計るカウンター
local FaceParts = {
	emotionCount = 0;
	blinkCount = 200;

    ---初期化関数
    ---@param self FaceParts
    init = function (self)
		events.TICK:register(function ()
			if not client:isPaused() then
				if player:getPose() == "SLEEPING" then
					if BlueArchiveCharacter.faceParts.emotionSet ~= nil and BlueArchiveCharacter.faceParts.emotionSet.onSleep ~= nil then
						self:setEmotion(BlueArchiveCharacter.faceParts.emotionSet.onSleep.rightEye, BlueArchiveCharacter.faceParts.emotionSet.onSleep.leftEye, BlueArchiveCharacter.faceParts.emotionSet.onSleep.mouth, 1, true)
					else
						self:setEmotion("CLOSED", "CLOSED", "NORMAL", 1, true)
					end
				elseif self.emotionCount == 0 then
					self:setEmotion("NORMAL", "NORMAL", "NORMAL", 0)
				end

				if self.blinkCount == 0 then
					self:setEmotion("CLOSED", "CLOSED", "NORMAL", 2)
					self.blinkCount = 200
				else
					self.blinkCount = self.blinkCount - 1
				end

				self.emotionCount = self.emotionCount > 0 and self.emotionCount - 1 or self.emotionCount
			end
		end)

		events.DAMAGE:register(function ()
			if BlueArchiveCharacter.faceParts.emotionSet ~= nil and BlueArchiveCharacter.faceParts.emotionSet.onDamage ~= nil then
				self:setEmotion(BlueArchiveCharacter.faceParts.emotionSet.onDamage.rightEye, BlueArchiveCharacter.faceParts.emotionSet.onDamage.leftEye, BlueArchiveCharacter.faceParts.emotionSet.onDamage.mouth, 8, true)
			else
				self:setEmotion("SURPRISED", "SURPRISED", "NORMAL", 8, true)
			end
		end)
    end;

	---表情を設定する。
	---@param self FaceParts
	---@param rightEye BlueArchiveCharacter.RightEyeTextures 設定する右目の名前
	---@param leftEye BlueArchiveCharacter.LeftEyeTextures 設定する左目の名前
	---@param mouth BlueArchiveCharacter.MouthTextures 設定する口の名前
	---@param duration integer この表情を有効にする時間
	---@param forced? boolean trueにすると以前のエモーションが再生中でも強制的に現在のエモーションを適用させる。
	setEmotion = function (self, rightEye, leftEye, mouth, duration, forced)
		if self.emotionCount == 0 or forced then
			--右目
			ModelAlias.alias.avatar.rightEye:setUVPixels(BlueArchiveCharacter.faceParts.rightEye[rightEye]:copy():scale(6))

			--左目
			ModelAlias.alias.avatar.leftEye:setUVPixels(BlueArchiveCharacter.faceParts.leftEye[leftEye]:copy():scale(6))

			--口
			if mouth ~= "NORMAL" then
				ModelAlias.alias.avatar.mouth:setVisible(true)
				ModelAlias.alias.avatar.mouth:setUVPixels(BlueArchiveCharacter.faceParts.mouth[mouth]:copy():mul(16, 8))
			else
				ModelAlias.alias.avatar.mouth:setVisible(false)
			end

			if BlueArchiveCharacter.faceParts.callbacks ~= nil and BlueArchiveCharacter.faceParts.callbacks.onPlay ~= nil then
				BlueArchiveCharacter.faceParts.callbacks.onPlay(BlueArchiveCharacter, rightEye, leftEye, mouth)
			end

			self.emotionCount = duration
		end
	end;

	---表情をリセットする。
	---@param self FaceParts
	resetEmotion = function (self)
		self.emotionCount = 0
	end;
}

return FaceParts
