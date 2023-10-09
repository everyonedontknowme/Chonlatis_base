Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 20, x = 1.0, y = 1.0, z = 1.0, r = 50, g = 50, b = 204, a = 100, rotate = false }

Config.ReviveReward               = 20  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders
Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second

Config.AutoRespawn				  = true
Config.AutoRespawnTimer           = 3 * minute
Config.EarlyRespawnTimer          = 40 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 20 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true
Config.EnableJobBlip              = false
Config.MaxInService               = -1

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 10000
Config.BedList = {
	{
		name = 'v_med_bed1'
	},
	{
		name = 'v_med_bed2'
	},
	{
		name = 'v_med_emptybed'
	},

}

Config.RespawnPoint = { coords = vector3(363.07, -586.23, 28.68), heading = 245.49 }

Config.Hospitals = {
	CentralLosSantosMechanic = {

		Blip = {
			coords = vector3(354.77, -1415.68, 32.51),
			sprite = 61,
			scale  = 1.0,
			color  = 3
		},

		AmbulanceActions = {
			
		},

		Pharmacies = {
			
		},

		Vehicles = {
			{
				Spawner = vector3(-225.21, -1320.70, 30.89),
				InsideShop = vector3(228.5, -993.5, -99.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-223.05, -1325.51, 29.88), heading = 177.49, radius = 6.0 },
				}
			}
		},

		Helicopters = { 
			
		},

		FastTravels = {
			-- {
			-- 	From = vector3(294.7, -1448.1, 29.0),
			-- 	To = {coords = vector3(272.8, -1358.8, 23.5), heading = 0.0},
			-- 	Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			-- },

			-- {
			-- 	From = vector3(275.3, -1361, 23.5),
			-- 	To = {coords = vector3(295.8, -1446.5, 28.9), heading = 0.0},
			-- 	Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			-- },

			-- {
			-- 	From = vector3(247.3, -1371.5, 23.5),
			-- 	To = {coords = vector3(333.1, -1434.9, 45.5), heading = 138.6},
			-- 	Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			-- },

			-- {
			-- 	From = vector3(335.5, -1432.0, 45.50),
			-- 	To = {coords = vector3(249.1, -1369.6, 23.5), heading = 0.0},
			-- 	Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			-- },

			-- {
			-- 	From = vector3(234.5, -1373.7, 20.9),
			-- 	To = {coords = vector3(320.9, -1478.6, 28.8), heading = 0.0},
			-- 	Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			-- },

			-- {
			-- 	From = vector3(317.9, -1476.1, 28.9),
			-- 	To = {coords = vector3(238.6, -1368.4, 23.5), heading = 0.0},
			-- 	Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			-- }
		},

		FastTravelsPrompt = {
			-- {
			-- 	From = vector3(327.48, -603.15, 42.3),
			-- 	To = {coords = vector3(339.56, -584.18, 73.18), heading = 184.54},
			-- 	Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
			-- 	Prompt = _U('fast_travel')
			-- },

			-- {
			-- 	From = vector3(339.56, -584.18, 73.18),
			-- 	To = {coords = vector3(327.48, -603.15, 42.3), heading = 340.69},
			-- 	Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
			-- 	Prompt = _U('fast_travel')
			-- }
		}

	}
}

Config.AuthorizedVehicles = {
	car = {
		ambulance = {
			{model = 'pol718', price = 500},
		},

		doctor = {
			{model = 'pol718', price = 500},
		},

		chief_doctor = {
			{model = 'pol718', price = 500},
		},

		doctor2 = {
			{model = 'pol718', price = 500},
		},

		doctor1 = {
			{model = 'pol718', price = 500},
		},
		TDoctor = {
			{model = 'pol718', price = 500},
		},

		boss = {
			{model = 'pol718', price = 500},
		}
	},

	helicopter = {
		ambulance = {},

		doctor = {
			{model = 'polmav', props = {modLivery = 1}, price = 10000},
		},

		chief_doctor = {
			{model = 'polmav', props = {modLivery = 1}, price = 10000},
		},

		doctor2 = {
			{model = 'polmav', props = {modLivery = 1}, price = 10000},
		},

		doctor1 = {
			{model = 'polmav', props = {modLivery = 1}, price = 10000},
		},

		TDoctor = {
			{model = 'polmav', props = {modLivery = 1}, price = 10000},
		},

		boss = {
			{model = 'polmav', props = {modLivery = 1}, price = 10000},
		}
	}
}
    

Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'motobm', label = 'Medic Lv.1', price = 2000},
		{ model = 'MDGS350', label = 'Medic Lv.2', price = 5000}
	},

	doctor = {
		{ model = 'motobm', label = 'Medic Lv.1', price = 2000},
		{ model = 'MDGS350', label = 'Medic Lv.2', price = 5000}
	},
	prodoctor = {
		{ model = 'motobm', label = 'Medic Lv.1', price = 2000},
		{ model = 'MDGS350', label = 'Medic Lv.2', price = 5000}

	},
	chief = {
		{ model = 'motobm', label = 'Medic Lv.1', price = 2000},
		{ model = 'MDGS350', label = 'Medic Lv.2', price = 5000}

	},

	chief_doctor = {
		{ model = 'motobm', label = 'Medic Lv.1', price = 2000},
		{ model = 'MDGS350', label = 'Medic Lv.2', price = 5000}
	},

	boss = {
		{ model = 'motobm', label = 'Medic Lv.1', price = 2000},
		{ model = 'MDGS350', label = 'Medic Lv.2', price = 5000},
		{ model = 'rmodpolice', label = 'Medic Lv.3', price = 15000}
	},

}

