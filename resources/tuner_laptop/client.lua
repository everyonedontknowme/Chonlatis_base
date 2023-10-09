local menu = false
ESX = nil

function getVehData(veh)
 
    local lvehstats = {
        boost = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce"),
        fuelmix = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia") - 1.0,
        braking = GetVehicleHandlingFloat(veh ,"CHandlingData", "fBrakeBiasFront"),
        drivetrain = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront"),
		brakeforce = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce"),
		handbrake = GetVehicleHandlingFloat(veh, "CHandlingData", "fHandBrakeForce")
    }
    return lvehstats
end

function setVehData(veh,data)
    if not DoesEntityExist(veh) or not data then 
		return nil 
	end
	
	-- local model = GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1),false))
	local getVehDataM = getVehData(GetVehiclePedIsIn(GetPlayerPed(-1),false))

	
	SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", data.boost * 0.7 )
	SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", (data.fuelmix + 1)  * 1.0 )
	SetVehicleEnginePowerMultiplier(veh, data.gearchange * 0.7)
	SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", data.braking  * 1.0)
	SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", data.drivetrain  * 1.0)
	SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", data.brakeforce  * 1.0)
	SetVehicleHandlingFloat(veh, "CHandlingData", "fHandBrakeForce", data.handbrake  * 1.0)

	
end

IsCar = function(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


function toggleMenu(b,send)
    menu = b
    SetNuiFocus(b,b)
	local ped = GetPlayerPed(-1)
    local vehData = getVehData(GetVehiclePedIsIn(ped,false))
	local veh = GetVehiclePedIsIn(ped,false)
    if send then 
	
		ESX.TriggerServerCallback('tuning:CheckStats', function(doTune,stats)
			if doTune then
				print('doTune')
				SendNUIMessage(({
					type = "togglemenu", 
					state = b, 
					data = stats
				})) 
			else
				print('else doTune')
				SendNUIMessage(({
					type = "togglemenu", 
					state = b, 
					data = vehData
				})) 
			end
		end, ESX.Game.GetVehicleProperties(veh))
		
	end
end

RegisterNUICallback('ButtonClick', function(data, cb)
	local veh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
	if data == "Default" then
		TriggerServerEvent('tuning:untune', ESX.Game.GetVehicleProperties(veh))
		toggleMenu(false,true)

		SetVehicleDoorShut(veh, 4, false)
	elseif data == "shutDown" then
		SetVehicleDoorShut(veh, 4, false)
		toggleMenu(false,true)
	elseif data == "exit" then
		SetVehicleDoorShut(veh, 4, false)
		toggleMenu(false,true)
	end

    cb('ok')
end)

RegisterNUICallback("togglemenu",function(data,cb)
    toggleMenu(data.state,false)
end)

RegisterNUICallback("save",function(data,cb)
	local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped,false)
    if not IsPedInAnyVehicle(ped) or GetPedInVehicleSeat(veh, -1) ~= ped then 
		return 
	end

	SetVehicleDoorShut(veh, 4, false)
    setVehData(veh,data)
	toggleMenu(false,true)
	TriggerServerEvent('tuning:SetData', data, ESX.Game.GetVehicleProperties(veh))
end)


RegisterNetEvent("tuning:useLaptop")
AddEventHandler("tuning:useLaptop", function()
    if not menu then
        
		
        local ped = GetPlayerPed(-1)
		local veh = GetVehiclePedIsIn(ped,false)
		local vehData = getVehData(GetVehiclePedIsIn(GetPlayerPed(-1),false))
		local coords = GetEntityCoords(PlayerPedId())
		local DistanceCheck = GetDistanceBetweenCoords(coords, -186.32, -1275.74, 31.3, true)
	--	if DistanceCheck <= 17 then
			if IsPedInAnyVehicle(ped, false) and IsCar(veh) then
				TriggerServerEvent("tuning:removeItem")
				TriggerEvent('esx_inventoryhud:closeInventory')
				toggleMenu(true,true)
				SetVehicleDoorOpen(veh, 4, false, false)
				local quest = exports["stepinw_quest"]:GetQuest()
				if quest then
					TriggerEvent('stepinw_quest:addsuccessquest', 'tunning', 1)
				end
			else
				TriggerEvent("pNotify:SendNotification",  {
					text = '<strong class="red-text">คุณไม่ได้อยู่บนรถ</strong>',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
--[[ 		else
			TriggerEvent("pNotify:SendNotification",  {
				text = '<strong class="red-text">กรุณาอยู่บริเวณจุดจูน</strong>',
				type = "error",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
		end ]]
		
		while IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped do
            Citizen.Wait(100)
        end
		
        toggleMenu(false,true)
    else
        return
    end
end)

RegisterNetEvent("tuning:closeMenu")
AddEventHandler("tuning:closeMenu",function()
    toggleMenu(false,true)
end)


local lastVeh = false
local lastData = false
local gotOut = false
Citizen.CreateThread(function(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    while true do
        Citizen.Wait(30)
		local ped = GetPlayerPed(-1)
        if IsPedInAnyVehicle(ped) then
            local veh = GetVehiclePedIsIn(ped,false)
            if veh ~= lastVeh or gotOut then
                if gotOut then 
					gotOut = false
				end
                local responded = false
                ESX.TriggerServerCallback('tuning:CheckStats', function(doTune,stats)
                    if doTune then
                        setVehData(veh,stats)
                        lastStats = stats
                    else
                        if lastVeh and veh and lastVeh == veh and lastData then
                            setVehData(veh,lastData)
                        end
                    end
                    lastVeh = veh
                    responded = true
                end, ESX.Game.GetVehicleProperties(veh))
                while not responded do 
				Citizen.Wait(0); 
				end
            end
        else
            if not gotOut then
                gotOut = true
            end
        end
    end
end)
