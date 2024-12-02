---@class Avatar アバターのメインクラス
---@field public avatarEvents AvatarEvents
---@field public modelUtils ModelUtils
---@field public playerUtils PlayerUtils
---@field public compatibilityUtils CompatibilityUtils
---@field public characterData BlueArchiveCharacter
---@field public headRing HeadRing
---@field public headBlock HeadBlock
---@field public locale Locale
---@field public config Config
---@field public cameraManager CameraManager
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
---@field public frameParticleManager ExSkillFrameParticleManager
---@field public placementObjectManager PlacementObjectManager
---@field public costume Costume
---@field public actionWheel ActionWheel
---@field public actionWheelGui ActionWheelGui
---@field public bubble Bubble
---@field public barrier Barrier
---@field public deathAnimation DeathAnimation
---@field public hypixelZombies HypixelZombies
---@field public updateChecker UpdateChecker
---@field public instantiate fun(class: table, super: table, ...: any) クラスをインスタンス化する

Avatar = {
	---コンストラクタ
	---@return Avatar
	new = function ()
		---@type Avatar
		local instance = Avatar.instantiate(Avatar)

		--ENTITY_INIT前に読み込み
		require("scripts.avatar_modules.avatar_module")

		--ユーティリティクラスの読み込み
		require("scripts.avatar_modules.events.abstract_event")
		require("scripts.avatar_modules.events.script_init_event")
		require("scripts.avatar_modules.events.avatar_events")
		instance.avatarEvents = AvatarEvents.new(instance)
		instance.avatarEvents:init()

		require("scripts.avatar_modules.utils.model_utils")
		instance.modelUtils = ModelUtils.new(instance)
		instance.modelUtils:init()

		--アバターモジュールの読み込み
		require("scripts.blue_archive_character")
		instance.characterData = BlueArchiveCharacter.new(instance)
		instance.characterData:init()

		require("scripts.avatar_modules.head_ring")
		instance.headRing = HeadRing.new(instance)
		instance.headRing:init()

		require("scripts.avatar_modules.head_model_generator")
		require("scripts.avatar_modules.head_block")
		instance.headBlock = HeadBlock.new(instance)
		instance.headBlock:init()

		--生徒固有クラスの読み込み

		events.ENTITY_INIT:register(function ()
			--ユーティリティクラスの読み込み
			require("scripts.avatar_modules.utils.player_utils")
			instance.playerUtils = PlayerUtils.new(instance)
			instance.playerUtils:init()

			require("scripts.avatar_modules.utils.compatibility_utils")
			instance.compatibilityUtils = CompatibilityUtils.new(instance)
			instance.compatibilityUtils:init()

			require("scripts.avatar_modules.utils.spawn_object_manager")
			require("scripts.avatar_modules.utils.spawn_object")

			--アバターモジュールの読み込み
			require("scripts.avatar_modules.locale")
			instance.locale = Locale.new(instance)
			instance.locale:init()

			require("scripts.avatar_modules.config")
			instance.config = Config.new(instance)
			instance.config:init()

			require("scripts.avatar_modules.camera_manager")
			instance.cameraManager = CameraManager.new(instance)
			instance.cameraManager:init()

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

			require("scripts.avatar_modules.ex_skill.ex_skill_frame_particle_manager")
			require("scripts.avatar_modules.ex_skill.ex_skill_frame_particle")
			instance.frameParticleManager = ExSkillFrameParticleManager.new(instance)
			instance.frameParticleManager:init()

			require("scripts.avatar_modules.placement_object.placement_object_manager")
			require("scripts.avatar_modules.placement_object.placement_object")
			instance.placementObjectManager = PlacementObjectManager.new(instance)
			instance.placementObjectManager:init()

			require("scripts.avatar_modules.costume")
			instance.costume = Costume.new(instance)
			instance.costume:init()

			require("scripts.avatar_modules.action_wheel.action_wheel")
			instance.actionWheel = ActionWheel.new(instance)
			instance.actionWheel:init()

			require("scripts.avatar_modules.action_wheel.action_wheel_gui")
			instance.actionWheelGui = ActionWheelGui.new(instance)
			instance.actionWheelGui:init()

			require("scripts.avatar_modules.bubble")
			instance.bubble = Bubble.new(instance)
			instance.bubble:init()

			require("scripts.avatar_modules.barrier")
			instance.barrier = Barrier.new(instance)
			instance.barrier:init()

			require("scripts.avatar_modules.death_animation")
			instance.deathAnimation = DeathAnimation.new(instance)
			instance.deathAnimation:init()

			require("scripts.avatar_modules.hypixel_zombies")
			instance.hypixelZombies = HypixelZombies.new(instance)
			instance.hypixelZombies:init()

			require("scripts.avatar_modules.action_wheel.update_checker")
			instance.updateChecker = UpdateChecker.new(instance)
			instance.updateChecker:init()

			--生徒固有クラスの読み込み

			--SCRIPT_INITイベントを実行
			instance.avatarEvents.SCRIPT_INIT:fire()
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