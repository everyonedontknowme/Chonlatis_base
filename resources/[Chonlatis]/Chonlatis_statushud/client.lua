ESX = nil 


local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false
local alertbelt	   = true

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end) 

local lastValues = {}
local currentValues = {
	["health"] = 100,
	["armor"] = 100,
	["myhunger"] = 100,
	["oxy"] = 100,
	["mystress"] = 100
}

local toghud = true

RegisterCommand("hidehud", function(src, arg)
	toghud = false
	SendNUIMessage({
		displayPlayer = false
	})
end)

RegisterCommand("showhud", function(src, arg)
	toghud = true
	SendNUIMessage({
		displayPlayer = true
	})
end)

Citizen.CreateThread(function()
    while true do

        if toghud == true then
            if (not IsPedInAnyVehicle(PlayerPedId(), false) )then
                DisplayRadar(0)
            else
                DisplayRadar(1)
            end
        else
            DisplayRadar(0)
        end 

		TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
			TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)

				currentValues['myhunger'] = hunger.getPercent()
				local mythirst = thirst.getPercent()

			end)
		end)
		Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
        local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
        local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId())

        SendNUIMessage({
            type = 'player',
            heath = health,
            armor = armor,
            ox = oxy,
			hunger = currentValues['myhunger'],
			id = GetPlayerServerId(PlayerId())
        })
        Citizen.Wait(200)
    end
end)

IsCar = function(veh)
    local vc = GetVehicleClass(veh)
    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end 

Fwv = function (entity)
    local hr = GetEntityHeading(entity) + 90.0
    if hr < 0.0 then
        hr = 360.0 + hr 
    end
    hr = hr * 0.0174533
    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

GetCarTypeToNui = function(veh)
	local vc = GetVehicleClass(veh)
	if vc == 8 then
		return 'moto'
	elseif vc == 14 then
		return 'boat'
	elseif vc == 16 then
		return 'air'
	elseif vc == 15 then
		return 'air'
	else
		return 'car'
	end
end

CreateThread(function()
	while true do 
		Wait(0) 
		if IsNuiFocused() then 
			DisableControlAction(0, 1, true)
			DisableControlAction(0, 2, true)
			DisableControlAction(0, 3, true)
			DisableControlAction(0, 4, true)
			DisableControlAction(0, 5, true)
			DisableControlAction(0, 6, true)

			DisableControlAction(0, 24, true)
			DisableControlAction(0, 64, true)

			if IsPedInAnyVehicle(PlayerPedId(), true) then 
				DisableControlAction(0, 85, true)
			end

			

			DisableControlAction(0, 200, true)

			DisableControlAction(0, 257, true)
			DisableControlAction(0, 346, true)
		else
			Wait(300)
		end
	end

end)

local uiopen = false
local Mph = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 2.236936
local gear = 0

Citizen.CreateThread(function()
    while true do
		local sleep = 500
		if not hide then
			local player = PlayerPedId()
			local x, y, z = table.unpack(GetEntityCoords(player, true))
			if IsPedInAnyVehicle(player, false) then
				sleep = 0
				if IsVehicleEngineOn(GetVehiclePedIsIn(player, false)) then          

					if not uiopen then
						uiopen = true
						SendNUIMessage({
							type = 'carhud',
							displayCarhud = true
						})
					end
					local playerPed = PlayerPedId()
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					local currentFuel = GetVehicleFuelLevel(vehicle)
					local cuhealthvehicle = GetVehicleEngineHealth(vehicle)
				
					healthvehicle = cuhealthvehicle / 10
					Fuel = currentFuel
					Gear = GetVehicleCurrentGear(vehicle)

					RPM = GetVehicleCurrentRpm(vehicle)
					if not GetIsVehicleEngineRunning(vehicle) then RPM = 0 end
					if RPM > 0.2 then
						RPM = RPM * 100
						RPM = RPM + math.random(-2, 2)
						RPM = RPM / 100
					end
					RPM = RPM*7000

					local l1, l2, l3 = GetVehicleLightsState(vehicle)

					
					Mph = math.ceil(GetEntitySpeed(GetVehiclePedIsIn(player, false)) * 3.6 )
					locakstatus = GetVehicleDoorLockStatus(vehicle)
					SendNUIMessage({
						type = 'carhud',
						kmh = Mph,
						gear = Gear,
						rpm = round(RPM / 1000),
						rpmPercent = round(RPM / 75),
						light = getLight(l2, l3),
						fuel = math.ceil(Fuel),
						doorlock = locakstatus,
						carfix = healthvehicle,
						wheel_fl = IsVehicleTyreBurst(vehicle, 0, false),
						wheel_fr = IsVehicleTyreBurst(vehicle, 1, false),
						wheel_bl = IsVehicleTyreBurst(vehicle, 4, false),
						wheel_br = IsVehicleTyreBurst(vehicle, 5, false),
						cartype = GetCarTypeToNui(vehicle),
						plate = GetVehicleNumberPlateText(vehicle),
						engine = true
					})
				
				else
					
					SendNUIMessage({
						type = 'carhud',
						engine = false
					})

				end
			else
				if uiopen then
					SendNUIMessage({
						type = 'menucar',
						displayMenucar = false,
					})
					SendNUIMessage({
						type = 'carhud',
						displayCarhud = false,
					})
					uiopen = false
				end
			end

		end
		Citizen.Wait(sleep)
			
    end
end)

