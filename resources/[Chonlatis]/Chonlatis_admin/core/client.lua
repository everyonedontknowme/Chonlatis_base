ESX = nil
local noclip = false
local menu = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


RegisterCommand('+noclip', function()
    admin.Noclip()
end)

RegisterKeyMapping("+noclip", "Chonlatis_admin [Noclip]", "keyboard", 'PAGEUP')

RegisterCommand('+openadmin', function()
    if not menu then
        OpenUI()
    else
        CloseUI()
    end
end)

RegisterKeyMapping('+openadmin', 'Chonlatis_admin [Open]', 'keyboard', 'HOME')