Config.AuthorizedHelicopters = {

	ambulance = {
		{ model = 'supervolito', label = 'supervolito', price = 10000 },
		{ model = 'seasparrow', label = 'seasparrow', price = 10000 }
	},

	doctor = {
		{ model = 'supervolito', label = 'supervolito', price = 10000 },
		{ model = 'seasparrow', label = 'seasparrow', price = 10000 }
	},

	chief_doctor = {
		{ model = 'supervolito', label = 'supervolito', price = 10000 },
		{ model = 'seasparrow', label = 'seasparrow', price = 10000 }
	},

	boss = {
		{ model = 'supervolito', label = 'supervolito', price = 10000 },
		{ model = 'seasparrow', label = 'seasparrow', price = 10000 }
	}

}

Config.Uniforms = {
	ambulance = {
		male = {
            tshirt_1=71,     tshirt_2 = 3,
            torso_1=100,     torso_2 = 0,
            arms=88, 
            pants_1 = 49,     pants_2=1,
            chain_1 = 126,     chain_2 = 0
        },
		female = {
			tshirt_1=67,		
			tshirt_2=3,
			torso_1=340,
			torso_2=1,
			pants_1=107,
			pants_2=0,
			arms=7,
			chain_1=0,
		}
	},

	doctor = {
		male = {
            tshirt_1=71,     tshirt_2 = 3,
            torso_1=100,     torso_2 = 0,
            arms=88, 
            pants_1 = 49,     pants_2=1,
            chain_1 = 126,     chain_2 = 0
        },
		female = {
			tshirt_1=67,		
			tshirt_2=3,
			torso_1=340,
			torso_2=1,
			pants_1=107,
			pants_2=0,
			arms=7,
			chain_1=0,
		}
	},

	prodoctor = {
		male = {
            tshirt_1=71,     tshirt_2 = 3,
            torso_1=100,     torso_2 = 0,
            arms=88, 
            pants_1 = 49,     pants_2=1,
            chain_1 = 126,     chain_2 = 0
        },
		female = {
			tshirt_1=67,		
			tshirt_2=3,
			torso_1=340,
			torso_2=1,
			pants_1=107,
			pants_2=0,
			arms=7,
			chain_1=0,
		}
	},

	chief = {
		male = {
			tshirt_1=71,     tshirt_2 = 3,
            torso_1=100,     torso_2 = 0,
            arms=88, 
            pants_1 = 49,     pants_2=1,
            chain_1 = 126,     chain_2 = 0
        },
		female = {
			tshirt_1=67,		
			tshirt_2=3,
			torso_1=340,
			torso_2=1,
			pants_1=107,
			pants_2=0,
			arms=7,
			chain_1=0,
		}
	},

	chief_doctor = {
		male = {
			tshirt_1=71,     tshirt_2 = 3,
            torso_1=100,     torso_2 = 0,
            arms=88, 
            pants_1 = 49,     pants_2=1,
            chain_1 = 126,     chain_2 = 0
        },
		female = {
			tshirt_1=67,		
			tshirt_2=3,
			torso_1=340,
			torso_2=1,
			pants_1=107,
			pants_2=0,
			arms=7,
			chain_1=0,
		}
	},

	boss = {
		male = {
            tshirt_1=71,     tshirt_2 = 3,
            torso_1=100,     torso_2 = 0,
            arms=88, 
            pants_1 = 49,     pants_2=1,
            chain_1 = 126,     chain_2 = 0
        },
		female = {
			tshirt_1=67,		
			tshirt_2=3,
			torso_1=340,
			torso_2=1,
			pants_1=107,
			pants_2=0,
			arms=7,
			chain_1=0,
		}
	},
}