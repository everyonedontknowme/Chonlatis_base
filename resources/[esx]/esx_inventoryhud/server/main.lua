ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_inventoryhud:Weapons:Recive:SV')
AddEventHandler('esx_inventoryhud:Weapons:Recive:SV', function()
	local r=source;
	local s=ESX.GetPlayerFromId(r)
	if not s then 
		return 
	end;
	TriggerClientEvent('esx_inventoryhud:Weapons:Recive:CL',r,{WEAPONS=s.getLoadout()or{}})
end)

RegisterServerEvent('esx_inventoryhud:deleteOutfit')
AddEventHandler('esx_inventoryhud:deleteOutfit', function(name, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	if type == 'earring' then
		type = 'ears'
	else
		type = type
	end


	

	MySQL.Async.execute('DELETE FROM meeta_accessory_inventory WHERE label = @label AND owner = @owner AND type = @type ', {
		['@owner'] = xPlayer.identifier,
		['@label'] = name,
		['@type'] = 'player_'..type,

	})
	TriggerClientEvent("esx_inventoryhud:getOwnerAccessories", source)
end)

RegisterServerEvent('esx_inventoryhud:getOwnerVehicle')
AddEventHandler('esx_inventoryhud:getOwnerVehicle', function()
	local _source = source
	local KeyItems = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	KeyItems = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
	TriggerClientEvent("esx_inventoryhud:setOwnerVehicle", _source, KeyItems)
end)

-- RegisterServerEvent('esx_inventoryhud:getOwnerHouse')
-- AddEventHandler('esx_inventoryhud:getOwnerHouse', function()
-- 	local _source = source
-- 	local HouseItems = {}
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	--HouseItems = MySQL.Sync.fetchAll('SELECT * FROM owned_properties WHERE owner = @identifier', {
-- 	--	['@identifier'] = xPlayer.identifier
-- 	--})

-- 	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
--         local house = json.decode(result[1].house)
-- 		if house.houseId == 0 then
-- 			HouseItems ={
-- 				id = 0
-- 			}
-- 			TriggerClientEvent("esx_inventoryhud:setOwnerHouse", _source, HouseItems)
-- 		else
-- 			HouseItems ={
-- 				id = house.houseId
-- 			}
-- 			TriggerClientEvent("esx_inventoryhud:setOwnerHouse", _source, HouseItems)
-- 		end
-- 	end)
-- 	--print(HouseItems.id)
-- 	--TriggerClientEvent("esx_inventoryhud:setOwnerHouse", _source, HouseItems)

-- end)

RegisterServerEvent('esx_inventoryhud:getOwnerAccessories')
AddEventHandler('esx_inventoryhud:getOwnerAccessories', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local AccessoriesItems = {}

		-- Accessories Watch
		local Result_watch = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
			['@owner'] = xPlayer.identifier,
			['@type'] = 'player_watch'
		})
	
		if Result_watch[1] then
			for k,v in pairs(Result_watch) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "watch",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["watches_1"],
					itemskin = skin["watches_2"]
				})
			end
		end



		-- Accessories Chain
		local Result_chain = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
			['@owner'] = xPlayer.identifier,
			['@type'] = 'player_chain'
		})
	
		if Result_chain[1] then
			for k,v in pairs(Result_chain) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "chain",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["chain_1"],
					itemskin = skin["chain_2"]
				})
			end
		end









		-- Accessories bags
		local Result_bags = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
			['@owner'] = xPlayer.identifier,
			['@type'] = 'player_bags'
		})
	
		if Result_bags[1] then
			for k,v in pairs(Result_bags) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "bags",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["bags_1"],
					itemskin = skin["bags_2"]
				})
			end
		end





	-- Accessories Helmet
	local Result_Helmet = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_helmet'
	})

	if Result_Helmet[1] then
		for k,v in pairs(Result_Helmet) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "helmet",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["helmet_1"],
				itemskin = skin["helmet_2"]
			})
		end
	end

	-- Accessories Mask
	local Result_Mask = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_mask'
	})

	if Result_Mask[1] then
		for k,v in pairs(Result_Mask) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "mask",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["mask_1"],
				itemskin = skin["mask_2"]
			})
		end
	end

	-- Accessories Glasses
	local Result_Glasses = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_glasses'
	})

	if Result_Glasses[1] then
		for k,v in pairs(Result_Glasses) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "glasses",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["glasses_1"],
				itemskin = skin["glasses_2"]
			})
		end
	end

	-- Accessories Torso
	local Result_Torso = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_torso'
	})

	if Result_Torso[1] then
		for k,v in pairs(Result_Torso) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "torso",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["torso_1"],
				itemskin = skin["torso_2"],
				itemarms = skin["arms"],
				itemarms2 = skin["arms_2"],
				itemtshirt = skin["tshirt_1"],
				itemtshirt2 = skin["tshirt_2"],
				itemchain = skin['chain_1'],
				itemchain2 = skin['chain_2'],
			})
		end
	end

	-- Accessories Pants
	local Result_Pants = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_pants'
	})

	if Result_Pants[1] then
		for k,v in pairs(Result_Pants) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "pants",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["pants_1"],
				itemskin = skin["pants_2"]
			})
		end
	end

	-- Accessories Shoes
	local Result_Shoes = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_shoes'
	})

	if Result_Shoes[1] then
		for k,v in pairs(Result_Shoes) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "shoes",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["shoes_1"],
				itemskin = skin["shoes_2"]
			})
		end
	end
	

	-- Accessories Earring
	local Result_Earring = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_ears'
	})

	if Result_Earring[1] then
		for k,v in pairs(Result_Earring) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "earring",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["ears_1"],
				itemskin = skin["ears_2"]
			})
		end
	end

	TriggerClientEvent("esx_inventoryhud:setOwnerAccessories", _source, AccessoriesItems)

