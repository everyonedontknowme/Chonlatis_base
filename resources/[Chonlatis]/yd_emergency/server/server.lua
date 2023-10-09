--[[
 *
 * DIPSCode FiveM | Agency Notification
 * dst_agency_noty
 * version 1.0
 *
]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterNetEvent('dst_agency_noty:sendAlert')
AddEventHandler('dst_agency_noty:sendAlert', function(job, title, message, coords, image)
	sendAlert(job, title, message, coords, image)
end)

RegisterNetEvent('dst_agency_noty:sendAcceptCase')
AddEventHandler('dst_agency_noty:sendAcceptCase', function(caseId, jobName)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('dst_agency_noty:showAccepted', -1, caseId, jobName, xPlayer.getName())
end)

function sendAlert(job, title, message, coords, image)
	TriggerClientEvent('dst_agency_noty:client:alert', -1, job, title, message, coords, image)
end

exports('sendAlert', sendAlert)