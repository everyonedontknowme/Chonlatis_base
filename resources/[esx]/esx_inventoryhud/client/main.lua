local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

isInInventory = false
ESX = nil
local Vehicle_Key = {}
local openMenu = false
local delay = false 
local fastWeapons = {
	[1] = nil,
	[2] = nil,
	[3] = nil,
    [4] = nil,
    [5] = nil
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    ESX.PlayerData = ESX.GetPlayerData()
    while ESX.PlayerData.inventory == nil do
        ESX.PlayerData = ESX.GetPlayerData()
        Citizen.Wait(1000)
    end
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerServerEvent("esx_inventoryhud:getOwnerVehicle")
end)


AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
        TriggerServerEvent("esx_inventoryhud:getOwnerVehicle")
    end
end)


AddEventHandler('esx_inventoryhud:closeInventory', function()
	closeInventory()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if delay == true then
			Citizen.Wait(3000)
			delay = false
		end
    end
end)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
			
			if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
                openInventory()
            elseif  IsDisabledControlJustReleased(1,  Keys["1"]) and not delay then
				delay = true
				local ishave = false
				for _, i in pairs(Config.CanUse) do
					if fastWeapons[1] == i then
						ishave = true
					end
				end
				
				if fastWeapons[1] ~= nil then
					if string.match(fastWeapons[1], 'WEAPON_') then
						if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[1]) then
							SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
						else
							SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[1],true)
						end
					elseif ishave then
						TriggerEvent("esx:use"..fastWeapons[1])
					elseif string.match(fastWeapons[1], 'card') or fastWeapons[1] == 'weapon' then
						TriggerEvent("esx_jsidmenu:usecard", fastWeapons[1])
					else
	
						TriggerServerEvent("esx:useItem", fastWeapons[1])
			
					end
                end
            elseif IsDisabledControlJustReleased(1, Keys["2"]) and not delay then
				delay = true
				local ishave = false
				for _, i in pairs(Config.CanUse) do
					if fastWeapons[2] == i then
						ishave = true
					end
				end
				
                if fastWeapons[2] ~= nil then
                    if string.match(fastWeapons[2], 'WEAPON_') then
						if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[2]) then
							SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
						else
							SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[2],true)
						end
					elseif ishave then
						TriggerEvent("esx:use"..fastWeapons[2])
					elseif string.match(fastWeapons[2], 'card') or fastWeapons[2] == 'weapon' then
						TriggerEvent("esx_jsidmenu:usecard", fastWeapons[2])
					else
						TriggerServerEvent("esx:useItem", fastWeapons[2])
					end
                end
            elseif IsDisabledControlJustReleased(1, Keys["3"]) and not delay then
				delay = true
				local ishave = false
				for _, i in pairs(Config.CanUse) do
					if fastWeapons[3] == i then
						ishave = true
					end
				end
				
                if fastWeapons[3] ~= nil then
                    if string.match(fastWeapons[3], 'WEAPON_') then
						if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[3]) then
							SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
						else
							SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[3],true)
						end
					elseif ishave then
						TriggerEvent("esx:use"..fastWeapons[3])
					elseif string.match(fastWeapons[3], 'card') or fastWeapons[3] == 'weapon' then
						TriggerEvent("esx_jsidmenu:usecard", fastWeapons[3])
					else
						TriggerServerEvent("esx:useItem", fastWeapons[3])
					end
                end
            elseif IsDisabledControlJustReleased(1, Keys["4"]) and not delay then
				delay = true
				local ishave = false
				for _, i in pairs(Config.CanUse) do
					if fastWeapons[4] == i then
						ishave = true
					end
				end
				
                if fastWeapons[4] ~= nil then
					if string.match(fastWeapons[4], 'WEAPON_') then
						if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[4]) then
							SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
						else
							SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[4],true)
						end
					elseif ishave then
						TriggerEvent("esx:use"..fastWeapons[4])
					elseif string.match(fastWeapons[4], 'card') or fastWeapons[4] == 'weapon' then
						TriggerEvent("esx_jsidmenu:usecard", fastWeapons[4])
					else
						TriggerServerEvent("esx:useItem", fastWeapons[4])
					end
                end
            elseif IsDisabledControlJustReleased(1, Keys["5"]) and not delay then
				delay = true
				local ishave = false
				for _, i in pairs(Config.CanUse) do
					if fastWeapons[5] == i then
						ishave = true
					end
				end
				
                if fastWeapons[5] ~= nil then
                    if string.match(fastWeapons[5], 'WEAPON_') then
						if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[5]) then
							SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
						else
							SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[5],true)
						end
					elseif ishave then
						TriggerEvent("esx:use"..fastWeapons[5])
					elseif string.match(fastWeapons[5], 'card') or fastWeapons[5] == 'weapon' then
						TriggerEvent("esx_jsidmenu:usecard", fastWeapons[5])
					else
						TriggerServerEvent("esx:useItem", fastWeapons[5])
					end
				end
			end
        end
    end
)

