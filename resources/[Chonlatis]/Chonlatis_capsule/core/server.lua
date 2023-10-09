ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Chonlatis_capsule:getServer')
AddEventHandler('Chonlatis_capsule:getServer', function()
    local _source = source

    TriggerClientEvent('Chonlatis_capsule:getConfig', _source)
end)

RegisterServerEvent('Chonlatis_capsule:getItems')
AddEventHandler('Chonlatis_capsule:getItems', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local randomTable = math.random(1, #data)

    for k,v in pairs(data) do
        if data[randomTable].rate >= math.random(1, 100) then
            local item_give = data[randomTable].name
            local item_amount = data[randomTable].amount
            
            print(item_give, item_amount, data[randomTable].rate)
            xPlayer.addInventoryItem(item_give, item_amount)
        end
    end
    
end)