---@class (exact) FaceParts : AvatarModule 目と口のテクスチャを管理するクラス
---@field package emotionCount integer エモートの時間を計るカウンター
---@field public blinkCount integer 瞬きのタイミングを計るカウンター
---@field public setEmotion fun(self: FaceParts, rightEye: BlueArchiveCharacter.RightEyeTextures, leftEye: BlueArchiveCharacter.LeftEyeTextures, mouth: BlueArchiveCharacter.MouthTextures, duration: integer, forced?: boolean) 表情を設定する
---@field public resetEmotion fun(self: FaceParts) 表情をリセットする

FaceParts = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return FaceParts
    new = function (parent)
        ---@type FaceParts
        local instance = Avatar.instantiate(FaceParts, AvatarModule, parent)

		instance.emotionCount = 0
		instance.blinkCount = 200

        return instance
    end;

    ---初期化関数
    ---@param self FaceParts
    init = function (self)
        AvatarModule.init(self)

		events.TICK:register(function ()
			if not client:isPaused() then
				if self.parent.playerUtils.damageStatus == "DAMAGE" then
					if self.parent.characterData.faceParts.emotionSet ~= nil and self.parent.characterData.faceParts.emotionSet.onDamage ~= nil then
						self:setEmotion(self.parent.characterData.faceParts.emotionSet.onDamage.rightEye, self.parent.characterData.faceParts.emotionSet.onDamage.leftEye, self.parent.characterData.faceParts.emotionSet.onDamage.mouth, 8, true)
					else
						self:setEmotion("SURPRISED", "SURPRISED", "NORMAL", 8, true)
					end
				elseif self.parent.playerUtils.damageStatus == "DIED" then
					if self.parent.characterData.faceParts.emotionSet ~= nil and self.parent.characterData.faceParts.emotionSet.onDied ~= nil then
						self:setEmotion(self.parent.characterData.faceParts.emotionSet.onDied.rightEye, self.parent.characterData.faceParts.emotionSet.onDied.leftEye, self.parent.characterData.faceParts.emotionSet.onDied.mouth, 20, true)
					else
						self:setEmotion("SURPRISED", "SURPRISED", "NORMAL", 20, true)
					end
				elseif player:getPose() == "SLEEPING" then
					if self.parent.characterData.faceParts.emotionSet ~= nil and self.parent.characterData.faceParts.emotionSet.onSleep ~= nil then
						self:setEmotion(self.parent.characterData.faceParts.emotionSet.onSleep.rightEye, self.parent.characterData.faceParts.emotionSet.onSleep.leftEye, self.parent.characterData.faceParts.emotionSet.onSleep.mouth, 1, true)
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
			models.models.main.Avatar.Head.FaceParts.Eyes.EyeLeft:setUVPixels(self.parent.characterData.faceParts.rightEye[rightEye]:copy():scale(6))

			--左目
			models.models.main.Avatar.Head.FaceParts.Eyes.EyeRight:setUVPixels(self.parent.characterData.faceParts.leftEye[leftEye]:copy():scale(6))

			--口
			if mouth ~= "NORMAL" then
				models.models.main.Avatar.Head.FaceParts.Mouth:setVisible(true)
				models.models.main.Avatar.Head.FaceParts.Mouth:setUVPixels(self.parent.characterData.faceParts.mouth[mouth]:copy():mul(16, 8))
			else
				models.models.main.Avatar.Head.FaceParts.Mouth:setVisible(false)
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