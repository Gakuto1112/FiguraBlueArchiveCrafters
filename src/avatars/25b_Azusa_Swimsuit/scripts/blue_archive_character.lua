---口のテクスチャの列挙型
---@alias Character00a.MouthTextures
---| "PLUSHIE" # 頭ブロックモデル用の口(他の口に置換可)

---@class (exact) Character00a : BlueArchiveCharacter キャラクターシート

---@type Character00a
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
			PLUSHIE = vectors.vec2(0, 0);
		};
	};

	arms = {

	};

	skirt = {
		skirtModels = {ModelAlias.alias.avatar.body.Skirt};
	};

	gun = {
		scale = 1.4;

		gunPosition = {
			hold = {
				firstPersonPos = {
					right = vectors.vec3(0, 1.5, -7);
					left = vectors.vec3(0, 1.5, -7);
				};

				thirdPersonPos = {
					right = vectors.vec3(-1.75 , -0.5, -7);
					left = vectors.vec3(1.75, -0.5, -7);
				};
			};

			put = {
				type = "HIDDEN";
			};
		};

		sound = {
			name = "minecraft:entity.firework_rocket.blast";
			pitch = 1;
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
		emotion = {
			rightEye = "NORMAL";
			leftEye = "NORMAL";
			mouth = "PLUSHIE";
		};
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
				models = {ModelAlias.alias.avatar.head.HairTails.LeftBackHairTail, ModelAlias.alias.avatar.head.HairTails.RightBackHairTail};

				x = {
					vertical = {
						min = -180;
						neutral = 0;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -80;
							min = -90;
							max = 90;
						};

						headRot = {
							multiplayer = 0.05;
							min = -90;
							max = 90;
						};

						bodyY = {
							multiplayer = 80;
							min = -180;
							max = 0;
						};
					};

					horizontal = {
						min = -180;
						neutral = -45;
						max = 95;

						headX = {
							multiplayer = -80;
							min = -45;
							max = 45;
						};

						bodyY = {
							multiplayer = 80;
							min = -45;
							max = 45;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.LeftBackHairTail.LeftBackHairTailZPivot};

				z = {
					vertical = {
						min = -70;
						neutral = 0;
						max = 90;

						headZ = {
							multiplayer = -80;
							min = -70;
							max = 90;
						};
					};

					horizontal = {
						min = -70;
						neutral = 0;
						max = 90;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightBackHairTail.RightBackHairTailZPivot};

				z = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 70;

						headZ = {
							multiplayer = -80;
							min = -90;
							max = 70;
						};
					};

					horizontal = {
						min = -90;
						neutral = 0;
						max = 70;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightFrontHairTail, ModelAlias.alias.avatar.head.HairTails.LeftFrontHairTail};

				x = {
					vertical = {
						min = -180;
						neutral = 0;
						max = 90;
						headRotMultiplayer = -1;

						headX = {
							multiplayer = -120;
							min = -90;
							max = 90;
						};

						headRot = {
							multiplayer = 0.075;
							min = -90;
							max = 90;
						};

						bodyY = {
							multiplayer = 120;
							min = -180;
							max = 0;
						};
					};


					horizontal = {
						min = -180;
						neutral = -45;
						max = 95;

						headX = {
							multiplayer = -120;
							min = -45;
							max = 45;
						};

						bodyY = {
							multiplayer = 120;
							min = -45;
							max = 45;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.LeftFrontHairTail.LeftFrontHairTailZPivot};

				z = {
					vertical = {
						min = -90;
						neutral = 0;
						max = 7.5;

						headZ = {
							multiplayer = -120;
							min = -90;
							max = 7.5;
						};
					};

					horizontal = {
						min = -90;
						neutral = 0;
						max = 7.5;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairTails.RightFrontHairTail.RightFrontHairTailZPivot};

				z = {
					vertical = {
						min = -7.5;
						neutral = 0;
						max = 90;

						headZ = {
							multiplayer = -120;
							min = -7.5;
							max = 90;
						};
					};

					horizontal = {
						min = -7.5;
						neutral = 0;
						max = 90;
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.Cowlick};

				x = {
					vertical = {
						min = -20;
						neutral = -10;
						max = 0;

						bodyY = {
							multiplayer = -40;
							min = -20;
							max = 0;
						};
					};

					horizontal = {
						min = -20;
						neutral = -10;
						max = 0;

						bodyX = {
							multiplayer = -80;
							min = -10;
							max = 0;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessories.HairRibbon.HairRibbonBottomRight};

				x = {
					vertical = {
						min = -17.5;
						neutral = 0;
						max = 30;

						headX = {
							multiplayer = -160;
							min = -17.5;
							max = 30;
						};
					};

					horizontal = {
						min = -17.5;
						neutral = 0;
						max = 30;

						headX = {
							multiplayer = -80;
							min = -17.5;
							max = 30;
						};

						bodyY = {
							multiplayer = 80;
							min = -17.5;
							max = 30;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessories.HairRibbon.HairRibbonBottomLeft};

				x = {
					vertical = {
						min = -30;
						neutral = 0;
						max = 17.5;

						headX = {
							multiplayer = -160;
							min = -30;
							max = 17.5;
						};
					};

					horizontal = {
						min = -30;
						neutral = 0;
						max = 17.5;

						headX = {
							multiplayer = -80;
							min = -30;
							max = 17.5;
						};

						bodyY = {
							multiplayer = 80;
							min = -30;
							max = 17.5;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessories.HairRibbon.HairRibbonBottomRight.HairRibbonBottomRightZPivot, ModelAlias.alias.avatar.head.HairAccessories.HairRibbon.HairRibbonBottomLeft.HairRibbonBottomLeftZPivot};

				z = {
					vertical = {
						min = 0;
						neutral = 0;
						max = 150;

						headZ = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};

						headRot = {
							multiplayer = 0.1;
							min = 0;
							max = 150;
						};

						bodyY = {
							multiplayer = -80;
							min = 0;
							max = 150;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessories.Flower.FlowerRibbon3};

				x = {
					vertical = {
						min = -45;
						neutral = 0;
						max = 100;

						headX = {
							multiplayer = -160;
							min = -45;
							max = 100;
						};
					};

					horizontal = {
						min = -45;
						neutral = 0;
						max = 100;

						headX = {
							multiplayer = -80;
							min = -45;
							max = 100;
						};

						bodyY = {
							multiplayer = 80;
							min = -65;
							max = 55;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessories.Flower.FlowerRibbon4};

				x = {
					vertical = {
						min = -22.5;
						neutral = 0;
						max = 100;

						headX = {
							multiplayer = -160;
							min = -22.5;
							max = 100;
						};
					};

					horizontal = {
						min = -22.5;
						neutral = 0;
						max = 100;

						headX = {
							multiplayer = -80;
							min = -22.5;
							max = 100;
						};

						bodyY = {
							multiplayer = 80;
							min = -45;
							max = 100;
						};
					};
				};
			};

			{
				models = {ModelAlias.alias.avatar.head.HairAccessories.Flower.FlowerRibbon3.FlowerRibbon3ZPivot, ModelAlias.alias.avatar.head.HairAccessories.Flower.FlowerRibbon4.FlowerRibbon4ZPivot};

				z = {
					vertical = {
						min = -167.5;
						neutral = 0;
						max = 0;

						headZ = {
							multiplayer = -80;
							min = -167.5;
							max = 0;
						};

						headRot = {
							multiplayer = 0.1;
							min = -167.5;
							max = 0;
						};

						bodyY = {
							multiplayer = 80;
							min = -17.5;
							max = 120;
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
