ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand('tpm', 'admin', function(xPlayer, args, showError)
	xPlayer.triggerEvent('Chonlatis_command:client:command', 'tpm', source)
end, false, {help = 'tpm yo marker', validate = false, arguments = {
	-- {name = 'playerId', help = 'The player id', type = 'player'}
}})

ESX.RegisterCommand('tp', 'admin', function(xPlayer, args, showError)
    xPlayer.triggerEvent('Chonlatis_command:client:command', 'teleport', {x = args.x, y = args.y, z = args.z})
end, false, {
    help = 'teleport to coords',
    validate = true,
    arguments = {
        {name = 'x', help = 'coords x', type = 'any'},
        {name = 'y', help = 'coords y', type = 'any'},
        {name = 'z', help = 'coords z', type = 'any'},
    }
})

ESX.RegisterCommand('bring', 'admin', function(xPlayer, args, showError)
    local playerPed = GetPlayerPed(xPlayer.source)
    local coords = GetEntityCoords(playerPed)
    args.playerId.triggerEvent('Chonlatis_command:client:command', 'bring', coords)
end, false, {
    help = 'Bring player of id',
    validate = false,
    arguments = {
        {name = 'playerId', help = 'playerId for bring', type = 'player'},
        -- {name = 'amount', help = 'test', type = 'any'}
    }
})

ESX.RegisterCommand('goto', 'admin', function(xPlayer, args, showError)
    local targetPed = GetPlayerPed(args.playerId.source)
    local coords = GetEntityCoords(targetPed)
    xPlayer.triggerEvent('Chonlatis_command:client:command', 'goto', coords)
end, false, {
    help = 'Goto player id',
    validate = false,
    arguments = {
        {name = 'playerId', help = 'playerId for goto', type = 'player'},
        -- {name = 'amount', help = 'test', type = 'any'}
    }
})

ESX.RegisterServerCallback("esx_marker:fetchUserRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)