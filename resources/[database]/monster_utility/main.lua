playerPed = nil

Citizen.CreateThread(function()

    SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
    SetRandomBoats(false) -- Stop random boats from spawning in the water.
        
    SetCreateRandomCops(false) -- disable random cops walking/driving around
    SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning
    SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning
end)


Citizen.CreateThread(function()
    while true do
        playerPed = PlayerPedId()
        Citizen.Wait(3000)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0) -- prevent crashing

		-- These natives have to be called every frame.
		SetPedDensityMultiplierThisFrame(0.0) -- set npc/ai peds density to 0    0.5
		SetRandomVehicleDensityMultiplierThisFrame(0.0) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
        SetScenarioPedDensityMultiplierThisFrame(0.00, 0.00) -- set random npc/ai peds or scenario peds to 0   0.25
        
		-- SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
        -- SetRandomBoats(false) -- Stop random boats from spawning in the water.
        
		-- SetCreateRandomCops(false) -- disable random cops walking/driving around.
		-- SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
		-- SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
		
		-- local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		-- ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		-- RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);

        -- fix OneSync NPC by Albert0
        
        if IsPedSittingInAnyVehicle(playerPed --[[ GetPlayerPed(-1) ]]) then

            if GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed --[[ GetPlayerPed(-1) ]],false),-1) == playerPed --[[ GetPlayerPed(-1) ]] then
                SetVehicleDensityMultiplierThisFrame(0) --0.1
                SetParkedVehicleDensityMultiplierThisFrame(0.0) --0.0
            else
                SetVehicleDensityMultiplierThisFrame(0.0)
                SetParkedVehicleDensityMultiplierThisFrame(0) --0.1
            end
        else
          SetParkedVehicleDensityMultiplierThisFrame(0.0) --0.0
          SetVehicleDensityMultiplierThisFrame(0.0)
        end
	end
end)

-- reward from vehicle
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DisablePlayerVehicleRewards(PlayerId())
		SetPedDropsWeaponsWhenDead(playerPed --[[ PlayerPedId() ]], false)
	end
end)

-- players can't steel vehicles from npc
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(800)
        -- local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsTryingToEnter(playerPed)

        if vehicle and DoesEntityExist(vehicle) then
            local driverPed = GetPedInVehicleSeat(vehicle, -1)

            if GetVehicleDoorLockStatus(vehicle) == 7 then
                SetVehicleDoorsLocked(vehicle, 2)
            end

            if driverPed and DoesEntityExist(driverPed) then
                SetPedCanBeDraggedOut(driverPed, false)
            end
        end
    end
end)

-- disafkcam by Monster TaerAttO
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000) -- The idle camera activates after 30 second so we don't need to call this per frame

        N_0xf4f2c0d4ee209e20() -- Disable the pedestrian idle camera
        N_0x9e4cfff989258472() -- Disable the vehicle idle camera
    end
end)

-- no npc drop

function SetWeaponDrops()
    local handle, ped = FindFirstPed()
    local finished = false 

    repeat
        if DoesEntityExist(ped) then
            if not IsEntityDead(ped) then
                local pedType = GetPedType(ped)
                if pedType ~= 28 and not IsPedAPlayer(ped) then
                    SetPedDropsWeaponsWhenDead(ped, false)
                    DeleteWeapon(GetCurrentPedWeaponEntityIndex(ped))
                end
            end
        end
        finished, ped = FindNextPed(handle)
    until not finished

    EndFindPed(handle)
end

function DeleteWeapon(object)
    SetEntityAsMissionEntity(object, false, true)
    DeleteObject(object)
end

Citizen.CreateThread(function()
    while true do
        SetWeaponDrops()
        Citizen.Wait(200)
    end
end)

Citizen.CreateThread(function()
	for i=1,15 do
        EnableDispatchService(i --[[ integer ]], false --[[ boolean ]])
        Citizen.Wait(10)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Config.ControlDamage) do
		SetWeaponDamageModifier(k --[[ Hash ]], v --[[ number ]])
	end
end)

-- Citizen.CreateThread(function()

--     while true do

--         Citizen.Wait(1)

--         if GetVehiclePedIsIn(PlayerPedId(), false) then

-- 			local coords = GetEntityCoords(PlayerPedId())

-- 			if not (GetDistanceBetweenCoords(coords, -33.777, -1102.021, 25.422, true) < 35.0) then

-- 				Citizen.InvokeNative(0xEA386986E786A54F,Citizen.PointerValueIntInitialized(car))

-- 			end

-- 		end

--     end

-- end)



