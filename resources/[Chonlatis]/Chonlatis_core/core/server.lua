ESX = nil
local connectedPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Chonlatis_core:callback:getConnectedPlayers', function(source, cb)
	cb(connectedPlayers)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	connectedPlayers[playerId].job = job.name

	TriggerClientEvent('Chonlatis_core:client:updateConnectedPlayers', -1, connectedPlayers)
end)

AddEventHandler('esx:playerLoaded', function(source)
	local mPlayer = ESX.GetPlayerFromId(source)
		AddPlayerToClient(mPlayer, true)
end)

AddEventHandler('esx:playerDropped', function(playerId)
	connectedPlayers[playerId] = nil

	TriggerClientEvent('Chonlatis_core:client:updateConnectedPlayers', -1, connectedPlayers)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			AddPlayersToClient()
		end)
	end
end)

function AddPlayerToClient(mPlayer, update)
	local playerId = mPlayer.source

	connectedPlayers[playerId] = {}
	connectedPlayers[playerId].ping = GetPlayerPing(playerId)
	connectedPlayers[playerId].id = playerId
	connectedPlayers[playerId].name = mPlayer.getName()
	connectedPlayers[playerId].job = mPlayer.job.name

	if update then
		TriggerClientEvent('Chonlatis_core:client:updateConnectedPlayers', -1, connectedPlayers)
	end
end

function AddPlayersToClient()
	local players = ESX.GetPlayers()

	for i=1, #players, 1 do
		local mPlayer = ESX.GetPlayerFromId(players[i])
		AddPlayerToClient(mPlayer, false)
	end

	TriggerClientEvent('Chonlatis_core:client:updateConnectedPlayers', -1, connectedPlayers)
end


ESX.RegisterCommand('fake', 'admin', function(xPlayer, args, showError)
	if args.jobname and args.numberjob then
		xPlayer.triggerEvent('Chonlatis_core:client:fakeCounterJob', args.jobname, tonumber(args.numberjob))
	end
end, false, {help = 'fake counter of job', validate = false, arguments = {
	{name = 'jobname', help = 'name of job', type = 'any'},
	{name = 'numberjob', help = 'number of job', type = 'any'}
}})

-- TriggerEvent('es:addGroupCommand', 'screfresh', 'admin', function(source, args, user)
-- 	AddPlayersToClient()
-- end, function(source, args, user)
-- 	TriggerClientEvent('chat:addMessage', source, { args = { '^1SISTEMA', 'Non hai i permessi per farlo.' } })
-- end, {help = "Ricarica nomi lista giocatori!"})

-- TriggerEvent('es:addGroupCommand', 'sctoggle', 'admin', function(source, args, user)
-- 	TriggerClientEvent('Chonlatis_core:toggleID', source)
-- end, function(source, args, user)
-- 	TriggerClientEvent('chat:addMessage', source, { args = { '^1SISTEMA', 'Non hai i permessi per farlo.' } })
-- end, {help = "Togli colonna degli ID!"})
