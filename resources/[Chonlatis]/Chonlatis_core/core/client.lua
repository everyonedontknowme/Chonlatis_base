ESX = nil
local ems, police, taxi, mechanic, chef, players = 0, 0, 0, 0, 0
func_utilsTaerAttO = {
	['UpdatePlayers'] = function(connectedPlayers)
		ems, police, taxi, mechanic, players = 0, 0, 0, 0, 0
		for k,v in pairs(connectedPlayers) do

			players = players + 1
	
			if v.job == 'ambulance' then
				ems = ems + 1
			elseif v.job == 'police' then
				police = police + 1
			elseif v.job == 'taxi' then
				taxi = taxi + 1
			elseif v.job == 'mechanic' then
				mechanic = mechanic + 1
			elseif v.job == 'chef' then
				chef = chef + 1	
			end
		end
	end,
	['GetPolice'] = function()
		return police
	end,
	['GetAmbulance'] = function()
		return ems
	end,
	['GetMechanic'] = function()
		return mechanic
	end,
	['GetTaxi'] = function()
		return taxi
	end,
	['GetChef'] = function()
		return chef
	end,
	['GetPlayers'] = function()
		return players
	end,
}
func_taeratto = {
	['Chonlatis_core:client:updateConnectedPlayers'] = function(connectedPlayers)
		func_utilsTaerAttO.UpdatePlayers(connectedPlayers)
	end,
	['Chonlatis_core:client:fakeCounterJob'] = function(jobname, count)
		if jobname == 'ambulance' then
			ems = count
			print('fake ems: ' .. ems)
		elseif jobname == 'police' then
			police = count
			print('fake police: ' .. police)
		end
	end
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(300)
	end

	Citizen.Wait(2000)
	ESX.TriggerServerCallback('Chonlatis_core:callback:getConnectedPlayers', function(connectedPlayers)
		func_utilsTaerAttO.UpdatePlayers(connectedPlayers)
	end)
end)

for k,v in pairs(func_taeratto) do
	RegisterNetEvent(k)
	AddEventHandler(k, v)
end

-- exports
for k,v in pairs(func_utilsTaerAttO) do
	if k ~= 'UpdatePlayers' then
		exports(k, v)
	end
end