function openInventory()

	TriggerEvent("esx:togglephone")
	
    loadPlayerInventory(true)
	openMenu = true
	
    isInInventory = true
    SendNUIMessage(
        {
            action = "display",
            type = "normal"
        }
    )
    SetNuiFocus(true, true)
	

end

function closeInventory()
	local playerPed = GetPlayerPed(-1)
    isInInventory = false
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)

	TriggerEvent('esx_inventoryhud:checkcloseInventory')
end

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInventory()
    end
)

RegisterNUICallback(
    "GetNearPlayers",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayers = false
        local elements = {}

        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                foundPlayers = true

                table.insert(
                    elements,
                    {
                       -- label = GetPlayerName(players[i]),
					    label = "",
                        player = GetPlayerServerId(players[i])
                    }
                )
            end
        end

        if not foundPlayers then
            exports.pNotify:SendNotification(
                {
                    text = _U("players_nearby"),
                    type = "error",
                    timeout = 3000,
                    layout = "topRight",
                    queue = "inventoryhud"
                }
            )
        else
            SendNUIMessage(
                {
                    action = "nearPlayers",
                    foundAny = foundPlayers,
                    players = elements,
                    item = data.item
                }
            )
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "UseItem",
    function(data, cb)
		
		local ishave = false
		for _, i in pairs(Config.CanUse) do
			if data.item.name == i then
				ishave = true
			end
		end
		
		if string.find(data.item.type, "car_key_") then
			local plate = string.gsub(data.item.type, "car_key_", "")
			TriggerEvent("scotty:keyTrigger", plate)
			return
		end
		

		if string.match(data.item.name, 'card') or data.item.name == 'weapon' then
			TriggerEvent("esx_jsidmenu:usecard", data.item.name)
		elseif ishave then
			TriggerEvent("esx:use"..data.item.name)
		else
			TriggerServerEvent("esx:useItem", data.item.name)
		end
	
        if shouldCloseInventory(data.item.name) then
            closeInventory()
        else
            Citizen.Wait(250)
            loadPlayerInventory(false)
        end

        cb("ok")
    end
)


RegisterNUICallback(
    "SellItem",
    function(data, cb)
		
		local ishaveSell = false
		for _, i in pairs(Config.IsSell) do
		
			if data.item.name == i then
				ishaveSell = true
			end
		end
		

		if ishaveSell then
			TriggerServerEvent('stp_selldrug:use', data.item.name)
		end
	
        if shouldCloseInventory(data.item.name) then
            closeInventory()
        else
            Citizen.Wait(250)
            loadPlayerInventory(false)
        end

        cb("ok")
    end
)


RegisterNUICallback(
    "DropItem",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
		
		if Config.disableDrop and Config.disableDrop[data.item.name] then
			exports.pNotify:SendNotification(
				{
					text = "This item cannot be dropped.",
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "inventoryhud"
				})
			return
		end
		
		
		if data.item.type == "item_weapon" then
			exports.pNotify:SendNotification(
				{
					text = "This weapon cannot be dropped.",
					type = "error",
					timeout = 3000,
					layout = "topRight",
					queue = "inventoryhud"
				}
			)
			return
		end
		
		RequestAnimDict("amb@medic@standing@kneel@base")
		TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
		
		local lPed = GetPlayerPed(-1)

        if type(data.number) == "number" and math.floor(data.number) == data.number then
			if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
				TriggerEvent("esx_inventoryhud:closeInventory")
				
				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'Drop_Menu',
				{
				  title    = 'You want to drop ['..data.item.label..' x'..data.number..'] , right?',
				  align    = 'top-left',
				  elements = {
					{label = ('Yes'), value = 'yes', itemlabel = data.item.label, itemtype = data.item.type, itemname = data.item.name, itemnumber = data.number},
					{label = ('No'), value = 'no'}
				  }
				},
				
				function(datamenu, menu)
				  if datamenu.current.value == 'yes' then
					menu.close()
					ClearPedTasks(PlayerPedId())
					Citizen.CreateThread(function()
						exports.pNotify:SendNotification(
							{
								text = 'You left ['..datamenu.current.itemlabel..' x'..datamenu.current.itemnumber..'] Wait 3 minutes',
								type = "error",
								timeout = 180000,
								layout = "topRight",
								queue = "inventoryhud"
							}
						)
						Wait(180000)
						if string.find(data.item.type, "car_key_") then
							local plate = string.gsub(data.item.type, "car_key_", "")
							TriggerServerEvent("scotty:dropKey", string.upper(plate))
						else
							TriggerServerEvent("esx:removeInventoryItem", datamenu.current.itemtype, datamenu.current.itemname, datamenu.current.itemnumber)
						end
					end)
				  elseif datamenu.current.value == 'no' then
					menu.close()
					ClearPedTasks(PlayerPedId())
				  end

				end,
				function(data, menu)
				  menu.close()
				  ClearPedTasks(PlayerPedId())
				end)
			end
        end

        Wait(250)
        loadPlayerInventory(false)

        cb("ok")
    end
)

