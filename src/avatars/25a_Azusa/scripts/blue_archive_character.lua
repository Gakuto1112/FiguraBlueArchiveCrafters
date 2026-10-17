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
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
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
			{
				models = {ModelAlias.alias.avatar.head.HairAccessory.HairRibbonRight, ModelAlias.alias.avatar.head.HairAccessory.HairRibbonLeft};

				x = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 90;

						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 90;
						};
					};

					horizontal = {
						min = -45;
						neutral = 45;
						max = 45;

						headX = {
							multiplayer = -80;
							min = -45;
							max = 45;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessory.HairRibbonRight.HairRibbonRightZPivot, ModelAlias.alias.avatar.head.HairAccessory.HairRibbonLeft.HairRibbonLeftZPivot};

				z = {
					vertical = {
						min = -165;
						neutral = 0;
						max = 0;

						headZ = {
							multiplayer = -80;
							min = -165;
							max = 90;
						};

						headRot = {
							multiplayer = 0.05;
							min = -165;
							max = 90;
						};

						bodyY = {
							multiplayer = 80;
							min = -165;
							max = 0;
						};
					};

					horizontal = {
						min = -165;
						neutral = 0;
						max = 0;

						headZ = {
							multiplayer = -80;
							min = -45;
							max = 45;
						};

						bodyY = {
							multiplayer = 80;
							min = -165;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Hairs.BackHair},

				x = {
					vertical = {
						min = -150;
						neutral = -15;
						max = -15;

						bodyX = {
							multiplayer = -80;
							min = -90;
							max = -15;
						};

						bodyY = {
							multiplayer = 80;
							min = -150;
							max = -15;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -90;
							max = -15;
						};
					};

					horizontal = {
						min = -90;
						neutral = -15;
						max = -15;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Hairs.FrontHair};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 150;
						sneakOffset = 30;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 90;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 90;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
						max = 150;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1RightRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2RightRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3LeftRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4LeftRibbon};

				z = {
					vertical = {
						min = -65;
						neutral = 0;
						max = 10;

						bodyY = {
							multiplayer = 80;
							min = -65;
							max = 10;
						};
					};

					horizontal = {
						min = -65;
						neutral = 0;
						max = 10;

						bodyY = {
							multiplayer = 80;
							min = -65;
							max = 10;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1LeftRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2LeftRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3RightRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4RightRibbon};

				z = {
					vertical = {
						min = -10;
						neutral = 0;
						max = 65;

						bodyY = {
							multiplayer = -80;
							min = -10;
							max = 65;
						};
					};

					horizontal = {
						min = -10;
						neutral = 0;
						max = 65;

						bodyY = {
							multiplayer = -80;
							min = -10;
							max = 65;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1RightBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1LeftBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2RightBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2LeftBottomRibbon};

				x = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 152.5;

						bodyX = {
							multiplayer = -80;
							min = 0;
							max = 65;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 152.5;
						};

						bodyRot = {
							multiplayer = -0.05;
							min = 0;
							max = 65;
						};
					};

					horizontal = {
						min = 0;
						neutral = 90;
						max = 152.5;

						bodyX = {
							multiplayer = -160;
							min = 0;
							max = 65;
						};

						bodyY = {
							multiplayer = 80;
							min = 0;
							max = 152.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1RightBottomRibbon.SkirtFlower1RightBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower1.SkirtFlower1LeftBottomRibbon.SkirtFlower1LeftBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2RightBottomRibbon.SkirtFlower2RightBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower2.SkirtFlower2LeftBottomRibbon.SkirtFlower2LeftBottomRibbonZPivot};

				z = {
					vertical = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyZ = {
							multiplayer = -80;
							min = -50;
							max = 50;
						};
					};

					horizontal = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyZ = {
							multiplayer = -80;
							min = -50;
							max = 50;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3RightBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3LeftBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4RightBottomRibbon, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4LeftBottomRibbon};

				x = {
					vertical = {
						min = -152.5;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = -65;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -152.5;
							max = 0;
						};

						bodyRot = {
							multiplayer = 0.05;
							min = -65;
							max = 0;
						};
					};

					horizontal = {
						min = -152.5;
						neutral = 0;
						max = 0;

						bodyX = {
							multiplayer = 160;
							min = -65;
							max = 0;
						};

						bodyY = {
							multiplayer = -80;
							min = -152.5;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3RightBottomRibbon.SkirtFlower3RightBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower3.SkirtFlower3LeftBottomRibbon.SkirtFlower3LeftBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4RightBottomRibbon.SkirtFlower4RightBottomRibbonZPivot, ModelAlias.alias.avatar.body.Skirt.SkirtFlower4.SkirtFlower4LeftBottomRibbon.SkirtFlower4LeftBottomRibbonZPivot};

				z = {
					vertical = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyZ = {
							multiplayer = 80;
							min = -50;
							max = 50;
						};
					};

					horizontal = {
						min = -50;
						neutral = 0;
						max = 50;

						bodyZ = {
							multiplayer = 80;
							min = -50;
							max = 50;
						};
					};
				};
			};
		};
	};

	---初期化関数
	---この関数は消しても構わない。
	init = function ()
		events.RENDER:register(function ()
			if not client:isPaused() then
				local wingRotOffset = math.map(vanilla_model.RIGHT_LEG:getOriginRot().x, -90, 90, 20, 0)
				ModelAlias.alias.avatar.body.Wings.RightWing:setRot(0, wingRotOffset * -1, 0)
				ModelAlias.alias.avatar.body.Wings.LeftWing:setRot(0, wingRotOffset, 0)
			end
		end)
	end;
}

return BlueArchiveCharacter
