ESX = nil
local blur = "MenuMGIn"

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent(Config['router_base']['getSharedObject'], function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end) 

local isOpenMenu = false

Citizen.CreateThread(function()
    Citizen.Wait(0)
    TriggerServerEvent("Chonlatis_shop:getClient")
end)

RegisterNetEvent("Chonlatis_shop:getConfig")
AddEventHandler("Chonlatis_shop:getConfig", function()
    TriggerEvent('Chonlatis_shop:balance')
    for k,v in pairs(Config['settingShops']) do
        if v.blip then
            if v.blip.enable then
                for i=1, #v.pos, 1 do
                    local blip = AddBlipForCoord(v.pos[i].x, v.pos[i].y, v.pos[i].z)
                    SetBlipHighDetail(blip, true)
                    SetBlipSprite (blip, v.blip.sprite)
                    SetBlipScale  (blip, v.blip.scale or 0.6)
                    SetBlipColour (blip, v.blip.color)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.blip.text or "Jobs")
                    EndTextCommandSetBlipName(blip)
                end
            end
        end 
        Citizen.CreateThread(function()
            while true do
                sleepthred = 600
                local coords = GetEntityCoords(PlayerPedId())
                
                for i=1, #v.pos , 1 do
                    if GetDistanceBetweenCoords(coords, v.pos[i].x, v.pos[i].y, v.pos[i].z, true, true, true) < 2 then
                        sleepthred = 7
                        ESX.ShowHelpNotification('Press E to access the store.')
                        if IsControlJustReleased(0, Config['mainSetting'].key_press) then
                            OpenShopMenu()
                            SendNUIMessage({
                                action = "itemList",
                                itemList = v.item_sell,
                                path_img = Config['mainSetting'].path_img
                            })
                        end
                    end
                end
                
                Citizen.Wait(sleepthred)
            end
        end)
    end

    Citizen.CreateThread(function()
        while true do
            sleepthred = 500
            local coords = GetEntityCoords(GetPlayerPed(-1))
            
            for k,v in pairs(Config['settingShops']) do
                for i = 1, #v.pos, 1 do
                    if(v.marker.type ~= -1 and GetDistanceBetweenCoords(coords, v.pos[i].x, v.pos[i].y, v.pos[i].z, true) < 10) then
                        sleepthred = 5
                        DrawMarker(v.marker.type, v.pos[i].x, v.pos[i].y, v.pos[i].z + v.marker.posz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.marker.size, v.marker.size, v.marker.size, v.marker.color.r, v.marker.color.g, v.marker.color.b, v.marker.color.a, false, true, 2, false, false, false, false)
                    end
                end
            end
            Citizen.Wait(sleepthred)
        end
    end)

end)

function OpenShopMenu()
    isOpenMenu = true
    StartScreenEffect(blur, 1, true)
    SendNUIMessage({
        action = 'show',
        header_text = Config['mainSetting'].header
    })
    SetNuiFocus(true, true)
end

function CloseShopMenu()
    isOpenMenu = false
    StopScreenEffect(blur)
    SendNUIMessage({
        action = 'hide'
    })
    SetNuiFocus(false, false)
end

RegisterNetEvent('Chonlatis_shop:balance', function(balance)
    print(balance)
    SendNUIMessage({
        action = 'itemList',
        bank = balance
    })
end)

RegisterNUICallback('CloseUI', function()
    CloseShopMenu()
end)

RegisterNUICallback('Cash', function(data)
    print('Cash', data.name, data.price, data.amount)
    TriggerServerEvent('Chonlatis_shop:payCash', data.name, data.price, data.amount)
end)

RegisterNUICallback('Credit', function(data)
    print('Bank', data.name, data.price, data.amount)
    TriggerServerEvent('Chonlatis_shop:payCredit', data.name, round(data.price), data.amount)
end)

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

AddEventHandler('onResourceStart', function(resourceName)
    local script_name = GetCurrentResourceName()

	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	Citizen.Wait(2500)
	print('[^2'..script_name..'^0] Script is Ready to use!')
end)

RegisterNetEvent('Chonlatis_shop:notification')
AddEventHandler('Chonlatis_shop:notification', function()

end)