end)

RegisterServerEvent("esx_inventoryhud:tradePlayerItem")
AddEventHandler(
	"esx_inventoryhud:tradePlayerItem",
	function(from, target, type, itemName, itemCount)
		local _source = from

		local sourceXPlayer = ESX.GetPlayerFromId(_source)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if type == "item_standard" then
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
			local targetItem = targetXPlayer.getInventoryItem(itemName)

			if itemCount > 0 and sourceItem.count >= itemCount then
				if  targetXPlayer.canCarryItem(itemName, itemCount) then
					sourceXPlayer.removeInventoryItem(itemName, itemCount)
					targetXPlayer.addInventoryItem(itemName, itemCount)
				else
					TriggerClientEvent("pNotify:SendNotification", target, {
						text = '<strong class="red-text">ล้มเหลว</strong> ไม่สามารถรับได้เนื่องจากน้ำหนักเกินขีดจำกัด',
						type = "information",
						timeout = 3000,
						layout = "centerRight",
						queue = "global"
					})
				end
			end
		elseif type == "item_money" then
			if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
				sourceXPlayer.removeMoney(itemCount)
				targetXPlayer.addMoney(itemCount)
			end
		elseif type == "item_account" then
			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
				sourceXPlayer.removeAccountMoney(itemName, itemCount)
				targetXPlayer.addAccountMoney(itemName, itemCount)
			end
		elseif type == "item_weapon" then
			if not targetXPlayer.hasWeapon(itemName) then
				sourceXPlayer.removeWeapon(itemName)
				targetXPlayer.addWeapon(itemName, itemCount)
			end
		end
	end
)

RegisterServerEvent('esx_inventoryhud:updateOutfit')
AddEventHandler('esx_inventoryhud:updateOutfit', function(target, type, name)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	local identifier = GetPlayerIdentifiers(source)[1]
	local identifier_target = GetPlayerIdentifiers(target)[1]

	MySQL.Async.execute("UPDATE meeta_accessory_inventory SET owner = @newplayer WHERE owner = @identifier AND label = @label AND type = @type ",
	{
		['@identifier']		= identifier,
		['@newplayer']		= identifier_target,
		['@label']	    	= name,
		['@type']           = 'player_'..type,
	})

	TriggerClientEvent("pNotify:SendNotification", source, {
		text = '<strong class="green-text">สำเร็จ</strong> ส่ง <strong class="amber-text">'..name..'</strong> เรียบร้อย',
		type = "information",
		timeout = 3000,
		layout = "centerRight",
		queue = "global"
	})
	TriggerClientEvent("pNotify:SendNotification", target, {
		text = '<strong class="green-text">สำเร็จ</strong> ได้รับ <strong class="amber-text">'..name..'</strong> เรียบร้อย',
		type = "information",
		timeout = 3000,
		layout = "centerRight",
		queue = "global"
	})

	TriggerClientEvent("esx_inventoryhud:getOwnerAccessories", _source)
	TriggerClientEvent("esx_inventoryhud:getOwnerAccessories", target)

end)

