---@class (exact) Character25a : BlueArchiveCharacter キャラクターシート
---@type Character25a
local BlueArchiveCharacter = {
	basic = {
		avatarName = "00a_Base";

		birth = {
			month = 1;
			day = 1;
		};
	};

	faceParts = {
		rightEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(2, 0); --必須
			TIRED = vectors.vec2(3, 0); --必須
			CLOSED = vectors.vec2(4, 0); --必須
		};

		leftEye = {
			NORMAL = vectors.vec2(0, 0); --必須
			SURPRISED = vectors.vec2(1, 0); --必須
			TIRED = vectors.vec2(2, 0); --必須
			CLOSED = vectors.vec2(3, 0); --必須
		};

		mouth = {

		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {};
	};

	gun = {
		scale = 1.2;

		gunPosition = {
			hold = {

			};

			put = {
				type = "BODY";

				pos = {
					right = vectors.vec3(4.5, -3, 4);
					left = vectors.vec3(-4.5, -3, 4);
				};

				rot = {
					right = vectors.vec3(-90, 0, 0);
					left = vectors.vec3(-90, 0, 0);
				};
			};
		};

		sound = {
			name = "minecraft:entity.iron_golem.hurt";
			pitch = 2;
		};
	};

	placementObjects = {
		{
			model = models.models.placement_object.PlacementObject;

			boundingBox = {
				size = vectors.vec3(8, 8, 8)
			};

			placementMode = "COPY";
		};
	};

	exSkill = {
		primary = {
			formationType = "STRIKER";

			models = {};

			animations = {"main"};

			camera = {
				start = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(0, 28, -64);
				};

				fin = {
					rot = vectors.vec3(0, 180, 0);
					pos = vectors.vec3(0, 28, -64);
				};
			};
		};
	};

	costume = {
		isAltCostumeEnabled = false;
	};

	bubble = {

	};

	headModel = {

	};

	headBlock = {
		includeModels = {};
	};

	portrait = {
		includeModels = {};
	};

	deathAnimation = {

	};

	actionWheelConfig = {
		isVehicleReplacementEnabled = false;
	};

	physics = {
		physicData = {

		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
	end;
}

return BlueArchiveCharacter
