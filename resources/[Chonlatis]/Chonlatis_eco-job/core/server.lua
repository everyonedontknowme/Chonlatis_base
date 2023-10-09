ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("Chonlatis_eco-job:loadConfig")
AddEventHandler("Chonlatis_eco-job:loadConfig", function()
    local _source = source

    TriggerClientEvent("Chonlatis_eco-job:getConfig", _source);
    TriggerClientEvent("Chonlatis_eco-job:process", _source);
end)

RegisterServerEvent("Chonlatis_eco-job:getItems")
AddEventHandler("Chonlatis_eco-job:getItems", function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    for k,v in pairs(data) do
        local xItem = xPlayer.getInventoryItem(data.ItemName)
        local xItemCount = math.random(data.ItemCount[1], data.ItemCount[2])

        if Config['Version'] == "1.2" or Config['Version'] == "v1Final" then
            if not xPlayer.canCarryItem(xItem.name, xItemCount) then
                Notify('' .. xItem.label .. ' ของคุณเต็ม</span> ')
            else
                xPlayer.addInventoryItem(xItem.name, xItemCount)
                DiscordSend(xItem.label, xItemCount)

                if data.ItemBonus ~= nil then
                    for k,v in pairs(data.ItemBonus) do
                        if math.random(1, 100) <= v.Percent then
                            local xItem2, xItem2Count = xPlayer.getInventoryItem(v.ItemName), v.ItemCount
    
                            xPlayer.addInventoryItem(xItem2.name, xItem2Count)
                        end
                    end
                end
            end
        else
            if xItem.limit ~= -1 and xItem.count >= xItem.limit then
                Notify('' .. xItem.label .. ' ของคุณเต็ม</span>')
            else
                if xItem.limit ~= -1 and (xItem.count + xItemCount) > xItem.limit then
                    xPlayer.setInventoryItem(xItem.name, xItem.limit)
                else
                    xPlayer.addInventoryItem(xItem.name, xItemCount)
                end
            
                if data.ItemBonus ~= nil then
                    for k,v in pairs(data.ItemBonus) do
                        if math.random(1, 100) <= v.Percent then
                            local xItem2, xItem2Count = xPlayer.getInventoryItem(v.ItemName), v.ItemCount
    
                            if xItem2.limit ~= -1 and (xItem2.count + xItem2Count) > xItem2.limit then
                                xPlayer.setInventoryItem(xItem2.name, xItem2.limit)
                            else
                                xPlayer.addInventoryItem(xItem2.name, xItem2Count)
                            end
                        end
                    end
                end
            end
        end

        break
    end
end)

RegisterServerEvent('Chonlatis_eco-job:server:process')
AddEventHandler('Chonlatis_eco-job:server:process', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for k,v in pairs(data) do
        local xItem = xPlayer.setInventoryItem(data.item_needs)
        if Config['Version'] == "1.2" or Config['Version'] == "v1Final" then
            xPlayer.removeInventoryItem(data.name, data.amount)
            print(data.name[i], data.amount[i])
        else
            print(v[v].name)
        end
    end

end)