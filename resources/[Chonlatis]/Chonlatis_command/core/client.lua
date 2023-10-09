local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Chonlatis = {
    [1] = function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
            Citizen.Wait(200)
        end
        ESX.PlayerData = ESX.GetPlayerData()
        while ESX.PlayerData.inventory == nil do
            ESX.PlayerData = ESX.GetPlayerData()
            Citizen.Wait(1000)
        end
    end
}

for i=1, #Chonlatis do
    Citizen.CreateThread(Chonlatis[i])
end

commands = {
    ['bring'] = function(targetG)
        local playerPed = PlayerPedId()
        -- local target = GetPlayerPed(GetPlayerFromServerId(target))
        -- local coords = GetEntityCoords(target)
        SetEntityCoords(playerPed, targetG)
    end,
    ['tpm'] = function()
        local WaypointHandle = GetFirstBlipInfoId(8)

        if DoesBlipExist(WaypointHandle) then
              local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    if foundGround then
                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                        break
                    end

                    Citizen.Wait(5)
                end

                ESX.ShowNotification("Teleported.")
            else
                ESX.ShowNotification("Please place your waypoint.")
        end
    end,
    ['goto'] = function(targetC)
        local playerPed = PlayerPedId()
        --[[ local playerPed = PlayerPedId()
        print(GetPlayerPed(-1))
        local target = GetPlayerPed(GetPlayerFromServerId(target))
        local coords = GetEntityCoords(target) ]]
        SetEntityCoords(playerPed, targetC)
    end,
    ['teleport'] = function(pos)
        pos.x = pos.x + 0.0
	    pos.y = pos.y + 0.0
	    pos.z = pos.z + 0.0

	    RequestCollisionAtCoord(pos.x, pos.y, pos.z)

	    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
		    RequestCollisionAtCoord(pos.x, pos.y, pos.z)
		    Citizen.Wait(1)
	    end

	    SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
    end
}

funcNet = {
    ['Chonlatis_command:client:command'] = function(t, target)
        commands[t](target)
    end
}

RegisterCommand("die", function()
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterCommand('testnotify', function()
    exports['Chonlatis_notify']:MsgNotification(1, 'Chonlatis', 5)
    Citizen.Wait(1000)
    exports['Chonlatis_notify']:MsgNotification(2, 'Chonlatissssssssssssss', 5)
end)

local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(0)
    end
end)

RegisterCommand("tpm", function(source)
    TeleportToWaypoint()
end)

TeleportToWaypoint = function()
    ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
            local WaypointHandle = GetFirstBlipInfoId(8)

            if DoesBlipExist(WaypointHandle) then
                local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    if foundGround then
                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                        break
                    end

                    Citizen.Wait(5)
                end

                ESX.ShowNotification("Teleported.")
            else
                ESX.ShowNotification("Please place your waypoint.")
            end
        else
            ESX.ShowNotification("You do not have rights to do this.")
        end
    end)
end


RegisterCommand('testems', function()

    exports.dst_agency_noty:sendAlert('ambulance', 'แจ้งซ่อม 1-1-1', 'มีเคสซ่อมเข้า ด่วนเลย!!!', {
        x = -49.23,
        y = 16.34
})

end)