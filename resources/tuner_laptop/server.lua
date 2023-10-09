ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('tuning_laptop', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem('tunnerchip')

   -- if xItem.count > 0 then
        TriggerClientEvent('tuning:useLaptop', source)
  --  end
end)

RegisterServerEvent('tuning:untune')
AddEventHandler('tuning:untune', function(vehp)
    local plate = vehp.plate
    local health = json.encode({
        boost = 1.0;
        fuelmix = 1.0;
        gearchange = 1.0;
        brakeforce = 1.0;
        handbrake = 1.0;
    })

 
    MySQL.Async.execute('UPDATE `owned_vehicles` SET `tune_data` = @health, `isTune` = @state WHERE plate=@plate',{
        ['@plate'] = plate,
        ['@health'] = health,
        ['@state'] = 0
    })    --code
    --code
end)


RegisterServerEvent('tuning:untune')
AddEventHandler('tuning:untune', function(damage, vehp)
    local plate = vehp.plate
    local health = json.encode(damage)

 
    MySQL.Async.execute('UPDATE `owned_vehicles` SET `tune_data` = @health, `isTune` = @state WHERE plate=@plate',{
        ['@plate'] = plate,
        ['@health'] = health,
        ['@state'] = 1
    })    --code
    --code
end)

RegisterServerEvent('tuning:SetData')
AddEventHandler('tuning:SetData', function(damage, vehp)
    local plate = vehp.plate
    local health = json.encode(damage)

 
    MySQL.Async.execute('UPDATE `owned_vehicles` SET `tune_data` = @health, `isTune` = @state WHERE plate=@plate',{
        ['@plate'] = plate,
        ['@health'] = health,
        ['@state'] = 1
    })    --code
    --code
end)

RegisterServerEvent('tuning:removeItem')
AddEventHandler('tuning:removeItem', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('aed', 1)
end)



--[[ ESX.RegisterServerCallback("tuning:CheckStats",function(source,cb,veh)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND plate=@plate', {
        ['@owner'] = GetPlayerIdentifier(source)[1],
        ['@plate'] = veh.plate,
    },function(data)
        cb((data[1].isTune == 1), json.decode(data[1].tune_data))
    end)  
end) ]]


ESX.RegisterServerCallback("tuning:CheckStats",function(source,cb,veh)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate=@plate',{['@plate'] = veh.plate},function(retData)
      if retData and retData[1] and cS then
        cb(true,json.decode(retData[1].tune_data))
      else
        cb(false,false)
      end
    end)  
  end)