RegisterNUICallback(
    "GiveItem",
    function(data, cb)
	
		if Config.disableGive and Config.disableGive[data.item.name] then
			exports.pNotify:SendNotification(
				{
					text = "This item cannot be given.",
					type = "error",
					timeout = 3000,
					layout = "topRight",
					queue = "inventoryhud"
				})
			return
		end
		
		if data.item.type == "item_weapon" then
			exports.pNotify:SendNotification(
				{
					text = "Cannot give this weapon.",
					type = "error",
					timeout = 3000,
					layout = "topRight",
					queue = "inventoryhud"
				}
			)
			return
		end
		
	
        local playerPed = PlayerPedId()
		local DataPlayer = tonumber(data.player)
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayer = false
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                if GetPlayerServerId(players[i]) == DataPlayer then
                    foundPlayer = true
                end
            end
        end

        if foundPlayer then
            local count = tonumber(data.number)
			local lPed = GetPlayerPed(-1)
            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end
			
			if string.find(data.item.type, "car_key_") then
				local plate = string.gsub(data.item.type, "car_key_", "")
				TriggerServerEvent("scotty:giveCarKey", DataPlayer, plate)
				
				Wait(500)
				loadPlayerInventory()
				return
			end
			
			ESX.Streaming.RequestAnimDict("gestures@m@car@low@casual@ps", function()
				TaskPlayAnim(PlayerPedId(), "gestures@m@car@low@casual@ps", "gesture_you_soft", 8.0, -8.0, -1, 48, 0, false, false, false)
			end)
			
	
			
			local playertarget = GetPlayerPed(GetPlayerFromServerId(DataPlayer))
			
			if not IsPedInAnyVehicle(lPed, false) and not IsPedInAnyVehicle(playertarget, false) and IsPedOnFoot(lPed) and IsPedOnFoot(playertarget)  and not IsPedUsingAnyScenario(lPed) then
				TriggerServerEvent("esx:giveInventoryItem", DataPlayer, data.item.type, data.item.name, count)
				Wait(250)
				loadPlayerInventory(false)
			end
        else
            exports.pNotify:SendNotification(
                {
                    text = _U("player_nearby"),
                    type = "error",
                    timeout = 3000,
                    layout = "topRight",
                    queue = "inventoryhud"
                }
            )
        end
        cb("ok")
    end
)


RegisterNetEvent("esx:inventoryclose")
AddEventHandler("esx:inventoryclose", function()
		closeInventory()
end)

function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

local carkeys
AddEventHandler('scotty:globalFetchCarKeys', function(keys)
	carkeys = keys
end)

RegisterNetEvent("esx_inventoryhud:setOwnerVehicle")
AddEventHandler("esx_inventoryhud:setOwnerVehicle", function(result)
    Vehicle_Key = result
end)


RegisterNetEvent("esx_inventoryhud:getOwnerVehicle")
AddEventHandler("esx_inventoryhud:getOwnerVehicle",function()
    TriggerServerEvent("esx_inventoryhud:getOwnerVehicle")
end)

