esx = nil

TriggerEvent('esx:getSharedObject', function(obj) esx = obj end)

RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function(skin)
	local xPlayer = esx.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(skin),
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_skin:responseSaveSkin')
AddEventHandler('esx_skin:responseSaveSkin', function(skin)
	local xPlayer = esx.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(skin),
		['@identifier'] = xPlayer.identifier
	})
end)

esx.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)
	local xPlayer = esx.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		local user, skin = users[1]

		local jobSkin = {
			skin_male   = xPlayer.job.skin_male,
			skin_female = xPlayer.job.skin_female
		}

		if user.skin then
			skin = json.decode(user.skin)
		end

		cb(skin, jobSkin)
	end)
end)

-- ESX.RegisterCommand('skin', 'admin', function(xPlayer, args, showError)
-- 	args.playerId.triggerEvent('esx_skin:openSaveableMenu')
-- end, true, {help = _U('revive_help'), validate = true, arguments = {
-- 	{name = 'playerId', help = 'The player id', type = 'player'}
-- }})

esx.RegisterCommand('skin', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_skin:openSaveableMenu')
end, true, {help = "skins", validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})

esx.RegisterCommand('skinsave', 'admin', function(xPlayer, args, showError)
	xPlayer.triggerEvent('esx_skin:requestSaveSkin')
end, false, {help = _U('saveskin')})