getLight = function(n, n2)
	if n == 0 then
		return n2
	else
		return n
	end
end

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0) 
  
		local ped = GetPlayerPed(-1)
		local car = GetVehiclePedIsIn(ped)

		if car ~= 0 and (wasInCar or IsCar(car)) then
			wasInCar = true
		
			if isUiOpen == false and not IsPlayerDead(PlayerId()) and not beltOn then
				SendNUIMessage({
					type = 'carhud',
					belt = true
				})
				isUiOpen = true
			end

			if beltOn then 
				DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
				DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
			end

			speedBuffer[2] = speedBuffer[1]
			speedBuffer[1] = GetEntitySpeed(car)


		
			if speedBuffer[2] ~= nil 
				and not beltOn
				and GetEntitySpeedVector(car, true).y > 1.0  
				and speedBuffer[1] > 19.25 
				and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then
				
				local co = GetEntityCoords(ped)
				local fw = Fwv(ped)
				SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
				SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
				Citizen.Wait(1)
				SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
			end
			
			velBuffer[2] = velBuffer[1]
			velBuffer[1] = GetEntityVelocity(car)
			
			if false then
				if not beltOn then
					beltOn = true
					SendNUIMessage({
						type = 'carhud',
						belt = false
					})
					isUiOpen = true 
					alertbelt = false
					
				end
				Citizen.Wait(1000)
			else
			
				if IsControlJustReleased(0, 305) and GetLastInputMethod(0) then
					beltOn = not beltOn 
					if beltOn then
						Citizen.Wait(1)
						TriggerServerEvent('InteractSound_SV:PlayOnSource', 'buckle', 0.9)
						Citizen.Wait(2500)
						ESX.ShowNotification('Connected')
						SendNUIMessage({
							type = 'carhud',
							belt = false
						})
						isUiOpen = true 
						alertbelt = false
					else 
						ESX.ShowNotification('Disconnected')
						TriggerServerEvent('InteractSound_SV:PlayOnSource', 'unbuckle', 0.9)
						Citizen.Wait(1000)
						SendNUIMessage({
							type = 'carhud',
							belt = true
						})
						sUiOpen = true
						alertbelt = true
					end
				end
			end
		
		elseif wasInCar then
			wasInCar = false
			beltOn = false
			speedBuffer[1], speedBuffer[2] = 0.0, 0.0
				if isUiOpen == true and not IsPlayerDead(PlayerId()) then
					SendNUIMessage({
						type = 'carhud',
						belt = false
					})
					isUiOpen = false 
				end
		end

  	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		local car = GetVehiclePedIsIn(ped)
		if not beltOn and not IsPlayerDead(PlayerId()) and IsPedInAnyVehicle(ped, false) and IsCar(car) and GetEntitySpeed(car) > 10 and alertbelt then
			TriggerEvent('InteractSound_CL:PlayOnOne', 'seatbelt', 0.8)
			Citizen.Wait(2500)
		end
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	Citizen.Wait(2500)
	print('[^2Chonlatis_statushud^0] Script is Ready to use!')
end)