RegisterServerEvent('esx_inventoryhud:updateKey')
AddEventHandler('esx_inventoryhud:updateKey', function(target, type, itemName)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	local identifier = GetPlayerIdentifiers(source)[1]
	local identifier_target = GetPlayerIdentifiers(target)[1]
	if type == "item_key" then -- MEETA GiveKey
		-- if Config.UseItemTransferCar then
		-- 	local xItem = sourceXPlayer.getInventoryItem(Config.ItemTransferCar)
		-- 	if xItem.count >= 1 then
		-- 		sourceXPlayer.removeInventoryItem(xItem.name, 1)
		-- 		MySQL.Async.execute("UPDATE owned_vehicles SET owner = @newplayer WHERE owner = @identifier AND plate = @plate",
		-- 		{
		-- 			['@identifier']		= identifier,
		-- 			['@newplayer']		= identifier_target,
		-- 			['@plate']		= itemName
		-- 		})


		-- 		TriggerClientEvent("pNotify:SendNotification", source, {
		-- 			text = '<strong class="green-text">สำเร็จ</strong> ส่ง <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong>',
		-- 			type = "information",
		-- 			timeout = 3000,
		-- 			layout = "centerRight",
		-- 			queue = "global"
		-- 		})
		-- 		TriggerClientEvent("pNotify:SendNotification", target, {
		-- 			text = '<strong class="green-text">สำเร็จ</strong> ได้รับ <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong>',
		-- 			type = "information",
		-- 			timeout = 3000,
		-- 			layout = "centerRight",
		-- 			queue = "global"
		-- 		})

		-- 		TriggerClientEvent("esx_inventoryhud:getOwnerVehicle", _source)
		-- 		TriggerClientEvent("esx_inventoryhud:getOwnerVehicle", target)
		-- 	else
		-- 		TriggerClientEvent("pNotify:SendNotification", source, {
		-- 			text = '<strong class="amber-text">คุณ </strong> ไม่มี <strong class="yellow-text">'..xItem.name..'</strong>',
		-- 			type = "information",
		-- 			timeout = 3000,
		-- 			layout = "centerRight",
		-- 			queue = "global"
		-- 		})
		-- 	end
		-- else
			TriggerClientEvent('rprogress:custom', source,{
				Duration = 2000,
				Label = "Doing Something",
				Animation = {
					animationDictionary = 'mp_common',
					animationName = 'givetake2_a'
				},
			})
			TriggerClientEvent('rprogress:custom', target,{
				Duration = 2000,
				Label = "Doing Something",
				Animation = {
					animationDictionary = 'mp_common',
					animationName = 'givetake2_a'
				},
			})

			MySQL.Async.execute("UPDATE owned_vehicles SET owner = @newplayer WHERE owner = @identifier AND plate = @plate",
			{
				['@identifier']		= identifier,
				['@newplayer']		= identifier_target,
				['@plate']		= itemName
			})


			TriggerClientEvent("pNotify:SendNotification", source, {
				text = '<strong class="green-text">สำเร็จ</strong> ส่ง <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong>',
				type = "information",
				timeout = 3000,
				layout = "centerRight",
				queue = "global"
			})
			TriggerClientEvent("pNotify:SendNotification", target, {
				text = '<strong class="green-text">สำเร็จ</strong> ได้รับ <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong>',
				type = "information",
				timeout = 3000,
				layout = "centerRight",
				queue = "global"
			})

			TriggerClientEvent("esx_inventoryhud:getOwnerVehicle", _source)
			TriggerClientEvent("esx_inventoryhud:getOwnerVehicle", target)
		-- end
		
	elseif type == "item_keyhouse" then -- MEETA GiveKeyHouse

		TriggerClientEvent('rprogress:custom', _source,{
			Duration = 2000,
			Label = "Doing Something",
			Animation = {
				animationDictionary = 'mp_common',
				animationName = 'givetake2_a'
			},
		})
		TriggerClientEvent('rprogress:custom', target,{
			Duration = 2000,
			Label = "Doing Something",
			Animation = {
				animationDictionary = 'mp_common',
				animationName = 'givetake2_a'
			},
		})
		MySQL.Async.execute("UPDATE owned_properties SET owner = @newplayer WHERE owner = @identifier AND id = @id",
		{
			['@identifier']		= identifier,
			['@newplayer']		= identifier_target,
			['@id']		= itemName
		})
		TriggerClientEvent("esx_inventoryhud:getOwnerHouse", _source)
		TriggerClientEvent("esx_inventoryhud:getOwnerHouse", target)

		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="green-text">สำเร็จ</strong> ส่ง <strong class="amber-text">กุญแจบ้าน</strong>',
			type = "information",
			timeout = 3000,
			layout = "centerRight",
			queue = "global"
		})
		TriggerClientEvent("pNotify:SendNotification", target, {
			text = '<strong class="green-text">สำเร็จ</strong> ได้รับ <strong class="amber-text">กุญแจบ้าน</strong>',
			type = "information",
			timeout = 3000,
			layout = "centerRight",
			queue = "global"
		})	
		

		-- MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier_target}, function(result)
		-- 	local houseid = json.decode(result[1].house)
		-- 	if houseid.houseId == 0 then
		-- 		local house
		-- 		MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier}, function(result)
		-- 			house = json.decode(result[1].house)
		-- 			MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = identifier, ['@house'] = '{"owns":false,"furniture":[],"houseId":0}'}) 
		-- 		end)
			
		-- 		MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier}, function(result)
		-- 			MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", 
		-- 			{
		-- 			['@identifier'] = identifier_target, 
		-- 			['@house'] = '{"owns":false,"furniture":[],"houseId":'..house.houseId..'}'
		-- 			}
		-- 		) 
		-- 		end)
		-- 		TriggerClientEvent('loaf_housing:reloadHouses', _source)
		-- 		TriggerClientEvent('loaf_housing:reloadHouses', target)
		-- 		TriggerClientEvent("pNotify:SendNotification", _source, {
		-- 			text = '<strong class="green-text">สำเร็จ</strong> ส่ง <strong class="amber-text">กุญแจบ้าน</strong>',
		-- 			type = "information",
		-- 			timeout = 3000,
		-- 			layout = "centerRight",
		-- 			queue = "global"
		-- 		})
		-- 		TriggerClientEvent("pNotify:SendNotification", target, {
		-- 			text = '<strong class="green-text">สำเร็จ</strong> ได้รับ <strong class="amber-text">กุญแจบ้าน</strong>',
		-- 			type = "information",
		-- 			timeout = 3000,
		-- 			layout = "centerRight",
		-- 			queue = "global"
		-- 		})
			
		-- 		TriggerClientEvent("esx_inventoryhud:getOwnerHouse", _source)
		-- 		TriggerClientEvent("esx_inventoryhud:getOwnerHouse", target)
		-- 	else
		-- 		TriggerClientEvent("pNotify:SendNotification", _source, {
		-- 			text = '<strong class="red-text">ล้มเหลว</strong> ผู้เล่น <strong class="amber-text">มีบ้านแล้ว</strong>',
		-- 			type = "information",
		-- 			timeout = 3000,
		-- 			layout = "centerRight",
		-- 			queue = "global"
		-- 		})
		-- 	end
		-- end)
		

	end
