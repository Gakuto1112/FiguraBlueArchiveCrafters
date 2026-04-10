-- キャラクター固有のスクリプトがある場合、ここをエントリーポイントとして実行させる。

---Exスキルのスプラッシュで使用するパーティクルの単一を管理するクラス
---@see ExSkillSplashParticle
ExSkillSplashParticle = require("scripts.ex_skill_splash_particle")

---Exスキルでで使用するスプラッシュパーティクルを管理するクラス
---@see ExSkillSplashParticleManager
ExSkillSplashParticleManager = require("scripts.ex_skill_splash_particle_manager")
ExSkillSplashParticleManager = ExSkillSplashParticleManager:new()

events.ENTITY_INIT:register(function ()
	ExSkillSplashParticleManager.init()
end)
