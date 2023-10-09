ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


---[SHOP]---
ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)   --- 60000   -8  400
	--TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)    
	xPlayer.showNotification(_U('used_bread'))
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)    --- 60000   -8  400
	--TriggerClientEvent('esx_status:add', source, 'thirst', 125000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_water'))
end)

ESX.RegisterUsableItem('pinto_m', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pinto_m', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500000)    --- 60000   -8  400
    TriggerClientEvent('esx_status:add', source, 'thirst', 500000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification(_U('used_pinto_m'))
end)

ESX.RegisterUsableItem('pinto_l', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pinto_l', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 1000000)    --- 60000   -8  400
    TriggerClientEvent('esx_status:add', source, 'thirst', 1000000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification(_U('used_pinto_l'))
end)

ESX.RegisterUsableItem('mre_job', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('mre_job', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 1000000)    --- 60000   -8  400
    TriggerClientEvent('esx_status:add', source, 'thirst', 1000000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification(_U('used_mre_job'))
end)

-- esx.RegisterUsableItem('soda', function(source)
-- 	local mPlayer = esx.GetPlayerFromId(source)

-- 	mPlayer.removeInventoryItem('soda', 1)

-- 	local item = esx.GetItemLabel('soda')

-- 	TriggerClientEvent('esx_status:add', source, 'thirst', 90000)
-- 	TriggerClientEvent('esx_status:remove', source, 'stress', 25000)  --10000  ---60000
-- 	TriggerClientEvent('esx_basicneeds:onDrink', source)--TriggerClientEvent('esx_optionneeds:onDrink', source)
-- 	TriggerClientEvent('esx:showNotification', source, _U('used_item', item))
-- end)







---[CHFE]----
-- esx.RegisterUsableItem('pinto_full', function(source)
-- 	local xPlayer = esx.GetPlayerFromId(source)
-- 	xPlayer.removeInventoryItem('pinto_full', 1)

-- 	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
-- 	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
-- 	TriggerClientEvent('esx_basicneeds:onEat', source)
-- 	xPlayer.addInventoryItem('pinto', 1)
-- end)



ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
	args.playerId.triggerEvent('chat:addMessage', {args = {'^5HEAL', 'You have been healed.'}})
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})

ESX.RegisterCommand('healall', 'admin', function(xPlayer, args, showError)
	TriggerClientEvent('esx_basicneeds:healPlayer', -1)
end, true, {help = 'Heal all player in the server - restores thirst, hunger and health.', validate = false, arguments = {
}})