function loadPlayerInventory(wait)
	local currentWeight = 0
	ESX.PlayerData = ESX.GetPlayerData()
    ESX.TriggerServerCallback("esx_inventoryhud:getPlayerInventory",function(data)
			items = {}
			fastItems = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons
			
			if Config.IncludeIDCard then
                IDCard = {
                    label = "IDCard",
                    name = "idcard",
                    type = "item_standard",
                    count = 1,
                    usable = true,
                    rare = false,
                    limit = -1,
					sell = false,
                    canRemove = false
                }

                table.insert(items, IDCard)
            end
			
			if Config.IncludeDriverCard then
                DriverCard = {
                    label = "DriverCard",
                    name = "drivercard",
                    type = "item_standard",
                    count = 1,
                    usable = true,
                    rare = false,
                    limit = -1,
					sell = false,
                    canRemove = false
                }

                table.insert(items, DriverCard)
            end
			
			if Config.IncludeWeaponCard then
                WeaponCard = {
                    label = "WeaponCard",
                    name = "weapon",
                    type = "item_standard",
                    count = 1,
                    usable = true,
                    rare = false,
                    limit = -1,
					sell = false,
                    canRemove = false
                }

                table.insert(items, WeaponCard)
            end
			
			
			if Config.IncludeMask then
                Mask = {
                    label = "Mask",
                    name = "Mask",
                    type = "item_standard",
                    count = 1,
                    usable = true,
                    rare = false,
                    limit = -1,
					sell = false,
                    canRemove = false
                }

                table.insert(items, Mask)
            end

            if Config.IncludeCash and money ~= nil and money > 0 then
                moneyData = {
                    label = _U("cash"),
                    name = "cash",
                    type = "item_money",
                    count = money,
                    usable = false,
                    rare = false,
                    limit = -1,
					sell = false,
                    canRemove = true
                }

                table.insert(items, moneyData)
            end

            if Config.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not shouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = accounts[key].label,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                limit = -1,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end
			

			
            if inventory ~= nil then
				
                for key, value in pairs(inventory) do
					local isuse = false
					
					for _, i in pairs(Config.CanUse) do
						if inventory[key].name == i then
							isuse = true
						end
					end
					
					local issell = false
					for _, i in pairs(Config.IsSell) do
						if inventory[key].name == i then
							issell = true
						end
					end
					
					if inventory[key].count <= 0 then
						inventory[key] = nil
					elseif isuse then
						inventory[key].type = "item_standard"
						inventory[key].usable = true
						table.insert(items, inventory[key])
					elseif issell then
						inventory[key].type = "item_standard"
						inventory[key].sell = true
						table.insert(items, inventory[key])
					else
						inventory[key].type = "item_standard"
						local founditem = false
						for slot, item in pairs(fastWeapons) do
							if item == inventory[key].name then
								table.insert(
									fastItems,
									{
										label = inventory[key].label,
										count = inventory[key].count,
										type = "item_standard",
										name = inventory[key].name,
										usable = inventory[key].usable,
										rare = inventory[key].rare,
										canRemove = true,
										slot = slot
									}
                                )
                                founditem = true
                                break
							end
						end
						if founditem == false then
							table.insert(items, inventory[key])
						end
					end
					
                end

            end
			
			for i=1, #ESX.PlayerData.inventory, 1 do
				if ESX.PlayerData.inventory[i].count > 0 then
					currentWeight = currentWeight + (ESX.PlayerData.inventory[i].weight * ESX.PlayerData.inventory[i].count)
					for k,v in ipairs(ESX.PlayerData.inventory) do
						
					end
				end
			end
			
			if carkeys then
				for plate, _ in pairs(carkeys) do
					local info = {
						label = plate and (plate .. " Key") or "UNKNOWN KEY",
						name = "car_keys",
						type = "car_key_"..plate,
						count = 1,
						usable = true,
						rare = true,
						limit = -1,
						sell = false,
						canRemove = false
					}

					table.insert(items, info)
				end
			end
			if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if HasPedGotWeapon(playerPed, weaponHash, false) and weapons[key].name ~= "WEAPON_UNARMED" then
						local found = false
						for slot, weapon in pairs(fastWeapons) do
							if weapon == weapons[key].name then
								local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
								table.insert(
									fastItems,
									{
										label = weapons[key].label,
										count = ammo,
										limit = -1,
										type = "item_weapon",
										name = weapons[key].name,
										usable = false,
										rare = false,
										canRemove = true,
										slot = slot
									}
								)
								found = true
								break
							end
						end
						if found == false then
							local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
							local isuse = false
							for _, i in pairs(Config.CanUse) do
								if weapons[key].name == i then
									isuse = true
								end
							end
							if isuse then
								table.insert(
									items,
									{
										label = weapons[key].label,
										count = ammo,
										limit = -1,
										type = "item_weapon",
										name = weapons[key].name,
										usable = true,
										rare = false,
										sell = false,
										canRemove = false
									}
								)
							else
								table.insert(
									items,
									{
										label = weapons[key].label,
										count = ammo,
										limit = -1,
										type = "item_weapon",
										name = weapons[key].name,
										usable = false,
										rare = false,
										sell = false,
										canRemove = false
									}
								)
							end
						end
                    end
                end
            end

            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items,
					weight = currentWeight,
					fastItems = fastItems,
					myid = GetPlayerServerId(PlayerId()),
					max = ESX.PlayerData.maxWeight
                }
            )
        end,
        GetPlayerServerId(PlayerId())
    )
