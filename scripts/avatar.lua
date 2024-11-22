--[[
events.ENTITY_INIT:register(function ()
	--クラスのインスタンス化
	Language = require("scripts.language")
	Config = require("scripts.config")
	KeyManager = require("scripts.key_manager")
	PlayerUtils = require("scripts.utils.player_utils")
	CompatibilityUtils = require("scripts.utils.compatibility_utils")
	InstanceUtils = require("scripts.utils.instance_utils")

	--パーツ別クラス
	VanillaModel = require("scripts.vanilla_model")
	Arms = require("scripts.arms")
	Skirt = require("scripts.skirt")
	Armor = require("scripts.armor")
	FaceParts = require("scripts.face_parts")
	Physics = require("scripts.physics")
	Gun = require("scripts.gun")
	Nameplate = require("scripts.nameplate")
	Portrait = require("scripts.portrait")

	--機能別クラス
	DeathAnimation = require("scripts.death_animation")
	Costume = require("scripts.costume")
	CameraManager = require("scripts.camera_manager")
	ExSkill = require("scripts.ex_skill.ex_skill")
	ActionWheel = require("scripts.action_wheel.action_wheel")
	ActionWheelGui = require("scripts.action_wheel.action_wheel_gui")
	FrameParticle = require("scripts.ex_skill.frame_particle")
	FrameParticleManager = require("scripts.ex_skill.frame_particle_manager")
	PlacementObjectManager = require("scripts.placement_object.placement_object_manager")
	Bubble = require("scripts.bubble")
	Barrier = require("scripts.barrier")

	--HypixelZombies = require("scripts.hypixel_zombies")

	--生徒固有クラス
end)
--]]

--ENTITY_INITを待たず読み込むクラス

---@class Avatar アバターのメインクラス
---@field public instantiate fun(class: table, super: table, ...: any) クラスをインスタンス化する。

Avatar = {
	---コンストラクタ
	---@param self Avatar
	---@return Avatar
	new = function (self)
		---@type Avatar
		local instance = Avatar.instantiate(Avatar)

		require("scripts.avatar_module")

		--ENTITY_INIT前に読み込み

		--ユーティリティクラスの読み込み
		require("scripts.avatar_modules.utils.model_utils")
		instance.modelUtils = ModelUtils.new(self)

		events.ENTITY_INIT:register(function ()
			--ユーティリティクラスの読み込み
			require("scripts.avatar_modules.utils.player_utils")
			instance.playerUtils = PlayerUtils.new(self)

			require("scripts.avatar_modules.utils.compatibility_utils")
			instance.compatibilityUtils = CompatibilityUtils.new(self)
		end)

		return instance
	end;

    ---クラスをインスタンス化する。
	---@generic S
	---@generic C
	---@param class `C` インスタンス化するクラス
	---@param super? `S` インスタンス化するクラスのスーパークラス
	---@param ... any クラスのインスタンス時に渡される引数
	---@return C instance インスタンス化されたクラスのオブジェクト
    instantiate = function (class, super, ...)
        local instance = super and super.new(...) or {}
        setmetatable(instance, {__index = class})
        setmetatable(class, {__index = super})
		return class
    end;
}

Avatar:new()