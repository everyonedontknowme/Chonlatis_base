ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("Chonlatis_shop:getClient")
AddEventHandler("Chonlatis_shop:getClient", function()
    local _source = source

    TriggerClientEvent("Chonlatis_shop:getConfig", _source)
end)

RegisterServerEvent('Chonlatis_shop:payCash')
AddEventHandler('Chonlatis_shop:payCash', function(name, price, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem = xPlayer.getInventoryItem(name)

    
    if Config['mainSetting'].esx_version == 'limit' then
        if xItem.limit ~= -1 and xItem.count +1 > xItem.limit then
            print(name, "full")
        else
            if xPlayer.getMoney() >= price then
                xPlayer.addInventoryItem(name, amount)
                xPlayer.removeMoney(price)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You purchased ' .. amount .. " " ..name.. " amount " ..price })
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Your money is not enough'})
            end
        end
    elseif Config['mainSetting'].esx_version == 'weight' then
        if not xPlayer.canCarryItem(xItem.name, amount) then
            print(name, "full")
        else
            xPlayer.addInventoryItem(name, amount)
        end
    end
end)

RegisterServerEvent('Chonlatis_shop:payCredit')
AddEventHandler('Chonlatis_shop:payCredit', function(name, price, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem = xPlayer.getInventoryItem(name)

    if xItem.limit ~= -1 and xItem.count +1 > xItem.limit then
        print(name, "full")
    else
        if xPlayer.getAccount('bank').money >= price then
            xPlayer.addInventoryItem(name, amount)  
            xPlayer.removeAccountMoney('bank', price)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You purchased ' .. amount .. " " ..name.. " amount " ..price })
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Your money is not enough'})
        end
    end
    
end)

AddEventHandler('Chonlatis_shop:server:bank', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('Chonlatis_shop:balance', _source, balance)
end)