end)

ESX.RegisterServerCallback("esx_inventoryhud:getPlayerInventory", function(source, cb, target)

	local targetXPlayer = ESX.GetPlayerFromId(target)
	local Inventory = targetXPlayer.inventory

	if targetXPlayer ~= nil then
		cb({inventory = Inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout, weight = targetXPlayer.getWeight()})
	else
		cb(nil)
	end

end)

ESX.RegisterServerCallback("esx_inventoryhud:getPlayerInventory1", function(source, cb, target, data)

	local xPlayer = ESX.GetPlayerFromId(target)
	local Inventory = xPlayer.inventory

	if data == nil then
		if xPlayer ~= nil then
			cb({inventory = Inventory, money = xPlayer.getMoney(), accounts = xPlayer.accounts, weapons = xPlayer.loadout})
		else
			cb(nil)
		end
	else

		if data.vehicle == true then

			local Vehicle_Key = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier', {
				['@identifier'] = xPlayer.identifier
			})

			for i=1, #Vehicle_Key, 1 do
				table.insert(Inventory, {
					label = Vehicle_Key[i].plate,
					count = 1,
					weight = 0,
					type = "item_key",
					name = "key",
					usable = false,
					rare = false,
					canRemove = false
				})
			end
			
		end

		if data.house == true then

			local Properties_Key = MySQL.Sync.fetchAll('SELECT * FROM owned_properties WHERE owner = @identifier', {
				['@identifier'] = xPlayer.identifier
			})

			for i=1, #Properties_Key, 1 do
				table.insert(Inventory, {
					label = Properties_Key[i].name,
					count = 1,
					weight = 0,
					type = "item_keyhouse",
					name = "keyhouse",
					usable = false,
					rare = false,
					canRemove = false,
					house_id = Properties_Key[i].id
				})
			end
		end

		-- Accessories Helmet
		local Result_Helmet = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
			['@owner'] = xPlayer.identifier,
			['@type'] = 'player_helmet'
		})

		if Result_Helmet[1] then
			for k,v in pairs(Result_Helmet) do
				local skin = json.decode(v.skin)
				table.insert(Inventory, {
					label = v.label,
					count = 1,
					weight = 0,
					type = "item_accessories",
					name = "helmet",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["helmet_1"],
					itemskin = skin["helmet_2"]
				})
			end
		end

		-- Accessories Mask
		local Result_Mask = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
			['@owner'] = xPlayer.identifier,
			['@type'] = 'player_mask'
		})

		if Result_Mask[1] then
			for k,v in pairs(Result_Mask) do
				local skin = json.decode(v.skin)
				table.insert(Inventory, {
					label = v.label,
					count = 1,
					weight = 0,
					type = "item_accessories",
					name = "mask",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["mask_1"],
					itemskin = skin["mask_2"]
				})
			end
		end

		-- Accessories Glasses
		local Result_Glasses = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
			['@owner'] = xPlayer.identifier,
			['@type'] = 'player_glasses'
		})

		if Result_Glasses[1] then
			for k,v in pairs(Result_Glasses) do
				local skin = json.decode(v.skin)
				table.insert(Inventory, {
					label = v.label,
					count = 1,
					weight = 0,
					type = "item_accessories",
					name = "glasses",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["glasses_1"],
					itemskin = skin["glasses_2"]
				})
			end
		end

		-- Accessories Earring
		local Result_Earring = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
			['@owner'] = xPlayer.identifier,
			['@type'] = 'player_ears'
		})

		if Result_Earring[1] then
			for k,v in pairs(Result_Earring) do
				local skin = json.decode(v.skin)
				table.insert(Inventory, {
					label = v.label,
					count = 1,
					weight = 0,
					type = "item_accessories",
					name = "earring",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["ears_1"],
					itemskin = skin["ears_2"]
				})
			end
		end

		if xPlayer ~= nil then
			cb({inventory = Inventory, money = xPlayer.getMoney(), accounts = xPlayer.accounts, weapons = xPlayer.loadout})
		else
			cb(nil)
		end
	end

end)


-- AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
--     local player = ESX.GetPlayerFromId(source)
--     TriggerClientEvent('disc-inventoryhud:showItemUse', source, {
--         { id = item.name, label = item.label, qty = count, msg = 'Item Removed' }
--     })
-- end)

-- AddEventHandler('esx:onAddInventoryItem', function(source, esxItem, count)
--     local player = ESX.GetPlayerFromId(source)
--     TriggerClientEvent('disc-inventoryhud:showItemUse', source, {
--         { id = esxItem.name, label = esxItem.label, qty = count, msg = 'Item Added' }
--     })
-- end)


RegisterServerEvent('esx_inventoryhud:getOwnerHouse')
AddEventHandler('esx_inventoryhud:getOwnerHouse', function()
	local _source = source
	local HouseItems = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	HouseItems = MySQL.Sync.fetchAll('SELECT * FROM owned_properties WHERE owner = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

	TriggerClientEvent("esx_inventoryhud:setOwnerHouse", _source, HouseItems)

end)