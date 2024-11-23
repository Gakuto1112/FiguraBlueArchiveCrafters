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
---@field public modelUtils ModelUtils
---@field public playerUtils PlayerUtils
---@field public compatibilityUtils CompatibilityUtils
---@field public characterData BlueArchiveCharacter
---@field public headRing HeadRing
---@field public headBlock HeadBlock
---@field public locale Locale
---@field public config Config
---@field public keyManager KeyManager
---@field public vanillaModel VanillaModel
---@field public arms Arms
---@field public skirt Skirt
---@field public armor Armor
---@field public faceParts FaceParts
---@field public portrait Portrait
---@field public physics Physics
---@field public gun Gun
---@field public nameplate Nameplate
---@field public exSkill ExSkill
---@field public costume Costume
---@field public deathAnimation DeathAnimation
---@field public instantiate fun(class: table, super: table, ...: any) クラスをインスタンス化する

Avatar = {
	---コンストラクタ
	---@return Avatar
	new = function ()
		---@type Avatar
		local instance = Avatar.instantiate(Avatar)

		--ENTITY_INIT前に読み込み
		require("scripts.avatar_module")

		--ユーティリティクラスの読み込み
		require("scripts.avatar_modules.utils.model_utils")
		instance.modelUtils = ModelUtils.new(instance)
		instance.modelUtils:init()

		--アバターモジュールの読み込み
		require("scripts.avatar_modules.blue_archive_character")
		instance.characterData = BlueArchiveCharacter.new(instance)
		instance.characterData:init()

		require("scripts.avatar_modules.head_ring")
		instance.headRing = HeadRing.new(instance)
		instance.headRing:init()

		require("scripts.avatar_modules.head_model_generator")
		require("scripts.avatar_modules.head_block")
		instance.headBlock = HeadBlock.new(instance)
		instance.headBlock:init()

		events.ENTITY_INIT:register(function ()
			--ユーティリティクラスの読み込み
			require("scripts.avatar_modules.utils.player_utils")
			instance.playerUtils = PlayerUtils.new(instance)
			instance.playerUtils:init()

			require("scripts.avatar_modules.utils.compatibility_utils")
			instance.compatibilityUtils = CompatibilityUtils.new(instance)
			instance.compatibilityUtils:init()

			--アバターモジュールの読み込み
			require("scripts.avatar_modules.locale")
			instance.locale = Locale.new(instance)
			instance.locale:init()

			require("scripts.avatar_modules.config")
			instance.config = Config.new(instance)
			instance.config:init()

			require("scripts.avatar_modules.key_manager")
			instance.keyManager = KeyManager.new(instance)
			instance.keyManager:init()

			require("scripts.avatar_modules.vanilla_model")
			instance.vanillaModel = VanillaModel.new(instance)
			instance.vanillaModel:init()

			require("scripts.avatar_modules.arms")
			instance.arms = Arms.new(instance)
			instance.arms:init()

			require("scripts.avatar_modules.skirt")
			instance.skirt = Skirt.new(instance)
			instance.skirt:init()

			require("scripts.avatar_modules.armor")
			instance.armor = Armor.new(instance)
			instance.armor:init()

			require("scripts.avatar_modules.face_parts")
			instance.faceParts = FaceParts.new(instance)
			instance.faceParts:init()

			require("scripts.avatar_modules.portrait")
			instance.portrait = Portrait.new(instance)
			instance.portrait:init()

			require("scripts.avatar_modules.physics")
			instance.physics = Physics.new(instance)
			instance.physics:init()

			require("scripts.avatar_modules.gun")
			instance.gun = Gun.new(instance)
			instance.gun:init()

			require("scripts.avatar_modules.nameplate")
			instance.nameplate = Nameplate.new(instance)
			instance.nameplate:init()

			require("scripts.avatar_modules.ex_skill.ex_skill")
			instance.exSkill = ExSkill.new(instance)
			instance.exSkill:init()

			require("scripts.avatar_modules.costume")
			instance.costume = Costume.new(instance)
			instance.costume:init()

			require("scripts.avatar_modules.death_animation")
			instance.deathAnimation = DeathAnimation.new(instance)
			instance.deathAnimation:init()
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
		return instance
    end;
}

AvatarInstance = Avatar.new()