end

RegisterNUICallback("PutIntoFast", function(data, cb)
	if data.item.slot ~= nil then
		fastWeapons[data.item.slot] = nil
	end
	fastWeapons[data.slot] = data.item.name
	loadPlayerInventory()
	cb("ok")
end)


RegisterNUICallback("TakeFromFast", function(data, cb)
	fastWeapons[data.item.slot] = nil
	if string.find(data.item.name, "WEAPON_", 1) ~= nil and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(data.item.name) then
		--TriggerEvent('esx_inventoryhud:closeinventory')
		--RemoveWeapon(data.item.name)
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"),true)
	end
	loadPlayerInventory()
	cb("ok")
end)


Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            if isInInventory then
                local playerPed = PlayerPedId()
                DisableControlAction(0, 1, true) -- Disable pan
                DisableControlAction(0, 2, true) -- Disable tilt
                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                DisableControlAction(0, 25, true) -- Aim
                DisableControlAction(0, 263, true) -- Melee Attack 1
                DisableControlAction(0, Keys["W"], true) -- W
                DisableControlAction(0, Keys["A"], true) -- A
                DisableControlAction(0, 31, true) -- S (fault in Keys table!)
                DisableControlAction(0, 30, true) -- D (fault in Keys table!)

                DisableControlAction(0, Keys["R"], true) -- Reload
                DisableControlAction(0, Keys["SPACE"], true) -- Jump
                DisableControlAction(0, Keys["Q"], true) -- Cover
                DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
                DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

                DisableControlAction(0, Keys["F1"], true) -- Disable phone
                DisableControlAction(0, Keys["F2"], true) -- Inventory
                DisableControlAction(0, Keys["F3"], true) -- Animations
                DisableControlAction(0, Keys["F6"], true) -- Job

                DisableControlAction(0, Keys["V"], true) -- Disable changing view
                DisableControlAction(0, Keys["C"], true) -- Disable looking behind
                DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
                DisableControlAction(2, Keys["P"], true) -- Disable pause screen

                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                DisableControlAction(0, 72, true) -- Disable reversing in vehicle

                DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

                DisableControlAction(0, 47, true) -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 75, true) -- Disable exit vehicle
                DisableControlAction(0, 37, true) -- TaB
                DisableControlAction(0, 157, true) -- TaB
                DisableControlAction(0, 158, true) -- TaB
                DisableControlAction(27, 75, true) -- Disable exit vehicle
            end
        end
    end)
	


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        BlockWeaponWheelThisFrame()
        -- HideHudComponentThisFrame(19)
        -- HideHudComponentThisFrame(20)
        -- HideHudComponentThisFrame(17)
        DisableControlAction(0, 157, true) --Disable Tab
        DisableControlAction(0, 158, true) --Disable Tab
        DisableControlAction(0, 37, true) --Disable Tab
       
    end
end)


RegisterNetEvent("esx_inventoryhud:showimage")
AddEventHandler("esx_inventoryhud:showimage", function(myid, playerid, coords, name)
	if ESX ~= nil then
		--local playeridcoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerid)), true)
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords["x"], coords["y"], coords["z"], true) >= 100.0 then
			return
		end

		Citizen.CreateThread(function()
			local lasttimer = GetGameTimer()
			while true do
				Wait(0)
				
					local mtarget = GetPlayerPed(GetPlayerFromServerId(myid))
					local ptarget = GetPlayerPed(GetPlayerFromServerId(playerid))
					local pcoords = GetEntityCoords(ptarget, true)
					local BoneIndex = GetPedBoneIndex(mtarget, 57005)
					local BonePosition = GetWorldPositionOfEntityBone(mtarget, BoneIndex)
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pcoords["x"], pcoords["y"], pcoords["z"], true) <= 40.0 then
						if (GetGameTimer() - lasttimer < 2000) then
							if HasEntityClearLosToEntity(PlayerPedId(), mtarget, 17) then
								ESX.Game.Utils.DrawImage3D("items", name, BonePosition.x, BonePosition.y, BonePosition.z, 0.10, 0.20, 0.0, 255, 255, 255, 255)
							end
						else
							if HasEntityClearLosToEntity(PlayerPedId(), ptarget, 17) then
								ESX.Game.Utils.DrawImage3D("items", name, pcoords.x, pcoords.y, pcoords.z, 0.10, 0.20, 0.0, 255, 255, 255, 255)
							end
						end
					end
					
					if (GetGameTimer() - lasttimer > 3000) then
						break
					end
				
			end
		end)
	end
end)