Citizen.CreateThread(function()

    -- Other stuff normally here, stripped for the sake of only scenario stuff

    local SCENARIO_TYPES = {

        "WORLD_VEHICLE_MILITARY_PLANES_SMALL", -- Zancudo Small Planes

        "WORLD_VEHICLE_MILITARY_PLANES_BIG", -- Zancudo Big Planes

    }

    local SCENARIO_GROUPS = {

        2017590552, -- LSIA planes

        2141866469, -- Sandy Shores planes

        1409640232, -- Grapeseed planes

        "ng_planes", -- Far up in the skies jets

    }

    local SUPPRESSED_MODELS = {

        `SHAMAL`, -- They spawn on LSIA and try to take off
    
        `LUXOR`, -- They spawn on LSIA and try to take off
    
        `LUXOR2`, -- They spawn on LSIA and try to take off
    
        `JET`, -- They spawn on LSIA and try to take off and land, remove this if you still want em in the skies
    
        `LAZER`, -- They spawn on Zancudo and try to take off
    
        `TITAN`, -- They spawn on Zancudo and try to take off
    
        `BARRACKS`, -- Regularily driving around the Zancudo airport surface
    
        `BARRACKS2`, -- Regularily driving around the Zancudo airport surface
    
        `CRUSADER`, -- Regularily driving around the Zancudo airport surface
    
        `RHINO`, -- Regularily driving around the Zancudo airport surface
    
        `AIRTUG`, -- Regularily spawns on the LSIA airport surface
    
        `RIPLEY`, -- Regularily spawns on the LSIA airport surface
    
        -- bike
    
        `akuma`,
    
        `avarus`,
    
        `bagger`,
    
        `bati`,
    
        `bati2`,
    
        `bf400`,
    
        `carbonrs`,
    
        `chimera`,
    
        `cliffhanger`,
    
        `daemon`,
    
        `daemon2`,
    
        `defiler`,
    
        `deathbike`,
    
        `deathbike2`,
    
        `deathbike3`,
    
        `diablous`,
    
        `diablous2`,
    
        `double`,
    
        `enduro`,
    
        `esskey`,
    
        `faggio`,
    
        `faggio2`,
    
        `faggio3`,
    
        `fcr`,
    
        `fcr2`,
    
        `gargoyle`,
    
        `hakuchou`,
    
        `hakuchou2`,
    
        `hexer`,
    
        `innovation`,
    
        `lectro`,
    
        `manchez`,
    
        `nemesis`,
    
        `nightblade`,
    
        `oppressor`,
    
        `oppressor2`,
    
        `pcj`,
    
        `ratbike`,
    
        `ruffian`,
    
        `sanchez`,
    
        `sanchez2`,
    
        `sanctus`,
    
        `shotaro`,
    
        `sovereign`,
    
        `thrust`,
    
        `vader`,
    
        `vindicator`,
    
        `vortex`,
    
        `wolfsbane`,
    
        `zombiea`,
    
        `zombieb`,
    
        --bike end
    
    }



    while true do

        for _, sctyp in next, SCENARIO_TYPES do

            SetScenarioTypeEnabled(sctyp, false)

        end

        for _, scgrp in next, SCENARIO_GROUPS do

            SetScenarioGroupEnabled(scgrp, false)

        end

        for _, model in next, SUPPRESSED_MODELS do

            SetVehicleModelIsSuppressed(model, true)

        end

        Citizen.Wait(10000)

    end

end)



local scenarios = {

	'WORLD_VEHICLE_ATTRACTOR',

	'WORLD_VEHICLE_AMBULANCE',

	'WORLD_VEHICLE_BICYCLE_BMX',

	'WORLD_VEHICLE_BICYCLE_BMX_BALLAS',

	'WORLD_VEHICLE_BICYCLE_BMX_FAMILY',

	'WORLD_VEHICLE_BICYCLE_BMX_HARMONY',

	'WORLD_VEHICLE_BICYCLE_BMX_VAGOS',

	'WORLD_VEHICLE_BICYCLE_MOUNTAIN',

	'WORLD_VEHICLE_BICYCLE_ROAD',

	'WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',

	'WORLD_VEHICLE_BIKER',

	'WORLD_VEHICLE_BOAT_IDLE',

	'WORLD_VEHICLE_BOAT_IDLE_ALAMO',

	'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',

	'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',

	'WORLD_VEHICLE_BROKEN_DOWN',

	'WORLD_VEHICLE_BUSINESSMEN',

	'WORLD_VEHICLE_HELI_LIFEGUARD',

	'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',

	'WORLD_VEHICLE_CONSTRUCTION_SOLO',

	'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',

	'WORLD_VEHICLE_DRIVE_PASSENGERS',

	'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',

	'WORLD_VEHICLE_DRIVE_SOLO',

   

	

	'WORLD_VEHICLE_EMPTY',

	'WORLD_VEHICLE_MARIACHI',

	'WORLD_VEHICLE_MECHANIC',

	'WORLD_VEHICLE_MILITARY_PLANES_BIG',

	'WORLD_VEHICLE_MILITARY_PLANES_SMALL',

	'WORLD_VEHICLE_PARK_PARALLEL',

	'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',

	'WORLD_VEHICLE_PASSENGER_EXIT',

	'WORLD_VEHICLE_POLICE_BIKE',

	'WORLD_VEHICLE_POLICE_CAR',

	'WORLD_VEHICLE_POLICE',

	'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',

	'WORLD_VEHICLE_QUARRY',

	'WORLD_VEHICLE_SALTON',

	

	

	'WORLD_VEHICLE_STREETRACE',

   

	'WORLD_VEHICLE_TOURIST',

	'WORLD_VEHICLE_TANDL',

	'WORLD_VEHICLE_DISTANT_EMPTY_GROUND'

  }

  

  Citizen.CreateThread(function()

	  while true do

		  Citizen.Wait(10000)

		  for i, v in ipairs(scenarios) do

			SetScenarioTypeEnabled(v, false)

		  end

	  end	

  end)