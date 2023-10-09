ESX = nil
isPickuped = false
cooldown = false

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent(Config['router_base'].getSharedObject, function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end) 

Citizen.CreateThread(function()
    Citizen.Wait(0)
    TriggerServerEvent('Chonlatis_capsule:getServer')
end)

RegisterNetEvent('Chonlatis_capsule:getConfig')
AddEventHandler('Chonlatis_capsule:getConfig', function()
    for k, v in pairs(Config['capsuleSetting']) do
        local dataitem = v.item_get

        Citizen.CreateThread(function()
            while true do
                sleep = 500
                local coords = GetEntityCoords(PlayerPedId())

                if GetDistanceBetweenCoords(v.coords.x, v.coords.y, v.coords.z, true, true, true) < v.distance then
                    if cooldown then

                    else

                    end
                end

                Wait(sleep)
            end
        end)

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(250)
                if cooldown == true then
                    Citizen.Wait(v.cooldown)
                    cooldown = false
                end
            end
        end)

    end
end)

local fontCustom = nil
Citizen.CreateThread(function()
  while not fontCustom do
    fontCustom = exports['monster_font']:GetFontId(Config['mainSetting'].fontCustom)
    Citizen.Wait(1000)
  end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.3, 0.3)
    SetTextFont(fontCustom)
    SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextOutline(1)
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end